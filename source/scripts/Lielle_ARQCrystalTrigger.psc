Scriptname Lielle_ARQCrystalTrigger  extends ReferenceAlias


Location Property BlackreachLocation  Auto  

ReferenceAlias Property CrystalAlias Auto

Quest Property LielleARQBlackreach Auto

GlobalVariable Property _ARQAetherCount Auto

GlobalVariable Property _ARQAetherTotal Auto


Event OnCellLoad()
	if (_ARQAetherCount.GetValueInt() < _ARQAetherTotal.GetValueInt()) && LielleARQBlackreach.IsActive() && GetActorReference().GetCurrentLocation() == BlackreachLocation
		LielleARQBlackreach.stop()
		Utility.wait(0.1)
		LielleARQBlackreach.start()
	endif
endEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if (akNewLoc == BlackreachLocation) && !(LielleARQBlackreach.IsActive()) && (_ARQAetherCount.GetValueInt() == 0)
		LielleARQBlackreach.start()
	endif
endEvent
