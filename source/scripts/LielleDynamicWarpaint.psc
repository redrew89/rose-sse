Scriptname LielleDynamicWarpaint extends ReferenceAlias


LielleCoreScript Property Core Auto
LielleMCMCore Property MCM Auto
bool Property DebugMode = true Auto


int Property TintColor			= 0xFF0000 	Auto
int Property EmissiveColor 		= 0xFFFFFF 	Auto
float Property EmissiveMultiple	= 0.0		Auto
float overlayAlpha 				= 0.7
string defaultPaint 			= "textures\\lielle\\warpaint\\defaultpaint.dds"
string smudgePaint				= "textures\\lielle\\warpaint\\smudgepaint.dds"
string pridePaint 				= "textures\\lielle\\warpaint\\pridepaint.dds"

int Property warpaintMCMSetting = 1 		Auto


ObjectReference overlayActor
bool niOverrideInstalled = false
Bool useNiOverride = False
String overlayNode = ""
Bool isFemale
String msgFlag = "LielleCore - Dynamic Appearance: " 

LielleDynamicAppearanceManager DynApp

event OnInit()

	DynApp = GetOwningQuest() as LielleDynamicAppearanceManager
	StartWarpaint()

EndEvent

Function StartWarpaint()
    overlayActor = GetActorReference()
    isFemale = true

    ; Check for NiOverride and RaceMenu support
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6)) 
		niOverrideInstalled = true
		MCM.bNiOverridePresent = true
        useNiOverride = InitializeOverlay(overlayActor)
		
        If useNiOverride
           SetWarpaint(warpaintMCMSetting)
        Else
            If DebugMode
                Core.Msg(msgFlag + "Failed to initialize NiOverride overlay slot.", false)
            EndIf
            return
        EndIf
    Else
        If DebugMode
             Core.Msg(msgFlag + "NiOverride not detected. Ending effect.", false)
        EndIf
        return
    EndIf
EndFunction

Bool Function InitializeOverlay(ObjectReference target)
    If !niOverride.HasOverlays(target)
        niOverride.AddOverlays(target)
        Utility.Wait(0.1)
    EndIf

    Int overlayCount = niOverride.GetNumFaceOverlays()
    Int i = 0
    While i < overlayCount
        String testNode = "Face [Ovl" + i as String + "]"
        String currentTex = niOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        If (StringUtil.Find(currentTex, "defaultpaint.dds", 0) != -1 || StringUtil.Find(currentTex, "pridepaint.dds", 0) != -1 || StringUtil.Find(currentTex, "smudgepaint.dds", 0) != -1 ) || (currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1)
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

Function SetWarpaint(int warpaintOption)
    If overlayNode != ""
        ; Reset any previous overrides for this node
        niOverride.RemoveAllNodenameOverrides(overlayActor, isFemale, overlayNode)
        Utility.Wait(0.1)
			
		string currentTexture 	= defaultPaint
		overlayAlpha 			= 0.7
		
		if warpaintOption == 0
			ClearWarpaint()
			return		
		endif
		
		if warpaintOption == 4
			currentTexture 		= pridePaint
			overlayAlpha 		= 0.6
        EndIf
		
		if DynApp.bWarpaintSmudge && warpaintOption != 4
			currentTexture 		= smudgePaint
		endif
		
        ; Apply texture - this is the tattoo texture (parameter 9)
        niOverride.AddNodeOverrideString(overlayActor, isFemale, overlayNode, 9, 0, currentTexture, true)
        
        ; Set ShaderAlpha (parameter 8) - controls opacity
        niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 8, -1, overlayAlpha, true)
				
		; Set ShaderGlossiness (parameter 2) - controls glossiness
		niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 2, -1, 0.0, true)
		
		; Set ShaderSpecularStrength (parameter 3) - controls specular
		niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 3, -1, 0.0, true)		
		
		; Set ShaderEmissiveColor (parameter 0) - use 0 for none
        niOverride.AddNodeOverrideInt(overlayActor, isFemale, overlayNode, 0, -1, EmissiveColor, true)
		
		; Set ShaderEmissiveMultiple (parameter 1) - controls glow intensity		
		niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 1, -1, EmissiveMultiple, true)
        
        ; Set ShaderTintColor (parameter 7) 
        niOverride.AddNodeOverrideInt(overlayActor, isFemale, overlayNode, 7, -1, TintColor, true)
        
        ; Apply all changes
        niOverride.ApplyNodeOverrides(overlayActor)
        
        If DebugMode
            Core.Msg(msgFlag + "Applied warpaint overlay to " + overlayNode, false)
        EndIf
    EndIf
EndFunction


Function ClearWarpaint()
    if useNiOverride && overlayActor && overlayNode != ""
        ; Clear overlay
		Int i = 0
		Int fn = nioverride.GetNumFaceOverlays()
		while i < fn
			String nn = "Face [Ovl" + i as String + "]"
			String tx = ""
			if netimmerse.HasNode(overlayActor, nn, false)
				tx = nioverride.GetNodepropertyString(overlayActor, false, nn, 9, 0)
			else
				tx = nioverride.GetNodeOverrideString(overlayActor, isFemale, nn, 9, 0)
			endIf
			if stringutil.Find(tx, "paint.dds", 0) != -1
				nioverride.AddNodeOverrideFloat(overlayActor, isFemale, nn, 8, 0, 0.000000, false)
				nioverride.AddNodeOverrideString(overlayActor, isFemale, nn, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
				nioverride.RemoveAllNodeNameOverrides(overlayActor, isFemale, nn)
			endIf
			i += 1
		endWhile
	endif
			
EndFunction