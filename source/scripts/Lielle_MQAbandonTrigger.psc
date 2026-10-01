Scriptname Lielle_MQAbandonTrigger extends ReferenceAlias  

Quest Property LielleCSQmqPaarAbandon Auto

Quest Property MQPaarthurnax Auto

Event OnCombatStateChanged(actor akTarget, int aeCombatState)
	if MQPaarthurnax.IsRunning()
		;LielleCSQmqPaarAbandon.Start()
		LielleCSQmqPaarAbandon.SetStage(10)
	endif
endevent
