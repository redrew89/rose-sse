Scriptname LielleARQWordTrigger extends ReferenceAlias  

Location Property HighHrothgarLocation Auto

Quest Property MQ105Ustengrav Auto

Quest Property LielleARQWord Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if akOldLoc == HighHrothgarLocation && MQ105Ustengrav.IsCompleted()
		LielleARQWord.Start()
	endif
EndEvent

Event OnLoad()

	RegisterForTrackedStatsEvent()

EndEvent

Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)
	if asStatFilter == "Words of Power Learned" && LielleARQWord.IsRunning()
		LielleARQWord.Stop()
		LielleARQWord.Start()
		LielleARQWord.SetStage(20)
	endif
EndEvent 