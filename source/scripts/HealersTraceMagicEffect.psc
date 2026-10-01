; HealersTraceMagicEffect.psc
ScriptName HealersTraceMagicEffect extends ActiveMagicEffect  

HealersTraceQuest Property TraceQuest Auto

Event OnEffectStart(Actor target, Actor caster)
    If TraceQuest.IsTracked(target)
        TraceQuest.RemoveTrackedNPC(target)
    Else
        TraceQuest.AddTrackedNPC(target)
    EndIf
EndEvent