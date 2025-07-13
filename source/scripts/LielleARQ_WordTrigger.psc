Scriptname LielleARQ_WordTrigger  extends ReferenceAlias

Quest Property LielleARQWord Auto

Quest Property MQ105Ustengrav Auto

Location Property HighHrothgarLocation Auto


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if akOldLoc == HighHrothgarLocation && MQ105Ustengrav.IsCompleted()
		RegisterForTrackedStatsEvent()
		LielleARQWord.Start()
	endif
	
EndEvent 

Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)
	if (asStatFilter == "Words of Power Learned")		
		LielleARQWord.stop()
		LielleARQWord.start()
	endif
EndEvent