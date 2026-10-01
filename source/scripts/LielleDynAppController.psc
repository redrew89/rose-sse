Scriptname LielleDynAppController extends Quest  

; MCM script, to grab properties from
LielleMCMCore 				Property 	MCM 	Auto

LielleDynamicWarpaint 	Property 	paint 	Auto
LielleDynamicTattoo		Property 	tattoo 	Auto

TextureSet					Property	LielleBodyBaseCLASSICTorso	Auto
TextureSet					Property 	LielleBodyBaseCLASSICHand	Auto
TextureSet					Property 	LielleBodyBaseCLASSICHead	Auto

TextureSet					Property	LielleBodyBaseMODERNTorso	Auto
TextureSet					Property 	LielleBodyBaseMODERNHand	Auto
TextureSet					Property 	LielleBodyBaseMODERNHead	Auto

bool 	Property 	bNiOverridePresent 		= false 	Auto

int 	Property	CONST_RED 					= 0xFF0000 Auto
int		Property 	CONST_PURPLE 				= 0x380077 Auto
int		Property 	CONST_PINK					= 0xEE22AA Auto
int		Property	CUSTOM_PAINT				= 0xFFFFFF Auto
int 	Property	CUSTOM_TATT					= 0xFFFFFF Auto

Event OnInit()

	If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6)) 
		bNiOverridePresent = true
		RefreshAppearance()
	endif		
	
endEvent

Function SetBaseBody()

	ObjectReference Lielle = ((self as Quest).GetAlias(0) as ReferenceAlias).GetActorReference() as ObjectReference
	bool isFemale = true
	TextureSet currentBodyTex = LielleBodyBaseCLASSICTorso
	TextureSet currentHandTex = LielleBodyBaseCLASSICHand
	TextureSet currentHeadTex = LielleBodyBaseCLASSICHead
	
	if MCM.iSkinOpt == 1
		currentBodyTex = LielleBodyBaseMODERNTorso
		currentHandTex = LielleBodyBaseMODERNHand
		currentHeadTex = LielleBodyBaseMODERNHead
		NiOverride.AddSkinOverrideTextureSet(Lielle, isFemale, true, 0x00000004, 6, -1, currentBodyTex, true)
		NiOverride.AddSkinOverrideTextureSet(Lielle, isFemale, true, 0x00000080, 6, -1, currentBodyTex, true)
		NiOverride.AddSkinOverrideTextureSet(Lielle, isFemale, true, 0x00000008, 6, -1, currentHandTex, true)
		NiOverride.AddSkinOverrideTextureSet(Lielle, isFemale, true, 0x00000001, 6, -1, currentHeadTex, true)
		NiOverride.ApplySkinOverrides(Lielle)
	else
		NiOverride.RemoveAllReferenceSkinOverrides(Lielle)
	endif
	

EndFunction

Function RefreshAppearance()

	if bNiOverridePresent
	
		SetBaseBody()
		
		; Indices match the MCM menu and LielleDynamicAppearanceManager.SetTattoo:
		; 0 Disabled, 1 Rose Red, 2 Dwemer Purple, 3 Lovestruck Pink, 4 Pride, 5 Custom
		if MCM.iMenuSelectTattoo == 1
			tattoo.EmissiveColor = CONST_RED
			tattoo.TintColor = CONST_RED
		elseif MCM.iMenuSelectTattoo == 2
			tattoo.EmissiveColor = CONST_PURPLE
			tattoo.TintColor = CONST_PURPLE
		elseif MCM.iMenuSelectTattoo == 3
			tattoo.EmissiveColor = CONST_PINK
			tattoo.TintColor = CONST_PINK
		elseif MCM.iMenuSelectTattoo == 4
			tattoo.EmissiveColor = 0 ; Pride - the tattoo script swaps in the pride texture, no emissive
			tattoo.TintColor = 0
		elseif MCM.iMenuSelectTattoo == 5
			tattoo.EmissiveColor = 0xFFFFFF
			tattoo.TintColor = CustomTattooColor()
		endif
		tattoo.tattooMCMSetting = MCM.iMenuSelectTattoo
		tattoo.RefreshTattoo() ; Removes the overlay when the menu is set to 0, otherwise applies it			
	endif
	if bNiOverridePresent
		; Indices match the MCM menu and LielleDynamicAppearanceManager.SetWarpaint:
		; 0 Clean Face, 1 Rose Red, 2 Dwemer Purple, 3 Lovestruck Pink, 4 Pride, 5 Custom
		if MCM.iMenuSelectWarpaint == 0
			paint.TintColor = 0
		elseif MCM.iMenuSelectWarpaint == 1
			paint.TintColor = CONST_RED
		elseif MCM.iMenuSelectWarpaint == 2
			paint.TintColor = CONST_PURPLE
		elseif MCM.iMenuSelectWarpaint == 3
			paint.TintColor = CONST_PINK
		elseif MCM.iMenuSelectWarpaint == 4
			paint.TintColor = 0x000000 ; Pride - the warpaint script swaps in the pride texture
		elseif MCM.iMenuSelectWarpaint == 5
			paint.TintColor = CustomPaintColor()
		endif
		if MCM.bWarpaintGlow && MCM.iMenuSelectWarpaint != 0
			paint.EmissiveMultiple = 1.0
		else
			paint.EmissiveMultiple = 0.0
		endif		
		paint.warpaintMCMSetting = MCM.iMenuSelectWarpaint
		paint.StartWarpaint()
	endif

endFunction

; The MCM color pickers store custom colors on the Dynamic Appearance manager
int Function CustomTattooColor()
	if MCM.DynAppManager
		return MCM.DynAppManager.CUSTOM_TATT
	endif
	return CUSTOM_TATT
EndFunction

int Function CustomPaintColor()
	if MCM.DynAppManager
		return MCM.DynAppManager.CUSTOM_PAINT
	endif
	return CUSTOM_PAINT
EndFunction

