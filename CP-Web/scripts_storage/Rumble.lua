Rumble = {}

function Rumble:__init()
    self.QRange = 600
    self.WRange = 0
    self.ERange = 950
    self.RRange = 1700

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 2000
    self.RSpeed = 1600

    self.ERadius = 120
    self.EWidth = 120
    self.RWidth = 200

    self.EDelay = 0.25
    self.RDelay = 0.5

    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.RumbleMenu         = Menu:CreateMenu("Rumble")
    ------------------------------------------------------------------------------
    self.RumbleCombo        = self.RumbleMenu:AddSubMenu("Combo")
    self.UseQCombo          = self.RumbleCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo          = self.RumbleCombo:AddCheckbox("Use W", 1)
    self.UseECombo          = self.RumbleCombo:AddCheckbox("Use E", 1)
    self.UseRCombo          = self.RumbleCombo:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.RumbleHarass         = self.RumbleMenu:AddSubMenu("Harass")
    self.UseQHarass          = self.RumbleHarass:AddCheckbox("Use Q", 1)
    self.UseWHarass          = self.RumbleHarass:AddCheckbox("Use W", 1)
    self.UseEHarass          = self.RumbleHarass:AddCheckbox("Use E", 1)
    -------------------------------------------------------------------------------
    self.RumbleLaneclear         = self.RumbleMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear          = self.RumbleLaneclear:AddCheckbox("Use Q", 1)
    self.UseWLaneclear          = self.RumbleLaneclear:AddCheckbox("Use W", 1)
    self.UseELaneclear          = self.RumbleLaneclear:AddCheckbox("Use E", 1)
    --------------------------------------------------------------------------------
    self.RumbleDrawings     = self.RumbleMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.RumbleDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW              = self.RumbleDrawings:AddCheckbox("Draw W", 1)
    self.DrawE              = self.RumbleDrawings:AddCheckbox("Draw E", 1)
    self.DrawR              = self.RumbleDrawings:AddCheckbox("Draw R", 1)
    Rumble:LoadSettings()
end

function Rumble:SaveSettings()
	SettingsManager:CreateSettings("Rumble")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Rumble:LoadSettings()
    SettingsManager:GetSettingsFile("Rumble")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
end


function Rumble:EnemiesInRange(Position, Range)
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

function Rumble:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetMyLevel() / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Rumble:Combo()
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange + 100 and myHero.Mana == 80 then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
            if CastPos then
                Engine:CastSpell("HK_SPELL4", CastPos, 1)
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 and myHero.Mana < 80 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange + 150 then
            Engine:CastSpell("HK_SPELL2", nil, 0)
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and myHero.Mana < 80 then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
            if CastPos then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
            end
        end
    end
end

function Rumble:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 and myHero.Mana < 80 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL2", nil, 0)
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and myHero.Mana < 80 then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
            if CastPos then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
            end
        end
    end
end

function Rumble:Laneclear() 
    local target = Orbwalker:GetTarget("Laneclear", 1000)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQLaneclear.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseQLaneclear.Value == 1 and myHero.Mana < 80 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            Engine:CastSpell("HK_SPELL2", nil, 0)
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseELaneclear.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and myHero.Mana < 80 then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
end

function Rumble:Lasthit() 

end

function Rumble:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            self:Combo()
		end
        if Engine:IsKeyDown("HK_HARASS") then
            self:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            self:Laneclear()
		end
		if Engine:IsKeyDown("HK_LASTHIT") then
            self:Lasthit()
        end
    end
end

function Rumble:OnDraw()
    if myHero.IsDead == true then return end
    if self.DrawQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        Render:DrawCircle(myHero.Position, self.QRange ,255,155,0,255)
    end
    if self.DrawW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        Render:DrawCircle(myHero.Position, self.WRange ,255,155,0,255)
    end
    if self.DrawE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        Render:DrawCircle(myHero.Position, self.ERange ,255,155,0,255)
    end
    if self.DrawR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        Render:DrawCircle(myHero.Position, self.RRange ,255,155,0,255)
    end
end

function Rumble:OnLoad()
    if myHero.ChampionName ~= "Rumble" then return end
    AddEvent("OnSettingsSave" , function() Rumble:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Rumble:LoadSettings() end)
    Rumble:__init()
    AddEvent("OnTick", function() Rumble:OnTick() end)
    AddEvent("OnDraw", function() Rumble:OnDraw() end)
end

AddEvent("OnLoad", function() Rumble:OnLoad() end)