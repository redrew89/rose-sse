Scriptname Lielle_AncanoDeathScript extends ReferenceAlias  

Quest Property LielleCSQmg Auto

Event OnDeath(Actor akKiller)

	LielleCSQmg.SetStage(40)
	(LielleCSQmg.GetAlias(17) as ReferenceAlias).GetActorReference().EvaluatePackage()
		
EndEvent	