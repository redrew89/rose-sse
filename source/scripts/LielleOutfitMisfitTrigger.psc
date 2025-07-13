Scriptname LielleOutfitMisfitTrigger extends ObjectReference  

Scene Property LielleMisfitChestScene  Auto  
Quest Property LielleCSQOutfits Auto
GlobalVariable Property LielleOutfitMisfit Auto
	
Event OnTriggerEnter(ObjectReference akTrigger)
	if akTrigger == Game.GetPlayer() && (LielleOutfitMisfit.GetValueInt() == 1 && LielleCSQOutfits.GetStage() == 1 )
		LielleMisfitChestScene.Start()
		LielleCSQOutfits.SetStage(10)	
	endif
EndEvent