Scriptname Lielle_DeathSceneTrigger extends ReferenceAlias


Scene Property LielleMiscScene Auto


Event OnDeath(Actor akKiller)

	if akKiller == Game.GetPlayer()
		LielleMiscScene.start()
	endif
	
EndEvent
