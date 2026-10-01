Scriptname LielleCSQSofiaBanterTimer extends Quest  


Lielle_CSQBanterScript Property BanterScript Auto 

Function beginTimer()

	int aValue = Utility.RandomInt(5,8)
	RegisterForSingleUpdateGameTime(aValue)

endFunction

Event OnUpdateGameTime()

	UnregisterForUpdateGameTime()
	BanterScript.SetBanterStage("Sofia",2)
	
EndEvent


	
	