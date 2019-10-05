ScriptName ARQKeenEdgeMagicEffectScript extends ActiveMagicEffect

Faction Property pDA07MehrunesRazorImmuneFaction auto


Event OnEffectStart(Actor akTarget, Actor akCaster)

	;Apply this effect if the target is not in the excluded faction
	If akTarget.IsInFaction(pDA07MehrunesRazorImmuneFaction) == 1
		Return
	Else
		;Percent change to kill target based on strength of enchantment
; 		debug.trace(self + " hitting " + akTarget + " Keen Edge enchantment")
		If (Utility.RandomInt() <= self.GetMagnitude())
; 			debug.trace(self + "Instant Kill effect applied on" + akTarget)
			akTarget.Kill()			
		EndIf
	EndIf

EndEvent