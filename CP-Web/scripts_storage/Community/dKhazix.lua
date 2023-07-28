--Credits to Critic, Scortch, Christoph

Khazix = {} 

function Khazix:__init() 

    
    self.QRange = 325 
    self.WRange = 1015 
    self.ERange = 700

    self.WSpeed = 1700
    self.WDelay = 0.25


    self.ScriptVersion = "         dKhazix Ver: 1.02 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("Khazix") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on your HP % in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

    --------------------------------------------

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
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
--    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Khazix:LoadSettings()
end

function Khazix:SaveSettings() 
  
    SettingsManager:CreateSettings("Khazix")
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
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
--    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Khazix:LoadSettings()
    SettingsManager:GetSettingsFile("Khazix")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
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


-----combo-----

function Khazix:Combo()

    if Engine:SpellReady("HK_SPELL3") then
        if self.ComboE.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixEEvo").Valid then
			    local Target = Orbwalker:GetTarget("Combo", self.ERange + 200)
                if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                        return
                    end
                end
            end
		end
    end

	if Engine:SpellReady("HK_SPELL3") then
		if self.ComboE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange)
			if Target then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
			end
		end
    end

	if Engine:SpellReady("HK_SPELL1") then
        if self.ComboQ.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixQEvo").Valid then
			    local Target = Orbwalker:GetTarget("Combo", self.QRange + 50)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL1") then
        if self.ComboQ.Value == 1 then
			    local Target = Orbwalker:GetTarget("Combo", self.QRange)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 140, self.WDelay, 1)
            if PredPos then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.RComboHP.Value == 1 then
        local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
        if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL4', myHero.Position)
        end
    end

end


function Khazix:Harass()

    if Engine:SpellReady("HK_SPELL3") then
        if self.HarassE.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixEEvo").Valid then
			    local Target = Orbwalker:GetTarget("Harass", self.ERange + 200)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                        return
                    end
                end
            end
		end
    end

	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
			if Target then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
			end
		end
    end

	if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixQEvo").Valid then
			    local Target = Orbwalker:GetTarget("Harass", self.QRange + 50)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
			    local Target = Orbwalker:GetTarget("Harass", self.QRange)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 275, self.WDelay, 1)
            if PredPos then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

end

function Khazix:Laneclear()

    if Engine:SpellReady("HK_SPELL3") then
		if self.ClearE.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
            local sliderValue = self.LClearSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
			if myHero.Mana >= condition then
			    if Target then
				    Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                    return
                end
			end
		end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.WRange - 20)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", Target.Position, 0)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                end
            end
        end
    end
end

--end---


function Khazix:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Khazix:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Khazix:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Khazix:Laneclear()
		end
	end
end

function Khazix:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if myHero.BuffData:GetBuff("KhazixQEvo").Valid then
            Render:DrawCircle(myHero.Position, self.QRange +50 ,255,20,147,255)
            else    
                Render:DrawCircle(myHero.Position, self.QRange ,255,20,147,255)
        end
    end

	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        if myHero.BuffData:GetBuff("KhazixEEvo").Valid then
            Render:DrawCircle(myHero.Position, self.ERange +200 ,255,20,147,255)
            else    
                Render:DrawCircle(myHero.Position, self.ERange ,255,20,147,255)
        end
    end
end

function Khazix:OnLoad()
    if(myHero.ChampionName ~= "Khazix") then return end
	AddEvent("OnSettingsSave" , function() Khazix:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Khazix:LoadSettings() end)


	Khazix:__init()
	AddEvent("OnTick", function() Khazix:OnTick() end)	
    AddEvent("OnDraw", function() Khazix:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Khazix:OnLoad() end)	
