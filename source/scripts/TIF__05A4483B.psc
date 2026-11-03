ScriptName TIF__05A4483B extends TopicInfo Hidden

liellefollowerscript Property LielleFollower Auto

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    LielleFollower.DismissFollower(0, 0, akSpeaker)
EndFunction

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq201ThalmorSay()
EndFunction

