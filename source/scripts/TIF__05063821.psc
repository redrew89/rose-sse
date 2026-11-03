ScriptName TIF__05063821 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mgscript).LielleAncanoTopicSay(1)
EndFunction

