Yasuo = {}

function Yasuo:__init()
    self.QRange = 450
    self.Q2Range = 1100
    self.WRange = 400
    self.ERange = 475
    self.RRange = 1400

    self.QSpeed = 1200
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QWidth = 80
    self.Q2Width = 180

    -- update delay
    self.QDelay = 0.1337
    self.WDelay = 0.1250
    self.EDelay = 0.0000
    self.RDelay = 0.0000

    self.DashTimer = 0

    self.QHitChance = 0.2
    
    self.YasuoMenu          = Menu:CreateMenu("Yasuo")
    self.YasuoCombo         = self.YasuoMenu:AddSubMenu("Combo")
    self.UseQCombo          = self.YasuoCombo:AddCheckbox("Use Q", 1)
    self.UseECombo          = self.YasuoCombo:AddCheckbox("Use E", 1)
    self.UseRCombo          = self.YasuoCombo:AddCheckbox("Use R", 1)

    self.YasuoHarass        = self.YasuoMenu:AddSubMenu("Harass")
    self.UseQHarass         = self.YasuoHarass:AddCheckbox("Use Q", 1)

    self.YasuoLaneclear     = self.YasuoMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear      = self.YasuoLaneclear:AddCheckbox("Stack Q", 1)

    self.YasuoMisc          = self.YasuoMenu:AddSubMenu("Misc")
    self.UseWBlockOnSpells  = self.YasuoMisc:AddCheckbox("Use W (Evade only)", 1)
    
    
    self.YasuoDrawings      = self.YasuoMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.YasuoDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW              = self.YasuoDrawings:AddCheckbox("Draw W", 1)
    self.DrawE              = self.YasuoDrawings:AddCheckbox("Draw E", 1)
    self.DrawR              = self.YasuoDrawings:AddCheckbox("Draw R", 1)
    Yasuo:LoadSettings()
end

function Yasuo:SaveSettings()
	SettingsManager:CreateSettings("Yasuo")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ", self.UseQHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("StackQ", self.UseQLaneclear.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("UseW", self.UseWBlockOnSpells.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Yasuo:LoadSettings()
    SettingsManager:GetSettingsFile("Yasuo")
    self.UseQCombo.Value            = SettingsManager:GetSettingsInt("Combo", "UseQ")
    self.UseECombo.Value            = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value            = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.UseQHarass.Value           = SettingsManager:GetSettingsInt("Harass", "UseQ")
    -------------------------------------------
    self.UseQLaneclear.Value        = SettingsManager:GetSettingsInt("Laneclear", "StackQ")
    -------------------------------------------
    self.UseWBlockOnSpells.Value    = SettingsManager:GetSettingsInt("Misc", "UseW")
    -------------------------------------------
    self.DrawQ.Value                = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawW.Value                = SettingsManager:GetSettingsInt("Drawings", "DrawW")
    self.DrawR.Value                = SettingsManager:GetSettingsInt("Drawings", "DrawR")
end

function Yasuo:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
end

function Yasuo:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local Heros = ObjectManager.HeroList
    for _,Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Yasuo:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Yasuo:BlockSpellsWithW()
    if self.UseWBlockOnSpells.Value == 1 then
        if Evade ~= nil then
            local Missiles = ObjectManager.MissileList
            for _, Missile in pairs(Missiles) do 
                local Spell = Evade.Spells[Missile.Name]
                if Spell ~= nil and Missile.Team ~= myHero.Team then
                    if Prediction:PointOnLineSegment(Missile.MissileStartPos, Missile.MissileEndPos, myHero.Position, Spell.Radius + 100) then
                        if self:GetDistance(myHero.Position, Missile.Position) < self.WRange and Engine:SpellReady("HK_SPELL2") then
                            return Engine:CastSpell("HK_SPELL2", Missile.MissileStartPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:TowerCheck(Position)
    local Turrets = ObjectManager.TurretList
    for _, Turret in pairs(Turrets) do
        if Turret.Team ~= myHero.Team and Turret.IsTargetable then
            if self:GetDistance(Position, Turret.Position) < 750 + Turret.CharData.BoundingRadius and self:GetDistance(myHero.Position, Turret.Position) > 750 + Turret.CharData.BoundingRadius then
                return false
            end
        end
    end
    return true
end

function Yasuo:GetDashEndPos(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
    local EndPos        = Vector3.new(PlayerPos.x + (TargetNorm.x * self.ERange),PlayerPos.y + (TargetNorm.y * self.ERange),PlayerPos.z + (TargetNorm.z * self.ERange))
    return EndPos
end

function Yasuo:Ultimate()
    local Heros = ObjectManager.HeroList
    for _, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and self:GetDistance(myHero.Position, Hero.Position) < self.RRange then
            if Hero.BuffData:HasBuffOfType(BuffType.Knockup) == true then
                return Engine:CastSpell("HK_SPELL4", Hero.Position, 0)              
            end
        end
    end
end

function Yasuo:GetETarget(Target)
    local TargetDistance = self:GetDistance(myHero.Position, Target.Position)
    if TargetDistance < self.ERange then
        local EBuff = Target.BuffData:GetBuff("YasuoE")
        if EBuff.Count_Alt < 1 then
            local DashPosition = self:GetDashEndPos(Target)
            if self:TowerCheck(DashPosition) then
                return Target
            end
        end
    end
    local Heros = ObjectManager.HeroList
    for _, Hero in pairs(Heros) do
        if Hero.IsTargetable and Hero.Index ~= Target.Index and Hero.Team ~= myHero.Team  and Prediction:PointOnLineSegment(myHero.Position, Target.Position, Hero.Position, self.ERange) then
            local TargetHeroDistance = self:GetDistance(Target.Position, Hero.Position)
            local PlayerHeroDistance = self:GetDistance(myHero.Position, Hero.Position)
            if PlayerHeroDistance < self.ERange then
                local EBuff = Hero.BuffData:GetBuff("YasuoE")
                if EBuff.Count_Alt < 1 then
                    local DashPosition          = self:GetDashEndPos(Hero)
                    local TargetDashDistance    = self:GetDistance(Target.Position, DashPosition)
                    if self:TowerCheck(DashPosition) and TargetDashDistance < TargetDistance then
                        return Hero
                    end
                end
            end
        end
    end
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
        if Minion.IsTargetable and Minion.Team ~= myHero.Team  and Prediction:PointOnLineSegment(myHero.Position, Target.Position, Minion.Position, self.ERange) then
            local TargetMinionDistance = self:GetDistance(Target.Position, Minion.Position)
            local PlayerMinionDistance = self:GetDistance(myHero.Position, Minion.Position)
            if PlayerMinionDistance < self.ERange then
                local EBuff = Minion.BuffData:GetBuff("YasuoE")
                if EBuff.Count_Alt < 1 then
                    local DashPosition          = self:GetDashEndPos(Minion)
                    local TargetDashDistance    = self:GetDistance(Target.Position, DashPosition)
                    if self:TowerCheck(DashPosition) and TargetDashDistance < TargetDistance then
                        return Minion
                    end
                end
            end
        end
    end
    return nil
end

function Yasuo:Combo()
    local bonusAts = (myHero.AttackSpeedMod - 1) * 100
    local calcQDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
    local StartPos = myHero.Position
    if myHero.AIData.Dashing == true then
        StartPos = myHero.AIData.TargetPos
    end
    
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Combo", self.ERange*3)
        if Target and self:GetDistance(myHero.Position, Target.Position) > 300 then
            local DashTarget =  self:GetETarget(Target)
            if DashTarget then
                return Engine:CastSpell("HK_SPELL3", DashTarget.Position, 0)
            end            
        end
    end
    
    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, calcQDelay, 0, true, self.QHitChance, 1)
        if PredPos and Target and self:GetDistance(StartPos, PredPos) < self.QRange  then
            return Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end

    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") and Orbwalker.Attack == 0 then
        self:Ultimate()
    end
end

function Yasuo:Harass() 
    local bonusAts = (myHero.AttackSpeedMod - 1) * 100
    local calcQDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
    if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, calcQDelay, 0, true, self.QHitChance, 1)
        if PredPos and Target and self:GetDistance(myHero.Position, PredPos) < self.QRange  then
            return Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end
end

function Yasuo:Laneclear()
    if self.UseQLaneclear.Value == 1 and self.QRange == 450 then
        if Engine:SpellReady("HK_SPELL1") then
            local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
            if Target and Target.MaxHealth > 10 and Target.IsMinion then
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            end
        end
    end
end

function Yasuo:LastHit()
    if self.UseQLaneclear.Value == 1 and self.QRange == 450 then
        if Engine:SpellReady("HK_SPELL1") then
            local Target = Orbwalker:GetTarget("Lasthit", self.QRange)
            if Target then
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            else
                local MinionList = ObjectManager.MinionList
                for i, Minion in pairs(MinionList) do
                    if not Minion.IsDead and Minion.IsTargetable and Minion.Team ~= myHero.Team and self:GetDistance(myHero.Position, Minion.Position) <= self.QRange then
                        local qDmg = -5 + (25 * myHero:GetSpellSlot(0).Level) + (1.05 * (myHero.BaseAttack + myHero.BonusAttack))
                        if Minion.Health <= qDmg then
                            Engine:CastSpell("HK_SPELL1", Minion.Position, 1)
                        end
                    end
                end
            end
        end
    end
end

function Yasuo:CheckQ()
    local Q2 = myHero.BuffData:GetBuff("YasuoQ2")
    if Q2.Count_Alt < 1 then
        self.QRange = 450
        self.QSpeed = math.huge
    else
        self.QRange = 1100
        self.QSpeed = 1337
    end
    self.QDelay = myHero:GetSpellSlot(0).CooldownTime/10
end

function Yasuo:CheckDash()
    if myHero.AIData.Dashing == true then
        self.DashTimer = os.clock()
        Orbwalker.BlockAttack = 1

        self.QRange = 300
        self.QSpeed = math.huge
    end
    if (os.clock() - self.DashTimer) > Orbwalker:GetPlayerAttackWindup()*2 then
        Orbwalker.BlockAttack = 0
    end
end

function Yasuo:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:CheckQ()
        self:CheckDash()
        self:BlockSpellsWithW()
        if Engine:IsKeyDown("HK_COMBO") and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
            return self:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
            return self:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
            return self:LastHit()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
            return self:Laneclear()
        end
    end
end

function Yasuo:OnDraw()
    if myHero.IsDead == true then return end

    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange,100,150,255,255)
    end
    if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange,100,150,255,255)
    end
    if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange,255,155,0,255)
    end
    if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange,255,155,0,255)
    end
end

function Yasuo:OnLoad()
    if myHero.ChampionName ~= "Yasuo" then return end
    AddEvent("OnSettingsSave" , function() Yasuo:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Yasuo:LoadSettings() end)
    Yasuo:__init()
    AddEvent("OnTick", function() Yasuo:OnTick() end)
    AddEvent("OnDraw", function() Yasuo:OnDraw() end)
end

AddEvent("OnLoad", function() Yasuo:OnLoad() end)