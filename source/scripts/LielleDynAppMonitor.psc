Scriptname LielleDynAppMonitor extends ReferenceAlias  

LielleDynamicAppearanceManager Property DynApp Auto
LielleEmotionManager Property Emotions Auto
Formlist Property LielleSafeLocationsFLST Auto
Keyword Property LocTypeClearable Auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	if GetActorReference().GetAV("Health") < 20 && !LielleSafeLocationsFLST.HasForm(GetActorReference().GetCurrentLocation())
		DynApp.bWarpaintSmudge = true
		DynApp.SetWarpaint()
		Emotions.HandleEmotions("Fear",100)
	endif

EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if LielleSafeLocationsFLST.HasForm(akNewLoc)
		if DynApp.bWarpaintSmudge
			DynApp.bWarpaintSmudge = false
			DynApp.SetWarpaint()
		endif	
	endif
	
	if akOldLoc.HasKeyword(LocTypeClearable)
		Emotions.ResetEmotionState()		
	endif

EndEvent
