Scriptname _ARQ_BlackreachScript extends Quest  Conditional

Quest Property LielleARQBlackreach auto

Scene Property LielleARQBlackreachCrystalScene Auto

GlobalVariable Property _ARQAetherCount Auto

GlobalVariable Property _ARQAetherTotal Auto

Function Extract()
	LielleARQBlackreachCrystalScene.Start()
	_ARQAetherCount.Mod(1)
	if _ARQAetherCount.GetValueInt() != _ARQAetherTotal.GetValueInt()
		LielleARQBlackreach.SetStage(30)
	else
		LielleARQBlackreach.SetStage(50)
	endif
EndFunction