Scriptname LielleMCMCore extends ski_configbase  


LielleCoreScript Property Core Auto

LielleCoreARQ Property CoreARQ Auto

LielleXOScript Property CoreXO Auto

LielleStudyRankScript Property StudyRank Auto

LielleOutfitScript Property Outfits Auto

LielleFollowerScript Property Follower Auto

Quest Property LielleCSQMain Auto

GlobalVariable Property LielleIsGYHInstalled Auto

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

Quest Property MG02 auto
Quest Property DA09 auto 
Quest Property DA14 auto
Quest Property DA07 auto
Quest Property dunGauldursonQST auto
Quest Property LielleARQMain auto
Quest Property LielleCSQmg auto
Quest Property DA13 auto
Quest Property DLC2TT1 auto

ObjectReference Property LielleARQTelMithrynMarker Auto

int iToggleTeleport_B

bool bToggleTeleport = false

int iToggleCombat_B

bool bToggleCombat = false

int iToggleAI_B

bool bToggleAI = false

int iToggleNightmareTAME_B

bool bToggleNightmareTAME = true

int iToggleHealing 

bool bHealingNative = true

int iToggleVerbose

bool bToggleVerbose = true

int iToggleDev 

bool bToggleDev = false

int iToggleDawn 

int iToggleRose

int iToggleRose2

int iToggleRazor

int iToggleGauldP

int iToggleGauld

int iToggleSpellb

int iToggleSkip

int iSliderXO_F

float SliderXOValue

int iDebugToggleOpt_B




bool bToggleSkip = false
bool bToggleDawn = false
bool bToggleRose = false
bool bToggleRose2 = false
bool bToggleRazor = false
bool bToggleGauldP = false
bool bToggleGauld	 = false
bool bToggleSpellb = false

bool bNightmareOptDisable = false
bool bDebugToggle = false

int function GetVersion()
	return 51
endFunction

event OnVersionUpdate(int a_version)
	if (a_version > CurrentVersion)
		Core.Msg("LielleCore: Updated to " + Core.LielleVersion())
		OnConfigInit()
	endif
EndEvent


Event OnConfigInit()
	ModName = "Lielle - Rose of the North"
	Pages = New String[5]
	Pages[0] = "Settings"
	Pages[1] = "Arcane Research"
	Pages[2] = "Credits"
	Pages[3] = "Integrations"
	DebugOption()
EndEvent

Function DebugOption()
	if bDebugToggle 
		Pages[4] = "Advanced"
	else 
		Pages[4] = none
	endif
endFunction


Event OnPageReset(string Page)
	if page == ""
		LoadCustomContent("lielle//Logo.dds")
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
		iDebugToggleOpt_B = AddToggleOption("Full Debug Options:", bDebugToggle)
		iToggleTeleport_B = AddToggleOption("Teleport to Player",bToggleTeleport)
		iToggleCombat_B = AddToggleOption("Reset Combat State", bToggleCombat)
		iToggleAI_B = AddToggleOption("Reset AI" , bToggleAI)
		
		AddEmptyOption()
		iToggleVerbose = AddToggleOption("Verbose Messages", bToggleVerbose)
		
		int flags
		
		if bNightmareOptDisable
			flags = OPTION_FLAG_DISABLED
		else
			flags = OPTION_FLAG_NONE
		endIf
		iToggleNightmareTAME_B = AddToggleOption("Altered Nightmare", bToggleNightmareTAME, flags)
	
		iToggleHealing = AddToggleOption("Healer's Trace and Player Healing", bHealingNative)

	
		
	
		SetCursorPosition(1)
		AddHeaderOption("Lielle's	Stats")
	
		AddEmptyOption()
		AddTextOption("Current Actor Level: ", (LielleAlias.GetActorReference()).GetLevel())
		AddTextOption("Health: ", (LielleAlias.GetActorReference()).GetAV("Health") as int)
		AddTextOption("Magicka: ", (LielleAlias.GetActorReference()).GetAV("Magicka") as int)
		AddTextOption("Stamina: ", (LielleAlias.GetActorReference()).GetAV("Stamina") as int)
		AddEmptyOption()
		
		AddTextOption("Affection Value: " , CoreXO.LielleXOVar)

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
		AddTextOption("Field Work: ", GetQuestStatus(LielleARQLab))
		AddTextOption("Word Walls: ", GetQuestStatus(LielleARQWord))
		AddTextOption("Aetherium: ", GetQuestStatus(LielleARQAether))
		AddTextOption("Blackreach:", GetQuestStatus(LielleARQBlackreach))
		AddTextOption("Azura's/Black Star: ", GetQuestStatus(LielleARQStar))
		
		SetCursorPosition(1)
		AddHeaderOption("Research Stats")
		AddEmptyOption()
		AddTextOption("Current Research Status: " , CoreARQ.GetStatus())
		AddTextOption("Study Rank: " , StudyRank.getRank())
		AddTextOption("Research Quests Completed: " , CoreARQ.LielleARQCount)

	elseif page == "Advanced" 
		SetCursorPosition(0)
		SetCursorFillMode(TOP_TO_BOTTOM)
		  	
		iToggleSkip = AddToggleOption("Skip Intro Dialogue", bToggleSkip)
		iSliderXO_F = AddSliderOption("Affection Adjustment", CoreXO.LielleXOVar,"{4}")
		AddEmptyOption()
		AddHeaderOption("ARQ Testing")
		iToggleDawn = AddToggleOption("Dawnbreaker", bToggleDawn)
		iToggleRose = AddToggleOption("Sanguine Rose", bToggleRose)
		iToggleRose2= AddToggleOption("Sanguine Rose Pt2", bToggleRose2)
		iToggleRazor = AddToggleOption("Mehrune's Razor", bToggleRose)
		iToggleGauldP = AddToggleOption("Saarthal Gauldur Fragment", bToggleGauldP)
		iToggleGauld = AddToggleOption("Reforged Gauldur Amulet",  bToggleGauld)
		iToggleSpellb = AddToggleOption("Spellbreaker", bToggleSpellb)
		
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
		SetCursorPosition(1) 
				
		AddEmptyOption()
		AddHeaderOption("Character Assets and Outfits")
		AddTextOption("KS Hairdos by Kalilies", none)
		AddTextOption("Fair Skin Complexion by HHaleyy", none)
		AddTextOption("Women of Skyrim SE by Shiva182", none)
		AddTextOption("UNP Tattoos", none)
		AddTextOption("Frecklemania 2 by tetrodoxin", none)
		AddTextOption("Caliente's Beautiful Bodies Edition", none)
		AddTextOption("CBBE 3BA by Acro748", none)
		AddTextOption("Osare Culort Outfit by anano feat. Zynxx", none)
		AddTextOption("Ashara Imperial Outfit", none)
		AddEmptyOption()
		AddHeaderOption("Tools and Software")
		AddTextOption("Mod Organizer 2", none)
		AddTextOption("Creation Kit Platform Extended", none) 
		AddTextOption("xEdit", none)
		AddTextOption("BSA Browser", none)
		AddTextOption("Paint.NET", none)
		AddTextOption("Notepad++", none)
		AddTextOption("Audacity", none)
		AddTextOption("BodySlide and Outfit Studio", none)
		AddTextOption("Blender", none)
		AddTextOption("Claude.ai (Scripting and Implementation)", none)
		AddEmptyOption()
		
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
		AddTextOption("Dwemer Researcher: ", CheckIntegration(Outfits.LielleOutfitResearcher))
		AddTextOption("Cloaks of Skyrim: " , CheckIntegration(Outfits.LielleOutfitCloak))
		AddTextOption("KS Hairdos Wigs: ", CheckIntegration(none,none, Outfits.bWigsFound))
		AddTextOption("KS Jewelry: ", CheckIntegration(none,none, Outfits.bWeddingItemsAdded))
		AddEmptyOption()
		AddHeaderOption("Systems Integrations")
		
		AddTextOption("I'm Glad You're Here:", CheckIntegration(LielleIsGYHInstalled))
		AddTextOption("Mfg Fix NG:", CheckIntegration(none,none,((CoreXO as Quest) as LielleEmotionManager).bMfgFixPresent))
		
		
		SetCursorPosition(1)
		AddHeaderOption("Character Interactions")
		AddTextOption("Rumarin: ", CheckIntegration(none,(LielleCSQMain.GetAlias(3) as ReferenceAlias)))
		AddTextOption("Anum-La: ", CheckIntegration(none,(LielleCSQMain.GetAlias(5) as ReferenceAlias)))
		AddTextOption("Mugnor: ", CheckIntegration(none,(LielleCSQMain.GetAlias(11) as ReferenceAlias)))
		AddTextOption("Sofia: ", CheckIntegration(none,(LielleCSQMain.GetAlias(8) as ReferenceAlias)))
		AddTextOption("Inigo: ", CheckIntegration(none,(LielleCSQMain.GetAlias(7) as ReferenceAlias)))
				
	endif
		
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
	
	if option == iToggleNightmareTAME_B
		SetInfoText("DEFAULT: ON. Changes scenes in Lielle's Nightmare to omit senstive content. Discretion advised. This choice will also be presented via dialogue during Lielle's Secret. This option will disable on starting Lielle's Secret.")
	elseif option == iToggleHealing
		SetInfoText("DEFAULT: ON. This option enables healing for player and Lielle. Disable if you use a mod that adds this feature.")
	elseif option == iToggleVerbose
		SetInfoText("DEFAULT: ON. This option enables verbose message notifications for various core systems.")
	elseif option == iToggleAI_B
		SetInfoText("Reset Lielle's basic AI packages. Try when forcegreets are broken")
	elseif option == iToggleCombat_B
		SetInfoText("Attempts to disengage Lielle from combat. Might not work")
	elseif option == iToggleTeleport_B
		SetInfoText("Moves Lielle to your location. May break quests.")
	endif
endEvent

Event OnOptionSelect(int option)
	
	if option == iToggleCombat_B
		SetToggleOptionValue(option,true)
		if (LielleAlias.GetActorReference()).IsInCombat()
			(LielleAlias.GetActorReference()).StopCombat()
		endif
		SetToggleOptionValue(option,false)
		
	
	elseif option == iToggleTeleport_B
		SetToggleOptionValue(option,true)
		((CoreXO as Quest) as LielleTeleportScript).Summon(Game.GetPlayer(), (LielleAlias.GetActorRef()))
		;(LielleAlias.GetReference()).MoveTo(Game.GetPlayer(),10,10)
		
		SetToggleOptionValue(option,false)
	
	
	elseif option == iToggleAI_B
		SetToggleOptionValue(option,true)
		LielleAlias.GetActorReference().StopCombat()
		LielleAlias.GetActorReference().EvaluatePackage()		
		SetToggleOptionValue(option,false)
		
	
	elseif option == iToggleNightmareTAME_B
		bToggleNightmareTAME = !bToggleNightmareTAME
		Core.LielleNightmarePG = bToggleNightmareTAME
		SetToggleOptionValue(option, bToggleNightmareTAME)
				
		
	elseif option == iToggleVerbose
		bToggleVerbose = !bToggleVerbose
		Core.LielleVerbose = bToggleVerbose 
		SetToggleOptionValue(option, bToggleVerbose)
				
	elseif option == iToggleHealing
		bHealingNative = !bHealingNative
		Core.LielleNativeHeal = bHealingNative
		SetToggleOptionValue(option, bHealingNative)		
		
	elseif option == iToggleDev
		bToggleDev == !bToggleDev
		SetToggleOptionValue(option, bToggleDev)
		ForcePageReset()
		
	elseif option == iToggleSkip
		SetToggleOptionValue(option, true)
		;Set Stage on Lielle's introduction quests
		LielleARQMain.SetStage(10)
		LielleCSQmg.SetStage(31)
		SetToggleOptionValue(option, false)
		
	elseif option == iToggleDawn
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(320750), 1, true)
		;Complete Meridia's Daedric Quest
		DA09.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == iToggleRose
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(117558), 1, true)
		;Complete Sanguine's Daedric Quest
		DA14.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == iToggleRose2
				
		;Teleport player and Lielle to Tel Mythrin; complete Neloth's quest to access staff enchanter.
		Game.GetPlayer().MoveTo(LielleARQTelMithrynMarker)
		LielleAlias.GetActorRef().MoveTo(Game.GetPlayer())
		DLC2TT1.CompleteQuest()
		debug.notification("You can activate the staff enchanter to trigger the quest.")
		
		
	elseif option == iToggleRazor
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(147666), 1, true)
		;Complete Dagon's Daedric Quest
		DA07.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == iToggleGauldP
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(186202), 1, true)
		;Complete "Under Saarthal"
		MG02.CompleteQuest()
		SetToggleOptionValue(option, false)
		
	elseif option == iToggleGauld
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(186227), 1, true)
		;Complete "Forbidden Legend"
		dunGauldursonQST.CompleteQuest()
		SetToggleOptionValue(option, false)
	
	elseif option == iToggleSpellb
		SetToggleOptionValue(option, true)
		Game.GetPlayer().AddItem(Game.GetForm(286614), 1, true)
		DA13.CompleteQuest()
		SetToggleOptionValue(option, false)
		
		
	elseif (option == iDebugToggleOpt_B && CurrentPage == "Settings")
		if !bDebugToggle
			SetToggleOptionValue(option, true)			
			bDebugToggle = true
		else
			SetToggleOptionValue(option, false)
			bDebugToggle = false
		endif
		OnConfigInit()	
		Debug.MessageBox("You must close and reopen the MCM for the new page to appear.")
		;OnPageReset("Settings")
	else
		return ; Catch for any other clicks on non-setting options
	endif

endEvent

Event OnOptionSliderOpen(int option)

	if option == iSliderXO_F
		SetSliderDialogStartValue(CoreXO.LielleXOVar)
		SetSliderDialogRange(0.0,10)
		SetSliderDialogInterval(0.25)
	
	endif

EndEvent

Event OnOptionSliderAccept(int option, float value)
	if option == iSliderXO_F
		CoreXO.LielleXOVar = Value
	endif
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

endFunction
