;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname xo_TIF__0508FFFD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Emotions.HandleEmotions("Bitter", 80)
XO.XOMinus(2.5)
;you dun goofed
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleXOScript Property XO  Auto  

LielleEmotionManager Property Emotions Auto
