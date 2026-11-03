Scriptname LielleOutfitScript extends Quest  

FormList Property LielleMisfitOutfitFLST Auto ; Formlist for containing Misfit Mage Outfit
	Formlist Property LielleOutfitWeddingFLST Auto ; Formlist for Lielle's wedding outfit - manually filled; added to by script
		FormList Property LielleResearcherOutfitFLST Auto ; Formlist for containing DwemerResearcherArmor Outfit
		FormList Property LielleModularOutfitFLST Auto ; Formlist for containing Alternate Default Outfit from Modular Mage
		Armor Property ModularJacket Auto
		Spell Property ModularJacketSpell Auto
			ReferenceAlias Property LielleAlias Auto ; Alias on LielleCSQOutfits - This quest
				ObjectReference Property LielleRef Auto ; Lielle's specific reference, to force if the alias won't fill
					GlobalVariable Property LielleOutfitCurrent Auto ; Current Outfit: 0 - College Robes/Alternate, 1 - Misfit, 2 - Researcher, 10 - Wedding
						GlobalVariable Property LielleOutfitMisfit Auto ; Global used for dialogue conditions
							GlobalVariable Property LielleOutfitResearcher Auto ; Global used for dialogue conditions
							GlobalVariable Property LielleOutfitAlternate Auto ; Global used for dialogue conditions
								Outfit Property LielleCollegeRobes Auto ; Default Outfit
									Armor Property Lielle_GogglesUp Auto ; Lielle's goggles; given to her when LielleARQWord starts up for the first time
										Quest Property LielleARQWord Auto ; Word Wall research quest - Used to check if goggles need equiped
											Armor Property IcarusWig Auto ; Empty armor variable for KS Wig - filled in state InitStart
											Armor Property CambrianWig Auto ; Empty armor Property for KS Wig
												Armor Property LielleClothesMGBoots Auto ; Lielle's regular College boots, added to Misfit formlist
													FormList Property LielleOutfitCloakFLST Auto ; Formlist for cloaks from Cloaks and Capes
														GlobalVariable Property LielleOutfitCloak Auto ; Global to track if cloaks are available
															GlobalVariable Property LielleOutfitCloakToggle Auto ; Global to toggle dynamic cloaks
																Outfit Property LielleEmptyOutfit Auto
																	Armor Property LielleBodyCustom Auto
																			bool Property bWeddingItemsAdded = false Auto
																				bool Property bWigsFound = false Auto
																				int Property iLielleBodyState = 1 Auto ; 0 - Always underwear, 1 - Story-based (default), 2 - Always nude
																					LielleCoreScript Property Core Auto
																						String msgFlag = "LielleCore - Outfits: "
																		
Event OnInit()
	Core.Msg(msgFlag + "Initialization starting, waiting for aliases to initialize...")
    Utility.Wait(2.0)  ; Wait for 2 seconds
    Core.Msg(msgFlag + "Continuing initialization after wait.")
	;SetOutfitDefault()
	GotoState("InitStart")
EndEvent 

Event OnPlayerLoadGame()
		ClearOutfit()
		GotoState("InitStart")
endEvent


State InitStart

	Event OnBeginState()

		if SKSE.GetPluginVersion("FormListManipulator") != -1
			Core.Msg(msgFlag + "FLM Found. Checking formlists.")

			if LielleMisfitOutfitFLST.GetSize() > 0 ||\
			LielleResearcherOutfitFLST.GetSize() > 0 ||\
			LielleModularOutfitFLST.GetSize() > 0 ||\
			LielleOutfitCloakFLST.GetSize() > 0 ||\
			LielleOutfitWeddingFLST.GetSize() > 0
				Core.Msg(msgFlag + "Formlists already populated. Skipping scripted population.",true)
				if LielleMisfitOutfitFLST.GetSize() > 0
					LielleOutfitMisfit.SetValueInt(1)
				endif
				if LielleResearcherOutfitFLST.GetSize() > 0
					LielleOutfitResearcher.SetValueInt(1)
				endif
				if LielleModularOutfitFLST.GetSize() > 0
					LielleOutfitAlternate.SetValueInt(1)
					ModularJacket = Game.GetFormFromFile(0x000F41, "[Imp] Modular Mage.esp") as Armor ; Adept jacket - its ability is granted by SetOutfitAlternate
				endif
				if LielleOutfitCloakFLST.GetSize() > 0
					LielleOutfitCloak.SetValueInt(1)
					LielleOutfitCloakToggle.SetValueInt(1)
				endif
				if LielleOutfitWeddingFLST.GetSize() > 2
					bWeddingItemsAdded = true
				endif

				return
			endif

		endif

		; Consider depreciating this, as I can give her SMP hair at the facegen layer, now
		if (Game.GetModByName("KSWigsSMP.esp") != 255) && IcarusWig == NONE ; Check for KS Wigs SMP
			IcarusWig = Game.GetFormFromFile(0x00000836, "KSWigsSMP.esp") as Armor ; fill Armor property
			if IcarusWig
				Core.Msg(msgFlag + "KS SMP wig found. Enjoy the pretty hair!")
				LielleAlias.GetActorReference().EquipItem(IcarusWig)
				bWigsFound = true
			else
				Core.Msg(msgFlag + "Failed to retrieve Icarus Wig form despite mod detection.", false)
			endif
		else
			Core.Msg(msgFlag + "KSWigsSMP not detected.", false)
		endif
		
		;Add WestWind Misfit Mage outfit to formlist
		bool bMisfitLoaded = Game.GetModByName("WestwindMisfit.esp") != 255
		if bMisfitLoaded && LielleMisfitOutfitFLST.GetSize() == 0 && Game.GetFormFromFile(0x00000005, "WestwindMisfit.esp") ; My conversion with renumbered formIDs
			Core.Msg(msgFlag + "Using renumbered form IDs for Westwind Misfit", false)
			Core.Msg(msgFlag + "West Wind Misfit Mage found. Time to rebel!")
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00000005,"WestwindMisfit.esp"))  ; Dark leggings
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00000D73,"WestwindMisfit.esp"))  ; Harlot Restoration
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00000D75,"WestwindMisfit.esp"))  ; Skirt Restoration
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x0000000A,"WestwindMisfit.esp"))  ; Bracers Restoration
			;LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00003897,"WestwindMisfit.esp"))  ; Dark Bands - temporarily disabled until I can fix the misalignment in my conversion
			LielleMisfitOutfitFLST.AddForm(LielleClothesMGBoots) ; Lielle's college boots
			LielleOutfitMisfit.SetValueInt(1)
		elseif bMisfitLoaded && LielleMisfitOutfitFLST.GetSize() == 0 && Game.GetFormFromFile(0x000012D9, "WestwindMisfit.esp") ; Older conversions/original UNP
			Core.Msg(msgFlag + "Using original form IDs for Westwind Misfit", false)
			Core.Msg(msgFlag + "West Wind Misfit Mage found. Time to rebel!")
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x000012D9,"WestwindMisfit.esp"))  ; Dark trousers
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00000D73,"WestwindMisfit.esp"))  ; Harlot Restoration
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00000D75,"WestwindMisfit.esp"))  ; Skirt Restoration
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x0000436B,"WestwindMisfit.esp"))  ; Bracers Restoration
			LielleMisfitOutfitFLST.AddForm(Game.GetFormFromFile(0x00003897,"WestwindMisfit.esp"))  ; Dark Bands
			LielleMisfitOutfitFLST.AddForm(LielleClothesMGBoots) ; Lielle's college boots
			LielleOutfitMisfit.SetValueInt(1)
		else
			Core.Msg(msgFlag + "West Wind Misfit Mage not found", false)
		endif
		
		;Add Dwemer Researcher outfit to formlist
		if(Game.GetModByName("DwemerResearcherArmor.esp")) != 255 && LielleResearcherOutfitFLST.GetSize() == 0 
			Core.Msg(msgFlag + "Dwemer Researcher found. Fashionable and practical.")
			LielleResearcherOutfitFLST.AddForm(Game.GetFormFromFile(0x0000080F, "DwemerResearcherArmor.esp")) ; Researcher Outfit
			LielleResearcherOutfitFLST.AddForm(Game.GetFormFromFile(0x0000080D, "DwemerResearcherArmor.esp")) ; Researcher Gauntlets
			LielleResearcherOutfitFLST.AddForm(Game.GetFormFromFile(0x00000800, "DwemerResearcherArmor.esp")) ; Researcher Boots
			LielleOutfitResearcher.SetValueInt(1)
		else
			Core.Msg(msgFlag + "Dwarven Researcher not found", false)
		endif

		;Add Modular Mage outfit to formlist - alternate default outfit
		if(Game.GetModByName("[Imp] Modular Mage.esp")) != 255 && LielleModularOutfitFLST.GetSize() == 0
			Core.Msg(msgFlag + "Modular Mage found. Fashionable and practical.")
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x000823, "[Imp] Modular Mage.esp")) ; Adept Corset 3
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x000887, "[Imp] Modular Mage.esp")) ; Adept armwraps
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x00090D, "[Imp] Modular Mage.esp")) ; Adept shorts
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x000913, "[Imp] Modular Mage.esp")) ; Adept stockings 3
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x000D79, "[Imp] Modular Mage.esp")) ; Adept high heels
			LielleModularOutfitFLST.AddForm(Game.GetFormFromFile(0x000EB0, "[Imp] Modular Mage.esp")) ; Adept skirt 3
			ModularJacket = Game.GetFormFromFile(0x000F41, "[Imp] Modular Mage.esp") as Armor ; Adept jacket - its ability is granted by SetOutfitAlternate
			LielleOutfitAlternate.SetValueInt(1)
		else
			Core.Msg(msgFlag + "Modular Mage not found", false)
		endif

		;Add cloaks to formlist
		if(Game.GetModByName("Cloaks.esp")) != 255 && LielleOutfitCloakFLST.GetSize() == 0
			Core.Msg(msgFlag + "Cloaks found. Good, it was getting cold.")
			LielleOutfitCloakFLST.AddForm(Game.GetFormFromFile(0x0000538E, "Cloaks.esp")) ; short Brown linen cape - default outfit
			LielleOutfitCloakFLST.AddForm(Game.GetFormFromFile(0x00012151, "Cloaks.esp")) ; Alternate cloak - Misfit outfit
			LielleOutfitCloakFLST.AddForm(Game.GetFormFromFile(0x0000F613, "Cloaks.esp")) ; Dwemer Purple cloak - Researcher outfit
			LielleOutfitCloak.SetValueInt(1)
			LielleOutfitCloakToggle.SetValueInt(1)
		else
			Core.Msg(msgFlag + "Cloaks not found.", false)
		endif
		
		
		;Add extras to wedding Outfit - using a modcheck for now. Might integrate jewelry options into plugin, if permission is given
		if(Game.GetModByName("KS Jewelry.esp")) != 255 && !bWeddingItemsAdded
			Core.Msg(msgFlag + "KS Jewelry found. Not too gaudy, I hope.")
			LielleOutfitWeddingFLST.AddForm(Game.GetFormFromFile(0x00005378, "KS Jewelry.esp")) ; Crimson Thorn earring
			LielleOutfitWeddingFLST.AddForm(Game.GetFormFromFile(0x00003884, "KS Jewelry.esp")) ; Magdalene choker
			bWeddingItemsAdded = true
		endif
		if(Game.GetModByName("KSWigsSMP.esp")) != 255 
			CambrianWig = Game.GetFormFromFile(0x00000818, "KSWigsSMP.esp") as Armor
			if !(LielleOutfitWeddingFLST.HasForm(CambrianWig))
				LielleOutfitWeddingFLST.AddForm(CambrianWig) ; Cambrian SMP wig
			endif
		endif
	
		DebugOutput()
	
	EndEvent
		
	Event OnInit()
	EndEvent
	
EndState

; 0 - Always underwear, 1 - Story-based (underwear until a scene undresses her), 2 - Always nude
Function SetBody(int iState)
	iLielleBodyState = iState
	if iState != 1
		isNude = false ; Scene nudity only applies in story mode
	endif
	ApplyBody()
EndFunction

bool isNude = false ; Story-based mode: true while a scene has her undressed

; Story-based scenes: toggle between her undergarments and nude. Does nothing outside story mode
Function SwapBody()
	SetSceneNude(!isNude)
EndFunction

Function SetSceneNude(bool abNude)
	if iLielleBodyState != 1
		return
	endif
	isNude = abNude
	ApplyBody()
EndFunction

; Puts the right body on her for the current setting by swapping her skin between LielleBodyCustom and LielleBodyNude.
; Changing the torso addon's model path instead only showed after a reload - QueueNiNodeUpdate keeps the skin mesh it
; already built while the skin form stays the same. Skin changes aren't reliably saved, so Lielle_PlayerLoadScript
; calls this after each load
Function ApplyBody()
	Actor Lielle = LielleAlias.GetActorReference()
	if !Lielle
		Lielle = LielleRef as Actor
	endif
	Armor LielleBodyNude = Game.GetFormFromFile(0x009C0D0F, "Lielle.esp") as Armor
	if !Lielle || !LielleBodyNude
		Core.Msg(msgFlag + "ApplyBody - couldn't find Lielle or her nude body.")
		return
	endif

	Armor wanted = LielleBodyCustom
	if iLielleBodyState == 2 || (iLielleBodyState == 1 && isNude)
		wanted = LielleBodyNude
	endif

	ActorBase LielleBase = Lielle.GetActorBase()
	if LielleBase.GetSkin() != wanted
		LielleBase.SetSkin(wanted)
		if Lielle.Is3DLoaded()
			Lielle.QueueNiNodeUpdate() ; Rebuild her 3D so the new body shows
		endif
	endif
EndFunction


; Outfit state 0 is shared by the College robes and the Modular Mage alternate, so these track which one she has on
bool bAltActive = false ; True while the Modular Mage alternate is the outfit she's wearing
bool bRobesSelected = false ; True once the player asks for the robes by name - default switches keep the robes until ResetOutfits

; True when akItem belongs to the outfit Lielle is set to wear, so cleanup and the equip watcher leave it alone.
; Outfits can share pieces (her College boots are in both the robes and Misfit), which is why this is checked per item.
bool Function IsInCurrentOutfit(Form akItem)
	if !akItem
		return false
	endif
	int current = LielleOutfitCurrent.GetValueInt()
	if current == 0
		if bAltActive
			return LielleModularOutfitFLST.HasForm(akItem) || (ModularJacket && akItem == ModularJacket)
		endif
		return OutfitHasPart(LielleCollegeRobes, akItem)
	elseif current == 1
		return LielleMisfitOutfitFLST.HasForm(akItem)
	elseif current == 2
		return LielleResearcherOutfitFLST.HasForm(akItem)
	elseif current == 10
		return LielleOutfitWeddingFLST.HasForm(akItem)
	endif
	return false
EndFunction

bool Function OutfitHasPart(Outfit akOutfit, Form akItem)
	int i = 0
	int total = akOutfit.GetNumParts()
	while i < total
		if akOutfit.GetNthPart(i) == akItem
			return true
		endif
		i += 1
	endWhile
	return false
EndFunction

; Removes every copy - she can hold both an EquipItem copy and an outfit copy of the same piece
Function RemoveAllOf(Actor akLielle, Form akItem)
	if akItem && !IsInCurrentOutfit(akItem) && !IsGift(akItem)
		int count = akLielle.GetItemCount(akItem)
		if count > 0
			akLielle.RemoveItem(akItem, count)
			Core.Msg(msgFlag + "Removed " + count + "x " + akItem.GetName() + " (" + akItem + ")", false)
		endif
	endif
EndFunction

Function RemoveListItems(Actor akLielle, FormList akList)
	int i = 0
	int total = akList.GetSize()
	while i < total
		RemoveAllOf(akLielle, akList.GetAt(i))
		i += 1
	endWhile
EndFunction

; Gifts - armour the player gave her that passed her modesty check, tracked in LielleOutfitDetectScript's LielleOutfitPlayerFLST.
; They stay locked on across outfits, except in a slot the current outfit has a piece for. A gift put on after the current
; outfit keeps its slot until the player changes her outfit - re-applying the same outfit (load, cell change, MCM reset) leaves it.
int iGiftSlotMask = 0 ; Slots a gift took over after the current outfit went on
int iAppliedOutfit = -1 ; OutfitKey() of the outfit last applied - a different key is a real outfit change

FormList Function GiftList()
	return (GetAlias(0) as LielleOutfitDetectScript).LielleOutfitPlayerFLST
EndFunction

bool Function IsGift(Form akItem)
	FormList kGifts = GiftList()
	return kGifts && kGifts.HasForm(akItem)
EndFunction

; Her own extras that other systems put on - the leftover sweep leaves them alone
bool Function IsExtra(Form akItem)
	return akItem == Lielle_GogglesUp || akItem == IcarusWig || akItem == CambrianWig || akItem == ModularJacket || LielleOutfitCloakFLST.HasForm(akItem)
EndFunction

; Robes and the Modular Mage alternate share outfit state 0, so the alternate gets its own key
int Function OutfitKey()
	if LielleOutfitCurrent.GetValueInt() == 0 && bAltActive
		return 99
	endif
	return LielleOutfitCurrent.GetValueInt()
EndFunction

; Call once the new outfit's state is set. A real change hands every slot back to the outfit
Function BeginOutfit()
	int iKey = OutfitKey()
	if iKey != iAppliedOutfit
		iGiftSlotMask = 0
		iAppliedOutfit = iKey
	endif
EndFunction

; A piece equipped with abPreventRemoval blocks a plain EquipItem into its slot, so the slot is cleared first
Function EquipLocked(Actor akLielle, Armor akItem)
	int iMask = akItem.GetSlotMask()
	int i = 0
	while i < 32
		int iBit = Math.LeftShift(1, i)
		if Math.LogicalAnd(iMask, iBit) != 0
			Form kWorn = akLielle.GetWornForm(iBit)
			if kWorn && kWorn != akItem
				akLielle.UnequipItem(kWorn, false, true)
			endif
		endif
		i += 1
	endWhile
	akLielle.EquipItem(akItem, true, true)
EndFunction

; Outfit pieces skip slots a gift took over since this outfit went on.
; A piece shared with her default outfit (her College boots are also Misfit's) is deleted by the engine when SetOutfit swaps
; outfits, and EquipItem doesn't reliably restore it - so she gets a fresh copy whenever she has none
Function EquipOutfitPiece(Form akItem)
	Armor kPiece = akItem as Armor
	if kPiece && Math.LogicalAnd(kPiece.GetSlotMask(), iGiftSlotMask) == 0
		Actor Lielle = LielleAlias.GetActorReference()
		if Lielle.GetItemCount(kPiece) == 0
			Lielle.AddItem(kPiece, 1, true)
		endif
		EquipLocked(Lielle, kPiece)
	endif
EndFunction

; Called by LielleOutfitDetectScript when she accepts a gift - it takes its slots until her outfit changes
Function EquipGift(Armor akGift)
	if akGift
		EquipLocked(LielleAlias.GetActorReference(), akGift)
		iGiftSlotMask = Math.LogicalOr(iGiftSlotMask, akGift.GetSlotMask())
	endif
EndFunction

int Function ListSlotMask(FormList akList)
	int iMask = 0
	int i = 0
	while i < akList.GetSize()
		Armor kPiece = akList.GetAt(i) as Armor
		if kPiece
			iMask = Math.LogicalOr(iMask, kPiece.GetSlotMask())
		endif
		i += 1
	endWhile
	return iMask
EndFunction

; Every slot the current outfit has a piece for
int Function CurrentOutfitSlotMask()
	int current = LielleOutfitCurrent.GetValueInt()
	if current == 0 && bAltActive
		return ListSlotMask(LielleModularOutfitFLST)
	elseif current == 0
		int iMask = 0
		int i = 0
		while i < LielleCollegeRobes.GetNumParts()
			Armor kPiece = LielleCollegeRobes.GetNthPart(i) as Armor
			if kPiece
				iMask = Math.LogicalOr(iMask, kPiece.GetSlotMask())
			endif
			i += 1
		endWhile
		return iMask
	elseif current == 1
		return ListSlotMask(LielleMisfitOutfitFLST)
	elseif current == 2
		return ListSlotMask(LielleResearcherOutfitFLST)
	elseif current == 10
		return ListSlotMask(LielleOutfitWeddingFLST)
	endif
	return 0
EndFunction

; Strips pieces from every outfit other than the current one, then sets the engine outfit to match
Function ClearOutfit()

	Actor Lielle = LielleAlias.GetActorReference()
	int current = LielleOutfitCurrent.GetValueInt()

	if current == 20 ; Player-provided outfit - her items stay as they are
		Lielle.SetOutfit(LielleEmptyOutfit)
	else
		int i = 0
		int total = LielleCollegeRobes.GetNumParts()
		while i < total
			RemoveAllOf(Lielle, LielleCollegeRobes.GetNthPart(i))
			i += 1
		endWhile
		RemoveListItems(Lielle, LielleMisfitOutfitFLST)
		RemoveListItems(Lielle, LielleResearcherOutfitFLST)
		RemoveListItems(Lielle, LielleModularOutfitFLST)
		RemoveListItems(Lielle, LielleOutfitWeddingFLST)

		if current == 0 && !bAltActive
			Lielle.SetOutfit(LielleCollegeRobes)
		else
			Lielle.SetOutfit(LielleEmptyOutfit)
		endif
	endif

	; The jacket ability only checks that Modular Mage is installed, so it has to go whenever the alternate isn't worn
	if !(current == 0 && bAltActive)
		if ModularJacketSpell
			Lielle.RemoveSpell(ModularJacketSpell)
		endif
		RemoveAllOf(Lielle, ModularJacket)
	endif

	RemoveCloak()

EndFunction

Function SetOutfitMisfit()
	LielleOutfitCurrent.SetValueInt(1)
	BeginOutfit()

	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleMisfitOutfitFLST.GetSize())
		EquipOutfitPiece(LielleMisfitOutfitFLST.GetAt(i))
		i +=1
	endWhile
	ClearOutfit()
	SetExtra()
EndFunction

Function SetOutfitResearcher()
	LielleOutfitCurrent.SetValueInt(2)
	BeginOutfit()

	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleResearcherOutfitFLST.GetSize())
		EquipOutfitPiece(LielleResearcherOutfitFLST.GetAt(i))
		i +=1
	endWhile
	ClearOutfit()
	SetExtra()
	if GetStage() < 40
		SetStage(40)
	endif

EndFunction

Function SetOutfitWedding()
	LielleOutfitCurrent.SetValueInt(10)
	BeginOutfit()

	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleOutfitWeddingFLST.GetSize())
		EquipOutfitPiece(LielleOutfitWeddingFLST.GetAt(i))
		i +=1
	endWhile
	ClearOutfit()
	LogOutfit()
EndFunction

; abAltOutfit = false means the player asked for the College robes - that choice sticks until ResetOutfits
Function SetOutfitDefault(bool abAltOutfit = true)
	if !abAltOutfit
		bRobesSelected = true
	endif
	if LielleOutfitAlternate.GetValueInt() == 1 && !bRobesSelected
		SetOutfitAlternate()
		return
	endif

	bAltActive = false
	LielleOutfitCurrent.SetValueInt(0)
	BeginOutfit()

	int itemCount = LielleCollegeRobes.GetNumParts()
    int i = 0
    while i < itemCount
        EquipOutfitPiece(LielleCollegeRobes.GetNthPart(i))
        i += 1
    endWhile
	ClearOutfit()

	SetExtra()
EndFunction

Function SetOutfitAlternate()
	if LielleOutfitAlternate.GetValueInt() != 1 || LielleModularOutfitFLST.GetSize() == 0
		Core.Msg(msgFlag + "Alternate outfit unavailable - using the College robes.", false)
		SetOutfitDefault(false)
		return
	endif
	bRobesSelected = false ; Asking for the alternate by name clears a robes choice
	bAltActive = true
	LielleOutfitCurrent.SetValueInt(0)
	BeginOutfit()

	Actor Lielle = LielleAlias.GetActorReference()
	Lielle.SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleModularOutfitFLST.GetSize())
		EquipOutfitPiece(LielleModularOutfitFLST.GetAt(i))
		i +=1
	endWhile
	if ModularJacketSpell
		Lielle.AddSpell(ModularJacketSpell, false) ; Jacket goes on outdoors - only granted while the alternate is worn
	endif
	ClearOutfit()

	SetExtra()
EndFunction

; Rain, snow and night are cloak weather - none of them change her outfit. LielleClimateScript calls SetCloakOption when this flips
bool Function IsCloakWeather()
	Weather kCurrent = Weather.GetCurrentWeather()
	if kCurrent && (kCurrent.GetClassification() == 2 || kCurrent.GetClassification() == 3)
		return true
	endif
	float fDays = Utility.GetCurrentGameTime()
	float fHour = (fDays - Math.Floor(fDays)) * 24.0
	return fHour < 6.0 || fHour >= 20.0
EndFunction

Function SetCloakOption()

    if IsCloakWeather() && LielleOutfitCloak.GetValueInt() == 1 && LielleOutfitCloakToggle.GetValueInt() == 1
		if LielleOutfitCurrent.GetValueInt() == 0 && !LielleAlias.GetActorReference().IsEquipped(LielleOutfitCloakFLST.GetAt(0) as Armor)
			; Default Outfit, brown cloak
			LielleAlias.GetActorReference().EquipItem(LielleOutfitCloakFLST.GetAt(0) as Armor)
		elseif LielleOutfitCurrent.GetValueInt() == 1 && !LielleAlias.GetActorReference().IsEquipped(LielleOutfitCloakFLST.GetAt(1) as Armor)
			; Misfit outfit, consider options
			LielleAlias.GetActorReference().EquipItem(LielleOutfitCloakFLST.GetAt(1) as Armor)
		elseif LielleOutfitCurrent.GetValueInt() == 2 && !LielleAlias.GetActorReference().IsEquipped(LielleOutfitCloakFLST.GetAt(2) as Armor)
			; Researcher outfit, purple cloak
			LielleAlias.GetActorReference().EquipItem(LielleOutfitCloakFLST.GetAt(2) as Armor)
		endif
    else
		RemoveCloak()
    endif

EndFunction

; Called by the cloak dialogue fragments (csq_TIF__050111D3/6/7/8)
Function SetCloak()
	SetCloakOption()
EndFunction

Function RemoveCloak()
	
	if LielleOutfitCloakFLST.GetSize() < 3
		return ; Cloaks.esp not installed
	endif
	LielleAlias.GetActorReference().RemoveItem(LielleOutfitCloakFLST.GetAt(0) as Armor)
	LielleAlias.GetActorReference().RemoveItem(LielleOutfitCloakFLST.GetAt(1) as Armor)
	LielleAlias.GetActorReference().RemoveItem(LielleOutfitCloakFLST.GetAt(2) as Armor)

EndFunction

; Runs after an outfit goes on: her extras, then gifts, then anything left over
Function SetExtra()

	Actor Lielle = LielleAlias.GetActorReference()
	if LielleARQWord.IsRunning()
		Lielle.EquipItem(Lielle_GogglesUp,true,true) ; Equip her goggles, if Word Wall research quest is active
	endif
	if IcarusWig != NONE
		Lielle.EquipItem(IcarusWig,true,true) ; Equip her physics wig, if present
	endif

	; Gifts lock on, except in a slot the outfit has a piece for - unless the gift took that slot after this outfit went on
	int iOutfitMask = Math.LogicalAnd(CurrentOutfitSlotMask(), Math.LogicalNot(iGiftSlotMask))
	FormList kGifts = GiftList()
	int i = 0
	if kGifts
		while i < kGifts.GetSize()
			Armor kGift = kGifts.GetAt(i) as Armor
			if kGift && Lielle.GetItemCount(kGift) > 0
				if Math.LogicalAnd(kGift.GetSlotMask(), iOutfitMask) != 0
					if Lielle.IsEquipped(kGift)
						Lielle.UnequipItem(kGift, false, true) ; The outfit piece takes this slot - the gift stays in her inventory
					endif
				elseif !Lielle.IsEquipped(kGift)
					EquipLocked(Lielle, kGift)
				endif
			endif
			i += 1
		endWhile
	endif

	; Leftovers - armour in no outfit list, not a gift and not an extra (e.g. pieces from an older version of a list)
	; come off but stay in her inventory
	i = 0
	int totalItems = Lielle.GetNumItems()
	while i < totalItems
		Armor kItem = Lielle.GetNthForm(i) as Armor
		if kItem && Lielle.IsEquipped(kItem) && !IsInCurrentOutfit(kItem) && !IsGift(kItem) && !IsExtra(kItem)
			Lielle.UnequipItem(kItem, false, true)
			Core.Msg(msgFlag + "Unequipped leftover " + kItem.GetName() + " (" + kItem + ")", false)
		endif
		i += 1
	endWhile

	LogOutfit()
EndFunction

Function ResetOutfits()
	
	LielleMisfitOutfitFLST.Revert()
	LielleResearcherOutfitFLST.Revert()
	LielleOutfitWeddingFLST.Revert()
	LielleOutfitCloakFLST.Revert()
	LielleModularOutfitFLST.Revert()
	bWeddingItemsAdded = false
	bRobesSelected = false ; Back to the alternate default, if Modular Mage is installed
	bAltActive = false
	GotoState("") ; Already in InitStart - leave first so OnBeginState runs again and refills the lists
	GotoState("InitStart")
	LielleAlias.GetActorReference().SetOutfit(LielleCollegeRobes)

EndFunction

String[] Function ReturnOutfits()

	String[] outfitsList = new string[5]
	outfitsList[0] = "Default"
	outfitsList[1] = "Wedding Day"
	outfitsList[2] = "Misfit Mage"
	outfitsList[3] = "Dwemer Researcher"
	outfitsList[4] = "Modular Mage (Alternate Default)"

	return outfitsList

EndFunction

Function DebugOutput()
	
	int misfitSize = LielleMisfitOutfitFLST.GetSize()
    Core.Msg(msgFlag + "LielleMisfitOutfitFLST contains " + misfitSize + " items.", false)
    int i = 0
    while i < misfitSize
        Core.Msg(msgFlag + "Misfit Outfit Item " + i + ": " + LielleMisfitOutfitFLST.GetAt(i), false)
        i += 1
    endWhile

    int researcherSize = LielleResearcherOutfitFLST.GetSize()
    Core.Msg(msgFlag + "LielleResearcherOutfitFLST contains " + researcherSize + " items.", false)
    i = 0
    while i < researcherSize
        Core.Msg(msgFlag + "Researcher Outfit Item " + i + ": " + LielleResearcherOutfitFLST.GetAt(i), false)
        i += 1
    endWhile
	
	int cloakSize = LielleOutfitCloakFLST.GetSize()
	Core.Msg(msgFlag + "LielleOutfitCloakFLST contains " + cloakSize + " items.", false)
	i = 0
	while i < cloakSize
		Core.Msg(msgFlag + i + ": " + LielleOutfitCloakFLST.GetAt(i), false)
		i += 1
	endWhile
	
	int WeddingSize = LielleOutfitWeddingFLST.GetSize()
	Core.Msg(msgFlag + "LielleOutfitWeddingFLST contains " + WeddingSize + " items.", false)
	i = 0
	while i < WeddingSize
		Core.Msg(msgFlag + "Wedding item " + i + ": " + LielleOutfitWeddingFLST.GetAt(i), false)
		i += 1
	endWhile
		
    if IcarusWig == NONE
		Core.Msg(msgFlag + "KS Wigs variable not filled. Check if installed.", false)
	endif
	
EndFunction

; Writes the outfit state and every filled armour slot to Lielle.log - the trace for outfit-mixing reports
Function LogOutfit()
	Actor Lielle = LielleAlias.GetActorReference()
	string sWorn = ""
	int i = 0
	while i < 32
		Form kWorn = Lielle.GetWornForm(Math.LeftShift(1, i))
		if kWorn && StringUtil.Find(sWorn, "(" + kWorn + ")") < 0
			sWorn += kWorn.GetName() + " (" + kWorn + "), "
		endif
		i += 1
	endWhile
	Core.Msg(msgFlag + "Outfit " + LielleOutfitCurrent.GetValueInt() + " (alternate " + bAltActive + ", robes chosen " + bRobesSelected + ") wearing: " + sWorn, false)
EndFunction
