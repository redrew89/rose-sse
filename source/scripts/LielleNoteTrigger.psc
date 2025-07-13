Scriptname LielleNoteTrigger extends ObjectReference  

Quest Property LielleCSQSecret Auto

Event OnRead()

	LielleCSQSecret.SetObjectiveCompleted(15)
	LielleCSQSecret.SetObjectiveDisplayed(18)
	
EndEvent