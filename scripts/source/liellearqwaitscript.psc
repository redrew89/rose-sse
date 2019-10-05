Scriptname LielleARQWaitScript extends Quest  

Function Waiting()
	;Give Lielle a day to finish whatever she's doing
	RegisterForSingleUpdateGameTime(24)
EndFunction

Event OnUpdateGameTime()
	If LielleARQStatus.GetValueInt() == 1 
		;She's still busy, wait another day
		RegisterForSingleUpdateGameTime(24)
	Else
		;She's done. Let's get her to work on this task
		(LielleQuestRef as LielleARQTimerScript).BeginResearch()
		return
	EndIf
EndEvent

GlobalVariable Property LielleARQStatus  Auto  

Actor Property LielleRef Auto

Faction Property CurrentFollowerFaction Auto

Quest Property LielleQuestRef Auto