Scriptname Lielle_InCombatSpells extends ReferenceAlias

LielleStudyRankScript Property StudyRank Auto 

LielleCoreScript Property Core Auto

string msgFlag = "LielleCore - Spells: "

; Base game spells
Spell Property FastHealingLeftHand Auto
Spell Property FireboltRightHand Auto
Spell Property FlamesRightHand Auto
Spell Property HealingLeftHand Auto
Spell Property IncinerateLeftHand Auto
Spell Property IncinerateRightHand Auto
Spell Property LightningBoltRightHand Auto
Spell Property SparksRightHand Auto
Spell Property StonefleshLeftHand Auto
Spell Property TurnLesserUndeadRightHand Auto
Spell Property WardSteadfastLeftHand Auto
Spell Property ChainLightning Auto
Spell Property WallofFlames Auto
Spell Property WallofStorms Auto

; Mod support properties
FormList Property LielleApocalypseSpellList Auto
FormList Property LielleMysticismSpellList Auto
GlobalVariable Property LielleApocalypseInstalled Auto
GlobalVariable Property LielleMysticismInstalled Auto

; Enemy type detection
Keyword Property ActorTypeUndead Auto
Class Property CombatMageDestruction Auto
Class Property CombatMageElemental Auto

; Spell tier FormLists
FormList Property LielleTier1Spells Auto ; Study Rank 0-10
FormList Property LielleTier2Spells Auto ; Study Rank 11-20
FormList Property LielleTier3Spells Auto ; Study Rank 21-30
FormList Property LielleTier4Spells Auto ; Study Rank 31-40
FormList Property LielleTier5Spells Auto ; Study Rank 41-50

; Internal variables
float Property fFireSpellPreference = 1.5 Auto Hidden
float Property fShockSpellPreference = 1.75 Auto Hidden
bool Property bInCombat Auto Hidden
bool Property bFightingMage Auto Hidden
Actor Property Lielle Auto Hidden

Event OnPlayerLoadGame()
    InitializeSpellLists()
	Lielle = GetActorReference()
EndEvent

Event OnLoad()
    InitializeSpellLists()
	Lielle = GetActorReference()
EndEvent


Function InitializeSpellLists()


	Core.Msg(msgFlag + "Clearing Spell Lists.",false)
	LielleTier1Spells.Revert()
	LielleTier2Spells.Revert()
	LielleTier3Spells.Revert()
	LielleTier4Spells.Revert()
	LielleTier5Spells.Revert()
	
	
	Core.Msg(msgFlag + "Rebuilding Spell Lists.", false)
    ; Base game spells - Tier 1 (Novice)
    LielleTier1Spells.AddForm(FlamesRightHand)
    LielleTier1Spells.AddForm(SparksRightHand)
    LielleTier1Spells.AddForm(HealingLeftHand)
    
    ; Base game spells - Tier 2 (Apprentice)
    LielleTier2Spells.AddForm(FireboltRightHand)
    LielleTier2Spells.AddForm(LightningBoltRightHand)
    LielleTier2Spells.AddForm(FastHealingLeftHand)
    
    ; Base game spells - Tier 3 (Adept)
    LielleTier3Spells.AddForm(IncinerateLeftHand)
    LielleTier3Spells.AddForm(IncinerateRightHand)
    LielleTier3Spells.AddForm(WardSteadfastLeftHand)
    
    ; Base game spells - Tier 4 (Expert)
    LielleTier4Spells.AddForm(ChainLightning)
    LielleTier4Spells.AddForm(WallofFlames)
    
    ; Base game spells - Tier 5 (Master)
    LielleTier5Spells.AddForm(WallofStorms)
    
	
	Core.Msg(msgFlag + "Checking for active spell mods.")
	; Apocalypse Spells
    Form apocForm = Game.GetFormFromFile(0x00000D62, "Apocalypse - Magic of Skyrim.esp")
	
	;Form mystForm = Game.GetFormFromFile(0x, "MysticismMagic.esp")
	
    if apocForm
		Core.Msg(msgFlag + "Found Apocalpyse - Magic of Skyrim.")
		Core.Msg(msgFlag + "Adding Apocalypse spells to Spell Lists.", false)
		LielleApocalypseInstalled.SetValueInt(1)
        ; Tier 1 - Novice spells
        Spell unboundFire = Game.GetFormFromFile(0x00085594, "Apocalypse - Magic of Skyrim.esp") as Spell
        Spell crackle = Game.GetFormFromFile(0x00109653, "Apocalypse - Magic of Skyrim.esp") as Spell
        
        if unboundFire
            LielleTier1Spells.AddForm(unboundFire)
        endif
        if crackle
            LielleTier1Spells.AddForm(crackle)
        endif
        
        ; Tier 2 - Apprentice spells
        Spell dragonTeeth = Game.GetFormFromFile(0x00024361, "Apocalypse - Magic of Skyrim.esp") as Spell
        Spell riftBolt = Game.GetFormFromFile(0x000253C2, "Apocalypse - Magic of Skyrim.esp") as Spell
        
        if dragonTeeth
            LielleTier2Spells.AddForm(dragonTeeth)
        endif
        if riftBolt
            LielleTier2Spells.AddForm(riftBolt)
        endif
        
        ; Tier 3 - Adept spells
        Spell incendiaryFlow = Game.GetFormFromFile(0x00085910, "Apocalypse - Magic of Skyrim.esp") as Spell
        Spell electrosphere = Game.GetFormFromFile(0x00001879, "Apocalypse - Magic of Skyrim.esp") as Spell
        
        if incendiaryFlow
            LielleTier3Spells.AddForm(incendiaryFlow)
        endif
        if electrosphere
            LielleTier3Spells.AddForm(electrosphere)
        endif
        
        ; Tier 4 - Expert spells
        Spell bombardment = Game.GetFormFromFile(0x000294D4, "Apocalypse - Magic of Skyrim.esp") as Spell
        Spell shockNova ;= Game.GetFormFromFile(0x00108623, "Apocalypse - Magic of Skyrim.esp") as Spell
        
        if bombardment
            LielleTier4Spells.AddForm(bombardment)
        endif
        if shockNova
            LielleTier4Spells.AddForm(shockNova)
        endif
        
        ; Tier 5 - Master spells
        Spell forbiddenSun = Game.GetFormFromFile(0x0008F318, "Apocalypse - Magic of Skyrim.esp") as Spell
        Spell staticDome = Game.GetFormFromFile(0x0008F317, "Apocalypse - Magic of Skyrim.esp") as Spell
        
        if forbiddenSun
            LielleTier5Spells.AddForm(forbiddenSun)
        endif
        if staticDome
            LielleTier5Spells.AddForm(staticDome)
        endif
    endif
    
   
EndFunction

Function RemoveAllSpells()
    ; Remove all combat spells
	Core.Msg(msgFlag + "Removing unneeded spells.", false)
    Lielle.RemoveSpell(IncinerateLeftHand)
    Lielle.RemoveSpell(IncinerateRightHand)
    Lielle.RemoveSpell(LightningBoltRightHand)
    Lielle.RemoveSpell(ChainLightning)
    Lielle.RemoveSpell(SparksRightHand)
    Lielle.RemoveSpell(TurnLesserUndeadRightHand)
    Lielle.RemoveSpell(WardSteadfastLeftHand)
    Lielle.RemoveSpell(WallofFlames)
    Lielle.RemoveSpell(WallofStorms)
EndFunction

Function EquipAnySpell(bool leftHand = false)
    FormList availableSpells
    float currentRank = StudyRank.getRank()
    Core.Msg(msgFlag + "Giving Lielle some spells.", false)
    ; Determine available spell tier based on study rank
    if currentRank >= 41
        availableSpells = LielleTier5Spells
    elseif currentRank >= 31
        availableSpells = LielleTier4Spells
    elseif currentRank >= 21
        availableSpells = LielleTier3Spells
    elseif currentRank >= 11
        availableSpells = LielleTier2Spells
    else
        availableSpells = LielleTier1Spells
    endif
    
    ; First remove spells to avoid conflicts
    RemoveAllSpells()
    
    ; Handle left hand (Restoration)
    int spellCount = availableSpells.GetSize()
    if spellCount > 0
        int index = Utility.RandomInt(0, spellCount - 1)
        Spell selectedSpell = availableSpells.GetAt(index) as Spell
        
        if selectedSpell
            string spellSchool = selectedSpell.GetNthEffectMagicEffect(0).GetAssociatedSkill()
            if spellSchool == "Restoration"
                Lielle.AddSpell(selectedSpell)
                Lielle.EquipSpell(selectedSpell, 0)  ; 0 = left hand
                Debug.Trace("Lielle equipped " + selectedSpell.GetName() + " to left hand")
            endif
        endif
    endif
    
    ; Handle right hand (non-Restoration)
    if spellCount > 0
        int index = Utility.RandomInt(0, spellCount - 1)
        Spell selectedSpell = availableSpells.GetAt(index) as Spell
        
        if selectedSpell
            string spellSchool = selectedSpell.GetNthEffectMagicEffect(0).GetAssociatedSkill()
            if spellSchool != "Restoration"
                Lielle.AddSpell(selectedSpell)
                Lielle.EquipSpell(selectedSpell, 1)  ; 1 = right hand
                Debug.Trace("Lielle equipped " + selectedSpell.GetName() + " to right hand")
            endif
        endif
    endif
EndFunction

Function EquipSpellsForRank(float currentRank, Actor akTarget = None)
    FormList availableSpells
    
	Core.Msg(msgFlag + "Giving Lielle some spells for fighting.", false)
    ; Determine available spell tier based on study rank
    if currentRank >= 41
        availableSpells = LielleTier5Spells
    elseif currentRank >= 31
        availableSpells = LielleTier4Spells
    elseif currentRank >= 21
        availableSpells = LielleTier3Spells
    elseif currentRank >= 11
        availableSpells = LielleTier2Spells
    else
        availableSpells = LielleTier1Spells
    endif
    
    ; Select spells based on combat situation
    if akTarget
        if akTarget.HasKeyword(ActorTypeUndead)
            Lielle.AddSpell(TurnLesserUndeadRightHand)
        endif
        
        ; Check if target is a mage
        if (akTarget.GetBaseObject() as ActorBase).GetClass() == CombatMageDestruction || \
           (akTarget.GetBaseObject() as ActorBase).GetClass() == CombatMageElemental
            Lielle.AddSpell(WardSteadfastLeftHand)
            bFightingMage = true
        else
            bFightingMage = false
        endif
    endif
    
    ; Always equip Stoneflex in combat
    Lielle.AddSpell(StonefleshLeftHand)
    
    ; Select random spells from available tier with element preferences
    int spellCount = availableSpells.GetSize()
    if spellCount > 0
        int index = Utility.RandomInt(0, spellCount - 1)
        Spell selectedSpell = availableSpells.GetAt(index) as Spell
        
        ; Apply spell preferences based on enemy type
        if selectedSpell && selectedSpell.GetNthEffectMagicEffect(0).GetAssociatedSkill() == "Destruction"
            float elementRoll = Utility.RandomFloat(0.0, 1.0)
            
            if bFightingMage
                ; Prefer shock spells against mages
                if elementRoll < fShockSpellPreference
                    ; Find a shock spell if possible
                    int i = 0
                    while i < spellCount
                        Spell potentialShockSpell = availableSpells.GetAt(i) as Spell
                        if potentialShockSpell && IsShockSpell(potentialShockSpell)
                            selectedSpell = potentialShockSpell
                            return
                        endif
                        i += 1
                    endwhile
                endif
            else
                ; Normal fire preference against non-mages
                if elementRoll < fFireSpellPreference
                    ; Find a fire spell if possible
                    int i = 0
                    while i < spellCount
                        Spell potentialFireSpell = availableSpells.GetAt(i) as Spell
                        if potentialFireSpell && IsFireSpell(potentialFireSpell)
                            selectedSpell = potentialFireSpell
                            return
                        endif
                        i += 1
                    endwhile
                endif
            endif
        endif
        
        if selectedSpell
            Lielle.AddSpell(selectedSpell)
        endif
    endif
EndFunction

bool Function IsFireSpell(Spell spellToCheck)
    ; Check if spell is fire-based
    if spellToCheck
        return spellToCheck.GetNthEffectMagicEffect(0).GetResistance() == "Resist Fire" ; ACTOR_VALUE_RESIST_FIRE
    endif
    return false
EndFunction

bool Function IsShockSpell(Spell spellToCheck)
    ; Check if spell is shock-based
    if spellToCheck
        return spellToCheck.GetNthEffectMagicEffect(0).GetResistance() == "Resist Shock" ; ACTOR_VALUE_RESIST_SHOCK
    endif
    return false
EndFunction

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
    if aeCombatState == 0 ; Exiting combat
        RemoveAllSpells()
        bInCombat = false
        bFightingMage = false
        Lielle.EvaluatePackage()
    elseif aeCombatState == 1 ; Entering combat
        bInCombat = true
        EquipSpellsForRank(StudyRank.getRank(), akTarget)
        Lielle.EvaluatePackage()
    endif
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
    if bInCombat && Lielle.GetActorValuePercentage("Health") <= 0.3
        ; When health is low, prioritize healing
        Lielle.AddSpell(FastHealingLeftHand)
        Lielle.EvaluatePackage()
    endif
EndEvent