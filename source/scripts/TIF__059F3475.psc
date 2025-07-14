;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__059F3475 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Lielle_Alias.GetReference() as Actor).EquipItem(GogglesDown)

LielleWordResearch.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property LielleWordResearch  Auto  

Armor Property GogglesDown  Auto  

ReferenceAlias Property Lielle_Alias  Auto  
