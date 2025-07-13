Scriptname LielleXOCharity extends ReferenceAlias

Quest Property LielleXOQPokeUp Auto

Spell Property FavorJobsBeggerAbility Auto
  
Event OnSpellCast(Form akSpell)
	if (akSpell as Spell) == FavorJobsBeggerAbility
		LielleXOQPokeUp.Start()
	endif
endEvent