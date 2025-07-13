Scriptname LielleARQTriggerBox extends ObjectReference  

Actor Property aNirya  Auto  

Actor Property PlayerRef Auto

ObjectReference Property mNiryaMark Auto

Event OnTriggerEnter(ObjectReference akTrigger)
	if akTrigger == PlayerRef 
		aNirya.Disable()
		aNirya.Enable()
		aNirya.MoveTo(mNiryaMark)
		aNirya.SetDontMove(true)
	endif
EndEvent

Event OnTriggerLeave(ObjectReference akTrigger)
	if akTrigger == PlayerRef
		aNirya.SetDontMove(false)
	endif
EndEvent