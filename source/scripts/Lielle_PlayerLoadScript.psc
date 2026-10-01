Scriptname Lielle_PlayerLoadScript extends ReferenceAlias  

LielleOutfitDetectScript Property OutfitDetect Auto
LielleOutfitScript Property Outfits Auto

LielleXOScript Property XO Auto

LielleCoreScript Property Core Auto

Actor Property Lielle Auto
Faction Property CurrentFollowerFaction Auto

Event OnInit()
	RegisterForSingleUpdate(10)
endEvent

Event OnPlayerLoadGame()


	Core.Msg("LielleCore: Reinitalizing after reload.")
	Outfits.ClearOutfit()
	Outfits.GotoState("InitStart")

	if !GetActorReference().HasLOS(Lielle)
		OutfitDetect.CheckCurrentOutfit()
	else
		RegisterForSingleUpdate(2)
	endif

endEvent

Event OnUpdate()
	OutfitDetect.CheckCurrentOutfit()
endEvent


