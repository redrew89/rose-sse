Scriptname Lielle_MG07SceneTrigger extends ReferenceAlias

Scene Property LielleMG07Scene Auto

Event OnDeath(Actor akKiller)

	if akKiller == Game.GetPlayer()
		LielleMG07Scene.Start()
	endif
	
EndEvent
