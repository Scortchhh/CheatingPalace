local Kayn = {
    Passive = {
        "Red Kayn",
        "Normal",
        "Blue Kayn",
    }
}

function Kayn:__init()

    self.QRange = 350
    self.QSpeed = 1200
    self.QWidth = 200
    self.QDelay = 0

    self.WRange = 700
    self.WSpeed = math.huge
    self.WWidth = 100
    self.WDelay = 0.55

    self.W2Range = 900
    self.W2Speed = 2000
    self.W2Width = 100
    self.W2Delay = 0

    self.QHitChance = 0.2
    self.WHitChance = 0.2

    self.KaynMenu = Menu:CreateMenu("Kayn")
    self.KaynCombo = self.KaynMenu:AddSubMenu("Combo")
    self.KaynCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KaynCombo:AddCheckbox("UseQ in combo", 1)
    self.UseWCombo = self.KaynCombo:AddCheckbox("UseW in combo", 1)
    self.UseRCombo = self.KaynCombo:AddCheckbox("UseR in Combo", 1)
    self.UseRComboEnemyHP = self.KaynCombo:AddSlider("Below % HP of enemy to use R", 20,1,100,1)
    self.UseRComboSelfHP = self.KaynCombo:AddSlider("Below % HP of Kayn to use R", 15,1,100,1)
    self.KaynHarass = self.KaynMenu:AddSubMenu("Harass")
    self.KaynHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KaynHarass:AddCheckbox("UseQ in harass", 1)
    self.UseWHarass = self.KaynHarass:AddCheckbox("UseW in harass", 0)
    self.KaynLaneclear = self.KaynMenu:AddSubMenu("Laneclear")
    self.KaynLaneclear:AddLabel("Check Spells for Laneclear:")
    self.UseQLaneclear = self.KaynLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.QLaneclearSettings = self.KaynLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.UseWLaneclear = self.KaynLaneclear:AddCheckbox("UseW in laneclear", 0)
    self.WLaneclearSettings = self.KaynLaneclear:AddSubMenu("W Laneclear Settings")
    self.LaneclearWMana = self.WLaneclearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)
    self.KaynMisc = self.KaynMenu:AddSubMenu("Misc")
    self.KaynMisc:AddLabel("Check Settings for Misc:")
	self.PassiveSelector = self.KaynMisc:AddCombobox("Passive Selector", self.Passive)
    self.KaynDrawings = self.KaynMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KaynDrawings:AddCheckbox("UseQ in drawings", 1)
    self.DrawW = self.KaynDrawings:AddCheckbox("UseW in drawings", 1)
    self.DrawR = self.KaynDrawings:AddCheckbox("UseR in drawings", 1)

    Kayn:LoadSettings()
end

function Kayn:SaveSettings()
	SettingsManager:CreateSettings("Kayn")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Below % HP of enemy to use R", self.UseRComboEnemyHP.Value)
    SettingsManager:AddSettingsInt("Below % HP of Kayn to use R", self.UseRComboSelfHP.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseQ in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("UseW in laneclear", self.UseWLaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.LaneclearWMana.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("UseW in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("UseR in drawings", self.DrawR.Value)
end

function Kayn:LoadSettings()
	SettingsManager:GetSettingsFile("Kayn")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR in combo")
    self.UseRComboEnemyHP.Value = SettingsManager:GetSettingsInt("Combo", "Below % HP of enemy to use R")
    self.UseRComboSelfHP.Value = SettingsManager:GetSettingsInt("Combo", "Below % HP of Kayn to use R")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseQ in laneclear")
    self.UseWLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseW in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneclearWMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use W")
	-------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "UseW in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "UseR in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
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

function Kayn:CastR()
    if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 550)
        if target then 
            local selfCondition = myHero.MaxHealth / 100 * self.UseRComboSelfHP.Value
            local enemyCondition = target.MaxHealth / 100 * self.UseRComboEnemyHP.Value
            local canR = target.BuffData:GetBuff("kaynrenemymark")
            if canR.Valid then
                if GetDist(myHero.Position, target.Position) <= 550 and myHero.Health <= selfCondition or target.Health <= enemyCondition then
                    Engine:CastSpell("HK_SPELL4", target.Position)
                end
            end
        end
    end
end

function Kayn:LaneclearQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Laneclear", 500)
        if target then
            local sliderValue = self.LaneclearQMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if GetDist(myHero.Position, target.Position) <= 500 and myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL1", target.Position)
            end
        end
    end
end

function Kayn:LaneclearW()
    if Engine:SpellReady('HK_SPELL2') then
        local target = Orbwalker:GetTarget("Laneclear", 600)
        if target then
            local sliderValue = self.LaneclearWMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if Orbwalker.Attack == 0 and myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL2", target.Position)
            end
        end
    end
end

function Kayn:Combo()
    Kayn:CastR()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL1") and GetDist(myHero.Position, target.Position) <= 500 and GetDist(myHero.Position, target.Position) >= getAttackRange() + 20 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos ~= nil then
                if self.UseQCombo.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
        else
            if Engine:SpellReady("HK_SPELL2") then
                if self.PassiveSelector.Selected == 2 then
                    if GetDist(myHero.Position, target.Position) <= 800 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.W2Range, self.W2Speed, self.W2Width, self.W2Delay, 0, true, self.WHitChance, 1)
                        if PredPos ~= nil and self.UseWCombo.Value == 1 then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                else
                    if GetDist(myHero.Position, target.Position) <= 600 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                        if PredPos ~= nil and self.UseWCombo.Value == 1 then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Kayn:Harass()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL1") and GetDist(myHero.Position, target.Position) <= 500 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos ~= nil then
                if self.UseQHarass.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
        else
            if Engine:SpellReady("HK_SPELL2") then
                if self.PassiveSelector.Selected == 2 then
                    if GetDist(myHero.Position, target.Position) <= 800 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.W2Range, self.W2Speed, self.W2Width, self.W2Delay, 0, true, self.WHitChance, 1)
                        if PredPos ~= nil and self.UseWHarass.Value == 1 then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                else
                    if GetDist(myHero.Position, target.Position) <= 600 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                        if PredPos ~= nil and self.UseWHarass.Value == 1 then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Kayn:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Kayn:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Kayn:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                Kayn:LaneclearQ()
            end
            if self.UseWLaneclear.Value == 1 then
                Kayn:LaneclearW()
            end
        end
    end
end

function Kayn:OnDraw()
    if myHero.IsDead then return end

    if self.DrawQ.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) and Engine:SpellReady('HK_SPELL1') then
            Render:DrawCircle(myHero.Position, 350,255,0,255,255)
        end
    end

    if self.DrawW.Value == 1 then
        local outvec = Vector3.new()
        if self.PassiveSelector.Selected == 2 then
            if Render:World2Screen(myHero.Position, outvec) and Engine:SpellReady('HK_SPELL2') then
                Render:DrawCircle(myHero.Position, 900,255,0,255,255)
            end
        else
            if Render:World2Screen(myHero.Position, outvec) and Engine:SpellReady('HK_SPELL2') then
                Render:DrawCircle(myHero.Position, 700,255,0,255,255)
            end
        end
    end

    if self.DrawR.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) and Engine:SpellReady('HK_SPELL4') then
            Render:DrawCircle(myHero.Position, 550,255,0,255,255)
        end
    end
end

function Kayn:OnLoad()
    if myHero.ChampionName ~= "Kayn" then return end
    AddEvent("OnSettingsSave" , function() Kayn:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kayn:LoadSettings() end)
    Kayn:__init()
    AddEvent("OnDraw", function() Kayn:OnDraw() end)
    AddEvent("OnTick", function() Kayn:OnTick() end)
end
AddEvent("OnLoad", function() Kayn:OnLoad() end)