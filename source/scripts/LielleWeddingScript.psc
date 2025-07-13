Scriptname LielleWeddingScript extends Quest  

ReferenceAlias Property LielleAlias  Auto  
	Quest Property RelationshipMarriage	Auto
		ObjectReference Property LielleSingleBedRef Auto
			ObjectReference Property LielleDoubleBedRef Auto
				LielleOutfitScript Property Outfits Auto
					LielleXOHomeSetScript Property Home Auto
						LielleEmotionManager Property Emotions Auto




Function WeddingStart(ObjectReference akLielle)

	LielleAlias.ForceRefIfEmpty(akLielle)
	RegisterForSingleUpdateGameTime(4)
	
EndFunction

Function WeddingEnd()
	
	RegisterForSingleUpdateGameTime(2)
			
EndFunction

Function BetrothalStart()
	
	RegisterForSingleUpdateGameTime(336) ; 24*14
	
EndFunction

Event OnUpdateGameTime()
;edited code to use ~OutfitScript
	if GetStage() == 20
		SetStage(30)
	endif
	
	if RelationshipMarriage.GetStage() >= 20 && RelationshipMarriage.GetStage() < 100
		Outfits.SetOutfitWedding()
		
	elseif RelationshipMarriage.GetStage() >= 100
		Outfits.SetOutfitDefault()
		
	endif
	
EndEvent
	
Function MoveIn()

	LielleSingleBedRef.Disable()
	LielleDoubleBedRef.Enable()

EndFunction

Function MoveOut()
	
	LielleDoubleBedRef.Disable()
	LielleSingleBedRef.Enable()
	
	; Call function on custom house script
	
	Home.MoveHouse()

endFunction
	