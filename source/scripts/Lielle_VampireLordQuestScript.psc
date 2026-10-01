Scriptname Lielle_VampireLordQuestScript extends Quest  


Quest Property LielleCSQdlc1dg auto

GlobalVariable Property LielleVampireFeedCount Auto

Event OnInit()

	Debug.Trace("LielleCSQdlc1dg property: " + LielleCSQdlc1dg)
	if LielleCSQdlc1dg != None
		debug.trace("Quest Initialized")
	else
		Debug.Trace("Error: LielleCSQdlc1dg is None in "+ self +"! Forcing manually.")
		LielleCSQdlc1dg = Game.GetFormFromFile(0x50AA6E5,"Lielle.esp") as Quest
	endif
EndEvent


Function PlayerFeed()

	if (GetStage() != 0 && GetStage() != 20) && LielleVampireFeedCount.GetValueInt() == 0 
		Reset()
		SetStage(20)
		LielleVampireFeedCount.SetValueInt(LielleVampireFeedCount.GetValueInt() + 1)
	elseif (GetStage() != 30) || LielleVampireFeedCount.GetValueInt() == 1
		Reset()
		SetStage(30)
		LielleVampireFeedCount.SetValueInt(LielleVampireFeedCount.GetValueInt() + 1)
	elseif LielleVampireFeedCount.GetValueInt() == 2
		LielleVampireFeedCount.SetValueInt(LielleVampireFeedCount.GetValueInt() + 1)
	endif
	if LielleVampireFeedCount.GetValueInt() >= 3
		debug.trace(self + ": Lielle has been fed on atleast 3 times. Launching LielleCSQFlee via Story Manager.")
	endif
	
EndFunction

Function PlayerCure()

	debug.trace(self + ": Telling Lielle that the player is cured.")
		if LielleCSQdlc1dg.isRunning() == true
			LielleCSQdlc1dg.reset()
			LielleCSQdlc1dg.SetCurrentStageID(10)  ; Update Dawnguard quest stage to reflect the cure
		endif
		if GetStage() != 0
			reset()
			stop()
			SetCurrentStageID(0)
	
		endif

EndFunction
