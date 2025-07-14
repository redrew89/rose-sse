Scriptname Lielle_HealPlayer extends ReferenceAlias  


ReferenceAlias Property LielleHealerAlias Auto


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
	if Game.GetPlayer().GetActorValuePercentage("Health") <= 0.5
		(LielleHealerAlias.GetReference() as Actor).EvaluatePackage()
	endif
EndEvent
	
