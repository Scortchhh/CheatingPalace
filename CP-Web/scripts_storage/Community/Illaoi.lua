Illaoi = {}

function Illaoi:__init()
    self.IllaoiMenu = Menu:CreateMenu("Illaoi")
    self.IllaoiCombo = self.IllaoiMenu:AddSubMenu("Combo")
    self.IllaoiCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.IllaoiCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.IllaoiCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.IllaoiCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.IllaoiCombo:AddCheckbox("Use R in combo", 1)
    self.ComboUseREnemiesSLider = self.IllaoiCombo:AddSlider("Use R if more then x enemies", 3,1,5,1)
    self.IllaoiHarass = self.IllaoiMenu:AddSubMenu("Harass")
    self.IllaoiHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.IllaoiHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.IllaoiHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.IllaoiHarass:AddCheckbox("Use E in harass", 1)
    self.IllaoiDrawings = self.IllaoiMenu:AddSubMenu("Drawings")
    self.DrawQ = self.IllaoiDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.IllaoiDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.IllaoiDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.IllaoiDrawings:AddCheckbox("Draw R", 1)
    Illaoi:LoadSettings()
end

function Illaoi:SaveSettings()
	SettingsManager:CreateSettings("Illaoi")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies", self.ComboUseREnemiesSLider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Illaoi:LoadSettings()
    SettingsManager:GetSettingsFile("Illaoi")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.ComboUseREnemiesSLider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Illaoi:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Illaoi:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Illaoi:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Illaoi:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Illaoi:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = target.MagicResist * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Illaoi:PassiveInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do   
        if Illaoi:GetDistance(Position, Minion.Position) < Range then
            Count = Count + 1
        end
    end
    return Count
end

function Illaoi:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Illaoi:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Illaoi:Combo()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            if Illaoi:EnemiesInRange(myHero.Position, 500) >= self.ComboUseREnemiesSLider.Value then
                Engine:CastSpell("HK_SPELL4", GameHud.MousePos)
                return
            end
        end
        local RBuff = myHero.BuffData:GetBuff("IllaoiR")
        if RBuff.Valid then
            if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                if Illaoi:PassiveInRange(target.Position, 700) >= 1 and Illaoi:GetDistance(myHero.Position, target.Position) <= 380 then
                    Engine:CastSpell("HK_SPELL2", target.Position)
                    return
                end
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                local castPos = Prediction:GetCastPos(myHero.Position, 750, math.huge, 150, 0.4, 0)
                if castPos ~= nil and Illaoi:GetDistance(myHero.Position, target.Position) <= 750 then
                    Engine:CastSpell("HK_SPELL1", castPos, 1)
                    return
                end
            end
        else
            local hasPassive = target.BuffData:GetBuff("illaoievessel")
            if not hasPassive.Valid and Illaoi:PassiveInRange(target.Position, 700) >= 1 or Illaoi:PassiveInRange(myHero.Position, 700) >= 1 then
                if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, 1000, 150, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL3", castPos, 1)
                        return
                    end
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                    if Illaoi:GetDistance(myHero.Position, target.Position) <= 380 then
                        Engine:CastSpell("HK_SPELL2", target.Position)
                        return
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                if Illaoi:PassiveInRange(target.Position, 700) >= 1 and Illaoi:GetDistance(myHero.Position, target.Position) <= 380 then
                    Engine:CastSpell("HK_SPELL2", target.Position)
                    return
                end
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                local castPos = Prediction:GetCastPos(myHero.Position, 750, math.huge, 150, 0.4, 0)
                if castPos ~= nil and Illaoi:GetDistance(myHero.Position, target.Position) <= 750 then
                    Engine:CastSpell("HK_SPELL1", castPos, 1)
                    return
                end
            end
        end
    end
end

function Illaoi:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1000)
    if target then
        local hasPassive = target.BuffData:GetBuff("illaoievessel")
        if not hasPassive.Valid then
            if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                local castPos = Prediction:GetCastPos(myHero.Position, 800, 1000, 150, 0.25, 0)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", castPos, 1)
                    return
                end
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
                if Illaoi:GetDistance(myHero.Position, target.Position) <= 380 then
                    Engine:CastSpell("HK_SPELL2", target.Position)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            if Illaoi:PassiveInRange(target.Position, 700) >= 1 and Illaoi:GetDistance(myHero.Position, target.Position) <= 380 then
                Engine:CastSpell("HK_SPELL2", target.Position)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            local castPos = Prediction:GetCastPos(myHero.Position, 750, math.huge, 150, 0.4, 0)
            if castPos ~= nil and Illaoi:GetDistance(myHero.Position, target.Position) <= 750 then
                Engine:CastSpell("HK_SPELL1", castPos, 1)
                return
            end
        end
    end
end

function Illaoi:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Illaoi:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Illaoi:Harass()
        end
    end
end

function Illaoi:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 820,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 400,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 900,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 450,255,0,255,255)
        end
    end
end

function Illaoi:OnLoad()
    if myHero.ChampionName ~= "Illaoi" then return end
    AddEvent("OnSettingsSave" , function() Illaoi:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Illaoi:LoadSettings() end)
    Illaoi:__init()
    AddEvent("OnTick", function() Illaoi:OnTick() end)
    AddEvent("OnDraw", function() Illaoi:OnDraw() end)
end

AddEvent("OnLoad", function() Illaoi:OnLoad() end)