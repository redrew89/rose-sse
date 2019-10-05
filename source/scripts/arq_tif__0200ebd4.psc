;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARQ_TIF__0200EBD4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
getowningquest().setstage(40)
LielleARQGauldur.setstage(10)
Game.GetPlayer().AddItem(GauldurPart)
(LielleDialogFollowerQst as LielleFollowerDialog).SetFollower(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleDialogFollowerQst  Auto  

Armor Property GauldurPart  Auto  

Quest Property LielleARQGauldur  Auto  
