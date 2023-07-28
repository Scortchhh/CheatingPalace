Katarina = {}

function Katarina:__init()
    self.KatarinaMenu = Menu:CreateMenu("Katarina")
    self.KatarinaCombo = self.KatarinaMenu:AddSubMenu("Combo")
    self.KatarinaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KatarinaCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.KatarinaCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.KatarinaCombo:AddCheckbox("Use E to catch daggers in combo", 0)
    self.UseRCombo = self.KatarinaCombo:AddCheckbox("Use R in combo", 1)
    self.ComboUseREnemiesSLider = self.KatarinaCombo:AddSlider("Use R if more then x enemies", 2,1,5,1)
    self.KatarinaHarass = self.KatarinaMenu:AddSubMenu("Harass")
    self.KatarinaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KatarinaHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.KatarinaHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.KatarinaHarass:AddCheckbox("Use E to catch daggers in harass", 0)
    self.KatarinaMisc = self.KatarinaMenu:AddSubMenu("Misc")
    self.QLastHit = self.KatarinaMisc:AddCheckbox("Use Q in lasthit", 1)
    self.QWaveClear = self.KatarinaMisc:AddCheckbox("Use Q in Laneclear", 1)
    self.KatarinaDrawings = self.KatarinaMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KatarinaDrawings:AddCheckbox("Draw Q", 1)
    self.DrawQDaggers = self.KatarinaDrawings:AddCheckbox("Draw Q spots", 1)
    self.DrawE = self.KatarinaDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.KatarinaDrawings:AddCheckbox("Draw R", 1)

    self.RActive = false
    Katarina:LoadSettings()
end

function Katarina:SaveSettings()
	SettingsManager:CreateSettings("Katarina")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E to catch daggers in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies", self.ComboUseREnemiesSLider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E to catch daggers in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use Q in lasthit", self.QLastHit.Value)
    SettingsManager:AddSettingsInt("Use Q in laneclear", self.QWaveClear.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw Q spots", self.DrawQDaggers.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Katarina:LoadSettings()
    SettingsManager:GetSettingsFile("Katarina")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E to catch daggers in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.ComboUseREnemiesSLider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E to catch daggers in harass")
    -------------------------------------------
    self.QLastHit.Value = SettingsManager:GetSettingsInt("Misc", "Use Q in lasthit")
    self.QWaveClear.Value = SettingsManager:GetSettingsInt("Misc", "Use Q in laneclear")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawQDaggers.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q spots")
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

function Katarina:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Katarina:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Katarina:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Katarina:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Katarina:GetDamage(rawDmg, isPhys, target)
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

function Katarina:ResetRActive()
    local rBuff = myHero.BuffData:GetBuff("katarinarsound")
    if rBuff.Valid then
        self.RActive = true
        Orbwalker.Enabled = 0
        if self.RActive == true then
            local target = Orbwalker:GetTarget("Combo", 1200)
            if target then
                if Katarina:GetDistance(myHero.Position, target.Position) >= 450 and Katarina:GetDistance(myHero.Position, target.Position) <= 700 then
                    self.RActive = false
                    Orbwalker.Enabled = 1
                    Engine:CastSpell("HK_SPELL1", target.Position,1)
                end
            end
        end
    end
    if not rBuff.Valid then
        self.RActive = false
        Orbwalker.Enabled = 1
    end
end

function Katarina:FindQ()
    local Minions = ObjectManager.MinionList
    for I, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Katarina:GetDistance(myHero.Position, Minion.Position) <= 1000 then
            if Minion.Name == "HiddenMinion" then
                return Minion
            end
        end
    end
    return nil
end

function Katarina:CatchQ()
    local target = Orbwalker:GetTarget("Combo", 1200)
    if target then 
        local Minions = ObjectManager.MinionList
        for I, Minion in pairs(Minions) do
            if Minion.Team == myHero.Team and Katarina:GetDistance(myHero.Position, Minion.Position) <= 2500 then
                if Minion.Name == "HiddenMinion" then
                    local leftSpot = Minion.Position
                    local rightSpot = Minion.Position
                    local topSpot = Minion.Position
                    local bottomSpot = Minion.Position
                    topSpot.z = topSpot.x - 70
                    bottomSpot.z = bottomSpot.z + 70
                    leftSpot.x = leftSpot.x - 70
                    rightSpot.x = rightSpot.x + 70
                    local delayTime = 0.8
                    if Katarina:EnemiesInRange(Minion.Position, 420) >= 1 then
                        if Minion.IsDead == false then
                            if Katarina:GetDistance(topSpot, target.Position) <= 360 then
                                DelayAction(function()
                                    Engine:CastSpell("HK_SPELL3", topSpot)
                                end, delayTime)
                                return
                            else
                                if Katarina:GetDistance(bottomSpot, target.Position) <= 360 then
                                    DelayAction(function()
                                        Engine:CastSpell("HK_SPELL3", bottomSpot)
                                    end, delayTime)
                                    return
                                else
                                    if Katarina:GetDistance(leftSpot, target.Position) <= 360 then
                                        DelayAction(function()
                                            Engine:CastSpell("HK_SPELL3", leftSpot)
                                        end, delayTime)
                                        return
                                    else
                                        if Katarina:GetDistance(rightSpot, target.Position) <= 360 then
                                            DelayAction(function()
                                                Engine:CastSpell("HK_SPELL3", rightSpot)
                                            end, delayTime)
                                            return
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Katarina:Combo()
    if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team and Hero.IsDead == false then
                if Katarina:EnemiesInRange(Hero.Position, 500) >= self.ComboUseREnemiesSLider.Value and Katarina:GetDistance(myHero.Position, Hero.Position) <= 700 then
                    self.RActive = true
                    if Engine:SpellReady("HK_SPELL3") then
                        Engine:CastSpell("HK_SPELL3", Hero.Position)
                    end
                    if Engine:SpellReady("HK_SPELL2") then
                        Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                    end
                    if Engine:SpellReady("HK_SPELL1") then
                        Engine:CastSpell("HK_SPELL1", Hero.Position)
                    end
                    Engine:CastSpell("HK_SPELL4", GameHud.MousePos)
                end
                if Katarina:EnemiesInRange(myHero.Position, 500) >= self.ComboUseREnemiesSLider.Value then
                    self.RActive = true
                    Engine:CastSpell("HK_SPELL4", GameHud.MousePos)
                end
            end
        end
    end
    if self.RActive == false then
        if Engine:SpellReady("HK_SPELL3") then
            local kataQ = Katarina:CatchQ()
            if kataQ ~= nil and self.UseECombo.Value == 1 then
                Katarina:CatchQ()
            end
        end
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                if Katarina:GetDistance(myHero.Position, target.Position) <= 600 then
                    Engine:CastSpell("HK_SPELL1", target.Position)
                else
                    if Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL2") and self.UseECombo.Value == 1 then
                        if Katarina:GetDistance(myHero.Position, target.Position) <= 700 then
                            Engine:CastSpell("HK_SPELL3", target.Position)
                        end
                    end
                    if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                        if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                            Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                        end
                    end
                end
                if Engine:SpellReady("HK_SPELL3") then
                    local kataQ = Katarina:CatchQ()
                    if kataQ ~= nil and self.UseECombo.Value == 1 then
                        Katarina:CatchQ()
                    end
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                    if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                        Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                    end
                end
            else
                if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
                    local kataQ = Katarina:CatchQ()
                    if kataQ ~= nil then
                        Katarina:CatchQ()
                    end
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                    if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                        Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                    end
                end
            end
        end
    end
end

function Katarina:Harass() 
    if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
        local kataQ = Katarina:CatchQ()
        if kataQ ~= nil then
            Katarina:CatchQ()
        end
    end
    local target = Orbwalker:GetTarget("Harass", 1200)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Katarina:GetDistance(myHero.Position, target.Position) <= 600 then
                Engine:CastSpell("HK_SPELL1", target.Position)
            else
                if Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL2") and self.UseEHarass.Value == 1 then
                    Engine:CastSpell("HK_SPELL3", target.Position)
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
                    if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                        Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                local kataQ = Katarina:CatchQ()
                if kataQ ~= nil then
                    Katarina:CatchQ()
                end
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
                if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                end
            end
        else
            if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                local kataQ = Katarina:CatchQ()
                if kataQ ~= nil then
                    Katarina:CatchQ()
                end
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
                if Katarina:GetDistance(myHero.Position, target.Position) <= 380 then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                end
            end
        end
    end
end

function Katarina:QKillMinion()
    if Engine:SpellReady("HK_SPELL1") and self.QLastHit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                if Katarina:GetDistance(myHero.Position, Minion.Position) <= 600 then
                    local QDmg = 45 + (30 * myHero:GetSpellSlot(0).Level) + 0.3 * myHero.AbilityPower
                    if Minion.Health <= QDmg then
                        Engine:CastSpell("HK_SPELL1", Minion.Position)
                    end
                end
            end
        end
    end
end

function Katarina:QLaneclear()
    if Engine:SpellReady("HK_SPELL1") and self.QWaveClear.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                if Katarina:GetDistance(myHero.Position, Minion.Position) <= 600 then
                    Engine:CastSpell("HK_SPELL1", Minion.Position)
                end
            end
        end
    end
end

function Katarina:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        Katarina:ResetRActive()
        if Engine:IsKeyDown("HK_COMBO") then
            if self.RActive == false then
                Katarina:Combo()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Katarina:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Katarina:QKillMinion()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Katarina:QLaneclear()
        end
    end
end

function Katarina:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    local KatarinaQ = Katarina:FindQ()
    if Render:World2Screen(myHero.Position, outvec) then
        if KatarinaQ ~= nil and KatarinaQ.IsDead == false and self.DrawQDaggers.Value == 1 then
            Render:DrawCircle(KatarinaQ.Position, 140,255,0,255,255)
        end
        if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then
            Render:DrawCircle(myHero.Position, 630,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 730,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 550,255,0,255,255)
        end
    end
end

function Katarina:OnLoad()
    if myHero.ChampionName ~= "Katarina" then return end
    AddEvent("OnSettingsSave" , function() Katarina:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Katarina:LoadSettings() end)
    Katarina:__init()
    AddEvent("OnTick", function() Katarina:OnTick() end)
    AddEvent("OnDraw", function() Katarina:OnDraw() end)
end

AddEvent("OnLoad", function() Katarina:OnLoad() end)