;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_LielleARQStar_050A9025 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndResearch()
self.stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
