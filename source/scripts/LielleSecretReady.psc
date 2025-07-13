Scriptname LielleSecretReady extends Quest  

Function Waiting()
	RegisterForSingleUpdateGameTime(24)
EndFunction


Event OnUpdateGameTime()
	If self.GetStage() == 17 
		self.SetStage(18)
	endif	
EndEvent
