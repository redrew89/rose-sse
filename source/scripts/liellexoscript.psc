Scriptname LielleXOScript extends Quest Conditional

;===============================================================================
; PROPERTIES
;===============================================================================

; -- Relationship State Properties --
bool Property bIsCourting = false Auto Conditional  ; Courtship state - raises cap, losses hit harder, breakup below minimum
bool Property bCourtshipPaused = false Auto Conditional   ; Whether courtship activities are paused - blocks all Affection changes
bool Property bCanResume = true Auto Conditional    ; Whether courtship can automatically resume
bool Property bIsMarried = false Auto Conditional  ; Marriage flag - keeps the raised cap, no automatic breakup
float Property fFavor = 1.0 Auto Conditional             ; Favorability - modulates Affection changes, FAVOR_MIN to FAVOR_MAX
float Property fAffection = 0.0 Auto Conditional   ; Primary relationship score
float Property LielleXOVar = 0.0 Auto Conditional  ; Legacy variable - kept in sync with fAffection for dialogue conditions
int Property iAffectionTier = 0 Auto Conditional   ; Affection band for dialogue conditions - 0 Low, 1 Moderate, 2 High, 3 Devoted

; -- Constants --
float Property MAX_NORMAL_AFFECTION = 10.0 AutoReadOnly    ; Cap for normal relationship
float Property MAX_COURTING_AFFECTION = 20.0 AutoReadOnly  ; Cap during courtship and marriage
float Property MIN_COURTING_AFFECTION = 7.0 AutoReadOnly   ; Minimum to maintain courtship

float Property FAVOR_MIN = 0.8 AutoReadOnly       ; Least favorable player - gains x0.8, losses x1.25
float Property FAVOR_MAX = 1.2 AutoReadOnly       ; Most favorable player - gains x1.2, losses x0.83

float Property SCALING_FLOOR = 0.5 AutoReadOnly       ; Gain multiplier at 0 Affection - early trust builds slowly
float Property SCALING_FULL_AT = 6.0 AutoReadOnly     ; Affection at which gains reach full value
float Property COURTING_LOSS_MULT = 1.5 AutoReadOnly  ; Loss multiplier while courting

; Affection tier boundaries - a tier starts above its value
float Property TIER_MODERATE = 3.0 AutoReadOnly   ; Above this is Moderate
float Property TIER_HIGH = 7.0 AutoReadOnly       ; Above this is High
float Property TIER_DEVOTED = 10.0 AutoReadOnly   ; Above this is Devoted - only reachable while courting or married

; Raw favor score range, from checkPlayerRace + checkPlayerSex + checkPlayerFaction
float Property RAW_FAVOR_MIN = 0.7 AutoReadOnly   ; 0.2 race + 0.5 sex + 0.0 faction
float Property RAW_FAVOR_MAX = 2.35 AutoReadOnly  ; 0.8 race + 0.7 sex + 0.85 faction

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

; -- Legacy Messages - used when the FormLists are empty or unfilled --
Message Property LielleXOPlus1 Auto
Message Property LielleXOPlus2 Auto
Message Property LielleXOPlus3 Auto
Message Property LielleXOPlus4 Auto
Message Property LielleXOPlus5 Auto
Message Property LielleXOMinus1 Auto
Message Property LielleXOMinus2 Auto
Message Property LielleXOMinus3 Auto
Message Property LielleXOMinus4 Auto
Message Property LielleXOMinus5 Auto

; -- Internal Logging --
LielleCoreScript Property Core Auto
String msgFlag = "LielleCore - Affection: "

;===============================================================================
; INITIALIZATION
;===============================================================================

bool initialized = false
int iDataVersion = 0 ; Bumped when saved data needs migrating

Function Initialize()
    if initialized
        return
    endif

    ; 0 -> 1: pre-0.5 saves only stored LielleXOVar
    if iDataVersion < 1
        if fAffection == 0.0 && LielleXOVar > 0.0
            fAffection = LielleXOVar
            Log("Migrated legacy Affection value " + fAffection, false)
        endif
        iDataVersion = 1
    endif

    ; Missing properties are survivable - each check falls back to neutral values
    if !ValidateProperties()
        Log("Some properties are not configured. Using fallbacks.", false)
    endif

    GetFavor()
    UpdateTier()
    initialized = true
    Log("Initialized successfully.", false)
EndFunction

bool Function ValidateProperties()
    if !LielleHiFavorRaces || !LielleMidFavorRaces || !LielleLoFavorRaces || !LielleHatedRaces
        return false
    endif
    if !LielleXOPlusLst || !LielleXOMinusLst
        return false
    endif
    return true
EndFunction

Function Log(string aMsg, bool bVerbose = true)
    if Core
        Core.Msg(msgFlag + aMsg, bVerbose)
    else
        Debug.Trace(msgFlag + aMsg)
    endif
EndFunction

;===============================================================================
; FAVORABILITY CALCULATION
;===============================================================================

; Recalculated on every Affection change, so race (vampirism) and faction changes apply as they happen
float Function GetFavor()
    float raw = checkPlayerRace() + checkPlayerSex() + checkPlayerFaction()
    float newFavor = FAVOR_MIN + ((raw - RAW_FAVOR_MIN) / (RAW_FAVOR_MAX - RAW_FAVOR_MIN)) * (FAVOR_MAX - FAVOR_MIN)

    if newFavor > FAVOR_MAX
        newFavor = FAVOR_MAX
    elseif newFavor < FAVOR_MIN
        newFavor = FAVOR_MIN
    endif

    if newFavor != fFavor
        fFavor = newFavor
        Log("Favorability calculated as " + fFavor, false)
    endif
    return fFavor
EndFunction

float Function checkPlayerRace()
    Race PlayerRace = Game.GetPlayer().GetRace()

    if !PlayerRace
        return 0.5  ; Default if race check fails
    endif

    ; Hated races first - vampire races must not be scored by their living counterpart
    if LielleHatedRaces && LielleHatedRaces.HasForm(PlayerRace)
        return 0.2
    elseif LielleHiFavorRaces && LielleHiFavorRaces.HasForm(PlayerRace)
        return 0.8
    elseif LielleMidFavorRaces && LielleMidFavorRaces.HasForm(PlayerRace)
        return 0.6
    elseif LielleLoFavorRaces && LielleLoFavorRaces.HasForm(PlayerRace)
        return 0.4
    endif

    return 0.5  ; Default for unclassified races
EndFunction

float Function checkPlayerSex()
    if Game.GetPlayer().GetActorBase().GetSex() == 1 ; Female - same sex as Lielle
        return 0.7
    endif
    return 0.5
EndFunction

float Function checkPlayerFaction()
    Actor player = Game.GetPlayer()
    float score = 0.2  ; Base score

    ; High favor factions
    if InFaction(player, CollegeOfWinterholdFaction)
        score += 0.3
    endif

    ; Mid favor factions
    if InFaction(player, CompanionsFaction)
        score += 0.15
    endif

    ; Low favor factions
    if InFaction(player, ThievesGuildFaction)
        score += 0.15
    endif

    ; Negative factions
    if InFaction(player, VolkiharVampireFaction) || InFaction(player, DarkBrotherhoodFaction)
        score -= 0.2
    endif

    ; Minor impact factions
    if InFaction(player, CivilWarFactionImperial) || InFaction(player, CivilWarFactionStormcloak)
        score += 0.05
    endif

    return score
EndFunction

bool Function InFaction(Actor akActor, Faction akFaction)
    return akFaction && akActor.IsInFaction(akFaction)
EndFunction

;===============================================================================
; AFFECTION SCALING
;===============================================================================

; Gains ramp from SCALING_FLOOR at 0 Affection to full value at SCALING_FULL_AT
float Function GetAffectionScaling()
    if fAffection >= SCALING_FULL_AT
        return 1.0
    endif
    return SCALING_FLOOR + ((fAffection / SCALING_FULL_AT) * (1.0 - SCALING_FLOOR))
EndFunction

float Function GetMaxAffection()
    if bIsCourting || bIsMarried
        return MAX_COURTING_AFFECTION
    endif
    return MAX_NORMAL_AFFECTION
EndFunction

; Direct assignment for MCM/debug use - clamps, skips scaling and breakup checks
Function SetAffection(float aValue)
    if !initialized
        Initialize()
    endif

    float maxAffection = GetMaxAffection()
    if aValue > maxAffection
        aValue = maxAffection
    elseif aValue < 0.0
        aValue = 0.0
    endif

    fAffection = aValue
    LielleXOVar = fAffection
    UpdateTier()
    Log("Affection set to " + fAffection, false)
EndFunction

; Recalculates iAffectionTier from fAffection - called on every Affection change and on game load
Function UpdateTier()
    int newTier = 0
    if fAffection > TIER_DEVOTED
        newTier = 3
    elseif fAffection > TIER_HIGH
        newTier = 2
    elseif fAffection > TIER_MODERATE
        newTier = 1
    endif

    if newTier != iAffectionTier
        iAffectionTier = newTier
        Log("Affection tier now " + iAffectionTier, false)
    endif
EndFunction

Function XOPlus(float aValue, bool bShowMsg = true)
    if !initialized
        Initialize()
    endif

    if aValue <= 0.0
        return
    endif

    if bCourtshipPaused
        Log("Courtship paused - ignored Affection gain of " + aValue, false)
        return
    endif

    if bShowMsg
        PlusText()
    endif

    float gain = aValue * GetAffectionScaling() * GetFavor()
    float newAffection = fAffection + gain
    float maxAffection = GetMaxAffection()

    if newAffection > maxAffection
        fAffection = maxAffection
    else
        fAffection = newAffection
    endif

    LielleXOVar = fAffection
    UpdateTier()
    Log("Affection increased by " + gain + " to " + fAffection)
EndFunction

Function XOMinus(float aValue, bool bShowMsg = true)
    if !initialized
        Initialize()
    endif

    if aValue <= 0.0
        return
    endif

    if bCourtshipPaused
        Log("Courtship paused - ignored Affection loss of " + aValue, false)
        return
    endif

    if bShowMsg
        MinusText()
    endif

    ; Favor softens or sharpens losses by the inverse of its effect on gains
    float loss = aValue / GetFavor()
    if bIsCourting && !bIsMarried
        loss = loss * COURTING_LOSS_MULT
    endif

    float newAffection = fAffection - loss
    if newAffection < 0.0
        fAffection = 0.0
    else
        fAffection = newAffection
    endif

    LielleXOVar = fAffection
    UpdateTier()
    Log("Affection decreased by " + loss + " to " + fAffection)

    ; Checked after clamping, so a loss that bottoms out still ends the courtship
    if bIsCourting && !bIsMarried && fAffection < MIN_COURTING_AFFECTION
        Breakup()
    endif
EndFunction

;===============================================================================
; RELATIONSHIP STATE MANAGEMENT
;===============================================================================

Function StartCourting()
    bIsCourting = true
    Log("Courtship started")
EndFunction

Function EndCourting()
    bIsCourting = false
    bCourtshipPaused = false ; A pause outliving the courtship would block all Affection changes
    bCanResume = true
    Log("Courtship ended")
EndFunction

Function Breakup()
    if !LielleXOQBreakup
        Log("Warning - Breakup quest not configured")
        return
    endif

    if !LielleXOQBreakup.IsRunning()
        LielleXOQBreakup.Start()
        Log("Breakup initiated")
    endif
    EndCourting()
EndFunction

Function Marry()
    ReferenceAlias allyAlias = GetAlias(3) as ReferenceAlias  ; Lielle_AllyAlias
    ReferenceAlias loverAlias = GetAlias(0) as ReferenceAlias ; LielleLoverAlias
    Actor akLielle
    if allyAlias
        akLielle = allyAlias.GetActorReference()
    endif

    if !akLielle
        Log("Warning - Marry() could not find Lielle in alias 3", false)
        return
    endif

    if loverAlias
        loverAlias.ForceRefIfEmpty(akLielle)
    endif

    Actor player = Game.GetPlayer()
    if akLielle.GetRelationshipRank(player) != 4
        akLielle.SetRelationshipRank(player, 4)
    endif
    if PlayerMarriedFaction && !akLielle.IsInFaction(PlayerMarriedFaction)
        akLielle.AddToFaction(PlayerMarriedFaction)
    endif

    bIsMarried = true
    bIsCourting = false
    bCourtshipPaused = false
    Log("Lielle and " + player.GetDisplayName() + " are now wed!")
EndFunction

;===============================================================================
; COURTSHIP PAUSE MANAGEMENT
;===============================================================================

Function PauseCourtship(bool requiresManualResume = false)
    if bIsCourting && !bCourtshipPaused
        bCourtshipPaused = true
        bCanResume = !requiresManualResume
        Log("Courtship paused. Manual resume required: " + requiresManualResume)
    endif
EndFunction

Function ResumeCourtship(bool force = false)
    if bCourtshipPaused && (bCanResume || force)
        bCourtshipPaused = false
        bCanResume = true
        Log("Courtship resumed")
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
    Message msg = PickMessage(LielleXOPlusLst, LielleXOPlus1, LielleXOPlus2, LielleXOPlus3, LielleXOPlus4, LielleXOPlus5)
    if msg
        msg.Show()
    else
        Log("Warning - Failed to show positive message", false)
    endif
EndFunction

Function MinusText()
    Message msg = PickMessage(LielleXOMinusLst, LielleXOMinus1, LielleXOMinus2, LielleXOMinus3, LielleXOMinus4, LielleXOMinus5)
    if msg
        msg.Show()
    else
        Log("Warning - Failed to show negative message", false)
    endif
EndFunction

; Random message from the FormList, or from the legacy Message properties when the list is empty
Message Function PickMessage(FormList akList, Message m1, Message m2, Message m3, Message m4, Message m5)
    if akList && akList.GetSize() > 0
        return akList.GetAt(Utility.RandomInt(0, akList.GetSize() - 1)) as Message
    endif

    int i = Utility.RandomInt(1, 5)
    if i == 1
        return m1
    elseif i == 2
        return m2
    elseif i == 3
        return m3
    elseif i == 4
        return m4
    endif
    return m5
EndFunction
