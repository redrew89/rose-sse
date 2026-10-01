;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname SF_LielleARQAnatomyCorpseStu_05AC41D4 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
GetOwningQuest().SetObjectiveDisplayed(1,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Race corpseRace = (GetOwningQuest().GetAlias(1) as ReferenceAlias).GetActorReference().GetRace()

if LielleARQCorpseRaces.HasForm(corpseRace as Form)
   LielleARQCorpseRaces.RemoveAddedForm(corpseRace as Form)
endif
(GetOwningQuest().GetAlias(1) as ReferenceAlias).Clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FormList Property LielleARQCorpseRaces  Auto  
