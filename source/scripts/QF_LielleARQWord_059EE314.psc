;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_LielleARQWord_059EE314 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Lielle_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lielle_Alias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player_Alias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WordWall_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WordWall_Alias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Give Lielle her new headgear, if she doesn't have a set already
if  !(Alias_Lielle_Alias.GetReference() as Actor).IsEquipped(GogglesUp)
   (Alias_Lielle_Alias.GetReference() as Actor).EquipItem(GogglesUp)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property GogglesUp  Auto  
