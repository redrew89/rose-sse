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



