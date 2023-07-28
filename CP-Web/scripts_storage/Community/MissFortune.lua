MF = {}

function MF:__init()
    self.IsUlting = false
    self.MFMenu = Menu:CreateMenu("MF")
    self.MFCombo = self.MFMenu:AddSubMenu("Combo")
    self.MFCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.MFCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.MFCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.MFCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.MFCombo:AddCheckbox("Use R if killable in combo", 1)
    self.MFHarass = self.MFMenu:AddSubMenu("Harass")
    self.MFHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.MFHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.MFHarass:AddCheckbox("Use W in harass", 0)
    self.UseEHarass = self.MFHarass:AddCheckbox("Use E in harass", 0)
    self.MFMisc = self.MFMenu:AddSubMenu("Misc")
    self.MFMisc:AddLabel("Check Spells for Misc:")
    self.AntigapcloseE = self.MFMisc:AddCheckbox("AntiGapclose E", 1)
    self.LasthitQ = self.MFMisc:AddCheckbox("Minion lasthit with Q", 1)
    self.MFDrawings = self.MFMenu:AddSubMenu("Drawings")
    self.DrawQ = self.MFDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.MFDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.MFDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.MFDrawings:AddCheckbox("Draw R", 1)
    MF:LoadSettings()
end

function MF:SaveSettings()
	SettingsManager:CreateSettings("MF")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R if killable in combo", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("AntiGapclose E", self.AntigapcloseE.Value)
    SettingsManager:AddSettingsInt("Minion lasthit with Q", self.LasthitQ.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function MF:LoadSettings()
    SettingsManager:GetSettingsFile("MF")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R if killable in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.AntigapcloseE.Value = SettingsManager:GetSettingsInt("Misc", "AntiGapclose E")
    self.LasthitQ.Value = SettingsManager:GetSettingsInt("Misc", "Minion lasthit with Q")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function unpack (t, i)
    i = i or 1
    if t[i] ~= nil then
      return t[i], unpack(t, i + 1)
    end
end

local delayedActions, delayedActionsExecuter = {}, nil
local DelayAction = function(func, delay, args)
        if not delayedActionsExecuter then
                delayedActionsExecuter = function()
                        for t, funcs in pairs(delayedActions) do
                                if t <= GameClock.Time then
                                        for j, f in ipairs(funcs) do
                                                f.func(unpack(f.args or {}))
                                        end
                                        delayedActions[t] = nil         
                                end
                        end
                end
                AddEvent("OnTick", delayedActionsExecuter)
        end

        local t = GameClock.Time + (delay or 0)
        if delayedActions[t] then
                table.insert(delayedActions[t], { func = func, args = args })
        else
                delayedActions[t] = { { func = func, args = args } }
        end
end

function MF:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function MF:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if MF:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function MF:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function MF:GetDamage(rawDmg, isPhys, target)
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

function ClosestMinion(target)
    local closestTarget = nil
    for i, minion in pairs(ObjectManager.MinionList) do
        if minion.Team ~= myHero.Team and minion.IsDead == false and minion.IsTargetable then
            if MF:GetDistance(target.Position, minion.Position) <= 400 then
                if closestTarget == nil then
                    closestTarget = minion
                end
                local closestTargetDistance = MF:GetDistance(target.Position, closestTarget.Position)
                local newTargetDistance = MF:GetDistance(target.Position, minion.Position)
                if closestTargetDistance < newTargetDistance then
                    closestTarget = minion
                end
            end
        end
    end
    return closestTarget
end

function VectorWay(A,B)
    WayX = B.x - A.x
    WayY = B.y - A.y
    WayZ = B.z - A.z
    return Vector3.new(WayX, WayY, WayZ)
end

function MF:GetQTarget()
    local MinionList = ObjectManager.MinionList
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(MinionList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                    if MF:GetDistance(myHero.Position, Minion.Position) <= 1400 then
                        local castPos = Prediction:GetCastPos(Minion.Position, 300, 5000, 90, 0.25, 0)
                        if castPos ~= nil then
                            local checkPosX = myHero.Position.x + (Minion.Position.x - myHero.Position.x)/MF:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPosY = myHero.Position.y + (Minion.Position.y - myHero.Position.y)/MF:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPosZ = myHero.Position.z + (Minion.Position.z - myHero.Position.z)/MF:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPos = Vector3.new(checkPosX, checkPosY, checkPosZ)
                            if MF:GetDistance(castPos, checkPos) < 300 then
                                return Minion
                            end
                        end
                        
                        -- local castPos = Prediction:PointOnLineSegment(Minion.Position, Hero.Position, Minion.Position, 120)
                        -- local minionTargetDist = MF:GetDistance(Minion.Position, Hero.Position)
                        -- local minionHeroDist = MF:GetDistance(Minion.Position, myHero.Position)
                        -- print(castPos)
                        -- if castPos == true and minionTargetDist < minionHeroDist then
                        --     return Minion
                        -- end

                    end
                end
            end
        end
    end
    return nil
end

function MF:QLastHit()
    if Engine:SpellReady("HK_SPELL1") and self.LasthitQ.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if MF:GetDistance(myHero.Position, Minion.Position) <= MF:GetAttackRange() then
                    local qDmg = MF:GetDamage(0 + (20 * myHero:GetSpellSlot(0).Level) + 1 * (myHero.BaseAttack + myHero.BonusAttack) + 0.35 * myHero.AbilityPower, true, Minion) 
                    if Minion.Health <= qDmg then
                        Engine:CastSpell("HK_SPELL1", Minion.Position)
                    end
                end
            end
        end
    end
end

function MF:SetOrbActive()
    DelayAction(function()
        Orbwalker.Enabled = 1
        self.IsUlting = false
    end, 3)
end

function MF:Combo()
    if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do 
            if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                if MF:GetDistance(myHero.Position, Hero.Position) <= 1300 then
                    local waves = 0
                    local dmg = myHero.BaseAttack + myHero.BonusAttack * 0.75
                    if myHero:GetSpellSlot(3).Level == 1 then
                        waves = 6
                    end
                    if myHero:GetSpellSlot(3).Level == 2 then
                        waves = 8
                    end
                    if myHero:GetSpellSlot(3).Level == 3 then
                        waves = 10
                    end
                    local rDmg = MF:GetDamage(waves * dmg, true, Hero)
                    if Hero.Health <= rDmg then
                        Orbwalker.Enabled = 0
                        self.IsUlting = true
                        Engine:CastSpell("HK_SPELL4", Hero.Position, 1)
                        MF:SetOrbActive()
                    end
                end
            end
        end
    end
    if self.IsUlting == false then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local qTarget = MF:GetQTarget()
            if qTarget ~= nil then
                if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                    if MF:GetDistance(myHero.Position, qTarget.Position) <= MF:GetAttackRange() then
                        Engine:CastSpell("HK_SPELL1", qTarget.Position, 1)
                    end
                end
            else
                if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                    if MF:GetDistance(myHero.Position, target.Position) <= MF:GetAttackRange() then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseQCombo.Value == 1 then
                if MF:GetDistance(myHero.Position, target.Position) <= MF:GetAttackRange() then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
                if MF:GetDistance(myHero.Position, target.Position) <= 1100 and MF:GetDistance(myHero.Position, target.Position) >= MF:GetAttackRange() then
                    local castPos = Prediction:GetCastPos(myHero.Position, 1100, math.huge, 120, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL3", castPos, 1)
                    end
                end
            end
        end
    end
end

function MF:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1200)
    if target then

    end
end

function MF:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        if Engine:IsKeyDown("HK_COMBO") then
            MF:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            MF:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            MF:QLastHit()
        end
    end
end

function MF:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 1000,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 1350,255,0,255,255)
        end
    end
end

function MF:OnLoad()
    if myHero.ChampionName ~= "MissFortune" then return end
    AddEvent("OnSettingsSave" , function() MF:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() MF:LoadSettings() end)
    MF:__init()
    AddEvent("OnTick", function() MF:OnTick() end)
    AddEvent("OnDraw", function() MF:OnDraw() end)
end

AddEvent("OnLoad", function() MF:OnLoad() end)