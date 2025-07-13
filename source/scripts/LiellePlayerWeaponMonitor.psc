Scriptname LiellePlayerWeaponMonitor extends ReferenceAlias

Actor Property PlayerRef Auto
ReferenceAlias Property LielleAlias Auto

Event OnInit()
    RegisterForControl("Ready Weapon")
EndEvent

Event OnControlDown(string control)
    If control == "Ready Weapon"
        Actor Lielle = LielleAlias.GetActorReference()
        If Lielle
			Utility.Wait(0.5)
            Lielle.EvaluatePackage()
        EndIf
    EndIf
EndEvent

Event OnPlayerLoadGame()
    UnregisterForControl("Ready Weapon")
    RegisterForControl("Ready Weapon")
EndEvent

Event OnUnload()
    UnregisterForControl("Ready Weapon")
EndEvent