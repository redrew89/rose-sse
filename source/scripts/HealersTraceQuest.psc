ScriptName HealersTraceQuest extends Quest Conditional

; Aliases for tracked NPCs
ReferenceAlias Property TraceTarget1 Auto
ReferenceAlias Property TraceTarget2 Auto
ReferenceAlias Property TraceTarget3 Auto
ReferenceAlias Property TraceTarget4 Auto
ReferenceAlias Property TraceTarget5 Auto
ReferenceAlias Property CurrentHealTarget Auto
Actor Property Lielle Auto

; Track previous heal target to detect changes
Actor LastHealTarget

bool Property TraceActive1 Auto Conditional
bool Property TraceActive2 Auto Conditional
bool Property TraceActive3 Auto Conditional
bool Property TraceActive4 Auto Conditional
bool Property TraceActive5 Auto Conditional

; Health threshold for healing
Float Property HealThreshold = 0.4 Auto ; Heal at 40% health

Event OnInit()
    RegisterForUpdate(3.3) 
    LastHealTarget = None
EndEvent

Event OnUpdate()
    CheckTrackedNPCHealth()
EndEvent

Function CheckTrackedNPCHealth()
    Float[] healthRatios = new Float[5]
    Actor[] npcs = new Actor[5]
    
    ; Get health ratios for all tracked NPCs
    If TraceTarget1.GetReference()
        npcs[0] = TraceTarget1.GetReference() as Actor
        healthRatios[0] = npcs[0].GetActorValuePercentage("Health")
    EndIf
    If TraceTarget2.GetReference()
        npcs[1] = TraceTarget2.GetReference() as Actor
        healthRatios[1] = npcs[1].GetActorValuePercentage("Health")
    EndIf
    If TraceTarget3.GetReference()
        npcs[2] = TraceTarget3.GetReference() as Actor
        healthRatios[2] = npcs[2].GetActorValuePercentage("Health")
    EndIf
    If TraceTarget4.GetReference()
        npcs[3] = TraceTarget4.GetReference() as Actor
        healthRatios[3] = npcs[3].GetActorValuePercentage("Health")
    EndIf
    If TraceTarget5.GetReference()
        npcs[4] = TraceTarget5.GetReference() as Actor
        healthRatios[4] = npcs[4].GetActorValuePercentage("Health")
    EndIf
    
    ; Find lowest health NPC
    Float lowestHealth = 1.0
    Int lowestIndex = -1
    
    Int i = 0
    While i < 5
        If npcs[i] && healthRatios[i] < lowestHealth && healthRatios[i] < HealThreshold
            lowestHealth = healthRatios[i]
            lowestIndex = i
        EndIf
        i += 1
    EndWhile
    
    ; Handle heal target changes
    If lowestIndex >= 0
        Actor newTarget = npcs[lowestIndex]
        
        ; Only update if target has changed
        If newTarget != LastHealTarget
            CurrentHealTarget.ForceRefTo(newTarget)
            LastHealTarget = newTarget
            Lielle.EvaluatePackage()
            Debug.Trace("Lielle focuses her healing on " + newTarget.GetDisplayName())
        EndIf
    Else
        ; Clear target if no one needs healing
        If LastHealTarget
            CurrentHealTarget.Clear()
            LastHealTarget = None
            Lielle.EvaluatePackage()
        EndIf
    EndIf
EndFunction

Bool Function IsTracked(Actor targetActor)
    If TraceTarget1.GetReference() == targetActor || \
       TraceTarget2.GetReference() == targetActor || \
       TraceTarget3.GetReference() == targetActor || \
       TraceTarget4.GetReference() == targetActor || \
       TraceTarget5.GetReference() == targetActor
        Return True
    EndIf
    Return False
EndFunction

Function AddTrackedNPC(Actor targetActor)
    If !TraceTarget1.GetReference()
        TraceTarget1.ForceRefTo(targetActor)
        Debug.Notification("Lielle attunes to " + targetActor.GetDisplayName() + "'s vital essence.")
        TraceActive1 = true
        Return
    ElseIf !TraceTarget2.GetReference()
        TraceTarget2.ForceRefTo(targetActor)
        Debug.Notification("Lielle attunes to " + targetActor.GetDisplayName() + "'s vital essence.")
        TraceActive2 = true
        Return
    ElseIf !TraceTarget3.GetReference()
        TraceTarget3.ForceRefTo(targetActor)
        Debug.Notification("Lielle attunes to " + targetActor.GetDisplayName() + "'s vital essence.")
        TraceActive3 = true
        Return
    ElseIf !TraceTarget4.GetReference()
        TraceTarget4.ForceRefTo(targetActor)
        Debug.Notification("Lielle attunes to " + targetActor.GetDisplayName() + "'s vital essence.")
        TraceActive4 = true
        Return
    ElseIf !TraceTarget5.GetReference()
        TraceTarget5.ForceRefTo(targetActor)
        Debug.Notification("Lielle attunes to " + targetActor.GetDisplayName() + "'s vital essence.")
        TraceActive5 = true
        Return
    Else
        Debug.Notification("Lielle cannot maintain more healing traces at once.")
    EndIf
EndFunction

Function RemoveTrackedNPC(Actor targetActor)
    If TraceTarget1.GetReference() == targetActor
        TraceTarget1.Clear()
        Debug.Notification("Lielle releases her healing trace from " + targetActor.GetDisplayName() + ".")
        TraceActive1 = false
    ElseIf TraceTarget2.GetReference() == targetActor
        TraceTarget2.Clear()
        Debug.Notification("Lielle releases her healing trace from " + targetActor.GetDisplayName() + ".")
        TraceActive2 = false
    ElseIf TraceTarget3.GetReference() == targetActor
        TraceTarget3.Clear()
        Debug.Notification("Lielle releases her healing trace from " + targetActor.GetDisplayName() + ".")
        TraceActive3 = false
    ElseIf TraceTarget4.GetReference() == targetActor
        TraceTarget4.Clear()
        Debug.Notification("Lielle releases her healing trace from " + targetActor.GetDisplayName() + ".")
        TraceActive4 = false
    ElseIf TraceTarget5.GetReference() == targetActor
        TraceTarget5.Clear()
        Debug.Notification("Lielle releases her healing trace from " + targetActor.GetDisplayName() + ".")
        TraceActive5 = false
    EndIf
    
    ; Clear heal target if it was this NPC
    If CurrentHealTarget.GetReference() == targetActor
        CurrentHealTarget.Clear()
        LastHealTarget = None
        Lielle.EvaluatePackage()
    EndIf
EndFunction

Function ClearAllTraces()
    Bool anyCleared = False
    
    If TraceTarget1.GetReference()
        TraceTarget1.Clear()
        anyCleared = True
    EndIf
    If TraceTarget2.GetReference()
        TraceTarget2.Clear()
        anyCleared = True
    EndIf
    If TraceTarget3.GetReference()
        TraceTarget3.Clear()
        anyCleared = True
    EndIf
    If TraceTarget4.GetReference()
        TraceTarget4.Clear()
        anyCleared = True
    EndIf
    If TraceTarget5.GetReference()
        TraceTarget5.Clear()
        anyCleared = True
    EndIf
    
    TraceActive1 = false
    TraceActive2 = false
    TraceActive3 = false
    TraceActive4 = false
    TraceActive5 = false
    
    CurrentHealTarget.Clear()
    LastHealTarget = None
    Lielle.EvaluatePackage()
    
    If anyCleared
        Debug.Notification("Lielle releases all healing traces.")
    Else
        Debug.Notification("Lielle has no active healing traces.")
    EndIf
EndFunction