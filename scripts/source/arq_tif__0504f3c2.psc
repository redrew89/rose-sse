;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARQ_TIF__0504F3C2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;;This is a script
Game.GetPlayer().RemoveItem(dunGauldurAmulet)
(GetOwningQuest() as LielleARQTimerScript).BeginResearch()
GetOwningQuest().SetObjectiveDisplayed(10)
GetOwningQuest().SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property dunGauldurAmulet  Auto  
