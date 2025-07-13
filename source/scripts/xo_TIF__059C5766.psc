;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname xo_TIF__059C5766 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
RelationshipMarriageFIN.SetStage(5)
LielleXO.WeddingEnd()
(GetOwningQuest() as LielleEmotionManager).HandleEmotions("Love",90)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleWeddingScript Property LielleXO  Auto  

Quest Property RelationshipMarriageFIN  Auto  
