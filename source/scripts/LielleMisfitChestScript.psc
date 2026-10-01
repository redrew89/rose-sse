Scriptname LielleMisfitChestScript extends ReferenceAlias  

Scene Property LielleCSQMisfitChestScene Auto
	Quest Property LielleCSQOutfits Auto
	

Event OnOpen(ObjectReference akActionRef)

	if (akActionRef == Game.GetPlayer()) && LielleCSQOutfits.GetStage() < 10	
		LielleCSQMisfitChestScene.Start()
		LielleCSQOutfits.SetStage(10)
	endif	

	
EndEvent