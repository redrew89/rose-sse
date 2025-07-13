Scriptname _CSQ_mgScript extends Quest Conditional


bool property LielleAncanoTopic = false Auto Conditional

bool Property LielleMG03Topic = false Auto Conditional

bool Property LiellePsijicTopic = false Auto Conditional

bool Property LielleMG04Topic = false Auto Conditional

bool Property LielleMG06Topic1 = false Auto Conditional

bool Property LielleMG06Topic2 = false Auto Conditional


Function LielleAncanoTopicSay(bool akBool)
	LielleAncanoTopic = akBool
EndFunction

Function LiellePsijicTopicSay(bool akBool)
	LiellePsijicTopic = akBool
EndFunction	

Function LielleMG03TopicSay(bool akBool)

	LielleMG03Topic = akBool
EndFunction

Function LielleMG04TopicSay(bool akBool)

	LielleMG04Topic = akBool
EndFunction

Function LielleMG06Topic1Say(bool akBool)

	LielleMG06Topic1 = akBool
EndFunction


Function LielleMG06Topic2Say(bool akBool)

	LielleMG06Topic2 = akBool
EndFunction