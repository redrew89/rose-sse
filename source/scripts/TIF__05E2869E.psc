ScriptName TIF__05E2869E extends TopicInfo Hidden

armor Property DA13Spellbreaker Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.Getplayer().RemoveItem(DA13Spellbreaker, 1, false)
    GetOwningQuest().SetStage(5)
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Happy", 80)
EndFunction

LielleEmotionManager Property Emotions Auto
