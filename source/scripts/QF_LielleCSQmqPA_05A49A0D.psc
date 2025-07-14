;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_LielleCSQmqPA_05A49A0D Extends Quest Hidden

;BEGIN ALIAS PROPERTY Lielle_Alias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lielle_Alias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
LielleFollower.DismissFollower(0,0,(Alias_Lielle_Alias.GetRef() as Actor))
LielleXO.XOMinus(1.5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

liellefollowerscript Property LielleFollower  Auto  

LielleXOScript Property LielleXO  Auto  
