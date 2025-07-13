Scriptname Lielle_MQTrigger extends ReferenceAlias  

Location Property HelgenLocation Auto

Location Property RiverwoodLocation	Auto

Quest Property MQ101 Auto

Quest Property LielleCSQmq Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if (MQ101.IsCompleted()) && (akOldLoc == HelgenLocation || akOldLoc == RiverwoodLocation)
		LielleCSQmq.Start()
	endif

endEvent