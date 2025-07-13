Scriptname ARQGauldurSceneTrigger extends ReferenceAlias Conditional

MiscObject Property dunFolgunthurIvoryDragonClaw Auto

Armor Property dunGauldurAmuletFragmentFolgunthur Auto

Armor Property dunGauldurAmuletFragmentGeirmund Auto

Armor Property dunGauldurAmulet Auto

Scene Property LielleARQGauldurDaynasScene Auto

Scene Property LielleARQGauldurFolgunthur Auto

Scene Property LielleARQGauldurGeirmund Auto

Scene Property LielleARQGauldurForceGreet Auto

int iAmuletFragmentCount = 1 ; assume we already have one when the quest starts, usually the Saarthal amulet fragment

Event OnInit()
	AddInventoryEventFilter(dunFolgunthurIvoryDragonClaw)
	AddInventoryEventFilter(dunGauldurAmuletFragmentFolgunthur)
	AddInventoryEventFilter(dunGauldurAmuletFragmentGeirmund)	
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If akBaseItem == dunFolgunthurIvoryDragonClaw
		LielleARQGauldurDaynasScene.Start()
		RemoveInventoryEventFilter(dunFolgunthurIvoryDragonClaw)
	ElseIf akBaseItem == dunGauldurAmuletFragmentFolgunthur || akBaseItem == dunGauldurAmuletFragmentGeirmund 
		iAmuletFragmentCount += 1
		if iAmuletFragmentCount == 2
			LielleARQGauldurFolgunthur.Start()		
		elseif iAmuletFragmentCount == 3
			LielleARQGauldurGeirmund.Start()		
		endif
	endif
		
	if akBaseItem == dunGauldurAmulet
		LielleARQGauldurForceGreet.Start()
		RemoveInventoryEventFilter(dunGauldurAmulet)
	endif
	
	if akBaseItem == dunGauldurAmuletFragmentFolgunthur
		RemoveInventoryEventFilter(dunGauldurAmuletFragmentFolgunthur)
	elseif akBaseItem == dunGauldurAmuletFragmentGeirmund
		RemoveInventoryEventFilter(dunGauldurAmuletFragmentGeirmund)
	endif 
	
EndEvent



