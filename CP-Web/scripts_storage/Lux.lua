--Credits to Critic, Scortch, Christoph
require("SupportLib")
Lux = {} 
function Lux:__init() 
    self.QRange = 1240 --140
    self.WRange = 1175 --220
    self.ERange = 1100 --310
    self.RRange = 3400 -- 200

    self.QSpeed = 1200
    self.WSpeed = 2400
    self.ESpeed = 1200
    self.RSpeed = math.huge

    self.QWidth = 140
    self.EWidth = 310
    self.RWidth = 200

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.EDelay = 0.25
    self.RDelay = 1

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2
    
    self.ScriptVersion = "         Lux Ver: 2" 
    self.ChampionMenu = Menu:CreateMenu("Lux") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R to KS", 1) 
    self.ComboMenu:AddLabel("HP % for W Shield:")
	self.WTargets		= {}
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    self.LClearSlider = self.LClearMenu:AddSlider("Use E ability on x minions", 3,1,5,1) 
    -------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw if killable", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Lux:LoadSettings()  
end 
function Lux:SaveSettings() 
    SettingsManager:CreateSettings("Lux")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R to KS", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    SettingsManager:AddSettingsInt("Use E ability on x minions", self.LClearSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw if killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end
function Lux:LoadSettings()
    SettingsManager:GetSettingsFile("Lux")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R to KS")
    --------------------------------------------
    --------------------------------Harass load----------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use E ability on x minions")
    --------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
end
local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end
local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end
local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end
function unpack (t, i)
    i = i or 1
    if t[i] ~= nil then
      return t[i], unpack(t, i + 1)
    end
end
local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Lux:TargetIsImmune(Target)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "WillRevive", "SionPassiveZombie", "rebirthready", "willrevive", "ZileanR", "gwenw_gweninsidew"
    }
    for i = 1, #ImmuneBuffs do
        local Buffname = ImmuneBuffs[i]
        local Buff = Target.BuffData:GetBuff(Buffname)
		if Buff.Count_Alt > 0 then
			return true
		end
    end
	return false
end

local function MinionsInRange(Position, Range)
	local Count = 0 
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

local function EnemiesInRange(Position, Range)
	local Count = 0 
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

function Lux:Damage(Target)
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {80, 125, 170, 215, 260}
        Qbonus = (myHero.AbilityPower * 0.6)
        QQdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
    end

    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {70, 120, 170, 220, 270}
        Ebonus = (myHero.AbilityPower * 0.7)
        EEdmg = GetDamage(EDamage[ELevel] + Ebonus, false, Target)
    end


    local RLevel = myHero:GetSpellSlot(3).Level
    local RDamage
    local Rbonus
    local RRdmg
    if RLevel ~= 0 then
        RDamage = {300, 400, 500}
        Rbonus = (myHero.AbilityPower * 1)
        RRdmg = GetDamage(RDamage[RLevel] + Rbonus, false, Target)
    end
    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 and  Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + QQdmg
    end

    if self.ComboE.Value == 1 and  Engine:SpellReady("HK_SPELL3") then
        FinalFullDmg = FinalFullDmg + EEdmg
    end

    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + RRdmg
    end
    return FinalFullDmg
end

function Lux:Efindbomb()
    local Missiles = ObjectManager.MissileList
    for I, Missile in pairs(Missiles) do
        if Missile.Team == myHero.Team and GetDist(myHero.Position, Missile.Position) <= 1200 then
            if Missile.Name == "LuxLightStrikeKugel" then 
                return Missile 
            end
        end
    end
    return nil
end
---- ultimate2 -----
function Lux:Ebomb()
    local target = Orbwalker:GetTarget("Combo", 1200)
    local LuxE = Lux:Efindbomb()    
    if LuxE ~= nil then
        if target ~= nil then
            if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
                if GetDist(LuxE.Position, target.Position) <= 310 then
                    Engine:CastSpell("HK_SPELL3", nil, 1)
                end
            end
        end
    end 
end
---- end ultimate------
function Lux:ultimate()
    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false and not target.AIData.Dashing and self:TargetIsImmune(target) == false then
                if GetDist(myHero.Position, target.Position) <= 2500 then
                    local Luxdmg = (200 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 1))
                    if Luxdmg >= target.Health then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end
end
-----combo-----
function Lux:Combo()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end

    if  self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local ShieldTarget = SupportLib:GetShieldTargetWithTable(self.WRange, self.WTargets)
		if ShieldTarget then
			return Engine:CastSpell("HK_SPELL2", ShieldTarget.Position, 1)
		end
	end
end
function Lux:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
        if PredPos ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
        if PredPos ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end
end
function Lux:Laneclear()

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.QRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.IsTargetable and MinionsInRange(Minion.Position, 280) > self.LClearSlider.Value then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.ERange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", Minion.Position, 0)
                    return
                end
            end
        end
    end
end
--end---

function Lux:KillHealthBox()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if Hero.IsTargetable then

                local CurrentDmg = self:Damage(Hero) --Switch this part of the code from where dmg calcs comes from!
                local KillCombo = "KILLABLE"
                local CurrentHP = Hero.Health
                local MaxHP = Hero.MaxHealth
                local KillDraw = string.format("%.0f", CurrentDmg) .. " / " .. string.format("%.0f", CurrentHP)
                local fullHpDrawWidth = 104
                local damageDrawWidth = 0
                local damageStartingX = 0
                local damageEndingPos = 0
                local hpDrawWidth = 104 * (Hero.Health / Hero.MaxHealth)
                local lostHP = 104 - (Hero.MaxHealth - Hero.Health) / Hero.MaxHealth

                damageDrawWidth = (hpDrawWidth - hpDrawWidth * ((Hero.Health - CurrentDmg) / Hero.Health))
                damageEndingPos = damageDrawWidth
                if CurrentDmg >= Hero.Health then
                    damageEndingPos =  hpDrawWidth
                end

                damageStartingX = hpDrawWidth - damageDrawWidth
                if damageStartingX <= 0 then
                    damageStartingX = 0
                end
    
                local vecOut = Vector3.new()

                if Render:World2Screen(Hero.Position, vecOut) then 
                    if CurrentDmg < CurrentHP then
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 248, 252, 3, 255)
                    end
                    if CurrentDmg > CurrentHP then
                        Render:DrawString(KillCombo, vecOut.x - 50 , vecOut.y - 220, 92, 255, 5, 255)
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 92, 255, 5, 255)
                    end
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 , fullHpDrawWidth,  6, 0, 0, 0, 200)
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180, hpDrawWidth,  6, 92, 255, 5, 200)
                    Render:DrawFilledBox(vecOut.x - 49 + damageStartingX , vecOut.y - 180 , damageEndingPos,  6,153, 0, 0, 240)
                end
            end
        end
    end
end

function Lux:OnTick()
    local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.WTargets[Ally.Index] == nil then
			self.WTargets[Ally.Index] 		= self.ComboMenu:AddSlider(Ally.ChampionName , 100, 0, 100, 1)
		end
	end

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Lux:Ebomb()
        Lux:Efindbomb()
        Lux:ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Lux:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Lux:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Lux:Laneclear()
		end
	end
end
function Lux:OnDraw()
    if self.DrawKillable.Value == 1 then
        Lux:KillHealthBox()
    end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end
function Lux:OnLoad()
    if(myHero.ChampionName ~= "Lux") then return end
	AddEvent("OnSettingsSave" , function() Lux:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Lux:LoadSettings() end)
	Lux:__init()
	AddEvent("OnTick", function() Lux:OnTick() end)	
    AddEvent("OnDraw", function() Lux:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Lux:OnLoad() end)	
