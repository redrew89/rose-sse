;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname xo_TIF__05773018 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
RelationshipMarriageBreakUp.setstage(200)
; Calling this directly
(GetOwningQuest() as LielleEmotionManager).SetTears()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
LielleXOQ.WeddingEnd()
;LielleXOQ.Breakup()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleWeddingScript Property LielleXOQ  Auto  

Quest Property RelationshipMarriageBreakUp  Auto  
