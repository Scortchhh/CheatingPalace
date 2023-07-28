--Credits to Critic, Scortch, Christoph, KKat, Uaremylight

Quinn = {} -- is the champion Quinn? yes okay proceed

function Quinn:__init() -- initialize Quinn script

    
    self.QRange = 1025
    self.WRange = 2100
    self.ERange = 600
    self.RRange = 700

    self.QSpeed = 1550
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0

    self.ScriptVersion = "         dQuinn Ver: 1.01 CREDITS Derang3d" -- tells what version of the script it is.

    -- whats the first thing needed on building a script! the Menu!!!

    self.ChampionMenu = Menu:CreateMenu("Quinn") -- creates a menu box called "Quinn"
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") -- adds a combo box under Quinn named "combo"
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
--    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --self.ComboMenu:AddLabel("R usage")
    --self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    --self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)
    --self.RHPSlider = self.ComboMenu:AddSlider("Use DF if HP above %", 20,1,100,1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") -- adds a harass box under Quinn below "combo" since its located below the combo section of menu
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
--    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") -- adds a LaneClear box under Quinn below "Harass" since its located below the Combo/Harass section of menu
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
 --   self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") -- adds a drawings box under Quinn named "Drawings"
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Quinn:LoadSettings()  -- this loads the settings for Quinn!
end -- ends the loading function for default settings above

function Quinn:SaveSettings() -- this is the save settings for Quinn.
    --save settings from menu--

    --combo save settings--
    SettingsManager:CreateSettings("Quinn")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
--	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
--    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
--    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)
--    SettingsManager:AddSettingsInt("Use DF if HP above %", self.RHPSlider.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
--    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
--    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
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

function Quinn:LoadSettings()
    SettingsManager:GetSettingsFile("Quinn")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
--	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
--    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
--    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")
--    self.RHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use DF if HP above %")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
--    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
--    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
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

-----combo-----

function Quinn:Combo()

    local buff1 = myHero.BuffData:GetBuff("QuinnR")

    if Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team then
                if GetDist(myHero.Position, target.Position) <= 700 then
                    if ValidTarget(target) then 
                        if buff1.Valid == true and Orbwalker.Attack == 1 then
                            local totalDmg = (myHero.BonusAttack * .4)
                            if totalDmg >= target.Health then
                                Engine:CastSpell('HK_SPELL4', GameHud.MousePos) 
                            end
                        end
                    end
                end
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 60, self.QDelay, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end

	if Engine:SpellReady("HK_SPELL3") then
		if self.ComboE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange)
            if Target then
                if GetDist(myHero.Position, target.Position) < 175 then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    end  
                end              
			end
		end
    end
end


function Quinn:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Harass", self.QRange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 60, self.QDelay, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end

	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
            if Target then
                if GetDist(myHero.Position, target.Position) < 175 then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    end  
                end              
			end
		end
    end
end

function Quinn:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") then
		if self.ComboE.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
			if Target then
				Engine:CastSpell("HK_SPELL3", Target.Position, 0)
				return
			end
		end
    end
end

--end---


function Quinn:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Quinn:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Quinn:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Quinn:Laneclear()
		end
	end
end

function Quinn:OnDraw()
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

function Quinn:OnLoad()
    if(myHero.ChampionName ~= "Quinn") then return end
	AddEvent("OnSettingsSave" , function() Quinn:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Quinn:LoadSettings() end)


	Quinn:__init()
	AddEvent("OnTick", function() Quinn:OnTick() end)	
    AddEvent("OnDraw", function() Quinn:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Quinn:OnLoad() end)	
