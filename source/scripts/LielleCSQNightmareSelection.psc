Scriptname LielleCSQNightmareSelection extends Quest  

Message Property LielleCSQAlteredMsg  Auto  

Message Property LielleCSQUncutMsg  Auto  

Message Property LielleCSQRewardUncut Auto

Message Property LielleCSQRewardAltered Auto

Perk Property LielleCSQTrust Auto

ReferenceAlias Property PlayerAlias Auto

LielleCoreScript Property LielleCore  Auto  


Function UncutNightmareDisplay()
	
	LielleCore.LielleNightmarePG = 0 ; Disables script conditional, enabling original Nightmare
	int iButton = LielleCSQUncutMsg.Show()
		if iButton == 1
			self.AlteredNightmareDisplay()
		endif
			
endFunction
	
Function AlteredNightmareDisplay()

	LielleCore.LielleNightmarePG = 1 ; Enables script conditional, disabling original Nightmare
	int iButton = LielleCSQAlteredMsg.Show()
		if iButton == 1
			self.UncutNightmareDisplay()
		endif
endFunction		


Function RewardDisplay()

	if LielleCore.LielleNightmarePG == 0
		;LielleCSQRewardUncut.show()
		PlayerAlias.GetActorRef().AddPerk(LielleCSQTrust)
	elseif LielleCore.LielleNightmarePG == 1
		;LielleCSQRewardAltered.show()
		
	endif
endFunction

Event OnUpdateGameTime()
	if Self.getStage() != 60
		Self.setStage(60)
	endif
EndEvent

Function SetRecoverWait()
	RegisterforSingleUpdateGameTime(24)
endFunction