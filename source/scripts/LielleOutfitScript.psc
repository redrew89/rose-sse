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
																				int Property iLielleBodyState = 0 Auto
																					LielleCoreScript Property Core Auto
																						String msgFlag = "LielleCore - Outfits: "
																						String sNudeBody = "lielle\\nude\\femalebody_1.nif"
																						String sUnderwearBody = "lielle\\femalebody_1.nif"
																		
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
					ModularJacket = Game.GetFormFromFile(0x000F41, "[Imp] Modular Mage.esp") as Armor ; Adept jacket
					(LielleAlias.GetActorReference()).AddSpell(ModularJacketSpell)
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
			ModularJacket = Game.GetFormFromFile(0x000F41, "[Imp] Modular Mage.esp") as Armor ; Adept jacket
			(LielleAlias.GetActorReference()).AddSpell(ModularJacketSpell)
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

Function SetBody(int iState)

	iLielleBodyState = iState

	if iState == 0 ; underwear always

		ArmorAddon LielleBodyAP = LielleBodyCustom.GetNthArmorAddon(0)
		LielleBodyAP.SetModelPath(sUnderwearBody,false,true)

	elseif iState == 1 ; story-based nudity

		ArmorAddon LielleBodyAP = LielleBodyCustom.GetNthArmorAddon(0)
		if LielleBodyAP.GetModelPath(false,true) != sNudeBody
			sUnderwearBody = LielleBodyAP.GetModelPath(false,true)
		endif

	elseif iState == 2 ; always nude

		ArmorAddon LielleBodyAP = LielleBodyCustom.GetNthArmorAddon(0)
		if LielleBodyAP.GetModelPath(false,true) != sNudeBody
			sUnderwearBody = LielleBodyAP.GetModelPath(false,true)
		endif
		LielleBodyAP.SetModelPath(sNudeBody,false,true)

	endif

EndFunction


bool isNude = false
Function SwapBody()

	ArmorAddon LielleBodyAP = LielleBodyCustom.GetNthArmorAddon(0)

	if iLielleBodyState == 1 && !isNude

		LielleBodyAP.SetModelPath(sNudeBody,false,true)

	elseif isNude

		LielleBodyAP.SetModelPath(sUnderwearBody,false,true)

	endif

EndFunction


Function ClearOutfit()

	Actor Lielle = LielleAlias.GetActorReference()
	;Lielle.UnequipAll()
	if LielleOutfitCurrent.GetValueInt() == 0 
		int i = 0 
		while i < (LielleMisfitOutfitFLST.GetSize())
			if LielleMisfitOutfitFLST.GetAt(i) != LielleClothesMGBoots
				Lielle.RemoveItem(LielleMisfitOutfitFLST.GetAt(i))
			endif
				i +=1
		endWhile
		i = 0
		while i < (LielleResearcherOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleResearcherOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleOutfitWeddingFLST.GetSize())
			Lielle.RemoveItem(LielleOutfitWeddingFLST.GetAt(i))
			i +=1
		endWhile
		Lielle.SetOutfit(LielleCollegeRobes)
	elseif LielleOutfitCurrent.GetValueInt() == 1
		int i = 0 
		
		int total = LielleCollegeRobes.GetNumParts()
		while i < total
			if LielleCollegeRobes.GetNthPart(i) != LielleClothesMGBoots
				Lielle.RemoveItem(LielleCollegeRobes.GetNthPart(i))
			endif
			i +=1
		endWhile
		
		i = 0
		while i < (LielleResearcherOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleResearcherOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleModularOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleModularOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleOutfitWeddingFLST.GetSize())
			Lielle.RemoveItem(LielleOutfitWeddingFLST.GetAt(i))
			i +=1
		endWhile
	elseif LielleOutfitCurrent.GetValueInt() == 2
		int i = 0 
		
		while i < (LielleCollegeRobes.GetNumParts())
			Lielle.RemoveItem(LielleCollegeRobes.GetNthPart(i))
			i +=1
		endWhile
		
		i = 0
		while i < (LielleMisfitOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleMisfitOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleOutfitWeddingFLST.GetSize())
			Lielle.RemoveItem(LielleOutfitWeddingFLST.GetAt(i))
			i +=1
		endWhile
	elseif LielleOutfitCurrent.GetValueInt() == 10
		int i = 0 
		
		int total = LielleCollegeRobes.GetNumParts()
		while i < total
			Lielle.RemoveItem(LielleCollegeRobes.GetNthPart(i))
			i +=1
		endWhile
		
		i = 0
		while i < (LielleMisfitOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleMisfitOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleResearcherOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleResearcherOutfitFLST.GetAt(i))
			i +=1
		endWhile
		i = 0
		while i < (LielleModularOutfitFLST.GetSize())
			Lielle.RemoveItem(LielleModularOutfitFLST.GetAt(i))
			i +=1
		endWhile
	elseif LielleOutfitCurrent.GetValueInt() == 20
		LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	endif
	
	RemoveCloak()
	
EndFunction

Function SetOutfitMisfit()
	LielleOutfitCurrent.SetValueInt(1)	
	
	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleMisfitOutfitFLST.GetSize())
		LielleAlias.GetActorReference().EquipItem(LielleMisfitOutfitFLST.GetAt(i) as Armor, true,true)
		i +=1
	endWhile
	ClearOutfit()
	SetExtra()
EndFunction

Function SetOutfitResearcher()
	LielleOutfitCurrent.SetValueInt(2)	
		
	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleResearcherOutfitFLST.GetSize())
		LielleAlias.GetActorReference().EquipItem(LielleResearcherOutfitFLST.GetAt(i) as Armor, true,true)
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
	
	LielleAlias.GetActorReference().SetOutfit(LielleEmptyOutfit)
	int i = 0
	while i < (LielleOutfitWeddingFLST.GetSize())
		LielleAlias.GetActorReference().EquipItem(LielleOutfitWeddingFLST.GetAt(i) as Armor, true,true)
		i +=1
	endWhile
	ClearOutfit()
EndFunction

Function SetOutfitDefault(bool abAltOutfit = true)
	if LielleOutfitAlternate.GetValueInt() == 1 && abAltOutfit
		SetOutfitAlternate()
		return
	endif

	LielleOutfitCurrent.SetValueInt(0)

	int itemCount = LielleCollegeRobes.GetNumParts()
    int i = 0
    while i < itemCount
        LielleAlias.GetActorReference().EquipItem((LielleCollegeRobes.GetNthPart(i) as Armor), true,true) ; Auto-equip each item in outfit
        i += 1
    endWhile
	ClearOutfit()

	SetExtra()
EndFunction

Function SetOutfitAlternate()
	LielleOutfitCurrent.SetValueInt(0)

	int i = 0
	while i < (LielleModularOutfitFLST.GetSize())
		LielleAlias.GetActorReference().EquipItem(LielleModularOutfitFLST.GetAt(i) as Armor, true,true)
		i +=1
	endWhile
	ClearOutfit()

	SetExtra()
EndFunction

Function SetCloakOption()

    if (Weather.GetCurrentWeather().GetClassification() == 2 || Weather.GetCurrentWeather().GetClassification() == 3) && LielleOutfitCloak.GetValueInt() == 1 && LielleOutfitCloakToggle.GetValueInt() == 1
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

Function SetExtra()
	
	Actor Lielle = LielleAlias.GetActorReference()
	if LielleARQWord.IsRunning() 
		Lielle.EquipItem(Lielle_GogglesUp,true,true) ; Equip her goggles, if Word Wall research quest is active
	endif
	if IcarusWig != NONE
		Lielle.EquipItem(IcarusWig,true,true) ; Equip her physics wig, if present
	endif
	
	int i = 0	
	int totalItems = Lielle.GetNumItems()

	;Cycle inventory, check for each item that is type ARMOR - equip if not already - may tighten scope to only select jewelry
	while i < totalItems
		Armor currentItem = Lielle.GetNthForm(i) as Armor
		if currentItem && !Lielle.IsEquipped(currentItem)
			Lielle.EquipItem(currentItem, true, true)
		endif
		i += 1
	endWhile	
		
EndFunction

Function ResetOutfits()
	
	LielleMisfitOutfitFLST.Revert()
	LielleResearcherOutfitFLST.Revert()
	LielleOutfitWeddingFLST.Revert()
	LielleOutfitCloakFLST.Revert()
	LielleModularOutfitFLST.Revert()
	bWeddingItemsAdded = false
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