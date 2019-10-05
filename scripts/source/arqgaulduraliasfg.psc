Scriptname ARQGauldurAliasFG extends ReferenceAlias  

Event OnInit()
	;debug.Notification("Keeping an eye out for important things.")
	AddInventoryEventFilter(dunFolgunthurJournal1)
	AddInventoryEventFilter(dunGauldurAmulet)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	;debug.Notification("You found a thing! Lielle has something to say about it!")
	LielleFGAlias.ForceRefIfEmpty(Lielle)
	Lielle.EvaluatePackage()
	;debug.Notification("Lielle's current package is " + Lielle.GetCurrentPackage())
EndEvent

Actor Property Lielle  Auto  

ReferenceAlias Property LielleFGAlias  Auto  

Armor Property dunGauldurAmulet Auto

Book Property dunFolgunthurJournal1 Auto
