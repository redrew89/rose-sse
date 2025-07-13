Scriptname Lielle_DA04SceneTrigger extends ReferenceAlias  


MiscObject Property DA04DweLexiconCubeBlank01 Auto

Quest Property DA04 Auto

Scene Property LielleDA04Scene Auto

Event OnInit()

	AddInventoryEventFilter(DA04DweLexiconCubeBlank01)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	
	if akBaseItem == DA04DweLexiconCubeBlank01 && DA04.IsRunning()
		LielleDA04Scene.Start()
	endif
	
EndEvent