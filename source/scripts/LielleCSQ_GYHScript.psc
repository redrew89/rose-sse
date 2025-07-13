Scriptname LielleCSQ_GYHScript extends Quest  

Quest Property WW42HugFollower  Auto

LielleXOScript Property XOScript Auto

function HugFollower(Actor akSpeaker)
    WW42HugFollowerScript hugscript = WW42HugFollower as WW42HugFollowerScript
	hugscript.ExtOverrideNPCHeight = 0.85
	hugscript.HugActor(akSpeaker)
endfunction


Function HugSet(int HugOverride)
	WW42HugFollowerScript hugscript = WW42HugFollower as WW42HugFollowerScript
	;Function to set hugscript.ExtForceAnimationType via dialogue fragment
	if HugOverride == 0 
		if XOScript.LielleXOVar >= 0 && XOScript.LielleXOVar < 5 
			hugscript.ExtForceAnimationType = 2 ;salute
		elseif XOScript.LielleXOVar >= 5 && XOScript.LielleXOVar < 9
			hugScript.ExtForceAnimationType = 1 ;hug
		elseif XOScript.LielleXOVar >= 9
			hugscript.ExtForceAnimationType = 3 ;embrace - REQUIRES OAR
		endif
	else
		hugScript.ExtForceAnimationType = HugOverride
	endif
	
endfunction