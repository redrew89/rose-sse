ScriptName TIF__05A3F6B8 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq105TopicSay()
EndFunction

