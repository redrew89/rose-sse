ScriptName TIF__05A499D6 extends TopicInfo Hidden

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    getowningquest().setstage(6)
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Puzzled", 80)
EndFunction

LielleEmotionManager Property Emotions Auto
