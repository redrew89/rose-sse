;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 42
Scriptname QF_LielleCSQSecret_054B06BB Extends Quest Hidden

;BEGIN ALIAS PROPERTY InjuredLielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_InjuredLielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChildLielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildLielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY LielleNightmareAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_LielleNightmareAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChildMalekAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildMalekAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY NoteAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_NoteAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MarkusAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MarkusAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY YoungLielleAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_YoungLielleAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY 3EyesAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_3EyesAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChildMarekAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChildMarekAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
DA16DreamState.Remove()
Game.EnablePlayerControls()
Game.GetPlayer().MoveTo(mgMarkerRef)
Alias_LielleNightmareAlias.GetReference().Disable()
SetObjectiveCompleted(25)

Game.RequestSave()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Game.SetPlayerAIDriven()
mbNightmareControl.Show()
SetObjectiveCompleted(20)
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
if Core.LielleNightmarePG 
   XO.XOPlus(2.5)
else
   XO.XOPlus(4)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
(Alias_LielleNightmareAlias.GetReference() as Actor).EvaluatePackage()
Game.RequestSave()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(15)
SetObjectiveCompleted(18)
SetObjectiveDisplayed(20)

kmyQuest.EndResearch()
Alias_LielleNightmareAlias.GetReference().Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
RegisterforSingleUpdate(1800)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
(Alias_LielleNightmareAlias.GetReference() as Actor).SetExpressionOverride(11,100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
SetObjectiveDisplayed(18)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
Game.SetPlayerAIDriven(false)
mbNightmareControlGiven.show()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
;shuts down quest completely, used to track state for other behavior
setObjectiveCompleted(30)
kmyQuest.EndResearch()

self.Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE LielleARQTimerScript
Quest __temp = self as Quest
LielleARQTimerScript kmyQuest = __temp as LielleARQTimerScript
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(10)
setObjectiveDisplayed(15)
LielleCSQSecretPrestart.SetStage(20)
kmyQuest.BeginResearch()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
DA16DreamState.Apply(0.5)
Game.DisablePlayerControls(0,1,0,0,1,1,0,1)
Utility.Wait(5)
Game.RequestSave()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
(Alias_LielleNightmareAlias.GetReference() as Actor).ClearExpressionOverride()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Event OnUpdate()
	if Self.getStage() == 50
		Self.setStage(60)
	endif
EndEvent


WICourierScript Property CourierScript  Auto  

Message Property mbNightmareControl  Auto  

ObjectReference Property mgMarkerRef  Auto  

Message Property mbNightmareControlGiven  Auto  

ImageSpaceModifier Property DA16DreamState  Auto  

Quest Property LielleCSQSecretPrestart  Auto  

LielleCoreScript Property Core  Auto  

LielleXOScript Property XO  Auto  
