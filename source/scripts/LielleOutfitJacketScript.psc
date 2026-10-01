Scriptname LielleOutfitJacketScript extends activemagiceffect  

LielleOutfitScript Property Outfits Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	GetTargetActor().EquipItem(Outfits.ModularJacket)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	GetTargetActor().UnequipItem(Outfits.ModularJacket)

EndEvent
