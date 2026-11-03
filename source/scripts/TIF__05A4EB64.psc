ScriptName TIF__05A4EB64 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    GetOwningQuest().SetStage(30)
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Bitter", 90)
EndFunction

LielleEmotionManager Property Emotions Auto
