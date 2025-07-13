Scriptname Lielle_FleeScript extends Quest  


Function LielleFleeNoteSend()                       

RegisterForUpdateGameTime(24) 

endFunction

Event OnUpdateGameTime() ;    
 if LielleCSQFlee.GetStage() == 20
	LielleFleeNoteAlias.ForceRefTo(Game.GetPlayer().PlaceAtMe(LielleFleeNote))
	(WICourier as WICourierScript).AddAliasToContainer(LielleFleeNoteAlias)
    UnregisterForUpdateGameTime() ;
  endIf
endEvent

Book Property LielleFleeNote Auto
    Quest Property WICourier Auto
        Quest Property LielleCSQFlee Auto
            ReferenceAlias Property LielleFleeNoteAlias Auto 