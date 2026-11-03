ScriptName TIF__050595F2 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mgscript).LielleMG04TopicSay(1)
EndFunction

