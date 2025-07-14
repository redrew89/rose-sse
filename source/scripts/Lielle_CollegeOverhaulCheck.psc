Scriptname Lielle_CollegeOverhaulCheck  extends ReferenceAlias

ObjectReference Property LielleMGEnchanterRef Auto

GlobalVariable Property LielleCollegeOverhaul Auto 

LielleCoreScript Property Core Auto

Event OnInit()
	
	debug.trace("LielleCore: Checking for College overhauls.")
	
	Core.Msg("LielleCore: Checking for College overhauls.",true)
		
	Quest OCWTracker
		
	if LielleCollegeOverhaul.GetValueInt() == 0 ; No overhaul - Default Global value
		LielleMGEnchanterRef.Enable()
		Debug.trace("LielleCore: None detected")
		Core.Msg("LielleCore: None detected",true)
	elseif LielleCollegeOverhaul.GetValueInt() == 1 ; Obscure's CoW
		OCWTracker = Game.GetFormFromFile(0x00003802, "Lielle-OCW.esp") as Quest
		OCWTracker.Start()
		Debug.trace("LielleCore: OCW detected")
		Core.Msg("LielleCore: OCW detected",true)
	elseif LielleCollegeOverhaul.GetValueInt() == 2 ; Immersive CoW
		LielleMGEnchanterRef.Enable()
		Debug.trace("LielleCore: ICoW detected")
		Core.Msg("LielleCore: ICoW detected",true)	
	elseif LielleCollegeOverhaul.GetValueInt() == 3 ; Magical CoW
		Debug.trace("LielleCore: MCoW detected")
		Core.Msg("LielleCore: MCoW detected",true)
	elseif LielleCollegeOverhaul.GetValueInt() == 4 ; Ultimate CoW
		OCWTracker = Game.GetFormFromFile(0x00004802, "Lielle-UCoW.esp") as Quest
		OCWTracker.Start()
		Debug.trace("LielleCore: UCoW detected")
		Core.Msg("LielleCore: UCoW detected",true)
	endif

EndEvent
