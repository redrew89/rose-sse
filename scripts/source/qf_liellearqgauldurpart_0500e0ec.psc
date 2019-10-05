;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_LielleARQGauldurPart_0500E0EC Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;;This is a fragment

(LielleARQGauldurPart as LielleARQWaitScript).Waiting()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property LielleARQStatus  Auto  

Quest Property LielleARQGauldurPart  Auto  
