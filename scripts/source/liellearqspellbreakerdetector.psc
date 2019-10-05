Scriptname LielleARQSpellbreakerDetector extends ReferenceAlias  

Event OnInit()
	AddInventoryEventFilter(da13Spellbreaker)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	LielleARQSpellbreak.Start()
EndEvent

Quest Property LielleARQSpellbreak Auto

Armor Property da13Spellbreaker Auto
