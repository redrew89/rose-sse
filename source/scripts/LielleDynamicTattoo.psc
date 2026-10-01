Scriptname LielleDynamicTattoo Extends ReferenceAlias

LielleCoreScript Property Core Auto
LielleMCMCore Property MCM Auto
Bool Property DebugMode = true Auto

; Custom properties to allow fine-tuning
Float Property EmissiveMultiple 	= 1.0 Auto  ; Controls glow intensity (higher values = brighter glow)
Float Property AlphaProperty 		= 0.8 Auto     ; Controls tattoo opacity
String Property TattooTexture 		= "textures\\lielle\\tattoo\\tattooglow.dds" Auto
String Property PrideTexture 		= "textures\\lielle\\tattoo\\prideglow.dds" Auto
Int Property EmissiveColor 			= 0xFF0000 Auto  ; Red color (0xFF0000) for emission
Int Property TintColor 				= 0xFF0000 Auto      ; Red tint

int property tattooMCMSetting = 0 auto



; Internal variables
ObjectReference TattooActor
bool niOverrideInstalled = false
Bool useNiOverride = False
String overlayNode = ""
Bool isFemale
String msgFlag = "LielleCore - Dynamic Appearance: "

; RaceMenu draws an overlay whose texture hasn't finished loading as black, which post-processing
; makes very visible. So the tattoo is never re-applied when nothing changed, and a new texture is
; set while the overlay is invisible, given time to load, then faded in.
Int fadeSteps = 8
Float fadeDuration = 0.4
Float loadWait = 0.15

Event OnInit()
    TattooActor = GetActorReference()
    isFemale = true

    ; Check for NiOverride and RaceMenu support
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6))
		niOverrideInstalled = true
		MCM.bNiOverridePresent = true
		If tattooMCMSetting == 0
			Core.Msg(msgFlag + "Tattoo glow disabled by MCM.",false)
			return ; claims no overlay slot until the glow is enabled
		EndIf
        useNiOverride = InitializeOverlay(TattooActor)
        If useNiOverride
            ApplyTattoo()
        ElseIf DebugMode
            Core.Msg(msgFlag + "Failed to initialize NiOverride overlay slot.", false)
        EndIf
    Else
        If DebugMode
             Core.Msg(msgFlag + "NiOverride not detected. Ending effect.", false)
        EndIf
        return
    EndIf
EndEvent

Function Reinitialize()
	TattooActor = GetActorReference()
    isFemale = true

	if niOverrideInstalled
		useNiOverride = InitializeOverlay(TattooActor)
	Else
		return
	EndIf
	if useNiOverride
		ApplyTattoo()
	Else
		return
	endif

endFunction

; Prefers the slot already holding the tattoo (either texture), so it never moves to a lower slot
; and leaves the old one showing; only then takes an empty slot
Bool Function InitializeOverlay(ObjectReference target)
    If !niOverride.HasOverlays(target)
        niOverride.AddOverlays(target)
        Utility.Wait(0.1)
    EndIf

    Int overlayCount = niOverride.GetNumBodyOverlays()
    Int pass = 0
    While pass < 2
        Int i = 0
        While i < overlayCount
            String testNode = "Body [Ovl" + i as String + "]"
            String currentTex = niOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
            Bool match = IsTattooTexture(currentTex)
            If pass == 1
                match = currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1
            EndIf
            If match
                overlayNode = testNode
                If DebugMode
                    Core.Msg(msgFlag + "Found valid overlay node: " + overlayNode, false)
                EndIf
                Return true
            EndIf
            i += 1
        EndWhile
        pass += 1
    EndWhile

    If DebugMode
        Core.Msg(msgFlag + "Unable to find valid overlay node.",false)
    EndIf
    Return false
EndFunction

Bool Function IsTattooTexture(String tex)
    Return StringUtil.Find(tex, "tattooglow.dds", 0) != -1 || StringUtil.Find(tex, "prideglow.dds", 0) != -1
EndFunction

Function ApplyTattoo()
    If overlayNode != ""

		string overlayTexture = TattooTexture
		if tattooMCMSetting == 4
			overlayTexture = PrideTexture
		endif
		if tattooMCMSetting == 0
			return ; short circuit, for no-glow option
		endif

		; Game load and MCM page opens re-request the same tattoo - RaceMenu has already restored it,
		; so touching the overlay again would only flash it
		if IsApplied(overlayTexture)
			return
		endif

		String shownTex = niOverride.GetNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0)
		Float shownAlpha = niOverride.GetNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1)

		if shownTex == overlayTexture && shownAlpha > 0.0
			; Same texture already loaded and visible - colour, glow and opacity change in place
			SetShaderValues()
			niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1, AlphaProperty, true)
			niOverride.ApplyNodeOverrides(TattooActor)
		else
			; New texture: fade any visible tattoo out, set everything while invisible, let it load, fade in
			if IsTattooTexture(shownTex) && shownAlpha > 0.0
				FadeAlpha(shownAlpha, 0.0)
			endif
			niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1, 0.0, true) ; ShaderAlpha - invisible
			SetShaderValues()
			niOverride.AddNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0, overlayTexture, true)
			niOverride.ApplyNodeOverrides(TattooActor)
			Utility.Wait(loadWait)
			FadeAlpha(0.0, AlphaProperty)
		endif

        If DebugMode
            Core.Msg(msgFlag + "Applied glowing overlay to " + overlayNode, false)
        EndIf
    EndIf
EndFunction

Function SetShaderValues()
	niOverride.AddNodeOverrideInt(TattooActor, isFemale, overlayNode, 0, -1, EmissiveColor, true) ; ShaderEmissiveColor
	niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 1, -1, EmissiveMultiple, true) ; ShaderEmissiveMultiple - glow
	niOverride.AddNodeOverrideInt(TattooActor, isFemale, overlayNode, 7, -1, TintColor, true) ; ShaderTintColor
EndFunction

; True when the slot already shows this texture with the requested colour, glow and opacity
Bool Function IsApplied(String tex)
	If niOverride.GetNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0) != tex
		Return false
	EndIf
	If niOverride.GetNodeOverrideInt(TattooActor, isFemale, overlayNode, 7, -1) != TintColor
		Return false
	EndIf
	If niOverride.GetNodeOverrideInt(TattooActor, isFemale, overlayNode, 0, -1) != EmissiveColor
		Return false
	EndIf
	If Math.Abs(niOverride.GetNodeOverrideFloat(TattooActor, isFemale, overlayNode, 1, -1) - EmissiveMultiple) > 0.01
		Return false
	EndIf
	Return Math.Abs(niOverride.GetNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1) - AlphaProperty) <= 0.01
EndFunction

Function FadeAlpha(Float fromAlpha, Float toAlpha)
	Int s = 1
	While s <= fadeSteps
		niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1, fromAlpha + (toAlpha - fromAlpha) * (s as Float / fadeSteps as Float), true)
		niOverride.ApplyNodeOverrides(TattooActor)
		Utility.Wait(fadeDuration / fadeSteps as Float)
		s += 1
	EndWhile
EndFunction

; Function to refresh or update the tattoo (can be called from other scripts)
Function RefreshTattoo()
    if tattooMCMSetting == 0
		RemoveTattoo()
		return
	endif
	if !TattooActor
		TattooActor = GetActorReference()
		isFemale = true
	endif
	; The slot is released while the glow is off - find one again, preferring a slot already holding the tattoo
	if overlayNode == "" && niOverrideInstalled
		useNiOverride = InitializeOverlay(TattooActor)
	endif
	If TattooActor && overlayNode != ""
        ApplyTattoo()
    EndIf

EndFunction

; Fades the tattoo out, then releases the slot
Function RemoveTattoo()
    If TattooActor && overlayNode != ""
		Float shownAlpha = nioverride.GetNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1)
		if shownAlpha > 0.0 && IsTattooTexture(nioverride.GetNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0))
			FadeAlpha(shownAlpha, 0.0)
		endif
		nioverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, 0, 0.000000, false)
		nioverride.AddNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
		nioverride.RemoveAllNodeNameOverrides(TattooActor, isFemale, overlayNode)
		overlayNode = ""
	endif
EndFunction
