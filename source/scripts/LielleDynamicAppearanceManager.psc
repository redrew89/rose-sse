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
	if menuIndex < 0 ; No arguments (game load, monitors) - re-apply the current settings, keeping colour and glow
		menuIndex = iMenuSelectWarpaint
		customColor = CUSTOM_PAINT
		bGlow = bWarpaintGlow
		if menuIndex < 0
			menuIndex = 0 ; Saves from before this fix stored -1 on every load
		endif
	endif
	; The paint is baked into her FaceGen tint, so there is no Clean Face any more - index 0 (old saves,
	; story scenes) just means the default colour if glow gets turned on
	if menuIndex == 0 && bGlow
		menuIndex = 1
	endif
	iMenuSelectWarpaint = menuIndex
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
		Warpaint.EmissiveMultiple = 0.5
	else
		Warpaint.EmissiveMultiple = 0.0
	endif

	; The overlay only carries the glow: it fades in while glow is on, and with glow off it fades out and
	; releases its slot (overlay setting 0) - the colour choice is kept for the next time glow is turned on
	if bGlow
		Warpaint.warpaintMCMSetting = menuIndex
	else
		Warpaint.warpaintMCMSetting = 0
	endif
	Warpaint.StartWarpaint()
EndFunction

Function SetTattoo(int menuIndex = -1, int customColor = 0xFFFFFF, bool bGlow = false)
	
	if menuIndex < 0 ; No arguments (game load) - re-apply the current settings, keeping colour and glow
		menuIndex = iMenuSelectTattoo
		customColor = CUSTOM_TATT
		bGlow = bTattooGlow
		if menuIndex < 0
			menuIndex = 0 ; Saves from before this fix stored -1 on every load - fall back to no glow
		endif
	endif
	; Glow with the accent at Disabled would show nothing - use the default colour, as the warpaint does
	if menuIndex == 0 && bGlow
		menuIndex = 1
	endif
	iMenuSelectTattoo = menuIndex
	CUSTOM_TATT = customColor

	; Glow follows the request - previously turning it off left EmissiveMultiple at 1.0 for one call
	bTattooGlow = bGlow
	if bGlow
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