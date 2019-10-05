Scriptname LielleFollowerDialog extends Quest  


Actor Property PlayerREF Auto

ReferenceAlias Property FollowerAlias Auto

Faction Property DismissedFollowerFaction Auto

Faction Property CurrentHireling Auto

Message Property  FollowerDismissMessage Auto

Message Property  FollowerDismissMessageWedding Auto

Message Property  FollowerDismissMessageCompanions Auto

Message Property  FollowerDismissMessageCompanionsMale Auto

Message Property  FollowerDismissMessageCompanionsFemale Auto

Message Property  FollowerDismissMessageWait Auto

SetHirelingRehire Property HirelingRehireScript Auto

GlobalVariable Property pPlayerFollowerCount Auto

;Property to tell follower to say dismissal line

Int Property iFollowerDismiss Auto Conditional

;Variables used for Extensible Follower Framework Compatibility

Int EFFStatus

Quest XFLMain 

Event OnInit()

		EFFStatus = Game.GetModByName("EFFCore.esm")
		If EFFStatus != 255 
		Debug.Notification("LielleCore: EFF Detected - Enhancing Behavior")
			XFLMain = Game.GetFormFromFile(0x05000EFF, "EFFCore.esm") as Quest
		EndIf

EndEvent
;----------------------------------------------------

Function SetFollower(ObjectReference FollowerRef)

	If EFFStatus != 255
		(XFLMain as EFFCore).XFL_AddFollower(FollowerRef as Actor)

	; Set the internal global for 3DNPC to allow/disallow recruiting
		If (XFLMain as EFFCore).XFL_FollowerCountEx.value < (XFLMain as EFFCore).XFL_MaximumFollowers.value
			pPlayerFollowerCount.SetValue(0)
		Else
			pPlayerFollowerCount.SetValue(1)
		Endif
	
	Else
		actor FollowerActor = FollowerRef as Actor

		FollowerActor.RemoveFromFaction(DismissedFollowerFaction)

		If FollowerActor.GetRelationshipRank(PlayerREF) <3 && FollowerActor.GetRelationshipRank(PlayerREF) >= 0

			FollowerActor.SetRelationshipRank(PlayerREF, 3)

		EndIf

		FollowerActor.SetPlayerTeammate()

		;FollowerActor.SetActorValue("Morality", 0)

		FollowerAlias.ForceRefTo(FollowerActor)

		FollowerActor.EvaluatePackage()
	EndIf

EndFunction
;----------------------------------------------------

Function FollowerWait()

	If EFFStatus != 255
		(XFLMain as EFFCore).XFL_SetWait(FollowerAlias.GetReference() as Actor)	
	Else
		actor FollowerActor = FollowerAlias.GetActorRef() as Actor

		FollowerActor.SetActorValue("WaitingForPlayer", 1)
	
		FollowerActor.EvaluatePackage()

		SetObjectiveDisplayed(10, abforce = true)

		;follower will wait 3 days
	EndIf
	 
EndFunction
;----------------------------------------------------

Function FollowerFollow()
	
	If EFFStatus != 255
		(XFLMain as EFFCore).XFL_SetFollow(FollowerAlias.GetReference() as Actor)
	Else
		actor FollowerActor = FollowerAlias.GetActorRef() as Actor

		FollowerActor.SetActorValue("WaitingForPlayer", 0)

		FollowerActor.EvaluatePackage()

		SetObjectiveDisplayed(10, abdisplayed = false)

		FollowerActor.EvaluatePackage()
	EndIf

EndFunction
;----------------------------------------------------
 
Function DismissFollower(Int iMessage = 0, Int iSayLine = 1)
	If EFFStatus != 255
		(XFLMain as EFFCore).XFL_RemoveFollower(FollowerAlias.GetReference() as Actor, iMessage, iSayLine)

		; Set the internal global for 3DNPC to allow/disallow recruiting
		If (XFLMain as EFFCore).XFL_FollowerCountEx.value < (XFLMain as EFFCore).XFL_MaximumFollowers.value
			pPlayerFollowerCount.SetValue(0)
		Else
			pPlayerFollowerCount.SetValue(1)
		Endif	
	Else
		If FollowerAlias && FollowerAlias.GetActorReference().IsDead() == False

			If iMessage == 0

				FollowerDismissMessage.Show()

			ElseIf iMessage == 1

				FollowerDismissMessageWedding.Show()

			ElseIf iMessage == 2

				FollowerDismissMessageCompanions.Show()

			ElseIf iMessage == 3

				FollowerDismissMessageCompanionsMale.Show()

			ElseIf iMessage == 4

				FollowerDismissMessageCompanionsFemale.Show()

			ElseIf iMessage == 5

				FollowerDismissMessageWait.Show()

			Else

				;failsafe

				FollowerDismissMessage.Show()

			EndIf

			actor DismissedFollowerActor = FollowerAlias.GetActorRef() as Actor

			DismissedFollowerActor.StopCombatAlarm()

			DismissedFollowerActor.AddToFaction(DismissedFollowerFaction)

			DismissedFollowerActor.SetPlayerTeammate(false)

			DismissedFollowerActor.RemoveFromFaction(CurrentHireling)

			DismissedFollowerActor.SetActorValue("WaitingForPlayer", 0)

			;hireling rehire function

			HirelingRehireScript.DismissHireling(DismissedFollowerActor.GetActorBase())

			If iSayLine == 1

				iFollowerDismiss = 1

				DismissedFollowerActor.EvaluatePackage()

				;Wait for follower to say line

				Utility.Wait(2)

			EndIf

				FollowerAlias.Clear()

				iFollowerDismiss = 0

				;don't set count to 0 if Companions have replaced follower

			If iMessage == 2

				;do nothing

			EndIf

		EndIf

	EndIf
EndFunction