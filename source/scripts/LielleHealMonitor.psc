Scriptname LielleHealMonitor extends ReferenceAlias

ReferenceAlias Property LielleHealerAlias Auto

Actor Property Lielle Auto

Actor Property PlayerRef Auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	if PlayerRef.GetActorValuePercentage("Health") <= 0.25
		LielleHealerAlias.ForceRefIfEmpty(Lielle)
		(LielleHealerAlias.GetReference() as Actor).EvaluatePackage()
	endIf
		
EndEvent 
