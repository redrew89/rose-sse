ScriptName TIF__06BAD555 extends TopicInfo Hidden

referencealias Property Bandit1 Auto

referencealias Property Bandit2 Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    Bandit1.GetActorRef().DrawWeapon()
    Bandit2.GetActorRef().DrawWeapon()
EndFunction

