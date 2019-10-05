;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_LielleARQGauldur_0504F3B4 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleFGAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleFGAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;;This is a script


(LielleQuestRef as LielleARQWaitScript).Waiting()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleQuestRef  Auto  
