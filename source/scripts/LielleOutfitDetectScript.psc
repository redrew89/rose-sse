Scriptname LielleOutfitDetectScript extends ReferenceAlias  


;Keywords assigned to outfits via KID
Keyword Property LielleOutfitSkimpy Auto ; Keyword for skimpy outfits - Shows some skin, but still somewhat tasteful - eg; Remodeled Armor
	Keyword Property LielleOutfitRevealing Auto ; Keyword for revealing outfits that show a lot of skin - eg; Bikini Armor, Modular Mage
		Keyword Property LielleOutfitScandalous Auto ; Keyword for highly sexualized outfits, particularly exposed genitals or breasts - eg; lingerie or fetish outfits, certain items in Modular Mage
			Keyword Property LielleOutfitForbidden Auto ; TODO - Add to plugin and set property value - Keyword assigned to outfits that Lielle would never wear: Forsworn, Thalmor, etc
			; Scenes for indication of refusal/acceptance
			Scene Property LielleOutfitRefusalScene Auto ; Scene for outfit refusal dialogue - Low Affection
				Scene Property LielleOutfitUncomfortableScene Auto ; Scene for reluctant outfit acceptance dialogues - revealing and scandelous outfits - Moderate Affection
					Scene Property LielleOutfitAcceptanceScene Auto ; Scene for outfit acceptance dialogues
						;Other scripts
						LielleXOScript Property XO Auto ; LielleXOScript to check Affection
								LielleOutfitScript Property OutfitManager Auto
									; Misc Properties
									ObjectReference Property LielleRejectedOutfitsContainer Auto ; Container used for rejected outfits, accessed via dialogue
										GlobalVariable Property LielleOutfitReject Auto ; Global used for conditional logic
											Formlist Property LielleOutfitPlayerFLST Auto ; Formlist used for items given by player
												Faction Property CurrentFollowerFaction Auto ; Follower Faction


; TODO - Secondary GlobalVariable LielleOutfitRefusedTier - indicates how severe her response would be in the refusal scene. Can be added in 0.6.0 update
					
string msgFlag = "LielleCore - Outfits: "					
					
Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	
	if akBaseObject == OutfitManager.LielleCollegeRobes.GetNthPart(1)
		CheckCurrentOutfit()
		OutfitManager.Core.Msg(msgFlag + "Checking if Lielle is wearing the right outfit.", false)		
	elseif akBaseObject == OutfitManager.IcarusWig || akBaseObject == OutfitManager.CambrianWig
		OutfitManager.Core.Msg(msgFlag + "Ignoring equip event for SMP wig.", false)
		return
	endif
	bool bIsOutfitItem
	int i = 0 
	int total = OutfitManager.LielleCollegeRobes.GetNumParts()
	while i < total
		if OutfitManager.LielleCollegeRobes.GetNthPart(i) 
			bIsOutfitItem = true
		endif
		i +=1
	endWhile
	if (OutfitManager.LielleMisfitOutfitFLST.HasForm(akBaseObject) || OutfitManager.LielleResearcherOutfitFLST.HasForm(akBaseObject) || OutfitManager.LielleOutfitWeddingFLST.HasForm(akBaseObject) || OutfitManager.LielleOutfitCloakFLST.HasForm(akBaseObject)) 
		bIsOutfitItem = true
	endif
	if !(LielleOutfitPlayerFLST.HasForm(akBaseObject)) && akBaseObject.GetType() == 26 && !bIsOutfitItem
		if LielleOutfitPlayerFLST.GetSize() == 0
			OutfitManager.Core.Msg(msgFlag + "Defining player-provided outfit.", false)
		endif
		LielleOutfitPlayerFLST.AddForm(akBaseObject as Armor) 
		OutfitManager.Core.Msg(msgFlag + "added item to formlist: " + akBaseObject.GetName(), false)
		OutfitManager.LielleOutfitCurrent.SetValueInt(20) ; Custom outfit flag - used to prevent outfit enforcement overriding
		OutfitManager.ClearOutfit()
	endif
	
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	if akBaseItem.GetType() == 26 
		ValidateItem(akBaseItem)
	endif
		
endEvent

Event OnPlayerLoadGame()

	if !GetActorReference().IsInFaction(CurrentFollowerFaction) 
		CheckCurrentOutfit()
	endif

EndEvent

Event OnCellAttach()

	if !GetActorReference().IsInFaction(CurrentFollowerFaction)
		CheckCurrentOutfit()
	endif

EndEvent


Function CheckCurrentOutfit()

	int currentOutfit = OutfitManager.LielleOutfitCurrent.GetValueInt()
    
    if currentOutfit == 1
        OutfitManager.SetOutFitMisfit()
    elseif currentOutfit == 2
        OutfitManager.SetOutfitResearcher()
    elseif currentOutfit == 10
        OutfitManager.SetOutfitWedding()
	elseif currentOutfit == 20 ; Player-provided
		return
	else
		OutfitManager.SetOutfitDefault()
    endif
	
	if GetActorReference().GetWornForm(0x00000004) == NONE
		OutfitManager.SetOutfitDefault()
	endif
		
endFunction

Function ValidateItem(Form currentForm)
	Actor Lielle = self.GetActorReference()
	int itemCount
	
	if currentForm.HasKeyword(LielleOutfitSkimpy) && XO.LielleXOVar < 5
		;refusal
		itemcount = Lielle.GetItemCount(currentForm)
		Lielle.RemoveItem(currentForm, itemCount, false, LielleRejectedOutfitsContainer)
		LielleOutfitPlayerFLST.RemoveAddedForm(currentForm)
		LielleOutfitReject.SetValueInt(1)
		OutfitManager.Core.Msg(msgFlag + "Removed an item because it was skimpy. " + currentForm.GetName())
	elseif currentForm.HasKeyword(LielleOutfitRevealing) && XO.LielleXOVar < 7
		;refusal 
		itemCount = Lielle.GetItemCount(currentForm)
		Lielle.RemoveItem(currentForm, itemCount, false, LielleRejectedOutfitsContainer)
		LielleOutfitPlayerFLST.RemoveAddedForm(currentForm)
		LielleOutfitReject.SetValueInt(1)
		OutfitManager.Core.Msg(msgFlag + "Removed an item because it was revealing. " + currentForm.GetName())
	elseif currentForm.HasKeyword(LielleOutfitScandalous) && XO.LielleXOVar < 9
		;refusal
		itemCount = Lielle.GetItemCount(currentForm)
		Lielle.RemoveItem(currentForm, itemCount, false, LielleRejectedOutfitsContainer)
		LielleOutfitPlayerFLST.RemoveAddedForm(currentForm)
		LielleOutfitReject.SetValueInt(1)
		OutfitManager.Core.Msg(msgFlag + "Removed an item because it was scandalous. " + currentForm.GetName())
	elseif currentForm.HasKeyword(LielleOutfitForbidden) 
		;hard refusal, no affection thresold
		itemCount = Lielle.GetItemCount(currentForm)
		Lielle.RemoveItem(currentForm, itemCount, false, LielleRejectedOutfitsContainer)
		LielleOutfitPlayerFLST.RemoveAddedForm(currentForm)
		LielleOutfitReject.SetValueInt(1)
		OutfitManager.Core.Msg(msgFlag + "Removed an item because it was forbidden. " + currentForm.GetName())
	else
		;acceptance
		GetActorReference().EquipItem(currentForm as Armor,true,true)
		;OutfitManager.LielleOutfitCurrent.SetValueInt(20)
	endif
	
	bool allowedOutfit = (GetActorReference().WornHasKeyword(LielleOutfitSkimpy) || GetActorReference().WornHasKeyword(LielleOutfitRevealing) || GetActorReference().WornHasKeyword(LielleOutfitScandalous))
	
	if LielleOutfitReject.GetValueInt() == 1
		RefuseOutfit()
	elseif LielleOutfitReject.GetValueInt() == 0 && allowedOutfit
		OutfitManager.Core.Msg(msgFlag + "Accepted an item based on Affection.")
		AcceptOutfit()
	endif
	
endFunction

			
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
			
	if (akDestContainer == LielleRejectedOutfitsContainer || akDestContainer == Game.GetPlayer()) && LielleOutfitPlayerFLST.HasForm(akBaseItem)
		LielleOutfitPlayerFLST.RemoveAddedForm(akBaseItem)
		OutfitManager.Core.Msg(msgFlag + "Removed item from player-provided outfit: " + akBaseItem.GetName())
	else
		return
	endif
	
	if LielleOutfitPlayerFLST.GetSize() == 0 && OutfitManager.LielleOutfitCurrent.GetValueInt() == 20
		OutfitManager.SetOutfitDefault()
		OutfitManager.Core.Msg(msgFlag + "Player-provided outfit cleared. Reverting to default.")
	else	
		CheckCurrentOutfit()
	endif		
	
endEvent

Function RefuseOutfit()	
	LielleOutfitRefusalScene.Start()
	CheckCurrentOutfit()
endFunction

Function AcceptOutfit()
	LielleOutfitAcceptanceScene.Start()
endFunction

