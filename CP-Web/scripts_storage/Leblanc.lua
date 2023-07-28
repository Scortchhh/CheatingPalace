Leblanc = {}

function Leblanc:__init()
    self.QRange = 700
    self.WRange = 600
    self.ERange = 950

    self.QSpeed = 2000
    self.WSpeed = 1450
    self.ESpeed = 1750

    self.WRadius = 235
    self.EWidth = 110

    self.EDelay = 0.25

    self.EHitChance = 0.2

    self.LeblancMenu         = Menu:CreateMenu("Leblanc")
    ------------------------------------------------------------------------------
    self.LeblancCombo        = self.LeblancMenu:AddSubMenu("Combo")
    self.UseQCombo          = self.LeblancCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo          = self.LeblancCombo:AddCheckbox("Use W", 1)
    self.UseECombo          = self.LeblancCombo:AddCheckbox("Use E", 1)
    self.UseRCombo          = self.LeblancCombo:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.LeblancHarass         = self.LeblancMenu:AddSubMenu("Harass")
    self.UseQHarass          = self.LeblancHarass:AddCheckbox("Use Q", 1)
    self.UseWHarass          = self.LeblancHarass:AddCheckbox("Use W", 1)
    self.UseEHarass          = self.LeblancHarass:AddCheckbox("Use E", 1)
    --------------------------------------------------------------------------------
    self.LeblancDrawings     = self.LeblancMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.LeblancDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW              = self.LeblancDrawings:AddCheckbox("Draw W", 1)
    self.DrawWOnMouse              = self.LeblancDrawings:AddCheckbox("Draw W Radius on Mouse", 1)
    self.DrawE              = self.LeblancDrawings:AddCheckbox("Draw E", 1)
    Leblanc:LoadSettings()
end

function Leblanc:SaveSettings()
	SettingsManager:CreateSettings("Leblanc")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Leblanc:LoadSettings()
    SettingsManager:GetSettingsFile("Leblanc")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
end


function Leblanc:EnemiesInRange(Position, Range)
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

function Leblanc:GetDamage(rawDmg, isPhys, target)
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

function Leblanc:GetWCastPosition(target)
    local Start     = myHero.Position
    local End       = target.Position
    local Vec       = Vector3.new(End.x - Start.x ,End.y - Start.y ,End.z - Start.z) 
    
    local Length    = Orbwalker:GetDistance(Start,End)
    local VecNorm   = Vector3.new(Vec.x / Length,Vec.y / Length,Vec.z / Length)
    local Mod 		= Length / 1.1
    local Point
    local PointScreen 			= Vector3.new()
    Point   = Vector3.new(Start.x + (VecNorm.x * Mod) , Start.y + (VecNorm.y * Mod) , Start.z + (VecNorm.z * Mod))	
    return Point
end

function Leblanc:Combo()
    local target = Orbwalker:GetTarget("Combo", 1000)
    local recastW = myHero.BuffData:GetBuff("LeblancW")
    local recastRW = myHero.BuffData:GetBuff("LeblancRW")
    local RAbility = myHero:GetSpellSlot(3).Info.Name
    local WRWTarget = Orbwalker:GetTarget("Combo", 1200)
    if WRWTarget then
        local RWFormula = 0 + (150 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75)
        local RWDmg = self:GetDamage(RWFormula, false, WRWTarget)
        if WRWTarget.Health <= RWDmg then
            if Orbwalker:GetDistance(myHero.Position, WRWTarget.Position) > 600 and Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL2", WRWTarget.Position, 1)
            end
        end
    end
    if target then
        local sigilMark = target.BuffData:GetBuff("LeblancQMark")
        if RAbility == "LeblancRW" and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.WRange then
            local RWFormula = 0 + (150 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75)
            local RWDmg = self:GetDamage(RWFormula, false, target)
            local totalDmg = RWDmg
            if sigilMark.Valid then
                local QpassiveDmg = 80 + (50 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.8)
                totalDmg = totalDmg + self:GetDamage(QpassiveDmg, false, target)
            end
            if target.Health <= totalDmg then
                local CastPos = self:GetWCastPosition(target)
                if CastPos then
                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                end
            end
        end
        if RAbility == "LeblancRQ" and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            local RQFormula = 0 + (70 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.4)
            local RQDmg = self:GetDamage(RQFormula, false, target)
            local totalDmg = RQDmg
            if sigilMark.Valid then
                local QpassiveDmg = 80 + (50 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.8)
                totalDmg = totalDmg + self:GetDamage(QpassiveDmg, false, target)
            end
            if target.Health <= totalDmg then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
        if RAbility == "LeblancRE" and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 and Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange then
            local RQFormula = 0 + (70 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.4)
            local REDmg = self:GetDamage(RQFormula, false, target)
            local totalDmg = REDmg
            if sigilMark.Valid then
                local QpassiveDmg = 80 + (50 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.8)
                totalDmg = totalDmg + self:GetDamage(QpassiveDmg, false, target)
            end
            if target.Health <= totalDmg then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                end
            end
        end
        if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and recastW.Valid and Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            Engine:CastSpell("HK_SPELL2", nil, 0) 
        end
        -- EQW combo (one shot)
        if Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange - 100 and self.UseECombo.Value == 1 then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
            -- might need to add a check if sigil not active so it uses W
            if CastPos then
                if Engine:SpellReady("HK_SPELL3") then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            else
                if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 and not recastW.Valid and not Engine:SpellReady("HK_SPELL1") then
                    local CastPos = self:GetWCastPosition(target)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL2", CastPos, 1)
                    end
                end
                if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 and not Engine:SpellReady("HK_SPELL2") then
                    local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and self.UseQCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 and not recastW.Valid and not Engine:SpellReady("HK_SPELL1") then
                local CastPos = self:GetWCastPosition(target)
                if CastPos then
                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                end
            end
        else
            -- -- if they have no vision on you
            -- if Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
            --     --172-186
            -- else
            --     if Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange then
            --         -- only do this if damage enough to kill in total due to no R afterwards and its all in
            --         if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 and not recastW.Valid then
            --             local CastPos = self:GetWCastPosition(target)
            --             if CastPos then
            --                 Engine:CastSpell("HK_SPELL2", CastPos, 1)
            --             end
            --         end
            --         if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 and not Engine:SpellReady("HK_SPELL2") then
            --             Engine:CastSpell("HK_SPELL1", target.Position, 1)
            --         end
            --         if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 and not Engine:SpellReady("HK_SPELL1") then
            --             local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1)
            --             if CastPos then
            --                 Engine:CastSpell("HK_SPELL3", CastPos, 1)
            --             end
            --         end
            --     end
            -- end
        end
    else
        if Engine:SpellReady("HK_SPELL2") and recastW.Valid and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL4") and not Engine:SpellReady("HK_SPELL3") and self.UseWCombo.Value == 1 then
            Engine:CastSpell("HK_SPELL2", nil, 0)
        end
        if Engine:SpellReady("HK_SPELL4") and recastRW.Valid and self.UseWCombo.Value == 1 then
            Engine:CastSpell("HK_SPELL4", nil, 0) 
        end
    end
end

function Leblanc:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1000)
    local recastW = myHero.BuffData:GetBuff("LeblancW")
    local recastRW = myHero.BuffData:GetBuff("LeblancRW")
    local RAbility = myHero:GetSpellSlot(3).Info.Name
    if target then
        if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and recastW.Valid and Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL2", nil, 0) 
        end
        -- EQW Harass (one shot)
        if Orbwalker:GetDistance(myHero.Position, target.Position) <= 450 and self.UseEHarass.Value == 1 then
            if Engine:SpellReady("HK_SPELL3") then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                end
            end
            if Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and self.UseQHarass.Value == 1 then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
            if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 and not recastW.Valid and not Engine:SpellReady("HK_SPELL1") then
                local CastPos = self:GetWCastPosition(target)
                if CastPos then
                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                end
            end
        else
            -- if they have no vision on you
            if Orbwalker:GetDistance(myHero.Position, target.Position) <= self.QRange then
                if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
                if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 and not recastW.Valid and not Engine:SpellReady("HK_SPELL1") then
                    local CastPos = self:GetWCastPosition(target)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL2", CastPos, 1)
                    end
                end
                if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 and not Engine:SpellReady("HK_SPELL2") then
                    local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                    end
                end
            else
                if Orbwalker:GetDistance(myHero.Position, target.Position) <= self.ERange then
                    -- only do this if damage enough to kill in total due to no R afterwards and its all in
                    if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 and not recastW.Valid then
                        local CastPos = self:GetWCastPosition(target)
                        if CastPos then
                            Engine:CastSpell("HK_SPELL2", CastPos, 1)
                        end
                    end
                    if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 and not Engine:SpellReady("HK_SPELL2") then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                    if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 and not Engine:SpellReady("HK_SPELL1") then
                        local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                        if CastPos then
                            Engine:CastSpell("HK_SPELL3", CastPos, 1)
                        end
                    end
                end
            end
        end
    else
        if Engine:SpellReady("HK_SPELL2") and recastW.Valid and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL4") and not Engine:SpellReady("HK_SPELL3") and self.UseWHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL2", nil, 0)
        end
        if Engine:SpellReady("HK_SPELL4") and recastRW.Valid and self.UseWHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL4", nil, 0) 
        end
    end
end

function Leblanc:Laneclear() 

end

function Leblanc:Lasthit() 
    local lastHitTarget = Orbwalker:GetTarget("Lasthit", self.QRange)
    if lastHitTarget then
        local QDmg = 40 + (25 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.4)
        QDmg = self:GetDamage(QDmg, false, lastHitTarget)
        if lastHitTarget.Health <= QDmg / 2 then
            Engine:CastSpell("HK_SPELL1", lastHitTarget.Position, 1)
        end
    end
end

function Leblanc:OnTick()
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

function Leblanc:OnDraw()
    if myHero.IsDead == true then return end
    if self.DrawQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        Render:DrawCircle(myHero.Position, self.QRange ,255,155,0,255)
    end
    if self.DrawW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        Render:DrawCircle(myHero.Position, self.WRange ,255,155,0,255)
    end
    if self.DrawWOnMouse.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        Render:DrawCircle(GameHud.MousePos, self.WRadius ,255,155,0,255)
    end
    if self.DrawE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        Render:DrawCircle(myHero.Position, self.ERange ,255,155,0,255)
    end
end

function Leblanc:OnLoad()
    if myHero.ChampionName ~= "Leblanc" then return end
    AddEvent("OnSettingsSave" , function() Leblanc:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Leblanc:LoadSettings() end)
    Leblanc:__init()
    AddEvent("OnTick", function() Leblanc:OnTick() end)
    AddEvent("OnDraw", function() Leblanc:OnDraw() end)
end

AddEvent("OnLoad", function() Leblanc:OnLoad() end)