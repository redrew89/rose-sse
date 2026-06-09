Scriptname LielleEmotionManager extends Quest

; DISCLAIMER - This script was built with assistance from generative AI

Import Utility
Import MfgConsoleFuncExt

; Properties
ReferenceAlias Property LielleAlias Auto  ; Set in CK
String Property sCurrentEmotion = "Neutral" Auto
Float Property EyeResetTimer = 10.0 Auto

; Internal detection properties
;Bool Property bConditionalExpressionsPresent = false Auto
bool Property bMfgFixPresent = false Auto

; Eye textures
TextureSet Property DefaultEyes Auto
TextureSet Property DilatedEyes Auto
TextureSet Property ConstrictedEyes Auto

GlobalVariable Property LielleExpressionDebug Auto
LielleCoreScript Property Core Auto

; Spell for tears effect
Spell Property LielleEmotionTears Auto
MagicEffect Property LielleEmotionTearsFX Auto

; Spell for blush effect
Spell Property LielleEmotionBlush Auto
MagicEffect Property LielleEmotionBlushFX Auto

; Internal variables
Actor Property Lielle auto

Bool bEyeUpdateRegistered = false
String[] sBasicEmotions 
String[] sExtraEmotions

String msgFlag = "LielleCore - EmotionManager: "

Function ResetEmotionManager()
	Core.Msg(msgFlag + "Performing system maintenance. Stand by.")
	OnInit()
EndFunction

Event OnInit()
   
	; Initialize our string arrays for emotion types
	sBasicEmotions = new String[8]
    sBasicEmotions[0] = "Happy"
    sBasicEmotions[1] = "Sad"
    sBasicEmotions[2] = "Anger"
    sBasicEmotions[3] = "Fear"
    sBasicEmotions[4] = "Puzzled"
    sBasicEmotions[3] = "Disgust"
    sBasicEmotions[6] = "Surprised"
    sBasicEmotions[7] = "Neutral"
    
	sExtraEmotions = new String[11]
    sExtraEmotions[0] = 	"Vulnerable"
    sExtraEmotions[1] = 	"Anguish"
    sExtraEmotions[2] = 	"Love"
    sExtraEmotions[3] =		"Overjoyed"
    sExtraEmotions[4] = 	"Flirty"
    sExtraEmotions[3] = 	"Seductive"
    sExtraEmotions[6] = 	"Bitter"
    sExtraEmotions[7] = 	"Embarrassed"
    sExtraEmotions[8] = 	"Flustered"
	sExtraEmotions[9] = 	"Wary"
	sExtraEmotions[10] = 	"Sarcastic"
	
	
    Lielle = LielleAlias.GetActorReference()
    If !Lielle
        Core.Msg(msgFlag + "Failed to get Lielle's reference from alias!", false) ; TODO - This could probably be removed, because we declare Lielle's Actor as a property, now.
        Return
    EndIf
	
	If !(SKSE.GetPluginVersion("mfgfix") == -1)
		bMfgFixPresent = true
		Core.Msg(msgFlag + "Found Mfg Fix NG. Enhancing emotions.")
	Else
		Core.msg(msgFlag + "Mfg Fix NG not found. Check installation. Falling back to default expressions.")
	endif
	
	
	; Initialize neutral state
    ResetEmotionState()
EndEvent

Event OnUpdateGameTime()
	
	ResetEmotionState()
	
EndEvent

; --- REFACTORED CODE TO USE MfgConsoleFuncExt CALLS; SIDE-STEPS CEE SCRIPT DEPENDENCIES
Function HandleEmotions(String emotion, int intensity = 100)
    
	Core.Msg(msgFlag + "Lielle should be expressing: " + emotion, false)
	
	sCurrentEmotion = emotion
    HandleEyeTextures(emotion)
	
     ; Handle tears for intense emotions
	if emotion == "Sad" && intensity >= 90
		SetTears()
	elseif emotion == "Fear" && intensity >= 90
		SetTears()
	elseif emotion == "Anger" && intensity == 100
		SetTears()
	endif
 
	; Handle effects for specific emotions
	if (emotion == "Anguish" && intensity >= 70) || (emotion == "Vulnerable" && intensity >= 90) || (emotion == "Overjoyed" && intensity >= 70)
		Utility.Wait(1)
		SetTears()
	endif   
	if (emotion == "Flirty") || (emotion == "Seductive") || (emotion == "Embarrassed") || (emotion == "Flustered")
		Utility.wait(1)
		SetBlush()
	EndIf
        
    int basicIndex = sBasicEmotions.Find(emotion)
    int extraIndex = sExtraEmotions.Find(emotion)
    
    if basicIndex >= 0 && bMfgFixPresent       
        
        ; Enhanced basic emotions using MfgConsoleFuncExt
        if emotion == "Happy"
            ; Warm happiness
            ; Raise both eyebrows
            MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity, 0.75) ; BrowUpL
            MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity, 0.75) ; BrowUpR
            ; Subtle smile with open mouth
            MfgConsoleFuncExt.SetExpression(Lielle, 2, intensity, 0.75) ; Happy expression
            Utility.Wait(0.5)
            ;MfgConsoleFuncExt.SetPhoneme(Lielle, 5, intensity/3, 0.75) ; Eee for slight smile
            
        elseif emotion == "Sad"
            ; Deep sadness
            MfgConsoleFuncExt.SetModifier(Lielle, 8, intensity/2, 0.75) ; LookDown
            MfgConsoleFuncExt.SetExpression(Lielle, 3, intensity*1.3 as int, 0.75) ; Sad expression
            Utility.Wait(0.5)
            ; Slight frown with mouth slightly open for pained expression
            ;MfgConsoleFuncExt.SetPhoneme(Lielle, 6, intensity/4, 0.75) ; Eh for slight open mouth
            
        elseif emotion == "Anger" 
            ; Intense anger
            MfgConsoleFuncExt.SetExpression(Lielle, 0, intensity, 0.75) ; Anger expression
            Utility.Wait(0.5)
            ; Furrow brows
            MfgConsoleFuncExt.SetModifier(Lielle, 4, intensity, 0.75) ; BrowInL
            MfgConsoleFuncExt.SetModifier(Lielle, 5, intensity, 0.75) ; BrowInR
            Utility.Wait(0.5)
            ; Quick dismissive look
            MfgConsoleFuncExt.SetModifier(Lielle, 9, 30, 1.0) ; LookLeft
            
        elseif emotion == "Fear"
            ; Heightened fear
            ; Initial startle
            MfgConsoleFuncExt.SetExpression(Lielle, 4, intensity, 0.75) ; Surprise expression
            Utility.Wait(0.5)
            ; Fear
            MfgConsoleFuncExt.SetExpression(Lielle, 1, intensity*1.3 as int, 0.75) ; Fear expression
            ; Wide eyes
            MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity, 0.75) ; BrowUpL
            MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity, 0.75) ; BrowUpR
            ; Cowering motion
            MfgConsoleFuncExt.SetModifier(Lielle, 8, 40, 1.0) ; LookDown
            
        elseif emotion == "Puzzled"
            ; Complex confusion
            MfgConsoleFuncExt.SetExpression(Lielle, 5, intensity, 0.75) ; Puzzled expression
            ; Raise eyebrows
            MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity, 0.75) ; BrowUpL
            MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity, 0.75) ; BrowUpR
            Utility.Wait(0.5)
            ; Thoughtful glance
            MfgConsoleFuncExt.SetModifier(Lielle, 10, 20, 1.0) ; LookRight
            
        elseif emotion == "Surprised"
            ; Startled surprise
            MfgConsoleFuncExt.SetExpression(Lielle, 4, intensity, 0.75) ; Surprise expression
            ; Raise eyebrows
            MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity, 0.75) ; BrowUpL
            MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity, 0.75) ; BrowUpR
            Utility.Wait(0.5)
            ; Quick reactive glance
            MfgConsoleFuncExt.SetModifier(Lielle, 9, 20, 1.0) ; LookLeft
            ; Open mouth slightly
            ;MfgConsoleFuncExt.SetPhoneme(Lielle, 0, intensity/3, 0.75) ; Aah for surprised open mouth
            
        ElseIf emotion == "Disgust"
            MfgConsoleFuncExt.SetExpression(Lielle, 6, intensity, 0.75) ; Disgust expression
            Utility.Wait(0.5)
            ; Slight head tilt down for disdain
            MfgConsoleFuncExt.SetModifier(Lielle, 8, 30, 1.0) ; LookDown
            ; Squint eyes slightly
            MfgConsoleFuncExt.SetModifier(Lielle, 12, intensity/2, 0.75) ; SquintL
            MfgConsoleFuncExt.SetModifier(Lielle, 13, intensity/2, 0.75) ; SquintR
            
        elseif emotion == "Neutral"
            MfgConsoleFuncExt.ResetMfg(Lielle, 0.75)
        endif          
    elseif extraIndex >= 0 && bMfgFixPresent
        HandleSpecialEmotions(emotion, intensity)
    endif    
    
    CheckAndClearBlinks()
    RegisterForSingleUpdateGameTime(0.05) ; schedule clean up after 5 minutes in game.
EndFunction

Function HandleSpecialEmotions(String emotion, int intensity = 100)
    ; Calculate scaled intensity for more subtle expressions
    int baseIntensity = math.floor(intensity*1.10)
    float smoothSpeed = 0.75
    
    If emotion == "Vulnerable"
        ; Mix of fear, sadness, and uncertainty
        MfgConsoleFuncExt.SetExpression(Lielle, 1, baseIntensity, smoothSpeed) ; Fear expression
        Utility.Wait(0.5)
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 40, smoothSpeed) ; LookDown
        Utility.Wait(0.5)
        ; Puzzled expression mixed with fear
        MfgConsoleFuncExt.SetExpression(Lielle, 5, 30, smoothSpeed) ; Puzzled expression
        ; Slight mouth open
        ;MfgConsoleFuncExt.SetPhoneme(Lielle, 6, baseIntensity/4, smoothSpeed) ; Eh for slight open mouth
        
    ElseIf emotion == "Anguish"
        ; Deep sorrow and emotional pain
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 80, smoothSpeed) ; LookDown
        Utility.Wait(0.5)
        ; Combined sad expression with furrowed brows
        MfgConsoleFuncExt.SetExpression(Lielle, 3, intensity, smoothSpeed) ; Sad expression
        MfgConsoleFuncExt.SetModifier(Lielle, 2, intensity/2, smoothSpeed) ; BrowDownL
        MfgConsoleFuncExt.SetModifier(Lielle, 3, intensity/2, smoothSpeed) ; BrowDownR
        Utility.Wait(0.5)
        ; Pained expression with slightly open mouth
        MfgConsoleFuncExt.SetPhoneme(Lielle, 6, intensity/3, smoothSpeed) ; Eh phoneme
        
    ElseIf emotion == "Love"
        ; Warm affection
        MfgConsoleFuncExt.SetExpression(Lielle, 2, baseIntensity, smoothSpeed) ; Happy expression
        Utility.Wait(0.5)
        ; Soft smile with raised brows
        MfgConsoleFuncExt.SetModifier(Lielle, 6, baseIntensity/2, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, baseIntensity/2, smoothSpeed) ; BrowUpR
        Utility.Wait(0.5)
        ; Gentle smile
        MfgConsoleFuncExt.SetPhoneme(Lielle, 5, baseIntensity/3, smoothSpeed) ; Eee for slight smile
        
    ElseIf emotion == "Overjoyed"
        ; Extreme happiness
        MfgConsoleFuncExt.SetExpression(Lielle, 2, intensity, smoothSpeed) ; Happy expression
        Utility.Wait(0.5)
        ; Wide smile with raised brows
        MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity, smoothSpeed) ; BrowUpR
        Utility.Wait(0.5)
        ; Big smile
		;MfgConsoleFuncExt.SetPhoneme(Lielle, 5, intensity, smoothSpeed) ; Eee for big smile
        ;MfgConsoleFuncExt.SetPhoneme(Lielle, 0, intensity/2, smoothSpeed) ; Aah for open-mouthed smile
        
    ElseIf emotion == "Flirty"
        ; Playful interest
        MfgConsoleFuncExt.SetExpression(Lielle, 2, baseIntensity, smoothSpeed) ; Happy expression
        Utility.Wait(0.5)
        ; Coy look with raised brow on one side
        MfgConsoleFuncExt.SetModifier(Lielle, 6, baseIntensity, smoothSpeed) ; BrowUpL
        Utility.Wait(0.5)
        ; Look down coyly
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 30, smoothSpeed) ; LookDown
        Utility.Wait(0.5)
        ; Subtle smile
        MfgConsoleFuncExt.SetPhoneme(Lielle, 5, baseIntensity/2, smoothSpeed) ; Eee for slight smile
        
    ElseIf emotion == "Seductive"
        ; More intense flirtation
        MfgConsoleFuncExt.SetExpression(Lielle, 2, intensity/2, smoothSpeed) ; Happy expression at half intensity
        Utility.Wait(0.5)
        ; Raised brows with half-lidded eyes (using squint)
        MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity/2, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity/2, smoothSpeed) ; BrowUpR
        MfgConsoleFuncExt.SetModifier(Lielle, 12, intensity/3, smoothSpeed) ; SquintL
        MfgConsoleFuncExt.SetModifier(Lielle, 13, intensity/3, smoothSpeed) ; SquintR
        Utility.Wait(0.5)
        ; Look down flirtatiously
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 30, smoothSpeed) ; LookDown
        Utility.Wait(0.5)
        ; Sensual smile
        ;MfgConsoleFuncExt.SetPhoneme(Lielle, 5, intensity/2, smoothSpeed) ; Eee for smile
        ; Coy look to the side
        MfgConsoleFuncExt.SetModifier(Lielle, 10, 30, smoothSpeed) ; LookRight
        
    ElseIf emotion == "Bitter"
        ; Disgust with anger elements
        MfgConsoleFuncExt.SetExpression(Lielle, 6, intensity/2, smoothSpeed) ; Disgust expression
        MfgConsoleFuncExt.SetExpression(Lielle, 0, intensity/2, smoothSpeed) ; Mix with Anger expression
        Utility.Wait(0.5)
        ; Furrowed brows
        MfgConsoleFuncExt.SetModifier(Lielle, 2, intensity/2, smoothSpeed) ; BrowDownL
        MfgConsoleFuncExt.SetModifier(Lielle, 3, intensity/2, smoothSpeed) ; BrowDownR
        Utility.Wait(0.5)
        ; Look down disdainfully
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 40, smoothSpeed) ; LookDown
        
    ElseIf emotion == "Embarrassed"
        ; Mix of surprise and bashful behavior
        MfgConsoleFuncExt.SetExpression(Lielle, 4, intensity/2, smoothSpeed) ; Surprise expression at half intensity
		MfgConsoleFuncExt.SetExpression(Lielle, 2, intensity, smoothSpeed) ; Happy expression
        Utility.Wait(0.5)
        ; Look down shyly
        MfgConsoleFuncExt.SetModifier(Lielle, 8, 60, smoothSpeed) ; LookDown
        ; Raised brows
        MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity/3, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity/3, smoothSpeed) ; BrowUpR
        Utility.Wait(0.5)
        ; Slight nervous smile
        ;MfgConsoleFuncExt.SetPhoneme(Lielle, 5, intensity/4, smoothSpeed) ; Eee for slight smile
        
    ElseIf emotion == "Flustered"
        ; Rapid shifts showing discomfort
        MfgConsoleFuncExt.SetExpression(Lielle, 4, intensity/2, smoothSpeed) ; Surprise expression
        MfgConsoleFuncExt.SetExpression(Lielle, 5, intensity/2, smoothSpeed) 
		; Raised brows
        MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity/2, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity/2, smoothSpeed) ; BrowUpR
        Utility.Wait(0.5)
        ; Quick looks to the sides (nervous)
        MfgConsoleFuncExt.SetModifier(Lielle, 9, 30, 0.5) ; LookLeft faster
        Utility.Wait(0.5)
        MfgConsoleFuncExt.SetModifier(Lielle, 10, 30, 0.5) ; LookRight faster
        Utility.Wait(0.5)
        
        ; Slightly open mouth
        MfgConsoleFuncExt.SetPhoneme(Lielle, 6, intensity/4, smoothSpeed) ; Eh for slight open mouth
    
    ElseIf emotion == "Wary"
        ; Mix of puzzlement, fear, and skepticism
        MfgConsoleFuncExt.SetExpression(Lielle, 5, intensity/2, smoothSpeed) ; Puzzled expression
        MfgConsoleFuncExt.SetExpression(Lielle, 1, intensity/3, smoothSpeed) ; Fear expression
		Utility.Wait(0.5)
        ; Suspicious look to the side
        MfgConsoleFuncExt.SetModifier(Lielle, 9, 30, smoothSpeed) ; LookLeft
        ; Slight squint for suspicion
        MfgConsoleFuncExt.SetModifier(Lielle, 12, intensity/4, smoothSpeed) ; SquintL
        MfgConsoleFuncExt.SetModifier(Lielle, 13, intensity/4, smoothSpeed) ; SquintR
        Utility.Wait(0.5)
               
        ; Subtle frown
        MfgConsoleFuncExt.SetModifier(Lielle, 2, intensity/4, smoothSpeed) ; BrowDownL
        MfgConsoleFuncExt.SetModifier(Lielle, 3, intensity/4, smoothSpeed) ; BrowDownR
		
	ElseIf emotion == "Sarcastic"
        ; Mix of disgust and mild happiness/enjoyment - playful ribbing and sarcastic responses
        MfgConsoleFuncExt.SetExpression(Lielle, 6, intensity/2, smoothSpeed) ; Disgust expression
        MfgConsoleFuncExt.SetExpression(Lielle, 2, intensity/4, smoothSpeed) ; Happy expression
		
		Utility.Wait(0.5)
        ; Slight eye roll or look to the side
        MfgConsoleFuncExt.SetModifier(Lielle, 10, 25, smoothSpeed) ; LookRight
        ; Subtle smirk with slight brow raise
        MfgConsoleFuncExt.SetModifier(Lielle, 6, intensity/3, smoothSpeed) ; BrowUpL
        MfgConsoleFuncExt.SetModifier(Lielle, 7, intensity/4, smoothSpeed) ; BrowUpR
        Utility.Wait(0.5)
           
        ; Slight squint for the knowing look
        MfgConsoleFuncExt.SetModifier(Lielle, 12, intensity/5, smoothSpeed) ; SquintL
        MfgConsoleFuncExt.SetModifier(Lielle, 13, intensity/5, smoothSpeed) ; SquintR
    EndIf
    
    CheckAndClearBlinks()
    RegisterForSingleUpdateGameTime(2.0) ; Schedule cleanup after 2 game hours
EndFunction

Function HandleEyeTextures(String emotion)
    If !Lielle
        Return
    EndIf
    
    If emotion == "Flirty" || emotion == "Seductive" || emotion == "Love" || emotion == "Overjoyed" || emotion == "Anger" || emotion == "Surprised" || emotion == "Flustered"
        Lielle.SetEyeTexture(DilatedEyes)
        If !bEyeUpdateRegistered
            RegisterForSingleUpdateGameTime(EyeResetTimer)
            bEyeUpdateRegistered = true
        EndIf
    ElseIf emotion == "Fear" || emotion == "Anguish" || emotion == "Disgust" || emotion == "Bitter"
        Lielle.SetEyeTexture(ConstrictedEyes)
        If !bEyeUpdateRegistered
            RegisterForSingleUpdateGameTime(EyeResetTimer)
            bEyeUpdateRegistered = true
        EndIf
    Else
        Lielle.SetEyeTexture(DefaultEyes)
        bEyeUpdateRegistered = false
        UnregisterForUpdateGameTime()
    EndIf
EndFunction


Function SetTears()
	; We don't need an argument because the magic effect stops when cast again while active
	LielleEmotionTears.Cast(Lielle)
EndFunction


Function SetBlush()
	; We don't need an argument because the magic effect stops when cast again while active
	LielleEmotionBlush.Cast(Lielle)
EndFunction


Function CheckAndClearBlinks()
    if !Lielle
        Return
    endif
    
    ; Check both blink modifiers
    ; Using MfgConsoleFunc.GetModifier which is defined in the original script
    if MfgConsoleFunc.GetModifier(Lielle, 0) > 0 || MfgConsoleFunc.GetModifier(Lielle, 1) > 0
        ; Using MfgConsoleFuncExt.SetModifier with smooth transition
        MfgConsoleFuncExt.SetModifier(Lielle, 0, 0, 0.5) ; Clear left blink
        MfgConsoleFuncExt.SetModifier(Lielle, 1, 0, 0.5) ; Clear right blink
        Core.Msg(msgFlag + "Cleared stuck blink state", false)
    endif
    
    ; Use ResetModifiers from MfgConsoleFuncExt
    MfgConsoleFuncExt.ResetModifiers(Lielle, 0.5)
EndFunction

Function ResetEmotionState()
    Core.Msg(msgFlag + "Clearing the current emotion.", false)
    Utility.wait(1)
    sCurrentEmotion = "Neutral"
    if Lielle.HasMagicEffect(LielleEmotionTearsFX)
        SetTears()
    endif
    if Lielle.HasMagicEffect(LielleEmotionBlushFX)
        SetBlush()
    endif
    HandleEyeTextures("Neutral")
    CheckAndClearBlinks()
    
    ; Reset all expressions and phonemes using MfgConsoleFuncExt
    MfgConsoleFuncExt.ResetMfg(Lielle, 0.75)
EndFunction