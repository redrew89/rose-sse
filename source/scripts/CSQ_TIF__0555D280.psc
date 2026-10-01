;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname CSQ_TIF__0555D280 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ChildLielle.GetReference().Enable(1)
ChildMalek.GetReference().Enable(1)
ChildMarek.GetReference().Enable(1)
(LielleARQMain as rdUtils).SlideTime(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
NightmareFarmScene2.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property NightmareFarmScene2  Auto  

Quest Property LielleARQMain  Auto  

ReferenceAlias Property ChildLielle  Auto  

ReferenceAlias Property ChildMalek Auto

ReferenceAlias Property ChildMarek Auto
