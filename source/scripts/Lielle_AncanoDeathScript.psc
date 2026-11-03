Scriptname Lielle_AncanoDeathScript extends ReferenceAlias  

Quest Property LielleCSQmg Auto
Scene Property LielleCSQmgAncanoDeathScene Auto

Event OnDeath(Actor akKiller)

	LielleCSQmg.SetStage(37) ; not 40 - stage 40 is the post-College late-add start, which gates the Archmage intro
	(LielleCSQmg.GetAlias(17) as ReferenceAlias).GetActorReference().EvaluatePackage()
	LielleCSQmgAncanoDeathScene.Start()
		
EndEvent	