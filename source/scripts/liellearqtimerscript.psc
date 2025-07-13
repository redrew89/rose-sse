Scriptname LielleARQTimerScript extends Quest 

Actor Property LielleActorRef  Auto  

Int Property TargetStage Auto

Faction Property FollowerFac Auto

bool Property difficultTask Auto

LielleCoreScript Property Core Auto

LielleCoreARQ Property CoreARQ Auto

LielleStudyRankScript Property StudyRank Auto

string msgFlag = "LielleCore - Arcane Research: "

Event OnUpdateGameTime()
	if !CoreARQ.LielleARQStatus
		UnregisterForUpdateGameTime()
		self.BeginResearch()		
	elseif CoreARQ.LielleARQStatus 	
		Self.SetStage(TargetStage)
		UnregisterForUpdateGameTime()
		if Core.LielleVerbose
			Core.Msg(msgFlag + "Research Done!")
		endif
		CoreARQ.LielleARQReady = true
	endif
EndEvent


Function speedUp(bool aBool = true)

	if aBool
		CoreARQ.LielleARQSpeedUp = true
	else
		CoreARQ.LielleARQSpeedUp = false
	endif
	
endFunction


Function BeginResearch()
	;First, checks that Lielle is not an active follower or busy with other research
	;If she isn't, runs one timer or the other, based on the bool Property 
	;If she is, register for another update in another 4 hours, in game

	If !LielleActorRef.IsInFaction(FollowerFac) && !(CoreARQ.LielleARQStatus)
		CoreARQ.LielleARQStatus = true
		;CoreARQ.LielleARQReady = false ;adding this as a sanity check
		If difficultTask == 1
			LongWait()
		Else
			ShortWait()
		EndIf
	Else
		RegisterforSingleUpdateGameTime(4)
	EndIf
EndFunction

Function EndResearch()
	;Ends research by resetting the quest variable that tracks whether or not Lielle is researching an artifact
	;Sets her ready value to 0, to indicate that she doesn't have completed research
	;Increments her research count, used in gated quests
	;Passes call to StudyRank on LielleARQMain
	CoreARQ.LielleARQCount = (CoreARQ.LielleARQCount + 1)
	CoreARQ.LielleARQReady = false	
	CoreARQ.LielleARQStatus = false
	
	
	if difficultTask
		StudyRank.RankAdd(1)
	else
		StudyRank.RankAdd(0.5)
	endif
	
EndFunction

Function ShortWait()
	;This function does a psuedo-random wait between 12 and 36 in game hours
	;OR if SpeedUp global set, 6 to 24 hours
	int TimeValue
	if CoreARQ.LielleARQSpeedUp
		TimeValue = Utility.RandomInt(6, 24)
	else	
		TimeValue = Utility.RandomInt(12,36)
	endif	
	
	if Core.LielleVerbose
		Core.Msg(msgFlag + "You expect Lielle to take " + TimeValue + " hours to complete this task.")
	endif
	RegisterForSingleUpdateGameTime(TimeValue)
		
EndFunction

Function LongWait()
	int TimeValue
	;This function does a pseudo-random wait between 24 and 48 in game hours
	if CoreARQ.LielleARQSpeedUp
		TimeValue = Utility.RandomInt(24, 48)
	else
		TimeValue = Utility.RandomInt(32, 96)
	endif
	if Core.LielleVerbose
		Core.Msg(msgFlag + "You expect Lielle to take " + TimeValue + " hours to complete this task.")
	endif
	RegisterForSingleUpdateGameTime(TimeValue)
	
EndFunction

