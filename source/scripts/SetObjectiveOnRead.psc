Scriptname SetObjectiveOnRead extends Book  

Event OnRead()

	questRef.SetObjectiveDisplayed(objective)
	
endEvent



Quest Property questRef  Auto  

Int Property objective  Auto  
