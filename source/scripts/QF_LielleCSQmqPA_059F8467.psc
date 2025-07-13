;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_LielleCSQmqPA_059F8467 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Lielle_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lielle_Alias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Self.stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
LielleFollower.DismissFollower(0,0,(Alias_Lielle_Alias.GetReference() as Actor))
LielleXO.XOMinus(2)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

liellefollowerscript Property LielleFollower  Auto  

LielleXOScript Property LielleXO  Auto  
