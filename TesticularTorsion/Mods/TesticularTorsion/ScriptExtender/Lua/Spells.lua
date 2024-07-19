function RollDice(diceAmount, faces, minDieValue, maxDieValue)
    local total = 0
    local min = math.min(minDieValue or 1, faces)
    local max = math.min(maxDieValue or faces, faces)
    for i = 1, diceAmount do
        total = total + Ext.Utils.Random(min, max)
    end
    return total
end

local function TorsionDamage(torisonType)
    local damageRoll = 0
    if torisonType == "TT_Spell_Target_Torsion_Minor" then
        damageRoll = RollDice(1, 4)
    elseif torisonType == "TT_Spell_Target_Torsion" then
        damageRoll = RollDice(1, 4)
    elseif torisonType == "TT_Spell_Target_Torsion_2" then
        damageRoll = RollDice(2, 4)
    elseif torisonType == "TT_Spell_Target_Torsion_3" then
        damageRoll = RollDice(3, 4)
    elseif torisonType == "TT_Spell_Target_Torsion_4" then
        damageRoll = RollDice(4, 4)
    elseif torisonType == "TT_Spell_Target_Torsion_5" then
        damageRoll = RollDice(5, 4)
    elseif torisonType == "TT_Spell_Target_Torsion_6" then
        damageRoll = RollDice(6, 4)
    end
    return damageRoll
end

local function AttemptTorsion(target, caster, torisonType)
    local total = Osi.GetVarInteger(target,"TorisonCount")
    if not total then
        total = 0
    end
    if total < 2 then
        local damage = TorsionDamage(torisonType)
        if not (damage == 0) then
            Osi.ApplyDamage(target, damage, "Force", caster)
            Osi.ApplyStatus(target, "PRONE", 1, 1) -- If the same enemy is hit with multiple instances of spell, only 1 prone is applied
            Osi.SetVarInteger(target,"TorisonCount", total) -- Add +1 to enable testicle limit, only two hits do damage.
        end
    else
        Osi.ShowNotification(caster, Osi.ResolveTranslatedString("h47786527gbe5cg4f59g82bag95f0afbb2a4a")) -- Testicles destroyed
    end
end

Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "before", function (caster, target, spell, target2, spellType, someNumber)
    local names = {"TT_Spell_Target_Torsion_Minor", "TT_Spell_Target_Torsion", "TT_Spell_Target_Torsion_2", "TT_Spell_Target_Torsion_3", "TT_Spell_Target_Torsion_4", "TT_Spell_Target_Torsion_5", "TT_Spell_Target_Torsion_6"}
    for index = 1, #names do
        if names[index] == spell then
            if Osi.GetGender(target, 1) == "Male" then
                Osi.SetVarString(target, "TorisonType", spell)
            else
                Osi.ShowNotification(caster, Osi.ResolveTranslatedString("ha393ecb3gfcf7g4ebeg90e5g3fecd8962f55")) -- No testicles
            end
            break
        end
    end
end)

-- On saving throw fail, the status is applied, to prock damage calculation. Read spell type and deal damage accordingly.
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function (target, status, caster, _)
    if status == "TESTICULAR_TORISON" then
        local torisonType = Osi.GetVarString(target, "TorisonType")
        if torisonType then
            AttemptTorsion(target, caster, torisonType)
        end
        Osi.RemoveStatus(target, "TESTICULAR_TORISON")
    end
end)