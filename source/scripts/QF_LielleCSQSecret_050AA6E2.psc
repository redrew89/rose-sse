;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname QF_LielleCSQSecret_050AA6E2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY ChildMalekAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildMalekAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChildLielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildLielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleNoteAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleNoteAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleNightmareAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleNightmareAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChildMarekAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildMarekAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MarkusNightmareAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MarkusNightmareAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
Alias_LielleNoteAlias.GetReference().Enable() ;If you marked your note alias as "Initially Disabled"
CourierScript.AddItemToContainer(Alias_LielleNoteAlias.GetReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndResearch()
SetObjectiveCompleted(15)
SetObjectiveCompleted(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(10)
setObjectiveDisplayed(15)
kmyQuest.BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveDisplayed(25)
LielleNightmareActor.enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Alias_ChildLielleAlias.GetReference().Disable()
Alias_ChildMalekAlias.GetReference().Disable()
Alias_ChildMarekAlias.GetReference().Disable()

Game.EnablePlayerControls(true,false,false,true,false,false,false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

WICourierScript Property CourierScript  Auto  

ObjectReference Property LielleNightmareActor  Auto  
