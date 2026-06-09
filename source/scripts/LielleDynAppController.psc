Scriptname LielleDynAppController extends Quest  

; MCM script, to grab properties from
LielleMCMCore 				Property 	MCM 	Auto

LielleDynamicWarpaintProto 	Property 	paint 	Auto
LielleTattooGlowProto 		Property 	tattoo 	Auto

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
			tattoo.EmissiveColor = 0xFFFFFF
			tattoo.TintColor = CUSTOM_TATT			
		elseif MCM.iMenuSelectTattoo == 5
			tattoo.EmissiveColor = 0xFFFFFF
			tattoo.TintColor = 0			
		endif
		tattoo.tattooMCMSetting = MCM.iMenuSelectTattoo
		tattoo.StartTattoo()			
	endif
	if bNiOverridePresent
		if MCM.iMenuSelectWarpaint == 1
			paint.TintColor = CONST_RED
		elseif MCM.iMenuSelectWarpaint == 2
			paint.TintColor = CONST_PURPLE
		elseif MCM.iMenuSelectWarpaint == 3
			paint.TintColor = CONST_PINK
		elseif MCM.iMenuSelectWarpaint == 4
			paint.TintColor = CUSTOM_PAINT
		elseif MCM.iMenuSelectWarpaint == 5
			paint.TintColor = 0x000000
		endif
		if MCM.bWarpaintGlow
			paint.EmissiveMultiple = 1.0
		else
			paint.EmissiveMultiple = 0.0
		endif		
		paint.warpaintMCMSetting = MCM.iMenuSelectWarpaint
		paint.StartWarpaint()
	endif
	
endFunction

