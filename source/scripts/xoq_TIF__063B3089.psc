;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname xoq_TIF__063B3089 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
WeddingScript.WeddingStart(akSpeaker as ObjectReference)
GetOwningQuest().Setstage(40)
LielleLoverAlias.ForceRefIfEmpty(LoveInterest.GetActorRef())
(GetOwningQuest() as LielleEmotionManager).ResetEmotionState()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akSpeaker.AddtoFaction(MarriageAskedFaction)
LoveInterest.ForceRefTo(akSpeaker as ObjectReference)
RelationshipMarriage.SetStage(20)
(GetOwningQuest() as LielleEmotionManager).HandleEmotions("Overjoyed",70)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property MarriageAskedFaction  Auto  

ReferenceAlias Property LoveInterest  Auto  

Quest Property RelationshipMarriage  Auto  

LielleWeddingScript Property WeddingScript  Auto  

ReferenceAlias Property LielleLoverAlias  Auto  
