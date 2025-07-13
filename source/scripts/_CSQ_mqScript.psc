Scriptname _CSQ_mqScript extends Quest  Conditional

bool Property mq103Topic = false Auto Conditional

bool Property mq104Topic = false Auto Conditional

bool Property mq105Topic = false Auto Conditional

bool Property mq105Usten = false Auto Conditional

bool Property mq105Usten2 = false Auto Conditional

bool Property mq106Topic = false Auto Conditional

bool Property mq106Sahloknir = false Auto Conditional

bool Property mq201Party = false Auto Conditional

bool Property mq201Thalmor = false Auto Conditional

bool Property mq201ToldYa = false Auto Conditional

bool Property mq203Alduin = false Auto Conditional

bool Property mq203Sky = false Auto Conditional

bool Property mq204Paar = false Auto Conditional

bool Property mq205Scroll1 = false Auto Conditional

bool Property mq205Scroll2 = false Auto Conditional

bool Property mq206Topic = false Auto Conditional

bool Property mq301Topic = false Auto Conditional

bool Property mq301Odahviing = false Auto Conditional

bool Property mq305Topic = false Auto Conditional

bool Property mq302Depart = false Auto Conditional

bool property mqBFBTopic = false Auto Conditional

bool Property mqCWTopic = false Auto Conditional

bool Property mqSignusTopic = False Auto Conditional

bool Property mqMoraTopic = False Auto Conditional

bool Property mqOghmaTopic = False Auto Conditional

Function mq103TopicSay()
	mq103Topic = true
endfunction

Function mq104TopicSay()
	mq104Topic = true
endfunction

Function mq105TopicSay()
	mq105Topic = true
endfunction
	
Function mq105UstenSay()
	mq105Usten = true
EndFunction

Function mq105Usten2Say()
	mq105Usten2 = true
EndFunction

Function mq106SahloknirSay()
	mq106Sahloknir = true
EndFunction

Function mq106TopicSay()
	mq106Topic = true
EndFunction

Function mq201PartySay()
	mq201Party = true
EndFunction

Function mq201ThalmorSay()
	mq201Thalmor = true
endfunction

Function mq201ToldYaSay()
	mq201ToldYa = true
endfunction

Function mq203AlduinSay()
	mq203Alduin = true
EndFunction

Function mq203SkySay()
	mq203Sky = true
EndFunction

Function mq204Paar()
	mq204Paar = true
EndFunction

Function mq205Scroll1Say()
	mq205Scroll1 = true
EndFunction

Function mq205Scroll2Say()
	mq205Scroll2 = true
EndFunction

Function mq206TopicSay()
	mq206Topic = true
EndFunction

Function mqCWTopicSay()
	mqCWTopic = true
EndFunction

Function mq301OdahviingSay()
	mq301Odahviing = true
EndFunction

Function mq301TopicSay()
	mq301Topic = true
EndFunction

Function mq302DepartSay()
	mq302Depart = true
EndFunction

Function mq305TopicSay()
	mq305Topic = true
EndFunction

Function mqBFBTopicSay()
	mqBFBTopic = true
EndFunction

Function mqSignusTopicSay()
	mqSignusTopic = true
EndFunction	

Function mqMoraTopicSay()
	mqMoraTopic = True
EndFunction

Function mqOghmaTopicSay()
	mqOghmaTopic = True
EndFunction