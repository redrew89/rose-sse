Scriptname LielleApocInit extends Quest  

Event OnInit()
bool bApoc = (Game.GetModByName("Apocalypse - The Spell Package.esp") < 255)
	If bApoc
		;debug.Notification("Detected Apocalypse Spells installed...")
		AddApocalypse()
	EndIf
	
EndEvent
;----------------------------------------------------

Function AddApocalypse()
	Lielle.AddSpell(Inferno)
	Lielle.AddSpell(RiftBolt)
	Lielle.AddSpell(Bolide)
	Lielle.AddSpell(Crackle)
	Lielle.AddSpell(Electrosphere)
	Lielle.AddSpell(Flamestike)
	debug.Notification("LielleCore: Apocalypse Spells Detected - Adding More Fire")
EndFunction
;----------------------------------------------------

Actor Property Lielle Auto

Spell Property Inferno Auto

Spell Property RiftBolt Auto

Spell Property Bolide Auto

Spell Property Crackle Auto

Spell Property Electrosphere Auto

Spell Property Flamestike Auto
