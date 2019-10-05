;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARQ_TIF__0200EBD0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;This fragment will advance LielleARQGauldurPart to stage 20, and start Lielle research timer on a short timer
GetOwningQuest().SetStage(20)
GetOwningQuest().SetObjectiveDisplayed(10)
(GetOwningQuest() as LielleARQTimerScript).BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
