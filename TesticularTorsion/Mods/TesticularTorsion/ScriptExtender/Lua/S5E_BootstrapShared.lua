Spells = {  
	SpellList = "Spells",
}

local others2ndLevelList5ES = {
    Bard2ndOther = "7ea8f476-97a1-4256-8f10-afa76a845cce",
    Cleric2ndOther = "2968a3e6-6c8a-4c2e-882a-ad295a2ad8ac",
    Druid2ndOther = "92126d17-7f1a-41d2-ae6c-a8d254d2b135",
    FighterEK2ndOther = "4a86443c-6a21-4b8d-b1bf-55a99e021354",
    Ranger2ndOther = "e7cfb80a-f5c2-4304-8446-9b00ea6a9814",
    RogueAT2ndOther = "f9fd64f1-f417-4544-94a9-51d8876d68df",
    Sorcerer2ndOther = "f80396e2-cb76-4694-b0db-5c34da61a478",
    WFiend2ndOther = "835aeca7-c64a-4aaa-a25c-143aa14a5cec",
    WGoO2ndOther = "fe101a94-8619-49b2-859d-a68c2c291054",
    WArchfey2ndOther = "0cc2c8ab-9bbc-43a7-a66d-08e47da4c172",
    Wizard2ndOther = "80c6b070-c3a6-4864-84ca-e78626784eb4"
}

local bardSpells2ndOther = {
	"TT_Spell_Target_Torsion",
}

local clericSpells2ndOther = {
	"TT_Spell_Target_Torsion",
}

local sorcererSpells2ndOther = {
	"TT_Spell_Target_Torsion",
}

local wizardSpells2ndOther = {
	"TT_Spell_Target_Torsion",
}

local others2ndleveladditions = {
    Bard2ndOther = {
        Spells = bardSpells2ndOther,
        SpellListID = others2ndLevelList5ES.Bard2ndOther
    },
    Cleric2ndOther = {
        Spells = clericSpells2ndOther,
        SpellListID = others2ndLevelList5ES.Cleric2ndOther
    },
    Sorcerer2ndOther = {
        Spells = sorcererSpells2ndOther,
        SpellListID = others2ndLevelList5ES.Sorcerer2ndOther
    },
    Wizard2ndOther = {
        Spells = wizardSpells2ndOther,
        SpellListID = others2ndLevelList5ES.Wizard2ndOther
    },
}

function S5E_SpellLists(additions)
if additions ~= nil then
    for _, add in pairs(additions) do
        if add ~= nil then
                local spellList = Spells["SpellList"]
                local list = Ext.StaticData.Get(add.SpellListID, "SpellList")
                list[spellList] = Set(list[spellList], add.Spells)
                end
            end
        end
    end

function Set(spelllist, spells)
    local result = {}
    local num = 0

    if spelllist ~= nil and spells ~= nil then
    result, num = Insert(spelllist, result, num)
    result, num = Insert(spells, result, num)
    end

    return result
end

function InTable(list, val)
    if list ~= nil then
    for _, value in pairs(list) do
        if val == value then
        return true
        end
    end
    end
    return false
end

function Insert(list, result, num)
    for _, value in pairs(list) do
        if not InTable(result, value) then
            result[num] = value
            num = num + 1
        end
    end
    return result, num
end

S5E_SpellLists(others2ndleveladditions)