Scriptname Lielle_FleeAliasScript extends ReferenceAlias  

ReferenceAlias Property LielleAlias Auto
	Quest Property LielleCSQFlee Auto
		ObjectReference Property qasmokeObject Auto

Function LielleFlees()
	if LielleCSQFlee.GetStage() == 10 && !(Game.GetPlayer().HasLOS(LielleAlias.GetActorReference()))
		; Move Lielle to qasmoke and disable her reference
		actor Lielle = LielleAlias.GetActorReference()
		Lielle.MoveTo(qasmokeObject)
		Lielle.Disable()
	else
		RegisterForSingleLOSLost(Game.GetPlayer(), LielleAlias.GetActorReference())
	endif
	LielleCSQFlee.SetStage(20)

	(LielleCSQFlee as Lielle_FleeScript).LielleFleeNoteSend()

endFunction

Event OnLostLOS(actor akViewer, ObjectReference akTarget)
	if akViewer == Game.GetPlayer() && akTarget == LielleAlias.GetActorReference()
		self.LielleFlees()
	endif
EndEvent
	