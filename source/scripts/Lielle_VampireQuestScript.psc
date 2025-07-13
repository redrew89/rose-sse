Scriptname Lielle_VampireQuestScript extends Quest  



GlobalVariable Property LielleVampireFeedCount Auto


Function PlayerFeed()
	debug.trace(self + ": Telling Lielle that the player has fed on her as a lesser vampire.")
	if LielleVampireFeedCount.GetValueInt() == 0
		if GetStage() != 20
			SetStage(20)  ; Update lesser vampire quest stage - first feeding
		endif
		LielleVampireFeedCount.SetValueInt(1)
		;debug.notification("Lielle is aware of what you've done.")
	elseif LielleVampireFeedCount.GetValueInt() == 1
		if GetStage() != 30
			SetStage(30) ; Repeat feeding 
		endif
		LielleVampireFeedCount.SetValueInt(2)
		;debug.notification("Lielle is aware of what you've done.")
	elseif LielleVampireFeedCount.GetValueInt() == 2
		LielleVampireFeedCount.SetValueInt(3)
	endif
	if LielleVampireFeedCount.GetValueInt() >= 3
		debug.trace(self + ": Lielle has been fed on atleast 3 times. Launching LielleCSQFlee via Story Manager.")
	endif
EndFunction

Function PlayerCure()

	if GetStage() != 0
		SetStage(40)  ; set lesser vampire quest stage, for cure recognition
		;debug.notification("Lielle sees that you've changed.")
		 
	endif
	
EndFunction
