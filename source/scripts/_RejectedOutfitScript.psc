Scriptname _RejectedOutfitScript extends ObjectReference  

GlobalVariable Property LielleOutfitReject Auto

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	
	if akDestContainer == Game.GetPlayer() && LielleOutfitReject.GetValueInt() == 1 && self.GetNumItems() == 0
		LielleOutfitReject.SetValueInt(0)
	endIf
EndEvent
