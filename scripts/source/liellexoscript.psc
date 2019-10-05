Scriptname LielleXOScript extends Quest  

GlobalVariable Property LielleXOValue Auto  

Message Property LielleXOPlus1 Auto

Message Property LielleXOPlus2 Auto

Message Property LielleXOPlus3 Auto

Message Property LielleXOPlus4 Auto

Message Property LielleXOPlus5 Auto

Message Property LielleXOMinus1 Auto

Message Property LielleXOMinus2 Auto

Message Property LielleXOMinus3 Auto

Message Property LielleXOMinus4 Auto

Message Property LielleXOMinus5 Auto

Function PlusText()
	int aRandomValue = Utility.RandomInt(1, 5)

	if aRandomValue == 1
		LielleXOPlus1.Show()
	elseif aRandomValue == 2
		LielleXOPlus2.Show()
	elseif aRandomValue == 3
		LielleXOPlus3.Show()
	elseif aRandomValue == 4
		LielleXOPlus4.Show()
	elseif aRandomValue == 5
		LielleXOPlus5.Show()
endIf
EndFunction

Function MinusText()
	int aRandomValue = Utility.RandomInt(1, 5)

	if aRandomValue == 1
		LielleXOMinus1.Show()
	elseif aRandomValue == 2
		LielleXOMinus2.Show()
	elseif aRandomValue == 3
		LielleXOMinus3.Show()
	elseif aRandomValue == 4
		LielleXOMinus4.Show()
	elseif aRandomValue == 5
		LielleXOMinus5.Show()
endIf
EndFunction

Function XOPlus(float aValue, bool bSuppressMsg)
	
	if !(bSuppressMsg)
		PlusText()
	EndIf
	
	If LielleXOValue.GetValueInt() < 10
		LielleXOValue.Mod(aValue)
	EndIf

EndFunction


Function XOMinus(float aValue, bool bSuppressMsg)
	
	If !(bSuppressMsg)
		MinusText()
	EndIf
	
	If LielleXOValue.GetValueInt() > 0 
		LielleXOValue.Mod(aValue)
	EndIf
	
EndFunction
