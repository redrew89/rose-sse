Scriptname LielleDialogQuestAliasScript extends ReferenceAlias  

Faction Property CurrentHireling Auto
Message Property FollowerDismissMessage  Auto
Actor Property PlayerREF Auto

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)

     If (akTarget == PlayerREF)

          ; debug.trace(self + "Dismissing follower because he is now attacking the player")

          (GetOwningQuest() as LielleFollowerDialog).DismissFollower(0, 0)

     EndIf

EndEvent

Event OnDeath(Actor akKiller)

     ; debug.trace(self + "Clearing the follower because the player killed him.")

     Self.GetActorRef().RemoveFromFaction(CurrentHireling)

     Self.Clear()

EndEvent