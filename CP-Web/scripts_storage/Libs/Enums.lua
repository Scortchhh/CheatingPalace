Colors = {
    Pink = {
        R = 247,
        G = 37,
        B = 133
    },
    PinkDark = {
        R = 181,
        G = 23,
        B = 158,
    },
    Purple = {
        R = 114,
        G = 8,
        B = 183,
    },
    PurpleDarker = {
        R = 86,
        G = 11,
        B = 173
    },
    PurpleDark = {
        R = 72,
        G = 12,
        B = 168
    },
    BlueDark = {
        R = 58,
        G = 12,
        B = 163
    },
    BlueDarker = {
        R = 63,
        G = 55,
        B = 201,
    },
    Blue = {
        R = 67,
        G = 97,
        B = 238
    },
    BlueLight = {
        R = 72,
        G = 149,
        B = 239,
    },
    Turqoise = {
        R = 76,
        G = 201,
        B = 240
    },
    Green = {
        R = 82,
        G = 183,
        B = 136
    },
    GreenDark = {
        R = 27,
        G = 67,
        B = 50
    },
    GrayLight = {
        R = 233,
        G = 236,
        B = 239
    },
    Gray = {
        R = 173,
        G = 181,
        B = 189,
    },
    GrayDark = {
        R = 33,
        G = 37,
        B = 41
    },
    Yellow = {
        R = 255,
        G = 255,
        B = 102,
    },
    Red = {
        R = 220,
        G = 20,
        B = 60
    },
    RedDark = {
        R = 139,
        G = 0,
        B = 0,
    }
}

DamageType = {
    PHYSICALDAMAGE   = 1,
    MAGICALDAMAGE    = 2,
    TRUEDAMAGE       = 3,
}

SpellSlot = {
    Passive          = -1,
    Q                = 0,
    W                = 1,
    E                = 2,
    R                = 3
}

UIKeys = {
    Combo            = "HK_COMBO",
    Harass           = "HK_HARASS",
    LastHit          = "HK_LASTHIT",
    LaneClear        = "HK_LANECLEAR",
}

SpellKey = {
    Q                = "HK_SPELL1",
    W                = "HK_SPELL2",
    E                = "HK_SPELL3",
    R                = "HK_SPELL4",
}

function HeroLvl() 
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end