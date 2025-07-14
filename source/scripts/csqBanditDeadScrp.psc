Scriptname csqBanditDeadScrp extends ReferenceAlias  

ReferenceAlias Property YoungLielle Auto

Event OnDeath(Actor akKiller)
	YoungLielle.GetActorRef().StopCombat()
	YoungLielle.GetActorRef().EvaluatePackage()
endEvent
