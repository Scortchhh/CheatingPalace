--Credits to Critic, Scortch, Christoph

Ekko = {} 

function Ekko:__init() 

    
    self.QRange = 700
    self.WRange = 1600
    self.ERange = 700 
    self.RRange = 550

    self.QSpeed = 1650 
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.QDelay = 0.25
    self.WDelay = 3.35
    self.EDelay = math.huge

    self.ScriptVersion = "         dEkko Ver: 1.0 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Ekko") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    self.ComboMenu:AddLabel("R usage")
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

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
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    
    Ekko:LoadSettings()  
end 

function Ekko:SaveSettings() 


    --combo save settings--
    SettingsManager:CreateSettings("Ekko")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Ekko:LoadSettings()
    SettingsManager:GetSettingsFile("Ekko")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    
     --------------------------------Draw load----------------------
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

---- ultimate2 -----
function Ekko:Ultimate()

    rPos = nil
    DelayAction(function() rPos = myHero.pos end, 3000)
    if (rPos) then
        EnemiesInRange(rPos, 550) >= 1 then
            if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
                local HeroList = ObjectManager.HeroList
                for i, target in pairs(HeroList) do
                    if target.Team ~= myHero.Team and target.IsDead == false then
                        if GetDist(myHero.Position, target.Position) <= 375 then
                            local EkkoR = GetDamage((150 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 1.5), false, target)
                            if EkkoR >= target.Health then
                                Engine:CastSpell('HK_SPELL4', target.Position, 0)
                            end
                        end
                    end
                end
            end
        end
    else
        if self.RComboHP.Value == 1 and Engine:SpellReady('HK_SPELL4') then
            local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
            if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL4', myHero.Position)
            end
        end

    end 
end

---- end ultimate------

-----combo-----
--EkkoE

function Ekko:Combo()

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 60, self.QDelay, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 0)
            if PredPos then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end

end


function Ekko:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 60, self.QDelay, 0)
            if PredPos then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.HarassWValue == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 0)
            if PredPos then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
    end

end

function Ekko:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end
        end
    end

end

--end---


function Ekko:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Ekko:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Ekko:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Ekko:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Ekko:Laneclear()
		end
	end
end

function Ekko:OnDraw()
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

function Ekko:OnLoad()
    if(myHero.ChampionName ~= "Ekko") then return end
	AddEvent("OnSettingsSave" , function() Ekko:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ekko:LoadSettings() end)


	Ekko:__init()
	AddEvent("OnTick", function() Ekko:OnTick() end)	
    AddEvent("OnDraw", function() Ekko:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Ekko:OnLoad() end)	
