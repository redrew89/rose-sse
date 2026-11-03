ScriptName TIF__05D6C6EF extends TopicInfo Hidden

armor Property DA13Spellbreaker Auto

book Property ARQWardTome Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Emotions.HandleEmotions("Happy", 90)
    game.GetPlayer().AddItem(DA13Spellbreaker, 1, false)
EndFunction

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.GetPlayer().AddItem(ARQWardTome, 1, false)
    GetOwningQuest().SetStage(15)
EndFunction

LielleEmotionManager Property Emotions Auto
