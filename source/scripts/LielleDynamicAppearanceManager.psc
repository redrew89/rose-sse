Scriptname LielleDynamicAppearanceManager extends Quest

; References to the individual overlay scripts
LielleDynamicWarpaint Property Warpaint Auto
LielleDynamicTattoo Property Tattoo Auto

; Color constants
int Property CONST_RED = 0xFF0000 AutoReadOnly
int Property CONST_PURPLE = 0x380077 AutoReadOnly
int Property CONST_PINK = 0xEE22AA AutoReadOnly

; Current settings
int Property iMenuSelectWarpaint = 1 Auto
int Property iMenuSelectTattoo = 0 Auto
int Property CUSTOM_PAINT = 0xFFFFFF Auto
int Property CUSTOM_TATT = 0xFFFFFF Auto
bool Property bWarpaintGlow = false Auto
bool Property bTattooGlow = false Auto
bool Property bWarpaintSmudge = false Auto
bool Property bStoryMode = true Auto

; Default values for story mode
int Property DEFAULT_WARPAINT = 1 Auto
int Property DEFAULT_TATTOO = 0 Auto

string Property msgFlag = "LielleCore - Dynamic Appearance: " AutoReadOnly

Function SetWarpaint(int menuIndex = -1, int customColor = 0xFFFFFF, bool bGlow = false)
	if menuIndex != -1 || iMenuSelectWarpaint != menuIndex
		iMenuSelectWarpaint = menuIndex
	endif
	CUSTOM_PAINT = customColor
	bWarpaintGlow = bGlow
	
	; Apply the appropriate color
	if menuIndex == 0
		Warpaint.TintColor = 0  ; Clean face
	elseif menuIndex == 1
		Warpaint.TintColor = CONST_RED
	elseif menuIndex == 2
		Warpaint.TintColor = CONST_PURPLE
	elseif menuIndex == 3
		Warpaint.TintColor = CONST_PINK
	elseif menuIndex == 4
		Warpaint.TintColor = 0x000000  ; Pride/Black
	elseif menuIndex == 5
		Warpaint.TintColor = customColor
	endif
	
	; Set glow
	if bGlow && menuIndex != 0
		Warpaint.EmissiveMultiple = 1.0
	else
		Warpaint.EmissiveMultiple = 0.0
	endif
	
	Warpaint.warpaintMCMSetting = menuIndex
	Warpaint.StartWarpaint()
EndFunction

Function SetTattoo(int menuIndex = -1, int customColor = 0xFFFFFF, bool bGlow = false)
	
	if menuIndex != -1 || iMenuSelectTattoo != menuIndex
		iMenuSelectTattoo = menuIndex
	endif
	CUSTOM_TATT = customColor
	
	if bTattooGlow || bGlow
		if bTattooGlow != bGlow
			bTattooGlow = bGlow
		endif
		Tattoo.EmissiveMultiple = 1.0
	else
		Tattoo.EmissiveMultiple = 0.0
	endif
	
	; Apply the appropriate color
	if menuIndex == 0
		Tattoo.RemoveTattoo() ; Disables tattoo accent overlay entirely - leaves skin texture tattoo unaffected
	elseif menuIndex == 1
		Tattoo.EmissiveColor = CONST_RED
		Tattoo.TintColor = CONST_RED
	elseif menuIndex == 2
		Tattoo.EmissiveColor = CONST_PURPLE
		Tattoo.TintColor = CONST_PURPLE
	elseif menuIndex == 3
		Tattoo.EmissiveColor = CONST_PINK
		Tattoo.TintColor = CONST_PINK
	elseif menuIndex == 4
		Tattoo.EmissiveColor = 0  ; Pride/Rainbow - no emissive
		Tattoo.TintColor = 0
	elseif menuIndex == 5
		Tattoo.EmissiveColor = 0xFFFFFF
		Tattoo.TintColor = customColor
	endif
	
	Tattoo.tattooMCMSetting = menuIndex
	Tattoo.RefreshTattoo()
EndFunction

Function ResetToDefaults()
	; Reset to default story values
	SetWarpaint(DEFAULT_WARPAINT, 0xFFFFFF, false)
	SetTattoo(DEFAULT_TATTOO, 0xFFFFFF)
	
	; Reset custom colors
	CUSTOM_PAINT = 0xFFFFFF
	CUSTOM_TATT = 0xFFFFFF
	bWarpaintGlow = false
EndFunction

Function SetStoryMode(bool bEnabled)
	bStoryMode = bEnabled
	if bEnabled
		ResetToDefaults()
	endif
EndFunction

; Getters for MCM to check current state
int Function GetWarpaintSelection()
	return iMenuSelectWarpaint
EndFunction

int Function GetTattooSelection()
	return iMenuSelectTattoo
EndFunction

bool Function GetWarpaintGlow()
	return bWarpaintGlow
EndFunction

int Function GetCustomPaintColor()
	return CUSTOM_PAINT
EndFunction

int Function GetCustomTattColor()
	return CUSTOM_TATT
EndFunction