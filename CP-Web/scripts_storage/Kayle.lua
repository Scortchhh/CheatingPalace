local Kayle = {
}

function Kayle:__init()

    self.QRange = 900
    self.QSpeed = 1600
    self.QWidth = 150
    self.QDelay = Orbwalker:GetPlayerAttackWindup()

    self.QHitChance = 0.2

    self.KayleMenu = Menu:CreateMenu("Kayle")
    self.KayleCombo = self.KayleMenu:AddSubMenu("Combo")
    self.KayleCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KayleCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWComboSelf = self.KayleCombo:AddCheckbox("Use W in combo for self", 1)
    self.UseWComboSelfSlider = self.KayleCombo:AddSlider("Use W on self below %HP", 60,1,100,1)
    self.UseWComboAlly = self.KayleCombo:AddCheckbox("Use W in combo for ally", 1)
    self.UseWComboAllySlider = self.KayleCombo:AddSlider("Use W on ally below %HP", 30,1,100,1)
    self.UseECombo = self.KayleCombo:AddCheckbox("Use E in combo", 1)
    self.KayleCombo:AddLabel("R usage based on enemies:")
    self.UseRComboSelf = self.KayleCombo:AddCheckbox("Use R on self based on enemies in combo", 1)
    self.UseRComboSelfSlider = self.KayleCombo:AddSlider("Use R if more then x enemies around self", 3,1,5,1)
    self.UseRComboAlly = self.KayleCombo:AddCheckbox("Use R on ally based on enemies in combo", 1)
    self.UseRComboAllySlider = self.KayleCombo:AddSlider("Use R if more then x enemies around ally", 3,1,5,1)
    self.KayleCombo:AddLabel("R usage based on % HP:")
    self.UseRComboSelfHP = self.KayleCombo:AddCheckbox("Use R on self based on %HP in combo", 1)
    self.UseRComboSelfHPSlider = self.KayleCombo:AddSlider("Use R if %HP below on self in combo", 20,1,100,1)
    self.UseRComboAllyHP = self.KayleCombo:AddCheckbox("Use R on ally based on %HP in combo", 1)
    self.UseRComboAllyHPSlider = self.KayleCombo:AddSlider("Use R if %HP below on ally in combo", 10,1,100,1)
    self.KayleHarass = self.KayleMenu:AddSubMenu("Harass")
    self.KayleHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KayleHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.KayleHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.KayleHarass:AddCheckbox("Use E in harass", 1)
    self.KayleLaneclear = self.KayleMenu:AddSubMenu("Laneclear")
    self.LaneclearQ = self.KayleLaneclear:AddCheckbox("Use Q in laneclear", 1)
    self.LaneclearE = self.KayleLaneclear:AddCheckbox("Use E in laneclear", 1)
    self.KayleDrawings = self.KayleMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KayleDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW = self.KayleDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawE = self.KayleDrawings:AddCheckbox("Use E in drawings", 1)
    self.DrawR = self.KayleDrawings:AddCheckbox("Use R in drawings", 1)
    Kayle:LoadSettings()
end

function Kayle:SaveSettings()
	SettingsManager:CreateSettings("Kayle")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo for self", self.UseWComboSelf.Value)
    SettingsManager:AddSettingsInt("Use W in combo for ally", self.UseWComboAlly.Value)
    SettingsManager:AddSettingsInt("Use W on self below %HP", self.UseWComboSelfSlider.Value)
    SettingsManager:AddSettingsInt("Use W on ally below %HP", self.UseWComboAllySlider.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R on self based on enemies in combo", self.UseRComboSelf.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies around self", self.UseRComboSelfSlider.Value)
    SettingsManager:AddSettingsInt("Use R on ally based on enemies in combo", self.UseRComboAlly.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies around ally", self.UseRComboAllySlider.Value)
    SettingsManager:AddSettingsInt("Use R on self based on %HP in combo", self.UseRComboSelfHP.Value)
    SettingsManager:AddSettingsInt("Use R if %HP below on self in combo", self.UseRComboSelfHPSlider.Value)
    SettingsManager:AddSettingsInt("Use R on ally based on %HP in combo", self.UseRComboAllyHP.Value)
    SettingsManager:AddSettingsInt("Use R if %HP below on ally in combo", self.UseRComboAllyHPSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in laneclear", self.LaneclearQ.Value)
    SettingsManager:AddSettingsInt("Use E in laneclear", self.LaneclearE.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Kayle:LoadSettings()
    SettingsManager:GetSettingsFile("Kayle")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWComboSelf.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo for self")
    self.UseWComboAlly.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo for ally")
    self.UseWComboSelfSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use W on self below %HP")
    self.UseWComboAllySlider.Value = SettingsManager:GetSettingsInt("Combo", "Use W on ally below %HP")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRComboSelf.Value = SettingsManager:GetSettingsInt("Combo", "Use R on self based on enemies in combo")
    self.UseRComboSelfSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies around self")
    self.UseRComboAlly.Value = SettingsManager:GetSettingsInt("Combo", "Use R on ally based on enemies in combo")
    self.UseRComboAllySlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies around ally")
    self.UseRComboSelfHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R on self based on %HP in combo")
    self.UseRComboSelfHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if %HP below on self in combo")
    self.UseRComboAllyHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R on ally based on %HP in combo")
    self.UseRComboAllyHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if %HP below on ally in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.LaneclearQ.Value = SettingsManager:GetSettingsInt("Laneclear", "Use Q in laneclear")
    self.LaneclearE.Value = SettingsManager:GetSettingsInt("Laneclear", "Use E in laneclear")
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

function Kayle:Healing()
    if self.UseWComboSelf.Value == 1 and Engine:SpellReady('HK_SPELL2') then
        local healCondition = myHero.MaxHealth / 100 * self.UseWComboSelfSlider.Value
        if myHero.Health <= healCondition then
            Engine:CastSpell('HK_SPELL2', nil, 0)
        end
    end
    if self.UseWComboAlly.Value == 1 and Engine:SpellReady('HK_SPELL2') then
        for i, Ally in pairs(ObjectManager.HeroList) do
            if myHero.Team == Ally.Team and Ally.IsDead == false then
                local healCondition = Ally.MaxHealth / 100 * self.UseWComboAllySlider.Value
                if Ally.Health <= healCondition and GetDist(myHero.Position, Ally.Position) <= 900 then
                    Engine:CastSpell('HK_SPELL2', Ally.Position, 1)
                end
            end
        end
    end
end

function Kayle:Ultimate()
    if Engine:SpellReady("HK_SPELL4") then 
        if self.UseRComboSelf.Value == 1 then
            local Rcondition = EnemiesInRange(myHero.Position, 500)
            if Rcondition >= self.UseRComboSelfSlider.Value then
                Engine:CastSpell('HK_SPELL4', myHero.Position, 1)
            end
        end

        if self.UseRComboSelfHP.Value == 1 then
            local Rcondition = myHero.MaxHealth / 100 * self.UseRComboSelfHPSlider.Value
            if myHero.Health <= Rcondition then
                Engine:CastSpell('HK_SPELL4', myHero.Position, 1)
            end
        end

        if self.UseRComboAlly.Value == 1 then
            for i, Ally in pairs(ObjectManager.HeroList) do
                if myHero.Team == Ally.Team and Ally.IsDead == false and Ally.ChampionName ~= myHero.ChampionName then
                    local Rcondition = EnemiesInRange(Ally.Position, 500)
                    if Rcondition >= self.UseRComboAllySlider.Value then
                        Engine:CastSpell('HK_SPELL4', Ally.Position, 1)
                    end
                end
            end
        end

        if self.UseRComboAllyHP.Value == 1 then
            for i, Ally in pairs(ObjectManager.HeroList) do
                if myHero.Team == Ally.Team and Ally.IsDead == false and Ally.ChampionName ~= myHero.ChampionName then
                    local Rcondition = Ally.MaxHealth / 100 * self.UseRComboAllyHPSlider.Value
                    if Ally.Health <= Rcondition then
                        Engine:CastSpell('HK_SPELL4', Ally.Position, 1)
                    end
                end
            end
        end
    end
end

function Kayle:Combo()
    Kayle:Ultimate()
    Kayle:Healing()
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then
        local LethalTempo = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Precision/LethalTempo/LethalTempoEmpowered.lua")

        if GetDist(myHero.Position, target.Position) <= 900 and not LethalTempo.Valid then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil and Orbwalker.Attack == 0 then
                if Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 then
                    Engine:CastSpell('HK_SPELL1', PredPos, 1)
                end
            end
        end
        if myHero.Level >= 16 then
            if GetDist(myHero.Position, target.Position) <= getAttackRange() and Orbwalker.ResetReady == 1 then
                if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', nil, 0)
                end
            end
        else
            if GetDist(myHero.Position, target.Position) <= 550 and Orbwalker.ResetReady == 1 then
                if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', nil, 0)
                end
            end
        end
    end
end

function Kayle:Harass()
    local target = Orbwalker:GetTarget("Harass", 700)
    if target then
        if GetDist(myHero.Position, target.Position) > getAttackRange() + 50 and GetDist(myHero.Position, target.Position) <= 500 then
            if Orbwalker.Attack == 0 then
                if Engine:SpellReady('HK_SPELL3') and self.UseEHarass.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', nil, 0)
                end
            end
        end

        if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 and Orbwalker.ResetReady == 1 then
            if Engine:SpellReady('HK_SPELL2') and self.UseWHarass.Value == 1 then
                Engine:CastSpell('HK_SPELL2', nil)
                -- to proc that it will actually use it as AA reset
                Engine:AttackClick(target.Position, 1)
            end
        end
        
        if GetDist(myHero.Position, target.Position) >= getAttackRange() - 60 and GetDist(myHero.Position, target.Position) <= 420 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil and Orbwalker.Attack == 0 then
                if Engine:SpellReady('HK_SPELL1') and self.UseQHarass.Value == 1 then
                    Engine:CastSpell('HK_SPELL1', PredPos, 0)
                end
            end
        end
    end
end

function Kayle:Laneclear()
    local target = Orbwalker:GetTarget("Laneclear", 700)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.LaneclearQ.Value == 1 and Orbwalker.ResetReady == 1 then
            return Engine:CastSpell("HK_SPELL1", target.Position, 0)
        end
        if Engine:SpellReady("HK_SPELL3") and self.LaneclearE.Value == 1 and Orbwalker.ResetReady == 1 then
            return Engine:CastSpell("HK_SPELL3", nil, 0)
        end
    end
end

function Kayle:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Kayle:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Kayle:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            self:Laneclear()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- target.BuffData:ShowAllBuffs()
end

function Kayle:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 900,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 900,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 550,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 900,255,0,255,255)
        end
    end
end

function Kayle:OnLoad()
    if myHero.ChampionName ~= "Kayle" then return end
    AddEvent("OnSettingsSave" , function() Kayle:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kayle:LoadSettings() end)
    Kayle:__init()
    AddEvent("OnDraw", function() Kayle:OnDraw() end)
    AddEvent("OnTick", function() Kayle:OnTick() end)
end

AddEvent("OnLoad", function() Kayle:OnLoad() end)	