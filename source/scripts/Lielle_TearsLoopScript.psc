Scriptname Lielle_TearsLoopScript extends activemagiceffect  

; Properties
FormList Property LielleTearsFrameList Auto  ; For shader fallback
Actor Property PlayerRef Auto  ; For distance checks

; Internal variables
EffectShader Frame
Actor CryingActor
Bool shuttingDown = False
Bool useNiOverride = False
String overlayNode = ""
Bool isFemale
Int currentFrame = 0
Float frameDelay = 0.025

Event OnEffectStart(Actor akTarget, Actor akCaster)
    shuttingDown = False
    CryingActor = akTarget
    isFemale = (akTarget.GetActorBase().GetSex() == 1)
    
    ; Check for NiOverride
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6))
        useNiOverride = InitializeTearOverlays(akTarget)
        Debug.Trace("LielleEmotions: Using RaceMenu overlays for tears.")
        if useNiOverride
            StartTearSequence()
        else
            Debug.Trace("LielleEmotions: NiOverride initialization failed, falling back to EffectShader")
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
    
    ; Find available overlay slot
    Int overlayCount = NiOverride.GetNumFaceOverlays()
    Int i = 0
    
    while i < overlayCount
        String testNode = "Face [Ovl" + i as String + "]"
        String currentTex = NiOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        if currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1
            overlayNode = testNode
            Return true
        endif
        i += 1
    endwhile
    
    Return false  ; No available slots found
EndFunction

Function StartTearSequence()
    while !shuttingDown
        Int i = 0
        while i < 33 && !shuttingDown  ; 33 frames in sequence
            String texturePath = "textures\\effects\\emotionaltears\\tearsframe" + StringUtil.Substring("00" + i, StringUtil.GetLength("00" + i) - 2, 2) + ".dds"
            ApplyTearFrame(texturePath)
            Utility.Wait(frameDelay)
            i += 1
        endwhile
        
        if !shuttingDown
            ; Hold last frame briefly
            ApplyTearFrame("textures\\effects\\emotionaltears\\tearsframe32.dds", 3.0)
        endif
    endwhile
EndFunction

Function ApplyTearFrame(String texturePath, Float holdTime = 0.025)
    if !CryingActor || shuttingDown
        Return
    endif
    
    ; Apply texture and alpha
    NiOverride.AddNodeOverrideFloat(CryingActor, isFemale, overlayNode, 8, -1, 1.0, true)
    NiOverride.AddNodeOverrideString(CryingActor, isFemale, overlayNode, 9, 0, texturePath, true)
    NiOverride.ApplyNodeOverrides(CryingActor)
    
    if holdTime > 0.025
        Utility.Wait(holdTime)
    endif
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
    if useNiOverride && CryingActor && overlayNode != ""
        ; Clear overlay
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
    ClearOverlays()
EndEvent