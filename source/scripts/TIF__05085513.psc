ScriptName TIF__05085513 extends TopicInfo Hidden

scene Property aScene Auto

_csq_dlc1script Property CSQ Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    CSQ.dlc1EndTopicSay()
    aScene.Start()
EndFunction

