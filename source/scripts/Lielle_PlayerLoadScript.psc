Scriptname Lielle_PlayerLoadScript extends ReferenceAlias  

LielleOutfitDetectScript Property OutfitDetect Auto
LielleOutfitScript Property Outfits Auto

LielleXOScript Property XO Auto

LielleCoreScript Property Core Auto

Actor Property Lielle Auto
Faction Property CurrentFollowerFaction Auto

Event OnInit()
	RegisterForMenu("ContainerMenu")
	RegisterForSingleUpdate(10)
endEvent

Event OnPlayerLoadGame()

	RegisterForMenu("ContainerMenu") ; Saves from before the trade freeze never ran OnInit's registration
	Lielle.SetDontMove(false) ; Never stay frozen across a load

	Core.Msg("LielleCore: Reinitalizing after reload.")
	if XO
		XO.UpdateTier() ; Saves from before the tier existed have none until it is recalculated
	endif
	Outfits.ClearOutfit()
	Outfits.GotoState("InitStart")
	Outfits.ApplyBody() ; Body model changes reset on load - restores Always Nude or a scene's nudity

	if !GetActorReference().HasLOS(Lielle)
		OutfitDetect.CheckCurrentOutfit()
	else
		RegisterForSingleUpdate(2)
	endif

endEvent

Event OnUpdate()
	OutfitDetect.CheckCurrentOutfit()
endEvent

Event OnMenuOpen(string menuName)
	; ContainerMenu also opens for chests - only freeze her when it's her inventory (unpaused menus let her wander off)
	if Game.GetCurrentCrosshairRef() == Lielle
		Lielle.SetDontMove(true)
	endif
endEvent

Event OnMenuClose(string menuName)
	Lielle.SetDontMove(false)
endEvent


