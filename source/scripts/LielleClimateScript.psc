Scriptname LielleClimateScript extends Quest
{Decides whether Lielle is somewhere cold or mild, from where she stands on the world map, for the outfit dialogue conditions.
The grids below are generated from the vanilla weather regions in Skyrim.esm, Dawnguard.esm and Dragonborn.esm: each entry
covers 2x2 cells, and is cold when the highest-priority weather region there uses snow-family weathers or rolls snow at
least 15% of the time. Weather overhauls don't change the grids; falling snow still counts as cold anywhere.}

GlobalVariable Property LielleClimate Auto ; 0 - Mild, 1 - Cold. Read by outfit dialogue conditions
	ReferenceAlias Property LielleAlias Auto ; Alias on LielleCSQOutfit - this quest
		LielleCoreScript Property Core Auto
			float Property fUpdateInterval = 20.0 Auto ; Real-time seconds between checks
			int Property iConfirmReadings = 2 Auto ; A change has to hold for this many checks in a row before it applies, so borders don't flicker

int iPendingClimate = -1
int iPendingCount = 0
bool bLastCloakWeather = false

WorldSpace wsTamriel
WorldSpace wsSolstheim
WorldSpace wsFalmerValley
WorldSpace[] wsCold ; Small worldspaces with their own weather region - classified the same way as the grids
WorldSpace[] wsMild
Weather wAshStorm ; Solstheim's ash storm is classed as snow, but it isn't cold

String msgFlag = "LielleCore - Climate: "

Event OnInit()
	CacheForms()
	UpdateClimate(true)
	RegisterForSingleUpdate(fUpdateInterval)
EndEvent

Event OnUpdate()
	UpdateClimate(false)
	RegisterForSingleUpdate(fUpdateInterval)
EndEvent

Function CacheForms()
	wsTamriel = Game.GetFormFromFile(0x00003C, "Skyrim.esm") as WorldSpace
	wsSolstheim = Game.GetFormFromFile(0x000800, "Dragonborn.esm") as WorldSpace
	wsFalmerValley = Game.GetFormFromFile(0x000BB5, "Dawnguard.esm") as WorldSpace
	wAshStorm = Game.GetFormFromFile(0x032336, "Dragonborn.esm") as Weather

	wsCold = new WorldSpace[6]
	wsCold[0] = Game.GetFormFromFile(0x01691D, "Skyrim.esm") as WorldSpace ; Windhelm
	wsCold[1] = Game.GetFormFromFile(0x0278DD, "Skyrim.esm") as WorldSpace ; Skuldafn
	wsCold[2] = Game.GetFormFromFile(0x094B35, "Skyrim.esm") as WorldSpace ; Japhet's Folly
	wsCold[3] = Game.GetFormFromFile(0x104217, "Skyrim.esm") as WorldSpace ; Labyrinthian maze
	wsCold[4] = Game.GetFormFromFile(0x029AB7, "Skyrim.esm") as WorldSpace ; Deepwood Redoubt
	wsCold[5] = Game.GetFormFromFile(0x0204C7, "Skyrim.esm") as WorldSpace ; Fallowstone Cave

	; Otherworldly places whose weather never means cold - Blackreach's spore weather is even classed as snow.
	; Cities and other small worldspaces aren't listed: they're mild unless it's snowing, like any unmapped worldspace
	wsMild = new WorldSpace[4]
	wsMild[0] = Game.GetFormFromFile(0x01EE62, "Skyrim.esm") as WorldSpace ; Blackreach
	wsMild[1] = Game.GetFormFromFile(0x02EE41, "Skyrim.esm") as WorldSpace ; Sovngarde
	wsMild[2] = Game.GetFormFromFile(0x001408, "Dawnguard.esm") as WorldSpace ; Soul Cairn
	wsMild[3] = Game.GetFormFromFile(0x01C0B2, "Dragonborn.esm") as WorldSpace ; Apocrypha
EndFunction

; abImmediate skips the confirmation wait - used on startup so the global is right straight away
Function UpdateClimate(bool abImmediate = false)
	if !wsTamriel
		CacheForms()
	endif

	Actor kRef = LielleAlias.GetActorReference()
	if !kRef || !kRef.Is3DLoaded()
		kRef = Game.GetPlayer()
	endif
	if kRef.IsInInterior()
		return ; Interiors keep the last outdoor reading
	endif

	; Rain, snow or nightfall starting or ending outdoors swaps her cloak - only when she's here to wear it
	if kRef != Game.GetPlayer()
		LielleOutfitScript Outfits = (self as Quest) as LielleOutfitScript
		bool bCloakWeather = Outfits.IsCloakWeather()
		if bCloakWeather != bLastCloakWeather
			bLastCloakWeather = bCloakWeather
			Outfits.SetCloakOption()
		endif
	endif

	int iReading = ReadClimate(kRef)
	if iReading < 0
		return ; A gap between weather regions - keep the last reading
	endif

	if iReading == LielleClimate.GetValueInt()
		iPendingCount = 0
		return
	endif

	if iReading != iPendingClimate
		iPendingClimate = iReading
		iPendingCount = 0
	endif
	iPendingCount += 1

	if abImmediate || iPendingCount >= iConfirmReadings
		LielleClimate.SetValueInt(iReading)
		iPendingCount = 0
		if Core.LielleVerbose
			Core.Msg(msgFlag + "Climate is now " + iReading + " (0 - Mild, 1 - Cold)", false)
		endif
	endif
EndFunction

; Returns 1 for cold, 0 for mild, or -1 when the map has no answer here
int Function ReadClimate(ObjectReference akRef)
	WorldSpace kWorld = akRef.GetWorldSpace()
	if wsMild.Find(kWorld) >= 0
		return 0
	endif

	Weather kCurrent = Weather.GetCurrentWeather()
	if kCurrent && kCurrent != wAshStorm && kCurrent.GetClassification() == 3
		return 1 ; Falling snow is cold anywhere
	endif

	if kWorld == wsTamriel
		return GridLookup(0, akRef.GetPositionX(), akRef.GetPositionY())
	elseif kWorld == wsSolstheim
		return GridLookup(1, akRef.GetPositionX(), akRef.GetPositionY())
	elseif kWorld == wsFalmerValley
		return GridLookup(2, akRef.GetPositionX(), akRef.GetPositionY())
	elseif wsCold.Find(kWorld) >= 0
		return 1
	endif
	return 0 ; Mild cities, other small worldspaces and mod-added lands - mild unless it's snowing
EndFunction

int Function GridLookup(int aiGrid, float afX, float afY)
	float fWest
	float fNorth
	int iCols
	int iRows
	if aiGrid == 0
		fWest = -212992.0
		fNorth = 180224.0
		iCols = 53
		iRows = 40
	elseif aiGrid == 1
		fWest = -12288.0
		fNorth = 118784.0
		iCols = 15
		iRows = 15
	else
		fWest = -57344.0
		fNorth = 53248.0
		iCols = 13
		iRows = 12
	endif

	int iCol = Math.Floor((afX - fWest) / 8192.0)
	int iRow = Math.Floor((fNorth - afY) / 8192.0)
	if iCol < 0 || iRow < 0 || iCol >= iCols || iRow >= iRows
		return -1
	endif

	string sLine
	if aiGrid == 0
		sLine = TamrielRow(iRow)
	elseif aiGrid == 1
		sLine = SolstheimRow(iRow)
	else
		sLine = FValeRow(iRow)
	endif

	string sCell = StringUtil.GetNthChar(sLine, iCol)
	if sCell == "1"
		return 1
	elseif sCell == "0"
		return 0
	endif
	return -1
EndFunction

; Grid rows, north to south. 1 - Cold, 0 - Mild, - - No weather region

string Function TamrielRow(int aiRow)
	string[] rows = new string[40]
	rows[0] = "-----------------------------------------------------"
	rows[1] = "----------111111111111111111111111111----------------"
	rows[2] = "---111--111111111111111111111111111111111111---------"
	rows[3] = "---111-111111111111111111111111111111111111111-------"
	rows[4] = "---11111111111111111111111111111111111111111111------"
	rows[5] = "-----1111111111111111111111111111111111111111111-----"
	rows[6] = "-----1111111111111100011111111111111111111111111-----"
	rows[7] = "-----11111111111111100011111111111111111111111111----"
	rows[8] = "-----11111111111110000011111111111111111111111111----"
	rows[9] = "-----11111111110000000011111111111111111111111111----"
	rows[10] = "-----111110000000000000111111111111111111111111111---"
	rows[11] = "----1111000000000000000011111111111111111111111111---"
	rows[12] = "----1110000000000000000011111111111111111111111111---"
	rows[13] = "---1111000000000000000001111111111111111111111111----"
	rows[14] = "--11100000000000000011111111111111111111111111111----"
	rows[15] = "--1110000000000000001111111111111111111111111111-----"
	rows[16] = "-111100000000000000011111111111111111111111111111----"
	rows[17] = "-111100000000000000111111111111111111111111111111----"
	rows[18] = "-1110000000000000000000111000000111111111111111111---"
	rows[19] = "-1111000000000000000000000000000111111111111111111---"
	rows[20] = "-11110000000000000000000000000000011111100001111111--"
	rows[21] = "-11110000000000000000000000000000000111000000111111--"
	rows[22] = "-11100000000000000000000000000000000000000000011111--"
	rows[23] = "--1100000000000000000000000000000000000000000001111--"
	rows[24] = "111100000000000000000000000000010110000000000001111--"
	rows[25] = "-11100000000000000000000001100011100000000000001111--"
	rows[26] = "-11111111110000000000000111100111100000000000001111--"
	rows[27] = "-111111111110000000000001110001111100000000000001111-"
	rows[28] = "--11111111111111000000000000001111100000000000001111-"
	rows[29] = "---1111111111111100000000000001111000000000000000111-"
	rows[30] = "------1111111111100000000000001111000000000000000111-"
	rows[31] = "---------1111111100000000000001111000000000000000111-"
	rows[32] = "------------1111110000000000011111000000000000000011-"
	rows[33] = "-------------111111100001111111111110000000000000011-"
	rows[34] = "--------------11111100011111111111111010000000000001-"
	rows[35] = "---------------1111111111111111111111111000000000011-"
	rows[36] = "------------------111111111111111-111111111110000011-"
	rows[37] = "-------------------111111111111------111111111100111-"
	rows[38] = "----------------------------------------111111111111-"
	rows[39] = "--------------------------------------------11111111-"
	return rows[aiRow]
EndFunction

string Function SolstheimRow(int aiRow)
	string[] rows = new string[15]
	rows[0] = "----111--------"
	rows[1] = "-111111111111--"
	rows[2] = "-1111111111111-"
	rows[3] = "-1111111111111-"
	rows[4] = "11111111111111-"
	rows[5] = "11111111111111-"
	rows[6] = "11111111111111-"
	rows[7] = "0111111-011111-"
	rows[8] = "00000000000000-"
	rows[9] = "-0000000000000-"
	rows[10] = "-0000000000000-"
	rows[11] = "-0000000000000-"
	rows[12] = "--000000000000-"
	rows[13] = "--000000000000-"
	rows[14] = "---------------"
	return rows[aiRow]
EndFunction

string Function FValeRow(int aiRow)
	string[] rows = new string[12]
	rows[0] = "---------1---"
	rows[1] = "---1111110---"
	rows[2] = "--111111000--"
	rows[3] = "--1111110000-"
	rows[4] = "--1111110000-"
	rows[5] = "-11111110001-"
	rows[6] = "-11111111011-"
	rows[7] = "-111111111111"
	rows[8] = "111111111111-"
	rows[9] = "-1111111111--"
	rows[10] = "--11111111---"
	rows[11] = "---111111----"
	return rows[aiRow]
EndFunction
