ScriptName TIF__05773021 extends TopicInfo Hidden

leveleditem Property LItemIngredientFoodPrepared Auto

potion Property FoodMarriageMeal Auto

Function Fragment_0(ObjectReference akSpeakerRef)
    actor akSpeaker = (akSpeakerRef as actor)
    game.GetPlayer().AddItem(FoodMarriageMeal, 1, false)
EndFunction

