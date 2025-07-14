Scriptname LielleCoreScript extends Quest  Conditional

string Property sLielleVersion = "0.4.5 - The True Voice Update" Auto 

string Property LastVer auto 

bool Property Lielle3EyesDiag = false auto Conditional ;Three-Eyes dialogue flag

bool Property LielleTattooDiag = false auto Conditional ;Tattoo dialogue flag

int Property LielleKienaDiag = 0 auto Conditional ;Kiena dialogue flag

bool Property LielleARQStaffCheck = false auto Conditional ;Neloth staff enchanter research flag.

bool Property LielleNightmarePG = true auto Conditional ;Nightmare alternate

bool Property LielleVerbose = true auto Conditional

bool Property LielleNativeHeal = true auto Conditional

bool Property LielleVampireHistory = false Auto Conditional

bool Property LielleCollegeHistory = false Auto Conditional

bool Property LielleCollegeInsomnia = false Auto Conditional

string Function LielleVersion()
	return sLielleVersion
EndFunction 


Event OnInit()

	Debug.OpenUserLog("Lielle")
	msg("LielleCore Initialized. Logging started for version " + sLielleVersion)
	
EndEvent

Function Msg(string aMsg, bool bVerboseOverride = true)

	if LielleVerbose && bVerboseOverride
		debug.notification(aMsg)
	Endif
	debug.Trace(aMsg)
	debug.TraceUser("Lielle", aMsg)

EndFunction