ScriptName TIF__0501277F extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mgscript).LielleMG03TopicSay(1)
EndFunction

