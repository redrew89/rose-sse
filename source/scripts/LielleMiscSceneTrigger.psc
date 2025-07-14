Scriptname LielleMiscSceneTrigger extends ReferenceAlias  


Formlist Property LielleCSQObjects Auto

Scene Property SHBScene1 Auto

Scene Property SHBScene2 Auto

Quest Property FreeformIvarstead01 Auto


Event OnInit()
	AddInventoryEventFilter(LielleCSQObjects)
EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	if akBaseItem.GetFormID() == 891755 && FreeformIvarstead01.IsRunning()
		SHBScene1.Start()
	elseif akBaseItem.GetFormID() == 418775 && FreeformIvarstead01.IsRunning()
		SHBScene2.Start()
	endif
	
EndEvent
