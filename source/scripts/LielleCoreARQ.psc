Scriptname LielleCoreARQ extends Quest  Conditional

int Property LielleARQCount = 0 auto Conditional ;research quests done

bool Property LielleARQReady = false auto Conditional ;ready to show results

bool Property LielleARQSpeedUp = false auto Conditional ;faster research

bool Property LielleARQStatus = false auto Conditional ;doing research

string function GetStatus()
	
	if LielleARQStatus && LielleARQReady
		return "Research Complete"
	elseif LielleARQStatus && !LielleARQReady
		return "Doing Research"
	elseif !LielleARQStatus	
		return "Inactive"
	endif	
endFunction 