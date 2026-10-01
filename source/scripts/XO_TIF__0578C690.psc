;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname XO_TIF__0578C690 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
RelationshipMarriageFIN.SetStage(10)
(RelationshipMarriageFIN as RelationshipMarriageSpouseHouseScript).MoveSpouse(akspeaker, HouseAlias)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property HouseAlias  Auto  

Quest Property RelationshipMarriageFIN Auto 