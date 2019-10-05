Scriptname LielleARQDawnDetector extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(da09Dawnbreaker)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	LielleARQDawn.Start()
EndEvent

Quest Property LielleARQDawn Auto

Weapon Property da09Dawnbreaker Auto
