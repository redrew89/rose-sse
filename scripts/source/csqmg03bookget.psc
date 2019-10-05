Scriptname CSQMG03BookGet Extends ReferenceAlias

ReferenceAlias Property LielleMG03Alias Auto

Actor Property Lielle Auto

Book Property MG03Book01 Auto

Event OnInit()
	AddInventoryEventFilter(MG03Book01)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	If	akBaseItem == MG03Book01
		LielleMG03Alias.ForceRefTo(Lielle)
	EndIf
	
EndEvent
