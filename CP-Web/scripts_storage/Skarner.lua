--Credits to Critic, Scortch, Christoph
Skarner = {} 
function Skarner:__init() 
    self.QRange = 350
    self.WRange = myHero.AttackRange
    self.ERange = 1000 
    self.RRange = 350

    self.ESpeed = 1500

    self.EWidth = 140

    self.EDelay = 0.25

    self.EHitChance = 0.2

    self.ScriptVersion = "         Skarner Ver: 1.1" 
    self.ChampionMenu = Menu:CreateMenu("Skarner") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1)
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)  
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)    
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Skarner:LoadSettings()  
end 
function Skarner:SaveSettings() 
    SettingsManager:CreateSettings("Skarner")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end
function Skarner:LoadSettings()
    SettingsManager:GetSettingsFile("Skarner")
     ------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
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
local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
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

function Skarner:Ultimate()
    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 400 then
                    local RDamage = {20, 60, 100}
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local Rdmg = RDamage[RLevel]
                    local RAPdmg = (myHero.AbilityPower * 0.5)
                    local RADdmg = (myHero.BonusAttack * 0.6)
                    local RRDMG = RAPdmg + RADdmg
                    local SkarnerR = GetDamage(Rdmg + RRDMG, false, target)
                    if SkarnerR >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end
end
---- end ultimate------
-----combo-----
function Skarner:Combo()
    if Engine:SpellReady('HK_SPELL1') and self.ComboQ.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 900)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", nil, 0)
            return
        end
    end
    if Engine:SpellReady('HK_SPELL2') and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 1000)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= 900 then
            Engine:CastSpell("HK_SPELL2", nil, 0)
            return
        end
    end
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end
end
function Skarner:Harass()
    if Engine:SpellReady('HK_SPELL1') and self.HarassQ.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", 900)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= self.ERange then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL1", nil, 0)
                return
            end
        end
    end
    if Engine:SpellReady('HK_SPELL2') and self.HarassW.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", 1000)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= 1000 then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if PredPos then
                    local sliderValue = self.HarassSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL3", target.Position, 0)
                        return
                    end
                end
            end
        end
    end
end
function Skarner:Laneclear()
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 0)
            return
        end
    end
    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
            return
        end
    end
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            Engine:CastSpell("HK_SPELL1", target.Position, 0)
            return
        end
    end
end
--end---
function Skarner:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Skarner:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Skarner:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Skarner:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Skarner:Laneclear()
		end
	end
end
function Skarner:OnDraw()
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
function Skarner:OnLoad()
    if(myHero.ChampionName ~= "Skarner") then return end
	AddEvent("OnSettingsSave" , function() Skarner:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Skarner:LoadSettings() end)
	Skarner:__init()
	AddEvent("OnTick", function() Skarner:OnTick() end)	
    AddEvent("OnDraw", function() Skarner:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Skarner:OnLoad() end)	
