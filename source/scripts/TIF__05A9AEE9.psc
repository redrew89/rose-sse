ScriptName TIF__05A9AEE9 extends TopicInfo Hidden

scene Property LielleCSQRumarinIntroScene Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_intros).RumarinIntro()
    LielleCSQRumarinIntroScene.Start()
EndFunction

