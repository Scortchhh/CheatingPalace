Shyvana = {}

function Shyvana:__init()
    self.QRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    self.WRange = 300 + myHero.CharData.BoundingRadius
    self.ERange = 925
    self.RRange = 850

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 1600
    self.RSpeed = 1400

    self.EWidth = 120
    self.RWidth = 200

    self.EDelay = 0.25
    self.RDelay = 0.25

    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ShyvanaMenu         = Menu:CreateMenu("Shyvana")
    ------------------------------------------------------------------------------
    self.ShyvanaCombo        = self.ShyvanaMenu:AddSubMenu("Combo")
    self.UseQCombo          = self.ShyvanaCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo          = self.ShyvanaCombo:AddCheckbox("Use W", 1)
    self.UseECombo          = self.ShyvanaCombo:AddCheckbox("Use E", 1)
    self.UseRCombo          = self.ShyvanaCombo:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.ShyvanaHarass         = self.ShyvanaMenu:AddSubMenu("Harass")
    self.UseQHarass          = self.ShyvanaHarass:AddCheckbox("Use Q", 1)
    self.UseWHarass          = self.ShyvanaHarass:AddCheckbox("Use W", 1)
    self.UseEHarass          = self.ShyvanaHarass:AddCheckbox("Use E", 1)
    -------------------------------------------------------------------------------
    self.ShyvanaLaneclear         = self.ShyvanaMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear          = self.ShyvanaLaneclear:AddCheckbox("Use Q", 1)
    self.UseWLaneclear          = self.ShyvanaLaneclear:AddCheckbox("Use W", 1)
    self.UseELaneclear          = self.ShyvanaLaneclear:AddCheckbox("Use E", 1)
    --------------------------------------------------------------------------------
    self.ShyvanaDrawings     = self.ShyvanaMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.ShyvanaDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW              = self.ShyvanaDrawings:AddCheckbox("Draw W", 1)
    self.DrawE              = self.ShyvanaDrawings:AddCheckbox("Draw E", 1)
    self.DrawR              = self.ShyvanaDrawings:AddCheckbox("Draw R", 1)
    Shyvana:LoadSettings()
end

function Shyvana:SaveSettings()
	SettingsManager:CreateSettings("Shyvana")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Shyvana:LoadSettings()
    SettingsManager:GetSettingsFile("Shyvana")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
end


function Shyvana:EnemiesInRange(Position, Range)
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

function Shyvana:GetDamage(rawDmg, isPhys, target)
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

function Shyvana:Combo()
    local isDragon = myHero.BuffData:GetBuff("ShyvanaTransform")
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then
        if not isDragon.Valid then
            if myHero.Mana >= 100 and Engine:SpellReady("HK_SPELL4") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.RRange and self.UseRCombo.Value == 1 then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and self.UseECombo.Value == 1 then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange * 3 and self.UseWCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", GameHud.MousePos, 0)
            end
        else
            self.QRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
            if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and self.UseECombo.Value == 1 then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange * 3 and self.UseWCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", GameHud.MousePos, 0)
            end
        end
    end
end

function Shyvana:Harass() 
    local isDragon = myHero.BuffData:GetBuff("ShyvanaTransform")
    local target = Orbwalker:GetTarget("Harass", 900)
    if target then
        if not isDragon.Valid then
            if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and self.UseEHarass.Value == 1 then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange * 3 and self.UseWHarass.Value == 1 then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", GameHud.MousePos, 0)
            end
        else
            self.QRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
            if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and self.UseEHarass.Value == 1 then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange * 3 and self.UseWHarass.Value == 1 then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
            if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", GameHud.MousePos, 0)
            end
        end
    end
end

function Shyvana:Laneclear() 
    local target = Orbwalker:GetTarget("Laneclear", 900)
    if target then
        if Engine:SpellReady("HK_SPELL3") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange and self.UseELaneclear.Value == 1 then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange and self.UseWLaneclear.Value == 1 then
            Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
        end
        if self.UseQLaneclear.Value == 1 and Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL1", GameHud.MousePos, 0)
        end
    end
end

function Shyvana:Lasthit() 

end

function Shyvana:OnTick()
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

function Shyvana:OnDraw()
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

function Shyvana:OnLoad()
    if myHero.ChampionName ~= "Shyvana" then return end
    AddEvent("OnSettingsSave" , function() Shyvana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Shyvana:LoadSettings() end)
    Shyvana:__init()
    AddEvent("OnTick", function() Shyvana:OnTick() end)
    AddEvent("OnDraw", function() Shyvana:OnDraw() end)
end

AddEvent("OnLoad", function() Shyvana:OnLoad() end)