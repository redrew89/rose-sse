;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname CSQ_TIF__05440A62 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.DisablePlayerControls(true,true,true,false,true,true,true)

ChildLielleAlias.GetReference().Enable()
ChildMalekAlias.GetReference().Enable()
ChildMarekAlias.GetReference().Enable()
FarmScene2.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property ChildLielleAlias  Auto  

ReferenceAlias Property ChildMalekAlias  Auto  

ReferenceAlias Property ChildMarekAlias  Auto  

Scene Property FarmScene2  Auto  
