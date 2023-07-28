local Malphite = {

}

function Malphite:__init()

    self.RRange = 1000
    self.RSpeed = 1500 + myHero.MovementSpeed
    self.RWidth = 325
    self.RDelay = 0
    
    self.MalphiteMenu = Menu:CreateMenu("Malphite")
    self.MalphiteCombo = self.MalphiteMenu:AddSubMenu("Combo")
    self.MalphiteCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.MalphiteCombo:AddCheckbox("UseQ in combo", 1)
    self.UseWCombo = self.MalphiteCombo:AddCheckbox("UseW in combo", 1)
    self.UseECombo = self.MalphiteCombo:AddCheckbox("UseE in combo", 1)
    self.UseRCombo = self.MalphiteCombo:AddCheckbox("UseR in combo", 1)
    self.RSettings = self.MalphiteCombo:AddSubMenu("R Settings")
    self.RCount = self.RSettings:AddSlider("Use R on x Enemies", 3,1,5,1)
    self.MalphiteHarass = self.MalphiteMenu:AddSubMenu("Harass")
    self.MalphiteHarass:AddLabel("Check Spells for Harass:")
    self.UseWHarass = self.MalphiteHarass:AddCheckbox("UseW in harass", 1)
    self.UseEHarass =self.MalphiteHarass:AddCheckbox("UseE in harass", 1)
    self.MalphiteDrawings = self.MalphiteMenu:AddSubMenu("Drawings")
    self.DrawQ = self.MalphiteDrawings:AddCheckbox("UseQ in drawings", 1)
    self.DrawE = self.MalphiteDrawings:AddCheckbox("UseE in drawings", 1)
    self.DrawR = self.MalphiteDrawings:AddCheckbox("UseR in drawings", 1)
    Malphite:LoadSettings()
end

function Malphite:SaveSettings()
	SettingsManager:CreateSettings("Malphite")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R on x Enemies", self.RCount.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("UseE in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("UseE in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("UseR in drawings", self.DrawR.Value)
end

function Malphite:LoadSettings()
    SettingsManager:GetSettingsFile("Malphite")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR in combo")
    self.RCount.Value = SettingsManager:GetSettingsInt("Combo", "Use R on x Enemies")
    -------------------------------------------
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseE in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "UseE in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "UseR in drawings")
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
    if not isPhys then return (100 / (100 + target.MR)) * rawDmg end
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

function Malphite:Q()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Combo", 650)
        if target then
            if ValidTarget(target) then
                if GetDist(myHero.Position, target.Position) <= 625 then
                    Engine:CastSpell('HK_SPELL1', target.Position, 1)
                end
            end
        end
    end
end

function Malphite:W()
    if Engine:SpellReady('HK_SPELL2') then
        local target = Orbwalker:GetTarget("Combo", getAttackRange())
        if target and Orbwalker.ResetReady == 1 then
            if ValidTarget(target) then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                    Engine:CastSpell('HK_SPELL2', nil, 1)
                end
            end
        end
    end
end

function Malphite:E()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 450)
        if target then
            if ValidTarget(target) then
                if GetDist(myHero.Position, target.Position) <= 390 then
                    Engine:CastSpell('HK_SPELL3', nil, 1)
                end
            end
        end
    end
end

function Malphite:R()
    if Engine:SpellReady('HK_SPELL4') then
        local castPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 0)
        if castPos ~= nil then
            local targetCount = EnemiesInRange(castPos, 370)
            if targetCount >= self.RCount.Value then
                Engine:CastSpell("HK_SPELL4", castPos,1)
            end
        end
    end
end

function Malphite:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseQCombo.Value == 1 then
                Malphite:Q()
            end
            if self.UseECombo.Value == 1 then
                Malphite:E()
            end
            if self.UseWCombo.Value == 1 then
                Malphite:W()
            end
            if self.UseRCombo.Value == 1 then
                Malphite:R()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseECombo.Value == 1 then
                Malphite:E()
            end
            if self.UseWCombo.Value == 1 then
                Malphite:W()
            end
        end
    end
    -- local heroBuff = myHero.BuffManager.Buffs
    -- for k,v in heroBuff:pairs() do
    --     print(v.Name)
    -- end
end

function Malphite:OnDraw()
    if myHero.IsDead == true then return end
    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 625,255,0,255,255)
        end
    end
    if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 400,255,0,255,255)
        end
    end
    if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 1000,255,0,255,255)
        end
    end
end

function Malphite:OnLoad()
    if myHero.ChampionName ~= "Malphite" then return end
    AddEvent("OnSettingsSave" , function() Malphite:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Malphite:LoadSettings() end)
    Malphite:__init()
    AddEvent("OnDraw", function() Malphite:OnDraw() end)
    AddEvent("OnTick", function() Malphite:OnTick() end)
end

AddEvent("OnLoad", function() Malphite:OnLoad() end)	