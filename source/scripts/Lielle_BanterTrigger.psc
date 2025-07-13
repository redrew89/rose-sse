Scriptname Lielle_BanterTrigger extends ReferenceAlias

;/ Adapted from portions of jr_modchecker in Lucien /;


ReferenceAlias Property Rumarin3D Auto

ReferenceAlias Property AnumLa3D Auto

ReferenceAlias Property Mugnor3D Auto

ReferenceAlias Property InigoAlias Auto

ReferenceAlias Property SofiaAlias Auto

ReferenceAlias Property Lielle_Alias Auto

Quest Property LielleCSQBanter02 Auto

Quest Property LielleCSQ_GYH Auto

LielleCoreScript Property Core Auto

GlobalVariable Property LielleIsGYHInstalled Auto

string msgFlag = "LielleCore - Integrations: "

Function OnLoad()

	self.CheckAllMods()
	LielleCSQBanter02.Start()
EndFunction



Function GYHCompatCheck()
	if(Game.GetModByName("ImGladYoureHere.esp") != 255 && LielleIsGYHInstalled.GetValueInt() == 0)
		Faction disableMainFac = Game.GetFormFromFile(0x0027108d, "ImGladYoureHere.esp") as Faction
		(Lielle_Alias.GetActorRef()).AddToFaction( disableMainFac)
	
		
		LielleCSQ_GYHScript hugscript = LielleCSQ_GYH as LielleCSQ_GYHScript
        hugscript.WW42HugFollower = Game.GetFormFromFile(0x00000d62, "ImGladYoureHere.esp") as Quest
        
        LielleIsGYHInstalled.SetValueInt(1)
		
		Core.Msg(msgFlag + "IGYH Detected")
    elseif(Game.GetModByName("ImGladYoureHere.esp") == 255 && LielleIsGYHInstalled.GetValueInt() == 1)
        LielleIsGYHInstalled.SetValueInt(0)
		Core.Msg(msgFlag + "IGYH Removed")
    endif
EndFunction

Function ModCheck(ReferenceAlias raFollowerAlias, Int aiFormID, String asFileName)

	if raFollowerAlias.getref() == none
		if game.GetFormFromFile(aiFormID, asFileName)
			ObjectReference FollowerRef = Game.GetFormFromFile(aiFormID, asFileName) as ObjectReference
			raFollowerAlias.ForceRefTo(FollowerRef)
			Core.Msg(msgFlag + FollowerRef.GetBaseObject().GetName() +" detected.")
		endIf
	endIf
EndFunction

Function CheckAllMods()
	
	Core.Msg(msgFlag + "Checking for compatible content. Stand by.")
	self.GYHCompatCheck()
	(Lielle_Alias as Lielle_InCombatSpells).InitializeSpellLists()
	
	
	self.ModCheck(Rumarin3D, 702188, "3DNPC.esp")
	self.ModCheck(AnumLa3D, 169157, "3DNPC.esp")
	self.ModCheck(InigoAlias, 35561, "Inigo.esp")
	self.ModCheck(Mugnor3D, 812013, "3DNPC.esp")
	self.ModCheck(SofiaAlias, 6183, "SofiaFollower.esp")
	
EndFunction