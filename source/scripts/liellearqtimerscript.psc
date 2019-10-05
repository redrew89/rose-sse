Scriptname LielleARQTimerScript extends Quest  

Actor Property LielleActorRef  Auto  

Int Property TargetStage Auto

Int Property waitStage Auto

Faction Property FollowerFac Auto

bool Property difficultTask Auto

Function BeginResearch()

;Check to make sure Lielle isn't currently doing research
	If LielleARQStatus.GetValueInt() == 1 
		
		Self.SetStage(waitStage)
	Else
		
		RegisterForSingleUpdateGameTime(1)
		
		;Clear LielleARQReady if it wasn't cleared before.
		If LielleARQReady.GetValueInt() != 0
			LielleARQReady.SetValueInt(0)
		EndIf
	EndIf
EndFunction

Function EndResearch()
;Ends research by resetting the global value that tracks whether or not Lielle is researching an artifact
;Set's her ready value to 0, to indicate that she doesn't have completed research
;Increments her research count, used in gated quests
	LielleARQCount.Mod(1)
	LielleARQReady.SetValueInt(0)
	LielleARQStatus.SetValueInt(0)
EndFunction


Event OnUpdateGameTime()
;First, checks that Lielle is not an active follower
;If she isn't, runs one timer or the other, based on the bool Property 
;If she is, register for another update in another 4 hours, in game

If LielleActorRef.IsInFaction(FollowerFac) == 0
	LielleARQStatus.SetValueInt(1)
	If difficultTask == 1
		LongWait()
	Else
		ShortWait()
	EndIf
Else
	RegisterForSingleUpdateGameTime(4)
	;debug.Notification("Lielle is busy. Waiting until she has time.")
EndIf
EndEvent


Function ShortWait()
	;This function does a psuedo-random wait between 6 and 12 in game hours

	int TimeValue = Utility.RandomInt(6, 12)
	Utility.WaitGameTime(TimeValue)
	;debug.Notification("Research Done!")
	Self.SetStage(TargetStage)
	LielleARQReady.SetValueInt(1)
EndFunction


Function LongWait()
	;This function does a pseudo-random wait between 72 and 96 in game hours
	
	int TimeValue = Utility.RandomInt(72, 96)
	Utility.WaitGameTime(TimeValue)
	;debug.Notification("Research Done!")
	Self.SetStage(TargetStage)
	LielleARQReady.SetValueInt(1)
EndFunction

GlobalVariable Property LielleARQStatus  Auto  

GlobalVariable Property LielleARQCount  Auto  

GlobalVariable Property LielleARQReady Auto  

