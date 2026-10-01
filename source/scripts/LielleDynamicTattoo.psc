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

Event OnInit()
    TattooActor = GetActorReference()
    isFemale = true

    ; Check for NiOverride and RaceMenu support
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6)) 
		niOverrideInstalled = true
        useNiOverride = InitializeOverlay(TattooActor)
		MCM.bNiOverridePresent = true
        If useNiOverride
            ApplyTattoo()
        Else
            If (!useNiOverride && tattooMCMSetting != 0) && DebugMode 
                Core.Msg(msgFlag + "Failed to initialize NiOverride overlay slot.", false)
			elseif tattooMCMSetting == 0
				Core.Msg(msgFlag + "Tattoo glow disabled by MCM.",false)
            EndIf
            return
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

Bool Function InitializeOverlay(ObjectReference target)
    If !niOverride.HasOverlays(target)
        niOverride.AddOverlays(target)
        Utility.Wait(0.1)
    EndIf

    Int overlayCount = niOverride.GetNumBodyOverlays()
    Int i = 0
    While i < overlayCount
        String testNode = "Body [Ovl" + i as String + "]"
        String currentTex = niOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        If (currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1) || StringUtil.Find(currentTex, "tattooglow.dds", 0) != -1 
            overlayNode = testNode
            If DebugMode
                Core.Msg(msgFlag + "Found valid overlay node: " + overlayNode, false)
            EndIf
            Return true
        EndIf
        i += 1
    EndWhile
    
    If DebugMode
        Core.Msg(msgFlag + "Unable to find valid overlay node.",false)
    EndIf
    Return false
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
		
		; Reset any previous overrides for this node
        niOverride.RemoveAllNodenameOverrides(TattooActor, isFemale, overlayNode)
        ;Utility.Wait(0.1)
        
        ; Apply texture - this is the tattoo texture (parameter 9)
        niOverride.AddNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0, overlayTexture, true)
        
        ; Set ShaderEmissiveColor (parameter 0) - use red (0xFF0000) for red emission
        niOverride.AddNodeOverrideInt(TattooActor, isFemale, overlayNode, 0, -1, EmissiveColor, true)
        
        ; Set ShaderEmissiveMultiple (parameter 1) - controls glow intensity
        niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 1, -1, EmissiveMultiple, true)
        
        ; Set ShaderAlpha (parameter 8) - controls opacity
        niOverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, -1, AlphaProperty, true)
        
        ; Set ShaderTintColor (parameter 7) to red for red tint
        niOverride.AddNodeOverrideInt(TattooActor, isFemale, overlayNode, 7, -1, TintColor, true)
        
        ; Apply all changes
        niOverride.ApplyNodeOverrides(TattooActor)
        
        If DebugMode
            Core.Msg(msgFlag + "Applied glowing overlay to " + overlayNode, false)
        EndIf
    EndIf
EndFunction

; Function to refresh or update the tattoo (can be called from other scripts)
Function RefreshTattoo()
    if tattooMCMSetting == 0 
		RemoveTattoo()
		return
	endif
	If TattooActor && overlayNode != ""
        ApplyTattoo()
    EndIf
	
EndFunction

Function RemoveTattoo()
    If TattooActor && overlayNode != ""
        ; Clear overlay
		nioverride.AddNodeOverrideFloat(TattooActor, isFemale, overlayNode, 8, 0, 0.000000, false)
		nioverride.AddNodeOverrideString(TattooActor, isFemale, overlayNode, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
		nioverride.RemoveAllNodeNameOverrides(TattooActor, isFemale, overlayNode)
	endif		    
EndFunction