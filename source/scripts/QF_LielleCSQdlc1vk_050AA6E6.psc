;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname QF_LielleCSQdlc1vk_050AA6E6 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
actor LielleActor = LielleAlias.GetActorRef()
Follower.DismissFollower(0,1,LielleActor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property LielleAlias  Auto  

liellefollowerscript Property Follower  Auto  
