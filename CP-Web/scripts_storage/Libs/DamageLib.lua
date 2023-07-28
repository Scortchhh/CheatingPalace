require("Enums")
require("ItemLib")
require("SpellLib")
require("BuffLib")

local function SpellDmg(SpellObject, Target)
    local spellDmg              = 0
    local spellDmgModAD         = 0
    local spellDmgModADBase     = 0
    local spellDmgModAP         = 0
    local spellDmgModAPBase     = 0
    local spellDmgModHP         = 0
    local spellDmgModHPBase     = 0
    local additionalCrit        = 0
    local pressTheAttackDmg     = 0
    local additionalArmorPenMod = 0

    if SpellObject ~= nil then
        if SpellObject.Dmg ~= nil then
            spellDmg = SpellObject:Dmg(Target)
            if spellDmg == nil then
                spellDmg = 0
            end
        end

        if SpellObject.DmgModAD ~= nil then
            spellDmgModAD = SpellObject:DmgModAD(Target)
            if spellDmgModAD == nil then
                spellDmgModAD = 0
            end
        end

        if SpellObject.DmgModADBase ~= nil then
            spellDmgModADBase = SpellObject:DmgModADBase(Target)
            if spellDmgModADBase == nil then
                spellDmgModADBase = 0
            end
        end

        if SpellObject.DmgModAP ~= nil then
            spellDmgModAP = SpellObject:DmgModAP(Target)
            if spellDmgModAP == nil then
                spellDmgModAP = 0
            end
        end

        if SpellObject.DmgModAPBase ~= nil then
            spellDmgModAPBase = SpellObject:DmgModAPBase(Target)
            if spellDmgModAPBase == nil then
                spellDmgModAPBase = 0
            end
        end

        if SpellObject.DmgModHP ~= nil then
            spellDmgModHP = SpellObject:DmgModHP(Target)
            if spellDmgModHP == nil then
                spellDmgModHP = 0
            end
        end

        if SpellObject.DmgModHPBase ~= nil then
            spellDmgModHPBase = SpellObject:DmgModHPBase(Target)
            if spellDmgModHPBase == nil then
                spellDmgModHPBase = 0
            end
        end

        if SpellObject.CritMod ~= nil then
            additionalCrit = SpellObject:CritMod(Target)
            if additionalCrit == nil then
                additionalCrit = 0
            end
        end

        if SpellObject.ArmorPenMod ~= nil then
            additionalArmorPenMod = SpellObject:ArmorPenMod(Target)
            if additionalArmorPenMod == nil then
                additionalArmorPenMod = 0
            end
        end
    end

    local totalDamage = spellDmg + pressTheAttackDmg + (spellDmgModAD * spellDmgModADBase) + (spellDmgModAP * spellDmgModAPBase) + (spellDmgModHP * spellDmgModHPBase) * (1 + additionalCrit)
    return DamageLib:GetDamage(totalDamage, SpellObject.DamageType, Target, additionalArmorPenMod)
end

local function AADmg(Source, Target, HasInfinityEdge)
    local bonuscritDamage       = 0
    local krakenSlayerDmg       = 0
    local pressTheAttackDmg     = 0
    local sheenDmg              = 0

    local fightDuration = 10 -- 5 sec
    local attackSpeed = Source.CharData.BaseAttackSpeed + (Source.AttackSpeedMod - 1)
    local AutoAttacksDuringTime = attackSpeed * fightDuration

    if BuffLib.Items:KrakenSlayer(Source) then
        krakenSlayerDmg = SpellDmg(ItemLib.KrakenSlayer, Target)
    end

    if HasInfinityEdge ~= nil and HasInfinityEdge then
        bonuscritDamage = bonuscritDamage + ItemLib.InfinityEdge:CritDmgMod()
    end

    if BuffLib.Items:Sheen(Source) then
        sheenDmg = SpellDmg(ItemLib.Sheen, Target)
    end
    local rawDmg = (Source.BaseAttack + Source.BonusAttack) * (1 + (Source.CritMod * (0.75 + bonuscritDamage))) + pressTheAttackDmg
    
    if Source.CritMod == 1.75 then -- main API broken
        rawDmg = (Source.BaseAttack + Source.BonusAttack) * (1 + (0* (0.75 + bonuscritDamage))) + pressTheAttackDmg
    end
    -- print('source', Source.ChampionName .. " Targets " .. Target.ChampionName .. " DMG " .. DamageLib:GetDamage(rawDmg, DamageType.PHYSICALDAMAGE, Target) + krakenSlayerDmg + sheenDmg)
    return (DamageLib:GetDamage(rawDmg, DamageType.PHYSICALDAMAGE, Target) * AutoAttacksDuringTime) + krakenSlayerDmg + sheenDmg
end 

DamageLib = {
    TargetSelector = {
        AD = function(self, Target)
            return AADmg(Target, false)
        end,
        AP = function(self, Target)
            return SpellDmg({
                Dmg = function() return 100 end,
                DamageType = DamageType.MAGICALDAMAGE,
                DmgModAP = function() return 1 end,
                DmgModAPBase = function() return myHero.AbilityPower end,
            }, Target)
        end
    },
    Galeforce = {
        GetDmg = function(self, Hero)
            return SpellDmg(ItemLib.Galeforce, Hero)
        end
    },
    PracticeTool_TargetDummy = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return 0
        end,
        GetPassiveDmg = function(self, Hero)
            return 0
        end,
        GetQDmg = function(self, Hero)
            return 0
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            if Stacks == nil then
                Stacks = 1
            end
            return 0
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Aatrox = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Aatrox.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            local q1 = SpellDmg(SpellLib.Aatrox.Q1, Hero)
            local q2 = SpellDmg(SpellLib.Aatrox.Q2, Hero)
            local q3 = SpellDmg(SpellLib.Aatrox.Q3, Hero)
            local total = q1 + q2 + q3
            return SpellDmg(total, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Aatrox.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Ahri = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ahri.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            local q1 = SpellDmg(SpellLib.Ahri.Q1, Hero)
            local q2 = SpellDmg(SpellLib.Ahri.Q2, Hero)
            local total = q1 + q2
            return SpellDmg(total, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ahri.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Ahri.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ahri.R, Hero) * 3
        end
    },
    Akali = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akali.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akali.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akali.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Akali.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akali.R, Hero)
        end
    },
    Akshan = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akshan.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akshan.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Akshan.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Akshan.R, Hero)
        end
    },
    Alistar = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Alistar.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Alistar.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Alistar.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Alistar.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Amumu = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Amumu.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Amumu.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Amumu.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Amumu.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Amumu.R, Hero)
        end
    },
    Anivia = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Anivia.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Anivia.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Anivia.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Anivia.R, Hero)
        end
    },
    Annie = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Annie.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Annie.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Annie.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Annie.R, Hero)
        end
    },
    -- Aphelios = {
    --     GetAADmg = function(self, Hero, HasInfinityEdge)
    --         return AADmg(Hero, HasInfinityEdge)
    --     end,
    --     GetPassiveDmg = function(self, Hero)
    --         return 0
    --     end,
    --     GetQDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Annie.Q, Hero)
    --     end,
    --     GetWDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Annie.W, Hero)
    --     end,
    --     GetEDmg = function(self, Hero, Stacks)
    --         return 0
    --     end,
    --     GetRDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Annie.R, Hero)
    --     end
    -- },
    Ashe = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ashe.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ashe.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ashe.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ashe.R, Hero)
        end
    },
    AurelionSol = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.AurelionSol.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.AurelionSol.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.AurelionSol.R, Hero)
        end
    },
    Azir = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Azir.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Azir.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Azir.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Azir.R, Hero)
        end
    },
    Bard = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Bard.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Bard.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    -- Belveth = {
    --     GetAADmg = function(self, Hero, HasInfinityEdge)
    --         return AADmg(Hero, HasInfinityEdge)
    --     end,
    --     GetPassiveDmg = function(self, Hero)
    --         return 0
    --     end,
    --     GetQDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Bard.Q, Hero)
    --     end,
    --     GetWDmg = function(self, Hero)
    --         return 0
    --     end,
    --     GetEDmg = function(self, Hero, Stacks)
    --         return 0
    --     end,
    --     GetRDmg = function(self, Hero)
    --         return 0
    --     end
    -- },
    Blitzcrank = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Blitzcrank.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Blitzcrank.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Blitzcrank.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Blitzcrank.R, Hero)
        end
    },
    Brand = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Brand.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Brand.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Brand.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Brand.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Brand.R, Hero)
        end
    },
    Braum = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Braum.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Braum.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Braum.R, Hero)
        end
    },
    Caitlyn = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            local trapDmg   = 0

            if BuffLib.Caitlyn:Trapped(Hero) then
                trapDmg = SpellDmg(SpellLib.Caitlyn.WPassive, Hero)
            end

            if BuffLib.Caitlyn:Headshot(myHero) 
            or BuffLib.Caitlyn:Trapped(Hero) 
            or BuffLib.Caitlyn:Netted(Hero) 
            then
                return (SpellDmg(SpellLib.Caitlyn.Passive, Hero)) + trapDmg        
            end
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Caitlyn.Passive, Hero)
        end,
        GetQDmg = function(self, Hero, WillCollide)
            if WillCollide and not(BuffLib.Caitlyn:Trapped(Hero)) then
                return SpellDmg(SpellLib.Caitlyn.Q2, Hero)
            end
            return SpellDmg(SpellLib.Caitlyn.Q1, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Caitlyn.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Caitlyn.R, Hero)
        end
    },
    Camille = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Camille.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Camille.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Camille.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Camille.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Cassiopeia = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Cassiopeia.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Cassiopeia.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Cassiopeia.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            local poisonnedDmg = 0
            if BuffLib:HasOneBuffOfType(Hero, {BuffType.Poison}) then
                poisonnedDmg = SpellDmg(SpellLib.Cassiopeia.EPoison, Hero)
            end
            return SpellDmg(SpellLib.Cassiopeia.E, Hero) + poisonnedDmg
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Cassiopeia.R, Hero)
        end,
    },
    Chogath = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Chogath.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Chogath.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Chogath.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Chogath.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Chogath.R, Hero)
        end
    },
    Corki = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Corki.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Corki.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Corki.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Corki.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Corki.R, Hero)
        end
    },
    Darius = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Darius.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Darius.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Darius.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Darius.R, Hero)
        end
    },
    Diana = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Diana.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Diana.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Diana.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Diana.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Diana.R, Hero)
        end
    },
    DrMundo = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.DrMundo.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.DrMundo.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.DrMundo.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.DrMundo.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Draven = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Draven.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Draven.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Draven.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Draven.R, Hero)
        end
    },
    Ekko = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ekko.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ekko.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Ekko.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ekko.R, Hero)
        end
    },
    Elise = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Elise.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Elise.Q1, Hero) + SpellDmg(SpellLib.Elise.Q2, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Elise.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Evelynn = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Evelynn.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Evelynn.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return 0
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Evelynn.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Evelynn.R, Hero)
        end
    },
    Ezreal = {
        GetAADmg = function(self, Hero, HasInifityEdge)
            return AADmg(Hero, HasInifityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ezreal.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ezreal.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            local wDmg = 0

            if BuffLib.Ezreal:W(Hero) then
                wDmg = SpellDmg(SpellLib.Ezreal.W, Hero)
            end
            return wDmg
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ezreal.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ezreal.R, Hero)
        end,
    },
    FiddleSticks = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.FiddleSticks.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.FiddleSticks.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.FiddleSticks.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.FiddleSticks.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.FiddleSticks.R, Hero)
        end
    },
    Fiora = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fiora.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fiora.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fiora.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return 0
        end,
        GetRDmg = function(self, Hero)
            return 0
        end
    },
    Fizz = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fizz.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fizz.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fizz.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Fizz.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Fizz.R, Hero)
        end
    },
    Galio = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Galio.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Galio.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Galio.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Galio.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Galio.R, Hero)
        end
    },
    Gangplank = {
        GetAADmg = function(self, Hero, HasInfinityEdge, includingPassive)
            local passiveDmg = 0
            if includingPassive and BuffLib.Gangplank:TrialByFire(myHero) then
                passiveDmg = self:GetPassiveDmg(Hero)
            end
            return AADmg(Hero, HasInifityEdge) + passiveDmg
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gangplank.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gangplank.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gangplank.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gangplank.E, Hero)
        end,
        GetRDmg = function(self, Hero, Waves)
            if Waves > SpellLib.Gangplank.R:AmountOfWaves() then
                Waves = SpellLib.Gangplank.R:AmountOfWaves()
            end

            return SpellDmg(SpellLib.Gangplank.R, Hero) * Waves
        end,
        GetRDeathsDaughterDmg = function(self, Hero) 
            return SpellDmg(SpellLib.Gangplank.RDeathsDaughter, Hero)
        end,
    },
    Garen = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Garen.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Garen.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Garen.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Garen.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Garen.R, Hero)
        end
    },
    Gnar = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gnar.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gnar.Q, Hero) + SpellDmg(SpellLib.Gnar.Q2, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gnar.W, Hero) + SpellDmg(SpellLib.Gnar.W2, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Gnar.E, Hero) + SpellDmg(SpellLib.Gnar.E2, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gnar.R, Hero)
        end
    },
    Gragas = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gragas.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gragas.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gragas.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Gragas.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gragas.R, Hero)
        end
    },
    Graves = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Graves.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Graves.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Graves.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Graves.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Graves.R, Hero)
        end
    },
    Gwen = {
        GetAADmg = function(self, Hero, HasInfinityEdge, includingPassive)
            local passiveDmg = 0
            if includingPassive and BuffLib.Gangplank:TrialByFire(myHero) then
                passiveDmg = self:GetPassiveDmg(Hero)
            end
            return AADmg(Hero, HasInifityEdge) + passiveDmg
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gwen.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gwen.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gwen.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Gwen.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            local RBuff = myHero.BuffData:GetBuff("GwenRRecast")
            local Count = RBuff.Count_Int
            if Count == 0 then
                return SpellDmg(SpellLib.Gwen.R1, Hero) + SpellDmg(SpellLib.Gwen.R2, Hero) + SpellDmg(SpellLib.Gwen.R3, Hero)
            elseif Count == 1 or Count == 2 then
                return SpellDmg(SpellLib.Gwen.R2, Hero) + SpellDmg(SpellLib.Gwen.R3, Hero)
            elseif Count == 3 then
                return SpellDmg(SpellLib.Gwen.R3, Hero)
            end
        end,
    },
    Hecarim = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Hecarim.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Hecarim.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Hecarim.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Hecarim.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Hecarim.R, Hero)
        end
    },
    Heimerdinger = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Heimerdinger.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Heimerdinger.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Heimerdinger.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Heimerdinger.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Heimerdinger.R, Hero)
        end
    },
    Illaoi = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Illaoi.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Illaoi.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Illaoi.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Illaoi.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Illaoi.R, Hero)
        end
    },
    Irelia = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Irelia.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Irelia.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Irelia.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Irelia.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Irelia.R, Hero)
        end
    },
    Ivern = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ivern.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ivern.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ivern.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Ivern.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ivern.R, Hero)
        end
    },
    Janna = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Janna.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Janna.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Janna.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Janna.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Janna.R, Hero)
        end
    },
    JarvanIV = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.JarvanIV.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.JarvanIV.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.JarvanIV.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.JarvanIV.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.JarvanIV.R, Hero)
        end
    },
    Jax = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jax.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jax.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jax.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Jax.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jax.R, Hero)
        end
    },
    Jayce = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jayce.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jayce.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jayce.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Jayce.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jayce.R, Hero)
        end
    },
    Jhin = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jhin.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jhin.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jhin.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            return SpellDmg(SpellLib.Jhin.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jhin.R, Hero)
        end
    },
    Jinx = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jinx.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jinx.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jinx.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jinx.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Jinx.R, Hero)
        end
    },
    Kaisa = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kaisa.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kaisa.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kaisa.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kaisa.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kaisa.R, Hero)
        end
    },
    Kalista = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kalista.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kalista.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kalista.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kalista.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kalista.R, Hero)
        end
    },
    Karma = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karma.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karma.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karma.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karma.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karma.R, Hero)
        end
    },
    Karthus = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karthus.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karthus.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karthus.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karthus.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Karthus.R, Hero)
        end
    },
    Kassadin = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kassadin.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kassadin.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kassadin.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kassadin.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kassadin.R, Hero)
        end
    },
    Katarina = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Katarina.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Katarina.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Katarina.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Katarina.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Katarina.R, Hero)
        end
    },
    Kayle = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayle.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayle.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayle.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayle.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayle.R, Hero)
        end
    },
    Kayn = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayn.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayn.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayn.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayn.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kayn.R, Hero)
        end
    },
    Kennen = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kennen.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kennen.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kennen.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kennen.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kennen.R, Hero)
        end
    },
    KhaZix = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.KhaZix.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.KhaZix.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.KhaZix.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.KhaZix.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.KhaZix.R, Hero)
        end
    },
    Kindred = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.W, Hero)
        end,
        GetEDmg = function(self, Hero, HasInfinityEdge)
            local wolfEntranceThreshold = 0.15 + 0.05 * myHero.CritMod
            local wolfDmg = 0

            if (Hero.Health - AADmg(Hero, HasInfinityEdge)) / Hero.MaxHealth < wolfEntranceThreshold then
                wolfDmg =  SpellDmg(SpellLib.Kindred.EWolf, Hero) 
                if HasInfinityEdge then
                    wolfDmg = wolfDmg + SpellDmg(SpellLib.Kindred.EWolfInfinityEdge, Hero)
                end
            end

            return SpellDmg(SpellLib.Kindred.E, Hero) + wolfDmg
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.R, Hero)
        end
    },
    Kled = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kled.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kled.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kled.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kled.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kled.R, Hero)
        end
    },
    KogMaw = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            local additionalBioDmg = 0

            if BuffLib.KogMaw:BioArcaneBarage(myHero) then
                additionalBioDmg = SpellDmg(SpellLib.KogMaw.W, Hero)
            end

            return AADmg(Hero, HasInfinityEdge) + additionalBioDmg
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.R, Hero)
        end,
    },
    LeBlanc = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeBlanc.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeBlanc.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeBlanc.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeBlanc.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeBlanc.R, Hero)
        end
    },
    LeeSin = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeeSin.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeeSin.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeeSin.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeeSin.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.LeeSin.R, Hero)
        end
    },
    Leona = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Leona.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Leona.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Leona.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Leona.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Leona.R, Hero)
        end
    },
    Lillia = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lillia.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lillia.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lillia.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lillia.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lillia.R, Hero)
        end
    },
    Lissandra = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lissandra.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lissandra.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lissandra.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lissandra.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lissandra.R, Hero)
        end
    },
    Lucian = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lucian.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lucian.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lucian.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lucian.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lucian.R, Hero)
        end
    },
    Lulu = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lulu.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lulu.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lulu.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lulu.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lulu.R, Hero)
        end
    },
    Lux = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lux.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lux.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lux.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lux.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Lux.R, Hero)
        end
    },
    Malphite = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malphite.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malphite.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malphite.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malphite.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malphite.R, Hero)
        end
    },
    Malzahar = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malzahar.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malzahar.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malzahar.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malzahar.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Malzahar.R, Hero)
        end
    },
    Maokai = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Maokai.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Maokai.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Maokai.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Maokai.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Maokai.R, Hero)
        end
    },
    MasterYi = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.MasterYi.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.MasterYi.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.MasterYi.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.MasterYi.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.MasterYi.R, Hero)
        end
    },
    MissFortune = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.MissFortune.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.MissFortune.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.MissFortune.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.MissFortune.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.MissFortune.R, Hero)
        end
    },
    Mordekaiser = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Mordekaiser.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Mordekaiser.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Mordekaiser.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Mordekaiser.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Mordekaiser.R, Hero)
        end
    },
    Morgana = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Morgana.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Morgana.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Morgana.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Morgana.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Morgana.R, Hero)
        end
    },
    Nami = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nami.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nami.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nami.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nami.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nami.R, Hero)
        end
    },
    Nasus = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nasus.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nasus.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nasus.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nasus.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nasus.R, Hero)
        end
    },
    Nautilus = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nautilus.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nautilus.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nautilus.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nautilus.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nautilus.R, Hero)
        end
    },
    Neeko = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Neeko.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Neeko.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Neeko.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Neeko.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Neeko.R, Hero)
        end
    },
    Nidalee = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nidalee.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nidalee.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nidalee.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nidalee.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nidalee.R, Hero)
        end
    },
    Nilah = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nilah.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nilah.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nilah.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nilah.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nilah.R, Hero)
        end
    },
    Nocturne = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nocturne.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nocturne.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nocturne.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nocturne.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nocturne.R, Hero)
        end
    },
    Nunu = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nunu.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nunu.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nunu.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nunu.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Nunu.R, Hero)
        end
    },
    Olaf = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Olaf.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Olaf.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Olaf.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Olaf.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Olaf.R, Hero)
        end
    },
    Orianna = {
        GetAADmg = function(self, Hero)
            -- count in stacks 
            return AADmg(Hero, false) + SpellDmg(SpellLib.Orianna.Passive, Hero) 
        end,
        GetPassiveDmg = function(self, Hero)
            -- count in stacks
            return SpellDmg(SpellLib.Orianna.Passive, Hero) 
        end,
        GetQDmg = function(self, Hero, hits)
            return SpellDmg(SpellLib.Orianna.Q, Hero) * SpellLib.Orianna.Q:ReducedDamageMod(hits)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Orianna.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Orianna.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Orianna.R, Hero)
        end,
    },
    Ornn = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ornn.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ornn.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ornn.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ornn.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ornn.R, Hero)
        end
    },
    Pantheon = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pantheon.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pantheon.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pantheon.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pantheon.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pantheon.R, Hero)
        end
    },
    Poppy = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Poppy.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Poppy.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Poppy.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Poppy.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Poppy.R, Hero)
        end
    },
    Pyke = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pyke.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pyke.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pyke.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pyke.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Pyke.R, Hero)
        end
    },
    Qiyana = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Qiyana.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Qiyana.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Qiyana.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Qiyana.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Qiyana.R, Hero)
        end
    },
    Quinn = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Quinn.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Quinn.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Quinn.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Quinn.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Quinn.R, Hero)
        end
    },
    Rakan = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rakan.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rakan.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rakan.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rakan.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rakan.R, Hero)
        end
    },
    Rammus = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rammus.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rammus.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rammus.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rammus.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rammus.R, Hero)
        end
    },
    Reksai = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Reksai.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Reksai.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Reksai.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Reksai.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Reksai.R, Hero)
        end
    },
    Rell = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rell.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rell.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rell.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rell.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rell.R, Hero)
        end
    },
    -- RenataGlasc = {
    --     -- needs update
    --     GetAADmg = function(self, Hero, HasInfinityEdge)
    --         return AADmg(Hero, HasInfinityEdge)
    --     end,
    --     GetQDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Rell.Q, Hero) 
    --     end,
    --     GetWDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Rell.W, Hero) 
    --     end,
    --     GetEDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Rell.E, Hero) 
    --     end,
    --     GetRDmg = function(self, Hero)
    --         return SpellDmg(SpellLib.Rell.R, Hero)
    --     end
    -- },
    Renekton = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Renekton.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Renekton.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Renekton.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Renekton.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Renekton.R, Hero)
        end
    },
    Rengar = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rengar.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rengar.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rengar.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rengar.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rengar.R, Hero)
        end
    },
    Riven = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Riven.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Riven.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Riven.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Riven.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Riven.R, Hero)
        end
    },
    Rumble = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rumble.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rumble.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rumble.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rumble.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Rumble.R, Hero)
        end
    },
    Ryze = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ryze.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ryze.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ryze.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ryze.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ryze.R, Hero)
        end
    },
    Samira = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Samira.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Samira.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Samira.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Samira.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Samira.R, Hero)
        end
    },
    Sejuaini = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sejuaini.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sejuaini.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sejuaini.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sejuaini.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sejuaini.R, Hero)
        end
    },
    Senna = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Senna.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Senna.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Senna.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Senna.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Senna.R, Hero)
        end
    },
    Seraphine = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Seraphine.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Seraphine.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Seraphine.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Seraphine.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Seraphine.R, Hero)
        end
    },
    Sett = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sett.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sett.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sett.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sett.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sett.R, Hero)
        end
    },
    Shaco = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shaco.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shaco.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shaco.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shaco.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shaco.R, Hero)
        end
    },
    Shen = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shen.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shen.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shen.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shen.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shen.R, Hero)
        end
    },
    Shyvana = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shyvana.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shyvana.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shyvana.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shyvana.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Shyvana.R, Hero)
        end
    },
    Singed = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Singed.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Singed.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Singed.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Singed.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Singed.R, Hero)
        end
    },
    Sion = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sion.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sion.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sion.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sion.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sion.R, Hero)
        end
    },
    Sivir = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sivir.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sivir.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sivir.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sivir.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sivir.R, Hero)
        end
    },
    Skarner = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Skarner.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Skarner.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Skarner.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Skarner.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Skarner.R, Hero)
        end
    },
    Sona = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sona.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sona.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sona.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sona.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sona.R, Hero)
        end
    },
    Soraka = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Soraka.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Soraka.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Soraka.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Soraka.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Soraka.R, Hero)
        end
    },
    Swain = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Swain.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Swain.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Swain.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Swain.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Swain.R, Hero)
        end
    },
    Sylas = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sylas.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sylas.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sylas.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sylas.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Sylas.R, Hero)
        end
    },
    Syndra = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Syndra.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Syndra.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Syndra.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Syndra.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Syndra.R, Hero)
        end
    },
    TahmKench = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.TahmKench.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.TahmKench.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.TahmKench.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.TahmKench.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.TahmKench.R, Hero)
        end
    },
    Taliyah = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taliyah.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taliyah.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taliyah.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taliyah.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taliyah.R, Hero)
        end
    },
    Talon = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Talon.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Talon.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Talon.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Talon.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Talon.R, Hero)
        end
    },
    Taric = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taric.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taric.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taric.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taric.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Taric.R, Hero)
        end
    },
    Teemo = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Teemo.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Teemo.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Teemo.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Teemo.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Teemo.R, Hero)
        end
    },
    Thresh = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Thresh.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Thresh.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Thresh.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Thresh.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Thresh.R, Hero)
        end
    },
    Tristana = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tristana.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tristana.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tristana.W, Hero)
        end,
        GetEDmg = function(self, Hero, Stacks)
            if Stacks == nil then
                Stacks = 1
            end
            return SpellDmg(SpellLib.Tristana.E1, Hero) + SpellDmg(SpellLib.Tristana.E2, Hero) + SpellDmg(SpellLib.Tristana.EStack, Hero) * Stacks
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tristana.R, Hero)
        end
    },
    Trundle = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Trundle.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Trundle.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Trundle.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Trundle.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Trundle.R, Hero)
        end
    },
    Tryndamere = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tryndamere.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tryndamere.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tryndamere.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tryndamere.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tryndamere.R, Hero)
        end
    },
    TwistedFate = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.TwistedFate.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.TwistedFate.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.TwistedFate.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.TwistedFate.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.TwistedFate.R, Hero)
        end
    },
    Twitch = {
        GetQDmg = function(self, Hero, HasInfinityEdge)
            return 0
        end,
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetWDmg = function(self, Hero, HasInfinityEdge)
            return SpellDmg(SpellLib.Twitch.W, Hero)
        end,
        GetPassiveDmg = function(self, Hero, Stacks)
            local Stacks = Hero.BuffData:GetBuff("twitchdeadlyvenom").Count_Int
            return (SpellDmg(SpellLib.Twitch.PassiveStack, Hero) * Stacks) * 6
        end,
        GetEDmg = function(self, Hero, Stacks)
            local Stacks = Hero.BuffData:GetBuff("twitchdeadlyvenom").Count_Int
            return SpellDmg(SpellLib.Twitch.E, Hero) 
            + SpellDmg(SpellLib.Twitch.EStack1, Hero) * Stacks 
            + SpellDmg(SpellLib.Twitch.EStack2, Hero) * Stacks
        end,
        GetRDmg = function(self, Hero, HasInfinityEdge, WillCollide)
            local modifier = 0

            if (WillCollide) then -- rework to amount of collision formula
                modifier = 0.60
            end

            return self:GetAADmg(Hero, HasInfinityEdge) * modifier
        end
    },
    Udyr = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Udyr.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Udyr.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Udyr.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Udyr.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Udyr.R, Hero)
        end
    },
    Urgot = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Urgot.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Urgot.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Urgot.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Urgot.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Urgot.R, Hero)
        end
    },
    Varus = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Varus.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Varus.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Varus.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Varus.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Varus.R, Hero)
        end
    },
    Vayne = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vayne.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vayne.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vayne.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vayne.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vayne.R, Hero)
        end
    },
    Veigar = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Veigar.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Veigar.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Veigar.W, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Veigar.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Veigar.R, Hero)
        end,
    },
    Velkoz = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Velkoz.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Velkoz.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Velkoz.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Velkoz.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Velkoz.R, Hero)
        end
    },
    Vex = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vex.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vex.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vex.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vex.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vex.R, Hero)
        end
    },
    Vi = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vi.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vi.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vi.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vi.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vi.R, Hero)
        end
    },
    Viego = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viego.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viego.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viego.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viego.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viego.R, Hero)
        end
    },
    Viktor = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viktor.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viktor.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viktor.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viktor.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Viktor.R, Hero)
        end
    },
    Vladimir = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vladimir.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vladimir.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vladimir.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vladimir.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Vladimir.R, Hero)
        end
    },
    Volibear = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Volibear.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Volibear.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Volibear.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Volibear.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Volibear.R, Hero)
        end
    },
    Warwick = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Warwick.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Warwick.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Warwick.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Warwick.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Warwick.R, Hero)
        end
    },
    MonkeyKing = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.MonkeyKing.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.MonkeyKing.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.MonkeyKing.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.MonkeyKing.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.MonkeyKing.R, Hero)
        end
    },
    Xayah = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xayah.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xayah.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xayah.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xayah.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xayah.R, Hero)
        end
    },
    Xerath = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xerath.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xerath.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xerath.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xerath.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Xerath.R, Hero)
        end
    },
    XinZhao = {
        GetAADmg = function(self, Hero, HasInifityEdge)
            return AADmg(Hero, HasInifityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.XinZhao.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.XinZhao.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            local wDmg = 0
            wDmg = SpellDmg(SpellLib.XinZhao.W, Hero)
            return wDmg
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.XinZhao.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.XinZhao.R, Hero)
        end,
    },
    Yasuo = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yasuo.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yasuo.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yasuo.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yasuo.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yasuo.R, Hero)
        end
    },
    Yone = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yone.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yone.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yone.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yone.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yone.R, Hero)
        end
    },
    Yorick = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yorick.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yorick.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yorick.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yorick.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yorick.R, Hero)
        end
    },
    Yuumi = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yuumi.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yuumi.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yuumi.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yuumi.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Yuumi.R, Hero)
        end
    },
    Zac = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zac.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zac.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zac.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zac.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zac.R, Hero)
        end
    },
    Zed = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zed.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zed.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zed.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zed.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zed.R, Hero)
        end
    },
    Zeri = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zeri.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zeri.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zeri.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zeri.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zeri.R, Hero)
        end
    },
    Ziggs = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ziggs.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ziggs.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ziggs.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ziggs.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Ziggs.R, Hero)
        end
    },
    Zilean = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zilean.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zilean.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zilean.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zilean.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zilean.R, Hero)
        end
    },
    Zoe = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zoe.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zoe.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zoe.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zoe.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zoe.R, Hero)
        end
    },
    Zyra = {
        -- needs update
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zyra.Passive, Hero)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zyra.Q, Hero) 
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zyra.W, Hero) 
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zyra.E, Hero) 
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Zyra.R, Hero)
        end
    },
}

function DamageLib:GetDamageDrawingPositions(Dmg, PreviousDamageSum, CurrentHpDrawWidth, Target)
    local SimulatedHealth       = Target.Health - PreviousDamageSum
    local reducedHealth         = SimulatedHealth - Dmg

    if reducedHealth <= 0 then
        reducedHealth = 0
    end

    local damageDrawWidth   = CurrentHpDrawWidth - (CurrentHpDrawWidth * (reducedHealth / SimulatedHealth))
    local DamageStartPos    = CurrentHpDrawWidth - damageDrawWidth

    if DamageStartPos <= 0 then
        DamageStartPos = 0
    end

    return {
        DamageDrawWidth = damageDrawWidth,
        DamageStartPos = DamageStartPos,
    }
end

function DamageLib:GetFullHpDrawWidth()
    return 104
end

function DamageLib:GetHpDrawWidth(Target)
    local fullHpDrawWidth = self:GetFullHpDrawWidth()

    return fullHpDrawWidth * (Target.Health / Target.MaxHealth)
end

function DamageLib:DrawDamageIndicator(Damages, Target)
    if Target.IsDead == false then
        local fullHpDrawWidth       = self:GetFullHpDrawWidth()
        local hpDrawWidth           = self:GetHpDrawWidth(Target)
        local totalDamage           = 0
        local nextStartingPosX      = 0
        local currentHpDrawWidth    = hpDrawWidth

        local vecOut = Vector3.new()
        if Render:World2Screen(Target.Position, vecOut) then 
            Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 + self.DrawingsYAdjust.Value, fullHpDrawWidth, 6, Colors.GrayDark.R, Colors.GrayDark.G, Colors.GrayDark.B, 200)

            for _,DamageObject in pairs(Damages) do
                if DamageObject.Damage ~= nil and type(DamageObject.Damage) == "number" then
                    local damagePositions   = self:GetDamageDrawingPositions(DamageObject.Damage, totalDamage, currentHpDrawWidth, Target)

                    totalDamage             = totalDamage + DamageObject.Damage
                    currentHpDrawWidth      = currentHpDrawWidth - damagePositions.DamageDrawWidth

                    if currentHpDrawWidth <= 0 then
                        currentHpDrawWidth = 0
                    end

                    Render:DrawFilledBox(vecOut.x - 49 + damagePositions.DamageStartPos , vecOut.y - 180 + self.DrawingsYAdjust.Value, damagePositions.DamageDrawWidth, 6, DamageObject.Color.R, DamageObject.Color.G, DamageObject.Color.B, 240)
                end          
            end

            Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 + self.DrawingsYAdjust.Value, currentHpDrawWidth, 6, Colors.Green.R, Colors.Green.G, Colors.Green.B, 200)

            local KillCombo = "KILLABLE"
            local KillDraw = string.format("%.0f", totalDamage) .. " / " .. string.format("%.0f", Target.Health)

            if totalDamage < Target.Health then
                Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200 + self.DrawingsYAdjust.Value, Colors.GrayLight.R, Colors.GrayLight.G, Colors.GrayLight.B, 255)
            end
            if totalDamage > Target.Health then
                Render:DrawString(KillCombo, vecOut.x - 50 , vecOut.y - 220 + self.DrawingsYAdjust.Value, Colors.GrayLight.R, Colors.GrayLight.G, Colors.GrayLight.B, 255)
                Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200 + self.DrawingsYAdjust.Value, Colors.GrayLight.R, Colors.GrayLight.G, Colors.GrayLight.B, 255)
            end
        end
    end
end

function DamageLib:GetDamage(rawDmg, damageType, target, additionalArmorReduction)
    if target == nil then
        return rawDmg
    end

    local additionalReduction = 0

    if additionalArmorReduction == nil then
        additionalArmorReduction = 0
    end

    if myHero.ChampionName == "KogMaw" and BuffLib.KogMaw:CausticSpittle(target) then
        additionalReduction = SpellLib.KogMaw.Q:DmgModResistanceMod()
    end
    
    if damageType == DamageType.PHYSICALDAMAGE then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * HeroLvl() / 18)
        local realArmor = target.Armor * (myHero.ArmorPenMod + additionalReduction + additionalArmorReduction)
        local FinalArmor = (realArmor - Lethality)
		if FinalArmor < 0 then
			FinalArmor = 0
		end

        return (100 / (100 + FinalArmor)) * rawDmg 
    elseif damageType == DamageType.MAGICALDAMAGE then 
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * (myHero.MagicPenMod + additionalReduction)

        if realMR < 0 then
			realMR = 0
		end

        return (100 / (100 + realMR)) * rawDmg
    elseif damageType == DamageType.TRUEDAMAGE then
        return rawDmg        
    end
    return 0
end


function DamageLib:__init()
    self.DmgLibMenu = Menu:CreateMenu("DamageLib")
    self.DmgLibMisc = self.DmgLibMenu:AddSubMenu("Misc")
    self.DrawingsYAdjust = self.DmgLibMisc:AddSlider("Adjust position of healthbars", 4, -200, 200, 1)
    self:LoadSettings()
end

function DamageLib:SaveSettings()
	SettingsManager:CreateSettings("DamageLib")
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("DrawingsYAdjust", self.DrawingsYAdjust.Value)
end

function DamageLib:LoadSettings()
	SettingsManager:GetSettingsFile("DamageLib")
    self.DrawingsYAdjust.Value = SettingsManager:GetSettingsInt("Misc", "DrawingsYAdjust")
end

function DamageLib:OnLoad()
    AddEvent("OnSettingsSave" , function() DamageLib:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() DamageLib:LoadSettings() end)
    DamageLib:__init()
end

AddEvent("OnLoad", function() DamageLib:OnLoad() end)	