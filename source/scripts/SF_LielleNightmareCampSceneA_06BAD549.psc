;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 30
Scriptname SF_LielleNightmareCampSceneA_06BAD549 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
YoungLielle.GetReference().Disable(true)
ThreeEyes.GetReference().Disable(true)
Bandit1.GetReference().Disable(true)
Bandit2.GetReference().Disable(true)
GetOwningQuest().SetStage(35)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Bandit1.GetReference().enable(1)
Bandit2.GetReference().enable(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Bandit1.GetActorReference().Enable(1)
Bandit2.GetActorReference().Enable(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20(ReferenceAlias akAlias)
;BEGIN CODE
Actor akBandit1 = Bandit1.GetActorRef()
akBandit1.PlayIdle(looseidlecowering)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
Bandit1.GetActorRef().Kill()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property ThreeEyes  Auto  

ReferenceAlias Property YoungLielle  Auto  

ReferenceAlias Property Bandit1  Auto  

ReferenceAlias Property Bandit2  Auto  

Idle Property looseidlecowering  Auto  

Idle Property FullbodyStagger  Auto  

Idle Property Wounded02  Auto  
