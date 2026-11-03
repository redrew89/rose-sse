ScriptName TIF__05AAF42B extends TopicInfo Hidden

scene Property LielleCSQSofiaIntroScene Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_intros).SofiaIntro()
    LielleCSQSofiaIntroScene.Start()
EndFunction

