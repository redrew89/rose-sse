Scriptname LielleXOScript extends Quest  

GlobalVariable Property LielleXOVar  Auto  

string pstring1 = "Lielle appreciated that."
string pstring2 = "Lielle liked that."
string pstring3 = "Lielle is pleased by that."
string pstring4 = "Lielle is happy about that."
string pstring5 = "Lielle will remember that."

string mstring1 = "Lielle did not appreciate that."
string mstring2 = "Lielle did not like that."
string mstring3 = "Lielle is not impressed."
string mstring4 = "Lielle hated that."
string mstring5 = "Lielle will remember that."

Function PlusText()
int aRandomValue = Utility.RandomInt(1, 5)

if aRandomValue == 1
	debug.Notification(pstring1)
elseif aRandomValue == 2
	debug.Notification(pstring2)
elseif aRandomValue == 3
	debug.Notification(pstring3)
elseif aRandomValue == 4
	debug.Notification(pstring4)
elseif aRandomValue == 5
	debug.Notification(pstring4)
endIf
EndFunction

Function MinusText()
int aRandomValue = Utility.RandomInt(1, 5)

if aRandomValue == 1
	debug.Notification(mstring1)
elseif aRandomValue == 2
	debug.Notification(mstring2)
elseif aRandomValue == 3
	debug.Notification(mstring3)
elseif aRandomValue == 4
	debug.Notification(mstring4)
elseif aRandomValue == 5
	debug.Notification(mstring5)
endIf
EndFunction

Function XOPlus(float aValue)

PlusText()

If LielleXOVar.GetValueInt() == 10
	return
	
Else
   LielleXOVar.Mod(aValue)
EndIf



EndFunction


Function XOMinus(float aValue)
MinusText()

If LielleXOVar.GetValueInt() == 0 
	return

Else
   LielleXOVar.Mod(aValue)
EndIf

	
EndFunction


