local Amumu = {}

function Amumu:__init()
    self.QRange = 1100
    self.WRange = 300
    self.ERange = 350
    self.RRange = 550

    self.QSpeed = 2000
    self.WSpeed = math.huge
    self.ESpeed = 2000
    self.RSpeed = math.huge
    
    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0.25
    self.RDelay = 0

    self.QWidth = 160

    self.QHitChance = 0.4
    
    self.AmumuMenu = Menu:CreateMenu("Amumu")
    self.AmumuCombo = self.AmumuMenu:AddSubMenu("Combo")
    self.AmumuCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.AmumuCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.AmumuCombo:AddCheckbox("Use W in combo", 1)
    self.UseWComboSlider = self.AmumuCombo:AddSlider("Use W if mana above % combo", 30,1,100,1)
    self.UseECombo = self.AmumuCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.AmumuCombo:AddCheckbox("Use R in combo", 1)
    self.UseRComboSlider = self.AmumuCombo:AddSlider("Use R if more then x enemies in R range", 3,1,5,1)
    self.AmumuHarass = self.AmumuMenu:AddSubMenu("Harass")
    self.AmumuHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.AmumuHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.AmumuHarass:AddCheckbox("Use W in harass", 1)
    self.UseWHarassSlider = self.AmumuHarass:AddSlider("Use W if mana above % harass", 30,1,100,1)
    self.UseEHarass = self.AmumuHarass:AddCheckbox("Use E in harass", 1)
    self.AmumuDrawings = self.AmumuMenu:AddSubMenu("Drawings")
    self.DrawQ = self.AmumuDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW = self.AmumuDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawE = self.AmumuDrawings:AddCheckbox("Use E in drawings", 1)
    self.DrawR = self.AmumuDrawings:AddCheckbox("Use R in drawings", 1)
    Amumu:LoadSettings()
end

function Amumu:SaveSettings()
	SettingsManager:CreateSettings("Amumu")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use W if mana above % combo", self.UseWComboSlider.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.UseRComboSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use W if mana above % harass", self.UseWHarassSlider.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Amumu:LoadSettings()
    SettingsManager:GetSettingsFile("Amumu")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseWComboSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use W if mana above % combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.UseRComboSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseWHarassSlider.Value = SettingsManager:GetSettingsInt("Harass", "Use W if mana above % harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
end

function Amumu:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Amumu:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Amumu:Combo()
    local Enemies = self:EnemiesInRange(myHero.Position, self.RRange)
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        if #Enemies >= self.UseRComboSlider.Value then
            return Engine:CastSpell("HK_SPELL4", nil, 1)
        end
    end 
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 100, self.EDelay, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
    end

    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local hasWBuff = myHero.BuffData:GetBuff("AuraofDespair").Valid
        if hasWBuff then
            local sliderValue = self.UseWComboSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana < condition then
                return Engine:CastSpell("HK_SPELL2", nil, 0)
            end
        end
        local target = Orbwalker:GetTarget("Combo", 500)
        if not target and hasWBuff then
            Engine:CastSpell("HK_SPELL2", nil, 0)
            return
        end
        if target then
            if not hasWBuff and self:GetDistance(myHero.Position, target.Position) <= 300 then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end

    -- look into q casting
    if self.UseQCombo.Value == 1 then
        if myHero:GetSpellSlot(0).Charges > 0 and Engine:SpellReady("HK_SPELL1") then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, 1, self.QHitChance, 1)
            if PredPos then
                return Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end 
end

function Amumu:Harass()
    if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 100, self.EDelay, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
    end
    if self.UseWHarass.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local hasWBuff = myHero.BuffData:GetBuff("AuraofDespair").Valid
        if not hasWBuff then
            local sliderValue = self.UseWComboSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                return Engine:CastSpell("HK_SPELL2", nil, 0)
            end
        end
        if hasWBuff then
            local sliderValue = self.UseWComboSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana < condition then
                return Engine:CastSpell("HK_SPELL2", nil, 0)
            end
        end
    end
    if self.UseQHarass.Value == 1 then
        if myHero:GetSpellSlot(0).Cooldown < GameClock.Time then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, 1, self.QHitChance - 0.1, 1)
            if PredPos then
                return Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end 
end

function Amumu:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        -- myHero.BuffData:ShowAllBuffs()
        if Engine:IsKeyDown("HK_COMBO") then
            self:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            self:Harass()
        end
    end
end

function Amumu:OnDraw()
    if myHero.IsDead then return end
    if self.DrawE.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then 
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if self.DrawW.Value == 1 and Engine:SpellReady('HK_SPELL2') then 
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if self.DrawR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Amumu:OnLoad()
    if myHero.ChampionName ~= "Amumu" then return end
    AddEvent("OnSettingsSave" , function() Amumu:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Amumu:LoadSettings() end)
    Amumu:__init()
    AddEvent("OnDraw", function() Amumu:OnDraw() end)
    AddEvent("OnTick", function() Amumu:OnTick() end)
end

AddEvent("OnLoad", function() Amumu:OnLoad() end)	