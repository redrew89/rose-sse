ScriptName TIF__050803AA extends TopicInfo Hidden

scene Property aScene Auto

_csq_dlc1script Property CSQ Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    CSQ.dlc1Serana2TopicSay()
    aScene.Start()
EndFunction

