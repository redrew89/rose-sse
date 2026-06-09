Scriptname LielleOutfitDetectScript extends ReferenceAlias

; =========================================================
; Outfit Detection / Acceptance Policy
; Primary signals come from KID (and ORF/SLA mappings).
; This script enforces Lielle’s rules when the player gives / equips armor.
; =========================================================

; --- Keywords assigned via KID ---
Keyword Property LielleOutfitSkimpy Auto
Keyword Property LielleOutfitRevealing Auto
Keyword Property LielleOutfitScandalous Auto
Keyword Property LielleOutfitForbidden Auto
Keyword Property LielleOutfitIgnore Auto

; --- Scenes ---
Scene Property LielleOutfitRefusalScene Auto
Scene Property LielleOutfitUncomfortableScene Auto ; (reserved for later use)
Scene Property LielleOutfitAcceptanceScene Auto

; --- Other scripts / systems ---
LielleXOScript Property XO Auto
LielleOutfitScript Property OutfitManager Auto

; --- Storage / bookkeeping ---
ObjectReference Property LielleRejectedOutfitsContainer Auto
GlobalVariable Property LielleOutfitReject Auto
FormList Property LielleOutfitPlayerFLST Auto
Faction Property CurrentFollowerFaction Auto

String msgFlag = "LielleCore - OutfitDetect: "

; Prevent re-entrant equip spam from our own EquipItem calls
bool _suppressEquipEvent = false


; =========================================================
; Events
; =========================================================

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if _suppressEquipEvent
		return
	endif

	if akBaseObject == None
		return
	endif

	; Ignore wig equip noise (your OutfitManager owns wig behavior)
	if akBaseObject == OutfitManager.IcarusWig || akBaseObject == OutfitManager.CambrianWig
		OutfitManager.Core.Msg(msgFlag + "Ignoring equip event for SMP wig.", false)
		return
	endif

	; Only care about armor
	if akBaseObject.GetType() != 26
		return
	endif

	Armor a = akBaseObject as Armor
	Actor Lielle = GetActorReference()
	if Lielle == None
		return
	endif

	; If this is one of Lielle's managed outfit items, do not treat as player-provided
	if IsManagedOutfitItem(akBaseObject)
		return
	endif

	; If we already consider it part of player-provided outfit, just validate (covers re-equip)
	if LielleOutfitPlayerFLST.HasForm(akBaseObject)
		ValidateAndResolve(a)
		return
	endif

	; New player-provided item: record it and set state 20 so manager doesn't enforce defaults over it
	if LielleOutfitPlayerFLST.GetSize() == 0
		OutfitManager.Core.Msg(msgFlag + "Defining player-provided outfit.", false)
	endif

	LielleOutfitPlayerFLST.AddForm(a)
	OutfitManager.Core.Msg(msgFlag + "Added item to player outfit list: " + akBaseObject.GetName(), false)

	OutfitManager.LielleOutfitCurrent.SetValueInt(20)
	OutfitManager.ClearOutfit()

	; Now validate the newly added piece (may be removed/refused)
	ValidateAndResolve(a)
EndEvent


Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == None
		return
	endif
	if akBaseItem.GetType() != 26
		return
	endif

	; Only validate items that are in Lielle’s inventory (added events can be noisy)
	Armor a = akBaseItem as Armor
	if a
		ValidateAndResolve(a)
	endif
EndEvent


Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	if akBaseItem == None
		return
	endif

	; Only care about removals from the player-provided list
	if !LielleOutfitPlayerFLST.HasForm(akBaseItem)
		return
	endif

	; If it moved to the rejection container or back to player, remove it from the list
	if akDestContainer == LielleRejectedOutfitsContainer || akDestContainer == Game.GetPlayer()
		LielleOutfitPlayerFLST.RemoveAddedForm(akBaseItem)
		OutfitManager.Core.Msg(msgFlag + "Removed item from player-provided outfit list: " + akBaseItem.GetName(), false)
	else
		return
	endif

	; If player outfit cleared, revert to defaults
	if LielleOutfitPlayerFLST.GetSize() == 0 && OutfitManager.LielleOutfitCurrent.GetValueInt() == 20
		OutfitManager.SetOutfitDefault()
		OutfitManager.Core.Msg(msgFlag + "Player-provided outfit cleared. Reverting to default.", false)
	else
		CheckCurrentOutfit()
	endif
EndEvent


Event OnCellAttach()
	Actor L = GetActorReference()
	if L == None
		return
	endif

	if !L.IsInFaction(CurrentFollowerFaction)
		CheckCurrentOutfit()
	endif
EndEvent


; =========================================================
; Core logic
; =========================================================

Function CheckCurrentOutfit()
	int currentOutfit = OutfitManager.LielleOutfitCurrent.GetValueInt()

	if currentOutfit == 1
		OutfitManager.SetOutFitMisfit()
	elseif currentOutfit == 2
		OutfitManager.SetOutfitResearcher()
	elseif currentOutfit == 10
		OutfitManager.SetOutfitWedding()
	elseif currentOutfit == 20
		; Player-provided: do not enforce
		return
	else
		OutfitManager.SetOutfitDefault()
	endif

	; Safety: if she somehow lacks body slot, re-apply default
	if GetActorReference().GetWornForm(0x00000004) == None
		OutfitManager.SetOutfitDefault()
	endif
EndFunction


Function ValidateAndResolve(Armor a)
	if a == None
		return
	endif

	Actor Lielle = GetActorReference()
	if Lielle == None
		return
	endif

	; Reset reject flag for this evaluation pass
	LielleOutfitReject.SetValueInt(0)

	int tier = ClassifyTier(a)

	; Tier 0 = neutral/no-op
	if tier == 0
		return
	endif

	; Tier -1 = ignore (always accept)
	if tier == -1
		SafeEquip(a)
		return
	endif

	; Forbidden is absolute
	if tier == 4
		RejectItem(a, "forbidden")
		RefuseOutfit()
		return
	endif

	; Affection thresholds
	float aff = XO.LielleXOVar
	bool allowed = IsAllowedByAffection(tier, aff)

	if !allowed
		String label = TierLabel(tier)
		RejectItem(a, label)
		RefuseOutfit()
		return
	endif

	; Allowed: accept and optionally play acceptance scene
	SafeEquip(a)
	AcceptOutfit()
EndFunction


; =========================================================
; Classification / policy helpers
; =========================================================

; Returns:
;  -1 = ignore
;   0 = neutral (no special handling)
;   1 = skimpy
;   2 = revealing
;   3 = scandalous
;   4 = forbidden
int Function ClassifyTier(Armor a)
	; Hard override first
	if a.HasKeyword(LielleOutfitIgnore)
		return -1
	endif

	; Absolute refusal next
	if a.HasKeyword(LielleOutfitForbidden)
		return 4
	endif

	; Escalation order matters: highest tier wins if multiple keywords exist
	if a.HasKeyword(LielleOutfitScandalous)
		return 3
	endif
	if a.HasKeyword(LielleOutfitRevealing)
		return 2
	endif
	if a.HasKeyword(LielleOutfitSkimpy)
		return 1
	endif

	return 0
EndFunction


bool Function IsAllowedByAffection(int tier, float affection)
	; thresholds: skimpy >= 5, revealing >= 7, scandalous >= 9
	if tier == 1
		return affection >= 5
	elseif tier == 2
		return affection >= 7
	elseif tier == 3
		return affection >= 9
	endif
	return true
EndFunction


String Function TierLabel(int tier)
	if tier == 1
		return "skimpy"
	elseif tier == 2
		return "revealing"
	elseif tier == 3
		return "scandalous"
	elseif tier == 4
		return "forbidden"
	endif
	return "neutral"
EndFunction


; =========================================================
; Actions
; =========================================================

Function SafeEquip(Armor a)
	if a == None
		return
	endif

	Actor L = GetActorReference()
	if L == None
		return
	endif

	_suppressEquipEvent = true
	L.EquipItem(a, true, true)
	_suppressEquipEvent = false
EndFunction


Function RejectItem(Armor a, String reason)
	Actor L = GetActorReference()
	if L == None || a == None
		return
	endif

	int itemCount = L.GetItemCount(a)
	if itemCount <= 0
		; If somehow not in inventory, just bail
		return
	endif

	L.RemoveItem(a, itemCount, false, LielleRejectedOutfitsContainer)

	if LielleOutfitPlayerFLST.HasForm(a)
		LielleOutfitPlayerFLST.RemoveAddedForm(a)
	endif

	LielleOutfitReject.SetValueInt(1)
	OutfitManager.Core.Msg(msgFlag + "Rejected item (" + reason + "): " + a.GetName(), false)
EndFunction


Function RefuseOutfit()
	if LielleOutfitRefusalScene
		LielleOutfitRefusalScene.Start()
	endif
	CheckCurrentOutfit()
EndFunction


Function AcceptOutfit()
	if LielleOutfitAcceptanceScene
		LielleOutfitAcceptanceScene.Start()
	endif
EndFunction


; =========================================================
; Managed outfit detection
; (Items Lielle equips as part of her own system, not player-provided)
; =========================================================

bool Function IsManagedOutfitItem(Form f)
	if f == None
		return false
	endif

	; Default outfit parts
	int i = 0
	int total = OutfitManager.LielleCollegeRobes.GetNumParts()
	while i < total
		if f == OutfitManager.LielleCollegeRobes.GetNthPart(i)
			return true
		endif
		i += 1
	endWhile

	; Other system-controlled lists
	if OutfitManager.LielleMisfitOutfitFLST && OutfitManager.LielleMisfitOutfitFLST.HasForm(f)
		return true
	endif
	if OutfitManager.LielleResearcherOutfitFLST && OutfitManager.LielleResearcherOutfitFLST.HasForm(f)
		return true
	endif
	if OutfitManager.LielleOutfitWeddingFLST && OutfitManager.LielleOutfitWeddingFLST.HasForm(f)
		return true
	endif
	if OutfitManager.LielleOutfitCloakFLST && OutfitManager.LielleOutfitCloakFLST.HasForm(f)
		return true
	endif
	if OutfitManager.LielleModularOutfitFLST && OutfitManager.LielleModularOutfitFLST.HasForm(f)
		return true
	endif

	return false
EndFunction
