Scriptname Lielle_DeathSceneTrigger extends ReferenceAlias


Scene Property LielleMiscScene Auto
Scene Property LiellePlayerDeathScene Auto

Event OnDeath(Actor akKiller)

	if akKiller == Game.GetPlayer()
		LielleMiscScene.start()
	elseif akKiller != Game.GetPlayer() && GetActorReference() == Game.GetPlayer()
		LiellePlayerDeathScene.start()
	endif
	
EndEvent
