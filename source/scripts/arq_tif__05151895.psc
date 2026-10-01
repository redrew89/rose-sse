;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARQ_TIF__05151895 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If akSpeaker.IsInFaction(FollowerFac)
   (LielleDialogueQuest as LielleFollowerScript).DismissFollower(0,0,akspeaker)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleDialogueQuest  Auto  

Faction Property FollowerFac  Auto  
