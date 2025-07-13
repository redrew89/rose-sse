;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PF_Lielle_MQScrollReadAction_05A499CA Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
Lielle_Alias.GetActorRef().Additem(DA04ElderScroll, 1)
Lielle_Alias.GetActorRef().EquipItem(ElderScrollHandAttachArmor3rdP, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
Lielle_Alias.GetActorRef().RemoveItem(DA04ElderScroll)
Lielle_Alias.GetActorRef().RemoveItem(ElderScrollHandAttachArmor3rdP, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


ReferenceAlias Property Lielle_Alias Auto

Armor Property ElderScrollHandAttachArmor3rdP Auto

Idle Property LooseFullBodyStagger Auto

Book Property DA04ElderScroll  Auto  
