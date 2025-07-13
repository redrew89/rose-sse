Scriptname zzTearsApplyScript extends activemagiceffect  

Spell Property zzTearsTestAbility Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	If akTarget.HasSpell(zzTearsTestAbility)
		akTarget.RemoveSpell(zzTearsTestAbility)
	Else
		akTarget.AddSpell(zzTearsTestAbility, false)
	EndIf

EndEvent