;/ Decompiled by Champollion V1.0.1
Source   : TIF__05A869AF.psc
Modified : 2020-02-01 00:47:51
Compiled : 2020-02-01 00:48:02
User     : Drew
Computer : DREWPC
/;
scriptName TIF__05A869AF extends TopicInfo hidden

;-- Properties --------------------------------------
lielleweddingscript property LielleXO auto

Quest Property RelationshipMarriageFIN Auto
;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	RelationshipMarriageFIN.SetStage(5)
	LielleXO.WeddingEnd()
endFunction

; Skipped compiler generated GotoState
