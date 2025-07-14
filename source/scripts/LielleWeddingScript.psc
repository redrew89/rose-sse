Scriptname LielleWeddingScript extends Quest  

ReferenceAlias Property LielleAlias  Auto  

Quest Property RelationshipMarriage	Auto

ObjectReference Property LielleSingleBedRef Auto

ObjectReference Property LielleDoubleBedRef Auto

Armor Property LielleCollegeRobes Auto

Armor Property LielleCollegeBoots Auto

Armor Property LielleWeddingDress Auto

Armor Property LielleWeddingShoes Auto  


Function WeddingStart(ObjectReference akLielle)

	LielleAlias.ForceRefIfEmpty(akLielle)
	RegisterForSingleUpdateGameTime(4)
	
EndFunction

Function WeddingEnd()
	
	RegisterForSingleUpdateGameTime(2)
			
EndFunction

Event OnUpdateGameTime()

	if RelationshipMarriage.GetStage() >= 20 && RelationshipMarriage.GetStage() < 100
		(LielleAlias.GetReference() as Actor).EquipItem(LielleWeddingDress, true)
		(LielleAlias.GetReference() as Actor).EquipItem(LielleWeddingShoes, true)
	elseif RelationshipMarriage.GetStage() >= 100
		(LielleAlias.GetReference() as Actor).EquipItem(LielleCollegeRobes)
		(LielleAlias.GetReference() as Actor).EquipItem(LielleCollegeBoots)
		LielleAlias.GetReference().RemoveItem(LielleWeddingDress,1)
		LielleAlias.GetReference().RemoveItem(LielleWeddingShoes,1)		
	endif
EndEvent
	
Function MoveIn()

	LielleSingleBedRef.Disable()
	LielleDoubleBedRef.Enable()

EndFunction

Function MoveOut()
	
	LielleDoubleBedRef.Disable()
	LielleSingleBedRef.Enable()

endFunction
	