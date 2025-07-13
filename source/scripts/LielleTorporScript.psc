Scriptname LielleTorporScript extends ActiveMagicEffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	LielleCSQSecret.SetStage(25)
	Actor PlayerRef = Game.GetPlayer()
	GameHour.SetValue(1)
	PlayerRef.MoveTo(LielleNightmareStartingLoc)
	

endEvent

ObjectReference Property LielleNightmareStartingLoc Auto

Quest Property LielleCSQSecret Auto

GlobalVariable Property GameHour Auto