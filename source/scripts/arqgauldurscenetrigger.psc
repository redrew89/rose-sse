Scriptname ARQGauldurSceneTrigger extends ReferenceAlias  

MiscObject Property dunFolgunthurIvoryDragonClaw Auto

Armor Property dunGauldurAmuletFragmentFolgunthur Auto

Armor Property dunGauldurAmuletFragmentGeirmund Auto

Scene Property LielleARQGauldurDaynasScene Auto

Scene Property LielleARQGauldurFolgunthur Auto

Scene Property LielleARQGauldurGeirmund Auto

Event OnInit()
	AddInventoryEventFilter(dunFolgunthurIvoryDragonClaw)
	AddInventoryEventFilter(dunGauldurAmuletFragmentFolgunthur)
	AddInventoryEventFilter(dunGauldurAmuletFragmentGeirmund)	
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem == dunFolgunthurIvoryDragonClaw
		LielleARQGauldurDaynasScene.Start()
	ElseIf akBaseItem == dunGauldurAmuletFragmentFolgunthur
		LielleARQGauldurFolgunthur.Start()
	ElseIf akBaseItem == dunGauldurAmuletFragmentGeirmund
		LielleARQGauldurGeirmund.Start()
	EndIf
	
EndEvent