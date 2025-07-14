Scriptname LielleMCMCore extends ski_configbase  

; Other script instances we might access
LielleCoreScript Property Core Auto
LielleCoreARQ Property CoreARQ Auto
LielleXOScript Property CoreXO Auto
LielleStudyRankScript Property StudyRank Auto
LielleFollowerScript Property Follower Auto

;LielleEmotionManager Property Emotion Auto -- Commented out for 0.4.5
;LielleOutfitScript Property Outfits Auto  -- Commented out for 0.4.5
;GlobalVariable Property LielleIsGYHInstalled Auto  -- Commented out for 0.4.5

; Lielle's reference alias and quests; for debugging features
ReferenceAlias Property LielleAlias Auto
Quest Property LielleARQGauldur Auto
Quest Property LielleARQDawn Auto
Quest Property LielleARQRose Auto
Quest Property LielleARQRoseNeloth Auto
Quest Property LielleARQRoseFinal Auto
Quest Property LielleARQRazor Auto
Quest Property LielleARQSpellbreak Auto
Quest Property LielleARQAether Auto
Quest Property LielleARQBlackreach Auto
Quest Property LielleARQWord Auto
Quest Property LielleARQLab Auto
Quest Property LielleARQStar Auto
Quest Property LielleCSQMain Auto
Quest Property LielleARQMain auto
Quest Property LielleCSQmg auto

Quest Property LielleDynamicAppearance Auto ; Leave empty in plugin data -- filled dynamically for 0.4.5, will repoint in 0.5.0
ObjectReference Property LielleARQTelMithrynMarker Auto ; Marker placed in Tel Mithryn. May replace with alias pointing to staff enchanter.

; Base game/DLC quests that we might do things with
Quest Property MG02 auto
Quest Property DA09 auto 
Quest Property DA14 auto
Quest Property DA07 auto
Quest Property dunGauldursonQST auto
Quest Property DA13 auto
Quest Property DLC2TT1 auto

; - 0.4.5 - Variables renamed according to proper naming practices.
int 	flag_DynamicAppearance
int 	flag_NightmareOption
int		flag_WarpaintCustom
int		flag_WarpaintGlow
int		flag_TattooCustom

int 	opt_MenuWarpaint
int 	opt_MenuTattoo
int 	opt_WarpaintCustom
int 	opt_TattooCustom
int 	opt_PaintGlow
int 	opt_PaintSmudge
int		opt_baseBody

int 	opt_Teleport
int 	opt_CombatReset
int 	opt_AIReset
int 	opt_NightmareAltered
int 	opt_NativeHeal
int 	opt_msgVerbose
int 	opt_debugMenu
int 	opt_debugDawn
int 	opt_debugRose
int 	opt_debugRose2
int 	opt_debugRazor
int 	opt_debugGauldur1
int 	opt_debugGauldur2
int 	opt_debugSpellbreak
int 	opt_skipIntro
int 	opt_fAffection

bool 	bdebugDev 						= false
bool 	bHealingNative 					= true
bool 	bMsgVerbose 					= true
bool 	bNightmareAltered				= true
bool 	bNightmareOptDisable			= false
bool 	Property bNiOverridePresent 	= false 	Auto
int 	Property iSkinOpt				= 0			Auto

String[] 	warpaintOptions 
String[] 	tattooGlowColors
String[]	baseBodySkin	

int 	Property	CONST_RED 					= 0xFF0000 Auto
int		Property 	CONST_PURPLE 				= 0x380077 Auto
int		Property 	CONST_PINK					= 0xEE22AA Auto
int		Property	CUSTOM_PAINT				= 0xFFFFFF Auto
int 	Property	CUSTOM_TATT					= 0xFFFFFF Auto


int 	Property	iMenuSelectTattoo 			= 1 		Auto
int		Property 	iMenuSelectWarpaint 		= 1 		Auto
bool	Property	bWarpaintGlow				= false 	Auto
bool 	Property	bWarpaintSmudge				= false 	Auto


int function GetVersion()
	return 450 ; Switch to modfied semantic versioning - 450 == 0.4.5.0 	
;	return 500 ; Semantic version 0.5.0.0
endFunction

event OnVersionUpdate(int a_version)
	if (a_version > CurrentVersion)
		Core.Msg("LielleCore: Updated to " + Core.LielleVersion())
		CurrentVersion = a_version
		OnConfigInit()		
	endif
EndEvent

Event OnConfigInit()

	ModName 	= "Lielle - Rose of the North"
	Pages 		= New String[5]
	Pages[0] 	= "Settings"
	Pages[1] 	= "Arcane Research"
	Pages[2] 	= "Credits"
	Pages[3] 	= "Integrations"
	
	if bdebugDev 
		Pages[4] = "Advanced"
	else 
		Pages[4] = none
	endif
	
	; 0.4.5 - Lazy loading quest from dynamic appearance test plugin - repoint in 0.5.0 - Filling unfilled script instance with a cast
	LielleDynamicAppearance = Game.GetFormFromFile(0x94F, "Lielle-DynamicAppearanceProto.esp") as Quest
		
	if LielleDynamicAppearance
		
		warpaintOptions 			= new String[6]
		warpaintOptions[0] 			= "Clean Face"
		warpaintOptions[1] 			= "Rose Red"
		warpaintOptions[2] 			= "Dwemer Purple"
		warpaintOptions[3] 			= "Lovestruck Pink"
		warpaintOptions[4] 			= "Custom Color"
		warpaintOptions[5] 			= "Pride Forever!"
		
		tattooGlowColors 			= new String[6]
		tattooGlowColors[0] 		= "No Glow"
		tattooGlowColors[1] 		= "Rose Red"
		tattooGlowColors[2] 		= "Dwemer Purple"
		tattooGlowColors[3] 		= "Lovestruck Pink"
		tattooGlowColors[4] 		= "Custom Color"
		tattooGlowColors[5] 		= "Pride Forever!"
		
		baseBodySkin				= new String[2]
		baseBodySkin[0]				= "Classic"
		baseBodySkin[1]				= "Modern"
		
	endif
	if bNiOverridePresent
		flag_DynamicAppearance = OPTION_FLAG_NONE
	else	
		flag_DynamicAppearance = OPTION_FLAG_HIDDEN
	endif
		
EndEvent

Event OnPageReset(string Page)
	if page == ""
		LoadCustomContent("lielle//Logo.dds",126,33)
	else
		UnloadCustomContent()
	endif
	
	if page == "Settings"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddTextOption("Version: " , Core.LielleVersion())
		AddEmptyOption()
		AddHeaderOption("Debug Options")
		AddEmptyOption()
		opt_debugMenu 			= AddToggleOption("Full Debug Options:", false)
		opt_Teleport 			= AddToggleOption("Teleport to Player:", false)
		opt_CombatReset 		= AddToggleOption("Reset Combat State:", false)
		opt_AIReset 			= AddToggleOption("Reset AI:" , false)
		
		AddEmptyOption()
		opt_msgVerbose 			= AddToggleOption("Verbose Messages", bMsgVerbose)
		opt_NightmareAltered 	= AddToggleOption("Altered Nightmare", bNightmareAltered, flag_NightmareOption)
		opt_NativeHeal 			= AddToggleOption("Native Self and Player Healing", bHealingNative)
		
		SetCursorPosition(1)
		AddHeaderOption("Lielle's Stats")
		AddEmptyOption()
		AddTextOption("Current Actor Level: ", (LielleAlias.GetActorReference()).GetLevel())
		AddTextOption("Health: ", (LielleAlias.GetActorReference()).GetAV("Health") as int)
		AddTextOption("Magicka: ", (LielleAlias.GetActorReference()).GetAV("Magicka") as int)
		AddTextOption("Stamina: ", (LielleAlias.GetActorReference()).GetAV("Stamina") as int)
		AddEmptyOption()
		AddTextOption("Affection Value: " , (CoreXO.LielleXOVar as String) + "/10")

	elseif page == "Arcane Research"
		SetCursorPosition(0)
		SetCursorFillMode(TOP_TO_BOTTOM)
		
		AddHeaderOption("Arcane Research Quests")
		AddEmptyOption()
		AddTextOption("Gaulder Amulet: " , GetQuestStatus(LielleARQGauldur))
		AddTextOption("Dawnbreaker: " , GetQuestStatus(LielleARQDawn))
		AddTextOption("Mehrune's Razor: " , GetQuestStatus(LielleARQRazor))
		AddTextOption("Sanguine Rose: " , GetQuestStatus(LielleARQRose))
		AddTextOption("Sanguine Rose Pt 2: " , GetQuestStatus(LielleARQRoseNeloth))
		AddTextOption("Sanguine Rose Pt 3: " , GetQuestStatus(LielleARQRoseFinal))
		AddTextOption("Spellbreaker: " , GetQuestStatus(LielleARQSpellbreak))
		AddTextOption("Word Walls: ", GetQuestStatus(LielleARQWord))
	
	;	0.5.0 quests, commented out.
	;	AddTextOption("Field Work: ", GetQuestStatus(LielleARQLab))
	;	AddTextOption("Aetherium: ", GetQuestStatus(LielleARQAether))
	;	AddTextOption("Blackreach:", GetQuestStatus(LielleARQBlackreach))
	;	AddTextOption("Azura's/Black Star: ", GetQuestStatus(LielleARQStar))
		
		SetCursorPosition(1)
		AddHeaderOption("Research Stats")
		AddEmptyOption()
		AddTextOption("Current Research Status: " , CoreARQ.GetStatus())
		AddTextOption("Study Rank: " , StudyRank.getRank())
		AddTextOption("Research Quests Completed: " , CoreARQ.LielleARQCount)

	elseif page == "Advanced" 
		SetCursorPosition(0)
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Basic Debug Options")  	
		opt_skipIntro 			= AddToggleOption("Skip Intro Dialogue", false)
		opt_fAffection 			= AddSliderOption("Affection Adjustment", CoreXO.LielleXOVar,"{3}/10")
		
		AddEmptyOption()
		AddHeaderOption("ARQ Testing")
		opt_debugDawn 			= AddToggleOption("Dawnbreaker", false)
		opt_debugRose 			= AddToggleOption("Sanguine Rose", false)
		opt_debugRose2 			= AddToggleOption("Sanguine Rose Pt2", false)
		opt_debugRazor 			= AddToggleOption("Mehrune's Razor", false)
		opt_debugGauldur1 		= AddToggleOption("Saarthal Gauldur Fragment", false)
		opt_debugGauldur2 		= AddToggleOption("Reforged Gauldur Amulet",  false)
		opt_debugSpellbreak 	= AddToggleOption("Spellbreaker", false)
		
	elseif page == "Credits"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		
		AddHeaderOption("Technical and Creative Team")
		AddTextOption("Lead Writer"	, "Drew H. 'ReDrew89'")
		AddTextOption("Lead Quest Design","Drew H. 'ReDrew89'")
		AddTextOption("Supporting Writer","'Dashogi'")
		AddTextOption("Lead Level Design","SanneARBY")
		AddTextOption("Lead QA Tester","'Scorcher'")
		AddEmptyOption()
		AddHeaderOption("Voice Talent")
		AddTextOption("Lielle","Jody Sharp 'JoJoRawr'")
		AddTextOption("Three-Eyes","Milica Radovanovic 'MilicaVO'")
		AddTextOption("Malek/Marek","'youngone'")
		AddTextOption("Markus","'Vanwood'")
		AddEmptyOption()
		AddHeaderOption("Patrons")
		AddTextOption("Jonas Wisser", none)
		AddTextOption("Drac", none)
		AddTextOption("piranha45", none)
		AddEmptyOption()
		AddHeaderOption("Scripting and Implementation")
		AddTextOption("Lucien by JosephRussell", none)
		AddTextOption("Deadwood 2.0 by PyroToaster", none)
		AddTextOption("Ashe - Crystal Heart by Martimus", none)
		AddTextOption("Spellbreaker Spell Reflection and Ward Visuals Restored", none)
		AddEmptyOption()
		AddHeaderOption("Inspiration and Special Mention")
		AddTextOption("The Unofficial Elder Scrolls Pages", none)
		AddTextOption("The Skyrim Voice Alliance", none)
		AddTextOption("r/SkyrimMods",none)
		AddTextOption("Aniya by Kenerad",none)
		AddTextOption("Val Serano by Axarien",none)
		AddTextOption("Inigo by Smartbluecat",none)
		AddTextOption("Remiel by Maplespice",none)
		SetCursorPosition(1) 
				
		AddEmptyOption()
		AddHeaderOption("Character Assets and Outfits")
		AddTextOption("KS Hairdos by Kalilies", none)
		AddTextOption("KS Hairdos HDT SMP by ousnius", none)
		AddTextOption("High Poly Head by VectorPlexus", none)
		AddTextOption("Fair Skin Complexion by HHaleyy", none)
		AddTextOption("Women of Skyrim SE by Shiva182", none)
		AddTextOption("UNP Dragon Tattoos and more by AncientKane", none)
		AddTextOption("Frecklemania 2 by tetrodoxin", none)
		AddTextOption("PAINTERLY by gobbidygook", none)		
		AddTextOption("Skin Feature Overlays SE by DomainWolf", none)
		AddTextOption("Caliente's Beautiful Bodies Edition", none)
		AddTextOption("CBBE 3BA by Acro748", none)
		AddTextOption("Osare Culort Outfit by anano feat. Zynxx", none)
		AddTextOption("Ashara Imperial Outfit", none)
		AddTextOption("UNP Nevernude Bikini BHUNP Conversion by Ismellgasonmyhands", none)
		AddTextOption("Robert HGEC Underwear CBBE 3BA by contentcat", none)
		AddEmptyOption()
		AddHeaderOption("Tools and Software")
		AddTextOption("Mod Organizer 2", none)
		AddTextOption("Creation Kit Platform Extended", none) 
		AddTextOption("xEdit", none)
		AddTextOption("BSA Browser", none)
		AddTextOption("Paint.NET", none)
		AddTextOption("Notepad++", none)
		AddTextOption("Audacity", none)
		AddTextOption("Runalip and LazyVoiceFinder", none)
		AddTextOption("BodySlide and Outfit Studio", none)
		AddTextOption("Blender", none)
		AddTextOption("NifSkope", none)
		AddTextOption("Claude.ai (Scripting and Implementation)", none)
		AddEmptyOption()
		AddHeaderOption("Other Resources")
		AddTextOption("Princess Sofia",none)
		AddTextOption("Copyright (c) 2011, Font Diner (www.fontdiner.com), with Reserved",none)
		AddTextOption("SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007",none)
		
	elseif page == "Integrations"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("Mod Integrations")
		AddTextOption("College Overhaul:", CheckIntegration(((Core as Quest).GetAlias(0) as Lielle_CollegeOverhaulCheck).LielleCollegeOverhaul))
		AddEmptyOption()
			
		; --- Need to carry into 0.5.0 - Revise alias method
		
		AddHeaderOption("Spell Mods")
		AddTextOption("Apocalypse - Spells of Skyrim", CheckIntegration((LielleCSQMain.GetAlias(6) as Lielle_InCombatSpells).LielleApocalypseInstalled))
		;AddTextOption("Mysticism - A Magic Overhaul", CheckIntegration((LielleAlias.GetActorReference() as Lielle_InCombatSpells).LielleMysticismInstalled))
		
		
		;/
		; --- ARTIFACT - COMMENTED VIA BACKPORT FROM 0.5.0
		;
		AddHeaderOption("Outfit Integrations")
		
		AddTextOption("West Wind Misfit Mage: ", CheckIntegration(Outfits.LielleOutfitMisfit))
		AddTextOption("Dwemer Researcher: ", CheckIntegration(Outfits.LielleOutfitResearcher))
		AddTextOption("Cloaks of Skyrim: " , CheckIntegration(Outfits.LielleOutfitCloak))
		AddTextOption("KS Hairdos Wigs: ", CheckIntegration(none,none, Outfits.bWigsFound))
		AddTextOption("KS Jewelry: ", CheckIntegration(none,none, Outfits.bWeddingItemsAdded))
		AddEmptyOption()
		AddHeaderOption("Systems Integrations")
		
		AddTextOption("I'm Glad You're Here:", CheckIntegration(LielleIsGYHInstalled))
		AddTextOption("Mfg Fix NG:", CheckIntegration(none,none,((CoreXO as Quest) as LielleEmotionManager).bMfgFixPresent))
		/;
		
		SetCursorPosition(1)
		
		; - 0.4.5 Dynamic Appearance Feature Prototype - To be carried to 0.5.0
		if iMenuSelectWarpaint != 0  && flag_DynamicAppearance != OPTION_FLAG_HIDDEN
			flag_WarpaintGlow = OPTION_FLAG_NONE
		elseif flag_DynamicAppearance == OPTION_FLAG_HIDDEN
			flag_WarpaintGlow = OPTION_FLAG_HIDDEN
		else
			flag_WarpaintGlow = OPTION_FLAG_HIDDEN
		endif
		if iMenuSelectWarpaint == 4 && flag_DynamicAppearance != OPTION_FLAG_HIDDEN
			flag_WarpaintCustom = OPTION_FLAG_NONE
		elseif flag_DynamicAppearance == OPTION_FLAG_HIDDEN
			flag_WarpaintCustom = OPTION_FLAG_HIDDEN
		else
			flag_WarpaintCustom = OPTION_FLAG_DISABLED
		endif
		if iMenuSelectTattoo == 4 && flag_DynamicAppearance != OPTION_FLAG_HIDDEN
			flag_TattooCustom = OPTION_FLAG_NONE
		elseif flag_DynamicAppearance == OPTION_FLAG_HIDDEN
			flag_TattooCustom = OPTION_FLAG_HIDDEN
		else
			flag_TattooCustom = OPTION_FLAG_DISABLED
		endif
		int flag_DynamicStoryMode 
		if flag_DynamicAppearance == OPTION_FLAG_HIDDEN
			flag_DynamicStoryMode = OPTION_FLAG_HIDDEN
		else
			flag_DynamicStoryMode = OPTION_FLAG_DISABLED
		endif
			
		AddHeaderOption("Dynamic Appearance Test",flag_DynamicAppearance)
		AddTextOption("Story Mode:","Coming Soon",flag_DynamicStoryMode)
		
		opt_PaintGlow 		= AddToggleOption("Dynamic Warpaint Glow:", bWarpaintGlow, flag_WarpaintGlow)
		opt_PaintSmudge 	= AddToggleOption("Dynamic Warpaint Smudge:", bWarpaintSmudge, flag_DynamicAppearance)
		opt_MenuWarpaint 	= AddMenuOption("Dynamic Warpaint:", warpaintOptions[iMenuSelectWarpaint], flag_DynamicAppearance)		
		opt_MenuTattoo 		= AddMenuOption("Dynamic Tattoo Accent:", tattooGlowColors[iMenuSelectTattoo], flag_DynamicAppearance)
		AddEmptyOption()
		opt_WarpaintCustom 	= AddColorOption("Warpaint Custom Color:", CUSTOM_PAINT,flag_WarpaintCustom)
		opt_TattooCustom 	= AddColorOption("Tattoo Custom Color:", CUSTOM_TATT,flag_TattooCustom)
		
		AddEmptyOption()
		AddHeaderOption("Character Interactions")
		AddTextOption("Rumarin: ", CheckIntegration(none,(LielleCSQMain.GetAlias(3) as ReferenceAlias)))
		AddTextOption("Anum-La: ", CheckIntegration(none,(LielleCSQMain.GetAlias(5) as ReferenceAlias)))
		;AddTextOption("Mugnor: ", CheckIntegration(none,(LielleCSQMain.GetAlias(11) as ReferenceAlias)))
		AddTextOption("Sofia: ", CheckIntegration(none,(LielleCSQMain.GetAlias(8) as ReferenceAlias)))
		AddTextOption("Inigo: ", CheckIntegration(none,(LielleCSQMain.GetAlias(7) as ReferenceAlias)))
				
	endif
		
endEvent

Event OnOptionMenuOpen(int option)
	
	if option == opt_MenuWarpaint
		Core.Msg("Current warpaint state: " + iMenuSelectWarpaint + ":" + warpaintOptions[iMenuSelectWarpaint], false)
		SetMenuDialogOptions(warpaintOptions)
		SetMenuDialogStartIndex(iMenuSelectWarpaint)
		SetMenuDialogDefaultIndex(1)
	elseif option == opt_MenuTattoo
		Core.Msg("Current tattoo state: " + iMenuSelectTattoo + ":" + tattooGlowColors[iMenuSelectTattoo], false)	
		SetMenuDialogOptions(tattooGlowColors)
		SetMenuDialogStartIndex(iMenuSelectTattoo)
		SetMenuDialogDefaultIndex(1)
	
	endif	
	
endEvent

Event OnOptionMenuAccept(int option, int index)
	
	; Check for valid index first - negative values mean user cancelled or error occurred
	if index < 0
		Core.Msg("Menu cancelled or invalid index received: " + index, false)
		return
	endif
	
	if option == opt_MenuWarpaint
		if index >= 0 && index < warpaintOptions.Length
			iMenuSelectWarpaint = index
			SetMenuOptionValue(opt_MenuWarpaint, warpaintOptions[iMenuSelectWarpaint], true)
		else
			Core.Msg("Invalid warpaint index: " + index, false)
		endif
	elseif option == opt_MenuTattoo
		if index >= 0 && index < tattooGlowColors.Length
			iMenuSelectTattoo = index
			SetMenuOptionValue(opt_MenuTattoo, tattooGlowColors[iMenuSelectTattoo], true)
		else
			Core.Msg("Invalid tattoo index: " + index, false)
		endif
	
	endif
	
	ForcePageReset()
	RegisterForSingleUpdate(0.2)

endEvent

String Function CheckIntegration(GlobalVariable checkGlobal = none, ReferenceAlias charAlias = none, bool bCheck = false)
	
	if checkGlobal == (((Core as Quest).GetAlias(0) as Lielle_CollegeOverhaulCheck).LielleCollegeOverhaul)
		if checkGlobal.GetValueInt() == 0
			return "NONE"
		elseif checkGlobal.GetValueInt() == 1
			return "Obscure's College of Winterhold"
		elseif checkGlobal.GetValueInt() == 2
			return "Immersive College of Winterhold"
		elseif checkGlobal.GetValueInt() == 3
			return "Magical College of Winterhold"
		elseif checkGlobal.GetValueInt() == 4
			return "Ultimate College of Winterhold"
		else
			return "Undefined State - Check Installation"
		endif	
	endif

	if (checkGlobal == none && charAlias == none)
		if bCheck
			return "FOUND"
		else
			return "NOT FOUND"
		endif
	elseif checkGlobal != none
		if checkGlobal.GetValueInt() != 0
			return "FOUND"
		else
			return "NOT FOUND"
		endif	
	elseif charAlias != none
		if charAlias.GetReference() == none
			return "NOT FOUND"
		else 
			return "FOUND"
		endif
	endif
endFunction

Event OnOptionHighlight(int option)
	
	if option == opt_NightmareAltered
		SetInfoText("DEFAULT: ON. Changes scenes in Lielle's Nightmare to omit senstive content. Discretion advised. This choice will also be presented via dialogue during Lielle's Secret. This option will disable on starting Lielle's Secret.")
	elseif option == opt_NativeHeal
		SetInfoText("DEFAULT: ON. This option enables healing for player and Lielle. Disable if you use a mod that adds this feature.")
	elseif option == opt_msgVerbose
		SetInfoText("DEFAULT: ON. This option enables verbose message notifications for various core systems.")
	elseif option == opt_AIReset
		SetInfoText("Reset Lielle's basic AI packages. Try when forcegreets are broken")
	elseif option == opt_CombatReset
		SetInfoText("Attempts to disengage Lielle from combat. Might not work")
	elseif option == opt_Teleport
		SetInfoText("Moves Lielle to your location. May break quests.")	
	endif
	
endEvent

Event OnOptionSelect(int option)
	
	if option == opt_CombatReset
		SetToggleOptionValue(option,true,false)
		if (LielleAlias.GetActorReference()).IsInCombat()
			(LielleAlias.GetActorReference()).StopCombat()
		endif
		SetToggleOptionValue(option,false,false)		
	
	elseif option == opt_Teleport
		SetToggleOptionValue(option,true,false)
		;((CoreXO as Quest) as LielleTeleportScript).Summon(Game.GetPlayer(), (LielleAlias.GetActorRef())) -- 0.5.0 summon system
		(LielleAlias.GetReference()).MoveTo(Game.GetPlayer(),100,100)		
		SetToggleOptionValue(option,false,false)	
	
	elseif option == opt_AIReset
		SetToggleOptionValue(option,true,false)
		LielleAlias.GetActorReference().StopCombat()
		LielleAlias.GetActorReference().EvaluatePackage()		
		SetToggleOptionValue(option,false,false)		
	
	elseif option == opt_NightmareAltered
		bNightmareAltered = !bNightmareAltered
		Core.LielleNightmarePG = bNightmareAltered
		SetToggleOptionValue(option, bNightmareAltered,false)				
		
	elseif option == opt_msgVerbose
		bMsgVerbose != bMsgVerbose
		Core.LielleVerbose = bMsgVerbose
		SetToggleOptionValue(option, bMsgVerbose,false)
				
	elseif option == opt_NativeHeal
		bHealingNative = !bHealingNative
		Core.LielleNativeHeal = bHealingNative
		SetToggleOptionValue(option, bHealingNative,false)	
		
	elseif option == opt_PaintGlow
		bWarpaintGlow = !bWarpaintGlow
		SetToggleOptionValue(option,bWarpaintGlow,false)		
		
	elseif option == opt_debugMenu
		bdebugDev == !bdebugDev
		SetToggleOptionValue(option, bdebugDev,false)
		SetDebug(bdebugDev)
		
	elseif option == opt_skipIntro
		SetToggleOptionValue(option, true,false)
		;Set Stage on Lielle's introduction quests
		LielleARQMain.SetStage(10)
		LielleCSQmg.SetStage(31)
		SetToggleOptionValue(option, false,false)
		
	elseif option == opt_debugDawn
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(320750), 1, true)
		;Complete Meridia's Daedric Quest
		DA09.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == opt_debugRose
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(117558), 1, true)
		;Complete Sanguine's Daedric Quest
		DA14.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == opt_debugRose2
		;Teleport player and Lielle to Tel Mythrin; complete Neloth's quest to access staff enchanter.
		Game.GetPlayer().MoveTo(LielleARQTelMithrynMarker)
		LielleAlias.GetActorRef().MoveTo(Game.GetPlayer())
		DLC2TT1.CompleteQuest()
		debug.notification("You can activate the staff enchanter to trigger the quest.")
			
	elseif option == opt_debugRazor
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(147666), 1, true)
		;Complete Dagon's Daedric Quest
		DA07.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == opt_debugGauldur1
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(186202), 1, true)
		;Complete "Under Saarthal"
		MG02.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == opt_debugGauldur2
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(186227), 1, true)
		;Complete "Forbidden Legend"
		dunGauldursonQST.CompleteQuest()
		SetToggleOptionValue(option, false)
	
	elseif option == opt_debugSpellbreak
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(286614), 1, true)
		DA13.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif (option == opt_debugMenu)
		bdebugDev = !bdebugDev
		SetToggleOptionValue(option, bdebugDev,false)		
		OnConfigInit()	
		Debug.MessageBox("You must close and reopen the MCM for the new page to appear.")	
	elseif option == opt_PaintSmudge
		bWarpaintSmudge = !bWarpaintSmudge
		SetToggleOptionValue(option, bWarpaintSmudge,false)					
	endif

	ForcePageReset()
	RegisterForSingleUpdate(0.2)

endEvent

Event OnOptionSliderOpen(int option)

	if option == opt_fAffection
		SetSliderDialogStartValue(CoreXO.LielleXOVar)
		SetSliderDialogRange(0.0,10)
		SetSliderDialogInterval(0.25)	
	endif

EndEvent

Event OnOptionSliderAccept(int option, float value)
	
	if option == opt_fAffection
		CoreXO.LielleXOVar = Value
	endif
	ForcePageReset()
	
EndEvent

Event OnOptionColorOpen(int option)

	if option == opt_WarpaintCustom
		SetColorDialogStartColor(CUSTOM_PAINT)
		SetColorDialogDefaultColor(0xFFFFFF)
	elseif option == opt_TattooCustom
		SetColorDialogStartColor(CUSTOM_TATT)
		SetColorDialogDefaultColor(0xFFFFFF)
	endif

EndEvent

Event OnOptionColorAccept(int option, int color)

	if option == opt_WarpaintCustom
		CUSTOM_PAINT = color
		SetColorOptionValue(option,color)
	elseif option == opt_TattooCustom
		CUSTOM_TATT = color
		SetColorOptionValue(option,color)
	endif
	
	ForcePageReset()
	RegisterForSingleUpdate(0.2)

EndEvent

String Function GetQuestStatus(Quest aQuest)
	if aQuest.IsCompleted()
		return "Completed"
	elseif aQuest.IsRunning()
		return "Active"
	else
		return "Inactive"
	endif
endFunction

Function DisableNightmareOption()

	bNightmareOptDisable = true
	RegisterForSingleUpdate(0.2)
	
endFunction

Event OnUpdate()

	
	UnregisterForUpdate()
	
	if bNiOverridePresent
	
		LielleTattooGlowProto tattoo = LielleDynamicAppearance.GetAlias(0) as LielleTattooGlowProto
		
		
		if iMenuSelectTattoo == 1
			tattoo.EmissiveColor = CONST_RED
			tattoo.TintColor = CONST_RED
		elseif iMenuSelectTattoo == 2
			tattoo.EmissiveColor = CONST_PURPLE
			tattoo.TintColor = CONST_PURPLE
		elseif iMenuSelectTattoo == 3
			tattoo.EmissiveColor = CONST_PINK
			tattoo.TintColor = CONST_PINK
		elseif iMenuSelectTattoo == 4
			tattoo.EmissiveColor = 0xFFFFFF
			tattoo.TintColor = CUSTOM_TATT			
		elseif iMenuSelectTattoo == 5
			tattoo.EmissiveColor = 0xFFFFFF
			tattoo.TintColor = 0			
		endif
		tattoo.tattooMCMSetting = iMenuSelectTattoo
		tattoo.RefreshTattoo()			
	endif
	if bNiOverridePresent
		
		LielleDynamicWarpaintProto paint = LielleDynamicAppearance.GetAlias(0) as LielleDynamicWarpaintProto
		
		if iMenuSelectWarpaint == 1
			paint.TintColor = CONST_RED
		elseif iMenuSelectWarpaint == 2
			paint.TintColor = CONST_PURPLE
		elseif iMenuSelectWarpaint == 3
			paint.TintColor = CONST_PINK
		elseif iMenuSelectWarpaint == 4
			paint.TintColor = CUSTOM_PAINT
		elseif iMenuSelectWarpaint == 5
			paint.TintColor = 0x000000
		endif
		if bWarpaintGlow
			paint.EmissiveMultiple = 1.0
		else
			paint.EmissiveMultiple = 0.0
		endif		
		paint.warpaintMCMSetting = iMenuSelectWarpaint
		paint.StartWarpaint()
	endif
	
	; Disabling option flag for Lielle's Nightmare
	if bNightmareOptDisable
		flag_NightmareOption = OPTION_FLAG_DISABLED
	else
		flag_NightmareOption = OPTION_FLAG_NONE
	endIf

endEvent

Function SetDebug(bool bState)
	
	(LielleDynamicAppearance.GetAlias(0) as LielleDynamicWarpaintProto).DebugMode = bState
	(LielleDynamicAppearance.GetAlias(0) as LielleTattooGlowProto).DebugMode = bState

endFunction
