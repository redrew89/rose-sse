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

	if RankValue <= 0.0 || LielleStudyRank >= 50.0
		return
	endif

	float nRank = LielleStudyRank + RankValue
	if nRank > 50.0
		nRank = 50.0
	endif

	int cRank = Math.Floor(LielleStudyRank)
	int newRank = Math.Floor(nRank)
	LielleStudyRank = nRank

	; One rank-up per whole rank crossed, and a perk for each multiple of 10 crossed
	int i = cRank + 1
	while i <= newRank
		RankUp()
		if (i % 10) == 0
			PerkAdd(i / 10)
		endif
		i += 1
	endWhile

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

