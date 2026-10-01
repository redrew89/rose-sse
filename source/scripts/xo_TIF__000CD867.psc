;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname xo_TIF__000CD867 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
;BEGIN CODE
Actor akSpeaker = akSpeakerRef as Actor
GetOwningQuest().SetStage(200)
LielleXO.XOMinus(3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleXOScript Property LielleXO  Auto
