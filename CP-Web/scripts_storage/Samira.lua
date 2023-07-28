require("SupportLib")
Samira = {}

function Samira:__init()

    self.QRange = 950
    self.Q2Range = 400
    self.WRange = 400
    self.ERange = 600
    self.RRange = 600
	
    self.QSpeed = 2600
    self.Q2Speed = math.huge
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

    self.QWidth = 120
    self.Q2Width = 130

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

    self.QHitChance = 0.2

    self.ChampionMenu       = Menu:CreateMenu("Samira")
    self.QSettings          = self.ChampionMenu:AddSubMenu("Q  Settings")
    self.UseQCombo          = self.QSettings:AddCheckbox("UseQ on Combo", 1)
    self.UseQHarass         = self.QSettings:AddCheckbox("UseQ on Harass", 1)
    self.UseQFarm           = self.QSettings:AddCheckbox("UseQ to Farm", 1)

    -------------------------------------------
    self.WSettings          = self.ChampionMenu:AddSubMenu("W Settings")
    self.UseWCombo          = self.WSettings:AddCheckbox("UseW", 1)
    self.UseWOnlyCC         = self.WSettings:AddCheckbox("Only CC", 1)
    -------------------------------------------
    self.ESettings          = self.ChampionMenu:AddSubMenu("E  Settings")
    self.UseECombo          = self.ESettings:AddCheckbox("UseE on Combo", 1)
    -------------------------------------------
    self.RSettings          = self.ChampionMenu:AddSubMenu("R  Settings")
    self.UseRCombo          = self.RSettings:AddCheckbox("UseR on Combo", 1)
    self.UseRSlider         = self.RSettings:AddSlider("R on min X enemies" , 1, 1, 5, 1)

    self.SamiraMisc         = self.ChampionMenu:AddSubMenu("Misc")
    self.InstantSCombo      = self.SamiraMisc:AddCheckbox("Instant S Combo", 1)

    self.SamiraFlee         = self.ChampionMenu:AddSubMenu("Flee")
    self.EAway      = self.SamiraFlee:AddCheckbox("EAway", 1)

    self.SamiraDrawings     = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.SamiraDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.SamiraDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.SamiraDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.SamiraDrawings:AddCheckbox("Draw R", 1)
    Samira:LoadSettings()
end

function Samira:SaveSettings()
	SettingsManager:CreateSettings("Samira")
    SettingsManager:AddSettingsGroup("QSettings")
    SettingsManager:AddSettingsInt("ComboQ", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("HarassQ", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseQFarm", self.UseQFarm.Value)

    -------------------------------------------
    SettingsManager:AddSettingsGroup("WSettings")
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("OnlyCC", self.UseWOnlyCC.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("ESettings")
    SettingsManager:AddSettingsInt("ComboE", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("RSettings")
    SettingsManager:AddSettingsInt("ComboR", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("RSlider", self.UseRSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("InstantSCombo", self.InstantSCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Flee")
    SettingsManager:AddSettingsInt("EAway", self.EAway.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Samira:LoadSettings()
    SettingsManager:GetSettingsFile("Samira")
    self.UseQCombo.Value    = SettingsManager:GetSettingsInt("QSettings", "ComboQ")
    self.UseQHarass.Value   = SettingsManager:GetSettingsInt("QSettings", "HarassQ")
    self.UseQFarm.Value   = SettingsManager:GetSettingsInt("QSettings", "UseQFarm")

    -------------------------------------------
    self.UseWCombo.Value    = SettingsManager:GetSettingsInt("WSettings", "UseW")
    self.UseWOnlyCC.Value   = SettingsManager:GetSettingsInt("WSettings", "OnlyCC")
    -------------------------------------------
    self.UseECombo.Value    = SettingsManager:GetSettingsInt("ESettings", "ComboE")
    -------------------------------------------
    self.UseRCombo.Value    = SettingsManager:GetSettingsInt("RSettings", "ComboR")  
    self.UseRSlider.Value   = SettingsManager:GetSettingsInt("RSettings", "RSlider")
    -------------------------------------------
    self.InstantSCombo.Value = SettingsManager:GetSettingsInt("Misc", "InstantSCombo")
    -------------------------------------------
    self.EAway.Value = SettingsManager:GetSettingsInt("Flee", "EAway")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "DrawR")
end

function Samira:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Samira:Q()
    if Engine:SpellReady("HK_SPELL1") then
        local RangePos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
        if RangePos then
            return Engine:ReleaseSpell("HK_SPELL1", RangePos)
        end
        local MeleePos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, self.Q2Width, self.QDelay, 0, true, self.QHitChance, 0)
        if MeleePos then
            return Engine:ReleaseSpell("HK_SPELL1", MeleePos)
        end
    end
end

function Samira:W()
    if Engine:SpellReady("HK_SPELL2") then
        local ShieldTarget, Missile = SupportLib:GetShieldTarget(self.ERange, 100)
        if ShieldTarget and Missile and Missile.Team ~= 300 then
            if self.UseWOnlyCC.Value == 0 or (Evade and Evade.Spells[Missile.Name] and Evade.Spells[Missile.Name].CC == 1) then
                if Prediction:PointOnLineSegment(Missile.MissileStartPos, Missile.MissileStartPos, myHero.Position, Evade.Spells[Missile.Name].Radius * 1.5) then
                    return Engine:ReleaseSpell("HK_SPELL2", nil)
                end
            end
        end
    end
end

function Samira:EMinion()
    local MinionList = ObjectManager.MinionList
    for _, Minion in pairs(MinionList) do
        if Minion.IsTargetable and Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 then
            local Enemies = SupportLib:GetEnemiesInRange(Minion.Position, self.RRange)
            if #Enemies >= self.UseRSlider.Value then
                for _, Enemy in pairs(Enemies) do
                    if self:GetDistance(Enemy.Position, myHero.Position) > self.ERange/2 then
                        return Minion
                    end
                end
            end
        end
    end
    return nil
end

function Samira:E()
    if Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        local RCD = myHero:GetSpellSlot(3).Cooldown - GameClock.Time
        local RBuff = myHero.BuffData:GetBuff("SamiraR")
        if Target then
            local AA = myHero.BaseAttack + myHero.BonusAttack
            local qDmg = -5 + (5 * myHero:GetSpellSlot(0).Level) + ((myHero.BaseAttack + myHero.BonusAttack) * (0.7 + (0.1 * myHero:GetSpellSlot(0).Level)))
            local eDmg = 40 + (10 * myHero:GetSpellSlot(2).Level) + (1.2 * AA)
            local totalDmg = AA + qDmg + eDmg
            if Target.Health <= totalDmg then
                if self:GetDistance(myHero.Position, Target.Position) <= self.ERange then
                    return Engine:ReleaseSpell("HK_SPELL3", Target.Position)
                end
            end
        end
        if myHero.Ammo > 3 and (RCD <= 0 or RBuff.Count_Alt > 0) then
            if Target and self:GetDistance(Target.Position, myHero.Position) > self.ERange/2 then
                return Engine:ReleaseSpell("HK_SPELL3", Target.Position)
            end
            local Minion = self:EMinion()
            if Minion then 
                return Engine:ReleaseSpell("HK_SPELL3", Minion.Position)
            end
        end
    end
end

function Samira:R()
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local Enemies = SupportLib:GetEnemiesInRange(myHero.Position, self.RRange)
        if #Enemies >= self.UseRSlider.Value then
            return Engine:ReleaseSpell("HK_SPELL4", nil)
        end
    end
end

function Samira:QLastHit()
    if Engine:SpellReady("HK_SPELL1") then
        local qDmg = -5 + (5 * myHero:GetSpellSlot(0).Level) + ((myHero.BaseAttack + myHero.BonusAttack) + (0.75 + (0.1 * myHero:GetSpellSlot(0).Level)))
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            local AARange = myHero.AttackRange + myHero.CharData.BoundingRadius
            if self:GetDistance(myHero.Position, target.Position) > AARange then
                if target.Health <= qDmg then
                    return Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end
end

function Samira:InstantS()
    if Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            if Orbwalker.ResetReady == 1 and self:GetDistance(myHero.Position, target.Position) <= self.WRange then
                return Engine:CastSpell("HK_SPELL2", nil, 1)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            local SamiraW = myHero.BuffData:GetBuff("SamiraW").Valid
            if SamiraW then
                return Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") then
        if not Engine:SpellReady("HK_SPELL3") then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
    if Engine:SpellReady("HK_SPELL4") then
        return Engine:CastSpell("HK_SPELL4", nil, 1)
    end
end

function Samira:Safe()
    if Engine:SpellReady("HK_SPELL3") then
        local MinionList = ObjectManager.MinionList
        local FurthestMinion = nil
        for i, Minion in pairs(MinionList) do
            if not Minion.IsDead and Minion.IsTargetable and Minion.Team ~= myHero.Team and self:GetDistance(myHero.Position, Minion.Position) <= self.ERange then
                if FurthestMinion == nil then
                    FurthestMinion = Minion
                end
                if FurthestMinion ~= nil then
                    if self:GetDistance(myHero.Position, FurthestMinion.Position) > self:GetDistance(myHero.Position, Minion.Position) then
                        FurthestMinion = Minion
                    end
                end
            end
        end
        if FurthestMinion ~= nil then
            Engine:CastSpell("HK_SPELL3", FurthestMinion.Position, 0)
        end
    end
end

function Samira:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.UseWCombo.Value == 1 then
            self:W()
        end
        -- myHero.BuffData:ShowAllBuffs()
        if Orbwalker.Attack == 0 then
            if Engine:IsKeyDown("HK_COMBO") then
                if self.InstantSCombo.Value == 1 then
                    self:InstantS()
                end
                self:R()
                if self.UseQCombo.Value == 1 then
                    self:Q()
                end
                if self.UseECombo.Value == 1 then
                    self:E()
                end
            end
            if Engine:IsKeyDown("HK_HARASS") then
                if self.UseQHarass.Value == 1 then
                    self:Q()
                end
            end
            if self.UseQFarm.Value == 1 and Engine:IsKeyDown("HK_LASTHIT") or Engine:IsKeyDown("HK_LANECLEAR") then
                self:QLastHit()
            end
            if Engine:IsKeyDown("HK_FLEE") then
                self:Safe()
            end
        end
    end
end

function Samira:OnDraw()
	if myHero.IsDead then return end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Samira:OnLoad()
    if myHero.ChampionName ~= "Samira" then return end
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
    self:__init()
    AddEvent("OnTick", function() self:OnTick() end)
    AddEvent("OnDraw", function() self:OnDraw() end)
end

AddEvent("OnLoad", function() Samira:OnLoad() end)