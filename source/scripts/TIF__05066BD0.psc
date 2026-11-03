ScriptName TIF__05066BD0 extends TopicInfo Hidden

liellexoscript Property LielleXO Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Wary", 80)
    LielleXO.XOMinus(0.3)
EndFunction

LielleEmotionManager Property Emotions Auto
