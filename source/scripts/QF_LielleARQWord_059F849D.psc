;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_LielleARQWord_059F849D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Lielle_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lielle_Alias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WordWall_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WordWall_Alias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
LielleStudyRank.RankAdd(0.25)
Alias_WordWall_Alias.Clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if (Alias_Lielle_Alias.GetRef() as Actor).IsEquipped(GogglesUp)
  self.setstage(10)   
else
   (Alias_Lielle_Alias.GetRef() as Actor).EquipItem(GogglesUp)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property GogglesUp  Auto  

LielleStudyRankScript Property LielleStudyRank  Auto  
