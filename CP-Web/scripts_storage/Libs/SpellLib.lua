require("Enums")
require("BuffLib")

local function SpellLevel(spellSlot)
    if spellSlot == SpellSlot.Passive then
        return HeroLvl()
    end

    return myHero:GetSpellSlot(spellSlot).Level
end

SpellLib = {
    --Modified 19/08/22
    Aatrox = {
        Passive = {
            DmgModHP            = function() return 0.05 + 0.07 / 17 * (HeroLvl() - 1) end,
            DmgModHPBase        = function(self, Target) return Target.MaxHealth end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive
        },
        Q1 = {
            Delay               = function() return 0.6 end,
            Range               = function() return 625 end,
            Width               = function() return 180 end,
            Dmg                 = function() return ({10, 30, 50, 70, 90})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * ({0.60, 0.65, 0.70, 0.75, 0.80})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q
        },
        Q2 = {
            Delay               = function() return 0.6 end,
            Range               = function() return 475 end,
            Width               = function() return 500 end,
            Dmg                 = function() return ({12.5, 37.5, 62.5, 87.5, 112.5})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * ({0.75, 0.8125, 0.875, 0.9375, 1})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q
        },
        Q3 = {
            Delay               = function() return 0.6 end,
            Range               = function() return 200 end,
            Width               = function() return 180 end,
            Dmg                 = function() return ({15, 45, 75, 105, 135})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * ({0.90, 0.975, 1.05, 1.125, 1.20})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q
        },
        W = {
            Delay               = function() return 0.25 end,
            Speed               = function() return 1800 end,
            Range               = function() return 825 end,
            Width               = function() return 160 end,
            Dmg                 = function() return ({30, 40, 50, 60, 70})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W
        },
        E = {        
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Delay               = function() return 0.25 end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({0.2, 0.3, 0.4})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R
        }
    },
    --Modified 03/11/22
    Ahri = {
        Passive = {
            --Dmg                 = function(self, Target) return 35 + 60 / 17 * (HeroLvl() - 1) end,
           -- DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            SpellSlot           = SpellSlot.Passive,
        },
        Q1 = {
            Range               = function() return 900 end,
            Width               = function() return 200 end,
            Speed               = function() return 1550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q
        },
        Q2 = {
            Speed               = function() return 1900 end,
            Dmg                 = function() return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W1 = {
            Range               = function() return 725 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({50, 75, 100, 125, 150})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 725 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.48 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1000 end,
            Width               = function() return 120 end,
            Speed               = function() return 1550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        RStack = {
            Delay               = function() return 0 end,
            Range               = function() return 500 end,
            Width               = function() return 600 end,
            Dmg                 = function() return ({60, 90, 120})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        }
    },
    --Modified 18/08/22
    Akali = {
        Passive = {
            RangeMod        = function() return 2 end,
            Dmg             = function() return ({35, 38, 41, 44, 47, 50, 53, 62, 71, 80, 89, 98, 107, 122, 137, 152, 167, 182})[HeroLvl()] end,
            DmgModAD        = function(self, Target) return Target.BonusAttack * 0.6 end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.Passive
        },
        Q = {
            Range           = function() return 500 end,
            Delay           = function() return 0.25 end,
            Width           = function() return 350 end,
            Dmg             = function() return ({30, 55, 80, 105, 130})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function(self, Target) return Target.BaseAttack * 0.65 end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.Q
        },
        W = {
            Range           = function() return 250 end,
            Width           = function() return 1175 end,
            Delay           = function() return 0.25 end,
            SpellSlot       = SpellSlot.W
        },
        E1 = {
            Range           = function() return 825 end,
            Width           = function() return 120 end,
            Speed           = function() return 1800 end,
            Delay           = function() return 0.4 end,
            Dmg             = function() return ({30, 56.25, 82.5, 108.75, 135})[SpellLevel(SpellSlot.E)] end,
            DmgModAD        = function(self, Target) return Target.BaseAttack * 0.255 end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.36 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.E
        },
        E2 = {
            Range           = function() return math.huge end,
            Speed           = function() return 1500 end,
            Delay           = function() return 0.25 end,
            Dmg             = function() return ({70, 131, 192, 253, 315})[SpellLevel(SpellSlot.E)] end,
            DmgModAD        = function(self, Target) return Target.BaseAttack * 0.595 end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.84 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.E
        },
        R1 = {
            Range           = function() return 675 end,
            Speed           = function() return 1500 end,
            Delay           = function() return 0.25 end,
            Dmg             = function() return ({80, 220, 360 })[SpellLevel(SpellSlot.R)] end,
            DmgModAD        = function(self, Target) return Target.BonusAttack * 0.5 end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.R
        },
        R2 = {
            Range           = function() return 800 end,
            Speed           = function() return 3000 end,
            Delay           = function() return 0 end,
            Dmg             = function() return ({60, 130, 200})[SpellLevel(SpellSlot.R)] end,
            DmgModAP        = function(self, Target) return Target.AbilityPower * 0.3 end,
            DmgModHP        = function(self, Target)
                if Target ~= nil then
                    return 0
                end

                local missingHealthPercentage = 1 - (Target.Health / Target.MaxHealth)
                
                if missingHealthPercentage > 0.7 then
                    missingHealthPercentage = 0.7
                end
                
                return 0.286 * missingHealthPercentage
            end,
            DmgModHPBase    = function() return ({60, 130, 200})[SpellLevel(SpellSlot.R)] end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.R
        }
    },
    --updated 18/08/22
    Akshan = {
        Passive = {
            Speed           = function() return 2000 end,
            DmgModAD        = function() return 0.5 end,
            DmgModADBase    = function(self, Target) return Target.BaseAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.Passive,
        },
        PassiveStack = {
            Speed           = function() return 5000 end,
            Dmg             = function() return ({10, 15, 20, 25, 30, 35, 40, 45, 55, 65, 75, 85, 95, 105, 120, 135, 150, 165})[HeroLvl()] end,
            DmgModAPBase    = function(self, Target) return Target.AbilityPower end,
            DamageType      = DamageType.MAGICALDAMAGE,
            SpellSlot       = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1500 end,
            Dmg                 = function() return ({5, 25, 45, 65, 85})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function() return Target.BaseAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Speed               = function() return 2500 end,
            Dmg                 = function() return ({30, 45, 60, 75, 90})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.175 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 2500 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({100, 150, 210})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function() return ({0.5, 0.6, 0.7})[SpellLevel(SpellSlot.R)] end,
            DmgModADBase        = function() return Target.BaseAttack end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Alistar = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Speed               = function() return 375 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Speed               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({55, 110, 165, 220, 275})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Speed               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Amumu = {
        Passive = {
            DmgModAP            = function() return 0.1 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Width               = function() return 160 end,
            Speed               = function() return 2000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.85 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Speed               = function() return 2000 end,
            Width               = function() return 350 end,
            Dmg                 = function() return ({6, 8, 10, 12, 14})[SpellLevel(SpellSlot.W)] end,
            DmgModHP            = function() return ({0.05, 0.0575, 0.065, 0.0725, 0.08})[SpellLevel(SpellSlot.W)] end,
            DmgModHPBase        = function(self, Target) return Target.MaxHealth end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 350 end,
            Speed               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({75, 100, 125, 150, 175})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Anivia = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Speed               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Width               = function() return 220 end,
            Dmg                 = function() return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Width               = function() return ({600, 700, 800, 900, 1000})[SpellLevel(SpellSlot.W)] end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Speed               = function() return 1600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({100, 150, 200, 250, 300})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 750 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({30, 45, 60})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.125 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Annie = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 625 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({150, 275, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Ashe = {
        Passive = {
            FrostDmgMod         = function() return 1.1 end,
            FrostCritMod        = function() return 0.75 end,
            FrostIEMod          = function() return 0.35 end,
            DmgModADBase        = function(self, Target) return Target.BaseAttack + Target.BonusAttack end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Speed               = function() return math.huge end,
            Delay               = function() return 0 end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * ({0.21, 0.22, 0.23, 0.24, 0.25})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 2000 end,
            Width               = function() return 20 end,
            Dmg                 = function() return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * 1 end,
            Arrows              = function() return ({7, 8, 9, 10, 11})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1400 end,
            Width               = function() return 1000 end,
            SpellSlot           = SpellSlot.E,
        },
        -- hmm?
        R = {
            Range               = function() return 2000 end,
            Delay               = function() return 1 end,
            Width               = function() return 260 end,
            Dmg                 = function() return ({200, 400, 600})[SpellLevel(SpellSlot.R)] + (Target.AbilityPower * 1) end,
            DmgSecondary        = function() return ({100, 200, 300})[SpellLevel(SpellSlot.R)] + (Target.AbilityPower * 0.5) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    AurelionSol = {
        Passive = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({12, 14, 16, 18, 20, 23, 26, 32, 38, 44, 50, 60, 70, 80, 90, 100, 110, 120})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return ({5, 10, 15, 20, 25})[SpellLevel(SpellSlot.W)] + (Target.AbilityPower * 0.25) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({16.8, 19.6, 22.4, 25.2, 28, 32.2, 36.4, 44.8, 53.2, 61.6, 70, 84, 98, 112, 126, 140, 154, 168})[HeroLvl()] + (Target.AbilityPower * 0.35) end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return ({5500, 6000, 6500, 7000, 7500})[SpellLevel(SpellSlot.E)] end,
            Speed               = function() return ({600, 650, 700, 750, 800})[SpellLevel(SpellSlot.E)] end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1500 end,
            Width               = function() return 240 end,
            Delay               = function() return 0.35 end,
            Speed               = function() return 4500 end,
            Dmg                 = function() return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Azir = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 740 end,
            Width               = function() return 140 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({70, 90, 110, 130, 150})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 500 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 400 end,
            Delay               = function() return 0.5 end,
            Speed               = function() return 1000 end,
            Dmg                 = function() return ({175, 325, 475})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Bard = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1500 end,
            Dmg                 = function() return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 3400 end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.R,
        },
    },
        --Modified 03/11/22
        Belveth = {
            Passive = {
                SpellSlot           = SpellSlot.Passive,
            },
            Q = {
                Range               = function() return 400 end,
                Delay               = function() return 0 end,
                Dmg                 = function() return ({10, 15, 20, 25, 30})[SpellLevel(SpellSlot.Q)] end,
                DmgModAD            = function(self, Target) return Target.BonusAttack * 1.1 end,
                DamageType          = DamageType.PHYSICALDAMAGE,
                SpellSlot           = SpellSlot.Q,
            },
            W = {
                Range               = function() return 660 end,
                Delay               = function() return 0.5 end,
                Width               = function() return 200 end,
                Dmg                 = function() return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.W)] end,
                DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
                DmgModAP            = function(self, Target) return Target.AbilityPower * 1.25 end,
                DamageType          = DamageType.MAGICALDAMAGE,
                SpellSlot           = SpellSlot.W,
            },
            E = {
                Range               = function() return math.huge end,
                Delay               = function() return 0 end,
                Dmg                 = function() return ({8, 10, 12, 14, 16})[SpellLevel(SpellSlot.E)] end,
                DmgModAD            = function(self, Target) return Target.BonusAttack * 0.06 end,
                DamageType          = DamageType.PHYSICALDAMAGE,
                SpellSlot           = SpellSlot.E,
            },
            R = {
                Range               = function() return 350 end,
                Delay               = function() return 1 end,
                Dmg                 = function() return ({150, 200, 250})[SpellLevel(SpellSlot.R)] end,
                DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
                DamageType          = DamageType.TRUEDAMAGE,
                SpellSlot           = SpellSlot.R,
            },
        },
    --Modified 05/10/22
    Blitzcrank = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1020 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1800 end,
            Width               = function() return 140 end,
            Dmg                 = function() return ({105, 155, 205, 255, 305})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.BonusAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.25 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({275, 400, 525})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Brand = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        StackofABlaze1 = {
            Range               = function() return 475 end,
            SpellSlot           = SpellSlot.Passive,
        },
        StackofABlaze2 = {
            Range               = function() return 475 end,
            SpellSlot           = SpellSlot.Passive,
        },
        StackofABlaze3 = {
            Range               = function() return 475 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({9, 9.25, 9.5, 9.75, 10, 10.25, 10.5, 10.75, 11, 11.25, 11.5, 11.75, 12, 12.25, 12.5, 12.75, 13, 13})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.02 * (Target.AbilityPower % 100)) end,         
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1040 end,
            Delay               = function() return 0.25 end,
            Width               = function() return 120 end,
            Speed               = function() return 1600 end,
            Dmg                 = function() return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        WABlaze = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({93.75, 150, 206.25, 262.5, 318.75})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 675 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 750 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 750 end,
            Dmg                 = function() return ({100, 200, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- Modified 19/08/22
    Braum = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack1 = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack2 = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack3 = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack4 = {
            Dmg                 = function(self, Target) return 16 + 10 * HeroLvl() end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1050 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1700 end,
            Width               = function() return 120 end,    
            Dmg                 = function() return ({75, 125, 175, 225, 275})[SpellLevel(SpellSlot.Q)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 2.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.5 end,
            Speed               = function() return 1400 end,
            Width               = function() return 230 end,  
            Dmg                 = function() return ({150, 300, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Caitlyn = {
        Passive = {
            DmgModAD        = function() 
                if (HeroLvl() == 18) then
                    return 1.00
                else
                    return 0.50 + 0.25 * math.floor(HeroLvl()/6)
                end
            end,
            Range           = function() return 1300 end,
            DmgModADBase      = function(self, Target) return Target.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.Passive,
            CritMod         = function(self, Target) return 0.09375 + Target.CritMod end,
        },
        Q1 = {
            Dmg             = function() return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function() return ({1.25, 1.45, 1.65, 1.85, 2.05})[SpellLevel(SpellSlot.Q)] end,
            DmgModADBase    = function(self, Target) return Target.BaseAttack + Target.BonusAttack end,
            SpellSlot       = SpellSlot.Q,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1300 end,
            Speed           = function() return 1800 end, -- official 2200 but 1800 better results
            Delay           = function() return 0.625 end,
            Width           = function() return 120 end,
        },
        Q2 = {
            Dmg             = function() return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.Q)] * 0.60 end,
            DmgModAD        = function() return ({1.25, 1.45, 1.65, 1.85, 2.05})[SpellLevel(SpellSlot.Q)] * 0.60 end,
            DmgModADBase    = function(self, Target) return Target.BaseAttack + Target.BonusAttack end,
            SpellSlot       = SpellSlot.Q,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1300 end,
            Speed           = function() return 1800 end, -- official 2200 but 1800 better results
            Delay           = function() return 0.625 end,
            Width           = function() return 180 end,
        },
        W = {
            Range           = function() return 800 end,
            Delay           = function() return 1.05 end, -- original is 0.25 but is too fast
            Speed           = function() return math.huge end,
            Width           = function() return 67.5 end,
            SpellSlot       = SpellSlot.W,
            LifeTime        = function() return ({30, 35, 40, 45, 50})[SpellLevel(SpellSlot.W)] end,
        },
        WPassive = {
            Dmg             = function() return ({40, 85, 130, 175, 220})[SpellLevel(SpellSlot.W)] end, 
            DmgModAD        = function() return ({0.40, 0.50, 0.60, 0.70, 0.80})[SpellLevel(SpellSlot.W)] end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1300 end,
            DmgModBase      = function(self, Target) return Target.BonusAttack end,
            SpellSlot       = SpellSlot.W
        },
        E = {
            Dmg             = function() return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.E)] end,
            DmgModAP        = function() return 0.8 end,
            DmgModAPBase    = function(self, Target) return Target.AbilityPower end,
            DamageType      = DamageType.MAGICALDAMAGE,
            Range           = function() return 750 end,
            Delay           = function() return 0.15 end,
            SpellSlot       = SpellSlot.E,
            BounceRange     = function() return 375 end,
            Width           = function() return 115 end,
            Speed           = function() return 1600 end,
        },
        R = {
            Range           = function() return 3500 end,
            Speed           = function() return 3200 end,
            Delay           = function() return 0.375 end,
            Width           = function() return 80 end,
            Dmg             = function() return ({300, 525, 750})[SpellLevel(SpellSlot.R)] end,
            DmgModAD        = function() return 2 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.R
        }
    },
    -- Modified 08/09/22
    Camille = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({75, 125, 175, 225, 275})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return ({20, 25, 30, 35, 40})[SpellLevel(SpellSlot.Q)] + Target.BonusAttack * 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({70, 100, 130, 160, 190})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Width               = function() return 100 end,
            Dmg                 = function() return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.9 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 475 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({5, 10, 15})[SpellLevel(SpellSlot.R)] end,
            DmgModHP            = function(self, Target) return Target.Health / 100 * ({4, 6, 8})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R
        },
    },
    -- Modified 19/08/22 DmgBonus, DmgBonusModAP
    Cassiopeia = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({75, 110, 145, 180, 215})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({100, 125, 150, 175, 200})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 700 end,
            Delay               = function() return 0.125 end,
            Speed               = function() return 2500 end,
            Dmg                 = function(self, Target) return 48 + 4 * HeroLvl() end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.1 end,
            DmgBonus            = function() return ({20, 40, 60, 80, 100})[SpellLevel(SpellSlot.E)] end,
            DmgBonusModAP       = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 850 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- Modified 19/08/22
    Chogath = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 950 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({75, 125, 175, 225, 275})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 500 end,
            Delay               = function() return 0 end,
            Width               = function() return 340 end,
            Dmg                 = function() return ({22, 34, 46, 58, 70})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 175 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({300, 475, 650})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 10 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Corki = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 825 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1000 end,
            Dmg                 = function() return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.7 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({15, 22.5, 30, 37.5, 45})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 690 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({7.5, 10.625, 13.75, 16.875, 20})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R1 = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.175 end,
            Speed               = function() return 2000 end,
            Width               = function() return 80 end,
            Dmg                 = function() return ({80, 115, 150})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.15, 0.45, 0.75})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.12 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.175 end,
            Speed               = function() return 2000 end,
            Width               = function() return 80 end,
            Dmg                 = function() return ({80, 115, 150})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.15, 0.45, 0.75})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.12 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R3 = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.175 end,
            Speed               = function() return 2000 end,
            Width               = function() return 80 end,
            Dmg                 = function() return ({160, 230, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.30, 0.90, 0.150})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.24 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Darius = {
        Passive = {
            Dmg                 = function() return ({65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150})[HeroLvl()] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 460 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({50, 80, 110, 140, 170})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({1, 1.1, 1.2, 1.3, 1.4})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function() return (Target.BaseAttack + Target.BonusAttack) * ({1.4, 1.45, 1.5, 1.55, 1.6})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 535 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 475 end,
            Delay               = function() return 0.3667 end,
            Dmg                 = function() return ({125, 250, 375})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.75 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 18/08/22
    Diana = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack2 = {
            Dmg                 = function() return ({20, 25, 30, 35, 40, 45, 65, 75, 85, 95, 95, 135, 150, 165, 180, 210, 210, 220})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1900 end,
            Dmg                 = function() return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 200 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({54, 90, 126, 162, 198})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 825 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({50, 70, 90, 110, 130})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22 but need more update
    DrMundo = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 990 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.Q)] end,
            DmgModHP            = function(self, Target) return Target.Health / 100 * ({20, 22.5, 25, 27.5, 30})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 325 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({80, 140, 200, 260, 320})[SpellLevel(SpellSlot.W)] end,
            DmgModHP            = function(self, Target) return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        -- update
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({40, 60, 80, 100, 120})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Draven = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({40, 45, 50, 55, 60})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({0.75, 0.85, 0.95, 1.05, 1.15})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({75, 110, 145, 180, 215})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({175, 275, 375})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({1.1, 1.3, 1.5})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Ekko = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack1 = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack2 = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveStack3 = {
            Dmg                 = function() return ({30, 40, 50, 60, 70, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({100, 140, 180, 220, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1600 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({50, 75, 100, 125, 150})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 375 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({200, 350, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 1.75 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 19/10/22
    Elise = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveSpiderForm = {
            Dmg                 = function() return ({10, 20, 30, 40})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q1 = {
            Range               = function() return 575 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({40, 75, 110, 145, 180})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.03 * (Target.AbilityPower % 100)) end,
            DmgModHP            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * 4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.03 * (Target.AbilityPower % 100)) end,
            DmgModHP            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * 8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 950 end,
            Delay               = function() return 0.125 end,
            Dmg                 = function() return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.95 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1600 end,
            Width               = function() return 110 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Evelynn = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.3 end,
            Speed               = function() return 2400 end,
            DmgDart             = function() return ({25, 30, 35, 40, 45})[SpellLevel(SpellSlot.Q)] end,
            DmgDartModAP        = function(self, Target) return Target.AbilityPower * 0.3 end,
            Dmg                 = function() return ({75, 90, 105, 120, 135})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return ({1200, 1300, 1400, 1500, 1600})[SpellLevel(SpellSlot.W)] end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E1 = {
            Range               = function() return 210 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({55, 70, 85, 100, 115})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.015 % Target.AbilityPower) end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 210 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({75, 100, 125, 150, 175})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.025 % Target.AbilityPower) end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function() return ({125, 250, 375})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Ezreal = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 2000 end,
            Width               = function() return 120 end,
            Dmg                 = function() return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.3 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1700 end,
            Width               = function() return 160 end,
            Dmg                 = function() return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.6 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * ({0.7, 0.75, 0.8, 0.85, 0.9})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 2000 end,
            Dmg                 = function() return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 1 end,
            Speed               = function() return 2000 end,
            Width               = function() return 320 end,
            Dmg                 = function() return ({350, 500, 650})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 19/08/2022
    FiddleSticks = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 575 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function() return Target.Health / 100 * ({6, 7, 8, 9, 10})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * (0.02 * (Target.AbilityPower % 100)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({120, 180, 240, 300, 360})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DmgModHP            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * ({12, 14.5, 17, 19.5, 22})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 850 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function() return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({750, 1250, 1750})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 2.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/08/22
    Fiora = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        PassiveVitals = {
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 3 end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * (0.045 * (Target.BonusAttack % 100)) end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 360 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({70, 80, 90, 100, 110})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * ({0.95, 1, 1.05, 1.1, 1,15})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0 end,
            Speed               = function() return 3200 end,
            Width               = function() return 140 end,
            Dmg                 = function() return ({110, 150, 190, 230, 270})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Updated 05/10/22
    Fizz = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.AbilityPower + (({10, 25, 40, 55, 70})[SpellLevel(SpellSlot.Q)] + (Target.AbilityPower * 0.55)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.AbilityPower + (({50, 70, 90, 110, 130})[SpellLevel(SpellSlot.W)] + (Target.AbilityPower * 0.5)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 330 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({300, 400, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 16/08/22
    Galio = {
        Passive = {
            Dmg                 = function(self, Target) return 15 + 185 / 17 * (HeroLvl() - 1) end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 825 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function() return ({90, 130, 170, 210, 250})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({4000, 4750, 5500})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Gangplank = {
        Passive = {
            DamageType          = DamageType.TRUEDAMAGE,
            DmgModAD            = function() return 0.1 end,
            DmgModADBase        = function(self, Target) return Target.BonusAttack end,
            Dmg                 = function() return (4.5 + HeroLvl()) * (2.5/0.25) end,
        },
        Q = {
            DamageType          = DamageType.PHYSICALDAMAGE,
            Range               = function() return 625 end,
            Speed               = function() return 2600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({10, 40, 70, 100, 130})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function() return 1 end,
            DmgModADBase        = function(self, Target) return Target.BaseAttack + Target.BonusAttack end,
        },
        E = {
            Range               = function() return 1000 end,
            Width               = function() return 325 end,
            Delay               = function() return 0.5 end, -- original 0.25
            Speed               = function() return math.huge end,
            Dmg                 = function() return ({75, 105, 135, 165, 195})[SpellLevel(SpellSlot.E)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            ArmorPenMod         = function() return 0.4 end,
        },
        Barrel = {
            DecayTime           = function() 
                if HeroLvl() < 7 then
                    return 2
                elseif HeroLvl() >= 7 and HeroLvl() < 13 then
                    return 1
                else
                    return 0.5
                end
            end,
            Width               = function() return 325 end,
            ExplosionDelay      = function() return 0.3 end,
        },
        R = {
            Dmg                 = function() return ({40, 70, 100})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 0.1 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Width               = function() return 600 end,
            AmountOfWaves       = function() return 12 end, -- add check if FireAtWill is possible
            Speed               = function() return math.huge end,
        },
        RCluster = {
            Dmg                 = function() return ({120, 210, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 0.3 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            Range               = function() return math.huge end,
            Width               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return math.huge end,
        },
        RDeathsDaughter = {
            Dmg                 = function() return ({120, 210, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 0.3 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.TRUEDAMAGE,
            Range               = function() return math.huge end,
            Width               = function() return 200 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return math.huge end,
        }
    },  
    Garen = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 60, 90, 120, 150})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 325 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({4, 8, 12, 16, 20})[SpellLevel(SpellSlot.E)] * 7 end, -- 7 max spins by default
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.32, 0.34, 0.36, 0.38, 0.4})[SpellLevel(SpellSlot.E)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 400 end,
            Delay               = function() return 0.435 end,
            Dmg                 = function() return ({150, 300, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * ({25, 30, 35})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Gnar = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1125 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({5, 45, 85, 125, 165})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 1150 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({25, 70, 115, 160, 205})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return 400 end,
            Delay               = function() return 0.1 end,
            Dmg                 = function(self, Target) return ({0, 10, 20, 30, 40})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 550 end,
            Delay               = function() return 0.6 end,
            Dmg                 = function(self, Target) return ({25, 55, 85, 115, 145})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 475 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({50, 85, 120, 155, 190})[SpellLevel(SpellSlot.E)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 675 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.5 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Gragas = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 250 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 50, 80, 110, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.MaxHealth / 100 * 7 + Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.AbilityPower) * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- Modified 08/09/22
    Graves = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({130, 180, 230, 280, 330})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({1.2, 1.5, 1.8, 2.1, 2.4})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 110, 160, 210, 260})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 325 end,
            Delay               = function() return 0.4 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({275, 425, 575})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Gwen = {
        Passive = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return math.huge end,
            Width                   = function() return 0 end,
            Speed                   = function() return math.huge end,
            Delay                   = function() return 0 end,
            DmgModHP                = function(self, Target) return 0.01 + (math.floor(Target.AbilityPower / 100) * 0.008) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
        },
        Q = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 450 end,
            Width                   = function() return 140 end,
            Speed                   = function() return math.huge end,
            Delay                   = function() return 0.25 end,
            Dmg                     = function() return ({90,120,150,180,210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP                = function() return 0.5 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
        },
        E = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return math.huge end,
            Width                   = function() return 0 end,
            Speed                   = function() return math.huge end,
            Delay                   = function() return 0 end,
            Dmg                     = function() return 10 * math.min(1, GameHud.AttackSpeed)  end,
            DmgModAP                = function() return 0.15 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
        },
        R1 = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 1350 end,
            Width                   = function() return 240 end,
            Speed                   = function() return 1800 end,
            Delay                   = function() return 0.25 end,
            Dmg                     = function() return ({30,65,95})[SpellLevel(SpellSlot.R)] end,
            DmgModAP                = function() return 0.1 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
            DmgModHP                = function(self, Target) return 0.01 + (math.floor(Target.AbilityPower / 100) * 0.008) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
        },        
        R2 = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 1350 end,
            Width                   = function() return 240 end,
            Speed                   = function() return 1800 end,
            Delay                   = function() return 0.50 end,
            Dmg                     = function() return ({105,195,285})[SpellLevel(SpellSlot.R)] end,
            DmgModAP                = function() return 0.3 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
            DmgModHP                = function(self, Target) return 0.03 + (math.floor(Target.AbilityPower / 100) * 0.024) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
        },        
        R3 = {
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 1350 end,
            Width                   = function() return 240 end,
            Speed                   = function() return 1800 end,
            Delay                   = function() return 0.50 end,
            Dmg                     = function() return ({175,325,475})[SpellLevel(SpellSlot.R)] end,
            DmgModAP                = function() return 0.5 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
            DmgModHP                = function(self, Target) return 0.05 + (math.floor(Target.AbilityPower / 100) * 0.040) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
        },
    },
    --Modified 08/09/22
    Hecarim = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 375 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.9 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 525 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000  end,
            Delay               = function() return 0 end,
            Dmg                 = function() return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Heimerdinger = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        -- update
        Q = {
            Range               = function() return 350 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1325 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 135, 180, 225, 270})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.93 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 1325 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({503, 697.5, 892})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.83 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        E = {
            Range               = function() return 970 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 200, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Illaoi = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        -- update
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.75 end,
            -- Dmg                 = function(self, Target) return ({10, 60, 110, 160, 210})[SpellLevel(SpellSlot.W)] end,
            -- DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.6 end,
            -- DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 30, 40, 50, 60})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return Target.Health / 100 * ({25, 30, 35, 40, 45})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return 8 * ((Target.BaseAttack + Target.BonusAttack) % 100) end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function() return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 16/08/22
    Irelia = {
        Passive = {
            Dmg                 = function(self, Target) return 7 + 3 * HeroLvl() end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.2 end,
            DmgModADBase        = function(self, Target) return Target.BaseAttack end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        -- update
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({5, 25, 45, 65, 85})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 775 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({30, 75, 120, 165, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.2 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 775 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function() return ({125, 250, 375})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Ivern = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        -- update
        Q = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            DmgModAP            = function(self, Target) return ({30, 37.5, 45, 52.5, 60})[SpellLevel(SpellSlot.W)] + (Target.AbilityPower * 0.3) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 750 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 90, 110, 130, 150})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Janna = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        -- update
        Q = {
            Range               = function() return 1760 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({105, 145, 185, 225, 265})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        -- update
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0.245 end,
            DmgModAP            = function(self, Target) return ({70, 100, 130, 160, 190})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    JarvanIV = {
        Passive = {
            Dmg                 = function(self, Target) return Target.Health / 100 * 8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 785 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({90, 130, 170, 210, 250})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 860 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({200, 325, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Jax = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({65, 105, 145, 185, 225})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 85, 120, 155, 190})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 300 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({110, 160, 210, 260, 310})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 140, 180})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Jayce = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({55, 100, 145, 190, 235, 280})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 1050 end,
            Delay               = function() return 0.2143 end,
            Dmg                 = function(self, Target) return ({55, 110, 165, 220, 275, 330})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 160, 220, 280, 340, 400})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 160, 220, 280, 340, 400})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 240 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({8, 10.8, 13.6, 16.4, 19.2, 22})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({8, 10.8, 13.6, 16.4, 19.2, 22})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Jhin = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({45, 70, 95, 120, 145})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.35, 0.425, 0.5, 0.575, 0.65})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 2520 end,
            Delay               = function() return 0.75 end,
            Dmg                 = function(self, Target) return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 750 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 80, 140, 200, 260})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.2 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 3500 end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({200, 500, 800})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Jinx = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 250 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1440 end,
            Delay               = function() return 0.6 - 0.02 * ((Target.AttackSpeed - 0.625) % 25) end,
            Dmg                 = function(self, Target) return ({10, 60, 110, 160, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 925 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.6 end,
            Dmg                 = function() return ({300, 450, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.5 + ((Target.MaxHealth - Target.Health) / 100 * ({25, 30, 35})[SpellLevel(SpellSlot.R)]) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Kaisa = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({40, 55, 70, 85, 100})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.5 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 3000 end,
            Delay               = function() return 0.8 end,
            Dmg                 = function(self, Target) return ({30, 55, 80, 105, 130})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.3 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 925 end,
            Delay               = function() return 0.4 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({1500, 2250, 3000})[SpellLevel(SpellSlot.W)] end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Kalista = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 85, 150, 215, 280})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 5000 end,
            Delay               = function() return 0.5 end,
            DmgModAP            = function(self, Target) return Target.MaxHealth / 100 * ({14, 15, 16, 17, 18})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        -- update
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 30, 40, 50, 60})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1200 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Karma = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 890 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return ({75, 240, 405, 570})[SpellLevel(SpellSlot.R)] + Target.AbilityPower * 1.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 675 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Karthus = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 875 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 125, 160, 195, 230})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 50, 70, 90, 110})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({200, 350, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22 R need to be adjusted still
    Kassadin = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({65, 95, 125, 155, 185})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 75, 100, 125, 150})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 105, 130, 155, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.85 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 100, 120})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DmgModMP            = function(self, Target) return Target.MaxMana / 100 * 2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 17/08/22 still need adjustment in passive
    Katarina = {
        Passive = {
            Dmg                 = function(self, Target) return ({68, 72, 77, 82, 89, 96, 103, 112, 121, 131, 142, 154, 166, 180, 194, 208, 224, 240})[HeroLvl()] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.6 end,
            --DmgModAP            = function(self, Target) return Target.AbilityPower * ({0.65, 0.65, 0.65, 0.65, 0.65, 0.75, 0.75, 0.75, 0.75, 0.75, 0.85, 0.85, 0.85, 0.85, 0.85, 0.95}) end,
            --DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 625 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 725 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.4 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        -- update
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({375, 562.5, 750})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 2.7 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 2.85 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Kayle = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
            Dmg                 = function(self, Target) return ({15, 20, 25, 30, 35})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.6 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({15, 20, 25, 30, 35})[SpellLevel(SpellSlot.E)] + ((Target.MaxHealth - Target.Health) / 100 * (({8, 9, 10, 11, 12})[SpellLevel(SpellSlot.E)] * 0.02 + (Target.AbilityPower % 100))) end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        -- update
        R = {
            Range               = function() return 900 end,
            Delay               = function() return 1.5 end,
            Dmg                 = function(self, Target) return ({200, 350, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Kayn = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 0.08 + 0.22 / 17 * (HeroLvl() - 1) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 190, 230, 270, 310})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 700 end,
            Delay               = function() return 0.55 end,
            Dmg                 = function(self, Target) return ({90, 135, 180, 225, 270})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 900 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({90, 135, 180, 225, 270})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.75 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Range               = function() return 750 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.75 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Kennen = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1050 end,
            Delay               = function() return 0.175 end,
            Dmg                 = function(self, Target) return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 750 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({300, 562.5, 825})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.6875 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 17/08/22
    KhaZix = {
        Passive = {
            Dmg                 = function(self, Target) return 8 + 6 * HeroLvl() end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.4 end,
            DmgModADBase        = function(self, Target) return Target.BaseAttack end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 325 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1025 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({85, 115, 145, 175, 205})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({65, 100, 135, 170, 205})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Kindred = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Dmg             = function() return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function() return 0.75 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 340 end,
            Width           = function(self, Target) return Target.AttackRange + Target.CharData.BoundingRadius end,
            Speed           = function() return 500 end,
            Delay           = function() return 0 end,
        },
        W = {
            Range           = function() return 500 end,
            Width           = function() return 800 end,
            Speed           = function() return 1400 end,
            Delay           = function() return 0 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            Dmg             = function() return ({25, 30, 35, 40, 45})[SpellLevel(SpellSlot.W)] end,
            DmgModAD        = function() return 0.2 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
            DmgModHP        = function(self, Target) return 0.015 + BuffLib.Kindred:MarkCounter(myHero) * 0.01 end, -- check if need to change myHero here
            DmgModHPBase    = function(self, Target) return Target.Health end,
        },
        E = {
            Range           = function() 
                local counter = BuffLib.Kindred:MarkCounter(myHero) -- check if need to change myHero here

                if counter < 4 then
                    return 500
                elseif counter < 7 and counter >= 4 then
                    return 575
                elseif counter < 10 and counter >= 7  then
                    return 600
                elseif counter < 13 and counter >= 10 then
                    return 625
                elseif counter < 16 and counter >= 13 then
                    return 650
                elseif counter < 19 and counter >= 16 then
                    return 675
                elseif counter < 22 and counter >= 19 then
                    return 700
                elseif counter < 25 and counter >= 22 then
                    return 725
                else
                    return 750
                end
            end,
            Delay           = function() return 0.25 end,
            Dmg             = function() return ({80, 100, 120, 140, 160})[SpellLevel(SpellSlot.E)] end,
            DmgModAD        = function() return 0.8 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
            DmgModHP        = function() return 0.08 + 0.005 * BuffLib.Kindred:MarkCounter(myHero) end, -- check if need to change myHero here
            DmgModHPBase    = function(self, Target) return Target.MaxHealth - Target.Health end,
            DamageType      = DamageType.PHYSICALDAMAGE,
        },
        EWolf = {
            DamageType      = DamageType.PHYSICALDAMAGE,
            DmgModAD        = function() return 0.5 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
        },
        EWolfInfinityEdge = {
            DamageType      = DamageType.PHYSICALDAMAGE,
            DmgModAD        = function() return 0.525 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
        }
    }, 
    --Modified 12/08/22
    Kled = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 165, 240, 315, 390})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.95 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        -- update
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 1.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({3500, 4000, 4500})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({12, 15, 18})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (12 * (Target.BonusAttack % 100)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    KogMaw = {
        Passive = {
            Dmg                     = function() return 100 + 25 * HeroLvl() end,
            DamageType              = DamageType.TRUEDAMAGE,
            Width                   = function() return 400 end,
        },
        Q = {
            Dmg                     = function() return ({90, 140, 190, 240, 290})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP                = function() return 0.7 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
            DmgModResistanceMod     = function() return ({0.23, 0.25, 0.27, 0.29, 0.31})[SpellLevel(SpellSlot.Q)] end,
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 1200 end,
            Width                   = function() return 140 end,
            Speed                   = function() return 1800 end,
            Delay                   = function() return 0.25 end,
        },
        W = {
            Delay                   = function() return 0 end,
            DmgModHP                = function(self, Target) return ({0.035, 0.0425, 0.05, 0.0575, 0.065})[SpellLevel(SpellSlot.W)] + math.floor(Target.AbilityPower/100) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function(self, Target) return ({130, 150, 170, 190, 210})[SpellLevel(SpellSlot.W)] + myHero.AttackRange + myHero.CharData.BoundingRadius end,
        },
        E = {
            Dmg                     = function() return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.E)] end,
            DmgModAP                = function() return 0.5 end,
            DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
            Range                   = function() return 1360 end,
            Width                   = function() return 240 end,
            Speed                   = function() return 1600 end,
            Delay                   = function() return 0.25 end,
            DamageType              = DamageType.MAGICALDAMAGE
        },
        R = {
            Range                   = function() return ({1300, 1550, 1800})[SpellLevel(SpellSlot.R)] end,
            Width                   = function() return 240 end,
            Delay                   = function() return 0.9 end,
            Speed                   = function() return math.huge end,
            ManaCost                = function(self, stacks) 
                if stacks > 10 then
                    stacks = 10
                end
                return stacks * 40
            end,
            Dmg                     = function() return ({100, 140, 180})[SpellLevel(SpellSlot.R)] end,
            DmgModAD                = function() return 0.65 end,
            DmgModADBase            = function(self, Target) if Target ~= nil then return Target.BonusAttack else return 0 end end,
            DmgModAP                = function() return 0.35 end,
            DmgModAPBase            = function(self, Target) if Target ~= nil then return Target.AbilityPower else return 0 end end,
            DmgModHP                = function(self, Target) 
                local missingHealth = 1 - (Target.Health/Target.MaxHealth)

                if missingHealth <= 0.6 then
                    return (0.00833 * (missingHealth*100))
                else
                    return 1
                end
            end,
            DmgModHPBase            = function(self) 
                return self:Dmg() + self:DmgModAD() * self:DmgModADBase() + self:DmgModAP() * self:DmgModAPBase()
            end,
            SpellSlot               = SpellSlot.R,
            DamageType              = DamageType.MAGICALDAMAGE
        }
    },
    LeBlanc = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({130, 180, 230, 280, 330})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({75, 115, 155, 195, 235})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({130, 190, 250, 310, 370})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R1 = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({210, 420, 630})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 300, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R3 = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({210, 420, 630})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    LeeSin = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({110, 160, 210, 260, 310})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 130, 160, 190, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 375 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({175, 400, 625})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Leona = {
        Passive = {
            Dmg                 = function() return 24 + 8 * HeroLvl() end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 35, 60, 85, 110})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({45, 80, 115, 150, 185})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 175, 250})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Lillia = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 485 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 100, 130, 160, 190})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 500 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({240, 300, 360, 420, 480})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.05 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({100, 150, 200})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Lissandra = {
        --update
        Passive = {
            --Dmg                 = function(self, Target) return ({120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 370, 400, 430, 460, 490, 520})[SpellLevel(SpellSlot.Passive)] end,
            --DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            --DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            --DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 725 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1025 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0.375 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Lucian = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 500 end,
            Delay               = function() return 0.4 - 0.15 / 17 * (HeroLvl() - 1) end,
            Dmg                 = function(self, Target) return ({95, 125, 155, 185, 215})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({0.6, 0.75, 0.9, 1.05, 1.2})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 110, 145, 180, 215})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 425 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1140 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({15, 30, 45})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.25 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Lulu = {
        -- update
        Passive = {
            Dmg                 = function(self, Target) return 9 + 6 * HeroLvl() end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.15 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0.2419 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 900 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 17/08/22
    Lux = {
        Passive = {
            Dmg                 = function(self, Target) return 10 + 10 * HeroLvl() end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1240 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1175 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 3400 end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({300, 400, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/2022
    Malphite = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 625 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 45, 60, 75, 90})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            Dmg2                = function(self, Target) return ({15, 25, 35, 45, 55})[SpellLevel(SpellSlot.W)] end,
            DmgModAP2            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 400 end,
            Delay               = function() return 0.2419 end,
            Dmg                 = function(self, Target) return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Malzahar = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return 150 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.0005 end,
            Dmg                 = function(self, Target) return ({125, 200, 275})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * (({10, 15, 20})[SpellLevel(SpellSlot.R)] + (2.5 * (Target.AbilityPower % 100))) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- Modified 08/09/22
    Maokai = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0.3889 end,
            Dmg                 = function(self, Target) return ({65, 110, 150, 200, 245})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * ({2, 2.25, 2.5, 2.75, 3})[SpellLevel(SpellSlot.Q)]  end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 525 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 80, 105, 130, 155})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 3000 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({150, 225, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.75 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 05/10/22
    MasterYi = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({52.5, 105, 157.5, 210, 262.5})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.875 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 35, 40, 45, 50})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.3 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- Modified 03/11/22
    MissFortune = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.35 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 100, 130, 160, 190})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({10.50, 12.00, 13.50})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * ({2.8, 3.2, 3.6})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Mordekaiser = {
        --need passive update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 625 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 51, 61, 71, 81, 91, 107, 123, 139})[HeroLvl()] + ({75, 95, 115, 135, 155})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 95, 110, 125, 140})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Morgana = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({162, 297, 432, 567, 702})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.89 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 625 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({300, 450, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Nami = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 875 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 130, 185, 240, 295})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 725 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 2750 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Nasus = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        -- need q update DMGModAP?
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 50, 70, 90, 110})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 95, 135, 175, 215})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 400 end,
            Delay               = function() return 0.2 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({45, 60, 75})[SpellLevel(SpellSlot.R)] + (15 * (Target.AbilityPower % 100)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Nautilus = {
        -- updated 17/08/22
        Passive = {
            Dmg                 = function(self, Target) return 2 + 6 * HeroLvl() end,
            DmgModADBase        = function(self, Target) return Target.BaseAttack end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1122 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 250 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 40, 50, 60, 70})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 590 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({110, 170, 230, 290, 350})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 825 end,
            Delay               = function() return 0.46 end,
            Dmg                 = function(self, Target) return ({150, 275, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Neeko = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({160, 255, 350, 445, 540})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 80, 110, 140, 170})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.6 end,
            Dmg                 = function(self, Target) return ({200, 425, 650})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Nidalee = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1500 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({210, 270, 330, 390, 450})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({40, 80, 120, 160, 200})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22 (need some more update)
    Nilah = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Width               = function() return 150 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({10, 20, 30, 40, 50})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function() return ({180, 200, 220, 240, 260})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {        
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 450 end,
            Speed               = function() return 2200 end,
            Dmg                 = function(self, Target) return ({65, 90, 115, 140, 165})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R1 = {
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 120, 180})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({185, 345, 505})[SpellLevel(SpellSlot.R)] end,
            DmgModAD           = function(self, Target) return Target.BonusAttack * 2.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },

    },
    --Modified 17/08/22
    Nocturne = {
        Passive = {
            DmgModAD            = function(self, Target) return Target.BaseAttack * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({65, 110, 155, 200, 245})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.85 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 425 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({2500, 3250, 4000})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 275, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 05/10/22
    Nunu = {
        Passive = {
            DmgModAD            = function(self, Target) return Target.BaseAttack * 0.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 125 end,
            Delay               = function() return 0.3 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return 1750 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({180, 225, 270, 315, 360})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 690 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({144, 216, 288, 360, 432})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({625, 950, 1275})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Olaf = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 120, 170, 220, 270})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 325 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Orianna = {
        Passive = {
            Dmg                 = function() return 10 + 8 * (1 + (math.floor(HeroLvl()-1 / 3))) end,
            DmgModAP            = function() return 0.15 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
        },
        PassiveStack = {
            Dmg                 = function() return (14 + 11.2 * (1 + (math.floor(HeroLvl()-1 / 3)))) end,
            DmgModAP            = function() return 0.21 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
        },
        Q = {
            Range               = function() return 825 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 225 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1120 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 415 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({200, 275, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Ornn = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 750 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 500 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({12, 13, 14, 15, 16})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.E)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 2550 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({250, 350, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Pantheon = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({155, 230, 305, 380, 455})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 2.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({55, 105, 155, 205, 255})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 5500 end,
            Delay               = function() return 0.1 end,
            Dmg                 = function(self, Target) return ({300, 500, 700})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Poppy = {
        Passive = {
            Dmg                 = function(self, Target) return 20 + 160 / 17 * (HeroLvl() - 1) end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 460 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1.8 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 16 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 475 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({120, 160, 200, 240, 280})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.9 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Pyke = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 150, 200, 250, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({105, 135, 165, 195, 225})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 750 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({0, 0, 0, 0, 0, 250, 290, 330, 370, 400, 430, 450, 470, 490, 510, 530, 540, 550})[HeroLvl()] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Qiyana = {
        Passive = {
            Dmg                 = function(self, Target) return 11 + 4 * HeroLvl() end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.3 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.3 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 525 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 80, 110, 140, 170})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.75 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 865 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({8, 22, 36, 50, 64})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.1 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 875 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 200, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.7 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 10 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/2022
    Quinn = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 5 + 5 * HeroLvl() end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.14 + (0.02 * HeroLvl()) end,
            DmgModADBase        = function(self, Target) return Target.BonusAttack end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 1050 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.8, 0.9, 1, 1.1, 1.2})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 2100 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({40, 70, 100, 130, 160})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Rakan = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 125, 180, 235, 290})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 200, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Rammus = {
        --update
        Passive = {
            Dmg                 = function() return 15 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 130, 160, 190, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 325 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({210, 352.5, 495})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Reksai = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 325 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({63, 81, 99, 117, 135})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 1650 end,
            Delay               = function() return 0.1 end,
            Dmg                 = function(self, Target) return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W2 = {
            Range               = function() return 160 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({55, 70, 85, 100, 115})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 225 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 60, 70, 80, 90})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.85 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 850 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 120, 140, 160, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1500 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 250, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.75 end,
            DmgModHP            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * ({20, 25, 30})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 17/08/22
    Rell = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 8 + 8 * (HeroLvl() - 1) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 685 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 500 end,
            Delay               = function() return 0.625 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1500 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({120, 200, 280})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 08/09/22
    Renekton = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({100, 150, 200, 250, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 40, 70, 100, 130})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({15, 60, 105, 150, 195})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 2.25 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({40, 70, 100, 130, 160})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.9 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 140, 200, 260, 320})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 375 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({750, 1500, 2250})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.5 end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Rengar = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 60, 90, 120, 150})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0, 0.05, 0.1, 0.15, 0.2})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 45, 60, 75, 90, 105, 120, 135, 145, 155, 165, 175, 185, 195, 205, 215, 225, 235})[HeroLvl()] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 80, 110, 140, 170})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 100, 145, 190, 235})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 65, 80, 95, 110, 125, 140, 155, 170, 185, 200, 215, 230, 245, 260, 275, 290, 305})[HeroLvl()] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({2500, 3000, 3500})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Riven = {
        --update
        Passive = {
            DmgModAD            = function(self, Target) return Target.BonusAttack * ({0.3, 0.3, 0.3, 0.3, 0.3, 0.36, 0.36, 0.36, 0.42, 0.42, 0.42, 0.48, 0.48, 0.48, 0.54, 0.54, 0.54, 0.6})[HeroLvl()] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 150 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({45, 105, 165, 225, 285})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({1.35, 1.5, 1.65, 1.8, 1.95})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 250 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({65, 95, 125, 155, 185})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 250 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({300, 450, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 17/08/22
    Rumble = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 5 + 35 / 17 * (HeroLvl() - 1) end,
            DmgModAD            = function(self, Target) return Target.AbilityPower* 0.25 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({180, 220, 260, 300, 340})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({270, 330, 390, 450, 510})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 890 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 890 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 127.5, 165, 202.5, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1700 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({700, 1050, 1400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.75 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 05/10/22
    Ryze = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 90, 110, 130, 150})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DmgModMP            = function(self, Target) return Target.MaxMana / 100 * 2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DmgModMP            = function(self, Target) return Target.MaxMana / 100 * 4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 3000 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Samira = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 340 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({0, 5, 10, 15, 20})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.85, 0.95, 1.05, 1.15, 1.25})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 325 end,
            Delay               = function() return 0.1 end,
            Dmg                 = function(self, Target) return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 60, 70, 80, 90})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 150, 250})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Sejuaini = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({90, 140, 190, 240, 290})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({50, 95, 140, 185, 230})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 105, 155, 205, 255})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Senna = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0.325 end,
            Dmg                 = function(self, Target) return ({30, 65, 100, 135, 170})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 400 end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({250, 375, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Seraphine = {
        --update
        Passive = {
            Dmg                 = function() return ({4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 14, 14, 14, 14, 14, 24, 24, 24})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.07 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 70, 85, 100, 115})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * ({0.45, 0.5, 0.55, 0.6, 0.65})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1300 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 80, 100, 120, 140})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({150, 200, 250})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 08/09/22
    Sett = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 5 * HeroLvl() end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 40, 60, 80, 100})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.MaxHealth / 100 * (2 + (({2, 3, 4, 5, 6})[SpellLevel(SpellSlot.Q)]) * (Target.BaseAttack + Target.BonusAttack % 100)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 725 end,
            Delay               = function() return 0.75 end,
            Dmg                 = function(self, Target) return ({80, 100, 120, 140, 160})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return 25 + (25 * (Target.BonusAttack % 100)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 70, 90, 110, 130})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.2 end,
            DmgModHP            = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * ({40, 50, 60})[SpellLevel(SpellSlot.R)]  end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Shaco = {
        --update
        Passive = {
            Dmg                 = function(self, Target) return 20 + 15 / 17 * (HeroLvl() - 1) end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.25 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({25, 35, 45, 55, 65})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 425 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({10, 15, 20, 25, 30})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return Target.AbilityPower * 0.12 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 625 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.75 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 250 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 225, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Shen = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30,30,30,48,48,48,66,66,66,84,84,84,102,102,102,120,120,120})[HeroLvl()] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * ({15, 16.5, 18, 19.5, 21})[SpellLevel(SpellSlot.Q)] + (6 * (Target.AbilityPower % 100)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 85, 110, 135, 160})[SpellLevel(SpellSlot.E)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 15 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Shyvana = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.2, 0.35, 0.5, 0.65, 0.8})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return 162.5 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 16.25, 22.5, 28.75, 35})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.15 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({5, 8.125, 11.25, 14.375, 17.5})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.075 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 925 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.4 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 925 end,
            Delay               = function() return 0.3333 end,
            Dmg                 = function(self, Target) return ({75, 75, 75, 75, 75, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135})[HeroLvl()] + ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.7 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Singed = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 180 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({40, 60, 80, 100, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 125 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 60, 70, 80, 90})[SpellLevel(SpellSlot.E)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * ({6, 6.5, 7, 7.5, 8})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Sion = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 850 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 135, 200, 265, 330})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({1.35, 1.575, 1.8, 2.025, 2.25})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 525 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({65, 100, 135, 170, 205})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({400, 800, 1200})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 08/09/22
    Sivir = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1250 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({30, 60, 90, 120, 150})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({1.6, 1.7, 1.8, 1.9, 2})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.25, 0.3, 0.35, 0.40, 0.45})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Skarner = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({1, 1.5, 2, 2.5, 3})[SpellLevel(SpellSlot.Q)] + ((Target.BaseAttack + Target.BonusAttack) * 0.2) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({2, 3, 4, 5, 6})[SpellLevel(SpellSlot.Q)] + (((Target.BaseAttack + Target.BonusAttack) * 0.2) + (Target.AbilityPower * 0.3)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 350 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({40, 120, 200})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.2 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --updated 05/10/22
    Sona = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 825 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 80, 110, 140, 170})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 15, 20, 25, 30})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Soraka = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({85, 120, 155, 190, 225})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 925 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({70, 95, 120, 145, 170})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Swain = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 725 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({108, 168, 228, 288, 348})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return ({5500, 6000, 6500, 7000, 7500})[SpellLevel(SpellSlot.W)] end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 115, 160, 205, 250})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --need update
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return (({420, 600, 780})[SpellLevel(SpellSlot.R)] + (Target.AbilityPower * 1.7)) + (({200, 300, 400})[SpellLevel(SpellSlot.R)]) + (Target.AbilityPower * 1) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Sylas = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 775 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({110, 185, 260, 335, 410})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 400 end,
            Delay               = function() return 0 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 950 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Syndra = {
        --updated 05/10/22
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 800 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return 262.5 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8125 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 925 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        W2 = {
            Range               = function() return 925 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return 230 / 100 * 120 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 115, 155, 195, 235})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        E2 = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 115, 155, 195, 235})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 675 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({630, 910, 1190})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.19 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Range               = function() return 750 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({630, 910, 1190})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.19 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 05/10/22
    TahmKench = {
        Passive = {
            Dmg                 = function(self, Target) return 8 + 52 / 17 * (HeroLvl() - 1) end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 130, 180, 230, 280})[SpellLevel(SpellSlot.Q)] + (Target.AbilityPower * 0.9) end,
            DmgModAP            = function(self, Target) return 8 + 52 / 17 * (HeroLvl() - 1) end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return ({1000, 1050, 1100, 1150, 1200})[SpellLevel(SpellSlot.W)] end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 135, 170, 205, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 250 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 250, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * (15 + 5 * (Target.AbilityPower % 100)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Taliyah = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --need modification
        Q = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({210, 285, 360, 435, 510})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 80, 100, 120, 140})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({2500, 4500, 6000})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Talon = {
        Passive = {
            --Dmg                 = function(self, Target) return 65 + 10 * HeroLvl() end,
            --DmgModAD            = function(self, Target) return Target.BonusAttack * 2 end,
            --DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 575 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({65, 85, 105, 125, 145})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 170 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({65, 85, 105, 125, 145})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 130, 170, 210, 250})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 725 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({180, 270, 360})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 17/08/22
    Taric = {
        Passive = {
            Dmg                 = function(self, Target) return 21 + 4 * HeroLvl() end,
            amageType           = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 325 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 575 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({90, 130, 170, 210, 250})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 400 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Teemo = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 680 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({24, 48, 72, 96, 120})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({400, 650, 900})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({200, 325, 450})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.55 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Thresh = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1040 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({100, 140, 180, 220, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 950 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 537.5 end,
            Delay               = function() return 0.3889 end,
            Dmg                 = function(self, Target) return ({75, 110, 145, 180, 215})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.45 end,
            Dmg                 = function(self, Target) return ({250, 400, 550})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Tristana = {
        Passive = {
            Dmg                 = function() return 8 + 8 * HeroLvl() end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive
        },
        Q = { 
            SpellSlot           = SpellSlot.Q
        },
        W = {
            Range               = function() return 900 end,
            Width               = function() return 350 end,
            Speed               = function() return 1100 end,
            Delay               = function() return 0.9 end, -- original 0.25
            Dmg                 = function() return ({95, 145, 195, 245, 295})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function() return 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            SpellSlot           = SpellSlot.W
        },
        E1 = {
            Range               = function() return 517 + 8 * HeroLvl() end,
            Width               = function() return 300 end,
            Speed               = function() return 2400 end,
            Delay               = function() return 0.226 end,
            Dmg                 = function() return ({55, 80, 105, 130, 155})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function() return 0.25 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        E2 = {
            Range               = function() return 517 + 8 * HeroLvl() end,
            Width               = function() return 300 end,
            Speed               = function() return 2400 end,
            Delay               = function() return 0.226 end,
            Dmg                 = function() return ({70, 80, 90, 100, 110})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function() return ({0.50, 0.75, 1.00, 1.25, 1.50})[SpellLevel(SpellSlot.E)] end,
            DmgModADBase        = function(self, Target) return Target.BonusAttack end,
            DmgModAP            = function() return 0.5 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        EStack = {
            Dmg                 = function() return ({21, 24, 27, 30, 33})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function() return ({0.15, 0.225, 0.30, 0.375, 0.45})[SpellLevel(SpellSlot.E)] end,
            DmgModADBase        = function(self, Target) return Target.BonusAttack end,
            DmgModAP            = function() return 0.15 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        R = {
            Range               = function() return 517 + 8 * HeroLvl() end,
            Width               = function() return 200 end,
            Speed               = function() return 2000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({300, 400, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 1 end,
            DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
            KnockBackDistance   = function() return ({600, 800, 1000})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R
        }
    },
    Trundle = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 40, 60, 80, 100})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.15, 0.25, 0.35, 0.45, 0.55})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 750 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * (({20, 27.5, 35})[SpellLevel(SpellSlot.R)] + 2 * (Target.AbilityPower % 100)) end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Tryndamere = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({25, 40, 55, 70, 85})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 850 end,
            Delay               = function() return 0.3 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 660 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.3 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 08/09/22
    TwistedFate = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 1450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        WBlue = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({40, 60, 80, 100, 120})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        WRed = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({30, 45, 60, 75, 90})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        WYellow = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({15, 22.5, 30, 37.5, 45})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({65, 90, 115, 140, 165})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 5500 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 05/10/22
    Twitch = {
        PassiveStack = {
            Dmg             = function() 
                return 1 + math.floor(HeroLvl()/4)
            end,
            DmgModAP        = function() return 0.03 end,
            DmgModAPBase    = function(self, Target) return Target.AbilityPower end,
            DamageType      = DamageType.TRUEDAMAGE,
            SpellSlot       = SpellSlot.Passive
        },
        Q = {
            DetectionRadius = function() return 500 end,
            SpellSlot       = SpellSlot.Q
        },
        W = {
            Range           = function() return 950 end,
            Speed           = function() return 1400 end, -- original 1400
            Delay           = function() return 0.25 end,
            Width           = function() return 175 end,
            SpellSlot       = SpellSlot.W
        },
        E = {
            Dmg             = function() return ({20, 30, 40, 50, 60})[SpellLevel(SpellSlot.E)] end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1200 end,
            Delay           = function() return 0.25 end,
        },
        EStack1 = {
            Dmg             = function() return ({15, 20, 25, 30, 35})[SpellLevel(SpellSlot.E)] end,
            DmgModAD        = function() return 0.35 end,
            DmgModADBase    = function(self, Target) return Target.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
        },
        EStack2 = {
            DmgModAPBase    = function(self, Target) return Target.AbilityPower end,
            DmgModAP        = function() return 0.35 end,
            DamageType      = DamageType.MAGICALDAMAGE,
        },
        R = {
            Dmg             = function() return ({40,55,70}) end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Speed           = function() return 4000 end,
            Delay           = function() return 0 end,
            Width           = function() return 120 end,
            Range           = function() return 1100 end
        }
    },
    Udyr = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({6, 8.8, 11.6, 14.4, 17.2, 20})[SpellLevel(SpellSlot.Q)] + 12 * (Target.BonusAttack % 100) end,
            DmgModAD            = function(self, Target) return ({5, 13, 21, 29, 37, 45})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD2           = function(self, Target) return Target.BonusAttack * 0.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function(self, Target) return 370 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 152, 224, 296, 368, 440})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Urgot = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({25, 70, 115, 160, 205})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 490 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return 12 end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.2, 0.235, 0.27, 0.305, 0.34})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 450 end,
            Delay               = function() return 0.45 end,
            Dmg                 = function(self, Target) return ({90, 120, 150, 180, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 2500 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({100, 225, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.BonusAttack * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Varus = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1595 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({15, 70, 125, 180, 235})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.8333, 0.8667, 0.9, 0.9333, 0.9667})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * (({9, 10.5, 12, 13.5, 15})[SpellLevel(SpellSlot.W)] + 7.5 * (Target.AbilityPower % 100)) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 925 end,
            Delay               = function() return 0.2419 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.9 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1370 end,
            Delay               = function() return 0.2419 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Vayne = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 300 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.60, 0.65, 0.70, 0.75, 0.80})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({4, 6, 8, 10, 12})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({125, 212.5, 300, 387.5, 475})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1.25 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({25, 40, 55})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Veigar = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 890 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100, 150, 200, 250, 300})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 725 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.E,
        },
        -- update
        R = {
            Range               = function() return 650 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({350, 500, 650})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 17/08/22
    Velkoz = {
        --update
        Passive = {
            Dmg                 = function() return 25 + 8 * HeroLvl() end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.5 end,
            DamageType          = DamageType.TRUEDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1105 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({75, 125, 175, 225, 275})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 100, 130, 160, 190})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        -- update
        R = {
            Range               = function() return 1555 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({450, 625, 800})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.25 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Vex = {
        Passive = {
            Dmg                 = function() return 30 + 110 / 17 * (HeroLvl() -  1) end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.15 end,
            Dmg                 = function(self, Target) return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({50, 70, 90, 110, 130})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * ({0.4, 0.45, 0.5, 0.55, 0.6})[SpellLevel(SpellSlot.E)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return ({2000, 2500, 3000})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 125, 175})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        R2 = {
            Range               = function() return ({2000, 2500, 3000})[SpellLevel(SpellSlot.R)] end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Vi = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 725 end,
            Delay               = function() return 1.25 end,
            Dmg                 = function(self, Target) return ({110, 160, 210, 260, 310})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * (({4, 5.5, 7, 8.5, 10})[SpellLevel(SpellSlot.W)] + 1 * (Target.BonusAttack % 35)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 30, 50, 70, 90})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.1 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 325, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.BonusAttack) * 1.1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Viego = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({15, 30, 45, 60, 75})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 900 end,
            Delay               = function() return 1 end,
            Dmg                 = function(self, Target) return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.AbilityPower) * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 775 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 500 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return (Target.MaxHealth - Target.Health) / 100 * (({12, 16, 20})[SpellLevel(SpellSlot.R)] + 3 * (Target.BonusAttack % 100)) end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Viktor = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 120, 160, 200, 240})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({90, 160, 230, 300, 370})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.3 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({490, 805, 1120})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 3.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Vladimir = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 100, 120, 140, 160})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q2 = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({148, 185, 222, 259, 296})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.11 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update with bonus health
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.W)] end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 10 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        -- updated
        E = {
            Range               = function() return 600 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] / 100 * 106 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.8 end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 625 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.7 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 17/08/22
    Volibear = {
        Passive = {
            Dmg                 = function() return ({11, 12, 13, 15, 17, 19, 22, 25, 28, 31, 34, 37, 40, 44, 48, 52, 56, 60})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({10, 30, 50, 70, 90})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.BonusAttack) * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update no bonus health
        W = {
            Range               = function() return 325 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({5, 30, 55, 80, 105})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1 end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.4 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] / 100 * ({11, 12, 13, 14, 15})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({300, 500, 700})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 2.5 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.25 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- update 17/08/22
    Warwick = {
        Passive = {
            Dmg                 = function() return 10 + 2 * HeroLvl() end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.15 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Passive
        },
        Q = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({6, 7, 8, 9, 10})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 375 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function(self, Target) return Target.MovementSpeed / 100 * 250 end,
            Delay               = function() return 0.1 end,
            Dmg                 = function(self, Target) return ({175, 350, 525})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1.67 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 19/10/22
    --update
    MonkeyKing = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.45 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 300 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * ({0.35, 0.4, 0.45, 0.5, 0.55})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 625 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 162.5 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return Target.MaxHealth / 100 * ({16, 24, 32})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 5.5 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Xayah = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 120, 150, 180, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({55, 65, 75, 85, 95})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.6 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({200, 300, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Xerath = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1450 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.85 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({100.02, 158.365, 216.71, 275.055, 333.4})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.0002 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1125 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 5000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({600, 1000, 1500})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.AbilityPower) * ({1.35, 1.8, 2.25})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    XinZhao = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({48, 75, 102, 129, 156})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.BonusAttack) * 1.2 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 940 end,
            Delay               = function() return 0.5 end,
            Dmg                 = function(self, Target) return ({80, 125, 170, 215, 260})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.2 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.65 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({50, 75, 100, 125, 150})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.AbilityPower) * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 450 end,
            Delay               = function() return 0.35 end,
            Dmg                 = function(self, Target) return ({75, 175, 275})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 1.1 end,
            DmgModHP            = function(self, Target) return (Target.Health) / 100 * 15 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Yasuo = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.05 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q3 = {
            Range               = function() return 1150 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 45, 70, 95, 120})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.05 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 450 end,
            Delay               = function() return 0.013 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 475 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({90, 105, 120, 135, 150})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 0.2 end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1400 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({200, 350, 500})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BonusAttack) * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Yone = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 450 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 40, 60, 80, 100})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.05 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        Q3 = {
            Range               = function() return 1050 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({20, 40, 60, 80, 100})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 1.05 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({10, 20, 30, 40, 50})[SpellLevel(SpellSlot.W)] + (Target.MaxHealth / 100 * ({11, 12, 13, 14, 15})[SpellLevel(SpellSlot.W)]) end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 300 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.75 end,
            Dmg                 = function(self, Target) return ({200, 400, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    Yorick = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({30, 55, 80, 105, 130})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 600 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 700 end,
            Delay               = function() return 0.33 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.7 end,
            SpellSlot           = SpellSlot.E,
        },
        --update
        R = {
            Range               = function() return 600 end,
            Delay               = function() return 0.5 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Yuumi = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1150 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 100, 140, 180, 220, 260})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DmgModHP            = function(self, Target) return Target.Health / 100 * ({2, 3.2, 4.4, 5.6, 6.8, 8})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        --update
        W = {
            Range               = function() return 700 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 1100 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({240, 320, 400})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Zac = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 951 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 110, 140, 170, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * 5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 350 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({35, 50, 65, 80, 95})[SpellLevel(SpellSlot.W)] end,
            DmgModHP            = function(self, Target) return Target.MaxHealth / 100 * ({4, 5, 6, 7, 8})[SpellLevel(SpellSlot.W)] + 4 * (Target.AbilityPower % 100) end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return ({1200, 1350, 1500, 1650, 1800})[SpellLevel(SpellSlot.E)] end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({60, 110, 160, 210, 260})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 300 end,
            Delay               = function() return 0.3 end,
            Dmg                 = function(self, Target) return ({350, 525, 700})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    --Modified 12/08/22
    Zed = {
        --update
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        --update
        Q = {
            Range               = function() return 925 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({80, 115, 150, 185, 220})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 1.1 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({48, 69, 90, 111, 132})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.66 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 315 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return ({70, 90, 110, 130, 150})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        -- need update?
        R = {
            Range               = function() return 625 end,
            Delay               = function() return 0 end,
            Dmg                 = function(self, Target) return (Target.BaseAttack + Target.BonusAttack) * 0.65 + ({25, 40, 55})[SpellLevel(SpellSlot.R)] end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Zeri = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 825 end,
            Delay               = function() return 0 end,
            Width               = function() return 80 end,
            Dmg                 = function(self, Target) return ({8, 11, 14, 17, 20})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * ({1, 1.05, 1.1, 1.15, 1.2})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 650 end,
            Delay               = function() return 0.594 end,
            Speed               = function() return 2200 end,
            Dmg                 = function(self, Target) return ({20, 55, 90, 125, 160})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function(self, Target) return Target.BaseAttack * 1 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 300 end,
            Delay               = function() return 0 end,
            Speed               = function() return 600 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 825 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 250, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAD            = function(self, Target) return Target.BonusAttack * 0.8 end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.8 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
        ROvercharge = {
            Range               = function() return 825 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({5, 10, 15})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.15 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- updated 19/10/22
    Ziggs = {
        Passive = {
            Dmg                 = function() return ({20, 24, 28, 32, 36, 40, 48, 56, 64, 72, 80, 88, 100, 112, 124, 136, 148, 160})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1400 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({95, 145, 195, 245, 295})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.65 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 1000 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 105, 140, 175, 210})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({150, 350, 550, 750, 950})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 5000 end,
            Delay               = function() return 0.375 end,
            Dmg                 = function(self, Target) return ({300, 450, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.1 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Zilean = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 900 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 115, 165, 230, 300})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.9 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function(self, Target) return Target.AttackRange end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 550 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 900 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Zoe = {
        Passive = {
            Dmg                 = function() return ({16, 20, 24, 28, 32, 36, 42, 48, 54, 60, 66, 74, 82, 90, 100, 11, 120, 130})[HeroLvl()] end,
            DmgModAP            = function(self, Target) return (Target.AbilityPower) * 0.2 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 1600 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({17.5, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 72.5, 80, 87.5, 95, 105, 115, 125})[HeroLvl()] + ({125, 200, 275, 350, 425})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 1.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 2200 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({75, 105, 135, 165, 195})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.4 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
        },
        --update
        E = {
            Range               = function() return 850 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.45 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 575 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.R,
        },
    },
    Zyra = {
        Passive = {
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Range               = function() return 800 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({60, 95, 130, 165, 200})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.6 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 850 end,
            Delay               = function() return 0 end,
            SpellSlot           = SpellSlot.W,
        },
        E = {
            Range               = function() return 1100 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1150 end,
            Dmg                 = function(self, Target) return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 700 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function(self, Target) return ({180, 265, 350})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function(self, Target) return Target.AbilityPower * 0.7 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
        },
    },
    -- zamo's work
    -- Cassiopeia = {
    --     Q = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 815 end,
    --         Width               = function() return 75 end,
    --         Delay               = function() return 0.65 end, -- original 0.25
    --         Dmg                 = function() return ({75, 110, 145, 180, 215})[SpellLevel(SpellSlot.Q)] end,
    --         DmgModAP            = function() return 0.9 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --         Speed               = function() return math.huge end,
    --     },
    --     W = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 700 end,
    --         Width               = function() return 160 end,
    --         Delay               = function() return 0.25 end, -- original 0.25
    --         Speed               = function() return 2200 end,
    --         Dmg                 = function() return ({20, 25, 30, 35, 40})[SpellLevel(SpellSlot.W)] end,
    --         DmgModAP            = function() return 0.15 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     E = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 700 end,
    --         Delay               = function() return 0.125 end,
    --         Dmg                 = function() return 48 + 4 * HeroLvl() end,
    --         DmgModAP            = function() return 0.10 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --         Speed               = function() return 1600 end,
    --     },
    --     EPoison = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 700 end,
    --         Delay               = function() return 0.125 end,
    --         Dmg                 = function() return ({10,30,50,70,90})[SpellLevel(SpellSlot.E)] end,
    --         DmgModAP            = function() return 0.60 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     R = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 825 end,
    --         Delay               = function() return 0.5 end,
    --         Speed               = function() return math.huge end,
    --         Dmg                 = function() return ({150,250,350})[SpellLevel(SpellSlot.R)] end,
    --         DmgModAP            = function() return 0.5 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     }
    -- },
    -- Ezreal = {
    --     Q = {
    --         DamageType          = DamageType.PHYSICALDAMAGE,
    --         Range               = function() return 1200 end,
    --         Width               = function() return 120 end,
    --         Speed               = function() return 2000 end,
    --         Delay               = function() return 0.25 end, -- original 0.25
    --         Dmg                 = function() return ({20,45,70,95,120})[SpellLevel(SpellSlot.Q)] end,
    --         DmgModAD            = function() return 1.30 end,
    --         DmgModAP            = function() return 0.15 end,
    --         DmgModADBase        = function(self, Target) return Target.BaseAttack + Target.BonusAttack end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     W = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 1200 end,
    --         Width               = function() return 160 end,
    --         Speed               = function() return 1700 end,
    --         Delay               = function() return 0.25 end, -- original 0.25
    --         Dmg                 = function() return ({80, 135, 190, 245, 300})[SpellLevel(SpellSlot.W)] end,
    --         DmgModAD            = function() return 0.6 end,
    --         DmgModADBase        = function(self, Target) return Target.BonusAttack end,
    --         DmgModAP            = function() return ({0.7, 0.75, 0.8, 0.85,0.9})[SpellLevel(SpellSlot.W)] end,
    --     },
    --     E = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 475 end,
    --         Width               = function() return 750 end,
    --         Speed               = function() return 2000 end,
    --         Delay               = function() return 0.25 end,
    --         Dmg                 = function() return ({80,130,180,230,280})[SpellLevel(SpellSlot.E)] end,
    --         DmgModAD            = function() return 0.5 end,
    --         DmgModADBase        = function(self, Target) return Target.BonusAttack end,
    --         DmgModAP            = function() return 0.75 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     R = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return math.huge end,
    --         Width               = function() return 320 end,
    --         Speed               = function() return 2000 end,
    --         Delay               = function() return 1 end,
    --         Dmg                 = function() return ({350,500,650})[SpellLevel(SpellSlot.R)] end,
    --         DmgModAD            = function() return 1 end,
    --         DmgModADBase        = function(self, Target) return Target.BonusAttack end,
    --         DmgModAP            = function() return 0.9 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     }
    -- },
    -- Veigar = {
    --     Q = {
    --         DamageType              = DamageType.MAGICALDAMAGE,
    --         Range                   = function() return 890 end,
    --         Width                   = function() return 140 end,
    --         Speed                   = function() return 2200 end,
    --         Delay                   = function() return 0.25 end,
    --         Dmg                     = function() return ({80,120,160,200,240})[SpellLevel(SpellSlot.Q)] end,
    --         DmgModAP                = function() return 0.6 end,
    --         DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
    --     },
    --     W = {
    --         DamageType              = DamageType.MAGICALDAMAGE,
    --         Range                   = function() return 900 end,
    --         Width                   = function() return 240 end,
    --         Delay                   = function() return 1.3 end, -- original 1.221
    --         Dmg                     = function() return ({100,150,200,250,300})[SpellLevel(SpellSlot.Q)] end,
    --         DmgModAP                = function() return 1 end,
    --         DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
    --         Speed                   = function() return math.huge end,
    --     },
    --     E = {
    --         DamageType              = DamageType.MAGICALDAMAGE,
    --         Range                   = function() return 725 end,
    --         Width                   = function() return 390 end,
    --         Speed                   = function() return math.huge end,
    --         Delay                   = function() return 0.5 end,
    --     },
    --     R = {
    --         DamageType              = DamageType.MAGICALDAMAGE,
    --         Range                   = function() return 650 end,
    --         Delay                   = function() return 0.25 end,
    --         Dmg                     = function() return ({175,250,325})[SpellLevel(SpellSlot.R)] end,
    --         DmgModAP                = function() return 0.75 end,
    --         DmgModAPBase            = function(self, Target) return Target.AbilityPower end,
    --         DmgModHP                = function(self, Target)
    --             local missingHealthPercentage = (Target.MaxHealth - Target.Health)/Target.MaxHealth

    --             if missingHealthPercentage >= 0.6666 then
    --                 return 1
    --             end

    --             return missingHealthPercentage * 0.015
    --         end,
    --         DmgModHPBase            = function(self) return self:Dmg() + self:DmgModAP() * self:DmgModAPBase() end
    --     }
    -- },
    -- Orianna = {
    --     Passive = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Dmg                 = function() return 10 + 8 * (1 + (math.floor(HeroLvl()-1 / 3))) end,
    --         DmgModAP            = function() return 0.15 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     PassiveStack = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Dmg                 = function() return (10 + 8 * (1 + (math.floor(HeroLvl()-1 / 3)))) * 0.2 end,
    --         DmgModAP            = function() return (0.15) * 0.2 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     Q = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 825 end,
    --         Width               = function() return 175 end,
    --         Speed               = function() return 1400 end,
    --         Delay               = function() return 0 end,
    --         Dmg                 = function() return ({60,90,120,150,180})[SpellLevel(SpellSlot.Q)] end,
    --         DmgModAP            = function() return 0.5 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --         ReducedDamageMod    = function(self, hits) 
    --             if hits == nil or hits == 0 then
    --                 hits = 1
    --             elseif hits > 7 then
    --                 hits = 7
    --             end

    --             return 1.10 - 0.10 * hits 
    --         end,
    --     },
    --     W = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Width               = function() return 250 end,
    --         Delay               = function() return 0 end,
    --         Speed               = function() return math.huge end,
    --         Dmg                 = function() return ({60,105,150,195,240})[SpellLevel(SpellSlot.W)] end,
    --         DmgModAP            = function() return 0.7 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     E = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Range               = function() return 1095 end,
    --         Speed               = function() return math.huge end,
    --         Delay               = function() return 0 end,
    --         Width               = function() return 175 end,
    --         Dmg                 = function() return ({60, 90, 120, 150, 180})[SpellLevel(SpellSlot.E)] end,
    --         DmgModAP            = function() return 0.3 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     },
    --     R = {
    --         DamageType          = DamageType.MAGICALDAMAGE,
    --         Width               = function() return 325 end,
    --         Speed               = function() return math.huge end,
    --         Delay               = function() return 0.5 end,
    --         Dmg                 = function() return ({200,275,350})[SpellLevel(SpellSlot.R)] end,
    --         DmgModAP            = function() return 0.8 end,
    --         DmgModAPBase        = function(self, Target) return Target.AbilityPower end,
    --     }
    -- }
}