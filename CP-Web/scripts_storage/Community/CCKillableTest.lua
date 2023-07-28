local Killable = {}

--[[NEXT TO DO: POSSIBLE ITEMS TO ADD (BLADE OF THE RUINED KING FOR TWITCH) AND RENGAR!!]]

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

    self.ScriptVersion = "          --Killable Version: 0.301--"

    self.KillableMenu = Menu:CreateMenu("Killable (BETA)")
    -------------------------------------------
    if myHero.ChampionName == "Rengar" then
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
        local realMR = target.MagicResist * myHero.MagicPenMod
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

function Killable:RengarEQDmg()
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
end

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
    local RAADmg = Killable:GetDamage((TotalAD + 10 + (10 * myHero:GetSpellSlot(3).Level) * (myHero.CritMod + 1)), true, Target)
    local RFullDmg = (myHero.AttackSpeedMod * 5) * RAADmg
    local BoRKDmg = Killable:GetDamage((myHero.AttackSpeedMod * 5) * Target.Health * 0.0325, true, Target)
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
    local RAADmg = Killable:GetDamage((TotalAD + 10 + (10 * myHero:GetSpellSlot(3).Level) * (myHero.CritMod + 1)), true, Target)
    local RFullDmg = (myHero.AttackSpeedMod * 5) * RAADmg
    local BoRKDmg = Killable:GetDamage((myHero.AttackSpeedMod * 5) * Target.Health * 0.0325, true, Target)
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
end

function Killable:DrawFullCombo(Target)

    local CurrentCombo = " "
    local targetHP = Target.Health
    local CurrentHP = " "
    local CurrentDmg = " "

    if myHero.ChampionName == "Rengar" then
        if self:RengarKillable(Target) then
            CurrentCombo = "KILLABLE"
        end
        CurrentHP = targetHP
        CurrentDmg = self:RengarDmgDraw(Target)
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
    if myHero.ChampionName == "Tristana" or myHero.ChampionName == "Rengar" then
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
    if myHero.ChampionName == "Xerath" then
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