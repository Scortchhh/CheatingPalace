Fizz = {}

function Fizz:__init() 
    self.QRange = 550
    self.WRange = 225
    self.ERange = 700
    self.RRange = 1300

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = 1300

    self.QWidth = 100
    self.WWidth = 100
    self.EWidth = 150
    self.RWidth = 200
   
    self.QDelay = 0
    self.WDelay = 0
    self.EDelay = 0.15
	self.RDelay = 0.25

    self.RHitChance = 0.5
   
    self.ScriptVersion = "         LFizz Ver: 1.0 CREDITS UAreMyLight"


    self.IsEvadeLoaded          = false
    self.ChampionMenu = Menu:CreateMenu("Fizz") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q as gapclose  in combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1)
    self.ComboEEvade = self.ComboMenu:AddCheckbox("Use E for Evade",1)

    self.ComboERangeMin = self.ComboMenu:AddSlider("Min Range for E gapclose in combo", 400,200,1000,10)
    self.ComboERangeMax = self.ComboMenu:AddSlider("Max Range for E gapclose in combo", 800,200,1000,10)
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Min % HP for target to use R", 40,1,100,1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1)  
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1)  
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1)   
end 

function Fizz:SaveSettings() 


    --combo save settings--
    SettingsManager:CreateSettings("Fizz")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Min Range for E gapclose in combo", self.ComboERangeMin.Value)
    SettingsManager:AddSettingsInt("Max Range for E gapclose in combo", self.ComboERangeMax.Value)
    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Fizz:LoadSettings()
    SettingsManager:GetSettingsFile("Fizz")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo") 
    self.ComboERangeMin.Value = SettingsManager:GetSettingsInt("Combo","Min Range for E gapclose in combo") 
    self.ComboERangeMax.Value = SettingsManager:GetSettingsInt("Combo","Max Range for E gapclose in combo")   
    --------------------------------------------

    --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    
     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    --------------------------------------------
    if Evade ~= nil then
        self.IsEvadeLoaded = true
    else
        print('enable evade for E usage')
    end

end

function Fizz:CheckCollision(startPos, endPos, r)
    local distanceP1_P2 = GetDist(startPos,endPos)
    local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
    local unitPos = myHero.Position
    local distanceP1_Unit = GetDist(startPos,unitPos)
    if distanceP1_Unit <= distanceP1_P2 then
        local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
        if GetDist(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
            return true
        end
    end
    return false
end

function Fizz:EvadeE()
    if self.IsEvadeLoaded then
   
            local HeroList = ObjectManager.HeroList
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and GetDist(myHero.Position, Hero.Position) <= 1400 then
                    if self.ComboEEvade.Value == 1 then
                        local Missiles = ObjectManager.MissileList
                        for I, Missile in pairs(Missiles) do
                            if Missile.Team ~= myHero.Team then 
                                local Info = Evade.Spells[Missile.Name]
                                if Info ~= nil and Info.Type == 0 then
                                    if Info.CC == 1 then 
                                        if Fizz:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius + 70) then
                                            --if info.Speed * Fizz:GetDist(Missile.MissilveStartPos, myHero.Position)
                                            if Engine:SpellReady("HK_SPELL3") then
                                                Engine:CastSpell("HK_SPELL3",  Hero.Position)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

    end
end

function Fizz:GetDist(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
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
	local Count = 0 --FeelsBadMan
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

function Fizz:Combo()
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            local Distance = GetDist(myHero.Position, target.Position)
            local damage = 0
            if Distance > 910 then
                damage = GetDamage(200 + (100 * myHero:GetSpellSlot(3).Level) + 1.2 * myHero.AbilityPower, false, target)
            end
            if Distance >= 455 and Distance <= 910 then
                damage = GetDamage(125 + (100 * myHero:GetSpellSlot(3).Level) + 1 * myHero.AbilityPower, false, target)
            end
            if Distance < 455 then
                damage = GetDamage(50 + (100 * myHero:GetSpellSlot(3).Level) + 0.8 * myHero.AbilityPower, false, target)
            end
            local eDmg = GetDamage(20 + (50 * myHero:GetSpellSlot(2).Level) + 0.75 * myHero.AbilityPower,false, target)
            local qDmg = GetDamage(-5 + (15 * myHero:GetSpellSlot(0).Level) + 0.5 * myHero.AbilityPower,false, target)
            damage = damage + eDmg + qDmg
            if target.Health <= damage then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    return
                end
            end
        end    
    end
    
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", 1000)
        if target then
            if GetDist(myHero.Position, target.Position) >= self.ComboERangeMin.Value and GetDist(myHero.Position, target.Position) <= self.ComboERangeMax.Value then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
            return end
        end    
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        return end
    end
end

function Fizz:Harass()
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        return end
    end
end

function Fizz:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        return end
    end
    
    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
    end
end



function Fizz:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Fizz:EvadeE()
        if Engine:IsKeyDown("HK_COMBO") then
            Fizz:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Fizz:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Fizz:Laneclear()
		end
	end
end

function Fizz:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
    end
end

function Fizz:OnLoad()
    if(myHero.ChampionName ~= "Fizz") then return end
	AddEvent("OnSettingsSave" , function() Fizz:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Fizz:LoadSettings() end)


	Fizz:__init()
	AddEvent("OnTick", function() Fizz:OnTick() end)	
    AddEvent("OnDraw", function() Fizz:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Fizz:OnLoad() end)