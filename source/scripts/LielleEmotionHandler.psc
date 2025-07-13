Scriptname LielleEmotionHandler extends ReferenceAlias  

;Import CondiExp_Util ; Let's just do this so we can call what we need directly, it's not too invasive, right? --- DEPRECIATED NOW CALLING MfgConsoleFunctExt DIRECTLY
LielleEmotionManager Property Emotions Auto

Event OnActivate(ObjectReference akActivator)
	
	if akActivator == Game.GetPlayer() && Emotions.bMfgFixPresent
		Emotions.ResetEmotionState()
	endif
	
endEvent