require("Enums")

RuneLib = {
    PressTheAttack = {
        Dmg             = function() return 40 + 140 / 17 * (HeroLvl() - 1) end,
        IncreasedDmgMod = function() return 0.08 + 0.04 / 17 * (HeroLvl() - 1) end,
    }
}