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
    end

    local totalDamage = spellDmg + pressTheAttackDmg + (spellDmgModAD * spellDmgModADBase) + (spellDmgModAP * spellDmgModAPBase) + (spellDmgModHP * spellDmgModHPBase) * (1 + additionalCrit)
    return DamageLib:GetDamage(totalDamage, SpellObject.DamageType, Target)
end

local function AADmg(Target, HasInfinityEdge)
    local bonuscritDamage       = 0
    local krakenSlayerDmg       = 0
    local pressTheAttackDmg     = 0

    if BuffLib.Items:KrakenSlayer(myHero) then
        krakenSlayerDmg = SpellDmg(ItemLib.KrakenSlayer, Target)
    end

    if HasInfinityEdge ~= nil and HasInfinityEdge then
        bonuscritDamage = bonuscritDamage + ItemLib.InfinityEdge:CritDmgMod()
    end

    local rawDmg = (myHero.BaseAttack + myHero.BonusAttack) * (1 + (myHero.CritMod * (0.75 + bonuscritDamage))) + pressTheAttackDmg
    return DamageLib:GetDamage(rawDmg, DamageType.PHYSICALDAMAGE, Target) + krakenSlayerDmg
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
            return SpellDmg(SpellLib.Tristana.E1, Hero) + SpellDmg(SpellLib.Tristana.E2, Hero) + SpellDmg(SpellLib.Tristana.EStack, Hero) * Stacks
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Tristana.R, Hero)
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
        GetQDmg = function(self, Hero, WillCollide)
            if WillCollide and not(BuffLib.Caitlyn:Trapped(Hero)) then
                return SpellDmg(SpellLib.Caitlyn.Q2, Hero)
            end
            return SpellDmg(SpellLib.Caitlyn.Q1, Hero)
        end,
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.Caitlyn.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.Caitlyn.R, Hero)
        end
    },
    Twitch = {
        GetAADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetPassiveDmg = function(self, Hero, Stacks)
            return (SpellDmg(SpellLib.Twitch.PassiveStack, Hero) * Stacks) * 6
        end,
        GetEDmg = function(self, Hero, Stacks)
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
        GetEDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.E, Hero)
        end,
        GetRDmg = function(self, Hero)
            return SpellDmg(SpellLib.KogMaw.R, Hero)
        end,
    },
    Kindred = {
        AADmg = function(self, Hero, HasInfinityEdge)
            return AADmg(Hero, HasInfinityEdge)
        end,
        GetQDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.Q, Hero)
        end,
        GetWDmg = function(self, Hero)
            return SpellDmg(SpellLib.Kindred.W, Hero)
        end,
        GetEDmg = function(self, Hero, HasInfinityEdge)
            local wolfEntranceThreshold = 0.15 + 0.005 * myHero.CritMod
            local wolfDmg = 0

            if Hero.Health / Hero.MaxHealth < wolfEntranceThreshold then
                wolfDmg =  SpellDmg(SpellLib.Kindred.EWolf, Hero) 
                if HasInfinityEdge then
                    wolfDmg = wolfDmg + SpellDmg(SpellLib.Kindred.EWolfInfinityEdge, Hero)
                end
            end

            return SpellDmg(SpellLib.Kindred.E, Hero) + wolfDmg
        end,
    }
}

function DamageLib:GetDamageDrawingPositions(Dmg, CurrentHpDrawWidth, Target)
    local hpDrawWidth       = CurrentHpDrawWidth
    local damageDrawWidth   = hpDrawWidth - hpDrawWidth * ((Target.Health - Dmg) / Target.Health)
    local DamageStartPos    = hpDrawWidth - damageDrawWidth

    if hpDrawWidth - damageDrawWidth <= 0 then
        DamageStartPos = 0
    end

    if damageDrawWidth >= CurrentHpDrawWidth then
        damageDrawWidth = CurrentHpDrawWidth
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
            Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 + self.DrawingsYAdjust.Value, hpDrawWidth, 6, Colors.Green.R, Colors.Green.G, Colors.Green.B, 200)

            for _,DamageObject in pairs(Damages) do
                if DamageObject.Damage ~= nil and type(DamageObject.Damage) == "number" then
                    local damagePositions   = self:GetDamageDrawingPositions(DamageObject.Damage, currentHpDrawWidth, Target)
                    totalDamage             = totalDamage + DamageObject.Damage
                    currentHpDrawWidth      = currentHpDrawWidth - damagePositions.DamageDrawWidth

                    if currentHpDrawWidth <= 0 then
                        currentHpDrawWidth = 0
                    end

                    Render:DrawFilledBox(vecOut.x - 49 + damagePositions.DamageStartPos , vecOut.y - 180 + self.DrawingsYAdjust.Value, damagePositions.DamageDrawWidth, 6, DamageObject.Color.R, DamageObject.Color.G, DamageObject.Color.B, 240)
                end          
            end

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

function DamageLib:GetDamage(rawDmg, damageType, target)
    local additionalReduction = 0

    if myHero.ChampionName == "KogMaw" and BuffLib.KogMaw:CausticSpittle(target) then
        additionalReduction = SpellLib.KogMaw.Q:DmgModResistanceMod()
    end
    
    if damageType == DamageType.PHYSICALDAMAGE then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * HeroLvl() / 18)
        local realArmor = target.Armor * (myHero.ArmorPenMod + additionalReduction)
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