Scriptname Lielle_BlushScript extends ActiveMagicEffect

; Properties
Actor Property PlayerRef Auto
Bool Property DebugMode = False Auto


; Internal variables
Actor BlushingActor
Bool shuttingDown = False
Bool useNiOverride = False
String overlayNode = ""
Bool isFemale
Float frameDelay = 0.05
String blushTexture = "textures\\effects\\blush\\blush.dds" ; Replace with your actual blush texture path
Float fadeDuration = 0.5

Event OnEffectStart(Actor akTarget, Actor akCaster)
    shuttingDown = False
    BlushingActor = akTarget
    isFemale = (akTarget.GetActorBase().GetSex() == 1)

    ; Check for NiOverride and RaceMenu support
    If !((SKSE.GetPluginVersion("skee64") == -1) && (NiOverride.GetScriptVersion() < 6))
        useNiOverride = InitializeBlushOverlay(akTarget)
        If useNiOverride
            FadeInBlush()
        Else
            If DebugMode
                Debug.Trace("LielleBlush: Failed to initialize NiOverride overlay slot.")
            EndIf
            self.Dispel()
        EndIf
    Else
        If DebugMode
            Debug.Trace("LielleBlush: NiOverride not detected. Ending effect.")
        EndIf
        self.Dispel()
    EndIf
EndEvent

Bool Function InitializeBlushOverlay(Actor target)
    If !niOverride.HasOverlays(target)
        niOverride.AddOverlays(target)
        Utility.Wait(0.1)
    EndIf

    Int overlayCount = niOverride.GetNumFaceOverlays()
    Int i = 0
    While i < overlayCount
        String testNode = "Face [Ovl" + i as String + "]"
        String currentTex = niOverride.GetNodeOverrideString(target, isFemale, testNode, 9, 0)
        If currentTex == "" || StringUtil.Find(currentTex, "default.dds", 0) != -1
            overlayNode = testNode
            Return true
        EndIf
        i += 1
    EndWhile
    Return false
EndFunction

Function FadeInBlush()
    If overlayNode != ""
        Float step = 0.1
        Float alpha = 0.0
        niOverride.AddNodeOverrideString(BlushingActor, isFemale, overlayNode, 9, 0, blushTexture, true)
        ; Overlay slots keep the shader values their last user left - set tint and glow explicitly, as LielleDynamicTattoo does
        niOverride.AddNodeOverrideInt(BlushingActor, isFemale, overlayNode, 7, -1, 0xFFFFFF, true) ; ShaderTintColor - white
        niOverride.AddNodeOverrideInt(BlushingActor, isFemale, overlayNode, 0, -1, 0, true) ; ShaderEmissiveColor - none
        niOverride.AddNodeOverrideFloat(BlushingActor, isFemale, overlayNode, 1, -1, 0.0, true) ; ShaderEmissiveMultiple - no glow
        While alpha < 1.0 && !shuttingDown
            niOverride.AddNodeOverrideFloat(BlushingActor, isFemale, overlayNode, 8, -1, alpha, true)
            niOverride.ApplyNodeOverrides(BlushingActor)
            alpha += step / fadeDuration
            Utility.Wait(step)
        EndWhile
        niOverride.AddNodeOverrideFloat(BlushingActor, isFemale, overlayNode, 8, -1, 1.0, true)
        niOverride.ApplyNodeOverrides(BlushingActor)
    EndIf
EndFunction

Function FadeOutBlush()
    If overlayNode != ""
        Float step = 0.1
        Float alpha = 1.0
        While alpha > 0.0
            niOverride.AddNodeOverrideFloat(BlushingActor, isFemale, overlayNode, 8, -1, alpha, true)
            niOverride.ApplyNodeOverrides(BlushingActor)
            alpha -= step / fadeDuration
            Utility.Wait(step)
        EndWhile
        ; Clear the alpha by resetting it to 0
        niOverride.AddNodeOverrideFloat(BlushingActor, isFemale, overlayNode, 8, -1, 0.0, true)
        niOverride.AddNodeOverrideString(BlushingActor, isFemale, overlayNode, 9, 0, "", true)
        niOverride.ApplyNodeOverrides(BlushingActor)
    EndIf
EndFunction

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    shuttingDown = true
    FadeOutBlush()
EndEvent
