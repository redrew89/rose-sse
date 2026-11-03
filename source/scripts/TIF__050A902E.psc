ScriptName TIF__050A902E extends TopicInfo Hidden

soulgem Property DA01SoulGemBlackStar Auto

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    getowningquest().setstage(20)
EndFunction

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.GetPlayer().RemoveItem(DA01SoulGemBlackStar, 1, false)
EndFunction

