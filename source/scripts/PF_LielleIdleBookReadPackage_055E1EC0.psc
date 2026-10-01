;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname PF_LielleIdleBookReadPackage_055E1EC0 Extends Package Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(Actor akActor)
;BEGIN CODE
Utility.Wait(45)
LielleReadingSceneGV.SetValueInt(0) 
akActor.EvaluatePackage()
LielleBookReadMarker.Disable()
LielleIdleBookReadScene.Stop()
akActor.PlayIdle(LooseIdleStop)

;debug.notification("Done reading.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(Actor akActor)
;BEGIN CODE
akActor.PlayIdle(idlewipebrow)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property LielleIdleBookReadScene  Auto  

Idle Property LooseIdleStop  Auto  

ObjectReference Property LielleBookReadMarker  Auto  

GlobalVariable Property LielleReadingSceneGV  Auto  

Idle Property IdleWipeBrow  Auto  
