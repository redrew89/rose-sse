ScriptName TIF__05A499FC extends TopicInfo Hidden

liellexoscript Property LielleXO Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    LielleXO.XOPlus(1)
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq302DepartSay()
EndFunction

