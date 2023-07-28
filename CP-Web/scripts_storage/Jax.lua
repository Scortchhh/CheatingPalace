-- 1.3 update
-- removed Orbwalker.ResetReady = 0 w/ new update
Jax = {}

function Jax:__init()
    self.JaxMenu = Menu:CreateMenu("Jax")
    self.JaxCombo = self.JaxMenu:AddSubMenu("Combo")
    self.JaxCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.JaxCombo:AddCheckbox("Use Q in combo", 1)
    self.JaxQSettingsCombo = self.JaxCombo:AddSubMenu("Q Settings Combo")
    self.QMinRangeCombo = self.JaxQSettingsCombo:AddSlider("Min Range for Q gapclose in combo", 300,200,700,1)
    self.QMaxRangeCombo = self.JaxQSettingsCombo:AddSlider("Max Range for Q gapclose in combo", 700,200,700,1)
    self.UseWCombo = self.JaxCombo:AddCheckbox("Use W in combo as AA reset", 1)
    self.UseECombo = self.JaxCombo:AddCheckbox("Use E in combo", 1)
    self.JaxESettingsCombo = self.JaxCombo:AddSubMenu("E Settings Combo")
    self.EMinEnemiesCombo = self.JaxESettingsCombo:AddSlider("Min Enemies to use E in combo", 1,1,5,1)
    self.EMaxLifeCombo = self.JaxESettingsCombo:AddSlider("Use E below % Health in combo", 40,1,100,1)
    self.JaxHarass = self.JaxMenu:AddSubMenu("Harass")
    self.JaxHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.JaxHarass:AddCheckbox("Use Q in harass", 1)
    self.JaxQSettingsHarass = self.JaxHarass:AddSubMenu("Q Settings Harass")
    self.QMinRangeHarass = self.JaxQSettingsHarass:AddSlider("Min Range for Q gapclose in harass", 300,200,700,1)
    self.QMaxRangeHarass = self.JaxQSettingsHarass:AddSlider("Max Range for Q gapclose in harass", 700,200,700,1)
    self.UseWHarass = self.JaxHarass:AddCheckbox("Use W in harass as AA reset", 1)
    self.UseEHarass = self.JaxHarass:AddCheckbox("Use E in harass", 1)
    self.JaxESettingsHarass = self.JaxHarass:AddSubMenu("E Settings Harass")
    self.EMinEnemiesHarass = self.JaxESettingsHarass:AddSlider("Min Enemies to use E in harass", 1,1,5,1)
    self.EMaxLifeHarass = self.JaxESettingsHarass:AddSlider("Use E below % Health in harass", 40,1,100,1)
    self.JaxLaneclear = self.JaxMenu:AddSubMenu("Laneclear")
    self.JaxLaneclear:AddLabel("Check Spells for Laneclear:")
    self.UseQLaneclear = self.JaxLaneclear:AddCheckbox("Use Q in laneclear", 1)
    self.UseWLaneclear = self.JaxLaneclear:AddCheckbox("Use W in laneclear as AA reset", 1)
    self.UseELaneclear = self.JaxLaneclear:AddCheckbox("Use E in laneclear", 1)
    self.JaxDrawings = self.JaxMenu:AddSubMenu("Drawings")
    self.DrawQ = self.JaxDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawE = self.JaxDrawings:AddCheckbox("Use E in drawings", 1)
    Jax:LoadSettings()
end

function Jax:SaveSettings()
	SettingsManager:CreateSettings("Jax")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Min Range for Q gapclose in combo", self.QMinRangeCombo.Value)
    SettingsManager:AddSettingsInt("Max Range for Q gapclose in combo", self.QMaxRangeCombo.Value)
    SettingsManager:AddSettingsInt("Min Enemies to use E in combo", self.EMinEnemiesCombo.Value)
    SettingsManager:AddSettingsInt("Use E below % Health in combo", self.EMaxLifeCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Min Range for Q gapclose in harass", self.QMinRangeHarass.Value)
    SettingsManager:AddSettingsInt("Max Range for Q gapclose in harass", self.QMaxRangeHarass.Value)
    SettingsManager:AddSettingsInt("Min Enemies to use E in harass", self.EMinEnemiesHarass.Value)
    SettingsManager:AddSettingsInt("Use E below % Health in harass", self.EMaxLifeHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in Laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("Use W in Laneclear", self.UseWLaneclear.Value)
    SettingsManager:AddSettingsInt("Use E in Laneclear", self.UseELaneclear.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
end

function Jax:LoadSettings()
    SettingsManager:GetSettingsFile("Jax")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.QMinRangeCombo.Value = SettingsManager:GetSettingsInt("Combo", "Min Range for Q gapclose in combo")
    self.QMaxRangeCombo.Value = SettingsManager:GetSettingsInt("Combo", "Max Range for Q gapclose in combo")
    self.EMinEnemiesCombo.Value = SettingsManager:GetSettingsInt("Combo", "Min Enemies to use E in combo")
    self.EMaxLifeCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E below % Health in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in Harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in Harass")
    self.QMinRangeHarass.Value = SettingsManager:GetSettingsInt("Harass", "Min Range for Q gapclose in harass")
    self.QMaxRangeHarass.Value = SettingsManager:GetSettingsInt("Harass", "Max Range for Q gapclose in harass")
    self.EMinEnemiesHarass.Value = SettingsManager:GetSettingsInt("Harass", "Min Enemies to use E in harass")
    self.EMaxLifeHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E below % Health in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use Q in Laneclear")
    self.UseWLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use W in Laneclear")
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use E in Laneclear")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
end

function Jax:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Jax:EnemiesInRange(Position, Range)
	-- local Count = 0 --FeelsBadMan
	-- local HeroList = ObjectManager.HeroList
	-- for Index = 1, #HeroList do	
    --     local Hero = HeroList[Index]
		-- if Hero.Team ~= myHero.Team and Hero.IsTargetable then
		-- 	if Jax:GetDistance(Hero.Position , Position) < Range then
		-- 		Count = Count + 1
		-- 	end
		-- end
	-- end
    -- return Count
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Jax:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Jax:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Jax:Combo() 
    local target = Orbwalker:GetTarget("Combo", 750)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            local minRange = self.QMinRangeCombo.Value
            local maxRange = self.QMaxRangeCombo.Value
            if Jax:GetDistance(myHero.Position, target.Position) >= minRange and Jax:GetDistance(myHero.Position, target.Position) <= maxRange then
                Engine:CastSpell("HK_SPELL1",  target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            local lifeCondition = myHero.MaxHealth / 100 * self.EMaxLifeCombo.Value
            local minEnemies = self.EMinEnemiesCombo.Value
            local eBuff = myHero.BuffData:GetBuff("JaxCounterStrike")
            if eBuff.Valid then
                if Orbwalker.ResetReady == 1 or Jax:GetDistance(myHero.Position, target.Position) >= 275 then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
            else
                if myHero.Health <= lifeCondition then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
                if Jax:EnemiesInRange(myHero.Position, 340) >= minEnemies then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            if Orbwalker.ResetReady == 1 and Jax:GetDistance(myHero.Position, target.Position) <= Jax:GetAttackRange() then
                Engine:CastSpell("HK_SPELL2",  nil)
            end
        end
    end
end

function Jax:Harass() 
    local target = Orbwalker:GetTarget("Harass", 750)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            local minRange = self.QMinRangeHarass.Value
            local maxRange = self.QMaxRangeHarass.Value
            if Jax:GetDistance(myHero.Position, target.Position) >= minRange and Jax:GetDistance(myHero.Position, target.Position) <= maxRange then
                Engine:CastSpell("HK_SPELL1",  target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
            local lifeCondition = myHero.MaxHealth / 100 * self.EMaxLifeHarass.Value
            local minEnemies = self.EMinEnemiesHarass.Value
            local eBuff = myHero.BuffData:GetBuff("JaxCounterStrike")
            if eBuff.Valid then
                if Orbwalker.ResetReady == 1 or Jax:GetDistance(myHero.Position, target.Position) >= 275 then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
            else
                if myHero.Health <= lifeCondition then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
                if Jax:EnemiesInRange(myHero.Position, 340) >= minEnemies then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            if Orbwalker.ResetReady == 1 and Jax:GetDistance(myHero.Position, target.Position) <= Jax:GetAttackRange() then
                Engine:CastSpell("HK_SPELL2",  nil)
            end
        end
    end
end

function Jax:Laneclear()
    local target = Orbwalker:GetTarget("Laneclear", 750)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQLaneclear.Value == 1 then
            if Jax:GetDistance(myHero.Position, target.Position) <= 700 then
                Engine:CastSpell("HK_SPELL1",  target.Position)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseELaneclear.Value == 1 then
            local eBuff = myHero.BuffData:GetBuff("JaxCounterStrike")
            if not eBuff.Valid then
                if Jax:GetDistance(myHero.Position, target.Position) <= 300 then
                    Engine:CastSpell("HK_SPELL3",  nil)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWLaneclear.Value == 1 then
            if Orbwalker.ResetReady == 1 and Jax:GetDistance(myHero.Position, target.Position) <= Jax:GetAttackRange() then
                Engine:CastSpell("HK_SPELL2",  nil)
            end
        end
    end
end

function Jax:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Jax:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Jax:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Jax:Laneclear()
        end
    end
end

function Jax:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 700,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 350,255,0,255,255)
        end
    end
end

function Jax:OnLoad()
    if myHero.ChampionName ~= "Jax" then return end
    AddEvent("OnSettingsSave" , function() Jax:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Jax:LoadSettings() end)
    Jax:__init()
    AddEvent("OnTick", function() Jax:OnTick() end)
    AddEvent("OnDraw", function() Jax:OnDraw() end)
end

AddEvent("OnLoad", function() Jax:OnLoad() end)