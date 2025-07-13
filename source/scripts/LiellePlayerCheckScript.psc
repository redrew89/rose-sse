Scriptname LiellePlayerCheckScript extends Quest  

ReferenceAlias Property PlayerAlias Auto ; Player Alias on LielleCSQMain; contains Lielle_VampTrigger and other scripts

LielleXOScript Property XO Auto


Function ExaminePlayer(bool sameSex, bool abVampire)

	;Commented code to try different implementation
	;Pseudocode to run function on LielleXOScript revision for 0.6.0 to calculate initial Favorability
	;XO.GetFavor(sameSex)
	(PlayerAlias as Lielle_VampTrigger).CheckPlayerVampire(abVampire)
	
EndFunction