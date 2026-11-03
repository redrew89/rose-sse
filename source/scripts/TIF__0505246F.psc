ScriptName TIF__0505246F extends TopicInfo Hidden

liellefollowerscript Property FollowerScript Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    GetOwningQuest().SetStage(10)
    FollowerScript.DismissFollower(0, 0, akSpeaker)
EndFunction

