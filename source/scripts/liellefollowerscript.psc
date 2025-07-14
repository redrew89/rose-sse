Scriptname LielleFollowerScript extends Quest  

DialogueFollowerScript Property Follower Auto

;----------------------------------------------------

Function SetFollower(ObjectReference FollowerRef)
	Follower.SetFollower(FollowerRef)	
EndFunction
;----------------------------------------------------

Function FollowerWait()
	Follower.FollowerWait()	 
EndFunction
;----------------------------------------------------

Function FollowerFollow()
	Follower.FollowerFollow()	
EndFunction
;----------------------------------------------------
 
Function DismissFollower(Int iMessage = 0, Int iSayLine = 1, Actor akActor)
	Follower.DismissFollower(iMessage, iSayLine)	
EndFunction

