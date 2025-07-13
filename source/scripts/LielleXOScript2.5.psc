Scriptname LielleXOScript extends Quest Conditional

;===============================================================================
; PROPERTIES
;===============================================================================

; -- Relationship State Properties --
bool Property bIsCourting = false Auto Conditional  ; Courtship state - doubles Affection losses and raises cap
bool Property bCourtshipPaused = false Auto Conditional   ; Whether courtship activities are paused
bool Property bCanResume = true Auto Conditional    ; Whether courtship can automatically resume
bool Property bIsMarried = false Auto Conditional  ; Marriage flag - may be used at some point
float Property fFavor = 0.1 Auto Conditional             ; Favorability - modulates Affection changes
float Property fAffection = 0.0 Auto Conditional   ; Primary relationship score
float Property LielleXOVar = 0.0 Auto Conditional  ; Legacy variable for backward compatibility

; -- Constants --
float Property MAX_NORMAL_AFFECTION = 10.0 AutoReadOnly    ; Cap for normal relationship
float Property MAX_COURTING_AFFECTION = 20.0 AutoReadOnly  ; Cap during courtship
float Property MIN_COURTING_AFFECTION = 7.0 AutoReadOnly   ; Minimum to maintain courtship

; -- Quest References --
Quest Property LielleXOQBreakup Auto  ; Breakup quest reference

; -- Race FormLists --
Formlist Property LielleHiFavorRaces Auto     ; Nord, Imperial, Breton, Redguard
Formlist Property LielleMidFavorRaces Auto    ; Khajiit, Argonian, Orc
Formlist Property LielleLoFavorRaces Auto     ; Altmer, Bosmer, Dunmer
Formlist Property LielleHatedRaces Auto       ; Vampires

; -- Faction References --
Faction Property CollegeOfWinterholdFaction Auto
Faction Property ThievesGuildFaction Auto
Faction Property CompanionsFaction Auto
Faction Property DarkBrotherhoodFaction Auto
Faction Property VolkiharVampireFaction Auto
Faction Property CivilWarFactionImperial Auto
Faction Property CivilWarFactionStormcloak Auto

Faction Property PlayerMarriedFaction Auto

; -- Message FormLists --
FormList Property LielleXOPlusLst Auto    ; Positive reaction messages
FormList Property LielleXOMinusLst Auto   ; Negative reaction messages

; -- Internal Logging --
LielleCoreScript Property Core Auto
String msgFlag = "LielleCore - Affection: "

;===============================================================================
; INITIALIZATION
;===============================================================================

bool initialized = false

Function Initialize()
    if initialized
        return
    endif
    
    ; Validate required FormLists
    if !ValidateProperties()
        Core.Msg(msgFlag + "Critical properties not configured.")
        return
    endif
          
    initialized = true
    Core.Msg(msgFlag + "Initialized successfully.", false)
EndFunction

bool Function ValidateProperties()
    if !LielleHiFavorRaces || !LielleMidFavorRaces || !LielleLoFavorRaces
        return false
    endif
    if !LielleXOPlusLst || !LielleXOMinusLst
        return false
    endif
    return true
EndFunction

;===============================================================================
; FAVORABILITY CALCULATION
;===============================================================================

Function GetFavor()
    float baseFavor = (checkPlayerRace() + checkPlayerSex() + checkPlayerFaction()) * 0.5
    
    ; Clamp favor value
    if baseFavor > 1.0
        fFavor = 1.0
    elseif baseFavor < 0.1
        fFavor = 0.1
    else
        fFavor = baseFavor
    endif
    
    Core.Msg(msgFlag + "Favorability calculated as " + fFavor)
EndFunction

float Function checkPlayerRace()
    Race PlayerRace = Game.GetPlayer().GetRace()
    
    if !PlayerRace
        return 0.5  ; Default if race check fails
    endif
    
    if LielleHiFavorRaces.HasForm(PlayerRace)
        return 0.8
    elseif LielleMidFavorRaces.HasForm(PlayerRace)
        return 0.6
    elseif LielleLoFavorRaces.HasForm(PlayerRace)
        return 0.4
    elseif LielleHatedRaces.HasForm(PlayerRace)
        return 0.2
    endif
    
    return 0.5  ; Default for unclassified races
EndFunction

float Function checkPlayerSex()
	bool sameSex = (Game.GetPlayer().GetActorBase().GetSex() == 1)
    
		if sameSex
			return 0.7
		else
			return 0.5
		endif
	
EndFunction

float Function checkPlayerFaction()
    Actor player = Game.GetPlayer()
    float score = 0.2  ; Base score
    
    ; High favor factions
    if player.IsInFaction(CollegeOfWinterholdFaction)
        score += 0.3
    endif
    
    ; Mid favor factions
    if player.IsInFaction(CompanionsFaction)
        score += 0.15
    endif
    
    ; Low favor factions
    if player.IsInFaction(ThievesGuildFaction)
        score += 0.15
    endif
    
    ; Negative factions
    if player.IsInFaction(VolkiharVampireFaction) || player.IsInFaction(DarkBrotherhoodFaction)
        score -= 0.2
    endif
    
    ; Minor impact factions
    if player.IsInFaction(CivilWarFactionImperial) || player.IsInFaction(CivilWarFactionStormcloak)
        score += 0.05
    endif
    
    return score
EndFunction

;===============================================================================
; AFFECTION SCALING
;===============================================================================

float Function GetAffectionScaling()
    if fAffection >= 6.0
        return 1.0
    endif
    
    float scalingFactor = 0.4 + ((fAffection / 6.0) * 0.6)
    return scalingFactor
EndFunction

Function XOPlus(float aValue, bool bShowMsg = true)
    if !initialized
        Initialize()
    endif
    
    if bCourtshipPaused
        return
    endif
    
    if bShowMsg
        PlusText()
    endif
    
    float scaledValue = aValue * GetAffectionScaling()
    float newAffection = fAffection + (scaledValue * fFavor)
    float maxAffection
    if bIsCourting
        maxAffection = MAX_COURTING_AFFECTION
    else
        maxAffection = MAX_NORMAL_AFFECTION
    endif
    
    if newAffection > maxAffection
        fAffection = maxAffection
    else
        fAffection = newAffection
    endif
    
    LielleXOVar = fAffection
	Core.Msg(msgFlag + "Affection increased to " + fAffection)
EndFunction

Function XOMinus(float aValue, bool bShowMsg = true)
    if !initialized
        Initialize()
    endif
    
    if bCourtshipPaused
        return
    endif
    
    if bShowMsg
        MinusText()
    endif
    
    float modifiedValue
    if bIsCourting
        modifiedValue = (aValue / fFavor) * 2
    else
        modifiedValue = aValue / fFavor
    endif
    
    float newAffection = fAffection - modifiedValue
    
    if newAffection <= 0
        fAffection = 0
    else
        fAffection = newAffection
        if bIsCourting && fAffection < MIN_COURTING_AFFECTION
            Breakup()
        endif
    endif
    
    LielleXOVar = fAffection
    Core.Msg(msgFlag + "Affection decreased to " + fAffection)
EndFunction

;===============================================================================
; RELATIONSHIP STATE MANAGEMENT
;===============================================================================

Function StartCourting()
    bIsCourting = true
    Core.Msg(msgFlag + "Courtship started")
EndFunction

Function EndCourting()
    bIsCourting = false
    Core.Msg(msgFlag + "Courtship ended")
EndFunction

Function Breakup()
    if LielleXOQBreakup
        LielleXOQBreakup.Start()
        EndCourting()
        Core.Msg(msgFlag + "Breakup initiated")
    else
        Core.Msg(msgFlag + "Warning - Breakup quest not configured")
    endif
EndFunction

Function Marry() 
	Core.Msg(msgFlag + "Lielle and " + Game.GetPlayer().GetDisplayName() + " are now wed!")
	bIsMarried = true
	ObjectReference Lielle = (self as Quest).GetAlias(3).GetActorReference() ; Get reference from Lielle_AllyAlias
	(self as Quest).GetAlias(0).ForceToRefIfEmpty(Lielle) ; Stuff that reference into LielleLoverAlias
	Actor akLielle = Lielle as Actor
	if akLielle.GetRelationshipRank(Game.GetPlayer()) != 4
		akLielle.SetRelationshipRank(Game.GetPlayer(), 4)
	endif
	if !akLielle.IsInFaction(PlayerMarriedFaction)
		akLielle.AddToFaction(PlayerMarriedFaction)
	endif
EndFunction

;===============================================================================
; COURTSHIP PAUSE MANAGEMENT
;===============================================================================

Function PauseCourtship(bool requiresManualResume = false)
    if bIsCourting && !bCourtshipPaused
        bCourtshipPaused = true
        bCanResume = !requiresManualResume
        Core.Msg(msgFlag + "Courtship paused. Manual resume required: " + requiresManualResume)
    endif
EndFunction

Function ResumeCourtship(bool force = false)
    if bCourtshipPaused && (bCanResume || force)
        bCourtshipPaused = false
        bCanResume = true
        Core.Msg(msgFlag + "Courtship resumed")
    endif
EndFunction

; Check if courtship activities should proceed
bool Function CanProgressCourtship()
    return bIsCourting && !bCourtshipPaused
EndFunction

;===============================================================================
; MESSAGE HANDLING
;===============================================================================

Function PlusText()
    int messageIndex = Utility.RandomInt(0, LielleXOPlusLst.GetSize() - 1)
    Message msg = LielleXOPlusLst.GetAt(messageIndex) as Message
    
    if msg
        msg.Show()
    else
        Core.Msg(msgFlag + "Warning - Failed to show positive message")
    endif
EndFunction

Function MinusText()
    int messageIndex = Utility.RandomInt(0, LielleXOMinusLst.GetSize() - 1)
    Message msg = LielleXOMinusLst.GetAt(messageIndex) as Message
    
    if msg
        msg.Show()
    else
        Core.Msg(msgFlag + "Warning - Failed to show negative message")
    endif
EndFunction