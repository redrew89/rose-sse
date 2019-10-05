;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARQ_TIF__0200EBCB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;check if player has dunGauldursonQST objective in journal

If dunGauldursonQST.IsObjectiveDisplayed(10)
    GetOwningQuest().SetStage(22)
Else
    return
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property dunGauldursonQST  Auto  
