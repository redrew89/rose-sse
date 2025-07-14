;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname Debug_TIF__0504009E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;;This script will fire debugs for all of the things
debug.Notification("ARQ Status: " + LielleARQStatus.GetValueInt())
debug.Notification("ARQ Count: " + LielleARQCount.GetValueInt())
debug.Notification("ARQ Ready: " + LielleARQReady.GetValueInt())
debug.Notification("XO Value: " + LielleXOValue.GetValueInt())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property LielleARQStatus  Auto  


GlobalVariable Property LielleARQCount Auto  

GlobalVariable Property LielleARQReady  Auto  

GlobalVariable Property LielleXOValue  Auto  
