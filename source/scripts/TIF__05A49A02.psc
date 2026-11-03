ScriptName TIF__05A49A02 extends TopicInfo Hidden

liellexoscript Property LielleXO Auto

liellefollowerscript Property LielleFollower Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    LielleXO.XOMinus(1)
    (GetOwningQuest() as _csq_mqscript).mq302DepartSay()
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    LielleFollower.DismissFollower(0, 0, akSpeaker)
EndFunction

