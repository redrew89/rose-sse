Scriptname _ARQ_WardReflectScript extends ActiveMagicEffect  

actor player
actor caster
objectReference casterREF
objectReference playerREF
Sound PROPERTY MAGWardTestDeflect Auto
Spell Property Flames auto
Spell Property Frostbite auto
Spell Property Sparks auto 

Event OnEffectStart(Actor akTarget, Actor akCaster)
	player = game.getPlayer()
	playerREF = (player as ObjectReference)
	caster = akCaster
	casterRef = (caster as ObjectReference)
endEVENT

EVENT onHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	
	if (akSource as spell) != NONE && ((akSource as Spell).GetNthEffectMagicEffect(1)).GetCastingType() != 2
			int reflectsoundID = MAGWardTestDeflect.play(casterREF)          ; play MAGWardTestDeflect sound from casterREF
			Sound.SetInstanceVolume(reflectsoundID, 2.0)         ; play at double volume	
			(akSource as Spell).cast(caster, akAggressor)
	endif

endEVENT
