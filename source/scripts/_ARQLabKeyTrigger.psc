Scriptname _ARQLabKeyTrigger extends ReferenceAlias 


Key Property MnzeftLiftKey Auto

Quest Property LielleARQLab Auto

Event OnInit()
	AddInventoryEventFilter(MnzeftLiftKey)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == MnzeftLiftKey
		LielleARQLab.SetStage(7)
	else
		return
	endif
EndEvent


 