ScriptName TIF__0507B24D extends TopicInfo Hidden

liellefollowerscript Property Follower Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Follower.DismissFollower(0, 1, akSpeaker)
EndFunction

