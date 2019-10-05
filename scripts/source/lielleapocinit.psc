Scriptname LielleApocInit extends Quest  

Event OnInit()
bool bApoc = (Game.GetModByName("Apocalypse - The Spell Package.esp") < 255)
	If bApoc
		debug.trace("LielleCore: Detected Apocalypse Spells installed...")
			
		RiftBolt = Game.GetFormFromFile(0x000253C2, "Apocalypse - The Spell Package.esp") as Spell
		Bolide = Game.GetFormFromFile(0x000294CD, "Apocalypse - The Spell Package.esp") as Spell
		Crackle = Game.GetFormFromFile(0x00109653, "Apocalypse - The Spell Package.esp") as Spell
		Electrosphere = Game.GetFormFromFile(0x00001879, "Apocalypse - The Spell Package.esp") as Spell
		UnboundFire = Game.GetFormFromFile(0x00085594, "Apocalypse - The Spell Package.esp") as Spell
		
		AddApocalypse()
		
	EndIf
	
EndEvent
;----------------------------------------------------

Function AddApocalypse()
	Lielle.AddSpell(RiftBolt)
	Lielle.AddSpell(Bolide)
	Lielle.AddSpell(Crackle)
	Lielle.AddSpell(Electrosphere)
	Lielle.AddSpell(UnboundFire)
	debug.Notification("LielleCore: Apocalypse Spells Detected - Adding More Fire")
		
EndFunction
;----------------------------------------------------

Actor Property Lielle Auto


Spell RiftBolt

Spell Bolide

Spell Crackle

Spell Electrosphere

Spell UnboundFire
