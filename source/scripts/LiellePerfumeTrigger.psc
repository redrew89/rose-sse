Scriptname LiellePerfumeTrigger extends activemagiceffect  

Message Property LiellePerfumeMsg Auto 
LielleCoreScript Property Core Auto

Event OnActivate(ObjectReference akActor)

	if akActor == Game.GetPlayer()
		if Core.LiellePerfumeDiag == 0
			Core.LiellePerfumeDiag = 1
		endif
		LiellePerfumeMsg.Show()
	endif

EndEvent