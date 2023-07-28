local Nidalee = {
}

function Nidalee:__init()

    self.QRange = 1500
    self.QSpeed = 1300
    self.QWidth = 80
    self.QDelay = 0.25

    self.QHitChance = 0.2

    self.NidaleeMenu = Menu:CreateMenu("Nidalee")
    self.NidaleeCombo = self.NidaleeMenu:AddSubMenu("Combo")
    self.NidaleeCombo:AddLabel("Check Spells for Combo:")
    self.UseQComboHuman = self.NidaleeCombo:AddCheckbox("Use Q in combo human", 1)
    self.UseEComboSelfHuman = self.NidaleeCombo:AddCheckbox("Use E in combo for self human", 1)
    self.UseEComboSelfSliderHuman = self.NidaleeCombo:AddSlider("Use E on self below %HP human", 60,1,100,1)
    self.UseEComboAllyHuman = self.NidaleeCombo:AddCheckbox("Use E in combo for ally human", 1)
    self.UseEComboAllySliderHuman = self.NidaleeCombo:AddSlider("Use E on ally below %HP human", 30,1,100,1)
    self.UseQComboCougar = self.NidaleeCombo:AddCheckbox("Use Q in combo cougar", 1)
    self.UseWComboCougar = self.NidaleeCombo:AddCheckbox("Use W in combo cougar", 1)
    self.UseEComboCougar = self.NidaleeCombo:AddCheckbox("Use E in combo cougar", 1)
    self.NidaleeHarass = self.NidaleeMenu:AddSubMenu("Harass")
    self.NidaleeHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarassHuman = self.NidaleeHarass:AddCheckbox("Use Q in harass human", 1)
    self.UseEHarassSelfHuman = self.NidaleeHarass:AddCheckbox("Use E in harass for self human", 1)
    self.UseEHarassSelfSliderHuman = self.NidaleeHarass:AddSlider("Use E on self below %HP human", 60,1,100,1)
    self.UseEHarassAllyHuman = self.NidaleeHarass:AddCheckbox("Use E in harass for ally human", 1)
    self.UseEHarassAllySliderHuman = self.NidaleeHarass:AddSlider("Use E on ally below %HP human", 30,1,100,1)
    self.UseQHarassCougar = self.NidaleeHarass:AddCheckbox("Use Q in harass cougar", 1)
    self.UseWHarassCougar = self.NidaleeHarass:AddCheckbox("Use W in harass cougar", 1)
    self.UseEHarassCougar = self.NidaleeHarass:AddCheckbox("Use E in harass cougar", 1)
    self.NidaleeMisc = self.NidaleeMenu:AddSubMenu("R")
    self.NidaleeMisc:AddLabel("R settings")
    self.UseSwapR = self.NidaleeMisc:AddCheckbox("Use smart swap R", 1)
    self.NidaleeDrawings = self.NidaleeMenu:AddSubMenu("Drawings")
    self.DrawQHuman = self.NidaleeDrawings:AddCheckbox("Use Q in human drawings", 1)
    self.DrawWHuman = self.NidaleeDrawings:AddCheckbox("Use W in human drawings", 1)
    self.DrawEHuman = self.NidaleeDrawings:AddCheckbox("Use E in human drawings", 1)
    self.DrawWCougar = self.NidaleeDrawings:AddCheckbox("Use W in cougar drawings", 1)
    self.DrawECougar = self.NidaleeDrawings:AddCheckbox("Use E in cougar drawings", 1)
    Nidalee:LoadSettings()
end

function Nidalee:SaveSettings()
	SettingsManager:CreateSettings("Nidalee")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQComboHuman.Value)
    SettingsManager:AddSettingsInt("Use E in combo for self", self.UseEComboSelfHuman.Value)
    SettingsManager:AddSettingsInt("Use E in combo for ally", self.UseEComboAllyHuman.Value)
    SettingsManager:AddSettingsInt("Use E on self below %HP combo", self.UseEComboSelfSliderHuman.Value)
    SettingsManager:AddSettingsInt("Use E on ally below %HP combo", self.UseEComboAllySliderHuman.Value)
    SettingsManager:AddSettingsInt("Use Q in combo cougar", self.UseQComboCougar.Value)
    SettingsManager:AddSettingsInt("Use W in combo cougar", self.UseWComboCougar.Value)
    SettingsManager:AddSettingsInt("Use E in combo cougar", self.UseEComboCougar.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarassHuman.Value)
    SettingsManager:AddSettingsInt("Use E in harass for self", self.UseEHarassSelfHuman.Value)
    SettingsManager:AddSettingsInt("Use E in harass for ally", self.UseEHarassAllyHuman.Value)
    SettingsManager:AddSettingsInt("Use E on self below %HP harass", self.UseEHarassSelfSliderHuman.Value)
    SettingsManager:AddSettingsInt("Use E on ally below %HP harass", self.UseEHarassAllySliderHuman.Value)
    SettingsManager:AddSettingsInt("Use Q in harass cougar", self.UseQHarassCougar.Value)
    SettingsManager:AddSettingsInt("Use W in harass cougar", self.UseWHarassCougar.Value)
    SettingsManager:AddSettingsInt("Use E in harass cougar", self.UseEHarassCougar.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("R")
    SettingsManager:AddSettingsInt("Use smart swap R", self.UseSwapR.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in human drawings", self.DrawQHuman.Value)
    SettingsManager:AddSettingsInt("Use W in human drawings", self.DrawWHuman.Value)
    SettingsManager:AddSettingsInt("Use E in human drawings", self.DrawEHuman.Value)
    SettingsManager:AddSettingsInt("Use W in cougar drawings", self.DrawWCougar.Value)
    SettingsManager:AddSettingsInt("Use E in cougar drawings", self.DrawECougar.Value)
end

function Nidalee:LoadSettings()
    SettingsManager:GetSettingsFile("Nidalee")
    self.UseQComboHuman.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseEComboSelfHuman.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo for self")
    self.UseEComboAllyHuman.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo for ally")
    self.UseEComboSelfSliderHuman.Value = SettingsManager:GetSettingsInt("Combo", "Use E on self below %HP combo")
    self.UseEComboAllySliderHuman.Value = SettingsManager:GetSettingsInt("Combo", "Use E on ally below %HP combo")
    self.UseQComboCougar.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo cougar")
    self.UseWComboCougar.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo cougar")
    self.UseEComboCougar.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo cougar")
    -------------------------------------------
    self.UseQHarassHuman.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseEHarassSelfHuman.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass for self")
    self.UseEHarassAllyHuman.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass for ally")
    self.UseEHarassSelfSliderHuman.Value = SettingsManager:GetSettingsInt("Harass", "Use E on self below %HP harass")
    self.UseEHarassAllySliderHuman.Value = SettingsManager:GetSettingsInt("Harass", "Use E on ally below %HP harass")
    self.UseQHarassCougar.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass cougar")
    self.UseWHarassCougar.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass cougar")
    self.UseEHarassCougar.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass cougar")
    -------------------------------------------
    self.UseSwapR.Value = SettingsManager:GetSettingsInt("R", "Use smart swap R")
    -------------------------------------------
    self.DrawQHuman.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in human drawings")
    self.DrawWHuman.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in human drawings")
    self.DrawEHuman.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in human drawings")
    self.DrawWCougar.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in cougar drawings")
    self.DrawECougar.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in cougar drawings")
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

function Nidalee:CheckForm()
    local attRange = getAttackRange()
    local form
    if attRange >= 525 then
        form = "Human"
    end
    if attRange <= 300 then
        form = "Cougar"
    end
    return form
end

function Nidalee:Healing()
    if self.UseEComboSelfHuman.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        local healCondition = myHero.MaxHealth / 100 * self.UseEComboSelfSliderHuman.Value
        if myHero.Health <= healCondition then
            Engine:CastSpell('HK_SPELL3', myHero.Position)
        end
    end
    if self.UseEComboAllyHuman.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        for i, Ally in pairs(ObjectManager.HeroList) do
            if myHero.Team == Ally.Team and Ally.IsDead == false then
                local healCondition = Ally.MaxHealth / 100 * self.UseEComboAllySliderHuman.Value
                if Ally.Health <= healCondition and GetDist(myHero.Position, Ally.Position) <= 600 then
                    Engine:CastSpell('HK_SPELL3', Ally.Position)
                end
            end
        end
    end
end

function Nidalee:SwapForm()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Nidalee:CheckForm() == "Human" then
            local isHunted = target.BuffData:GetBuff("NidaleePassiveHunted")
            if isHunted.Valid then
                if GetDist(myHero.Position, target.Position) <= 850 then
                    if Engine:SpellReady('HK_SPELL4') and self.UseSwapR.Value == 1 then
                        Engine:CastSpell('HK_SPELL4', nil,1)
                    end
                end
            end
        end
        if Nidalee:CheckForm() == "Cougar" then
            if GetDist(myHero.Position, target.Position) >= 900 then
                if Engine:SpellReady('HK_SPELL4') and self.UseSwapR.Value == 1 then
                    Engine:CastSpell('HK_SPELL4', nil,1)
                end
            end
        end
    end
end

function Nidalee:Combo()
    Nidalee:SwapForm()
    if Nidalee:CheckForm() == "Human" then
        Nidalee:Healing()
        local target = Orbwalker:GetTarget("Combo", 1600)
        if target then
            if GetDist(myHero.Position, target.Position) <= 1400 then
                local qCastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if qCastPos ~= nil then
                    if Engine:SpellReady('HK_SPELL1') and self.UseQComboHuman.Value == 1 then
                        Engine:CastSpell('HK_SPELL1', qCastPos,1)
                    end
                end
            end
        end
    else
        local target = Orbwalker:GetTarget("Combo", 900)
        if target then
            local isHunted = target.BuffData:GetBuff("NidaleePassiveHunted")
            if isHunted.Valid then
                if GetDist(myHero.Position, target.Position) <= 770 and GetDist(myHero.Position, target.Position) >= getAttackRange() then
                    if Engine:SpellReady('HK_SPELL2') and self.UseWComboCougar.Value == 1 then
                        Engine:CastSpell('HK_SPELL2', target.Position,1)
                    end
                end
            else
                if GetDist(myHero.Position, target.Position) <= 450 then
                    if Engine:SpellReady('HK_SPELL2') and self.UseWComboCougar.Value == 1 then
                        Engine:CastSpell('HK_SPELL2', target.Position,1)
                    end
                end
            end
            if GetDist(myHero.Position, target.Position) <= 285 then
                if Engine:SpellReady('HK_SPELL1') and self.UseQComboCougar.Value == 1 then
                    Engine:CastSpell('HK_SPELL1', target.Position,1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= 330 then
                if Engine:SpellReady('HK_SPELL3') and self.UseEComboCougar.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', target.Position,1)
                end
            end
        end
    end
end

function Nidalee:Harass()
    Nidalee:SwapForm()
    if Nidalee:CheckForm() == "Human" then
        Nidalee:Healing()
        local target = Orbwalker:GetTarget("Harass", 1600)
        if target then
            if GetDist(myHero.Position, target.Position) <= 1400 then
                local qCastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if qCastPos ~= nil then
                    if Engine:SpellReady('HK_SPELL1') and self.UseQHarassHuman.Value == 1 then
                        Engine:CastSpell('HK_SPELL1', qCastPos,1)
                    end
                end
            end
        end
    else
        local target = Orbwalker:GetTarget("Harass", 900)
        if target then
            local isHunted = target.BuffData:GetBuff("NidaleePassiveHunted")
            if isHunted.Valid then
                if GetDist(myHero.Position, target.Position) <= 770 and GetDist(myHero.Position, target.Position) >= getAttackRange() then
                    if Engine:SpellReady('HK_SPELL2') and self.UseWHarassCougar.Value == 1 then
                        Engine:CastSpell('HK_SPELL2', target.Position,1)
                    end
                end
            else
                if GetDist(myHero.Position, target.Position) <= 450 then
                    if Engine:SpellReady('HK_SPELL2') and self.UseWHarassCougar.Value == 1 then
                        Engine:CastSpell('HK_SPELL2', target.Position,1)
                    end
                end
            end
            if GetDist(myHero.Position, target.Position) <= 285 then
                if Engine:SpellReady('HK_SPELL1') and self.UseQHarassCougar.Value == 1 then
                    Engine:CastSpell('HK_SPELL1', target.Position,1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= 330 then
                if Engine:SpellReady('HK_SPELL3') and self.UseEHarassCougar.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', target.Position,1)
                end
            end
        end
    end
end

function Nidalee:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Nidalee:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Nidalee:Harass()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- target.BuffData:ShowAllBuffs()
    -- myHero.BuffData:ShowAllBuffs()
end

function Nidalee:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Nidalee:CheckForm() == "Human" then
            if Engine:SpellReady('HK_SPELL1') and self.DrawQHuman.Value == 1 then
                Render:DrawCircle(myHero.Position, 1450,255,0,255,255)
            end
            if Engine:SpellReady('HK_SPELL2') and self.DrawWHuman.Value == 1 then
                Render:DrawCircle(myHero.Position, 900,255,0,255,255)
            end
            if Engine:SpellReady('HK_SPELL3') and self.DrawEHuman.Value == 1 then
                Render:DrawCircle(myHero.Position, 600,255,0,255,255)
            end
        end
        if Nidalee:CheckForm() == "Cougar" then
            local target = Orbwalker:GetTarget("Combo", 1600)
            if target then
                if target.BuffData:GetBuff("NidaleePassiveHunted").Valid then
                    if Engine:SpellReady('HK_SPELL2') and self.DrawWCougar.Value == 1 then
                        Render:DrawCircle(myHero.Position, 800,255,0,255,255)
                    end
                else
                    if Engine:SpellReady('HK_SPELL2') and self.DrawWCougar.Value == 1 then
                        Render:DrawCircle(myHero.Position, 400,255,0,255,255)
                    end
                end
            else
                if Engine:SpellReady('HK_SPELL2') and self.DrawWCougar.Value == 1 then
                    Render:DrawCircle(myHero.Position, 400,255,0,255,255)
                end
            end
            if Engine:SpellReady('HK_SPELL3') and self.DrawECougar.Value == 1 then
                Render:DrawCircle(myHero.Position, 330,255,0,255,255)
            end
        end
    end
end

function Nidalee:OnLoad()
    if myHero.ChampionName ~= "Nidalee" then return end
    AddEvent("OnSettingsSave" , function() Nidalee:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nidalee:LoadSettings() end)
    Nidalee:__init()
    AddEvent("OnDraw", function() Nidalee:OnDraw() end)
    AddEvent("OnTick", function() Nidalee:OnTick() end)
end

AddEvent("OnLoad", function() Nidalee:OnLoad() end)	