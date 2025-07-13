;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PF_LielleNightmareEscort2_0561428C Extends Package Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(Actor akActor)
;BEGIN CODE
YoungLielle.GetReference().Enable(true)
ThreeEyes.GetReference().Enable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(Actor akActor)
;BEGIN CODE
NightmareCampScene1.start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Scene Property NightmareCampScene1 Auto

ReferenceAlias Property YoungLielle  Auto  

ReferenceAlias Property ThreeEyes Auto



