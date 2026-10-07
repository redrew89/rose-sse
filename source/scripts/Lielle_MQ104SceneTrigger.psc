Scriptname Lielle_MQ104SceneTrigger extends ReferenceAlias

Quest Property MQ104 Auto

Quest Property DA04 Auto

Scene Property LielleMQScene1 Auto

Scene Property LielleMQScene2 Auto

Location Property WhiterunDragonsreachLocation Auto

Location Property SeptimusSignusOutpostLocation Auto

bool bScene1Done = false
bool bScene2Done = false

; OnLocationChange can arrive in floods (thousands per second if the actor's
; location flickers). Every check here is local until a location matches, and
; the Busy state drops repeat events while a GetStage call is in flight, so
; stacks can never pile up. Once both scenes are played or missed, the
; script parks in Done for good.

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if akOldLoc != WhiterunDragonsreachLocation && akOldLoc != SeptimusSignusOutpostLocation
		return
	endif

	GotoState("Busy")

	if akOldLoc == WhiterunDragonsreachLocation && !bScene1Done
		int mq104Stage = MQ104.GetStage()
		if mq104Stage == 40
			bScene1Done = true
			LielleMQScene1.Start()
		elseif mq104Stage > 40
			bScene1Done = true
		endif

	elseif akOldLoc == SeptimusSignusOutpostLocation && !bScene2Done
		int da04Stage = DA04.GetStage()
		if da04Stage == 20
			bScene2Done = true
			LielleMQScene2.Start()
		elseif da04Stage > 20
			bScene2Done = true
		endif
	endif

	if bScene1Done && bScene2Done
		GotoState("Done")
	else
		GotoState("")
	endif
EndEvent

State Busy
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	EndEvent
EndState

State Done
	Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	EndEvent
EndState
