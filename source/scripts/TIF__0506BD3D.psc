ScriptName TIF__0506BD3D extends TopicInfo Hidden

liellexoscript Property XOScript Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Disgust", 80)
    XOScript.XOMinus(0.1)
EndFunction

LielleEmotionManager Property Emotions Auto
