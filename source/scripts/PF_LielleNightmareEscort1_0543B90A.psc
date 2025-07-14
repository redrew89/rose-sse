;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PF_LielleNightmareEscort1_0543B90A Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
Markus.GetReference().EnableNoWait()
Utility.Wait(5)
NightmareFarmScene1.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property NightmareFarmScene1  Auto  

ReferenceAlias Property Markus  Auto  

ReferenceAlias Property Lielle  Auto  
