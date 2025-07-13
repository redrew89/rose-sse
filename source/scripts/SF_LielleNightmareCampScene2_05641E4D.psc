;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_LielleNightmareCampScene2_05641E4D Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
InjuredLielle.GetReference().Disable(true)
ThreeEyes.GetReference().Disable(true)
GetOwningQuest().SetStage(35)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property InjuredLielle  Auto  

ReferenceAlias Property ThreeEyes  Auto  
