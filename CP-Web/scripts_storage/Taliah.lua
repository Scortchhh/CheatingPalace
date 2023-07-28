
Taliyah = {} 
function Taliyah:__init() 
    self.QRange = 1000
    self.WRange = 900
    self.ERange = 800
    self.RRange = 1200

    self.ESpeed = 2000
    self.RSpeed = math.huge

    self.EDelay = 0.25
    self.RDelay = 0.625

    self.ScriptVersion = "         Taliyah Ver: 1.5" 
    self.ChampionMenu = Menu:CreateMenu("Taliyah") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R to KS", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    self.HarassR = self.HarassMenu:AddCheckbox("Use R in Harass", 1) 
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
    Taliyah:LoadSettings()  
end 
function Taliyah:SaveSettings() 
    SettingsManager:CreateSettings("Taliyah")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R to KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    SettingsManager:AddSettingsInt("Use R in Harass", self.HarassR.Value)
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
end
function Taliyah:LoadSettings()
    SettingsManager:GetSettingsFile("Taliyah")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboRR.Value = SettingsManager:GetSettingsInt("Combo","Use R to KS")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    self.HarassR.Value = SettingsManager:GetSettingsInt("Harass","Use R in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
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

--[[function Taliah:GetSecondWTargetCombo(FirstTarget)
	local Hero = Orbwalker.ForceTarget
	if Hero ~= nil and Hero.Team ~= myHero.Team and Hero.IsHero and Hero.IsTargetable then
        print('xd3',self:GetDistance(myHero.Position , Hero.Position) < self.WRange_Max)
		if self:GetDistance(myHero.Position , Hero.Position) < self.WRange_Max then
            return Hero, true
        end
	end
	
	if Hero ~= nil and Prediction.ForceTargetOnly.Value == 1 then
		return nil, true
	end

	local TargetSelector = Orbwalker:GetTargetSelectorList(myHero.Position, self.WRange_Max)
	for _, Hero in pairs(TargetSelector) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if FirstTarget then
                if Hero.Index ~= FirstTarget.Index  then
                    if Hero.Health < FirstTarget.Health then
                        if self:GetDistance(myHero.Position, Hero.Position) < self.WRange_Max then
                            return Hero, false
                        end    
                    else
                        if self:GetDistance(FirstTarget.Position, Hero.Position) < self.WRange_Laser then
                            return Hero, false
                        end        
                    end
                end
                return Hero, false
            else
                return Hero, false
            end
        end 
    end
    return nil, false
end

function Taliah:GetWCastPositionsCombo()
    local PlayerPos             = myHero.Position
    local FirstTarget           = Orbwalker:GetTarget("Combo", self.WRange_Min - 50)
    local SecondTarget, Force   = self:GetSecondETargetCombo(FirstTarget)
    
    local StartPos      = nil
    local MaxPredPos    = nil
    
    -- if FirstTarget and SecondTarget then
    --     StartPos        = FirstTarget.Position
    --     MaxPredPos      = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
    -- end

    -- if FirstTarget and SecondTarget == nil then
    --     print('2')
    --     StartPos        = FirstTarget.Position
    --     MaxPredPos      = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
    -- end
    if (StartPos == nil or Force == true)  and SecondTarget then
        -- if FirstTarget then
        --     local CheckPos = FirstTarget.Position
        --     PredPos      = Prediction:GetCastPos(CheckPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
        --     if self:GetDistance(CheckPos, PredPos) < self.ERange_Laser then
        --         print('1')
        --         return CheckPos, PredPos
        --     end
        -- end

        local factor = 200

        local TargetPos     = SecondTarget.Position
        local TargetVec     = Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
        local Distance      = math.sqrt((TargetVec.x * TargetVec.x) + (TargetVec.y * TargetVec.y) + (TargetVec.z * TargetVec.z))
        local VectorNorm    = Vector3.new(TargetVec.x / Distance, TargetVec.y / Distance, TargetVec.z / Distance)
        if self:GetDistance(myHero.Position, TargetPos) <= myHero.AttackRange + myHero.CharData.BoundingRadius then
            factor = 550
            StartPos      = Vector3.new(PlayerPos.x + (VectorNorm.x*(self.ERange_Min - factor)),PlayerPos.y + (VectorNorm.y*(self.ERange_Min - factor)),PlayerPos.z + (VectorNorm.z*(self.ERange_Min - factor)) ) 
            MaxPredPos    = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        else
            StartPos      = Vector3.new(PlayerPos.x + (VectorNorm.x*(self.ERange_Min - factor)),PlayerPos.y + (VectorNorm.y*(self.ERange_Min - factor)),PlayerPos.z + (VectorNorm.z*(self.ERange_Min - factor)) ) 
            MaxPredPos    = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        end
    end
    return StartPos, MaxPredPos
end
]]



function Taliyah:Combo()

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL3", PredPos, 1)
            return
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.WRange then
                return Engine:CastSpell2Points("HK_SPELL2", CastPos, myHero.Position, 0)
            end
        end
    end
    
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.QRange then
                return Engine:CastSpell("HK_SPELL1", CastPos, 1)
            end
        end
    end

    -- if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL2") then
    --     local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
    --     if PredPos ~= nil then
    --         Engine:CastSpell("HK_SPELL3", PredPos, 1)
    --         return
    --     end
    -- end

    

    

  --[[  if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target  then
            Engine:CastSpell("HK_SPELL2", PredPos, 1)
            return
        end
    end]]         -- DOESNT WORK CAUSE NEED TWO CAST POSITIONS
end
function Taliyah:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target and Orbwalker.ResetReady == 1  then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                    return
                end
            end
        end
    end
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target and Orbwalker.ResetReady == 1  then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end
    if self.HarassR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 0, self.RDelay, 0)
        if PredPos ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL4", PredPos, 1)
                return
            end
        end
    end
    local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 0, self.RDelay, 0)
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
        if PredPos ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end
end
function Taliyah:Laneclear()
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
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
                    Engine:CastSpell("HK_SPELL2", nil, 1)
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
function Taliyah:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
       -- Taliyah:Ultimate() --- WIP
        if Engine:IsKeyDown("HK_COMBO") then
            Taliyah:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Taliyah:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Taliyah:Laneclear()
		end
	end
end
function Taliyah:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
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
function Taliyah:OnLoad()
    if(myHero.ChampionName ~= "Taliyah") then return end
	AddEvent("OnSettingsSave" , function() Taliyah:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Taliyah:LoadSettings() end)
	Taliyah:__init()
	AddEvent("OnTick", function() Taliyah:OnTick() end)	
    AddEvent("OnDraw", function() Taliyah:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Taliyah:OnLoad() end)	
