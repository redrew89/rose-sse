Scriptname Lielle_MQ104SceneTrigger extends ReferenceAlias  

Quest Property MQ104 Auto

Quest Property DA04 Auto

Scene Property LielleMQScene1 Auto

Scene Property LielleMQScene2 Auto

Location Property WhiterunDragonsreachLocation Auto

Location Property SeptimusSignusOutpostLocation Auto


Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if akOldLoc == WhiterunDragonsreachLocation && MQ104.GetStage() == 40
		LielleMQScene1.Start()
		
	elseif akOldLoc == SeptimusSignusOutpostLocation && DA04.GetStage() == 20
		LielleMQScene2.Start()
	endif
EndEvent

