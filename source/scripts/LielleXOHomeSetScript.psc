Scriptname LielleXOHomeSetScript extends Quest Conditional

Actor Property PlayerRef Auto
FormList Property ValidHomeKeywords Auto
ObjectReference Property LielleRef Auto
LocationAlias Property HomeLocation Auto
ObjectReference Property SleepMarker Auto
ObjectReference Property EatMarker Auto  
ObjectReference Property WorkMarker Auto
ObjectReference Property RelaxMarker Auto
ObjectReference Property LielleRejectedOutfitsContainer Auto ; Handy reference for moving markers back to the storage cell when not needed

; Aliases on RelationshipMarriageFIN, in case the player moves Lielle from a vanilla house to a custom one

ReferenceAlias Property WhiterunHouse Auto
ReferenceAlias Property CCHouse01 Auto
ReferenceAlias Property CCHouse02 Auto
ReferenceAlias Property CCHouse03 Auto
ReferenceAlias Property CCHouse04 Auto
ReferenceAlias Property CCHouse05 Auto
ReferenceAlias Property CCHouse06 Auto
ReferenceAlias Property CCHouse07 Auto
ReferenceAlias Property CCHouse08 Auto
ReferenceAlias Property CCHouse09 Auto
ReferenceAlias Property CCHouse10 Auto
ReferenceAlias Property CCHouse11 Auto
ReferenceAlias Property CCHouse12 Auto
ReferenceAlias Property CCHouse13 Auto
ReferenceAlias Property CCHouse14 Auto
ReferenceAlias Property CCHouse15 Auto
ReferenceAlias Property CCHouse16 Auto
ReferenceAlias Property CCHouse17 Auto
ReferenceAlias Property CCHouse18 Auto
ReferenceAlias Property CCHouse19 Auto
ReferenceAlias Property CCHouse20 Auto
ReferenceAlias Property WindhelmHouse Auto
ReferenceAlias Property SolitudeHouse Auto
ReferenceAlias Property RiftenHouse Auto
ReferenceAlias Property FalkreathHouse Auto
ReferenceAlias Property HjaalmarchHouse Auto
ReferenceAlias Property PaleHouse Auto

Bool Property AllMarkersPlaced = False Auto Conditional
Bool Property SleepMarkerPlaced = False Auto
Bool Property EatMarkerPlaced = False Auto
Bool Property WorkMarkerPlaced = False Auto
Bool Property RelaxMarkerPlaced = False Auto


Function MoveHouse()
    ; Declare an array with the correct size
    ReferenceAlias[] HouseAliases = new ReferenceAlias[27]

    ; Manually assign each alias to the array
    HouseAliases[0] = WhiterunHouse
    HouseAliases[1] = CCHouse01
    HouseAliases[2] = CCHouse02
    HouseAliases[3] = CCHouse03
    HouseAliases[4] = CCHouse04
    HouseAliases[5] = CCHouse05
    HouseAliases[6] = CCHouse06
    HouseAliases[7] = CCHouse07
    HouseAliases[8] = CCHouse08
    HouseAliases[9] = CCHouse09
    HouseAliases[10] = CCHouse10
    HouseAliases[11] = CCHouse11
    HouseAliases[12] = CCHouse12
    HouseAliases[13] = CCHouse13
    HouseAliases[14] = CCHouse14
    HouseAliases[15] = CCHouse15
    HouseAliases[16] = CCHouse16
    HouseAliases[17] = CCHouse17
    HouseAliases[18] = CCHouse18
    HouseAliases[19] = CCHouse19
    HouseAliases[20] = CCHouse20
    HouseAliases[21] = WindhelmHouse
    HouseAliases[22] = SolitudeHouse
    HouseAliases[23] = RiftenHouse
    HouseAliases[24] = FalkreathHouse
    HouseAliases[25] = HjaalmarchHouse
    HouseAliases[26] = PaleHouse

    ; Iterate through the array to find a matching alias
    int i = 0
    while i < HouseAliases.Length
        if HouseAliases[i].GetReference() == LielleRef
            HouseAliases[i].Clear()
            ResetMarkers() ; Call ResetMarkers after clearing the alias
            return
        endIf
        i += 1
    endWhile
EndFunction

Function SetHomeLocation()
    Location currentLoc = PlayerRef.GetCurrentLocation()
    If !currentLoc
        Debug.Notification("Must be inside a valid location.")
        Return
    EndIf
    
    Bool isValidHome = False
    Int i = 0
    While i < ValidHomeKeywords.GetSize()
        Keyword kwd = ValidHomeKeywords.GetAt(i) as Keyword
        If currentLoc.HasKeyword(kwd)
            isValidHome = true
            i = ValidHomeKeywords.GetSize()
        EndIf
        i += 1
    EndWhile
    
    If !isValidHome
        Debug.Notification("This location cannot be set as Lielle's home.")
        Return
    EndIf
    
    HomeLocation.ForceLocationTo(currentLoc)
    Debug.Notification("Home location set.")
EndFunction

Function PlaceActivityMarker(Int markerType)
    If !HomeLocation.GetLocation()
        Debug.Notification("Must set home location first!")
        Return
    EndIf
    
    If PlayerRef.GetCurrentLocation() != HomeLocation.GetLocation()
        Debug.Notification("Must be in designated home to set activity locations.")
        Return
    EndIf
    
    String markerName
    ObjectReference markerToMove
    
    If markerType == 0 
        markerToMove = SleepMarker
        markerName = "Sleep"
    ElseIf markerType == 1
        markerToMove = EatMarker
        markerName = "Eat"
    ElseIf markerType == 2
        markerToMove = WorkMarker
        markerName = "Work"
    ElseIf markerType == 3
        markerToMove = RelaxMarker
        markerName = "Relax"
    EndIf
    
    If markerToMove
        markerToMove.MoveTo(PlayerRef)
        markerToMove.Enable()
        
        If markerType == 0
            SleepMarkerPlaced = True
        ElseIf markerType == 1
            EatMarkerPlaced = True
        ElseIf markerType == 2
            WorkMarkerPlaced = True
        ElseIf markerType == 3
            RelaxMarkerPlaced = True
        EndIf
        
        AllMarkersPlaced = (SleepMarkerPlaced && EatMarkerPlaced && WorkMarkerPlaced && RelaxMarkerPlaced)
        Debug.Notification(markerName + " location set.")
    EndIf
EndFunction

Function ResetMarkers()
        
    If SleepMarkerPlaced
        SleepMarker.Disable()
		SleepMarker.MoveTo(LielleRejectedOutfitsContainer,120,120,0)
		SleepMarkerPlaced = False
    EndIf
    If EatMarkerPlaced
        EatMarker.Disable()
		EatMarkerPlaced = False
		EatMarker.MoveTo(LielleRejectedOutfitsContainer,120,120,0)
    EndIf
    If WorkMarkerPlaced
        WorkMarker.Disable()
		WorkMarkerPlaced = False
		WorkMarker.MoveTo(LielleRejectedOutfitsContainer,120,120,0)
    EndIf
    If RelaxMarkerPlaced
        RelaxMarker.Disable()
		RelaxMarkerPlaced = False
		RelaxMarker.MoveTo(LielleRejectedOutfitsContainer,120,120,0)
    EndIf
	AllMarkersPlaced = False
	
EndFunction