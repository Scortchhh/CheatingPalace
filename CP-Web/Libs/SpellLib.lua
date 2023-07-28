require("Enums")
require("BuffLib")

local function SpellLevel(spellSlot)
    if spellSlot == SpellSlot.Passive then
        return HeroLvl()
    end

    return myHero:GetSpellSlot(spellSlot).Level
end

SpellLib = {
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
            DmgModAD            = function() return ({0.60, 0.65, 0.70, 0.75, 0.80})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.Q
        },
        Q2 = {
            Delay               = function() return 0.6 end,
            Range               = function() return 475 end,
            Width               = function() return 500 end,
            Dmg                 = function() return ({12.5, 37.5, 62.5, 87.5, 112.5})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function() return ({0.75, 0.8125, 0.875, 0.9375, 1})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.Q
        },
        Q3 = {
            Delay               = function() return 0.6 end,
            Range               = function() return 200 end,
            Width               = function() return 180 end,
            Dmg                 = function() return ({15, 45, 75, 105, 135})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD            = function() return ({0.90, 0.975, 1.05, 1.125, 1.20})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.Q
        },
        W = {
            Delay               = function() return 0.25 end,
            Speed               = function() return 1800 end,
            Range               = function() return 825 end,
            Width               = function() return 160 end,
            Dmg                 = function() return ({30, 40, 50, 60, 70})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function() return 0.4 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.W
        },
        E = {        
            SpellSlot           = SpellSlot.E,
        },
        R = {
            DmgModAD            = function() return ({0.2, 0.3, 0.4})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.R
        }
    },
    Ahri = {
        Q1 = {
            Dmg                 = function() return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function() return 0.35 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            Range               = function() return 900 end,
            Width               = function() return 200 end,
            Speed               = function() return 1550 end,
            Delay               = function() return 0.25 end,
            SpellSlot           = SpellSlot.Q
        },
        Q2 = {
            Dmg                 = function() return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP            = function() return 0.35 end,
            DamageType          = DamageType.TRUEDAMAGE,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            Speed               = function() return 1900 end, 
            SpellSlot           = SpellSlot.Q,
        },
        W = {
            Range               = function() return 700 end,
            Dmg                 = function() return ({40, 65, 90, 115, 140})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function() return 0.3 end,
            AdditionalBoltMod   = function() return 0.3 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.W,
            Delay               = function() return 0 end,
        },
        E = {
            Range               = function() return 1000 end,
            Width               = function() return 120 end,
            Speed               = function() return 1550 end,
            Delay               = function() return 0.25 end,
            Dmg                 = function() return ({72, 108, 144, 180, 216})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function() return 0.48 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        RStack = {
            Range               = function() return 450 end,
            Width               = function() return 600 end,
            Dmg                 = function() return ({60, 90, 120})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 0.35 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R,
            Delay               = function() return 0 end,
        }
    },
    Akali = {
        Passive = {
            Dmg             = function() return ({29, 32, 35, 38, 41, 44, 47, 50, 59, 68, 77, 86, 95, 110, 125, 140, 155, 170})[SpellLevel(SpellSlot.Passive)] end,
            DmgModAD        = function() return 0.6 end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
            DmgModAP        = function() return 0.4 end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            DamageType      = DamageType.MAGICALDAMAGE,
            RangeMod        = function() return 2 end,
            SpellSlot       = SpellSlot.Passive
        },
        Q = {
            Dmg             = function() return ({30, 55, 80, 105, 130})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function() return 0.65 end,
            DmgModAP        = function() return 0.6 end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            DamageType      = DamageType.MAGICALDAMAGE,
            Range           = function() return 500 end,
            Delay           = function() return 0.25 end,
            Width           = function() return 350 end,
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
            Dmg             = function() return ({50, 85, 120, 155, 190})[SpellLevel(SpellSlot.E)] end,
            DamageType      = DamageType.MAGICALDAMAGE,
            DmgModAD        = function() return 0.35 end,
            DmgModAP        = function() return 0.5 end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            SpellSlot       = SpellSlot.E
        },
        E2 = {
            Range           = function() return math.huge end,
            Speed           = function() return 1500 end,
            Delay           = function() return 0.25 end,
            Dmg             = function() return ({50, 85, 120, 155, 190})[SpellLevel(SpellSlot.E)] end,
            DamageType      = DamageType.MAGICALDAMAGE,
            DmgModAD        = function() return 0.35 end,
            DmgModAP        = function() return 0.5 end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            SpellSlot       = SpellSlot.E
        },
        R1 = {
            Range           = function() return 675 end,
            Speed           = function() return 1500 end,
            Delay           = function() return 0.25 end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Dmg             = function() return ({125, 225, 325 })[SpellLevel(SpellSlot.R)] end,
            DmgModAD        = function() return 0.5 end,
            DmgModADBase    = function() return myHero.BonusAttack end,
            DmgModAP        = function() return 0.3 end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            SpellSlot       = SpellSlot.R
        },
        R2 = {
            Range           = function() return 750 end,
            Speed           = function() return 3000 end,
            Delay           = function() return 0 end,
            DamageType      = DamageType.MAGICALDAMAGE,
            Dmg             = function() return ({75, 145, 215})[SpellLevel(SpellSlot.R)] end,
            DmgModAP        = function() return 0.3 end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
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
            DmgModHPBase    = function() return ({75, 145, 215})[SpellLevel(SpellSlot.R)] end,
            SpellSlot       = SpellSlot.R
        }
    },
    Ashe = {
        Passive = {
            FrostDmgMod         = function() return 1.1 end,
            FrostCritMod        = function() return 0.75 end,
            FrostIEMod          = function() return 0.35 end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.Passive,
        },
        Q = {
            Speed               = function() return math.huge end,
            DmgModAD            = function() return ({0.21, 0.22, 0.23, 0.24, 0.25})[SpellLevel(SpellSlot.Q)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.Q
        },
        W = {
            Range               = function() return 1200 end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 2000 end,
            Dmg                 = function() return ({20, 35, 50, 65, 80})[SpellLevel(SpellSlot.W)] end,
            DmgModAD            = function() return 1 end,
            Width               = function() return 20 end,
            Arrows              = function() return ({7, 8, 9, 10, 11})[SpellLevel(SpellSlot.W)] end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            DmgModADBase        = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot           = SpellSlot.W
        },
        E = {
            Range               = function() return math.huge end,
            Delay               = function() return 0.25 end,
            Speed               = function() return 1400 end,
            Width               = function() return 1000 end,
            SpellSlot           = SpellSlot.E,
        },
        R = {
            Range               = function() return 2000 end,
            Delay               = function() return 1 end,
            Dmg                 = function() return ({200, 400, 600})[SpellLevel(SpellSlot.R)] end,
            DmgModAP            = function() return 1 end,
            DmgSecondary        = function() return ({100, 200, 300})[SpellLevel(SpellSlot.R)] end,
            DmgModSecundary     = function() return 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            SpellSlot           = SpellSlot.R
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
            Range               = function() return 800 end,
            Width               = function() return 350 end,
            Speed               = function() return 1100 end,
            Delay               = function() return 0.9 end, -- original 0.25
            Dmg                 = function() return ({95, 145, 195, 245, 295})[SpellLevel(SpellSlot.W)] end,
            DmgModAP            = function() return 0.5 end,
            DamageType          = DamageType.MAGICALDAMAGE,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            SpellSlot           = SpellSlot.W
        },
        E1 = {
            Range               = function() return 517 + 8 * HeroLvl() end,
            Width               = function() return 300 end,
            Speed               = function() return 2400 end,
            Delay               = function() return 0.226 end,
            Dmg                 = function() return ({55, 80, 105, 130, 155})[SpellLevel(SpellSlot.E)] end,
            DmgModAP            = function() return 0.25 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
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
            DmgModADBase        = function() return myHero.BonusAttack end,
            DmgModAP            = function() return 0.5 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
            DamageType          = DamageType.PHYSICALDAMAGE,
            SpellSlot           = SpellSlot.E
        },
        EStack = {
            Dmg                 = function() return ({21, 24, 27, 30, 33})[SpellLevel(SpellSlot.E)] end,
            DmgModAD            = function() return ({0.15, 0.225, 0.30, 0.375, 0.45})[SpellLevel(SpellSlot.E)] end,
            DmgModADBase        = function() return myHero.BonusAttack end,
            DmgModAP            = function() return 0.15 end,
            DmgModAPBase        = function() return myHero.AbilityPower end,
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
            DmgModAPBase        = function() return myHero.AbilityPower end,
            KnockBackDistance   = function() return ({600, 800, 1000})[SpellLevel(SpellSlot.R)] end,
            DamageType          = DamageType.MAGICALDAMAGE,
            SpellSlot           = SpellSlot.R
        }
    },
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
            DmgModADBase      = function() return myHero.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.Passive,
            CritMod         = function() return 0.09375 + myHero.CritMod end
        },
        Q1 = {
            Dmg             = function() return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function() return ({1.30, 1.40, 1.50, 1.60, 1.70})[SpellLevel(SpellSlot.Q)] end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
            SpellSlot       = SpellSlot.Q,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1300 end,
            Speed           = function() return 1800 end, -- official 2200 but 1800 better results
            Delay           = function() return 0.625 end,
            Width           = function() return 120 end,
        },
        Q2 = {
            Dmg             = function() return ({50, 90, 130, 170, 210})[SpellLevel(SpellSlot.Q)] * 0.60 end,
            DmgModAD        = function() return ({1.30, 1.40, 1.50, 1.60, 1.70})[SpellLevel(SpellSlot.Q)] * 0.60 end,
            DmgModADBase    = function() return myHero.BaseAttack + myHero.BonusAttack end,
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
            Dmg             = function() return ({60, 105, 150, 195, 240})[SpellLevel(SpellSlot.W)] end, 
            DmgModAD        = function() return ({0.40, 0.55, 0.70, 0.85, 1.00})[SpellLevel(SpellSlot.W)] end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 1300 end,
            DmgModBase      = function() return myHero.BonusAttack end,
            SpellSlot       = SpellSlot.W
        },
        E = {
            Dmg             = function() return ({70, 110, 150, 190, 230})[SpellLevel(SpellSlot.E)] end,
            DmgModAP        = function() return 0.8 end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
            DamageType      = DamageType.MAGICALDAMAGE,
            Range           = function() return 750 end,
            Delay           = function() return 0.15 end,
            SpellSlot       = SpellSlot.E,
            BounceRange     = function() return 375 end,
            Width           = function() return 115 end,
            Speed           = function() return 1800 end,
        },
        R = {
            Range           = function() return 3500 end,
            Speed           = function() return 3200 end,
            Delay           = function() return 0.375 end,
            Dmg             = function() return ({300, 525, 750})[SpellLevel(SpellSlot.R)] end,
            DmgModAD        = function() return 2 end,
            DmgModADBase    = function() return myHero.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            SpellSlot       = SpellSlot.R
        }
    },
    Twitch = {
        PassiveStack = {
            Dmg             = function() 
                return 1 + math.floor(HeroLvl()/4)
            end,
            DmgModAP        = function() return 0.025 end,
            DmgModAPBase    = function() return myHero.AbilityPower end,
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
            DmgModADBase    = function() return myHero.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
        },
        EStack2 = {
            DmgModAPBase    = function() return myHero.AbilityPower end,
            DmgModAP        = function() return 0.333 end,
            DamageType      = DamageType.MAGICALDAMAGE,
        },
        R = {
            Dmg             = function() return ({30,45,60}) end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Speed           = function() return 4000 end,
            Delay           = function() return 0 end,
            Width           = function() return 120 end,
            Range           = function() return 1100 end
        }
    },
    KogMaw = {
        Passive = {
            Dmg                     = function() return 100 + 25 * HeroLvl() end,
            DamageType              = DamageType.TRUEDAMAGE,
            Width                   = function() return 400 end,
        },
        Q = {
            Dmg                     = function() return ({90, 140, 190, 240, 290})[SpellLevel(SpellSlot.Q)] end,
            DmgModAP                = function() return 0.7 end,
            DmgModAPBase            = function() return myHero.AbilityPower end,
            DmgModResistanceMod     = function() return ({0.20, 0.22, 0.24, 0.26, 0.28})[SpellLevel(SpellSlot.Q)] end,
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return 1200 end,
            Width                   = function() return 140 end,
            Speed                   = function() return 1650 end,
            Delay                   = function() return 0.25 end,
        },
        W = {
            Delay                   = function() return 0 end,
            DmgModHP                = function() return ({0.03, 0.04, 0.05, 0.06, 0.07})[SpellLevel(SpellSlot.W)] + math.floor(myHero.AbilityPower/100) end,
            DmgModHPBase            = function(self, Hero) return Hero.MaxHealth end,
            DamageType              = DamageType.MAGICALDAMAGE,
            Range                   = function() return ({130, 150, 170, 190, 210})[SpellLevel(SpellSlot.W)] + myHero.AttackRange + myHero.CharData.BoundingRadius end,
        },
        E = {
            Dmg                     = function() return ({75, 120, 165, 210, 255})[SpellLevel(SpellSlot.E)] end,
            DmgModAP                = function() return 0.5 end,
            DmgModAPBase            = function() return myHero.AbilityPower end,
            Range                   = function() return 1360 end,
            Width                   = function() return 240 end,
            Speed                   = function() return 1400 end,
            Delay                   = function() return 0.25 end,
            DamageType              = DamageType.MAGICALDAMAGE
        },
        R = {
            Range                   = function() return ({1300, 1550, 1800})[SpellLevel(SpellSlot.R)] end,
            Width                   = function() return 240 end,
            Delay                   = function() return 0.9 end,
            Speed                   = function() return 1650 end,
            ManaCost                = function(self, stacks) 
                if stacks > 10 then
                    stacks = 10
                end
                return stacks * 40
            end,
            Dmg                     = function() return ({100, 140, 180})[SpellLevel(SpellSlot.R)] end,
            DmgModAD                = function() return 0.65 end,
            DmgModADBase            = function() return myHero.BonusAttack end,
            DmgModAP                = function() return 0.35 end,
            DmgModAPBase            = function() return myHero.AbilityPower end,
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
    Kindred = {
        Q = {
            Dmg             = function() return ({60, 80, 100, 120, 140})[SpellLevel(SpellSlot.Q)] end,
            DmgModAD        = function() return 0.65 end,
            DmgModADBase    = function() return myHero.BonusAttack end,
            DamageType      = DamageType.PHYSICALDAMAGE,
            Range           = function() return 340 end,
            Width           = function() return myHero.AttackRange + myHero.CharData.BoundingRadius end,
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
            DmgModADBase    = function() return myHero.BonusAttack end,
            DmgModHP        = function() return 0.015 + BuffLib.Kindred:MarkCounter(myHero) * 0.01 end,
            DmgModHPBase    = function(self, Target) return Target.Health end,
        },
        E = {
            Range           = function() 
                local counter = BuffLib.Kindred:MarkCounter(myHero)

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
            DmgModAD        = function() return myHero.BonusAttack end,
            DmgModHP        = function() return 0.08 + 0.005 * BuffLib.Kindred:MarkCounter(myHero) end,
            DmgModHPBase    = function(self, Target) return Target.MaxHealth - Target.Health end,
            DamageType      = DamageType.PHYSICALDAMAGE
        },
        EWolf = {
            DamageType      = DamageType.PHYSICALDAMAGE,
            DmgModAD        = function() return 0.5 end,
            DmgModADBase    = function() return myHero.BonusAttack end,
        },
        EWolfInfinityEdge = {
            DamageType      = DamageType.PHYSICALDAMAGE,
            DmgModAD        = function() return 0.525 end,
            DmgModADBase    = function() return myHero.BonusAttack end,
        }
    }
}