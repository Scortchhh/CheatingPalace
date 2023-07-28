Syndra = {}

function Syndra:__init()
    self.SyndraMenu = Menu:CreateMenu("Syndra")
    self.SyndraCombo = self.SyndraMenu:AddSubMenu("Combo")
    self.SyndraCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.SyndraCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.SyndraCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.SyndraCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.SyndraCombo:AddCheckbox("Use R if killable in combo", 1)
    self.SyndraHarass = self.SyndraMenu:AddSubMenu("Harass")
    self.SyndraHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.SyndraHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.SyndraHarass:AddCheckbox("Use W in harass", 0)
    self.UseEHarass = self.SyndraHarass:AddCheckbox("Use E in harass", 0)
    self.SyndraMisc = self.SyndraMenu:AddSubMenu("Misc")
    self.SyndraMisc:AddLabel("Check Spells for Misc:")
    self.AntigapcloseE = self.SyndraMisc:AddCheckbox("AntiGapclose E", 1)
    self.SyndraDrawings = self.SyndraMenu:AddSubMenu("Drawings")
    self.DrawQ = self.SyndraDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.SyndraDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.SyndraDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.SyndraDrawings:AddCheckbox("Draw R", 1)
    Syndra:LoadSettings()
end

function Syndra:SaveSettings()
	SettingsManager:CreateSettings("Syndra")
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
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Syndra:LoadSettings()
    SettingsManager:GetSettingsFile("Syndra")
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
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Syndra:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Syndra:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Syndra:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Syndra:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Syndra:GetDamage(rawDmg, isPhys, target)
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

function Syndra:GetOrbsCount()
    local Count = 0
    local Minions = ObjectManager.MinionList
    for I, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Syndra:GetDistance(myHero.Position, Minion.Position) <= 3000 then
            if Minion.ChampionName == "SyndraSphere" then
                if Minion.IsDead == false then
                    Count = Count + 1
                end
            end
        end
    end
    return Count
end

function Syndra:GetOrb()
    local Count = 0
    local Minions = ObjectManager.MinionList
    for I, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Syndra:GetDistance(myHero.Position, Minion.Position) <= 3000 then
            if Minion.ChampionName == "SyndraSphere" then
                if Minion.IsDead == false then
                    return Minion
                end
            end
        end
    end
    return nil
end

function Syndra:AntiDashE()
    if self.AntigapcloseE.Value == 1 then
        for i,Hero in pairs(ObjectManager.HeroList) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                if Syndra:GetDistance(myHero.Position, Hero.Position) <= 600 then
                    if Hero.AIData.Dashing == true and Engine:SpellReady('HK_SPELL3') then
                        Engine:CastSpell("HK_SPELL3", Hero.AIData.CurrentPos, 1)
                    end
                end
            end
        end
    end
end

function Syndra:Combo()
    local target = Orbwalker:GetTarget("Combo", 1200)
    if target then
        local orbs = Syndra:GetOrbsCount()
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            local rDmg = Syndra:GetDamage(120 + (150 * myHero:GetSpellSlot(3).Level) + 0.6 * myHero.AbilityPower, false, target)
            local sphereDmg = Syndra:GetDamage(40 + (50 * myHero:GetSpellSlot(3).Level) + 0.2 * myHero.AbilityPower, false, target) * orbs
            local totalDmg = rDmg + sphereDmg
            if target.Health <= totalDmg then
                Engine:CastSpell("HK_SPELL4", target.Position)
            end
        end
        if orbs >= 1 then
            local orb = Syndra:GetOrb()
            if orb ~= nil then
                if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                    if Syndra:GetDistance(myHero.Position, target.Position) <= 860 then
                        local castPos = Prediction:GetCastPos(orb.Position, 860, 1200, 130, 0.25, 0)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL2", castPos, 1)
                        end
                    end
                end
                if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
                    local castPos = Prediction:GetCastPos(orb.Position, 600, 1600, 130, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL3", castPos, 1)
                    end
                end
            end

            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                if Syndra:GetDistance(myHero.Position, target.Position) <= 800 then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, math.huge, 120, 0.5, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos, 1)
                    end
                end
            end
        else
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                if Syndra:GetDistance(myHero.Position, target.Position) <= 800 then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, math.huge, 120, 0.5, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos, 1)
                    end
                end
            end
        end
    end
end

function Syndra:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1200)
    if target then
        local orbs = Syndra:GetOrbsCount()
        if orbs >= 1 then
            local orb = Syndra:GetOrb()
            if orb ~= nil then
                if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
                    if Syndra:GetDistance(myHero.Position, target.Position) <= 860 then
                        local castPos = Prediction:GetCastPos(orb.Position, 860, 1200, 130, 0.25, 0)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL2", castPos, 1)
                        end
                    end
                end
                if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                    local castPos = Prediction:GetCastPos(orb.Position, 600, 1600, 130, 0.25, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL3", castPos, 1)
                    end
                end
            end

            if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
                if Syndra:GetDistance(myHero.Position, target.Position) <= 800 then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, math.huge, 120, 0.5, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos, 1)
                    end
                end
            end
        else
            if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
                if Syndra:GetDistance(myHero.Position, target.Position) <= 800 then
                    local castPos = Prediction:GetCastPos(myHero.Position, 800, math.huge, 120, 0.5, 0)
                    if castPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", castPos, 1)
                    end
                end
            end
        end
    end
end

function Syndra:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        Syndra:AntiDashE()
        if Engine:IsKeyDown("HK_COMBO") then
            Syndra:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Syndra:Harass()
        end
    end
end

function Syndra:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 800,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 920,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 650,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 750,255,0,255,255)
        end
    end
end

function Syndra:OnLoad()
    if myHero.ChampionName ~= "Syndra" then return end
    AddEvent("OnSettingsSave" , function() Syndra:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Syndra:LoadSettings() end)
    Syndra:__init()
    AddEvent("OnTick", function() Syndra:OnTick() end)
    AddEvent("OnDraw", function() Syndra:OnDraw() end)
end

AddEvent("OnLoad", function() Syndra:OnLoad() end)