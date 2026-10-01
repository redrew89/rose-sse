Scriptname LielleCoreScript extends Quest  Conditional

string Property sLielleVersion = "0.4.7 EA" AutoReadOnly ; ReadOnly, so saves from older versions report the current version

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

bool Property LielleWarpaintDiag = false Auto Conditional

bool Property LielleCadmusBookRead = False Auto Conditional

int Property LiellePerfumeDiag = 0 Auto Conditional

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
	debug.OpenUserLog("Lielle") ; User logs close when the game exits - no-op when already open
	debug.TraceUser("Lielle", aMsg)

EndFunction