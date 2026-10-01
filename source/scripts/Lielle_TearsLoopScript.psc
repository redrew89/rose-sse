Scriptname Lielle_TearsLoopScript extends activemagiceffect

; Properties
FormList Property LielleTearsFrameList Auto  ; For shader fallback
Actor Property PlayerRef Auto  ; For distance checks

; RaceMenu draws an overlay whose texture hasn't finished loading as black, so a frame is never applied
; to a visible overlay. Two face overlay slots alternate: the next frame loads into the hidden slot while
; the current one shows, then the slots swap. The first frame fades in and the last one fades out.

; Internal variables
EffectShader Frame
Actor CryingActor
Bool shuttingDown = False
Bool useNiOverride = False
String overlayNode = ""		; the slot currently showing
String hiddenNode = ""		; the slot the next frame loads into
Bool isFemale
Int frameCount = 33
Float frameDelay = 0.025	; time per frame - also how long the next frame has to load before it is revealed
Float holdTime = 3.0		; the last frame holds this long before the sequence repeats
Int fadeSteps = 8
Float fadeDuration = 0.4	; fade-out when the tears end
Float fadeInDuration = 0.2	; kept short so the tears land within a line of dialogue (conversation cameras cut fast)
Float visibleAlpha = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
    shuttingDown = False
    CryingActor = akTarget
    isFemale = (akTarget.GetActorBase().GetSex() == 1)

    ; Check for NiOverride
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6))
        useNiOverride = InitializeTearOverlays(akTarget)
        if useNiOverride
            Debug.Trace("LielleEmotions: Using RaceMenu overlays for tears (" + overlayNode + " / " + hiddenNode + ").")
            ; No preload pass - it delayed the tears by over a second, and each frame already gets its own
            ; load time in the hidden slot before it is revealed. PreloadFrames() is kept for reference.
            FadeSlot(overlayNode, 0.0, 1.0, true, fadeInDuration)
            StartTearSequence()
        else
            Debug.Trace("LielleEmotions: Fewer than two free face overlay slots, falling back to EffectShader")
            TearsLoop(akTarget)
        endif
    Else
        Debug.Trace("LielleEmotions: NiOverride not found, using EffectShader method")
        TearsLoop(akTarget)
    EndIf
EndEvent

Bool Function InitializeTearOverlays(Actor target)
    if !NiOverride.HasOverlays(target)
        NiOverride.AddOverlays(target)
        Utility.Wait(0.1)  ; Give system time to initialize
    endif

    ; Preparing the first slot gives it a texture, which claims it before the search for the second
    overlayNode = FindFreeSlot(target)
    if overlayNode == ""
        Return false
    endif
    PrepareSlot(overlayNode, FramePath(0))

    hiddenNode = FindFreeSlot(target)
    if hiddenNode == ""
        ClearOverlays()
        overlayNode = ""
        Return false
    endif
    PrepareSlot(hiddenNode, FramePath(1))
    NiOverride.ApplyNodeOverrides(target)
    Return true
EndFunction

String Function FindFreeSlot(Actor target)
    Int overlayCount = NiOverride.GetNumFaceOverlays()
    Int i = 0
    while i < overlayCount
        String testNode = "Face [Ovl" + i as String + "]"
        String currentTex = NiOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        if currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1
            Return testNode
        endif
        i += 1
    endwhile
    Return ""
EndFunction

; Sets a slot up invisible first, then white tint and no glow (slots keep whatever their last user left),
; then the texture - so the texture loads while nothing is showing
Function PrepareSlot(String node, String texturePath)
    NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, node, 8, -1, 0.0, true) ; ShaderAlpha - invisible
    NiOverride.AddNodeOverrideInt(CryingActor, isFemale, node, 7, -1, 0xFFFFFF, true) ; ShaderTintColor - white
    NiOverride.AddNodeOverrideInt(CryingActor, isFemale, node, 0, -1, 0, true) ; ShaderEmissiveColor - none
    NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, node, 1, -1, 0.0, true) ; ShaderEmissiveMultiple - no glow
    NiOverride.AddNodeOverrideString(CryingActor, isFemale, node, 9, 0, texturePath, true)
EndFunction

String Function FramePath(Int i)
    String num = "0" + i as String
    Return "textures\\effects\\emotionaltears\\tearsframe" + StringUtil.Substring(num, StringUtil.GetLength(num) - 2, 2) + ".dds"
EndFunction

; Runs every frame through the hidden slot once, so the sequence is loaded before any of it shows
Function PreloadFrames()
    Int i = 2
    while i < frameCount && !shuttingDown
        NiOverride.AddNodeOverrideString(CryingActor, isFemale, hiddenNode, 9, 0, FramePath(i), true)
        NiOverride.ApplyNodeOverrides(CryingActor)
        Utility.Wait(0.02)
        i += 1
    endwhile
    NiOverride.AddNodeOverrideString(CryingActor, isFemale, hiddenNode, 9, 0, FramePath(1), true)
    NiOverride.ApplyNodeOverrides(CryingActor)
EndFunction

Function FadeSlot(String node, Float fromAlpha, Float toAlpha, Bool abStopOnShutdown, Float afDuration = -1.0)
    if afDuration < 0.0
        afDuration = fadeDuration
    endif
    Int s = 1
    while s <= fadeSteps && !(abStopOnShutdown && shuttingDown)
        visibleAlpha = fromAlpha + (toAlpha - fromAlpha) * (s as Float / fadeSteps as Float)
        NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, node, 8, -1, visibleAlpha, true)
        NiOverride.ApplyNodeOverrides(CryingActor)
        Utility.Wait(afDuration / fadeSteps as Float)
        s += 1
    endwhile
EndFunction

Function StartTearSequence()
    Int i = 1
    while !shuttingDown
        ShowFrame(i)
        if i == frameCount - 1
            Utility.Wait(holdTime)  ; Hold last frame briefly
            i = 0
        else
            i += 1
        endif
    endwhile
EndFunction

; Loads frame i into the hidden slot, gives it frameDelay to load, then swaps which slot is visible
Function ShowFrame(Int i)
    NiOverride.AddNodeOverrideString(CryingActor, isFemale, hiddenNode, 9, 0, FramePath(i), true)
    NiOverride.ApplyNodeOverrides(CryingActor)
    Utility.Wait(frameDelay)
    if shuttingDown
        Return
    endif
    NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, hiddenNode, 8, -1, visibleAlpha, true)
    NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, overlayNode, 8, -1, 0.0, true)
    NiOverride.ApplyNodeOverrides(CryingActor)
    String swap = overlayNode
    overlayNode = hiddenNode
    hiddenNode = swap
EndFunction

Function TearsLoop(Actor CryBaby)
    Int iMin = 0
    Int iMax = LielleTearsFrameList.GetSize()
    While iMin < iMax
        Frame = LielleTearsFrameList.GetAt(iMin) as EffectShader
        If iMin < iMax
            If iMin == 0
                Utility.Wait(3.0)
            EndIf
            Frame.Play(CryBaby, 0.1)
        EndIf
        iMin += 1
        If iMin == iMax
            Frame.Play(CryBaby, 3.0)
        EndIf
    EndWhile
    If !shuttingDown
        TearsLoop(CryBaby)
    EndIf
EndFunction

Function ClearOverlays()
    if useNiOverride && CryingActor
        ; Clear every slot holding a tear frame - both halves of the swap pair
		Int i = 0
		Int fn = nioverride.GetNumFaceOverlays()
		while i < fn
			String nn = "Face [Ovl" + i as String + "]"
			String tx = ""
			if netimmerse.HasNode(CryingActor, nn, false)
				tx = nioverride.GetNodepropertyString(CryingActor, false, nn, 9, 0)
			else
				tx = nioverride.GetNodeOverrideString(CryingActor, isFemale, nn, 9, 0)
			endIf
			if stringutil.Find(tx, "tearsframe", 0) != -1
				nioverride.AddNodeOverrideFloat(CryingActor, isFemale, nn, 8, 0, 0.000000, false)
				nioverride.AddNodeOverrideString(CryingActor, isFemale, nn, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
				nioverride.RemoveAllNodeNameOverrides(CryingActor, isFemale, nn)
			endIf
			i += 1
		endWhile
	endif
EndFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    shuttingDown = True
    if useNiOverride && CryingActor && overlayNode != ""
        Utility.Wait(frameDelay)  ; let an in-flight frame swap land before fading
        FadeSlot(overlayNode, visibleAlpha, 0.0, false)
    endif
    ClearOverlays()
EndEvent
