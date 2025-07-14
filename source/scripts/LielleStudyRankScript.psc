Scriptname LielleStudyRankScript extends Quest

LielleCoreScript Property Core Auto

ReferenceAlias Property LielleAlias Auto

float Property LielleStudyRank Auto

Perk Property LiellePerk1 Auto

Perk Property LiellePerk2 Auto

Perk Property LiellePerk3 Auto

Perk Property LiellePerk4 Auto

Perk Property LiellePerk5 Auto

string msgFlag = "LielleCore - StudyRank: "

float Function getRank()
	return LielleStudyRank
endFunction

Function RankAdd(float RankValue)

	float nRank = (LielleStudyRank + RankValue) 
	int	cRank = Math.Floor(LielleStudyRank)  		
	
	if nRank > 50
		return
	endif
	
	if nRank > cRank
		RankUp()
		
		if (nRank as int % 10) == 0
			int pRank = nRank as int / 10 
			PerkAdd(pRank)
		endif
		
	endif
			
	LielleStudyRank=(LielleStudyRank + RankValue) 
	
EndFunction


Function RankUp()
		
	Core.Msg(msgFlag + "Lielle has gained a study rank!")
	(LielleAlias.GetReference() as Actor).ModAV("Magicka", 10)
	
EndFunction 


Function PerkAdd(int PerkLevel)	
	Core.Msg(msgFlag + "Lielle has gained a new perk!")
	
	if PerkLevel == 1
		(LielleAlias.GetReference() as Actor).AddPerk(LiellePerk1)		
	elseif PerkLevel == 2
		(LielleAlias.GetReference() as Actor).AddPerk(LiellePerk2)
	elseif PerkLevel == 3
		(LielleAlias.GetReference() as Actor).AddPerk(LiellePerk3)
	elseif PerkLevel == 4
		(LielleAlias.GetReference() as Actor).AddPerk(LiellePerk4)
	elseif PerkLevel == 5
		(LielleAlias.GetReference() as Actor).AddPerk(LiellePerk5)
	endif
	
EndFunction

