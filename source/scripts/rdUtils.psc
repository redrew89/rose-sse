Scriptname rdUtils extends Quest

; ReDrew's Tools 0.1 Alpha



; Gradually increments game hour to target value (must be int between 0 and 23)
GlobalVariable Property GameHour Auto

Function SlideTime(int iTime)
	; TODO - Add a float argument to specify the smoothness, as well as the interval to use

	while GameHour.GetValueInt() != iTime
		
		; Sliding time as smoothly as possible, may need to grain out to lower float values
		float	cTime = GameHour.GetValue() + 0.1
		GameHour.SetValue(cTime)
		Utility.Wait(0.1)
	endWhile
	
EndFunction
