ScriptName TIF__05A44857 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq203AlduinSay()
EndFunction

