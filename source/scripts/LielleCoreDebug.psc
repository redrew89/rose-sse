Scriptname LielleCoreDebug Extends Quest

GlobalVariable Property LielleARQCount Auto

GlobalVariable Property LielleARQReady Auto

GlobalVariable Property LielleARQStatus Auto

GlobalVariable Property LielleXOValue Auto


Quest Property LielleARQGauldur  Auto  

Quest Property LielleARQGauldurPart  Auto  

Quest Property LielleARQRose  Auto  

Quest Property LielleARQRoseNeloth  Auto  

Quest Property LielleARQRoseFinal Auto

Quest Property LielleARQDawn  Auto  

Quest Property LielleARQRazor  Auto  



Quest Property LielleARQSpellbreak Auto

Quest Property LielleCSQmg Auto

Quest Property LielleCSQmq Auto

Quest Property LielleCSQdlc1vk Auto

Quest Property LielleCSQdlc1dg Auto

Quest Property LielleCSQdlc2 Auto

Quest Property LielleCSQcwEmpire Auto

Quest Property LielleCSQcwSons Auto

Quest Property LielleCSQtg Auto

Quest Property LielleCSQdb Auto

Quest Property LielleCSQSecret Auto

Quest Property LielleDialogueQuest Auto

Message Property LielleCoreDebugResetMsgBox Auto

ReferenceAlias Property LielleAlias Auto

Function BrainOutput()

	;;This script will fire debugs for all of the things
	debug.Notification("ARQ Status: " + LielleARQStatus.GetValueInt())
	debug.Notification("ARQ Count: " + LielleARQCount.GetValueInt())
	debug.Notification("ARQ Ready: " + LielleARQReady.GetValueInt())
	debug.Notification("XO Value: " + LielleXOValue.GetValueInt())

EndFunction 


Function ARQMax()

	LielleARQCount.SetValueInt(10)

EndFunction

Function XOLove()

	LielleXOValue.SetValueInt(10)

EndFunction

Function XOHate()

	LielleXOValue.SetValueInt(0)

EndFunction

; TODO: Make this less ugly. Define MessageBox object

Function QuestOutput()  

	Debug.MessageBox("Research Quests \n" + "LielleARQIntro: " + LielleARQIntro.GetStage() + "\n" + "LielleARQGauldurPart: " + LielleARQGauldurPart.GetStage() + "\n" + "LielleARQGauldur: " + LielleARQGauldur.GetStage() + "\n" + "LielleARQRose: " + LielleARQRose.GetStage() + "\n" + "LielleARQRoseNeloth: " + LielleARQRoseNeloth.GetStage() + "\n" + "LielleARQRoseFinal: "+ LielleARQRoseFinal.GetStage() + "\n" + "LielleARQDawn: " + LielleARQDawn.GetStage() + "\n" + "LielleARQRazor: " + LielleARQRazor.GetStage() + "\n" + "LielleARQSpellbreak: " + LielleARQSpellbreak.GetStage() + "\n")
	Debug.MessageBox("Story Quests \n" + "LielleCSQmg: " + LielleCSQmg.GetStage() + "\n" + "LielleCSQmq: " + LielleCSQmq.GetStage() + "\n" + "LielleCSQdlc1dg: " + LielleCSQdlc1dg.GetStage() + "\n" + "LielleCSQdlc1vk: " + LielleCSQdlc1vk.GetStage() + "\n" + "LielleCSQdlc2: " + LielleCSQdlc2.GetStage() + "\n" + "LielleCSQcwEmpire: " + LielleCSQcwEmpire.GetStage() + "\n" + "LielleCSQcwSons: " + LielleCSQcwSons.GetStage() + "\n" + "LielleCSQtg: " + LielleCSQtg.GetStage() + "\n" + "LielleCSQdb: " + LielleCSQdb.GetStage() + "\n" + "LielleCSQSecret: " + LielleCSQSecret.GetStage() + "\n")

EndFunction

Function Reset()

	Int DoReset = LielleCoreDebugResetMsgBox.Show()
	If DoReset == 0
		LielleARQCount.SetValueInt(0)
		LielleARQStatus.SetValueInt(0)
		LielleARQReady.SetValueInt(0)
		LielleXOValue.SetValueInt(0)
		(LielleDialogueQuest as LielleFollowerScript).DismissFollower(0,0, (LielleAlias.GetReference() as Actor))
		
	Else
		;Do nothing
	EndIf

EndFunction