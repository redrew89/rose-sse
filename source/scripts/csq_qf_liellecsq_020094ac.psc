;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname CSQ_QF_LielleCSQ_020094AC Extends Quest Hidden

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OrthornAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OrthornAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EstormoAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EstormoAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AncanoAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AncanoAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveCompleted(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
; MG completion check

if MG08.GetStage() == 200
  self.SetStage(40)
else
  self.setstage(5)
endif


;Start misc quests

LielleCSQMisc01.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
XO.XOPlus(2.5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Quest Property MG08  Auto  

Quest Property LielleCSQMisc01  Auto  


LielleXOScript Property XO  Auto  

LielleEmotionManager Property Emotions  Auto  
