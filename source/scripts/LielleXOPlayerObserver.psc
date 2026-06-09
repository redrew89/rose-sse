Scriptname LielleXOPlayerObserver extends ActiveMagicEffect

Quest Property LielleXOQPokeUp Auto
Quest Property LielleXOQPokeDown Auto

Spell Property FavorJobsBeggarsAbility Auto

LielleXOScript Property XO Auto
LielleCoreScript Property Core Auto

ReferenceAlias Property Lielle_AllyAlias Auto

Faction Property CurrentFollowerFaction Auto

Scene Property LielleXOPlusScene Auto
Scene Property LielleXOMinusScene Auto
Scene Property LielleXOQVampireNag Auto
Scene Property LielleXOQBribeScene Auto
Scene Property LielleXOQTheftScene Auto
Scene Property LielleXOQPersuadeScene Auto
Scene Property LielleXOQIntimidateScene Auto
Scene Property LielleXOQSkoomaScene Auto
Scene Property LielleXOQAlcoholScene Auto

Keyword Property LielleObserveIntoxicant Auto
Keyword Property LielleObserveIntoxicantSkooma Auto
Keyword Property LielleObserveIntoxicantAlcohol Auto

String[] Property sTrackedStats Auto
String msgFlag = "LielleCore - Affection: "


Event OnEffectStart(actor aktarget, actor akcaster)

	RegisterForTrackedStatsEvent()
	
	sTrackedStats = new String[10]
	sTrackedStats[0] = "Assaults"
	sTrackedStats[1] = "Murders"
	sTrackedStats[2] = "Persuasions"
	sTrackedStats[3] = "Bribes"
	sTrackedStats[4] = "Intimidations"
	sTrackedStats[5] = "Skill Books Read"
	sTrackedStats[6] = "Bunnies Slaughtered"
	sTrackedStats[7] = "Spells Learned"
	sTrackedStats[8] = "Items Stolen"
	sTrackedStats[9] = "Days as a Vampire"
	
	Core.Msg(msgFlag + "Player Observer Events Registered. Keeping an eye on you...",false)
	
EndEvent

Event OnSpellCast(Form akSpell)
	if (akSpell as Spell) == FavorJobsBeggarsAbility
		LielleXOQPokeUp.Start()
	endif
endEvent

bool Function IsLiellePresent()

	; First, let's make sure she's even present
	ObjectReference Lielle = Lielle_AllyAlias.GetActorReference()
	if !(Lielle && ((Lielle as Actor).IsInFaction(CurrentFollowerFaction) && (Lielle as Actor).IsPlayerTeammate()) && (Lielle.GetDistance(GetTargetActor()) <= 500))
		return false ; She's not there. Didn't see it. Didn't happen. 
	endif	
	
	if Game.GetPlayer().HasLOS(Lielle)
		return true ; Shit, she saw that.
	else
		return false ; Phew, got lucky.
	endif

EndFunction


Float fReactionCooldown 

Event OnTrackedStatsEvent(string asStat, int aiStatValue)

	; First, let's make sure she's even present
	if !IsLiellePresent()
		return
	endif
	
	If Utility.GetCurrentRealTime() < fReactionCooldown
		Return ; suppress reaction
	EndIf

	fReactionCooldown = Utility.GetCurrentRealTime() + 10.0 ; 2 seconds cooldown


	int StatIndex = sTrackedStats.Find(asStat)
	
	if StatIndex == 0 || StatIndex == 1 || StatIndex == 6 
		LielleXOMinusScene.Start()
	elseif StatIndex == 5 || StatIndex == 7 
		LielleXOPlusScene.Start()		
	elseif StatIndex == 2
		XO.XOPlus(0.2)
		LielleXOQPersuadeScene.Start()
	elseif StatIndex == 4
		XO.XOMinus(0.2)
		LielleXOQIntimidateScene.Start()
	elseif StatIndex == 9
		XO.XOMinus(0.25)
		LielleXOQVampireNag.Start()
	elseif StatIndex == 3
		LielleXOQBribeScene.Start()
	elseif StatIndex == 8
		LielleXOQTheftScene.Start()
	endif

EndEvent

int iAlcoholConsumed = 0

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	
	; First, let's make sure she's even present
	if !IsLiellePresent()
		return
	endif
	
	if akBaseObject.HasKeyword(LielleObserveIntoxicant)
		if akBaseObject.HasKeyword(LielleObserveIntoxicantSkooma)
			XO.XOMinus(0.2)
			LielleXOQSkoomaScene.Start()		
		elseif akBaseObject.HasKeyword(LielleObserveIntoxicantAlcohol)
			iAlcoholConsumed += 1
			if iAlcoholConsumed > 3
				XO.XOMinus(0.15)
				LielleXOQAlcoholScene.Start()
			endif
			RegisterForSingleUpdateGameTime(4)
		endif
	endif

EndEvent

Event OnUpdateGameTime()

	if iAlcoholConsumed > 0
		iAlcoholConsumed = 0
	endif

EndEvent
