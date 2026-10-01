;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname ARQ_QF_LielleARQRoseFinal_05151879 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Self.SetObjectiveCompleted(15)
LielleARQRose.Stop()
LielleARQRoseNeloth.Stop()
self.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
Self.SetObjectiveDisplayed(10)
;kmyQuest.BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE LielleARQStaffBenchEnabler
Quest __temp = self as Quest
LielleARQStaffBenchEnabler kmyQuest = __temp as LielleARQStaffBenchEnabler
;END AUTOCAST
;BEGIN CODE
;;script
SetObjectiveCompleted(10)
SetObjectiveDisplayed(15)
kmyQuest.DoTheThing()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleARQRose  Auto  

Quest Property LielleARQRoseNeloth  Auto  
