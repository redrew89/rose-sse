Scriptname LiellePlayerWeaponMonitor extends ActiveMagicEffect


ReferenceAlias Property LielleAlias Auto

Event OnEffectStart(actor aktarget, actor akcaster)

	(LielleAlias.GetActorReference()).EvaluatePackage()

EndEvent


Event OnEffectFinish(actor aktarget, actor akcaster)

	(LielleAlias.GetActorReference()).EvaluatePackage()

EndEvent
