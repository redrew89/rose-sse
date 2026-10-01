;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PF_LabLielleSleepPackage_05005956 Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
GetInsomnia()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function GetInsomnia()
	
	int aValue
	if  LielleCSQSecret.IsCompleted()
		aValue = utility.randomint(1,10) ; 1 in 10 chance of a nightmare
	else
		aValue = utility.randomint(1,3)  ; 1 in 3 chance of a nightmare
	endif
	
	if aValue == 1
		LielleInsomniaToggle.SetValueInt(1)
	else
		LielleInsomniaToggle.SetValueInt(0)
	endif
	
EndFunction


Quest Property LielleCSQSecret Auto

GlobalVariable Property LielleInsomniaToggle Auto 
