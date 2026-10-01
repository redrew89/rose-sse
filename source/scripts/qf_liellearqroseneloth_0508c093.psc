;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_LielleARQRoseNeloth_0508C093 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DLC2EnchanterAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DLC2EnchanterAlias Auto
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
Self.SetObjectiveCompleted(15)
Core.LielleARQStaffCheck = true
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveCompleted(10)
setObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleDialogueQuest  Auto  

;GlobalVariable Property LielleARQStaffCheck  Auto  
;Old structure. Now using quest script variable.

LielleCoreScript Property Core Auto
