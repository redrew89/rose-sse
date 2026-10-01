;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname QF_LielleARQLab_05E41D0E Extends Quest Hidden

;BEGIN ALIAS PROPERTY WorkshopXmark
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WorkshopXmark Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RubbleXmark
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RubbleXmark Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RuinsMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RuinsMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;script

(Alias_RubbleXmark.GetReference()).Disable()
(Alias_WorkshopXmark.GetReference()).Enable()

SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)

if LielleOutfitResearcher.GetValueInt() == 1
   (LielleCSQOutfits as LielleOutfitScript).SetOutfitResearcher()
endif
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
kmyQuest.BeginResearch()
SetObjectiveCompleted(5)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EndResearch()
SetObjectiveCompleted(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property LielleOutfitResearcher  Auto  

Quest Property LielleCSQOutfits  Auto  

GlobalVariable Property LielleOutfitToggle  Auto  
