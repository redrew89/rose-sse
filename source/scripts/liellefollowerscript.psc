Scriptname LielleFollowerScript extends Quest

; Vanilla Properties
Actor Property PlayerRef Auto
ReferenceAlias Property FollowerAlias Auto
Faction Property DismissedFollowerFaction Auto
Faction Property CurrentHireling Auto
Message Property FollowerDismissMessage Auto
Message Property FollowerDismissMessageWedding Auto
Message Property FollowerDismissMessageCompanions Auto
Message Property FollowerDismissMessageCompanionsMale Auto
Message Property FollowerDismissMessageCompanionsFemale Auto
Message Property FollowerDismissMessageWait Auto
SetHirelingRehire Property HirelingRehireScript Auto

; Custom Properties
Package Property LielleFollowPlayer Auto
Package Property LielleWaitPackage Auto
GlobalVariable Property LielleIsFollowing Auto

; Internal variables
Actor LielleActor
bool isWaiting = false
bool isDistanceWarned = false
Int Property iFollowerDismiss Auto Conditional

; Events
Event OnInit()
  LielleActor = FollowerAlias.GetActorReference()
  RegisterForSingleUpdate(5.0)
  InitializeFollower()
EndEvent

Event OnUpdate()
  if LielleIsFollowing.GetValue() == 1.0
    MonitorDistance()
  endif
  RegisterForSingleUpdate(5.0)
EndEvent

Function InitializeFollower()
  if LielleActor
    LielleActor.SetNotShowOnStealthMeter(true)
    LielleActor.SetNoBleedoutRecovery(false)
    LielleActor.AllowPCDialogue(true)
  endif
EndFunction

Function SetFollower(ObjectReference FollowerRef)
  Actor FollowerActor = FollowerRef as Actor
  FollowerActor.RemoveFromFaction(DismissedFollowerFaction)
  If FollowerActor.GetRelationshipRank(PlayerRef) < 3 && FollowerActor.GetRelationshipRank(PlayerRef) >= 0
    FollowerActor.SetRelationshipRank(PlayerRef, 3)
  EndIf
  FollowerActor.SetPlayerTeammate()
  FollowerAlias.ForceRefTo(FollowerActor)
  LielleActor = FollowerActor ; The alias may have been empty at OnInit
  LielleIsFollowing.SetValue(1.0)
  isWaiting = false
  UpdateCombatStyle(true)
  FollowerActor.EvaluatePackage()
EndFunction

Function FollowerWait()
  Actor FollowerActor = FollowerAlias.GetActorRef() as Actor
  FollowerActor.SetActorValue("WaitingForPlayer", 1)
  SetObjectiveDisplayed(10, abforce = true)
  FollowerAlias.RegisterForSingleUpdateGameTime(72)
  isWaiting = true
  FollowerActor.EvaluatePackage()
EndFunction

Function FollowerFollow()
  Actor FollowerActor = FollowerAlias.GetActorRef() as Actor
  FollowerActor.SetActorValue("WaitingForPlayer", 0)
  SetObjectiveDisplayed(10, abdisplayed = false)
  isWaiting = false
  FollowerActor.EvaluatePackage()
EndFunction

Function DismissFollower(Int iMessage = 0, Int iSayLine = 1, Actor akActor = None)
  If FollowerAlias && FollowerAlias.GetActorReference() && FollowerAlias.GetActorReference().IsDead() == False
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
      FollowerDismissMessage.Show()
    EndIf
    
    Actor DismissedFollowerActor = FollowerAlias.GetActorRef() as Actor
    DismissedFollowerActor.StopCombatAlarm()
    DismissedFollowerActor.AddToFaction(DismissedFollowerFaction)
    DismissedFollowerActor.SetPlayerTeammate(false)
    DismissedFollowerActor.RemoveFromFaction(CurrentHireling)
    DismissedFollowerActor.SetActorValue("WaitingForPlayer", 0)
    
    HirelingRehireScript.DismissHireling(DismissedFollowerActor.GetActorBase())
    
    If iSayLine == 1
      iFollowerDismiss = 1
      DismissedFollowerActor.EvaluatePackage()
      Utility.Wait(2)
    EndIf
    
    FollowerAlias.Clear()
    iFollowerDismiss = 0
    LielleIsFollowing.SetValue(0.0)
    isWaiting = false
    UpdateCombatStyle(false)
    
    If iMessage == 2
      ;do nothing for Companions replacement
    EndIf
  EndIf
EndFunction

Function MonitorDistance()
  if !isWaiting && LielleActor
    float distance = PlayerRef.GetDistance(LielleActor)
    
    if distance > 4000.0 && !isDistanceWarned
      isDistanceWarned = true
    elseif distance > 5000.0 && !LielleActor.GetCurrentScene() && !LielleActor.IsDead()
      ; Angle Z is clockwise from north, so the player's forward vector is (sin, cos)
      float angle = PlayerRef.GetAngleZ()
      LielleActor.MoveTo(PlayerRef, 100.0 * Math.sin(angle), 100.0 * Math.cos(angle))
      isDistanceWarned = false
    elseif distance < 3000.0
      isDistanceWarned = false
    endif
  endif
EndFunction

Function UpdateCombatStyle(bool isFollowing)
  if LielleActor
    if isFollowing
      LielleActor.SetActorValue("Confidence", 3)
    else
      LielleActor.SetActorValue("Confidence", 2)
    endif
  endif
EndFunction

bool Function IsFollowing()
  return LielleIsFollowing.GetValue() == 1.0
EndFunction

bool Function IsWaiting()
  return isWaiting
EndFunction