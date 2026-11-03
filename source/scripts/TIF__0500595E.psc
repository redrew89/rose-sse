ScriptName TIF__0500595E extends TopicInfo Hidden

quest Property LielleDialogueQuest Auto

objectreference Property MnzeftMarker Auto

Function Fragment_0(objectreference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    GetOwningQuest().SetStage(5)
    (LielleDialogueQuest as liellefollowerscript).SetFollower(akSpeaker)
EndFunction

Function Fragment_1(objectreference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    MnzeftMarker.AddToMap(false)
EndFunction

