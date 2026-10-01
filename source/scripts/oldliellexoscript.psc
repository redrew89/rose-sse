Scriptname LielleXOScript extends Quest Conditional

;GlobalVariable Property LielleXOVar  Auto  

float Property LielleXOVar = 0.0 auto Conditional 

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

Function XOPlus(float aValue)

PlusText()

If LielleXOVar + aValue >= 10
	LielleXOVar=(10)	
Else
	LielleXOVar=(LielleXOVar + aValue)
EndIf

EndFunction


Function XOMinus(float aValue)
MinusText()

If LielleXOVar - aValue <= 0 
	LielleXOVar = 0
Else
   LielleXOVar = (LielleXOVar - aValue)
EndIf

	
EndFunction


