;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SF_LielleNightmareCampScene1_0661428D Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;;script
if Core.LielleNightmarePG
GetOwningQuest().SetStage(30)
aScene.Stop()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

LielleCoreScript Property Core Auto 

Scene Property aScene  Auto  
