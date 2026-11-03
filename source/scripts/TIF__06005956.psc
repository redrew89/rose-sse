ScriptName TIF__06005956 extends TopicInfo Hidden

quest Property LielleCSQMain Auto

Function Fragment_2(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (LielleCSQMain as lielle_csqbanterscript).SetBanterStage("Sofia", 1)
EndFunction

Function Fragment_3(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Embarrassed", 80)
EndFunction

LielleEmotionManager Property Emotions Auto
