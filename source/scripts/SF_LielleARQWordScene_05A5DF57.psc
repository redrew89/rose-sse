;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SF_LielleARQWordScene_05A5DF57 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(Lielle_Alias.GetRef() as Actor).EquipItem(GogglesDown)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
(Lielle_Alias.GetRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(Lielle_Alias.GetRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
(Lielle_Alias.GetRef() as Actor).EquipItem(GogglesUp)
(Lielle_Alias.GetRef() as Actor).RemoveItem(GogglesDown)
GetOwningQuest().setstage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Armor Property GogglesUp  Auto  

Armor Property GogglesDown  Auto  

ReferenceAlias Property Lielle_Alias  Auto  
