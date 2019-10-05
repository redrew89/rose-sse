;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname ARQ_QF_LielleARQDawn_0500E0F8 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleFGAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleFGAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndResearch()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE LielleARQWaitScript
Quest __temp = self as Quest
LielleARQWaitScript kmyQuest = __temp as LielleARQWaitScript
;END AUTOCAST
;BEGIN CODE
;;script

kmyQuest.Waiting()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;;script

LielleFGAlias.ForceRefTo(Lielle)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property Lielle  Auto  

ReferenceAlias Property LielleFGAlias  Auto  
