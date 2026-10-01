;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SF_LielleIdleBookReadScene_055E1EBD Extends Scene Hidden

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
LielleReadingSceneGV.SetValueInt(0) 
LielleFollowerAlias.GetActorReference().EvaluatePackage()
LielleBookReadMarker.Disable()
LielleFollowerAlias.GetActorReference().PlayIdle(WipeBrow)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;LielleBookReadMarker.Disable()
;LielleFollowerAlias.GetActorReference().EvaluatePackage()
;LielleFollowerAlias.GetActorReference().PlayIdle(WipeBrow)
;debug.notification("Done reading.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
LielleReadingSceneGV.SetValueInt(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
LielleBookReadMarker.MoveTo(LielleFollowerAlias.GetActorReference())
LielleBookReadMarker.Enable()
LielleReadingSceneGV.SetValueInt(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property LielleFollowerAlias  Auto  

ObjectReference Property LielleBookReadMarker  Auto  

Idle Property WipeBrow  Auto  

GlobalVariable Property LielleReadingSceneGV  Auto  
