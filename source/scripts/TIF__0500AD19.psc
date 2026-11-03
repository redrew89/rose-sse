ScriptName TIF__0500AD19 extends TopicInfo Hidden

quest Property LielleDialogueQuest Auto

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    GetOwningQuest().SetStage(10)
    (LielleDialogueQuest as liellefollowerscript).DismissFollower(0, 0, akSpeaker)
EndFunction

