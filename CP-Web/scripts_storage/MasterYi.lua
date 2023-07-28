MasterYi = {}

function MasterYi:__init()
    self.MobsAttacks = {
        ["AirDragonAttack2"] = "AirDragonAttack2",
        ["EarthDragonAttack2"] = "EarthDragonAttack2",
        ["FireDragonAttack2"] = "FireDragonAttack2",
        ["WaterDragonAttack2"] = "WaterDragonAttack2",
        ["ElderDragonAttack2"] = "ElderDragonAttack2",
        ["BaronAcidBallChampion"] = "BaronAcidBallChampion",
        ["BaronBasicAttack"] = "BaronBasicAttack",
    }

    self.TowerShots = {
        ["SRUAP_Turret_Chaos1BasicAttack"] = "SRUAP_Turret_Chaos1BasicAttack",
        ["SRUAP_Turret_Chaos2BasicAttack"] = "SRUAP_Turret_Chaos2BasicAttack",
        ["SRUAP_Turret_Chaos3BasicAttack"] = "SRUAP_Turret_Chaos3BasicAttack",
        ["SRUAP_Turret_Chaos4BasicAttack"] = "SRUAP_Turret_Chaos4BasicAttack",
    }

    self.MasterYiMenu = Menu:CreateMenu("MasterYi")
    self.MasterYiCombo = self.MasterYiMenu:AddSubMenu("Combo")
    self.MasterYiCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.MasterYiCombo:AddCheckbox("Use Q in combo", 1)
    self.MasterYiQSettingsCombo = self.MasterYiCombo:AddSubMenu("QSettings Combo")
    self.QMinRangeCombo = self.MasterYiQSettingsCombo:AddSlider("Min Range for Q gapclose in combo", 400,200,600,1)
    self.QMaxRangeCombo = self.MasterYiQSettingsCombo:AddSlider("Max Range for Q gapclose in combo", 600,200,600,1)
    self.UseWCombo = self.MasterYiCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.MasterYiCombo:AddCheckbox("Use E in combo", 1)
    self.MasterYiHarass = self.MasterYiMenu:AddSubMenu("Harass")
    self.MasterYiHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.MasterYiHarass:AddCheckbox("Use Q in Harass", 1)
    self.MasterYiQSettingsHarass = self.MasterYiHarass:AddSubMenu("QSettings Harass")
    self.QMinRangeHarass = self.MasterYiQSettingsHarass:AddSlider("Min Range for Q gapclose in harass", 400,200,600,1)
    self.QMaxRangeHarass = self.MasterYiQSettingsHarass:AddSlider("Max Range for Q gapclose in harass", 600,200,600,1)
    self.UseEHarass = self.MasterYiHarass:AddCheckbox("Use E in Harass", 1)
    self.MasterYiLaneclear = self.MasterYiMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear = self.MasterYiLaneclear:AddCheckbox("Use Q", 1)
    self.UseELaneclear = self.MasterYiLaneclear:AddCheckbox("Use E", 1)
    self.MasterYiMisc = self.MasterYiMenu:AddSubMenu("Misc")
    self.UseQDodgeOnSpells = self.MasterYiMisc:AddCheckbox("Use Q on Spells", 1)
    self.UseQDodgeOnMobAttack = self.MasterYiMisc:AddCheckbox("Use Q on MobAttacks(dragons/baron) in laneclear", 1)
    self.SmartTowerDiveQ = self.MasterYiMisc:AddCheckbox("Smart tower dive logic with Q", 1)
    self.MasterYiDrawings = self.MasterYiMenu:AddSubMenu("Drawings")
    self.DrawQ = self.MasterYiDrawings:AddCheckbox("Use Q in drawings", 1)
    MasterYi:LoadSettings()
end

function MasterYi:SaveSettings()
	SettingsManager:CreateSettings("MasterYi")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Min Range for Q gapclose in combo", self.QMinRangeCombo.Value)
    SettingsManager:AddSettingsInt("Max Range for Q gapclose in combo", self.QMaxRangeCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Min Range for Q gapclose in harass", self.QMinRangeHarass.Value)
    SettingsManager:AddSettingsInt("Max Range for Q gapclose in harass", self.QMaxRangeHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use Q on Spells", self.UseQDodgeOnSpells.Value)
    SettingsManager:AddSettingsInt("Use Q on MobAttacks(dragons/baron) in laneclear", self.UseQDodgeOnMobAttack.Value)
    SettingsManager:AddSettingsInt("Smart tower dive logic with Q", self.SmartTowerDiveQ.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
end

function MasterYi:LoadSettings()
    SettingsManager:GetSettingsFile("MasterYi")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.QMinRangeCombo.Value = SettingsManager:GetSettingsInt("Combo", "Min Range for Q gapclose in combo")
    self.QMaxRangeCombo.Value = SettingsManager:GetSettingsInt("Combo", "Max Range for Q gapclose in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in Harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in Harass")
    self.QMinRangeHarass.Value = SettingsManager:GetSettingsInt("Harass", "Min Range for Q gapclose in harass")
    self.QMaxRangeHarass.Value = SettingsManager:GetSettingsInt("Harass", "Max Range for Q gapclose in harass")
    -------------------------------------------
    self.UseQDodgeOnSpells.Value = SettingsManager:GetSettingsInt("Misc", "Use Q on Spells")
    self.UseQDodgeOnMobAttack.Value = SettingsManager:GetSettingsInt("Misc", "Use Q on MobAttacks(dragons/baron) in laneclear")
    self.SmartTowerDiveQ.Value = SettingsManager:GetSettingsInt("Misc", "Smart tower dive logic with Q")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
end

function MasterYi:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function MasterYi:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if MasterYi:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function MasterYi:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = MasterYi:GetDistance(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = MasterYi:GetDistance(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if MasterYi:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

function MasterYi:DodgeQ()
    for i, Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and self:GetDistance(myHero.Position, Hero.Position) <= 700 then
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(Missiles) do
                if Missile.Team ~= myHero.Team then 
                    local Info = Evade.Spells[Missile.Name]
                    if Info ~= nil and Info.Type == 0 then
                        if MasterYi:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius) then
                            if Engine:SpellReady("HK_SPELL1") and self.UseQDodgeOnSpells.Value == 1 then
                                Engine:CastSpell("HK_SPELL1",  Hero.Position, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function MasterYi:DodgeQMobsAttacks()
    local Missiles = ObjectManager.MissileList
    for I, Missile in pairs(Missiles) do
        if Missile.Team ~= myHero.Team and MasterYi:GetDistance(myHero.Position, Missile.Position) <= 620 then 
            if self.MobsAttacks[Missile.Name] then
                if Engine:SpellReady("HK_SPELL1") and self.UseQDodgeOnMobAttack.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", Missile.MissileStartPos, 0)
                end
            end
        end
    end
end

function MasterYi:SmartTowerDive()
    if self.SmartTowerDiveQ.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 800)
        if not target then
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(Missiles) do
                if Missile.Team ~= myHero.Team and MasterYi:GetDistance(myHero.Position, Missile.Position) <= 620 then 
                    if self.TowerShots[Missile.Name] then
                        if Engine:SpellReady("HK_SPELL1") then
                            local minion = MasterYi:GetMinionsAround()
                            if minion then
                                Engine:CastSpell("HK_SPELL1", minion.Position, 0)
                            end
                        end
                    end
                end
            end
        end
    end
end

function MasterYi:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end


local useW = false
function MasterYi:Combo() 
    local target = Orbwalker:GetTarget("Combo", 700)
    if target then
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            local wBuff = myHero.BuffData:GetBuff("doublestrike")
            if wBuff.Valid then
                useW = true
            else
                if useW then
                    Engine:CastSpell("HK_SPELL2",  nil, 0)
                    useW = false
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            local minRange = self.QMinRangeCombo.Value
            local maxRange = self.QMaxRangeCombo.Value
            if MasterYi:GetDistance(myHero.Position, target.Position) >= minRange and MasterYi:GetDistance(myHero.Position, target.Position) <= maxRange then
                Engine:CastSpell("HK_SPELL1",  target.Position,1)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            if MasterYi:GetDistance(myHero.Position, target.Position) <= MasterYi:GetAttackRange() then
                Engine:CastSpell("HK_SPELL3",  nil,0)
            end
        end
    end
end

function MasterYi:Harass() 
    local target = Orbwalker:GetTarget("Harass", 700)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            local minRange = self.QMinRangeHarass.Value
            local maxRange = self.QMaxRangeHarass.Value
            if MasterYi:GetDistance(myHero.Position, target.Position) >= minRange and MasterYi:GetDistance(myHero.Position, target.Position) <= maxRange then
                Engine:CastSpell("HK_SPELL1",  target.Position,0)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
            if MasterYi:GetDistance(myHero.Position, target.Position) <= MasterYi:GetAttackRange() then
                Engine:CastSpell("HK_SPELL3",  nil,0)
            end
        end
    end
end

function MasterYi:LaneClear() 
    local target = Orbwalker:GetTarget("Laneclear", 700)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQLaneclear.Value == 1 then
            Engine:CastSpell("HK_SPELL1",  target.Position,0)
        end
        if Engine:SpellReady("HK_SPELL3") and self.UseELaneclear.Value == 1 then
            if MasterYi:GetDistance(myHero.Position, target.Position) <= MasterYi:GetAttackRange() then
                Engine:CastSpell("HK_SPELL3",  nil,0)
            end
        end
    end
end

function MasterYi:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            MasterYi:Combo()
            MasterYi:DodgeQ()
            MasterYi:SmartTowerDive()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            MasterYi:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            MasterYi:DodgeQMobsAttacks()
            MasterYi:LaneClear()
        end
    end
end

function MasterYi:OnDraw()
    if myHero.IsDead == true then return end
    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, 600,255,0,255,255)
    end
end

function MasterYi:OnLoad()
    if myHero.ChampionName ~= "MasterYi" then return end
    AddEvent("OnSettingsSave" , function() MasterYi:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() MasterYi:LoadSettings() end)
    MasterYi:__init()
    AddEvent("OnTick", function() MasterYi:OnTick() end)
    AddEvent("OnDraw", function() MasterYi:OnDraw() end)
end

AddEvent("OnLoad", function() MasterYi:OnLoad() end)