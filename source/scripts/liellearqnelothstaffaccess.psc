Scriptname LielleARQNelothStaffAccess extends ReferenceAlias

Event OnLoad()
	;debug.Notification("Lielle is paying attention to what you do.")
EndEvent

Event OnActivate(ObjectReference akActionRef)
	If (akActionRef == Game.GetPlayer()) && (!LielleARQRoseNeloth.IsRunning() && !LielleARQRoseNeloth.IsCompleted())
		LielleARQRoseNeloth.Start()
		;debug.Notification("Lielle is intrigued by what you are doing.")
	EndIf
EndEvent

Quest Property LielleARQRoseNeloth Auto