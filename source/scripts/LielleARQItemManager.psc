Scriptname LielleARQItemManager extends ReferenceAlias

FormList Property LielleARQArtifacts Auto

Quest Property LielleARQDawn Auto

Quest Property LielleARQRose Auto

Quest Property LielleARQRazor Auto

Quest Property LielleARQGauldurPart Auto

Quest Property LielleARQGauldur Auto

Quest Property LielleARQSpellbreak Auto

Quest Property LielleCSQSecret Auto

Quest Property LielleCSQSecretPreStart Auto

Armor Property dunGauldurAmuletFragmentFolgunthur Auto

Armor Property dunGauldurAmuletFragmentSaarthal Auto

Armor Property dunGauldurAmuletFragmentGeirmund Auto

;Looked up at runtime instead of properties, so no VMAD/binding change is needed on existing saves.
Keyword StaffEnchanterKW
Quest RoseNeloth

Event OnPlayerLoadGame()
	AddInventoryEventFilter(LielleARQArtifacts)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem.GetFormID() == 320750
		LielleARQDawn.Start()
	elseif akBaseItem.GetFormID() == 117558
		LielleARQRose.Start()
	elseif akBaseItem.GetFormID() == 147666
		LielleARQRazor.Start()
	elseif akBaseItem.GetFormID() == 186202
		LielleARQGauldurPart.Start()
	elseif (akBaseItem == dunGauldurAmuletFragmentFolgunthur || akBaseItem == dunGauldurAmuletFragmentGeirmund || akBaseItem == dunGauldurAmuletFragmentSaarthal) && !(LielleARQGauldurPart.isActive())
		LielleARQGauldur.Start()
	elseif akBaseItem.GetFormID() == 646717 && !(LielleCSQSecret.isActive())
		LielleCSQSecret.Start()
		;LielleCSQSecretPreStart.SetStage(20)
	elseif akBaseItem.GetFormID() == 286614
		LielleARQSpellbreak.Start()
	endif

endEvent

Event OnSit(ObjectReference akFurniture)
	;Any staff enchanter (vanilla, CC tower, mod homes) starts LielleARQRoseNeloth and points DLC2EnchanterAlias at it.
	;Stage 10 = started but not yet agreed to, so re-point the alias if the player sits at a different bench.
	if !StaffEnchanterKW
		StaffEnchanterKW = Game.GetFormFromFile(0x00017738, "Dragonborn.esm") as Keyword
		RoseNeloth = Game.GetFormFromFile(0x0008C093, "Lielle.esp") as Quest
	endif

	if !akFurniture || !akFurniture.HasKeyword(StaffEnchanterKW)
		return
	endif

	if !RoseNeloth.IsRunning() && !RoseNeloth.IsCompleted()
		if RoseNeloth.Start()
			(RoseNeloth.GetAlias(3) as ReferenceAlias).ForceRefTo(akFurniture)
		endif
	elseif RoseNeloth.GetStage() == 10
		(RoseNeloth.GetAlias(3) as ReferenceAlias).ForceRefTo(akFurniture)
	endif
EndEvent
