ScriptName LielleBookwormScript extends ReferenceAlias

FormList Property LielleSafeLocations Auto
Topic Property LielleCoreMainIdles Auto
GlobalVariable Property GameDaysPassed Auto

Keyword Property LocTypePlayerHouse Auto

Keyword Property LocTypeInn Auto

Float LastReadingTime

Event OnInit()
    LastReadingTime = GameDaysPassed.GetValue()
    RegisterForSingleUpdate(60.0) ; Check every minute real-time
EndEvent

Event OnUpdate()
    CheckLocationAndTriggerReading()
    RegisterForSingleUpdate(60.0)
EndEvent

Function CheckLocationAndTriggerReading()
    Float currentTime = GameDaysPassed.GetValue()
    Float timeElapsed = (currentTime - LastReadingTime) * 24.0 ; Convert to hours
    
    ; If less than 0.5 hours has passed, return
    If timeElapsed < 0.5
        Return
    EndIf
    
    Actor Lielle = GetActorReference()
    
    If !Lielle || Lielle.IsInCombat() || Lielle.IsSwimming() || \
       Lielle.IsOnMount() || Lielle.IsSneaking() || Lielle.IsRunning()
        Return
    EndIf
    
    Location currLoc = Lielle.GetCurrentLocation()
    If !currLoc || !LielleSafeLocations.HasForm(currLoc) || !currLoc.HasKeyword(LocTypePlayerHouse) || !currLoc.HasKeyword(LocTypeInn)
        Return
    EndIf
    
    ; Random chance weighted by time elapsed
    If Utility.RandomInt(1, 100) <= 40
        Lielle.Say(LielleCoreMainIdles)
        LastReadingTime = currentTime
    EndIf
EndFunction