;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_LielleARQWord_05A1BE5D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Wall_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Wall_Alias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Lielle_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lielle_Alias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Alias_Lielle_Alias.GetReference() as Actor).EquipItem(GogglesUp)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property GogglesUp  Auto  

Armor Property GogglesDown  Auto  

GlobalVariable Property LielleARQReady  Auto  
