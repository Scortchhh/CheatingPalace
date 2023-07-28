Yasuo = {}

function Yasuo:__init()

    self.Minions = {}

    self.YasuoMenu = Menu:CreateMenu("Yasuo")
    self.YasuoCombo = self.YasuoMenu:AddSubMenu("Combo")
    self.YasuoCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.YasuoCombo:AddCheckbox("Use Q in combo", 1)
    self.UseECombo = self.YasuoCombo:AddCheckbox("Use E in combo", 1)
    self.UseEMinionCombo = self.YasuoCombo:AddCheckbox("Use E as gapclose with minions in combo", 1)
    self.UseRCombo = self.YasuoCombo:AddCheckbox("Use R in combo", 1)
    self.REnemyHP = self.YasuoCombo:AddSlider("Maximum % HP for enemy to use R", 60,1,100,1)
    self.YasuoCombo:AddLabel("Amount of %HP that yasuo needs to have more then the enemy to R")
    self.RYasuoHP = self.YasuoCombo:AddSlider("Select a value, recommended 10-20", 20,1,30,1)
    self.YasuoHarass = self.YasuoMenu:AddSubMenu("Harass")
    self.YasuoHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.YasuoHarass:AddCheckbox("Use Q in harass", 1)
    self.UseEHarass = self.YasuoHarass:AddCheckbox("Use E in harass", 1)
    self.UseEMinionHarass = self.YasuoHarass:AddCheckbox("Use E as gapclose with minions in harass", 1)
    self.YasuoMisc = self.YasuoMenu:AddSubMenu("Misc")
    self.UseWBlockOnSpells = self.YasuoMisc:AddCheckbox("Use W on Spells", 1)
    self.QLastHit = self.YasuoMisc:AddCheckbox("Use Q in lasthit", 1)
    self.ELastHit = self.YasuoMisc:AddCheckbox("Use E in lasthit", 1)
    self.QStack = self.YasuoMisc:AddCheckbox("Use Q to stack in laneclear", 1)
    self.YasuoDrawings = self.YasuoMenu:AddSubMenu("Drawings")
    self.DrawQ = self.YasuoDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.YasuoDrawings:AddCheckbox("Draw W", 1)
    self.DrawR = self.YasuoDrawings:AddCheckbox("Draw R", 1)
    Yasuo:LoadSettings()
end

function Yasuo:SaveSettings()
	SettingsManager:CreateSettings("Yasuo")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use E as gapclose with minions in combo", self.UseEMinionCombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Maximum % HP for enemy to use R", self.REnemyHP.Value)
    SettingsManager:AddSettingsInt("Select a value, recommended 10-20", self.RYasuoHP.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Use E as gapclose with minions in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use W on Spells", self.UseWBlockOnSpells.Value)
    SettingsManager:AddSettingsInt("Use Q in lasthit", self.QLastHit.Value)
    SettingsManager:AddSettingsInt("Use E in lasthit", self.ELastHit.Value)
    SettingsManager:AddSettingsInt("Use Q to stack in laneclear", self.QStack.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Yasuo:LoadSettings()
    SettingsManager:GetSettingsFile("Yasuo")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseEMinionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E as gapclose with minions in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.REnemyHP.Value = SettingsManager:GetSettingsInt("Combo", "Maximum % HP for enemy to use R")
    self.RYasuoHP.Value = SettingsManager:GetSettingsInt("Combo", "Select a value, recommended 10-20")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    self.UseEMinionHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E as gapclose with minions in harass")
    -------------------------------------------
    self.UseWBlockOnSpells.Value = SettingsManager:GetSettingsInt("Misc", "Use W on Spells")
    self.QLastHit.Value = SettingsManager:GetSettingsInt("Misc", "Use Q in lasthit")
    self.ELastHit.Value = SettingsManager:GetSettingsInt("Misc", "Use E in lasthit")
    self.QStack.Value = SettingsManager:GetSettingsInt("Misc", "Use Q to stack in laneclear")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Yasuo:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Yasuo:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Yasuo:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Yasuo:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Yasuo:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Yasuo:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = Yasuo:GetDistance(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = Yasuo:GetDistance(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if Yasuo:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

function Yasuo:BlockW()
    local target = Orbwalker:GetTarget("Combo", 1400)
    if target and self.UseWBlockOnSpells.Value == 1 then
        local Missiles = ObjectManager.MissileList
        for I, Missile in pairs(Missiles) do
            if Missile.Team ~= myHero.Team then 
                local Info = Awareness.Spells[Missile.Name]
                if Info ~= nil and Info.Type == 0 then
                    if Yasuo:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius) then
                        if Engine:SpellReady("HK_SPELL2") and self.UseWBlockOnSpells.Value == 1 then
                            Engine:CastSpell("HK_SPELL2",  target.Position)
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Yasuo:Combo() 
    local target = Orbwalker:GetTarget("Combo", 1400)
    if target then
        if target and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            local enemyHPPercentage = target.MaxHealth / 100 * self.REnemyHP.Value
            local yasuoHPPercentage = myHero.MaxHealth / 100 * self.RYasuoHP.Value
            local isEnemyKnockedUp = target.BuffData:HasBuffOfType(29)
            if isEnemyKnockedUp then
                local HPDiff = myHero.Health - target.Health
                local HPDiffNeeded = target.MaxHealth / 100 * self.RYasuoHP.Value
                if HPDiff >= HPDiffNeeded then
                    if target.Health <= enemyHPPercentage then
                        if Yasuo:GetDistance(myHero.Position, target.Position) <= Yasuo:GetAttackRange() then
                            if Orbwalker.ResetReady == 1 then
                                Engine:CastSpell("HK_SPELL4", Vector3.new(), 0)
                            end
                        end
                        if Yasuo:GetDistance(myHero.Position, target.Position) <= 1400 then
                            Engine:CastSpell("HK_SPELL4", Vector3.new(), 0)
                        end
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEMinionCombo.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) >= 450 then
                local yasuoDistToTarget = Yasuo:GetDistance(myHero.Position, target.Position)
                for i, Minion in pairs(ObjectManager.MinionList) do
                    if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                        if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                            if Yasuo:GetDistance(Minion.Position, target.Position) <= yasuoDistToTarget - 100 then
                                Engine:CastSpell("HK_SPELL3", Minion.Position ,1)
                            end
                        end
                    end
                end
            end
        end
        local qBuff = myHero.BuffData:GetBuff("YasuoQ2")
        if qBuff.Valid and self.UseQCombo.Value == 1 and self.UseECombo.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) >= 500 then
                if Engine:SpellReady("HK_SPELL1") then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, 1400, 100, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos ,1)
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL3") then
                local hasEBuff = target.BuffData:GetBuff("YasuoE")
                if not hasEBuff.Valid then
                    if Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                        Engine:CastSpell("HK_SPELL3", target.Position ,1)
                        Engine:CastSpell("HK_SPELL1", GameHud.MousePos)
                    end
                end
            else
                if Engine:SpellReady("HK_SPELL1") then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, 1200, 100, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos ,1)
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                local castPos = Prediction:GetCastPos(myHero.Position, 450, math.huge, 70, 0.25, 0)
                if castPos ~= nil and Orbwalker.ResetReady == 1 then
                    Engine:CastSpell("HK_SPELL1", castPos ,1)
                else
                    if Yasuo:GetDistance(myHero.Position, target.Position) >= Yasuo:GetAttackRange() then
                        local castPos = Prediction:GetCastPos(myHero.Position, 450, math.huge, 70, 0.25, 0)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", castPos ,1)
                        end
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            local hasEBuff = target.BuffData:GetBuff("YasuoE")
            local qBuff = myHero.BuffData:GetBuff("YasuoQ1")
            if not hasEBuff.Valid and not qBuff.Valid then
                if Yasuo:GetDistance(myHero.Position, target.Position) >= Yasuo:GetAttackRange() + 50 and Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                    Engine:CastSpell("HK_SPELL3", target.Position ,1)
                end
            end
        end
    end
end

function Yasuo:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL3") and self.UseEMinionHarass.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) >= 450 then
                local yasuoDistToTarget = Yasuo:GetDistance(myHero.Position, target.Position)
                for i, Minion in pairs(ObjectManager.MinionList) do
                    if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                        if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                            if Yasuo:GetDistance(Minion.Position, target.Position) <= yasuoDistToTarget - 100 then
                                Engine:CastSpell("HK_SPELL3", Minion.Position ,1)
                            end
                        end
                    end
                end
            end
        end
        local qBuff = myHero.BuffData:GetBuff("YasuoQ2")
        if qBuff.Valid and self.UseQHarass.Value == 1 and self.UseEHarass.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) >= 500 then
                if Engine:SpellReady("HK_SPELL1") then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, 1400, 100, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos ,1)
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL3") then
                local hasEBuff = target.BuffData:GetBuff("YasuoE")
                if not hasEBuff.Valid then
                    if Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                        Engine:CastSpell("HK_SPELL3", target.Position ,1)
                        Engine:CastSpell("HK_SPELL1", GameHud.MousePos)
                    end
                end
            else
                if Engine:SpellReady("HK_SPELL1") then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, 1200, 100, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos ,1)
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                local castPos = Prediction:GetCastPos(myHero.Position, 450, math.huge, 70, 0.25, 0)
                if castPos ~= nil and Orbwalker.ResetReady == 1 then
                    Engine:CastSpell("HK_SPELL1", castPos ,1)
                else
                    if Yasuo:GetDistance(myHero.Position, target.Position) >= Yasuo:GetAttackRange() then
                        local castPos = Prediction:GetCastPos(myHero.Position, 450, math.huge, 70, 0.25, 0)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", castPos ,1)
                        end
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
            local hasEBuff = target.BuffData:GetBuff("YasuoE")
            local qBuff = myHero.BuffData:GetBuff("YasuoQ1")
            if not hasEBuff.Valid and not qBuff.Valid then
                if Yasuo:GetDistance(myHero.Position, target.Position) >= Yasuo:GetAttackRange() + 50 and Yasuo:GetDistance(myHero.Position, target.Position) <= 450 then
                    Engine:CastSpell("HK_SPELL3", target.Position ,1)
                end
            end
        end
    end
end

function Yasuo:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLastHit.Value == 1 then
        local qBuff = myHero.BuffData:GetBuff("YasuoQ2")
        if not qBuff.Valid then
            local MinionList = ObjectManager.MinionList
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                    if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                        local QDmg = -5 + (25 * myHero:GetSpellSlot(0).Level) + 1 * (myHero.BaseAttack + myHero.BonusAttack)
                        if Minion.Health <= QDmg then
                            Engine:CastSpell("HK_SPELL1", Minion.Position)
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:LastHitE()
    if Engine:SpellReady("HK_SPELL3") and self.ELastHit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                    local hasEBuff = Minion.BuffData:GetBuff("YasuoE")
                    if not hasEBuff.Valid then
                        local EDmg = 50 + (10 * myHero:GetSpellSlot(0).Level) + 0.2 * myHero.BonusAttack + 0.6 * myHero.AbilityPower
                        if Minion.Health <= EDmg and Yasuo:EnemiesInRange(Minion.Position, 400) <= 0 then
                            Engine:CastSpell("HK_SPELL3", Minion.Position)
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:StackQ()
    local target = Orbwalker:GetTarget("Combo", 1400)
    if target == nil then
        if Engine:SpellReady("HK_SPELL1") and self.QStack.Value == 1 then
            local MinionList = ObjectManager.MinionList
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                    if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                        local hasEBuff = Minion.BuffData:GetBuff("YasuoE")
                        if not hasEBuff.Valid then
                            local QDmg = -5 + (25 * myHero:GetSpellSlot(0).Level) + 1 * (myHero.BaseAttack + myHero.BonusAttack)
                            if Minion.Health > QDmg + 50  and Yasuo:EnemiesInRange(Minion.Position, 400) <= 0 then
                                Engine:CastSpell("HK_SPELL1", Minion.Position)
                            end
                        end
                    end
                end
            end
        end
    else
        if Engine:SpellReady("HK_SPELL1") and self.QStack.Value == 1 then
            local QBuff = myHero.BuffData:GetBuff("yasuoq2")
            if not QBuff.Valid then
                local MinionList = ObjectManager.MinionList
                for i, Minion in pairs(MinionList) do
                    if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                        if Yasuo:GetDistance(myHero.Position, Minion.Position) <= 450 then
                            local hasEBuff = Minion.BuffData:GetBuff("YasuoE")
                            if not hasEBuff.Valid then
                                local QDmg = -5 + (25 * myHero:GetSpellSlot(0).Level) + 1 * (myHero.BaseAttack + myHero.BonusAttack)
                                if Minion.Health > QDmg + 50  and Yasuo:EnemiesInRange(Minion.Position, 400) <= 0 then
                                    Engine:CastSpell("HK_SPELL1", Minion.Position)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        if Engine:IsKeyDown("HK_COMBO") then
            Yasuo:BlockW()
            Yasuo:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Yasuo:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Yasuo:StackQ()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Yasuo:LastHitQ()
            Yasuo:LastHitE()
        end
    end
end

function Yasuo:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 470,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 400,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 1400,255,0,255,255)
        end
    end
end

function Yasuo:OnLoad()
    if myHero.ChampionName ~= "Yasuo" then return end
    AddEvent("OnSettingsSave" , function() Yasuo:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Yasuo:LoadSettings() end)
    Yasuo:__init()
    AddEvent("OnTick", function() Yasuo:OnTick() end)
    AddEvent("OnDraw", function() Yasuo:OnDraw() end)
end

AddEvent("OnLoad", function() Yasuo:OnLoad() end)