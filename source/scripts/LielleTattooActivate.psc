Scriptname LielleTattooActivate extends ReferenceAlias  

Message Property LielleCSQTattooMSG Auto

Armor Property TattooGlow Auto

MiscObject Property GlowMixture Auto

Event OnActivate(ObjectReference akActionRef)

	if GetOwningQuest().GetStage() == 10
		
		int iButton = LielleCSQTattooMSG.Show()
		
		if iButton == 0
			;fade to black, equip tattoo glow object to Lielle's Reference
			DoFadeOut(0.3)
			GetActorReference().EquipItem(TattooGlow, true)
			Game.GetPlayer().RemoveItem(GlowMixture, 1)
			Utility.Wait(3)
			DoFadeIn(0.3)
			GetOwningQuest().SetStage(20)
		endif 
	endif
endEvent

;IMS Property
;object under ImageSpaceModifier FadeToBlackHoldImod
ImageSpaceModifier Property FadeToBlackHold auto


;*****************************************
;Fade Functions

Function DoFadeOut (Float Time)
	FadeToBlackHold.ApplyCrossFade (Time)
  	Utility.Wait (Time)
	Game.FadeOutGame (False,True,50,1)
EndFunction


Function DoFadeIn (Float Time)
	Game.FadeOutGame (False,True,0.1,0.1)
	ImageSpaceModifier.RemoveCrossFade (Time)
EndFunction

;****************************************