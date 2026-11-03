ScriptName TIF__05A499EE extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq301TopicSay()
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Surprised", 90)
EndFunction

LielleEmotionManager Property Emotions Auto
