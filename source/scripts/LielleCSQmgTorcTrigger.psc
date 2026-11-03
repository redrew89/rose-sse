Scriptname LielleCSQmgTorcTrigger extends ReferenceAlias
{On the player alias. When Mirabelle hands over the Torc of Labyrinthian, starts Lielle's
College commentary force-greet as a scene, so it outranks her follower packages.}

MiscObject Property MG07Keystone Auto ; Torc of Labyrinthian
Quest Property LielleCSQmg Auto
Scene Property LielleCSQmgTorcFGScene Auto
Actor Property Lielle Auto

float Property fMaxDistance = 4000.0 Auto

Event OnInit()
	AddInventoryEventFilter(MG07Keystone)
EndEvent

Event OnPlayerLoadGame()
	AddInventoryEventFilter(MG07Keystone)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem != MG07Keystone
		return
	endif
	if !LielleCSQmg.IsRunning() || LielleCSQmg.GetStage() >= 35 || LielleCSQmgTorcFGScene.IsPlaying()
		return
	endif
	if Lielle.IsDead() || Lielle.IsDisabled()
		return
	endif

	; Only when she is with the player. If she is elsewhere (at home), a scene would pin her
	; in place until the player arrives; her alias force-greet package covers that case instead.
	ObjectReference PlayerRef = GetReference()
	bool bNearby = false
	if Lielle.GetParentCell() == PlayerRef.GetParentCell()
		bNearby = true
	elseif Lielle.GetWorldSpace() && Lielle.GetWorldSpace() == PlayerRef.GetWorldSpace()
		bNearby = Lielle.GetDistance(PlayerRef) <= fMaxDistance
	endif

	if bNearby
		LielleCSQmgTorcFGScene.Start()
	endif
EndEvent
