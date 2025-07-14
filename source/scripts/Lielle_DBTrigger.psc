Scriptname Lielle_DBTrigger extends ReferenceAlias  


Quest Property DB01 Auto

Quest Property LielleCSQdb Auto

Location Property WindhelmAretinoResidenceLocation Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if akOldLoc == WindhelmAretinoResidenceLocation && DB01.GetStage() == 20
		LielleCSQdb.Start()
	endif
EndEvent
