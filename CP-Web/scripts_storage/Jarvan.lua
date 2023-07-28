--Credits to Critic, Scortch, Christoph

JarvanIV = {} 

function JarvanIV:__init() 

    
    self.QRange = 770
    self.WRange = 625 
    self.ERange = 860
    self.RRange = 650
    self.QDelay = 0.4
    self.EDelay = 0
    self.ESpeed = math.huge
    self.EWidth = 200

    self.EHitChance = 0.2

    self.ScriptVersion = "         dJarvanIV Ver: 1.04 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("JarvanIV") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("R KS", 1)
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R in Combo w/ enemies", 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
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
    
    JarvanIV:LoadSettings()
end

function JarvanIV:SaveSettings() 
  

    --combo save settings--
    SettingsManager:CreateSettings("JarvanIV")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R in Combo w/ enemies", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
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

function JarvanIV:LoadSettings()
    SettingsManager:GetSettingsFile("JarvanIV")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo w/ enemies")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    
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

function JarvanIV:GetDistance(source, target)
    return math.sqrt(((target.x - source.x) ^ 2) + ((target.z - source.z) ^ 2))
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

function JarvanIV:GetECastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

-----combo-----

function JarvanIV:ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 650 then
                    local Jarvandmg = GetDamage(75 + (125 * myHero:GetSpellSlot(3).Level) + (myHero.BonusAttack * 1.5), true, target)
                    if Jarvandmg >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end

    end

    if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 650 then
                if EnemiesInRange(target.Position, 325) > self.ComboRSlider.Value then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end

end

function JarvanIV:Combo()

	if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") then
		local StartPos 				= myHero.Position
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
		if PredPos ~= nil and Target ~= nil then
			PredPos = self:GetECastPos(PredPos)
			local Distance = self:GetDistance(StartPos, Target.Position)
			if Distance < myHero.AttackRange + myHero.CharData.BoundingRadius then
				if Orbwalker.ResetReady == 1 then
					if self:GetDistance(StartPos, PredPos) < self.ERange then
						Engine:CastSpell("HK_SPELL3", PredPos, 1)
						return
					end
				end
			else
				if self:GetDistance(StartPos, PredPos) < self.ERange then
					Engine:CastSpell("HK_SPELL3", PredPos, 1)
					return
				end
			end
		end
	end
    
    if Engine:SpellReady("HK_SPELL1") then
        if self.ComboQ.Value == 1 then
			    local Target = Orbwalker:GetTarget("Combo", self.QRange)
			    if Target then
				    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
				    return
                end
        end
    end

	if Engine:SpellReady("HK_SPELL2") then
		if self.ComboW.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", myHero.Position )
				return
			end
		end
    end

end


function JarvanIV:Harass()

	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
			if Target then
				Engine:CastSpell("HK_SPELL3", Target.Position, 1)
				return
			end
		end
    end
    
    if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
			    local Target = Orbwalker:GetTarget("Harass", self.QRange)
			    if Target then
				    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
				    return
                end
        end
    end

	if Engine:SpellReady("HK_SPELL2") then
		if self.HarassW.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", myHero.Position )
				return
			end
		end
    end

end

function JarvanIV:Laneclear()
    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target ~= nil then
            if GetDist(myHero.Position, Target.Position) <= self.ERange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition  and Target.IsMinion and Target.MaxHealth > 10 then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                    return
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
                if myHero.Mana >= condition  and Target.IsMinion and Target.MaxHealth > 10 then
                    Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") then
		if self.ClearW.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.WRange)
			if Target and Target.IsMinion and Target.MaxHealth > 10 then
				Engine:CastSpell("HK_SPELL2", myHero.Position )
				return
			end
		end
    end



end


--end---


function JarvanIV:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            JarvanIV:ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            JarvanIV:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            JarvanIV:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            JarvanIV:Laneclear()
		end
	end
end

function JarvanIV:OnDraw()
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
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function JarvanIV:OnLoad()
    if(myHero.ChampionName ~= "JarvanIV") then return end
	AddEvent("OnSettingsSave" , function() JarvanIV:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() JarvanIV:LoadSettings() end)


	JarvanIV:__init()
	AddEvent("OnTick", function() JarvanIV:OnTick() end)	
    AddEvent("OnDraw", function() JarvanIV:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() JarvanIV:OnLoad() end)	
