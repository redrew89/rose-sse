ScriptName TIF__050A9037 extends TopicInfo Hidden

soulgem Property DA01SoulGemAzurasStar Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.getplayer().additem(DA01SoulGemAzurasStar, 1, false)
EndFunction

