local Rumble = {}

function Rumble:__init()

    --self.QRange = 
    self.QRange = 600
    self.WRange = myHero.AttackRange + 50
    self.ERange = 850
    self.RRange = 1700

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 2000
    self.RSpeed = math.huge

    self.QDelay = math.huge
    self.WDelay = math.huge
    self.EDelay = 0.25
    self.RDelay = 0.65
    

    self.ScriptVersion = "          --KKRumble Version: 0.1-- ///Credits KKat///"

	self.RumbleMenu = Menu:CreateMenu("Rumble")
	self.RumbleCombo = self.RumbleMenu:AddSubMenu("Combo")
	self.RumbleCombo:AddLabel("Check Spells for Combo:")
	self.UseQCombo = self.RumbleCombo:AddCheckbox("Use Q in combo", 1)
	self.UseWCombo = self.RumbleCombo:AddCheckbox("Use W in combo", 1)
	self.UseECombo = self.RumbleCombo:AddCheckbox("Use E in combo", 1)
	self.UseRCombo = self.RumbleCombo:AddCheckbox("Use R in combo", 1)
	self.UseRComboSlider = self.RumbleCombo:AddSlider("Use R if more then x enemies in R range", 3, 1, 4, 1)
	self.RumbleHarass = self.RumbleMenu:AddSubMenu("Harass")
	self.RumbleHarass:AddLabel("Check Spells for Harass")
	self.UseQHarass = self.RumbleHarass:AddCheckbox("Use Q in harass", 1)
	self.UseWHarass = self.RumbleHarass:AddCheckbox("Use W in harass", 1)
	self.UseEHarass = self.RumbleHarass:AddCheckbox("Use E in harass", 1)
    self.RumbleFarm = self.RumbleMenu:AddSubMenu("Farm")
    self.RumbleFarm:AddLabel("Check Spells for Farm")
    self.UseQFarm = self.RumbleFarm:AddCheckbox("Use Q in Farm", 1)
    self.UseWFarm = self.RumbleFarm:AddCheckbox("Use W in Farm", 1)
    self.UseEFarm = self.RumbleFarm:AddCheckbox("Use E in Farm", 1)
	self.RumbleDrawings = self.RumbleMenu:AddSubMenu("Drawings")
	self.DrawQ = self.RumbleDrawings:AddCheckbox("Use Q in drawings", 1)
	self.DrawE = self.RumbleDrawings:AddCheckbox("Use E in drawings", 1)
	self.DrawW = self.RumbleDrawings:AddCheckbox("Use W in drawings", 1)
	self.DrawR = self.RumbleDrawings:AddCheckbox("Use R in drawings", 1)
	Rumble:LoadSettings()
end

function Rumble:SaveSettings()
	SettingsManager:CreateSettings("Rumble")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
	SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
	SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.UseRComboSlider.Value)
	------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
	SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
	SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Farm")
    SettingsManager:AddSettingsInt("Use Q in Farm", self.UseQFarm.Value)
    SettingsManager:AddSettingsInt("Use W in Farm", self.UseWFarm.Value)
    SettingsManager:AddSettingsInt("Use E in Farm", self.UseEFarm.Value)
    ------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
	SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Rumble:LoadSettings()
	SettingsManager:GetSettingsFile("Rumble")
	self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
	self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
	self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
	self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
	self.UseRComboSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
	-------------------------------------------
	self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
	self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
	self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
	-------------------------------------------
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use Q in Farm")
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use E in Farm")
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use W in Farm")
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

function Rumble:Combo()
    if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if EnemiesInRange(target.Position, 200) > self.UseRComboSlider.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end
        end
    end
	if Engine:SpellReady("HK_SPELL2") then
		if self.UseWCombo.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
				return
			end
		end
	end
	if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
            end
        end
    end
end

 function Rumble:Harass()
	if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end
        end
    end
	if Engine:SpellReady("HK_SPELL2") then
		if self.UseWCombo.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
				return
			end
		end
	end
	if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
            end
        end
    end
end

function Rumble:Laneclear()
	local QRange = getAttackRange() -20
	local target = Orbwalker:GetTarget("Laneclear", QRange)
	if target == nil then return end
	if not ValidTarget(target) then return end
		if GetDist(myHero.Position, target.Position) <= QRange then
			if Engine:SpellReady("HK_SPELL1") and self.UseQFarm.Value == 1 and Orbwalker.WindingUp == 0 then
			Engine:CastSpell("HK_SPELL1", Vector3.new())
			end
		end
		if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
        end
		if Engine:SpellReady("HK_SPELL2") then
		if self.UseWCombo.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
				return
			end
		end
	end
end


















		    

function Rumble:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			Rumble:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Rumble:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Rumble:Laneclear()
			return
		end
	end
end

function Rumble:OnDraw()
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 77, 255, 228, 255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, 925, 255, 249, 77, 255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 77, 210, 255)
    end
end

			
function Rumble:OnLoad()
	if(myHero.ChampionName ~= "Rumble") then return end
    AddEvent("OnSettingsSave" , function() Rumble:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Rumble:LoadSettings() end)
    

    Rumble:__init()
    AddEvent("OnDraw", function() Rumble:OnDraw() end)
    AddEvent("OnTick", function() Rumble:OnTick() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Rumble:OnLoad() end)