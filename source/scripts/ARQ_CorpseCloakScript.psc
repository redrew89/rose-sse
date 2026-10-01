Scriptname ARQ_CorpseCloakScript extends activemagiceffect  

Formlist Property LielleARQCorpseRaces Auto

Quest Property LielleARQAnatomy Auto

Event OnEffectStart(actor akTarget, actor akCaster)

	if akTarget.IsDead() && LielleARQCorpseRaces.Find(akTarget.GetRace()) != -1
		
		(LielleARQAnatomy.GetAlias(1) as ReferenceAlias).ForceRefTo(akTarget as ObjectReference)
		LielleARQAnatomy.SetObjectiveDisplayed(1)		
		
	endif

EndEvent

