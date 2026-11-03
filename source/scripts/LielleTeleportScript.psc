Scriptname LielleTeleportScript extends Quest

; Quiet summon: no portal activator, no sound. The summon fades out, reappears just
; behind the summoner, fades back in, and gets a brief silent dissolve shimmer.
; A negative afDistance places her in front instead.
Function Summon(ObjectReference akSummoner = None, ObjectReference akSummon = None, Float afDistance = 120.0, Float afZOffset = 0.0)
        If !akSummoner || !akSummon
                Return
        EndIf

        EffectShader arriveFX = Game.GetFormFromFile(0x000EC354, "Skyrim.esm") as EffectShader ; TimeFadeIn01FXS - silent dissolve-in, ~2.5s

        akSummon.Disable(True) ; fade out wherever she was
        Float fAngle = akSummoner.GetAngleZ()
        akSummon.MoveTo(akSummoner, -Math.Sin(fAngle) * afDistance, -Math.Cos(fAngle) * afDistance, afZOffset)
        akSummon.Enable(True) ; fade in at the new spot
        If arriveFX
                arriveFX.Play(akSummon, 2.5)
        EndIf
EndFunction
