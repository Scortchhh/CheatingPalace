
Ornn = {} 
function Ornn:__init()

    self.KeyNames = {}
    
    self.KeyNames[4]         = "HK_SUMMONER1"
    self.KeyNames[5]         = "HK_SUMMONER2"
    
    self.KeyNames[6]         = "HK_ITEM1"
    self.KeyNames[7]         = "HK_ITEM2"
    self.KeyNames[8]         = "HK_ITEM3"
    self.KeyNames[9]         = "HK_ITEM4"
    self.KeyNames[10]         = "HK_ITEM5"
    self.KeyNames[11]        = "HK_ITEM6"

    self.QRange = 750
    self.WRange = 175
    self.ERange = 650 
    self.RRange = 2550

    self.QWidth = 130
    self.WWidth = 175
    self.EWidth = myHero.CharData.BoundingRadius
    self.RWidth = 340

    self.QSpeed = 1800
    self.WSpeed = math.huge
    self.ESpeed = 1600
    self.RSpeed = 1200

    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0.35
    self.RDelay = 0.5

    self.QTimer = nil
    self.QPosition = nil
    self.RActive = false

    self.ChampionMenu = Menu:CreateMenu("Ornn") 
    
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 1, 4, 1)
    
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1)

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    Ornn:LoadSettings()  
end 

-- Save Settings Function
function Ornn:SaveSettings() 
    
    SettingsManager:CreateSettings("Ornn")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)

    -- HARASS
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
 
	-- DRAW
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end
-- Load Settings Function
function Ornn:LoadSettings()
    SettingsManager:GetSettingsFile("Ornn")
    
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
   
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
   
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
end

function Ornn:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Ornn:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Ornn:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Ornn:ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Ornn:EnemiesInRange(Position, Range)
	local Count = 0 
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Ornn:MinionsInRange(Position, Range)
	local Count = 0 
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if self:GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Ornn:SortToLowestHealth(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        if Object.Health > 0 then
            SortedTable[#SortedTable + 1] = Object
        end
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return left.Health < right.Health
        end)
    end
    return SortedTable
end    

function Ornn:AlliesInRange(Position, Range)
    local Count = 0 
    local HeroList = ObjectManager.HeroList
    for I,Hero in pairs(HeroList) do    
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if self:GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Ornn:ResetQ()
    if self.QTimer ~= nil and self.QPosition ~= nil then
        if GameClock.Time > self.QTimer then
            self.QTimer = nil
            self.QPosition = nil
        end
    end
end

function Ornn:R2()
    if Engine:SpellReady("HK_SPELL4") and self.RActive then
        local TroyList = ObjectManager.TroyList
        for _, Troy in pairs(TroyList) do 
            if Troy.Name == "Ornn_Base_R_Wave_Mis" then
                if self:GetDist(myHero.Position, Troy.Position) <= 450 then
                    local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, 0, 0.1, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL4", CastPos, 1)
                        self.RActive = false
                        return
                    end
                end
            end
        end
    end
end

function Ornn:Combo()
    local target = Orbwalker:GetTarget("Combo", self.RRange)
    if target and Engine:SpellReady("HK_SPELL1") and self.ComboR.Value == 1 and not self.RActive then
        local enemiesAround = self:EnemiesInRange(target.Position, 400)
        if enemiesAround >= self.ComboRSlider.Value then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, 0, 0.1, 1)
            if CastPos then
                Engine:CastSpell("HK_SPELL4", CastPos, 1)
                self.RActive = true
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 1, 0.2, 1)
            if CastPos then
                self.QPosition = CastPos
                self.QTimer = GameClock.Time + 5.25
                return Engine:CastSpell("HK_SPELL1", CastPos, 1)
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if self.QPosition ~= nil and GameClock.Time >= self.QTimer - 4 then
                if self:GetDist(self.QPosition, target.Position) <= 200 then -- effect radius of pillar hit for knockup
                    return Engine:CastSpell("HK_SPELL3", self.QPosition, 1)
                end
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if self:GetDist(myHero.Position, target.Position) <= self.WRange then
                return Engine:CastSpell("HK_SPELL2", target.Position, 1)
            end
        end
    end
end

function Ornn:Harass() 
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 1, 0.2, 1)
            if CastPos then
                self.QPosition = CastPos
                self.QTimer = GameClock.Time + 4
                return Engine:CastSpell("HK_SPELL1", CastPos, 1)
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target then
            if self.QPosition ~= nil and GameClock.Time >= self.QTimer - 4 then
                if self:GetDist(self.QPosition, target.Position) <= 200 then -- effect radius of pillar hit for knockup
                    return Engine:CastSpell("HK_SPELL3", self.QPosition, 1)
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            if self:GetDist(myHero.Position, target.Position) <= self.WRange then
                return Engine:CastSpell("HK_SPELL2", target.Position, 1)
            end
        end
    end
end

function Ornn:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:ResetQ()
        self:R2()
        if Engine:IsKeyDown("HK_COMBO") then
            Ornn:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Ornn:Harass()
        end
    end
end

function Ornn:OnDraw()
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

function Ornn:OnLoad()
    if(myHero.ChampionName ~= "Ornn") then return end
	AddEvent("OnSettingsSave" , function() Ornn:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ornn:LoadSettings() end)
	Ornn:__init()
	AddEvent("OnTick", function() Ornn:OnTick() end)	
    AddEvent("OnDraw", function() Ornn:OnDraw() end)
end
AddEvent("OnLoad", function() Ornn:OnLoad() end)	