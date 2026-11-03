ScriptName TIF__06BB26B7 extends TopicInfo Hidden

scene Property LielleNightmareCampAlt Auto

scene Property aScene Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    aScene.Start()
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Sad", 80)
EndFunction

LielleEmotionManager Property Emotions Auto
