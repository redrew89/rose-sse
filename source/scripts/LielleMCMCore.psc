Scriptname LielleMCMCore extends ski_configbase  

; Other script instances we might access
LielleCoreScript Property Core Auto
LielleCoreARQ Property CoreARQ Auto
LielleXOScript Property CoreXO Auto
LielleStudyRankScript Property StudyRank Auto
LielleFollowerScript Property Follower Auto
LielleEmotionManager Property Emotion Auto 
LielleOutfitScript Property Outfits Auto  

GlobalVariable Property LielleIsGYHInstalled Auto 

GlobalVariable Property Lielle_DynAppStoryMode Auto

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

Quest Property LielleDynamicAppearance Auto 
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
int 	flag_DynamicStoryMode
int 	flag_NightmareOption
int		flag_WarpaintCustom
int		flag_WarpaintGlow
int		flag_TattooCustom
int 	flag_TattooGlow
int		flag_NudeAlways

int 	opt_MenuWarpaint
int 	opt_MenuTattoo
int 	opt_WarpaintCustom
int 	opt_PaintGlow
int 	opt_TattooGlow
int 	opt_TattooCustom
int 	opt_PaintSmudge
int		opt_NudeStory
int 	opt_NudeAlways
int		opt_DynAppStoryMode

int 	opt_MenuDebugOutfit

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
int		opt_forceWife
int 	opt_ResetOutfit

bool 	bdebugDev 						= false
bool 	bHealingNative 					= true
bool 	bMsgVerbose 					= true
bool 	bNightmareAltered				= true
bool 	bNightmareOptDisable			= false
bool	bLielleDynamicAppearance 		= false
bool 	bTattooGlow						= false
bool 	Property bDynAppStoryMode		= true		Auto
bool 	Property bNiOverridePresent 	= false 	Auto
bool	Property bNudeBody				= false		Auto
bool 	Property bNudeAlways			= false		Auto

String[] 	warpaintOptions 
String[] 	tattooGlowColors

String[] 	debugOutfitsList
int 		iMenuSelectOutfit


LielleDynamicAppearanceManager Property DynAppManager
    LielleDynamicAppearanceManager Function Get()
        return LielleDynamicAppearance as LielleDynamicAppearanceManager
    EndFunction
EndProperty

int function GetVersion()
	return 471 ; Switch to modfied semantic versioning - 470 == 0.4.7.0 - incremented to 471 for testing TODO: revert on next save refresh 	
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
	Pages 		= New String[6]
	Pages[0] 	= "Settings"
	Pages[1] 	= "Arcane Research"
	Pages[2] 	= "Credits"
	Pages[3] 	= "Integrations"
	Pages[4] 	= "Dynamic Appearance"
	
	if bdebugDev 
		Pages[5] = "Advanced"
	else 
		Pages[5] = none
	endif
		
	;bLielleDynamicAppearance = SKSE.GetPluginVersion("OverlayDistributionFramework") != -1
	; 0.4.5 - Lazy loading quest from dynamic appearance test plugin - repoint in 0.5.0 - Filling unfilled script instance with a cast
	;LielleDynamicAppearance = Game.GetFormFromFile(0x94F, "Lielle-DynamicAppearanceProto.esp") as Quest
		
	if bNiOverridePresent
	
		;Core.Msg("LielleCore: Detected Overlay Distribution Framework - Enabling Dynamic Appearance 2.0",true)
		
		warpaintOptions 			= new String[6]
		warpaintOptions[0] 			= "Clean Face"
		warpaintOptions[1] 			= "Rose Red"
		warpaintOptions[2] 			= "Dwemer Purple"
		warpaintOptions[3] 			= "Lovestruck Pink"
		warpaintOptions[4] 			= "Pride Forever!"
		warpaintOptions[5] 			= "Custom Color"
		
		tattooGlowColors 			= new String[6]
		tattooGlowColors[0] 		= "Disabled"
		tattooGlowColors[1] 		= "Rose Red"
		tattooGlowColors[2] 		= "Dwemer Purple"
		tattooGlowColors[3] 		= "Lovestruck Pink"
		tattooGlowColors[4] 		= "Pride Forever!"
		tattooGlowColors[5] 		= "Custom Color"
	endif
	
	debugOutfitsList = new String[5]
	debugOutfitsList = Outfits.ReturnOutfits()
			
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
		opt_debugMenu 			= AddToggleOption("Full Debug Options:", bdebugDev)
		opt_Teleport 			= AddToggleOption("Teleport to Player:", false)
		opt_CombatReset 		= AddToggleOption("Reset Combat State:", false)
		opt_AIReset 			= AddToggleOption("Reset AI:" , false)
		
		if !bNudeBody 
			flag_NudeAlways = OPTION_FLAG_HIDDEN
		else	
			flag_NudeAlways = OPTION_FLAG_NONE
		endif
		
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
		AddTextOption("Affection Value: " , (CoreXO.LielleXOVar as String) + "{3}/" + CoreXO.MAX_CURRENT_AFFECTION)

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
		AddTextOption("Field Work: ", GetQuestStatus(LielleARQLab))
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
		opt_fAffection 			= AddSliderOption("Affection Adjustment", CoreXO.LielleXOVar,"{3}/" + CoreXO.MAX_CURRENT_AFFECTION)
		opt_forceWife			= AddTextOption("Force Marry", "I DO!")
		
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
		AddTextOption("Author"	, "Andrew Hanson 'ReDrew89'")
		AddTextOption("Supporting Writer","'Dashogi'")
		AddTextOption("Lead Level Design","SanneARBY")
		AddTextOption("Lead QA Tester","'Scorcher'")
		AddTextOption("QA Tester", "pndragon65")
		AddTextOption("QA Tester","Gorguts5")
		AddEmptyOption()
		AddHeaderOption("Voice Talent")
		AddTextOption("Lielle","Jody Sharp 'JoJoRawr'")
		AddTextOption("Three-Eyes","Milica Radovanovic 'MilicaVO'")
		AddTextOption("Malek/Marek","'youngone'")
		AddTextOption("Markus","'Vanwood'")
		AddEmptyOption()
		AddHeaderOption("Patrons")
		AddTextOption("jwisser", none)
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
		;AddTextOption("Aniya by Kenerad",none)
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
			
			
		AddHeaderOption("Spell Mods")
		AddTextOption("Apocalypse - Spells of Skyrim", CheckIntegration((LielleCSQMain.GetAlias(6) as Lielle_InCombatSpells).LielleApocalypseInstalled))
		AddTextOption("Mysticism - A Magic Overhaul", CheckIntegration((LielleCSQMain.GetAlias(6) as Lielle_InCombatSpells).LielleMysticismInstalled))
		
		
		AddHeaderOption("Outfit Integrations")
		
		AddTextOption("West Wind Misfit Mage: ", CheckIntegration(Outfits.LielleOutfitMisfit))
		AddTextOption("Modular Mage: ", CheckIntegration(Outfits.LielleOutfitAlternate))
		AddTextOption("Dwemer Researcher: ", CheckIntegration(Outfits.LielleOutfitResearcher))
		AddTextOption("Cloaks of Skyrim: " , CheckIntegration(Outfits.LielleOutfitCloak))
		AddTextOption("KS Hairdos Wigs: ", CheckIntegration(none,none, Outfits.bWigsFound))
		AddTextOption("KS Jewelry: ", CheckIntegration(none,none, Outfits.bWeddingItemsAdded))
		AddEmptyOption()
		opt_ResetOutfit = AddTextOption("Reset Current Outfit",none)
		opt_MenuDebugOutfit = AddMenuOption("Test Outfit:",debugOutfitsList[iMenuSelectOutfit])
		AddEmptyOption()
		
		AddHeaderOption("Systems Integrations")
		
		AddTextOption("I'm Glad You're Here:", CheckIntegration(LielleIsGYHInstalled))
		AddTextOption("Mfg Fix NG:", CheckIntegration(none,none,((CoreXO as Quest) as LielleEmotionManager).bMfgFixPresent))
	
		
		SetCursorPosition(1)		
		

		AddEmptyOption()
		AddHeaderOption("Character Interactions")
		AddTextOption("Rumarin: ", CheckIntegration(none,(LielleCSQMain.GetAlias(3) as ReferenceAlias)))
		AddTextOption("Anum-La: ", CheckIntegration(none,(LielleCSQMain.GetAlias(5) as ReferenceAlias)))
		;AddTextOption("Mugnor: ", CheckIntegration(none,(LielleCSQMain.GetAlias(11) as ReferenceAlias)))
		AddTextOption("Sofia: ", CheckIntegration(none,(LielleCSQMain.GetAlias(8) as ReferenceAlias)))
		AddTextOption("Inigo: ", CheckIntegration(none,(LielleCSQMain.GetAlias(7) as ReferenceAlias)))

	elseif page == "Dynamic Appearance"
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)	
		
		AddHeaderOption("Dynamic Appearance", flag_DynamicAppearance)
		AddTextOption("RaceMenu: ", CheckIntegration(none, none, bNiOverridePresent), flag_DynamicAppearance)
		
		opt_NudeStory			= AddToggleOption("Story-based Nudity", bNudeBody)
		opt_NudeAlways			= AddToggleOption("Always Nude", bNudeAlways,flag_NudeAlways)
		; Dynamic Appearance setup
		bool bDynamicAppearanceAvailable = bNiOverridePresent 

		; Determine flag for main menus based on Story Mode
		int flag_MainMenus
		if !bDynamicAppearanceAvailable
			flag_MainMenus = OPTION_FLAG_HIDDEN
			flag_DynamicAppearance = OPTION_FLAG_HIDDEN
			flag_DynamicStoryMode = OPTION_FLAG_HIDDEN
		elseif bDynAppStoryMode
			flag_MainMenus = OPTION_FLAG_DISABLED
			flag_DynamicAppearance = OPTION_FLAG_NONE
			flag_DynamicStoryMode = OPTION_FLAG_NONE
		else
			flag_MainMenus = OPTION_FLAG_NONE
			flag_DynamicAppearance = OPTION_FLAG_NONE
			flag_DynamicStoryMode = OPTION_FLAG_NONE
		endif

		; Set flags for sub-options
		if !bDynamicAppearanceAvailable
			; Hide everything if RaceMenu not present
			flag_WarpaintGlow = OPTION_FLAG_HIDDEN
			flag_WarpaintCustom = OPTION_FLAG_HIDDEN
			flag_TattooGlow = OPTION_FLAG_HIDDEN
			flag_TattooCustom = OPTION_FLAG_HIDDEN
		elseif bDynAppStoryMode
			; Story Mode ON: Disable all options
			flag_WarpaintGlow = OPTION_FLAG_DISABLED
			flag_WarpaintCustom = OPTION_FLAG_DISABLED
			flag_TattooGlow = OPTION_FLAG_DISABLED
			flag_TattooCustom = OPTION_FLAG_DISABLED
		else
			; Story Mode OFF: Enable options based on selections
			if DynAppManager.iMenuSelectWarpaint != 0
				flag_WarpaintGlow = OPTION_FLAG_NONE
			else
				flag_WarpaintGlow = OPTION_FLAG_DISABLED
			endif

			if DynAppManager.iMenuSelectWarpaint == 5
				flag_WarpaintCustom = OPTION_FLAG_NONE
			else
				flag_WarpaintCustom = OPTION_FLAG_DISABLED
			endif

			if DynAppManager.iMenuSelectTattoo != 0
				flag_TattooGlow = OPTION_FLAG_NONE
			else
				flag_TattooGlow = OPTION_FLAG_DISABLED
			endif

			if DynAppManager.iMenuSelectTattoo == 5
				flag_TattooCustom = OPTION_FLAG_NONE
			else
				flag_TattooCustom = OPTION_FLAG_DISABLED
			endif
		endif
		SetCursorPosition(1)
		opt_DynAppStoryMode = AddToggleOption("Story Mode:", bDynAppStoryMode, flag_DynamicStoryMode)
		AddEmptyOption()

		; Main menus and toggles use flag_MainMenus (disabled when Story Mode is on)
		opt_PaintGlow = AddToggleOption("Dynamic Warpaint Glow:", DynAppManager.bWarpaintGlow, flag_WarpaintGlow)		
		opt_MenuWarpaint = AddMenuOption("Dynamic Warpaint:", warpaintOptions[DynAppManager.iMenuSelectWarpaint], flag_MainMenus)		
		opt_WarpaintCustom = AddColorOption("Custom Color: ", DynAppManager.CUSTOM_PAINT, flag_WarpaintCustom)
		opt_TattooGlow	= AddToggleOption("Tattoo Glow: ", DynAppManager.bTattooGlow, flag_TattooGlow)
		opt_MenuTattoo = AddMenuOption("Dynamic Tattoo Accent:", tattooGlowColors[DynAppManager.iMenuSelectTattoo], flag_MainMenus)
		opt_TattooCustom = AddColorOption("Custom Color: ", DynAppManager.CUSTOM_TATT, flag_TattooCustom)

	endif
	
	RegisterForSingleUpdate(0.2)
		
endEvent

Event OnOptionMenuOpen(int option)
	if option == opt_MenuWarpaint
		if warpaintOptions && warpaintOptions.Length > 0
			SetMenuDialogOptions(warpaintOptions)
			SetMenuDialogStartIndex(DynAppManager.iMenuSelectWarpaint)
			SetMenuDialogDefaultIndex(1)
		endif
	elseif option == opt_MenuTattoo
		if tattooGlowColors && tattooGlowColors.Length > 0
			SetMenuDialogOptions(tattooGlowColors)
			SetMenuDialogStartIndex(DynAppManager.iMenuSelectTattoo)
			SetMenuDialogDefaultIndex(1)
		endif
	elseif option == opt_MenuDebugOutfit
		if debugOutfitsList && debugOutfitsList.Length > 0
			SetMenuDialogOptions(debugOutfitsList)
			SetMenuDialogStartIndex(iMenuSelectOutfit)
			SetMenuDialogDefaultIndex(0)
		endif
	endif	
endEvent


Event OnOptionColorAccept(int option, int value)
	if option == opt_WarpaintCustom
		DynAppManager.CUSTOM_PAINT = value
		DynAppManager.SetWarpaint(5, value, DynAppManager.bWarpaintGlow)
	elseif option == opt_TattooCustom
		DynAppManager.CUSTOM_TATT = value
		DynAppManager.SetTattoo(5, value)
	endif	
	ForcePageReset()
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if index < 0
		return
	endif
	
	if option == opt_MenuWarpaint
		if warpaintOptions && index < warpaintOptions.Length
			SetMenuOptionValue(opt_MenuWarpaint, warpaintOptions[index])
			DynAppManager.SetWarpaint(index, DynAppManager.CUSTOM_PAINT, DynAppManager.bWarpaintGlow)
		endif
	elseif option == opt_MenuTattoo
		if tattooGlowColors && index < tattooGlowColors.Length
			SetMenuOptionValue(opt_MenuTattoo, tattooGlowColors[index])
			DynAppManager.SetTattoo(index, DynAppManager.CUSTOM_TATT)
		endif
	elseif option == opt_MenuDebugOutfit
		if debugOutfitsList && index < debugOutfitsList.Length
			SetMenuOptionValue(opt_MenuDebugOutfit, debugOutfitsList[index])
			if index == 0 
				Outfits.SetOutfitDefault(false)
			elseif index == 1
				Outfits.SetOutfitWedding()
			elseif index == 2
				Outfits.SetOutfitMisfit()
			elseif index == 3
				Outfits.SetOutfitResearcher()
			elseif index == 4
				Outfits.SetOutfitDefault(true)
			endif
		endif
	endif
	
	ForcePageReset()
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
	elseif option == opt_NudeStory
		SetInfoText("By default, Lielle has undergarments. Enable this setting to allow optional full nudity in certain scenes.")
	elseif option == opt_NudeAlways
		SetInfoText("By default, Lielle has undergarments. Enable this setting to override.")
	endif
	
endEvent

Event OnOptionSelect(int option)
	
	if option == opt_CombatReset
		SetToggleOptionValue(option,true,false)
		if (LielleAlias.GetActorReference()).IsInCombat()
			(LielleAlias.GetActorReference()).StopCombat()
		endif
		SetToggleOptionValue(option,false,false)		
	
	elseif option == opt_ResetOutfit
		((Outfits as Quest).GetAlias(0) as LielleOutfitDetectScript).CheckCurrentOutfit()
	elseif option == opt_Teleport
		SetToggleOptionValue(option,true,false)
		((CoreXO as Quest) as LielleTeleportScript).Summon(Game.GetPlayer(), (LielleAlias.GetActorRef())) 
		;(LielleAlias.GetReference()).MoveTo(Game.GetPlayer(),100,100)		
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
		bMsgVerbose = !bMsgVerbose
		Core.LielleVerbose = bMsgVerbose
		SetToggleOptionValue(option, bMsgVerbose,false)
				
	elseif option == opt_NativeHeal
		bHealingNative = !bHealingNative
		Core.LielleNativeHeal = bHealingNative
		SetToggleOptionValue(option, bHealingNative,false)	
		
	elseif option == opt_PaintGlow
		DynAppManager.bWarpaintGlow = !DynAppManager.bWarpaintGlow
		SetToggleOptionValue(option, DynAppManager.bWarpaintGlow, false)
		DynAppManager.SetWarpaint(DynAppManager.iMenuSelectWarpaint, DynAppManager.CUSTOM_PAINT, DynAppManager.bWarpaintGlow)
	elseif option == opt_TattooGlow
		DynAppManager.bTattooGlow = !DynAppManager.bTattooGlow
		SetToggleOptionValue(option, DynAppManager.bTattooGlow, false)
		DynAppManager.SetTattoo(DynAppManager.iMenuSelectTattoo, DynAppManager.CUSTOM_TATT, DynAppManager.bTattooGlow)
		
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
		
	elseif option == opt_debugMenu
		bdebugDev = !bdebugDev
		SetToggleOptionValue(option, bdebugDev,false)		
		SetDebug(bdebugDev)
		OnConfigInit()
		Debug.MessageBox("You must close and reopen the MCM for the new page to appear.")	

	elseif option == opt_DynAppStoryMode
		bDynAppStoryMode = !bDynAppStoryMode
		SetToggleOptionValue(option, bDynAppStoryMode, false)
		Lielle_DynAppStoryMode.SetValueInt(bDynAppStoryMode as int)
		
		DynAppManager.SetStoryMode(bDynAppStoryMode)
		
		if bDynAppStoryMode && bMsgVerbose
			Core.Msg(DynAppManager.msgFlag + "Dynamic Appearance reset to story defaults.",false)
		endif
		
	elseif option == opt_NudeAlways
		bNudeAlways = !bNudeAlways
		SetToggleOptionValue(option, bNudeAlways, false)
		if bNudeAlways
			Outfits.SetBody(2)
		else
			Outfits.SetBody(1)
		endif
		
	elseif option == opt_NudeStory
		bNudeBody = !bNudeBody
		SetToggleOptionValue(option, bNudeBody, false)
		if bNudeBody
			Outfits.SetBody(1)
		else
			Outfits.SetBody(0)
		endif
	
	elseif option == opt_forceWife 	
		Actor Lielle = LielleAlias.GetActorRef()
		if Lielle.GetRelationshipRank(Game.GetPlayer()) != 4
			CoreXO.Marry()
			SetTextOptionValue(option, "NOW AND FOREVER")
		endif
	endif

	ForcePageReset()
	

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
	
	if bNiOverridePresent && DynAppManager
		; Just call the manager functions
		DynAppManager.SetWarpaint(DynAppManager.GetWarpaintSelection(), DynAppManager.GetCustomPaintColor(), DynAppManager.GetWarpaintGlow())
		DynAppManager.SetTattoo(DynAppManager.GetTattooSelection(), DynAppManager.GetCustomTattColor())
	endif
	
	; Handle nightmare option flag
	if bNightmareOptDisable
		flag_NightmareOption = OPTION_FLAG_DISABLED
	else
		flag_NightmareOption = OPTION_FLAG_NONE
	endIf
	
	ForcePageReset()
endEvent

Function SetDebug(bool bState)
	
	; Stub

endFunction
