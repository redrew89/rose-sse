;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname CSQ_DF_TIF__05059607 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;This is a script
If Lielle.IsInFaction(CurrentFollowerFaction) == 0
     (LielleDialogueQuest as LielleFollowerScript).SetFollower(akSpeaker)
EndIf
debug.Notification("Lielle will not rest until the College of Winterhold is safe.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(35)
Lielle.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property LielleDialogueQuest  Auto  

Faction Property CurrentFollowerFaction  Auto  

Actor Property Lielle  Auto  

Scene Property LielleCSQMG07Labyrintian  Auto  
