ScriptName TIF__05A499C9 extends TopicInfo Hidden

armor Property ElderScrollHandAttachArmor3rdP Auto

book Property ElderScrollDragon Auto

scene Property LielleCSQScrollScene Auto

Function Fragment_1(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    (GetOwningQuest() as _csq_mqscript).mq205Scroll2Say()
EndFunction

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    LielleCSQScrollScene.Start()
EndFunction

