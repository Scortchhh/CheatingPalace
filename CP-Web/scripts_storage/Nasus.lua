Nasus = {}

function Nasus:__init()
    self.NasusMenu = Menu:CreateMenu("Nasus")
    self.NasusCombo = self.NasusMenu:AddSubMenu("Combo")
    self.NasusCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.NasusCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.NasusCombo:AddCheckbox("Use W in combo", 1)
    self.WConditionCombo = self.NasusCombo:AddSlider("Use W on max range if enemy below % HP", 60,1,100,1)
    self.UseECombo = self.NasusCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.NasusCombo:AddCheckbox("Use R in combo", 1)
    self.RNasusConditionCombo = self.NasusCombo:AddSlider("Use R below % HP and target in range", 60,1,100,1)
    self.REnemiesAround = self.NasusCombo:AddSlider("Use R if more then x enemies around", 2,1,5,1)
    self.NasusHarass = self.NasusMenu:AddSubMenu("Harass")
    self.NasusHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.NasusHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.NasusHarass:AddCheckbox("Use W in harass", 1)
    self.WConditionHarass = self.NasusCombo:AddSlider("Use W on max range if enemy below % maximum HP", 60,1,100,1)
    self.UseEHarass = self.NasusHarass:AddCheckbox("Use E in harass", 1)
    self.NasusMisc = self.NasusMenu:AddSubMenu("Misc")
    self.NasusMisc:AddLabel("Check Spells for Misc:")
    self.QLastHit = self.NasusMisc:AddCheckbox("Use Q to lasthit", 1)
    self.NasusDrawings = self.NasusMenu:AddSubMenu("Drawings")
    self.DrawQ = self.NasusDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.NasusDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.NasusDrawings:AddCheckbox("Draw E", 1)
    Nasus:LoadSettings()
end

function Nasus:SaveSettings()
	SettingsManager:CreateSettings("Nasus")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use W on max range if enemy below % HP combo", self.WConditionCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R below % HP and target in range", self.RNasusConditionCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies around", self.REnemiesAround.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use W on max range if enemy below % HP harass", self.WConditionHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
end

function Nasus:LoadSettings()
    SettingsManager:GetSettingsFile("Nasus")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.WConditionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W on max range if enemy below % HP combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.RNasusConditionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R below % HP and target in range")
    self.REnemiesAround.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies around")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.WConditionHarass.Value = SettingsManager:GetSettingsInt("Combo", "Use W on max range if enemy below % HP harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
end

function Nasus:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Nasus:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Nasus:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Nasus:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Nasus:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Nasus:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Nasus:UseLastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLastHit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                if Nasus:GetDistance(myHero.Position, Minion.Position) <= 400 then
                    local qDmg = (10 + (20 * myHero:GetSpellSlot(0).Level)) 
                    local qStacks = myHero.BuffData:GetBuff("NasusQStacks")
                    if qStacks.Valid then
                        qDmg = qDmg + qStacks.Count_Int
                    end
                    qDmg = qDmg + myHero.BaseAttack + myHero.BonusAttack
                    if Minion.Health <= qDmg then
                        Engine:CastSpell("HK_SPELL1", nil)
                        Engine:AttackClick(Minion.Position, 0)
                    end
                end
            end
        end
    end
end

function Nasus:Combo() 
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            local nasusHPCondition = myHero.MaxHealth / 100 * self.RNasusConditionCombo.Value
            if myHero.Health <= nasusHPCondition then
                if Nasus:GetDistance(myHero.Position, target.Position) <= Nasus:GetAttackRange() + 50 then
                    Engine:CastSpell("HK_SPELL4", nil)
                end
            end
            if Nasus:EnemiesInRange(myHero.Position, 500) >= self.REnemiesAround.Value then
                Engine:CastSpell("HK_SPELL4", nil)
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            local enemyHPCondition = target.MaxHealth / 100 * self.WConditionCombo.Value
            if target.Health <= enemyHPCondition then
                if Nasus:GetDistance(myHero.Position, target.Position) <= 700 then
                    Engine:CastSpell("HK_SPELL2", target.Position)
                end
            end
            if Nasus:GetDistance(myHero.Position, target.Position) >= Nasus:GetAttackRange() and Nasus:GetDistance(myHero.Position, target.Position) <= 400 then
                Engine:CastSpell("HK_SPELL2", target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            if Nasus:GetDistance(myHero.Position, target.Position) <= Nasus:GetAttackRange() + 100 then
                Engine:CastSpell("HK_SPELL3", target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            if Nasus:GetDistance(myHero.Position, target.Position) <= Nasus:GetAttackRange() and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", nil)
            end
        end
    end
end

function Nasus:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            local enemyHPCondition = target.MaxHealth / 100 * self.WConditionCombo.Value
            if target.Health <= enemyHPCondition then
                if Nasus:GetDistance(myHero.Position, target.Position) <= 700 then
                    Engine:CastSpell("HK_SPELL2", target.Position)
                end
            end
            if Nasus:GetDistance(myHero.Position, target.Position) >= Nasus:GetAttackRange() and Nasus:GetDistance(myHero.Position, target.Position) <= 400 then
                Engine:CastSpell("HK_SPELL2", target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
            if Nasus:GetDistance(myHero.Position, target.Position) <= Nasus:GetAttackRange() + 100 then
                Engine:CastSpell("HK_SPELL3", target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Nasus:GetDistance(myHero.Position, target.Position) <= Nasus:GetAttackRange() and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", nil)
            end
        end
    end
end

function Nasus:QDamage()
    local qBuff = myHero.BuffData:GetBuff("NasusQ")
    if qBuff.Valid then
        local qDmg = (10 + (20 * myHero:GetSpellSlot(0).Level)) 
        local qStacks = myHero.BuffData:GetBuff("NasusQStacks")
        if qStacks.Valid then
            qDmg = qDmg + qStacks.Count_Int
            return qDmg
        end
        return qDmg
    else
        return 0
    end
end

function Nasus:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        Orbwalker.ExtraDamage = self:QDamage()
        if Engine:IsKeyDown("HK_COMBO") then
            Nasus:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Nasus:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Nasus:UseLastHitQ()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Nasus:UseLastHitQ()
        end
    end
end

function Nasus:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, Nasus:GetAttackRange() - 25,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 700,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 650,255,0,255,255)
        end
    end
end

function Nasus:OnLoad()
    if myHero.ChampionName ~= "Nasus" then return end
    AddEvent("OnSettingsSave" , function() Nasus:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nasus:LoadSettings() end)
    Nasus:__init()
    AddEvent("OnTick", function() Nasus:OnTick() end)
    AddEvent("OnDraw", function() Nasus:OnDraw() end)
end

AddEvent("OnLoad", function() Nasus:OnLoad() end)