Scriptname Lielle_CSQBanterScript extends Quest Conditional

int Property AmaleeStage = 0 Auto Conditional

int Property AnumlaStage = 0 Auto Conditional

int Property RumarinStage = 0 Auto Conditional

int Property RecorderStage = 0 Auto Conditional

int Property SofiaStage = 0 Auto Conditional

int Property InigoStage = 0 Auto Conditional

int Property LucienStage = 0 Auto Conditional


Function SetBanterStage(String asData, int aiValue)
	if asData == "Amalee"
		AmaleeStage = aiValue
	elseif asData == "Anumla"
		AnumlaStage = aiValue
	elseif asData == "Rumarin"
		RumarinStage = aiValue
	elseif	asData == "Recorder"
		RecorderStage = aiValue
	elseif asData == "Sofia"
		SofiaStage = aiValue
	elseif asData == "Inigo"
		InigoStage = aiValue
	elseif asData == "Lucien"
		LucienStage = aiValue
	endif	
EndFunction

int Function GetBanterStage(String asData) 
if asData == "Amalee"
		return AmaleeStage
	elseif asData == "Anumla"
		return AnumlaStage
	elseif asData == "Rumarin"
		return RumarinStage
	elseif	asData == "Recorder"
		return RecorderStage
	elseif asData == "Sofia"
		return SofiaStage
	elseif asData == "Inigo"
		return InigoStage
	elseif asData == "Lucien"
		return LucienStage
	endif	
endFunction

	
