--Credits to Critic, Scortch, Christoph

Sett = {} 

function Sett:__init() 

    self.QRange = myHero.AttackRange
    self.WRange = 790
    self.ERange = 490
    self.RRange = 400 

    self.QSpeed = math.huge 
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.QDelay = 0.25
    self.WDelay = 0.75
    self.EDelay = 0.30


    self.ScriptVersion = "         dSett Ver: 1.03 CREDITS Derang3d" 

  

    self.ChampionMenu = Menu:CreateMenu("Sett") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboWHPSlider = self.ComboMenu:AddSlider("Use W if Grit Above %", 20,1,100,1)
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

    Sett:LoadSettings()  
end 

function Sett:SaveSettings() 

    SettingsManager:CreateSettings("Sett")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use W if Grit Above %", self.ComboWHPSlider.Value)
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

function Sett:LoadSettings()
    SettingsManager:GetSettingsFile("Sett")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboWHPSlider.Value = SettingsManager:GetSettingsInt("Use W if Grit Above %")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
--------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
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

function Sett:GetDistance(source, target)
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

function Sett:rUlti()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 400 then
                    local Settdmg = GetDamage(100 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.BonusAttack * 1.0), true, target)
                    if Settdmg >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end
end

function Sett:Combo()

    if Engine:SpellReady("HK_SPELL1") then
		if self.ComboQ.Value == 1 then
            local Target = Orbwalker:GetTarget("Combo", self.QRange)
            if Target then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL1", Vector3.new() , 1)
                end
			end
		end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local sliderValue = self.ComboWHPSlider.Value
        local condition = myHero.MaxMana / 100 * sliderValue
        if myHero.Mana >= condition then
            local Target = Orbwalker:GetTarget("Combo", self.WRange)
            local StartPos = myHero.Position
            if Target ~= nil then
                local PredPos, Target = Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, 805, self.WDelay, 0)
                if PredPos ~= nil then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    end
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, 350, self.EDelay, 0)
            if PredPos ~= nil then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end 
            end
        end
    end


end



function Sett:Harass()

    if Engine:SpellReady("HK_SPELL1") then
		if self.HarassQ.Value == 1 then
            local Target = Orbwalker:GetTarget("Harass", self.QRange)
			if Target then
				Engine:CastSpell("HK_SPELL1", Vector3.new() , 1)
				return
			end
		end
    end

    if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 805, self.WDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.HarassE.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 350, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
        end
    end

end

function Sett:Laneclear()

    if Engine:SpellReady("HK_SPELL1") then
		if self.ClearQ.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
			if Target then
				Engine:CastSpell("HK_SPELL1", Vector3.new() , 0)
				return
			end
		end
    end

    if Engine:SpellReady("HK_SPELL2") then
		if self.ClearW.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.WRange - 20)
			if Target then
				Engine:CastSpell("HK_SPELL2", Target.Position , 0)
				return
			end
		end
    end

    if Engine:SpellReady("HK_SPELL3") then
		if self.ClearE.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.ERange - 20)
			if Target then
				Engine:CastSpell("HK_SPELL3", Target.Position , 0)
				return
			end
		end
    end


end

--end---


function Sett:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            Sett:rUlti()
        if Engine:IsKeyDown("HK_COMBO") then
            Sett:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sett:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sett:Laneclear()
		end
	end
end

function Sett:OnDraw()
	--if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
    --    Render:DrawCircle(myHero.Position, self.QMaxRange ,100,150,255,255)
    --end
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

function Sett:OnLoad()
    if(myHero.ChampionName ~= "Sett") then return end
	AddEvent("OnSettingsSave" , function() Sett:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sett:LoadSettings() end)


	Sett:__init()
	AddEvent("OnTick", function() Sett:OnTick() end)	
    AddEvent("OnDraw", function() Sett:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Sett:OnLoad() end)	
