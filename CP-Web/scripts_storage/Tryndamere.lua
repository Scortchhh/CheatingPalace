--Credits to Critic, Scortch, Christoph
Tryndamere = {} 
function Tryndamere:__init() 

    self.QRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    self.WRange = 850
    self.ERange = 660
    self.RRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20


    self.ESpeed = math.huge

    self.EWidth = 225

    self.EDelay = 0

    self.EHitChance = 0.2

    self.ScriptVersion = "         Tryndamere Ver: 1.1" 

    self.ChampionMenu = Menu:CreateMenu("Tryndamere") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboQHPSlider = self.ComboMenu:AddSlider("Use Q if HP below %", 20,1,100,1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)
    self.ComboRRSlider = self.ComboMenu:AddSlider("Use Q in R w/ Rage above %", 20,1,100,1)
    self.ComboRX = self.ComboMenu:AddSlider("Dont Use Q in R", 1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    --------------------------------------------
    Tryndamere:LoadSettings()  
end 
function Tryndamere:SaveSettings() 
    SettingsManager:CreateSettings("Tryndamere")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use Q if HP below %", self.ComboQHPSlider.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in R w/ Rage above %", self.ComboRRSlider.Value)
    SettingsManager:AddSettingsInt("Dont Use Q in R", self.ComboRX.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    --------------------------------------------
end
function Tryndamere:LoadSettings()
    SettingsManager:GetSettingsFile("Tryndamere")
     --------------------------------------------
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboQHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use Q if HP below %")  
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")  
    self.ComboRRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in R w/ Rage above %")  
    self.ComboRX.Value = SettingsManager:GetSettingsInt("Combo", "Dont Use Q in R")  
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
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
function Tryndamere:GetECastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	local i 			= 170
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end
----ultimate-----
function Tryndamere:Ultimate()
    local buff1 = myHero.BuffData:GetBuff("UndyingRage")
    if self.RComboHP.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
        if myHero.Health <= Rcondition then
            Engine:CastSpell('HK_SPELL4', myHero.Position, 1)
            return
        end
    end
    if self.ComboQ.Value == 1 and Engine:SpellReady('HK_SPELL1') and buff1.Count_Alt > 0 and self.ComboRX.Value == 0 then
        local Rcondition = myHero.MaxMana / 100 * self.ComboRRSlider.Value
        if myHero.Mana >= Rcondition then
            Engine:CastSpell('HK_SPELL1', nil, 1)
            return
        end
    end
end
----------
-----combo-----
--TryndamereE
function Tryndamere:Combo()
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local StartPos 				= myHero.Position
		local CastPos, Target 		= Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
		if CastPos ~= nil and Target ~= nil then
			CastPos = self:GetECastPos(CastPos)
			local Distance = GetDist(StartPos, Target.Position)
            if GetDist(StartPos, CastPos) <= 660 then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                return
            end
		end
    end
    if self.ComboQ.Value == 1 and Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL4') then
        local Rcondition = myHero.MaxHealth / 100 * self.ComboQHPSlider.Value
        if myHero.Health <= Rcondition then
            Engine:CastSpell('HK_SPELL1', nil, 1)
            return
        end
    end
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
            return
        end
    end
end
function Tryndamere:Harass()
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local StartPos 				= myHero.Position
		local CastPos, Target 		= Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
		if CastPos ~= nil and Target ~= nil then
			CastPos = self:GetECastPos(CastPos)
			local Distance = GetDist(StartPos, Target.Position)
            if GetDist(StartPos, CastPos) <= 660 then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                return
            end
		end
    end
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local Rcondition = myHero.MaxHealth / 100 * self.ComboQHPSlider.Value
            if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL1', nil, 1)
                return
            end
        end
    end
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
            return
        end
    end
end
function Tryndamere:Laneclear()
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 0)
            return
        end
    end
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            local Rcondition = myHero.MaxHealth / 100 * self.ComboQHPSlider.Value
            if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL1', nil , 0)
                return
            end
        end
    end
    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
            return
        end
    end
end
--end---
function Tryndamere:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Tryndamere:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Tryndamere:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Tryndamere:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Tryndamere:Laneclear()
		end
	end
end
function Tryndamere:OnDraw()
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
end
function Tryndamere:OnLoad()
    if(myHero.ChampionName ~= "Tryndamere") then return end
	AddEvent("OnSettingsSave" , function() Tryndamere:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Tryndamere:LoadSettings() end)
	Tryndamere:__init()
	AddEvent("OnTick", function() Tryndamere:OnTick() end)	
    AddEvent("OnDraw", function() Tryndamere:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Tryndamere:OnLoad() end)	
