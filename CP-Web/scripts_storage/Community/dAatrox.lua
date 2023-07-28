--Credits to Critic, Scortch, Christoph

Aatrox = {} 

function Aatrox:__init() 

    
    self.QRange = 625
    self.QRange2 = 475
    self.QRange3 = 200
    self.WRange = 825
    self.ERange = 200 
    self.RRange = 600

    self.QSpeed = math.huge 
    self.WSpeed = 1800
    self.ESpeed = 850

    self.QDelay = 0.6
    self.WDelay = 0.25
    self.EDelay = 0

    self.SpellDelay1 = 0.5

    self.ScriptVersion = "         dAatrox Ver: 1.01 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Aatrox") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

    --------------------------------------------


    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)    
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Aatrox:LoadSettings()  
end 

function Aatrox:SaveSettings() 

    SettingsManager:CreateSettings("Aatrox")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)
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

function Aatrox:LoadSettings()
    SettingsManager:GetSettingsFile("Aatrox")
     ------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")    
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

function unpack (t, i)
    i = i or 1
    if t[i] ~= nil then
      return t[i], unpack(t, i + 1)
    end
end

local delayedActions, delayedActionsExecuter = {}, nil
local DelayAction = function(func, delay, args)
        if not delayedActionsExecuter then
                delayedActionsExecuter = function()
                        for t, funcs in pairs(delayedActions) do
                                if t <= GameClock.Time then
                                        for j, f in ipairs(funcs) do
                                                f.func(unpack(f.args or {}))
                                        end
                                        delayedActions[t] = nil         
                                end
                        end
                end
                AddEvent("OnTick", delayedActionsExecuter)
        end

        local t = GameClock.Time + (delay or 0)
        if delayedActions[t] then
                table.insert(delayedActions[t], { func = func, args = args })
        else
                delayedActions[t] = { { func = func, args = args } }
        end
end

---- ultimate-----
function Aatrox:Ultimate()

    if self.RComboHP.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
        if myHero.Health <= Rcondition then
            Engine:CastSpell('HK_SPELL4', myHero.Position)
        end
    end

end

---- end ultimate------

-----combo-----
function Aatrox:Combo()

    local buff1 = myHero.BuffData:GetBuff("AatroxQ2")
    local buff2 = myHero.BuffData:GetBuff("AatroxQ3")
        
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 160, self.WDelay, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff1.Valid == false and buff2.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 180, self.QDelay, 0)
            if PredPos then
                DelayAction(function() 
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end, self.SpellDelay1)
            end
        end
    end 
    
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff1.Valid == true then
        local target = Orbwalker:GetTarget("Combo", self.QRange2)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange2, self.QSpeed, 180, self.QDelay, 0)
            if PredPos then
                DelayAction(function() 
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end, self.SpellDelay1)
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff2.Valid == true then
        local target = Orbwalker:GetTarget("Combo", self.QRange3)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange3, self.QSpeed, 180, self.QDelay, 0)
            if PredPos then
                DelayAction(function() 
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end, self.SpellDelay1)
            end
        end
    end

end


function Aatrox:Harass()

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 160, self.WDelay, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 180, self.QDelay, 0)
            if PredPos then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Aatrox:Laneclear()

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 0)
        end
    end

    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
        end
    end

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            DelayAction(function() 
            Engine:CastSpell("HK_SPELL1", target.Position, 0)
            end, self.SpellDelay1)
        end
    end
end

--end---


function Aatrox:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Aatrox:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Aatrox:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Aatrox:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Aatrox:Laneclear()
		end
	end
end

function Aatrox:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if myHero.BuffData:GetBuff("AatroxQ2").Valid then
            Render:DrawCircle(myHero.Position, self.QRange2 ,100,150,255,255)
            else    
            
                if myHero.BuffData:GetBuff("AatroxQ3").Valid then

                Render:DrawCircle(myHero.Position, self.QRange3 ,100,150,255,255)
            else
                
                Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
            end
        end
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

function Aatrox:OnLoad()
    if(myHero.ChampionName ~= "Aatrox") then return end
	AddEvent("OnSettingsSave" , function() Aatrox:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Aatrox:LoadSettings() end)


	Aatrox:__init()
	AddEvent("OnTick", function() Aatrox:OnTick() end)	
    AddEvent("OnDraw", function() Aatrox:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Aatrox:OnLoad() end)	
