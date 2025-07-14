;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARQ_TIF__0516ADD1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;;script
LielleARQReady.SetValueInt(0)
LielleARQStatus.SetValueInt(0)
LielleARQCount.SetValueInt(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property LielleARQReady  Auto  

GlobalVariable Property LielleARQStatus  Auto  

GlobalVariable Property LielleARQCount  Auto  
