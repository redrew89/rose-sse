ScriptName TIF__05AAF429 extends TopicInfo Hidden

scene Property LielleCSQInigoIntroScene Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_intros).InigoIntro()
    LielleCSQInigoIntroScene.Start()
EndFunction

