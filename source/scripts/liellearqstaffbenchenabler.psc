Scriptname LielleARQStaffBenchEnabler extends Quest  

ObjectReference Property LielleDLC2StaffEnch  Auto  

Function DoTheThing()

	If !(LielleDLC2StaffEnch.isEnabled())
		LielleDLC2StaffEnch.Enable()
	Endif

EndFunction