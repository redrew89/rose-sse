;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_LielleARQRoseNeloth_0508C093 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NelothAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NelothAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndResearch()
Self.SetObjectiveCompleted(10)
LielleARQStaffCheck.SetValueInt(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleDialogueQuest  Auto  

GlobalVariable Property LielleARQStaffCheck  Auto  
