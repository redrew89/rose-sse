Scriptname LielleOutfitDebugScript extends Quest

ReferenceAlias Property LielleAlias Auto

Function TraceEquippedItems()
    Debug.Trace("=== Starting Lielle Equipment Trace ===")
    
    Actor Lielle = LielleAlias.GetActorReference()
    if !Lielle
        Debug.Trace("ERROR: Could not get Lielle's reference")
        return
    endif
    
    int totalItems = Lielle.GetNumItems()
    Debug.Trace("Total items in inventory: " + totalItems)
    
    int i = 0
    while i < totalItems
        Form currentItem = Lielle.GetNthForm(i)
        if currentItem
            if Lielle.IsEquipped(currentItem)
                Armor armorItem = currentItem as Armor
                if armorItem
                    int slot = armorItem.GetSlotMask()
                    int formId = currentItem.GetFormID()
                    string plugin = Game.GetModName(Math.RightShift(formId, 24))
                    string slotDesc = GetSlotDescription(slot)
                    Debug.Trace("Equipped Item " + i + ": " + currentItem + " (0x" + formId + ") - Plugin: " + plugin + " - Slots: " + slotDesc + " (mask: " + slot + ")")
                else
                    int formId = currentItem.GetFormID()
                    string plugin = Game.GetModName(Math.RightShift(formId, 24))
                    Debug.Trace("Equipped Item " + i + ": " + currentItem + " (0x" + formId + ") - Plugin: " + plugin)
                endif
            endif
        endif
        i += 1
    endwhile
    
    Debug.Trace("=== Equipment Trace Complete ===")
EndFunction

string Function GetSlotDescription(int slotMask)
    string result = ""
    
    if (Math.LogicalAnd(slotMask, 0x00000001)) ; 30
        result += "Head "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000002)) ; 31
        result += "Hair "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000004)) ; 32
        result += "Body "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000008)) ; 33
        result += "Hands "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000010)) ; 34
        result += "Forearms "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000020)) ; 35
        result += "Amulet "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000040)) ; 36
        result += "Ring "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000080)) ; 37
        result += "Feet "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000100)) ; 38
        result += "Calves "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000200)) ; 39
        result += "Shield "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000400)) ; 40
        result += "Tail "
    endif
    if (Math.LogicalAnd(slotMask, 0x00000800)) ; 41
        result += "LongHair "
    endif
    if (Math.LogicalAnd(slotMask, 0x00001000)) ; 42
        result += "Circlet "
    endif
    if (Math.LogicalAnd(slotMask, 0x00002000)) ; 43
        result += "Ears "
    endif
    if (Math.LogicalAnd(slotMask, 0x00004000)) ; 44
        result += "FX01 "
    endif
    if (Math.LogicalAnd(slotMask, 0x00008000)) ; 45
        result += "DecapitateHead "
    endif
    if (Math.LogicalAnd(slotMask, 0x00010000)) ; 46
        result += "Decapitate "
    endif
    if (Math.LogicalAnd(slotMask, 0x00020000)) ; 47
        result += "FX02 "
    endif
    if (Math.LogicalAnd(slotMask, 0x00040000)) ; 48
        result += "FX03 "
    endif
    
    return result
EndFunction