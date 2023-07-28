--Credits to Critic, Scortch, Christoph, KKat, Uaremylight

Renekton = {} -- is the champion Renekton? yes okay proceed

function Renekton:__init() -- initialize Renekton script

    
    self.QRange = 310 --(325 is the actual radius but with aoe want about 15-25 less)
    self.WRange = 125 --(basic aa range)
    self.ERange = 435 -- (450 is the actual radius w/ aoe 15 less)

    self.ESpeed = 0


    self.EDelay = 0.25

--    self.RRange = 175 -- R range is 400(activate since using target.position it will be used perfectly)
    -- delay indicators 
    -- script version--

    self.ScriptVersion = "         dRenekton Ver: 1.01 CREDITS Derang3d" -- tells what version of the script it is.

    -- whats the first thing needed on building a script! the Menu!!!

    self.ChampionMenu = Menu:CreateMenu("Renekton") -- creates a menu box called "Renekton"
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") -- adds a combo box under Renekton named "combo"
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    self.ComboMenu:AddLabel("R usage")
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") -- adds a harass box under Renekton below "combo" since its located below the combo section of menu
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") -- adds a LaneClear box under Renekton below "Harass" since its located below the Combo/Harass section of menu
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    --self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") -- adds a drawings box under Renekton named "Drawings"
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
--    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Renekton:LoadSettings()  -- this loads the settings for Renekton!
end -- ends the loading function for default settings above

function Renekton:SaveSettings() -- this is the save settings for Renekton.
    --save settings from menu--

    --combo save settings--
    SettingsManager:CreateSettings("Renekton")
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
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
--    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Renekton:LoadSettings()
    SettingsManager:GetSettingsFile("Renekton")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------

     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
--    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
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

---- ultimate -----
function Renekton:Ultimate()
    if Engine:SpellReady("HK_SPELL4") then 
        if self.ComboR.Value == 1 then
            local Rcondition = EnemiesInRange(myHero.Position, 700)
            if Rcondition >= self.RComboHPSlider.Value then
                Engine:CastSpell('HK_SPELL4', myHero.Position)
            end
        end

        if self.RComboHP.Value == 1 then
            local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
            if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL4', myHero.Position)
            end
        end
    end
end

---- end ultimate------


-----combo-----

function Renekton:Combo()

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
        end
    end

	if Engine:SpellReady("HK_SPELL1") then
		if self.ComboQ.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.QRange)
			if Target then
				Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
				return
			end
		end
    end
    
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) >= getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
        end
    end


end


function Renekton:Harass()

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
        end
    end

	if Engine:SpellReady("HK_SPELL1") then
		if self.ComboQ.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.QRange)
			if Target then
				Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
				return
			end
		end
    end
    
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) >= getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
        end
    end


end

function Renekton:Laneclear()

    if Engine:SpellReady("HK_SPELL1") then
		if self.ComboQ.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
			if Target then
				Engine:CastSpell("HK_SPELL1", Vector3.new(), 0)
				return
			end
		end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 0)
            end
        end
    end

end

--end---


function Renekton:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Renekton:Ultimate()
            Renekton:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Renekton:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Renekton:Laneclear()
		end
	end
end

function Renekton:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,255,20,147,255)
    end
--    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
--        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255) -- values Red, Green, Blue, Alpha(opacity)      
--    end
end

function Renekton:OnLoad()
    if(myHero.ChampionName ~= "Renekton") then return end
	AddEvent("OnSettingsSave" , function() Renekton:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Renekton:LoadSettings() end)


	Renekton:__init()
	AddEvent("OnTick", function() Renekton:OnTick() end)	
    AddEvent("OnDraw", function() Renekton:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Renekton:OnLoad() end)	
