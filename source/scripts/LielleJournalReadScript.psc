Scriptname LielleJournalReadScript extends ObjectReference  

LielleCoreScript Property Core Auto

Event OnRead()

	if Core.LielleKienaDiag == 0
		Core.LielleKienaDiag = 1
	endif

EndEvent