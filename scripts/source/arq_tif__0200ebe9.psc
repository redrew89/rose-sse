;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname arq_TIF__0200EBE9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;This is a script fragment
GetOwningQuest().SetStage(40)
GauldurNext.Start()
(LielleQuestRef as LielleFollowerDialog).SetFollower(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(LielleXOQuest as LielleXOScript).XOPlus(2,0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleQuestRef  Auto  

Quest Property LielleXOQuest  Auto  

Quest Property GauldurNext  Auto  
