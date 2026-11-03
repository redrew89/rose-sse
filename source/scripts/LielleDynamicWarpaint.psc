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

; RaceMenu draws an overlay whose texture hasn't finished loading as black, which post-processing
; makes very visible. So the paint is never re-applied when nothing changed, and a new texture is
; set while the overlay is invisible, given time to load, then faded in.
Int fadeSteps = 8
Float fadeDuration = 0.4
Float loadWait = 0.15

; Other overlays (tears, blush, and most other mods) take the first free face slot counting up from 0,
; so those low slots churn. The paint keeps to the far end instead: the highest slot by default, or
; slot 0 upward when this is false.
Bool bPaintTopSlot = true

LielleDynamicAppearanceManager DynApp

event OnInit()

	DynApp = GetOwningQuest() as LielleDynamicAppearanceManager
	; Start through the manager, so its saved settings (Clean Face = no overlay) decide. Calling StartWarpaint
	; here used this script's own default (Rose Red) and put the overlay on whenever the quest started.
	if DynApp
		DynApp.SetWarpaint()
	endif

EndEvent

Function StartWarpaint()
    overlayActor = GetActorReference()
    isFemale = true

    ; Check for NiOverride and RaceMenu support
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6))
		niOverrideInstalled = true
		MCM.bNiOverridePresent = true

		if warpaintMCMSetting == 0
			ClearWarpaint() ; Clean face - claims no overlay slot at all
			return
		endif

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

; Walks the face slots from the far end (see bPaintTopSlot) and takes the first that is hers or empty.
; Paint left in any other slot - a save from before this, or a slot the paint moved out of - is
; faded out and cleared, so the paint only ever lives in one slot.
Bool Function InitializeOverlay(ObjectReference target)
    If !niOverride.HasOverlays(target)
        niOverride.AddOverlays(target)
        Utility.Wait(0.1)
    EndIf

    Int overlayCount = niOverride.GetNumFaceOverlays()
    Int n = 0
    While n < overlayCount
        Int i = n
        If bPaintTopSlot
            i = overlayCount - 1 - n
        EndIf
        String testNode = "Face [Ovl" + i as String + "]"
        String currentTex = niOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        If IsPaintTexture(currentTex) || currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1
            overlayNode = testNode
            ClearStrayPaint(overlayNode)
            If DebugMode
                Core.Msg(msgFlag + "Found valid overlay node: " + overlayNode, false)
            EndIf
            Return true
        EndIf
        n += 1
    EndWhile

    If DebugMode
        Core.Msg(msgFlag + "Unable to find valid overlay node.",false)
    EndIf
    Return false
EndFunction

; Fades out and clears her paint in every face slot except keepNode
Function ClearStrayPaint(String keepNode)
	Int i = 0
	Int fn = nioverride.GetNumFaceOverlays()
	while i < fn
		String nn = "Face [Ovl" + i as String + "]"
		if nn != keepNode
			String tx = nioverride.GetNodeOverrideString(overlayActor, isFemale, nn, 9, 0)
			if IsPaintTexture(tx)
				Float shownAlpha = nioverride.GetNodeOverrideFloat(overlayActor, isFemale, nn, 8, -1)
				if shownAlpha > 0.0
					FadeAlpha(nn, shownAlpha, 0.0)
				endif
				nioverride.AddNodeOverrideFloat(overlayActor, isFemale, nn, 8, 0, 0.000000, false)
				nioverride.AddNodeOverrideString(overlayActor, isFemale, nn, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
				nioverride.RemoveAllNodeNameOverrides(overlayActor, isFemale, nn)
				If DebugMode
					Core.Msg(msgFlag + "Moved warpaint out of " + nn, false)
				EndIf
			endif
		endif
		i += 1
	endWhile
EndFunction

Bool Function IsPaintTexture(String tex)
    Return StringUtil.Find(tex, "defaultpaint.dds", 0) != -1 || StringUtil.Find(tex, "pridepaint.dds", 0) != -1 || StringUtil.Find(tex, "smudgepaint.dds", 0) != -1
EndFunction

Function SetWarpaint(int warpaintOption)
    If overlayNode != ""
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

		; Game load, MCM page opens and location changes all re-request the same paint - RaceMenu has
		; already restored it, so touching the overlay again would only flash it
		if IsApplied(currentTexture)
			return
		endif

		String shownTex = niOverride.GetNodeOverrideString(overlayActor, isFemale, overlayNode, 9, 0)
		Float shownAlpha = niOverride.GetNodeOverrideFloat(overlayActor, isFemale, overlayNode, 8, -1)

		if shownTex == currentTexture && shownAlpha > 0.0
			; Same texture already loaded and visible - colour, glow and opacity change in place
			SetShaderValues()
			niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 8, -1, overlayAlpha, true)
			niOverride.ApplyNodeOverrides(overlayActor)
		else
			; New texture: fade any visible paint out, set everything while invisible, let it load, fade in
			if IsPaintTexture(shownTex) && shownAlpha > 0.0
				FadeAlpha(overlayNode, shownAlpha, 0.0)
			endif
			niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 8, -1, 0.0, true) ; ShaderAlpha - invisible
			SetShaderValues()
			niOverride.AddNodeOverrideString(overlayActor, isFemale, overlayNode, 9, 0, currentTexture, true)
			niOverride.ApplyNodeOverrides(overlayActor)
			Utility.Wait(loadWait)
			FadeAlpha(overlayNode, 0.0, overlayAlpha)
		endif

        If DebugMode
            Core.Msg(msgFlag + "Applied warpaint overlay to " + overlayNode, false)
        EndIf
    EndIf
EndFunction

Function SetShaderValues()
	niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 2, -1, 0.0, true) ; ShaderGlossiness
	niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 3, -1, 0.0, true) ; ShaderSpecularStrength
	niOverride.AddNodeOverrideInt(overlayActor, isFemale, overlayNode, 0, -1, EmissiveColor, true) ; ShaderEmissiveColor
	niOverride.AddNodeOverrideFloat(overlayActor, isFemale, overlayNode, 1, -1, EmissiveMultiple, true) ; ShaderEmissiveMultiple - glow
	niOverride.AddNodeOverrideInt(overlayActor, isFemale, overlayNode, 7, -1, TintColor, true) ; ShaderTintColor
EndFunction

; True when the slot already shows this texture with the requested colour, glow and opacity
Bool Function IsApplied(String tex)
	If niOverride.GetNodeOverrideString(overlayActor, isFemale, overlayNode, 9, 0) != tex
		Return false
	EndIf
	If niOverride.GetNodeOverrideInt(overlayActor, isFemale, overlayNode, 7, -1) != TintColor
		Return false
	EndIf
	If niOverride.GetNodeOverrideInt(overlayActor, isFemale, overlayNode, 0, -1) != EmissiveColor
		Return false
	EndIf
	If Math.Abs(niOverride.GetNodeOverrideFloat(overlayActor, isFemale, overlayNode, 1, -1) - EmissiveMultiple) > 0.01
		Return false
	EndIf
	Return Math.Abs(niOverride.GetNodeOverrideFloat(overlayActor, isFemale, overlayNode, 8, -1) - overlayAlpha) <= 0.01
EndFunction

Function FadeAlpha(String node, Float fromAlpha, Float toAlpha)
	Int s = 1
	While s <= fadeSteps
		niOverride.AddNodeOverrideFloat(overlayActor, isFemale, node, 8, -1, fromAlpha + (toAlpha - fromAlpha) * (s as Float / fadeSteps as Float), true)
		niOverride.ApplyNodeOverrides(overlayActor)
		Utility.Wait(fadeDuration / fadeSteps as Float)
		s += 1
	EndWhile
EndFunction


; Fades out any slot holding her paint, then releases it
Function ClearWarpaint()
    if overlayActor
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
				Float shownAlpha = nioverride.GetNodeOverrideFloat(overlayActor, isFemale, nn, 8, -1)
				if shownAlpha > 0.0
					FadeAlpha(nn, shownAlpha, 0.0)
				endif
				nioverride.AddNodeOverrideFloat(overlayActor, isFemale, nn, 8, 0, 0.000000, false)
				nioverride.AddNodeOverrideString(overlayActor, isFemale, nn, 9, 0, "textures\\Actors\\character\\overlays\\default.dds", false)
				nioverride.RemoveAllNodeNameOverrides(overlayActor, isFemale, nn)
			endIf
			i += 1
		endWhile
		overlayNode = ""
	endif

EndFunction
