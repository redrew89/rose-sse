;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname arq_TIF__0200EBDD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;This is a script
Game.GetPlayer().AddItem(aBook)
Game.GetPlayer().AddItem(GauldurPart)
GetOwningQuest().SetObjectiveCompleted(10)
(GetOwningQuest() as LielleARQTimerScript).EndResearch()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Book Property aBook  Auto  

Armor Property GauldurPart  Auto  
