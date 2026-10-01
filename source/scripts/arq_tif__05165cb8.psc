;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARQ_TIF__05165CB8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(da09Dawnbreaker)
GetOwningQuest().SetStage(15)
GetOwningQuest().SetObjectiveDisplayed(10)
LielleFGAlias.Clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If Lielle.IsInFaction(CurrentFollowerFaction)
(LielleDialogueQuest as LielleFollowerScript).DismissFollower(0,0,akspeaker)
EndIf

(GetOwningQuest() as LielleARQTimerScript).BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

WEAPON Property DA09Dawnbreaker  Auto  

Quest Property LielleDialogueQuest  Auto  

Actor Property Lielle  Auto  

Faction Property CurrentFollowerFaction  Auto  

ReferenceAlias Property LielleFGAlias  Auto  
