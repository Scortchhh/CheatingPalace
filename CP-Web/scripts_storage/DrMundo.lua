local DrMundo = {

}

function DrMundo:__init()

    self.QRange = 1050
    self.QSpeed = 2000
    self.QWidth = 120
    self.QDelay = 0.25

    self.QHitChance = 0.5
    
    self.DrMundoMenu        = Menu:CreateMenu("DrMundo")
    --------------------------------------------------------------
    self.DrMundoCombo       = self.DrMundoMenu:AddSubMenu("Combo")
    self.DrMundoCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo          = self.DrMundoCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo          = self.DrMundoCombo:AddCheckbox("Use W in combo", 1)
    self.WHPSliderCombo     = self.DrMundoCombo:AddSlider("Use W below % HP combo mode", 70,1,100,1)
    self.UseECombo          = self.DrMundoCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo          = self.DrMundoCombo:AddCheckbox("Use R in combo", 1)
    self.RHPSliderCombo     = self.DrMundoCombo:AddSlider("Use R below % HP combo mode", 13,1,100,1)
    ---------------------------------------------------------------
    self.DrMundoHarass      = self.DrMundoMenu:AddSubMenu("Harass")
    self.DrMundoHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass         = self.DrMundoHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass         = self.DrMundoHarass:AddCheckbox("Use W in harass", 1)
    self.WHPSliderHarass    = self.DrMundoHarass:AddSlider("Use W below % HP harass mode", 70,1,100,1)
    self.UseEHarass         = self.DrMundoHarass:AddCheckbox("Use E in harass", 1)
    self.UseRHarass         = self.DrMundoHarass:AddCheckbox("Use R in harass", 1)
    self.RHPSliderHarass    = self.DrMundoHarass:AddSlider("Use R below % HP harass mode", 40,1,100,1)
    --------------------------------------------------------------
    self.DrMundoDrawings    = self.DrMundoMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.DrMundoDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW              = self.DrMundoDrawings:AddCheckbox("Use W in drawings", 1)
    DrMundo:LoadSettings()
end

function DrMundo:SaveSettings()
	SettingsManager:CreateSettings("DrMundo")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use W above % HP combo mode", self.WHPSliderCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R below % HP combo mode", self.RHPSliderCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use W above % HP harass mode", self.WHPSliderHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Use R in harass", self.UseRHarass.Value)
    SettingsManager:AddSettingsInt("Use R below % HP harass mode", self.RHPSliderHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
end

function DrMundo:LoadSettings()
    SettingsManager:GetSettingsFile("DrMundo")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.WHPSliderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W above % HP combo mode")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.RHPSliderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R below % HP combo mode")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.WHPSliderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W above % HP harass mode")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    self.UseRHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use R in harass")
    self.RHPSliderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use R below % HP harass mode")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
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

function DrMundo:Combo()
    local wTarget = Orbwalker:GetTarget("Combo", getAttackRange() + 100)
    if wTarget then
        if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
            local wBuff = myHero.BuffData:GetBuff("DrMundoW")
            local wHP = self.WHPSliderCombo.Value
            local useWCondition = myHero.MaxHealth / 100 * wHP
            local rBuff = myHero.BuffData:GetBuff("DrMundoR")
            if rBuff.Count_Alt > 0 then
                if wBuff.Count_Alt == 0 then
                    Engine:CastSpell("HK_SPELL2", nil)
                end
            else
                if wBuff.Count_Alt == 0 then
                    if myHero.Health <= useWCondition then
                        Engine:CastSpell("HK_SPELL2", nil)
                    end
                end
            end
        end
        if Engine:SpellReady('HK_SPELL3') and Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0  and self.UseECombo.Value == 1 then
            Engine:CastSpell("HK_SPELL3", nil)
        end
    end

    local qTarget = Orbwalker:GetTarget("Combo", 850)
    if qTarget and Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 then
        if wTarget then
            if Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos,1)
                end
            end
        else
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos,1)
            end
        end
    end
    local RHP = self.RHPSliderCombo.Value
    local useRCondition = myHero.MaxHealth / 100 * RHP
    if myHero.Health <= useRCondition and Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
        Engine:CastSpell("HK_SPELL4", nil)
    end
end

function DrMundo:Harass()
    local wTarget = Orbwalker:GetTarget("Combo", getAttackRange() + 100)
    if wTarget then
        if Engine:SpellReady('HK_SPELL2') and self.UseWHarass.Value == 1 then
            local wBuff = myHero.BuffData:GetBuff("DrMundoW")
            local wHP = self.WHPSliderHarass.Value
            local useWCondition = myHero.MaxHealth / 100 * wHP
            local rBuff = myHero.BuffData:GetBuff("DrMundoR")
            if rBuff.Count_Alt > 0 then
                if wBuff.Count_Alt == 0 then
                    Engine:CastSpell("HK_SPELL2", nil)
                end
            else
                if wBuff.Count_Alt == 0 then
                    if myHero.Health <= useWCondition then
                        Engine:CastSpell("HK_SPELL2", nil)
                    end
                end
            end
        end
        if Engine:SpellReady('HK_SPELL3') and Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0  and self.UseEHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL3", nil)
        end
    end

    local qTarget = Orbwalker:GetTarget("Combo", 850)
    if qTarget and Engine:SpellReady('HK_SPELL1') and self.UseQHarass.Value == 1 then
        if wTarget then
            if Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos,1)
                end
            end
        else
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos,1)
            end
        end
    end
    local RHP = self.RHPSliderHarass.Value
    local useRCondition = myHero.MaxHealth / 100 * RHP
    if myHero.Health <= useRCondition and Engine:SpellReady('HK_SPELL4') and self.UseRHarass.Value == 1 then
        Engine:CastSpell("HK_SPELL4", nil)
    end
end

function DrMundo:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            DrMundo:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            DrMundo:Harass()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    --myHero.BuffData:ShowAllBuffs()
end

function DrMundo:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        local isSpider = myHero.BuffData:GetBuff("DrMundoR")
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 950,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 310,255,0,255,255)
        end
    end
end

function DrMundo:OnLoad()
    if myHero.ChampionName ~= "DrMundo" then return end
    AddEvent("OnSettingsSave" , function() DrMundo:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() DrMundo:LoadSettings() end)
    DrMundo:__init()
    AddEvent("OnDraw", function() DrMundo:OnDraw() end)
    AddEvent("OnTick", function() DrMundo:OnTick() end)
end

AddEvent("OnLoad", function() DrMundo:OnLoad() end)	