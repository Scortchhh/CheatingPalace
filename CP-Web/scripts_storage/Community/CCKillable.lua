local Killable = {}

--[[NEXT TO DO: 
-Fix rengar
-Kaisa
-More items/runes]]

function Killable:__init()
    self.KeyNames = {}
	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"
	
	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
    self.KeyNames[11]		= "HK_ITEM6"

    self.Count = 0

    self.ScriptVersion = "          --Killable Version: 0.8--"

    self.KillableMenu = Menu:CreateMenu("Killable (BETA)")
    -------------------------------------------
    if myHero.ChampionName == "Yone" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseW = self.Settings:AddCheckbox("Use W", 1)
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
        self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
        self.KillTime = self.Settings:AddSlider("X amount seconds calculated", 4, 1, 5, 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Kaisa" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UsePassive = self.Settings:AddCheckbox("Use Passive", 1)
        self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseEvolvedQ = self.Settings:AddCheckbox("Use Evolved Q", 1)
        self.UseW = self.Settings:AddCheckbox("Use W", 1)
        self.UseDoubleW = self.Settings:AddCheckbox("Use Double W when WEvolved", 1)
        self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Evelynn" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
        ---------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Jhin" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
        self.InfinityEdge = self.Settings:AddCheckbox("Do u have IE", 0)
        ---------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Ryze" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseDoubleQ = self.Settings:AddCheckbox("Use Double Q", 1)
        self.DoubleQLevel = self.Settings:AddSlider("double at level", 3, 1, 18, 1)
        self.UseTripleQ = self.Settings:AddCheckbox("Use Triple Q", 1)
        self.TripleQLevel = self.Settings:AddSlider("triple at level", 3, 1, 18, 1)
        self.UseQuadraQ = self.Settings:AddCheckbox("Use Quadra Q", 1)
        self.QuadraQLevel = self.Settings:AddSlider("quadra at level", 3, 1, 18, 1)
        self.UseW = self.Settings:AddCheckbox("Use W", 1)
        self.UseE = self.Settings:AddCheckbox("Use E", 1)
        self.UseDoubleE = self.Settings:AddCheckbox("Use Double E", 1)
        --self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
        --self.amountAA = self.Settings:AddSlider("Amount of AA's", 5, 1, 10, 1)
        --self.UseIgnite = self.Settings:AddCheckbox("Use Ignite", 1)
        --self.UseItems = self.Settings:AddCheckbox("Use Items", 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
        self.DebugRyzeQ = self.Drawings:AddCheckbox("Debug Ryze Q", 0)
    end
    -------------------------------------------
    if myHero.ChampionName == "Tristana" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        --self.UsePassive = self.Settings:AddCheckbox("Use Passive", 1)
        --self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseW = self.Settings:AddCheckbox("Use W", 1)
        self.UseDoubleW = self.Settings:AddCheckbox("Use Double W", 1)
        self.UseE = self.Settings:AddCheckbox("Use E", 1)
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
        self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
        self.amountAA = self.Settings:AddSlider("Amount of AA's", 5, 1, 10, 1)
        self.UseIgnite = self.Settings:AddCheckbox("Use Ignite", 1)
        self.UseItems = self.Settings:AddCheckbox("Use Items", 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Xerath" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    if myHero.ChampionName == "Twitch" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        --self.UsePassive = self.Settings:AddCheckbox("Use Passive", 1)
        --self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseE = self.Settings:AddCheckbox("Use E", 1)
        self.UseR = self.Settings:AddCheckbox("Use AA's in R", 1)
        --self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
        --self.amountAA = self.Settings:AddSlider("Amount of AA's", 5, 1, 10, 1)
        self.UseItems = self.Settings:AddCheckbox("Use items", 1)
        -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end
    -------------------------------------------
    --[[if myHero.ChampionName == "Rengar" then
        self.Settings = self.KillableMenu:AddSubMenu("Settings")
        --self.UsePassive = self.Settings:AddCheckbox("Use Passive", 1)
        self.UseQ = self.Settings:AddCheckbox("Use Q", 1)
        self.UseDoubleQ = self.Settings:AddCheckbox("Use Double Q", 1)
        self.UseTripleQ = self.Settings:AddCheckbox("Use Triple Q", 1)
        self.UseW = self.Settings:AddCheckbox("Use W", 1)
        --self.UseDoubleW = self.Settings:AddCheckbox("Use Double W", 1)
        self.UseE = self.Settings:AddCheckbox("Use E", 1)
        self.UseR = self.Settings:AddCheckbox("Use R", 1)
        --self.UseAA = self.Settings:AddCheckbox("Use AA", 1)
        --self.amountAA = self.Settings:AddSlider("Amount of AA's", 5, 1, 10, 1)
        self.UseIgnite = self.Settings:AddCheckbox("Use Ignite", 1)
        self.UseItems = self.Settings:AddCheckbox("Use Items", 1)
    -------------------------------------------
        self.Drawings = self.KillableMenu:AddSubMenu("Drawings")
        self.DrawKillable = self.Drawings:AddCheckbox("Draw KILLABLE", 1)
        self.DrawKillTime = self.Drawings:AddCheckbox("(Coming soon) Draw KillTime", 1)
    end]]

    self.Spells 			={}

    self.Spells['RyzeQ'] = { Type = 0, Range = 1000, Radius = 55, Speed = 1700, Delay = 0.25, CC = 0}
	
	Killable:LoadSettings()
end

function Killable:SaveSettings()
	SettingsManager:CreateSettings("CCKillable")
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DK", self.DrawKillable.Value)
end

function Killable:LoadSettings()
	SettingsManager:GetSettingsFile("CCKillable")
    -------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings", "DK")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Killable:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Killable:GetSummonerKey(SummonerName)
    for i = 4 , 5 do
        if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
            return self.KeyNames[i]
        end
    end
    return nil
end

function Killable:GetItemKey(ItemName)
	for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return self.KeyNames[i]
		end
	end
	return nil
end


function Killable:Ignite_Check()
    if self.UseIgnite.Value == 1 then
        self.IgniteKey                    = self:GetSummonerKey("SummonerDot")    
        if self.IgniteKey     ~= nil then
        return true
        end
    end
    return false
end

function Killable:Blade_Check()
	if self.UseItems.Value == 1 then
		self.BladeKey			= self:GetItemKey("ItemSwordOfFeastAndFamine")	
	    if self.BladeKey ~= nil then
        return true
        end
    end
    return false
end


function Killable:SkillCount()
    local SpellCount = 0
    local ActiveSpell = myHero.ActiveSpell
    local Info = self.Spells[ActiveSpell.Info.Name]
    if Info ~= nil and Info.Type == 0 then
        self.Count = self.Count + 1
        sleep()
    end
    if self.Count > 1 and self.Count < 35 then
        SpellCount = 1
    end
    if self.Count > 35 and self.Count < 65 then
        SpellCount = 2
    end
    if self.Count > 65 and self.Count < 95  then
        SpellCount = 3
    end
    if self.Count > 95 then
        SpellCount = 4
    end
    if GetMyLevel() == 1 and Engine:SpellReady("HK_SPELL1") then
        self.Count = 0
    end
    if GetMyLevel() == 2 and Engine:SpellReady("HK_SPELL1") then
        if Engine:SpellReady("HK_SPELL2") or Engine:SpellReady("HK_SPELL3") then
            self.Count = 0
        end
    end
    if Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL2") and Engine:SpellReady("HK_SPELL3") then
        self.Count = 0
    end
    return SpellCount
end

--[[function Killable:RengarEQDmg()
    local Dmg = {30,45,60,75,90,105,120,135,150,160,170,180,190,200,210,220,230,240}
    local Level = self:GetMyLevel()
    local QDmg = Dmg[Level]
    return QDmg
end

function Killable:RengarKillable(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Killable:GetDamage(30 * myHero:GetSpellSlot(0).Level * (TotalAD * myHero.GetSpellSlot(0).Level * 0.05) - 0.05 * TotalAD, true, Target)
    local EQDmg = Killable:GetDamage(self:RengarEQDmg() + TotalAD * 0.4, true, Target)
    local WDmg = Killable:GetDamage(20 + (30 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.8, false, Target)
    local EDmg = Killable:GetDamage(10 + (45 * myHero:GetSpellSlot(2).Level) + myHero.BonusAttack * 0.8, true, Target)
    local RDmg = Killable:GetDamage(TotalAD * 0.5, true, Target)
    local BoRKDmg = Killable:GetDamage(Target.Health * 0.195, true, Target)
    local IgniteDmg = 50 + (20 * GetMyLevel())
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self.UseDoubleQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if self.UseTripleQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    if self:Ignite_Check() and self.UseIgnite.Value == 1 then
        FinalFullDmg = FinalFullDmg + IgniteDmg
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:RengarDmgDraw(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Killable:GetDamage(30 * myHero:GetSpellSlot(0).Level * (TotalAD * myHero.GetSpellSlot(0).Level * 0.05) - 0.05 * TotalAD, true, Target)
    local EQDmg = Killable:GetDamage(self:RengarEQDmg() + TotalAD * 0.4, true, Target)
    local WDmg = Killable:GetDamage(20 + (30 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.8, false, Target)
    local EDmg = Killable:GetDamage(10 + (45 * myHero:GetSpellSlot(2).Level) + myHero.BonusAttack * 0.8, true, Target)
    local RDmg = Killable:GetDamage(TotalAD * 0.5, true, Target)
    local BoRKDmg = Killable:GetDamage(Target.Health * 0.195, true, Target)
    local IgniteDmg = 50 + (20 * GetMyLevel())
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self.UseDoubleQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if self.UseTripleQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    if self:Ignite_Check() and self.UseIgnite.Value == 1 then
        FinalFullDmg = FinalFullDmg + IgniteDmg
    end
    return FinalFullDmg
end]]

local function JhinDmgBoost()
    local DmgBoost 			    = {1.04,1.05,1.06,1.07,1.08,1.09,1.10,1.11,1.12,1.14,1.16,1.20,1.24,1.28,1.32,1.36,1.40,1.44}
    local Level 				= GetMyLevel()
    local Damage 				= DmgBoost[Level]
    if myHero.CritMod > 0 then
        Damage = Damage + myHero.CritMod * 100 * 0.004
    end
    if myHero.AttackSpeedMod > 0 then
        Damage = Damage + (myHero.AttackSpeedMod - 1) * 100 * 0.0025
    end
    return Damage
end

function Killable:JhinKillable(Target)
    local TotalAD = (myHero.BonusAttack + myHero.BaseAttack) * JhinDmgBoost()
    local BaseDmg = -25 + 75 * myHero:GetSpellSlot(3).Level + TotalAD * 0.2
    local RDmg1 = Killable:GetDamage((Target.MaxHealth - Target.Health) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg2 = Killable:GetDamage((Target.MaxHealth - Target.Health + RDmg1) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg3 = Killable:GetDamage((Target.MaxHealth - Target.Health + RDmg1 + RDmg2) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg4 = Killable:GetDamage(((Target.MaxHealth - Target.Health + RDmg1 + RDmg2 + RDmg3) / Target.MaxHealth * 3 * BaseDmg + BaseDmg) * 2, true, Target)
    local RDmg = RDmg1 + RDmg2 + RDmg3
    if self.InfinityEdge.Value == 1 then
        RDmg = RDmg + (RDmg4 * 1.25)
    end
    if self.InfinityEdge.Value == 0 then
        RDmg = RDmg + RDmg4
    end
    if RDmg > Target.Health then
        return true
    end
    return false
end

function Killable:JhinDmgDraw(Target)
    local TotalAD = (myHero.BonusAttack + myHero.BaseAttack) * JhinDmgBoost()
    local BaseDmg = -25 + 75 * myHero:GetSpellSlot(3).Level + TotalAD * 0.2
    local RDmg1 = Killable:GetDamage((Target.MaxHealth - Target.Health) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg2 = Killable:GetDamage((Target.MaxHealth - Target.Health + RDmg1) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg3 = Killable:GetDamage((Target.MaxHealth - Target.Health + RDmg1 + RDmg2) / Target.MaxHealth * 3 * BaseDmg + BaseDmg, true, Target)
    local RDmg4 = Killable:GetDamage(((Target.MaxHealth - Target.Health + RDmg1 + RDmg2 + RDmg3) / Target.MaxHealth * 3 * BaseDmg + BaseDmg) * 2, true, Target)
    local RDmg = RDmg1 + RDmg2 + RDmg3
    if self.InfinityEdge.Value == 1 then
        RDmg = RDmg + (RDmg4 * 1.1246)
    end
    if self.InfinityEdge.Value == 0 then
        RDmg = RDmg + RDmg4
    end
    return RDmg
end

function Killable:EvelynnKillable(Target)
    local RDmg = Killable:GetDamage(125 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.75, false, Target)
    if Target.Health < (Target.MaxHealth * 0.3) then
        RDmg = RDmg * 2.4
    end
    if RDmg > Target.Health then
        return true
    end
    return false
end

function Killable:EvelynnDmgDraw(Target)
    local RDmg = Killable:GetDamage(125 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.75, false, Target)
    if Target.Health < (Target.MaxHealth * 0.3) then
        RDmg = RDmg * 2.4
    end
    return RDmg
end

function Killable:YoneQCD()
    QCD = 0.25
    Speed = myHero.AttackSpeedMod
    if Speed > 0 and Speed < 15 then
        QCD = 0.25
    end
    if Speed > 14 and Speed < 30 then
        QCD = 0.27
    end
    if Speed > 29 and Speed < 45 then
        QCD = 0.30
    end
    if Speed > 44 and Speed < 60 then
        QCD = 0.34
    end
    if Speed > 59 and Speed < 75 then
        QCD = 0.39
    end
    if Speed > 74 and Speed < 90 then
        QCD = 0.45
    end
    if Speed > 89 and Speed < 105 then
        QCD = 0.54
    end
    if Speed > 104 and Speed < 111 then
        QCD = 0.67
    end
    if Speed > 110 then
        QCD = 0.75
    end
    return QCD
end


function Killable:YoneKillable(Target)
    local Crit = myHero.CritMod
    local QCrit = 1
    if Crit == 0 then
        QCrit = 1
    end
    if Crit > 0 and Crit < 1 then
        QCrit = Crit * 0.6 + 1
    end
    if Crit == 1 then
        QCrit = 1.8
    end
    local AACrit = 1
    if Crit == 0 then
        AACrit = 1
    end
    if Crit > 0 and Crit < 1 then
        AACrit = Crit * 0.8 + 1
    end
    if Crit == 1 then
        AACrit = 2.025
    end 
    --print("Autoattack Crit is:" .. AACrit)
    --print("Q Crit is:" .. QCrit)
    local AttackSpeed = myHero.AttackSpeedMod * 0.625 
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Killable:GetDamage((20 * myHero:GetSpellSlot(0).Level + TotalAD) * QCrit , true, Target)
    local WDmgAD = Killable:GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), true, Target)
    local WDmgAP = Killable:GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), false, Target)
    local RDmgAD = Killable:GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, true, Target)
    local RDmgAP = Killable:GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, false, Target)
    local AA = Killable:GetDamage( TotalAD * AACrit, true, Target)
    local AA2AD = Killable:GetDamage( TotalAD * AACrit * 0.5, true, Target)
    local AA2AP = Killable:GetDamage( TotalAD * AACrit * 0.5, false, Target)
    local FinalFullDmg = 0
    if self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + (QDmg * self:YoneQCD() * self.KillTime.Value)
    end
    if self.UseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WDmgAD + WDmgAP
    end
    if self.UseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + RDmgAD + RDmgAP
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + (AA * AttackSpeed * self.KillTime.Value * 0.5)
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + ((AA2AD + AA2AP) * AttackSpeed * self.KillTime.Value * 0.5)
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:YoneDmgDraw(Target)
    local Crit = myHero.CritMod
    local QCrit = 1
    if Crit == 0 then
        QCrit = 1
    end
    if Crit > 0 and Crit < 1 then
        QCrit = Crit * 0.6 + 1
    end
    if Crit == 1 then
        QCrit = 1.8
    end
    local AACrit = 1
    if Crit == 0 then
        AACrit = 1
    end
    if Crit > 0 and Crit < 1 then
        AACrit = Crit * 0.8 + 1
    end
    if Crit == 1 then
        AACrit = 2.025
    end 
    --print("Autoattack Crit is:" .. AACrit)
    --print("Q Crit is:" .. QCrit)
    local AttackSpeed = myHero.AttackSpeedMod * 0.625 
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Killable:GetDamage((20 * myHero:GetSpellSlot(0).Level + TotalAD) * QCrit , true, Target)
    local WDmgAD = Killable:GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), true, Target)
    local WDmgAP = Killable:GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), false, Target)
    local RDmgAD = Killable:GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, true, Target)
    local RDmgAP = Killable:GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, false, Target)
    local AA = Killable:GetDamage( TotalAD * AACrit, true, Target)
    local AA2AD = Killable:GetDamage( TotalAD * AACrit * 0.5, true, Target)
    local AA2AP = Killable:GetDamage( TotalAD * AACrit * 0.5, false, Target)
    local FinalFullDmg = 0
    if self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + (QDmg * self:YoneQCD() * self.KillTime.Value)
    end
    if self.UseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WDmgAD + WDmgAP
    end
    if self.UseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + RDmgAD + RDmgAP
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + (AA * AttackSpeed * self.KillTime.Value * 0.5)
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + ((AA2AD + AA2AP) * AttackSpeed * self.KillTime.Value * 0.5)
    end
    return FinalFullDmg
end

function Killable:KaisaKillable(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local AttackSpeed = myHero.AttackSpeedMod * 0.644 
    local QDmg = Killable:GetDamage(65 + (36 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.9) + (myHero.AbilityPower * 0.5625), true, Target)
    local EQDmg = Killable:GetDamage(42 + (25 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.6) + (myHero.AbilityPower * 0.375), true, Target)
    local WDmg = Killable:GetDamage(5 + (25 * myHero:GetSpellSlot(1).Level) + (TotalAD * 1.3) + (myHero.AbilityPower * 0.7), false, Target)
    local StackDmg = Killable:GetDamage((0.075 + (myHero.AbilityPower * 0.000125)) * Target.MaxHealth, false, Target)
    local AADmg = Killable:GetDamage((TotalAD * (myHero.CritMod + 1)), true, Target)
    local FullAADmg = (AttackSpeed * 3) * AADmg
    local FinalFullDmg = 0
    if self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
   if self.UseEvolvedQ.Value == 1 and myHero.BuffData:GetBuff("KaisaQEvolved").Valid then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self.UsePassive.Value == 1 then
        FinalFullDmg = FinalFullDmg + StackDmg
    end
    if self.UseDoubleW.Value == 1 and myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
        FinalFullDmg = FinalFullDmg + StackDmg + WDmg
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + FullAADmg
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:KaisaDmgDraw(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local AttackSpeed = myHero.AttackSpeedMod * 0.644 
    local QDmg = Killable:GetDamage(65 + (36 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.9) + (myHero.AbilityPower * 0.5625), true, Target)
    local EQDmg = Killable:GetDamage(42 + (25 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.6) + (myHero.AbilityPower * 0.375), true, Target)
    local WDmg = Killable:GetDamage(5 + (25 * myHero:GetSpellSlot(1).Level) + (TotalAD * 1.3) + (myHero.AbilityPower * 0.7), false, Target)
    local StackDmg = Killable:GetDamage((0.075 + (myHero.AbilityPower * 0.000125)) * Target.MaxHealth, false, Target)
    local AADmg = Killable:GetDamage((TotalAD * (myHero.CritMod + 1)), true, Target)
    local FullAADmg = (AttackSpeed * 3) * AADmg
    local FinalFullDmg = 0
    if self.UseQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self.UseEvolvedQ.Value == 1 and myHero.BuffData:GetBuff("KaisaQEvolved").Valid then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self.UsePassive.Value == 1 then
        FinalFullDmg = FinalFullDmg + StackDmg
    end
    if self.UseW.Value == 1 and myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
        FinalFullDmg = FinalFullDmg + StackDmg + WDmg
    end
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + FullAADmg
    end
    return FinalFullDmg
end
    

function Killable:RyzeBonusMana()
    local Mana = {300,336,373,413,454,497,542,588,637,687,738,792,847,904,963,1023,1086,1150}
    local Level = GetMyLevel()
    local BaseMana = Mana[Level]
    if Level == 0 then
        BaseMana = 300
    end
    local BonusMana = myHero.MaxMana - BaseMana
    return BonusMana
end

function Killable:RyzeKillable(Target)
    local QDmg = Killable:GetDamage(40 + (25 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.45 + self:RyzeBonusMana() * 0.03, false, Target)
    local EQDmg = QDmg * (1.1 + (0.3 * myHero:GetSpellSlot(3).Level))
    local WDmg = Killable:GetDamage(50 + (30 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.6 + self:RyzeBonusMana() * 0.04, false, Target)
    local EDmg = Killable:GetDamage(40 + (20 * myHero:GetSpellSlot(2).Level) + myHero.AbilityPower * 0.3 + self:RyzeBonusMana() * 0.02, false, Target)
    local FinalFullDmg = 0
    local Level = GetMyLevel()
    local SkillCount = self:SkillCount()
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 and SkillCount < 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 and SkillCount < 2 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self.UseDoubleQ.Value == 1 and SkillCount < 2 and Level >= self.DoubleQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self.UseTripleQ.Value == 1 and SkillCount < 3 and Level >= self.TripleQLevel.Value then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self.UseDoubleE.Value == 1 and SkillCount < 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self.UseQuadraQ.Value == 1 and SkillCount < 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 and SkillCount == 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 and SkillCount == 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end --Q>E>Q>W>Q>E>Q

function Killable:RyzeDmgDraw(Target)
    local QDmg = Killable:GetDamage(40 + (25 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.45 + self:RyzeBonusMana() * 0.03, false, Target)
    local EQDmg = QDmg * (1.1 + (0.3 * myHero:GetSpellSlot(3).Level))
    local WDmg = Killable:GetDamage(50 + (30 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.6 + self:RyzeBonusMana() * 0.04, false, Target)
    local EDmg = Killable:GetDamage(40 + (20 * myHero:GetSpellSlot(2).Level) + myHero.AbilityPower * 0.3 + self:RyzeBonusMana() * 0.02, false, Target)
    local FinalFullDmg = 0
    local Level = GetMyLevel()
    local SkillCount = self:SkillCount()
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 and SkillCount < 1 then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 and SkillCount < 2 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self.UseDoubleQ.Value == 1 and SkillCount < 2 and Level >= self.DoubleQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self.UseTripleQ.Value == 1 and SkillCount < 3 and Level >= self.TripleQLevel.Value then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self.UseDoubleE.Value == 1 and SkillCount < 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self.UseQuadraQ.Value == 1 and SkillCount < 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 and SkillCount == 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQ.Value == 1 and SkillCount == 4 and Level >= self.QuadraQLevel.Value then
        FinalFullDmg = FinalFullDmg + EQDmg
    end
    return FinalFullDmg
end --Q>E>Q>W>Q>E>Q

function Killable:TristanaKillable(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local WDmg = Killable:GetDamage(45 + (50 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 0.5), false, Target)
    local EDmg = Killable:GetDamage(132 + (22 * myHero:GetSpellSlot(2).Level) + ((myHero.BonusAttack * 0.55) + (myHero.BonusAttack * 0.55 * myHero:GetSpellSlot(2).Level)) + myHero.AbilityPower * 1.1, false, Target)
    local AADmg = Killable:GetDamage(self.amountAA.Value * TotalAD  * (myHero.CritMod + 1), true, Target)
    local BoRKDmg = Killable:GetDamage(self.amountAA.Value * Target.Health * 0.0325, true, Target)
    local RDmg = Killable:GetDamage(200 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 100), false, Target)
    local IgniteDmg = 50 + (20 * GetMyLevel())
    local FinalFullDmg = 0
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + AADmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseDoubleW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    if self:Ignite_Check() and self.UseIgnite.Value == 1 then
        FinalFullDmg = FinalFullDmg + IgniteDmg
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:TristanaDmgDraw(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local WDmg = Killable:GetDamage(45 + (50 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 0.5), false, Target)
    local EDmg = Killable:GetDamage(132 + (22 * myHero:GetSpellSlot(2).Level) + ((myHero.BonusAttack * 0.55) + (myHero.BonusAttack * 0.55 * myHero:GetSpellSlot(2).Level)) + myHero.AbilityPower * 1.1, false, Target)
    local AADmg = Killable:GetDamage(self.amountAA.Value * TotalAD  * (myHero.CritMod + 1), true, Target)
    local BoRKDmg = Killable:GetDamage(self.amountAA.Value * Target.Health * 0.0325, true, Target)
    local RDmg = Killable:GetDamage(200 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 100), false, Target)
    local IgniteDmg = 50 + (20 * GetMyLevel())
    local FinalFullDmg = 0
    if self.UseAA.Value == 1 then
        FinalFullDmg = FinalFullDmg + AADmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseDoubleW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    if self:Ignite_Check() and self.UseIgnite.Value == 1 then
        FinalFullDmg = FinalFullDmg + IgniteDmg
    end
    return FinalFullDmg
end

function Killable:XerathRKillable(Target)
    local RDmg = Killable:GetDamage(150 + (50 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.45), false, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg * 3
    end
    if Engine:SpellReady("HK_SPELL4") and myHero:GetSpellSlot(3).Level == 2 and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if Engine:SpellReady("HK_SPELL4") and myHero:GetSpellSlot(3).Level == 3 and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg * 2
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:XerathRDmgDraw(Target)
    local RDmg = Killable:GetDamage(150 + (50 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.45), false, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg * 3
    end
    if Engine:SpellReady("HK_SPELL4") and myHero:GetSpellSlot(3).Level == 2 and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if Engine:SpellReady("HK_SPELL4") and myHero:GetSpellSlot(3).Level == 3 and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RDmg * 2
    end
    return FinalFullDmg
end

function Killable:TwitchRKillable(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QSpeed = 0.25 + (0.05 * myHero:GetSpellSlot(0).Level)
    local AttackSpeed = (myHero.AttackSpeedMod + QSpeed) * 0.679 
    local RAADmg = Killable:GetDamage((TotalAD + 10 + (10 * myHero:GetSpellSlot(3).Level) * (myHero.CritMod + 1)), true, Target)
    local RFullDmg = (AttackSpeed * 5) * RAADmg
    local BoRKDmg = Killable:GetDamage((AttackSpeed * 5) * Target.Health * 0.0325, true, Target)
    local EDmg = Killable:GetDamage(70 + (40 * myHero:GetSpellSlot(2).Level) + (myHero.BonusAttack * 2.1), true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RFullDmg
    end
    if self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Killable:TwitchRDmgDraw(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QSpeed = 0.25 + (0.05 * myHero:GetSpellSlot(0).Level)
    local AttackSpeed = (myHero.AttackSpeedMod + QSpeed) * 0.679 
    local RAADmg = Killable:GetDamage((TotalAD + 10 + (10 * myHero:GetSpellSlot(3).Level) * (myHero.CritMod + 1)), true, Target)
    local RFullDmg = (AttackSpeed * 5) * RAADmg
    local BoRKDmg = Killable:GetDamage((AttackSpeed * 5) * Target.Health * 0.0325, true, Target)
    local EDmg = Killable:GetDamage(70 + (40 * myHero:GetSpellSlot(2).Level) + (myHero.BonusAttack * 2.1), true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL4") and self.UseR.Value == 1 then
        FinalFullDmg = FinalFullDmg + RFullDmg
    end
    if self.UseE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if self:Blade_Check() == true and self.UseItems.Value == 1 then
        FinalFullDmg = FinalFullDmg + BoRKDmg
    end
    return FinalFullDmg
end

--function Killable:AkaliComboI(Target)
--    local qDmg = Akali:GetDamage(5 + (25 * myHero:GetSpellSlot(0).Level) + 0.65 * (myHero.BaseAttack + myHero.BonusAttack) + 0.65 * myHero.AbilityPower, false, Target) * 2
--    local eDmg = Akali:GetDamage(15 + (35 * myHero:GetSpellSlot(2).Level) + 0.35 * (myHero.BaseAttack + myHero.BonusAttack) + 0.5 * myHero.AbilityPower, true, Target)
--    local FinalFullDmg = qDmg + eDmg
--    if FinalFullDmg > Target.Health then
--        return true
--    end
--    return false
--end

--function Killable:AkaliComboII(Target)
--    local qDmg = Akali:GetDamage(5 + (25 * myHero:GetSpellSlot(0).Level) + 0.65 * (myHero.BaseAttack + myHero.BonusAttack) + 0.65 * myHero.AbilityPower, false, Target) * 2
--    local eDmg = Akali:GetDamage(15 + (35 * myHero:GetSpellSlot(2).Level) + 0.35 * (myHero.BaseAttack + myHero.BonusAttack) + 0.5 * myHero.AbilityPower, true, Target)
--    local rDmg = Akali:GetDamage(25 + (100 * myHero:GetSpellSlot(3).Level) + 0.5 * myHero.BonusAttack, true, Target)
--    local r2Dmg = Akali:GetDamage(5 + (70 * myHero:GetSpellSlot(3).Level) + 0.3 * myHero.AbilityPower, false, Target)
--    local FinalFullDmg = qDmg + eDmg + rDmg + r2Dmg
--    if FinalFullDmg > Target.Health then
--        return true
--    end
--    return false
--end

--local Ignite				= self:Ignite_Check()
--if self.UseIgnite.Value 	== 1 and Ignite 		~= false and Orbwalker.Attack == 0 then
    --Engine:CastSpell(Ignite.Key,Ignite.Target.Position,1)
    --return
--end	

function Killable:OnTick()
    --print(myHero.AttackSpeedMod * 0.679)
    if myHero.ChampionName == "Ryze" then
        if self.DebugRyzeQ.Value == 1 then
            print(self:SkillCount())
            print(self.Count)
        end
    end
end

function Killable:DrawFullCombo(Target)

    local CurrentCombo = " "
    local targetHP = Target.Health
    local CurrentHP = " "
    local CurrentDmg = " "

    --[[if myHero.ChampionName == "Rengar" then
        if self:RengarKillable(Target) then
            CurrentCombo = "KILLABLE"
        end
        CurrentHP = targetHP
        CurrentDmg = self:RengarDmgDraw(Target)
    end]]

    if myHero.ChampionName == "Yone" then
        if self:YoneKillable(Target) then
            CurrentCombo = "KILLABLE (" .. self.KillTime.Value .. "s)"
        end
        CurrentHP = targetHP
        CurrentDmg = self:YoneDmgDraw(Target)
    end

    if myHero.ChampionName == "Jhin" then
        if self:JhinKillable(Target) then
            CurrentCombo = "KILLABLE/R"
        end
        CurrentHP = targetHP
        CurrentDmg = self:JhinDmgDraw(Target)
    end

    if myHero.ChampionName == "Evelynn" then
        if self:EvelynnKillable(Target) then
            CurrentCombo = "KILLABLE/R"
        end
        CurrentHP = targetHP
        CurrentDmg = self:EvelynnDmgDraw(Target)
    end

    if myHero.ChampionName == "Kaisa" then
        if self:KaisaKillable(Target) then
            CurrentCombo = "KILLABLE (3s)"
        end
        CurrentHP = targetHP
        CurrentDmg = self:KaisaDmgDraw(Target)
    end

    if myHero.ChampionName == "Ryze" then
        if self:RyzeKillable(Target) then
            CurrentCombo = "KILLABLE"
        end
        CurrentHP = targetHP
        CurrentDmg = self:RyzeDmgDraw(Target)
    end

    if myHero.ChampionName == "Tristana" then
        if self:TristanaKillable(Target) then
            CurrentCombo = "KILLABLE"
        end
        CurrentHP = targetHP
        CurrentDmg = self:TristanaDmgDraw(Target)
    end

    if myHero.ChampionName == "Xerath" then
        if self:XerathRKillable(Target) then
            CurrentCombo = "KILLABLE/R"
        end
        CurrentHP = targetHP
        CurrentDmg = self:XerathRDmgDraw(Target)
    end

    if myHero.ChampionName == "Twitch" then
        if self:TwitchRKillable(Target) then
            CurrentCombo = "KILLABLE"
        end
        CurrentHP = targetHP
        CurrentDmg = self:TwitchRDmgDraw(Target)
    end

    --if myHero.ChampionName == "Akali" then
    --    if self:AkaliComboI(Target) then
    --        CurrentCombo = "2XQ>E>2XAA"
    --    else
    --        CurrentCombo = "2XQ>E>2XAA>2XR"
    --    end
    --end

    local KillCombo = CurrentCombo
    local KillDraw = string.format("%.0f", CurrentDmg) .. " / " .. string.format("%.0f", CurrentHP)
	
	local vecOut = Vector3.new()
    if Render:World2Screen(Target.Position, vecOut) and CurrentDmg > CurrentHP then
        --Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 141 , 105,  3, 92, 255, 5, 255)
        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 135 , 92, 255, 5, 255)
    end
    if Render:World2Screen(Target.Position, vecOut) then
        Render:DrawString(KillCombo, vecOut.x - 40 , vecOut.y - 175 , 92, 255, 5, 255)
    end
    if Render:World2Screen(Target.Position, vecOut) and CurrentDmg < CurrentHP then
        --Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 141 , 105,  3, 92, 255, 5, 255)
        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 135 , 248, 252, 3, 255)
	end
end

function Killable:OnDraw()
    if myHero.ChampionName == "Tristana" or myHero.ChampionName == "Ryze" or myHero.ChampionName == "Kaisa" or myHero.ChampionName == "Yone" then
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team then
			    if self.DrawKillable.Value == 1 then
				    if Hero.IsTargetable then
                        self:DrawFullCombo(Hero)
				    end
			    end
            end
        end
    end

    if myHero.ChampionName == "Xerath" or myHero.ChampionName == "Evelynn" or myHero.ChampionName == "Jhin" then
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team then
                if self.DrawKillable.Value == 1 and Engine:SpellReady("HK_SPELL4") then
                    if Hero.IsTargetable then
                        self:DrawFullCombo(Hero)
                    end
			    end
            end
        end
    end

    if myHero.ChampionName == "Twitch" then
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team then
                if self.DrawKillable.Value == 1 then
                    if Engine:SpellReady("HK_SPELL3") or Engine:SpellReady("HK_SPELL4") then
                        if Hero.IsTargetable then
                            self:DrawFullCombo(Hero)
                        end
                    end
			    end
            end
        end
    end

    --if myHero.ChampionName == "Akali" then
    --    local Heros = ObjectManager.HeroList
    --    for I, Hero in pairs(Heros) do
    --        if Hero.Team ~= myHero.Team then
    --            if self.DrawKillable.Value == 1 then
    --                if self:AkaliComboII(Hero) then
    --                    if Hero.IsTargetable then
    --                        self:DrawFullCombo(Hero)
    --                    end
	--			      end
	--  		  end
    --        end
    --    end
    --end
end

function Killable:OnLoad()
    AddEvent("OnSettingsSave" , function() Killable:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Killable:LoadSettings() end)

	Killable:__init()
	AddEvent("OnTick", function() Killable:OnTick() end)
    AddEvent("OnDraw", function() Killable:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Killable:OnLoad() end)