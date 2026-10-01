Scriptname Lielle_VampTrigger extends ReferenceAlias 

; Declare relevant quest properties for vampire events
Quest Property LielleCSQdlc1vk Auto  ; Quest triggered when player is a Vampire Lord
Quest Property LielleCSQdlc1dg Auto  ; Dawnguard quest, stages modified depending on player's vampirism
Quest Property LielleCSQVampireGeneric Auto  ; Quest triggered for lesser vampire events

Lielle_VampireLordQuestScript Property Lielle_VampireLord Auto
Lielle_VampireQuestScript Property Lielle_Vampire Auto

;Quest Property DLC1VQ01MiscObjective Auto  ; Miscellaneous objective related to Vampire Lord form

ReferenceAlias Property LielleAlias Auto  ; Alias for Lielle, to reference her actor

Spell Property DLC1VampireChange Auto  ; Spell property for Vampire Lord transformation spell

LielleCoreScript Property Core Auto
string msgFlag = "LielleCore: "

Function CheckPlayerVampire(bool abVampire)
	
	if abVampire == false
		utility.wait(0.5)
		self.PlayerVampireState(false)
	endif
	
endFunction

Event OnInit()
	Core.Msg(msgFlag + "Lielle_Vampire property: " + Lielle_Vampire, false)
	if Lielle_Vampire != None
		Core.Msg(msgFlag + "Quest Initialized", false)
	else
		Core.Msg(msgFlag + "Error -- Lielle_Vampire is None in Lielle_VampTrigger! Forcing manually.", false)
		Lielle_Vampire = Game.GetFormFromFile(0x0516AB43,"Lielle.esp") as Lielle_VampireQuestScript
	endif
	
	Core.Msg(msgFlag + "Lielle_VampireLord property: " + Lielle_VampireLord, false)
	if Lielle_VampireLord != None
		Core.Msg(msgFlag + "Quest Initialized", false)
	else
		Core.Msg(msgFlag + "Error -- Lielle_VampireLord is None in Lielle_VampTrigger! Forcing manually.", false)
		Lielle_VampireLord = Game.GetFormFromFile(0x50AA6E6,"Lielle.esp") as Lielle_VampireLordQuestScript
	endif
	Core.Msg(msgFlag + "LielleCSQdlc1dg property: " + LielleCSQdlc1dg)
	if LielleCSQdlc1dg != None
		Core.Msg(msgFlag + "Quest Initialized", false)
	else
		Core.Msg(msgFlag + "Error -- LielleCSQdlc1dg is None in "+ self +"! Forcing manually.", false)
		LielleCSQdlc1dg = Game.GetFormFromFile(0x50AA6E5,"Lielle.esp") as Quest
	endif
	
EndEvent

Function PlayerVampireState(bool abIsVampire)
			
    if abIsVampire == false
        Core.Msg(msgFlag + "Telling Lielle that the player is cured.", false)
		if LielleCSQdlc1dg.isRunning() == true
			LielleCSQdlc1dg.reset()
			LielleCSQdlc1dg.SetCurrentStageID(10)  ; Update Dawnguard quest stage to reflect the cure
		endif
		if LielleCSQdlc1vk.GetStage() != 0
			Lielle_VampireLord.PlayerCure()
	
		endif
		if LielleCSQVampireGeneric.GetStage() != 0
			Lielle_Vampire.PlayerCure() ; set lesser vampire quest stage, for cure recognition
		endif
    endif
endFunction

Event OnVampireFeed(Actor akTarget)
	
	
    if akTarget == LielleAlias.GetActorReference() 
		if Game.GetPlayer().HasSpell(DLC1VampireChange)
            Core.Msg(msgFlag + "Telling Lielle that the player has fed on her as a Vampire Lord.", false)
            Lielle_VampireLord.PlayerFeed()
			
        else
            Core.Msg(msgFlag + "Telling Lielle that the player has fed on her as a lesser vampire.", false)
			Lielle_Vampire.PlayerFeed()
								
        endif
    endif
EndEvent
