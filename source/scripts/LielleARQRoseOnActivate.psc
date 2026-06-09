Scriptname LielleARQRoseOnActivate   

Quest Property LielleARQRoseNeloth Auto

Event OnActivate(ObjectReference akActivator)

	if akActivator == Game.GetPlayer() && LielleARQRoseNeloth.GetStage() > 30
		LielleARQRoseNeloth.SetStage(30)
	endif

EndEvent