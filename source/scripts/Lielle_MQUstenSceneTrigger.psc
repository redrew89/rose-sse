Scriptname Lielle_MQUstenSceneTrigger extends ReferenceAlias  

Book Property MQ105Note Auto

Scene Property LielleCSQmqUstenScene Auto

Event OnInit()

	AddInventoryEventFilter(MQ105Note)

EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == MQ105Note
		LielleCSQmqUstenScene.Start()
		RemoveInventoryEventFilter(MQ105Note)
	endif
EndEvent