local Talon = {}

function Talon:__init()

    --self.QRange = 
    self.QRange = 575
    self.WRange = 900
    self.ERange = 725
    self.RRange = 550

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QDelay = math.huge
    self.WDelay = math.huge
    self.EDelay = math.huge
    self.RDelay = math.huge
    

    self.ScriptVersion = "          --KKTalon Version: 0.1-- ///Credits KKat///"

	self.TalonMenu = Menu:CreateMenu("Talon")
	self.TalonCombo = self.TalonMenu:AddSubMenu("Combo")
	self.TalonCombo:AddLabel("Check Spells for Combo:")
	self.UseQCombo = self.TalonCombo:AddCheckbox("Use Q in combo", 1)
	self.UseWCombo = self.TalonCombo:AddCheckbox("Use W in combo", 1)
	self.UseRCombo = self.TalonCombo:AddCheckbox("Use R in combo", 1)
    self.UseRComboSlider = self.TalonCombo:AddSlider("Use R if more then x enemies in R range", 3, 1, 4, 1)
	self.TalonHarass = self.TalonMenu:AddSubMenu("Harass")
	self.TalonHarass:AddLabel("Check Spells for Harass")
	self.UseQHarass = self.TalonHarass:AddCheckbox("Use Q in harass", 1)
	self.UseWHarass = self.TalonHarass:AddCheckbox("Use W in harass", 1)
    self.TalonFarm = self.TalonMenu:AddSubMenu("Farm")
    self.TalonFarm:AddLabel("Check Spells for Farm")
    self.UseQFarm = self.TalonFarm:AddCheckbox("Use Q in Farm", 1)
    self.UseWFarm = self.TalonFarm:AddCheckbox("Use W in Farm", 1)
	self.TalonDrawings = self.TalonMenu:AddSubMenu("Drawings")
	self.DrawQ = self.TalonDrawings:AddCheckbox("Use Q in drawings", 1)
	self.DrawE = self.TalonDrawings:AddCheckbox("Use E in drawings", 1)
	self.DrawW = self.TalonDrawings:AddCheckbox("Use W in drawings", 1)
	self.DrawR = self.TalonDrawings:AddCheckbox("Use R in drawings", 1)
	Talon:LoadSettings()
end

function Talon:SaveSettings()
	SettingsManager:CreateSettings("Talon")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.UseRComboSlider.Value)
	------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
	SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
	------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Farm")
    SettingsManager:AddSettingsInt("Use Q in Farm", self.UseQFarm.Value)
    SettingsManager:AddSettingsInt("Use W in Farm", self.UseWFarm.Value)
    ------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
	SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Talon:LoadSettings()
	SettingsManager:GetSettingsFile("Talon")
	self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
	self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
	self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.UseRComboSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
	-------------------------------------------
	self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
	self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
	-------------------------------------------
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use Q in Farm")
    self.UseWFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use W in Farm")
    -------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
	return math.sqrt((target.x - source.x) ^2 + (target.z - source.z) ^2)
end

local function GetDamage(rawDmg, isPhys, target)
	if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
	if not isPhys then return (100 / (100 + target.MagicResist)) *rawDmg end
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

function Talon:Combo()
	if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 60, self.WDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end
	if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if EnemiesInRange(target.Position, 200) > self.UseRComboSlider.Value == 1 then
                if GetDist(myHero.Position, target.Position) > getAttackRange() then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 60, self.RDelay, 0)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    end
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
            local TalonPassiveStack = target.BuffData:GetBuff("TalonPassiveStack")
                if TalonPassiveStack.Valid then
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL1",  target.Position)
                    end
                end
    end
end

function Talon:Harass()
    if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 60, self.WDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
            local TalonPassiveStack = target.BuffData:GetBuff("TalonPassiveStack")
                if TalonPassiveStack.Valid then
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL1",  target.Position)
                    end
                end
    end
end

function Talon:Laneclear()
    if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target == nil then return end
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 60, self.WDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL1",  target.Position)
                    end
    end
end


function Talon:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			Talon:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Talon:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Talon:Laneclear()
			return
		end
	end
end

function Talon:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 174, 87, 56, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 77, 255, 228, 255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 77, 210, 255)
    end
end

			
function Talon:OnLoad()
	if(myHero.ChampionName ~= "Talon") then return end
    AddEvent("OnSettingsSave" , function() Talon:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Talon:LoadSettings() end)
    

    Talon:__init()
    AddEvent("OnDraw", function() Talon:OnDraw() end)
    AddEvent("OnTick", function() Talon:OnTick() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Talon:OnLoad() end)