local Varus = {}

function Varus:__init()

    self.QCast = false
    self.QMaxRange = 1625
    self.QChargeRange = 925
    --self.WRange = math.huge
    self.ERange = 925
    self.RRange = 1075

    self.QSpeed = 1850
    --self.WSpeed = math.huge
    self.ESpeed = 1500
    self.RSpeed = 1850

    self.QDelay = 0
    --self.WDelay = math.huge
    self.EDelay = 0.25
    self.RDelay = 0.25

    self.QRadius = 70
    --self.WRadius = 0
    self.ERadius = 260
    self.RRadius = 120

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ScriptVersion = "        **CCVarus Version: 0.3 (BETA)**"

    self.ChampionMenu = Menu:CreateMenu("Varus")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboWSlider = self.Combomenu:AddSlider("Use Q/E when X stacks", 3, 0, 3, 1)
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.QSettings = self.Combomenu:AddSubMenu("Q Settings")
    self.ComboKSQ = self.QSettings:AddCheckbox("Use KS Q in combo", 1)
    self.ComboW = self.QSettings:AddCheckbox("Use W active if Killable with KS", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ESettings = self.Combomenu:AddSubMenu("E Settings")
    self.ComboKSE = self.ESettings:AddCheckbox("Use KS E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)
    self.SingleR = self.Combomenu:AddCheckbox("(BETA) Single R if enemy Killable", 1)
    self.SingleRHP = self.Combomenu:AddSlider("Single R if you are under % hp", 40, 1, 100, 1)
    self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
--[[    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)]]
    -------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
    
	Varus:LoadSettings()
end

function Varus:SaveSettings()
	SettingsManager:CreateSettings("CCVarus")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("KSQ", self.ComboKSQ.Value)
    SettingsManager:AddSettingsInt("CWStack", self.ComboWSlider.Value)
    SettingsManager:AddSettingsInt("KSW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("KSE", self.ComboKSE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("SR", self.SingleR.Value)
    SettingsManager:AddSettingsInt("SRHP", self.SingleRHP.Value)
    SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
 --[[   SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)]]
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Varus:LoadSettings()
	SettingsManager:GetSettingsFile("CCVarus")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboKSQ.Value = SettingsManager:GetSettingsInt("Combo", "KSQ")
    self.ComboWSlider.Value = SettingsManager:GetSettingsInt("Combo", "CWStack")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "KSW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboKSE.Value = SettingsManager:GetSettingsInt("Combo", "KSE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.SingleR.Value = SettingsManager:GetSettingsInt("Combo", "SR")
    self.SingleRHP.Value = SettingsManager:GetSettingsInt("Combo", "SRHP")
    self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass", "HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass", "HQM")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass", "HE")
    self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass", "HEM")
    -------------------------------------------
--[[    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")]]
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Varus:GetDamage(rawDmg, isPhys, target)
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

function Varus:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Varus:CastingQ()
	local QStartTime = myHero:GetSpellSlot(0).StartTime
	local QChargeTime = GameClock.Time - QStartTime
	local QCharge = myHero.ActiveSpell.Info.Name	
	if QCharge == "VarusQ" then
		self.QChargeRange = 925.0 + (350*QChargeTime)
		if self.QChargeRange < 925 then self.QChargeRange = 925 end
		if self.QChargeRange > 1625 then self.QChargeRange = 1625 end
	else
		self.QChargeRange = 925.0
		self.QCast = false
	end
	if Engine:IsKeyDown("HK_SPELL1") == true and Engine:SpellReady("HK_SPELL1") == false then
		Engine:ReleaseSpell("HK_SPELL1", nil)
		self.QCast = false
	end
end
--VarusQLaunch
--VarusQ

function Varus:DmgDistance(Target, Dmg)
    if GetDist(myHero.Position, Target.Position) >= 1300 then
        Dmg = Dmg * 1.5
    end
    if GetDist(myHero.Position, Target.Position) < 1300 then
        Dmg = Dmg
    end
    return Dmg
end

function Varus:MissingHealthW()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    local WDmg = 0
    if totalLevel >= 0 and totalLevel < 4 then
        WDmg = 0.06
    end
    if totalLevel > 3 and totalLevel < 7 then
        WDmg = 0.08
    end
    if totalLevel > 6 and totalLevel < 10 then
        WDmg = 0.10
    end
    if totalLevel > 9 and totalLevel < 13 then
        WDmg = 0.12
    end
    if totalLevel > 12 then
        WDmg = 0.14
    end
    return WDmg
end

function Varus:KillableR(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local EDmg = Varus:GetDamage(10 + (40 * myHero:GetSpellSlot(2).Level) + myHero.BonusAttack * 0.6, true, Target)
    local RDmg = Varus:GetDamage(100 + (50 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower, false, Target)
    local W3Stack = Varus:GetDamage((0.075 + (0.015 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 0.0006)) * Target.MaxHealth, false, Target)
    local AADmg = Varus:GetDamage((TotalAD * (myHero.CritMod + 1)) * 4, true, Target)
    local QDmg = Varus:GetDamage(-26.66 + (36.66 * myHero:GetSpellSlot(0).Level) + (TotalAD * (0.8 + (0.0333 * myHero:GetSpellSlot(0).Level))), true, Target)
    local WDmg = Varus:GetDamage((Target.MaxHealth - (Target.Health - EDmg - RDmg - (W3Stack * 2) - AADmg)) * self:MissingHealthW(), false, Target)
    local TotalDmg = AADmg + W3Stack * 2
    if Engine:SpellReady("HK_SPELL1") then
        TotalDmg = TotalDmg + QDmg
    end
    if Engine:SpellReady("HK_SPELL2") then
        TotalDmg = TotalDmg + WDmg
    end
   if Engine:SpellReady("HK_SPELL3") then
        TotalDmg = TotalDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL4") then
        TotalDmg = TotalDmg + RDmg
    end
    if TotalDmg > Target.Health then
        return true
    end
    return false
end

function Varus:MaxQDmg(Target)
    local WdeBuff = Target.BuffData:GetBuff("VarusWDebuff")
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Varus:GetDamage((-26.66 + (36.66 * myHero:GetSpellSlot(0).Level) + (TotalAD * (0.8 + (0.0333 * myHero:GetSpellSlot(0).Level)))) * 1.45, true, Target)
    local WDmg = Varus:GetDamage((Target.MaxHealth - Target.Health) * self:MissingHealthW() * 1.45, false, Target)
    local WStack = Varus:GetDamage((0.025 + (0.005 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 0.0002)) * Target.MaxHealth * WdeBuff.Count_Alt, false, Target)
    local TotalDmg = WStack
    if Engine:SpellReady("HK_SPELL1") then
        TotalDmg = TotalDmg + QDmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        TotalDmg = TotalDmg + WDmg
    end
    return TotalDmg
end

function Varus:EDmg(Target)
    local EDmg = Varus:GetDamage(10 + (40 * myHero:GetSpellSlot(2).Level) + myHero.BonusAttack * 0.6, true, Target)
    return EDmg
end

function Varus:Killsteal()
    if self.ComboKSE.Value == 1 and Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if self:EDmg(target) > target.Health then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.ERadius, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboKSE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if (self:MaxQDmg(target) + self:EDmg(target)) > target.Health then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.ERadius, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self.ComboKSQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
        if target then
            if self:MaxQDmg(target) > target.Health then
                Engine:CastSpell("HK_SPELL2", nil, 1)
            end
        end
    end
    
    if self.ComboKSQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
        if target then
            if self:MaxQDmg(target) > target.Health then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if GetDist(StartPos, CastPos) < self.QChargeRange-200 then
                        Engine:ReleaseSpell("HK_SPELL1", CastPos)
                        return
                    end
                    if self.QCast == false then
                        Engine:ChargeSpell("HK_SPELL1")
                        self.QCast = true
                        return
                    end
                end
            end
        end
    end
end

function Varus:SingleTargetR()
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") and self.SingleR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            if (self:MaxQDmg(target) + self:EDmg(target)) > target.Health then return end
            if myHero.Health <= myHero.MaxHealth / 100 * self.SingleRHP.Value then
                if self:KillableR(target) then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RRadius, self.RDelay, 0, true, self.RHitChance, 1)
                    if PredPos then
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    end
                end
            end
        end
    end
end

function Varus:Combo()
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            if EnemiesInRange(target.Position, 550) >= self.REnemies.Value then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RRadius, self.RDelay, 0, true, self.RHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL4", PredPos, 1)
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3")then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            local WdeBuff = target.BuffData:GetBuff("VarusWDebuff")
            local WStacks = self.ComboWSlider.Value
            if WdeBuff.Count_Alt >= WStacks then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.ERadius, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                        Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
        if target then
            local WdeBuff = target.BuffData:GetBuff("VarusWDebuff")
            local WStacks = self.ComboWSlider.Value
            if WdeBuff.Count_Alt >= WStacks then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if GetDist(StartPos, CastPos) < self.QChargeRange-200 then
                        Engine:ReleaseSpell("HK_SPELL1", CastPos)
                        return
                    end
                    if self.QCast == false then
                        Engine:ChargeSpell("HK_SPELL1")
                        self.QCast = true
                        return
                    end
                end
            end
        end
    end	
end

function Varus:Harass()
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3")then
        if myHero.Mana <= myHero.MaxMana * self.HarassEMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.ERadius, self.EDelay, 0, true, self.EHitChance, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
        if target then
            local StartPos 	= myHero.Position
            local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
            if CastPos ~= nil then
                if GetDist(StartPos, CastPos) < self.QChargeRange-200 then
                    Engine:ReleaseSpell("HK_SPELL1", CastPos)
                    return
                end
                if self.QCast == false then
                    Engine:ChargeSpell("HK_SPELL1")
                    self.QCast = true
                    return
                end
            end
        end
    end	
end

function Varus:Laneclear()
    --Just Do It URSELF!!
end

function Varus:OnTick()
    Varus:CastingQ()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Varus:Combo()
            Varus:SingleTargetR()
            Varus:Killsteal()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Varus:Harass()
            return
        end
        --[[if Engine:IsKeyDown("HK_LANECLEAR") then
            Varus:Laneclear()
            return
        end]]
    end
end

function Varus:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMaxRange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 0, 255, 255)
    end
end

function Varus:OnLoad()
    if(myHero.ChampionName ~= "Varus") then return end
    AddEvent("OnSettingsSave" , function() Varus:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Varus:LoadSettings() end)

	Varus:__init()
	AddEvent("OnTick", function() Varus:OnTick() end)
    AddEvent("OnDraw", function() Varus:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Varus:OnLoad() end)