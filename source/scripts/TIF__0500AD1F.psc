ScriptName TIF__0500AD1F extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    GetOwningQuest().SetStage(100)
EndFunction

