;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_LielleCSQFlee_051F8FB2 Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleFleeNoteAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleFleeNoteAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Alias_LielleAlias as Lielle_FleeAliasScript).LielleFlees()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
