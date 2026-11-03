Scriptname LielleAllyPeaceEffect extends ActiveMagicEffect
{Distributed by SPID to followers who travel with Lielle. If the actor enters combat against Lielle, combat is dropped on both sides. Fights between other NPCs are left alone.}

Faction Property LielleAlliesFaction Auto ; unused - kept so the plugin's existing VMAD binding resolves
ReferenceAlias Property LielleAlias Auto ; LielleCSQMain Lielle_Alias
Scene Property LielleCSQffApology Auto ; her friendly-fire apology

int iCalmCount = 0 ; times this follower has been calmed against Lielle

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if aeCombatState == 0 || !akTarget
		return
	endif

	Actor akLielle = LielleAlias.GetActorReference()
	if akTarget != akLielle
		return
	endif

	Actor akSelf = GetTargetActor()
	akSelf.StopCombat()
	akSelf.StopCombatAlarm()

	; Only calm Lielle if she is fighting back at us, not at a real enemy
	if akLielle.GetCombatTarget() == akSelf
		akLielle.StopCombat()
		akLielle.StopCombatAlarm()
	endif

	; Lielle apologizes for the stray spell on every 4th fight called off.
	; If the scene is busy on that 4th, the count holds and the next one plays it.
	iCalmCount += 1
	if iCalmCount >= 4 && !LielleCSQffApology.IsPlaying()
		iCalmCount = 0
		LielleCSQffApology.Start()
	endif
EndEvent
