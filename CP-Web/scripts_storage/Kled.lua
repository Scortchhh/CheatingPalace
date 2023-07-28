--Credits to Critic, Scortch, Christoph

Kled = {} 

function Kled:__init() 

    
    self.QMRange = 800
    self.EMRange = 550
    self.QRange = 700

    self.QMSpeed = math.huge
    self.QMWidth = 100
    self.EMSpeed = math.huge
    self.QSpeed = 3000
    self.QWidth = 80

    self.EMWidth = 100

    self.QMDelay = 0.25
    self.EMDelay = 0
    self.QDelay = 0.25

    self.QHitChance = 0.2
    self.EHitChance = 0.2

    self.ScriptVersion = "         Kled Ver: 1.00 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Kled") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    --------------------------------------------
    Kled:LoadSettings()  
end 

function Kled:SaveSettings() 

    SettingsManager:CreateSettings("Kled")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    --------------------------------------------
end

function Kled:LoadSettings()
    SettingsManager:GetSettingsFile("Kled")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")

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

--KledRiderQ

function Kled:Combo()

    --mounted abilities

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QMRange, self.QMSpeed, self.QMWidth, self.QMDelay, 1, true, self.QHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.EMRange, self.EMSpeed, self.EMWidth, self.EMDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL3", PredPos, 1)
            return
        end
    end

    --unmounted
    local Info = myHero:GetSpellSlot(0).Info.Name
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Info == ("KledRiderQ") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

end


function Kled:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QMRange, self.QMSpeed, self.QMWidth, self.QMDelay, 1, true, self.QHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.EMRange, self.EMSpeed, self.EMWidth, self.EMDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL3", PredPos, 1)
            return
        end
    end

    --unmounted
    local Info = myHero:GetSpellSlot(0).Info.Name
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Info == ("KledRiderQ") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end
end

function Kled:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QMRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QMRange then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
                return
            end
        end
    end

    local Info = myHero:GetSpellSlot(0).Info.Name
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 and Info == ("KledRiderQ") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
                return
            end
        end
    end


    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.EMRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.EMRange then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
    end
end

--end---


function Kled:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Kled:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Kled:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Kled:Laneclear()
		end
	end
end

function Kled:OnDraw()

    local Infoq = myHero:GetSpellSlot(0).Info.Name
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 and Infoq == ("KledQ") then
        Render:DrawCircle(myHero.Position, self.QMRange ,0,255,0,255)
    end
    local Info = myHero:GetSpellSlot(0).Info.Name
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 and Info == ("KledRiderQ") then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.EMRange ,100,150,255,255)
    end
end

function Kled:OnLoad()
    if(myHero.ChampionName ~= "Kled") then return end
	AddEvent("OnSettingsSave" , function() Kled:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kled:LoadSettings() end)


	Kled:__init()
	AddEvent("OnTick", function() Kled:OnTick() end)	
    AddEvent("OnDraw", function() Kled:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Kled:OnLoad() end)	
