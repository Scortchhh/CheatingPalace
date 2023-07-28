--Credits to Critic, Scortch, Christoph

Fiora = {} 

function Fiora:__init() 

    
    self.QRange = 760
    self.WRange = 900
    self.ERange = 200
    self.RRange = 500

    self.QSpeed = math.huge 
    self.WSpeed = 3200
    self.ESpeed = 850

    self.QDelay = 0
    self.WDelay = 0
    self.EDelay = 0.25

    self.ScriptVersion = "         dFiora Ver: 0.5 CREDITS Derang3d" 

    
    self.IsEvadeLoaded = false
    self.ChampionMenu = Menu:CreateMenu("Fiora") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
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
    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.DodgeQ = self.MiscMenu:AddCheckbox("Dodge w/ Q", 1)

    Fiora:LoadSettings()  
end 

function Fiora:SaveSettings() 

    SettingsManager:CreateSettings("Fiora")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
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
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Dodge w/ Q", self.DodgeQ.Value)
    --------------------------------------------
end

function Fiora:LoadSettings()
    SettingsManager:GetSettingsFile("Fiora")
     --------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")   
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
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
    self.DodgeQ.Value = SettingsManager:GetSettingsInt("Misc","Dodge w/ Q")

    if Evade ~= nil then
        self.IsEvadeLoaded = true
    else
        print('enable evade for Dodge Q')
    end
end


local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Fiora:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
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
			if Fiora:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end
----------
function Fiora:CheckCollision(startPos, endPos, r)
    local distanceP1_P2 = Fiora:GetDistance(startPos,endPos)
    local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
    local unitPos = myHero.Position
    local distanceP1_Unit = Fiora:GetDistance(startPos,unitPos)
    if distanceP1_Unit <= distanceP1_P2 then
        local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
        if Fiora:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
            return true
        end
    end
    return false
end

function Fiora:Qdodge()
    if self.IsEvadeLoaded then
        for i, Hero in pairs(ObjectManager.HeroList) do
            if Hero.Team ~= myHero.Team and self:GetDistance(myHero.Position, Hero.Position) <= 1400 then
                if self.DodgeQ.Value == 1 then
                    local Missiles = ObjectManager.MissileList
                    for I, Missile in pairs(Missiles) do
                        if Missile.Team ~= myHero.Team then 
                            local Info = Evade.Spells[Missile.Name]
                            local dodgepos = myHero.Position
                            dodgepos.z = dodgepos.z - 300
                            if Info ~= nil and Info.Type == 0 then
                                if Fiora:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius + 70) then
                                    if Engine:SpellReady("HK_SPELL1") then
                                        Engine:CastSpell("HK_SPELL1",  dodgepos)
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
-----combo-----
--FioraPassive

function Fiora:Combo()

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 140, self.WDelay, 0)
            if PredPos then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                Engine:CastSpell("HK_SPELL3", Vector3.new(), 1)
            end
        end
    end
end


function Fiora:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") and buff1.Valid == false then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 140, self.WDelay, 0)
            if PredPos then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        return
                    end
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
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    return
                end
            end
        end
    end

end

function Fiora:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if Fiora:GetDistance(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end

    
    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if Fiora:GetDistance(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 0)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            if Fiora:GetDistance(myHero.Position, target.Position) <= self.ERange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", target.Position, 0)
                end
            end
        end
    end

end

--end---


function Fiora:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Fiora:Qdodge()
        if Engine:IsKeyDown("HK_COMBO") then
            Fiora:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Fiora:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Fiora:Laneclear()
		end
	end
end

function Fiora:OnDraw()
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

function Fiora:OnLoad()
    if(myHero.ChampionName ~= "Fiora") then return end
	AddEvent("OnSettingsSave" , function() Fiora:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Fiora:LoadSettings() end)


	Fiora:__init()
	AddEvent("OnTick", function() Fiora:OnTick() end)	
    AddEvent("OnDraw", function() Fiora:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Fiora:OnLoad() end)	
