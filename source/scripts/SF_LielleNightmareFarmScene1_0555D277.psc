;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SF_LielleNightmareFarmScene1_0555D277 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
GetOwningQuest().SetStage(27)
(Lielle.GetReference() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property glassShatter Auto  

Sound Property glassShatterFX Auto


ReferenceAlias Property Markus  Auto  

ReferenceAlias Property Lielle  Auto  
