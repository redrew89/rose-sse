ScriptName TIF__05A3F6C2 extends TopicInfo Hidden

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq105UstenSay()
EndFunction

