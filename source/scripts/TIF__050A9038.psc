ScriptName TIF__050A9038 extends TopicInfo Hidden

soulgem Property DA01SoulGemBlackStar Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.getplayer().additem(DA01SoulGemBlackStar, 1, false)
EndFunction

