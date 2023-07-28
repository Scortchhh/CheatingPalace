--Credits to Critic, Scortch, Christoph

Riven = {} 

function Riven:__init() 

    
    self.QRange = 275
    self.WRange = 260
    self.ERange = 310
    self.RRange = 1000

    self.RSpeed = 1600

    self.RDelay = 0.25

    self.SpellDelay1 = 0.3

    self.ScriptVersion = "         dRiven Ver: 1.0 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Riven") 
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
    
    Riven:LoadSettings()  
end 

function Riven:SaveSettings() 

    SettingsManager:CreateSettings("Riven")
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

function Riven:LoadSettings()
    SettingsManager:GetSettingsFile("Riven")
     ------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo")   
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
function Riven:Ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 900 then
                    local MissingHPCalc = 2.667 * (100 - (target.Health / 100 * 10))
                    -- local RBuff = 1 + math.min(1, (1 - target.Health / target.MaxHealth) * 4/3)
                    local RDmg = GetDamage(50 + (50 * myHero:GetSpellSlot(3).Level) + myHero.BonusAttack * 0.6, true, target) * (MissingHPCalc / 100)
                    if RDmg >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end

end

---- end ultimate------

-----combo-----
function Riven:Combo()

    if Engine:SpellReady('HK_SPELL3') and self.ComboE.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 1000)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) >= self.ERange then
            Engine:CastSpell("HK_SPELL3", target.Position , 1)
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
        end
    end


    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 then
        if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 1 then 
            DelayAction(function()
                local target = Orbwalker:GetTarget("Combo", self.QRange)
                if target then
                    if GetDist(myHero.Position, target.Position) < getAttackRange() then
                         Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end, self.SpellDelay1)
        end

    end

end


function Riven:Harass()

    if Engine:SpellReady('HK_SPELL3') and self.HarassE.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", 1000)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) >= self.ERange then
            Engine:CastSpell("HK_SPELL3", target.Position , 1)
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
        end
    end


    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 1 then
            DelayAction(function()
                local target = Orbwalker:GetTarget("Harass", self.QRange)
                if target then
                    if GetDist(myHero.Position, target.Position) < getAttackRange() then
                         Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end, self.SpellDelay1)
        end

    end
end

function Riven:Laneclear()

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end

    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
        end
    end

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            DelayAction(function() 
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end, self.SpellDelay1)
        end
    end
end

--end---


function Riven:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Riven:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Riven:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Riven:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Riven:Laneclear()
		end
	end
end

function Riven:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if myHero.BuffData:GetBuff("RivenQ2").Valid then
            Render:DrawCircle(myHero.Position, self.QRange2 ,100,150,255,255)
            else    
            
                if myHero.BuffData:GetBuff("RivenQ3").Valid then

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

function Riven:OnLoad()
    if(myHero.ChampionName ~= "Riven") then return end
	AddEvent("OnSettingsSave" , function() Riven:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Riven:LoadSettings() end)


	Riven:__init()
	AddEvent("OnTick", function() Riven:OnTick() end)	
    AddEvent("OnDraw", function() Riven:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Riven:OnLoad() end)	
