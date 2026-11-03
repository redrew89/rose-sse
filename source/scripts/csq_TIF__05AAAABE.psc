;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname csq_TIF__05AAAABE Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if sEmotion != ""
	Emotions.HandleEmotions(sEmotion, iIntensity)
endif
XO.XOPlus(0.4)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleXOScript Property XO  Auto  

LielleEmotionManager Property Emotions Auto

String Property sEmotion Auto
Int Property iIntensity Auto
