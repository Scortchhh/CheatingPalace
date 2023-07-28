local Diana = {

}

function Diana:__init()

    self.QRange = 900
    self.QSpeed = 2100
    self.QWidth = 70
    self.QDelay = 0.25

    self.QHitChance = 0.5

    self.DianaMenu = Menu:CreateMenu("Diana")
    self.DianaCombo = self.DianaMenu:AddSubMenu("Combo")
    self.DianaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.DianaCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.DianaCombo:AddCheckbox("Use W in combo", 1)
    self.WHPSliderCombo = self.DianaCombo:AddSlider("Use W below % HP combo mode", 20,1,100,1)
    self.UseECombo = self.DianaCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.DianaCombo:AddCheckbox("Use R in combo if killable", 1)
    self.UseRComboEnemies = self.DianaCombo:AddCheckbox("Use R in combo on X enemies", 0)
    self.UseRComboEnemiesSlider = self.DianaCombo:AddSlider("Use R in combo if X enemies hittable", 3,1,5,1)
    self.DianaHarass = self.DianaMenu:AddSubMenu("Harass")
    self.DianaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.DianaHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.DianaHarass:AddCheckbox("Use W in harass", 1)
    self.WHPSliderHarass = self.DianaHarass:AddSlider("Use W below % HP harass mode", 20,1,100,1)
    self.UseEHarass = self.DianaHarass:AddCheckbox("Use E in harass", 1)
    self.UseRHarass = self.DianaHarass:AddCheckbox("Use R in harass", 1)
    self.DianaDrawings = self.DianaMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DianaDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawE = self.DianaDrawings:AddCheckbox("Use E in drawings", 1)
    self.DrawR = self.DianaDrawings:AddCheckbox("Use R in drawings", 1)
    Diana:LoadSettings()
end

function Diana:SaveSettings()
	SettingsManager:CreateSettings("Diana")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use W below % HP combo mode", self.WHPSliderCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo if killable", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo on X enemies", self.UseRComboEnemies.Value)
    SettingsManager:AddSettingsInt("Use R in combo if X enemies hittable", self.UseRComboEnemiesSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use W below % HP harass mode", self.WHPSliderHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Use R in harass", self.UseRHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Diana:LoadSettings()
    SettingsManager:GetSettingsFile("Diana")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.WHPSliderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W below % HP combo mode")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo if killable")
    self.UseRComboEnemies.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo on X enemies")
    self.UseRComboEnemiesSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo if X enemies hittable")
    -------------------------------------------
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.WHPSliderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W below % HP harass mode")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Harass", "Use R in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
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

function Diana:Combo()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
            local WHP = self.WHPSliderCombo.Value
            local WCondition = myHero.MaxHealth / 100 * WHP
            if myHero.Health <= WCondition then
                Engine:CastSpell("HK_SPELL2", nil)
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 then
                Engine:CastSpell("HK_SPELL2", nil)
            end
        end
        if Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos ~= nil and GetDist(myHero.Position, target.Position) <= 900 then
                Engine:CastSpell("HK_SPELL1", PredPos,1)
            end
        end
        if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
            local moonlightedEnemy = target.BuffData:GetBuff("dianamoonlight")
            if GetDist(myHero.Position, target.Position) <= 800 then
                if moonlightedEnemy.Valid then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                else
                    local eDmg = GetDamage(20 + (20 * myHero:GetSpellSlot(2).Level) + 0.4 * myHero.AbilityPower, false, target)
                    if target.Health <= eDmg then
                        Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    end
                end
            end
        end
        if Engine:SpellReady('HK_SPELL4') then
            if self.UseRCombo.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= 480 then
                    local enemiesinRRange = EnemiesInRange(myHero.Position, 500)
                    local multiplierPerEnemy = (10 + (25 * myHero:GetSpellSlot(3).Level)) * enemiesinRRange + 0.15 * myHero.AbilityPower
                    local rDmg = GetDamage(100 + (100 * myHero:GetSpellSlot(3).Level) + 0.6 * myHero.AbilityPower, false, target)
                    local totalRDmg = multiplierPerEnemy + rDmg
                    if target.Health <= totalRDmg then
                        Engine:CastSpell("HK_SPELL4", nil)
                    end
                end
            end
            if self.UseRComboEnemies.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= 480 then
                    local enemiesinRRange = EnemiesInRange(myHero.Position, 500)
                    local useROnXEnemies = self.UseRComboEnemiesSlider.Value
                    if enemiesinRRange >= useROnXEnemies then
                        Engine:CastSpell("HK_SPELL4", nil)
                    end
                end
            end
        end
    end
end

function Diana:Harass()
    local target = Orbwalker:GetTarget("Harass", 1000)
    if target then
        if Engine:SpellReady('HK_SPELL2') and self.UseWHarass.Value == 1 then
            local WHP = self.WHPSliderHarass.Value
            local WCondition = myHero.MaxHealth / 100 * WHP
            if myHero.Health <= WCondition then
                Engine:CastSpell("HK_SPELL2", nil)
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 then
                Engine:CastSpell("HK_SPELL2", nil)
            end
        end
        if Engine:SpellReady('HK_SPELL1') and self.UseQHarass.Value == 1 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos ~= nil and GetDist(myHero.Position, target.Position) <= 900 then
                Engine:CastSpell("HK_SPELL1", PredPos,1)
            end
        end
        if Engine:SpellReady('HK_SPELL3') and self.UseEHarass.Value == 1 then
            local moonlightedEnemy = target.BuffData:GetBuff("dianamoonlight")
            if GetDist(myHero.Position, target.Position) <= 800 then
                if moonlightedEnemy.Valid then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                else
                    local eDmg = GetDamage(20 + (20 * myHero:GetSpellSlot(2).Level) + 0.4 * myHero.AbilityPower, false, target)
                    if target.Health <= eDmg then
                        Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    end
                end
            end
        end
        if Engine:SpellReady('HK_SPELL4') and self.UseRHarass.Value == 1 then
            if GetDist(myHero.Position, target.Position) <= 480 then
                local enemiesinRRange = EnemiesInRange(myHero.Position, 500)
                local multiplierPerEnemy = (10 + (25 * myHero:GetSpellSlot(3).Level)) * enemiesinRRange + 0.15 * myHero.AbilityPower
                local rDmg = GetDamage(100 + (100 * myHero:GetSpellSlot(3).Level) + 0.6 * myHero.AbilityPower, false, target)
                local totalRDmg = multiplierPerEnemy + rDmg
                if target.Health <= totalRDmg then
                    Engine:CastSpell("HK_SPELL4", nil)
                end
            end
        end
    end
end

function Diana:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Diana:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Diana:Harass()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- target.BuffData:ShowAllBuffs()
end

function Diana:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        local isSpider = myHero.BuffData:GetBuff("DianaR")
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 875,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 820,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 480,255,0,255,255)
        end
    end
end

function Diana:OnLoad()
    if myHero.ChampionName ~= "Diana" then return end
    AddEvent("OnSettingsSave" , function() Diana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Diana:LoadSettings() end)
    Diana:__init()
    AddEvent("OnDraw", function() Diana:OnDraw() end)
    AddEvent("OnTick", function() Diana:OnTick() end)
end

AddEvent("OnLoad", function() Diana:OnLoad() end)	