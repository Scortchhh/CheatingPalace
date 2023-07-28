local Zilean = {

}

function Zilean:__init()

    self.QRange = 900
    self.ERange = 625
    self.RRange = 910
    
    self.QSpeed = math.huge
    self.QWidth = 140
    self.QDelay = 0.25

    self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Zilean")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("Use Q", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("Use W", 1)
	self.ComboUseE = self.ComboMenu:AddCheckbox("Use E", 1)
    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.ComboUseR = self.MiscMenu:AddCheckbox("Auto R", 1)
  
    self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1)

    Zilean:LoadSettings()
end

function Zilean:SaveSettings()
	SettingsManager:CreateSettings("Zilean")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Zilean:LoadSettings()
    SettingsManager:GetSettingsFile("Zilean")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo", "UseQ")
    self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo", "UseR")

    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "DrawR")
end

function Zilean:EnemiesInRange(Position, Range)
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

--ZileanQMissile
function Zilean:GetBombTarget()
    local StartPos      = myHero.Position
    local Heros         = ObjectManager.HeroList
    local Minions       = ObjectManager.MinionList
    local Missiles      = ObjectManager.MissileList
    for _, Missile in pairs(Missiles) do
        if Missile.Team == myHero.Team and Missile.Name == "ZileanQMissile" then
            local PredPos = Prediction:GetCastPos(Missile.MissileEndPos, 300, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos and Orbwalker:GetDistance(StartPos, PredPos) < self.QRange then return PredPos end
        end
    end      
    for _, Hero in pairs(Heros) do
        local Bomb = Hero.BuffData:GetBuff("ZileanQEnemyBomb")
        local Time = (Bomb.EndTime - GameClock.Time) - 0.2 
        if Bomb.Count_Alt > 0 and Time > self.QDelay then
            local PredPos = Prediction:GetCastPos(Hero.Position, 300, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos and Orbwalker:GetDistance(StartPos, PredPos) < self.QRange then return PredPos end
        end
        Bomb = Hero.BuffData:GetBuff("ZileanQAllyBomb")
        Time = (Bomb.EndTime - GameClock.Time) - 0.2 
        if Bomb.Count_Alt > 0 and Time > self.QDelay then
            local PredPos = Prediction:GetCastPos(Hero.Position, 300, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos and Orbwalker:GetDistance(StartPos, PredPos) < self.QRange then return PredPos end
        end
    end
    for _, Minion in pairs(Minions) do
        local Bomb = Minion.BuffData:GetBuff("ZileanQEnemyBomb")
        local Time = (Bomb.EndTime - GameClock.Time) - 0.2 
        if Bomb.Count_Alt > 0 and Time > self.QDelay then
            local PredPos = Prediction:GetCastPos(Minion.Position, 300, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos and Orbwalker:GetDistance(StartPos, PredPos) < self.QRange then return PredPos end
        end
        Bomb = Minion.BuffData:GetBuff("ZileanQAllyBomb")
        Time = (Bomb.EndTime - GameClock.Time) - 0.2 
        if Bomb.Count_Alt > 0 and Time > self.QDelay then
            local PredPos = Prediction:GetCastPos(Minion.Position, 300, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos and Orbwalker:GetDistance(StartPos, PredPos) < self.QRange then return PredPos end
        end
    end
    return Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
end

function Zilean:GetRTarget()
    local Heros     = ObjectManager.HeroList
    local Turrets   = ObjectManager.TurretList
    local Missiles  = ObjectManager.MissileList
    for _, Hero in pairs(Heros) do
        if myHero.Team == Hero.Team and Orbwalker:GetDistance(Hero.Position, myHero.Position) < self.RRange then
            local Enemies = self:EnemiesInRange(Hero.Position, 1200)
            if #Enemies > 0 then
                for _, Enemy in pairs(Enemies) do
                    local IsDashing         = Enemy.AIData.Dashing
                    local DashPosition      = Enemy.AIData.TargetPos
                    if Orbwalker:GetDistance(Hero.Position, DashPosition) <= 300 and IsDashing == true then --Ally gets dashed
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local ArmorMod  = 100 / (100 + Hero.Armor)
                        local APDamage  = Enemy.AbilityPower
                        local MRMod     = 100 / (100 + Hero.MagicResist)
                        if (Hero.Health < (ADDamage * ArmorMod) * 3) or (Hero.Health < (APDamage * MRMod) * 3) then
                            return Hero
                        end
                    end

                    if Orbwalker:GetDistance(Hero.Position, Enemy.Position) <= 300 and string.len(Enemy.ActiveSpell.Info.Name) > 0 then --Ally in Melee Range
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local ArmorMod  = 100 / (100 + Hero.Armor)
                        local APDamage  = Enemy.AbilityPower
                        local MRMod     = 100 / (100 + Hero.MagicResist)
                        if (Hero.Health < (ADDamage * ArmorMod) * 3) or (Hero.Health < (APDamage * MRMod) * 3) then
                            return Hero
                        end
                    end
                end
            end
        end
    end
    for _, Missile in pairs(Missiles) do
        local Source = Heros[Missile.SourceIndex] or Turrets[Missile.SourceIndex]
        local Target = Heros[Missile.TargetIndex]
        if Source and Target and Source.Team ~= myHero.Team and Target.Team == myHero.Team then
            local ADDamage  = Source.BaseAttack + Source.BonusAttack
            local ArmorMod  = 100 / (100 + Target.Armor)
            local APDamage  = Source.AbilityPower
            local MRMod     = 100 / (100 + Target.MagicResist)
            if (Target.Health < (ADDamage * ArmorMod) * 3) or (Target.Health < (APDamage * MRMod) * 3) then
                return Target
            end
        end
        if Source and Source.Team ~= myHero.Team then
            for _, Hero in pairs(Heros) do
                if myHero.Team == Hero.Team and Orbwalker:GetDistance(Hero.Position, myHero.Position) < self.RRange then
                    local StartPos  = Missile.MissileStartPos
                    local EndPos    = Missile.MissileEndPos
                    if Prediction:PointOnLineSegment(StartPos, EndPos, Hero.Position, Missile.MissileInfo.Data.MissileWidth + Hero.CharData.BoundingRadius) then
                        local HealthPercent = Hero.Health / Hero.MaxHealth
                        if HealthPercent < 0.2 and Orbwalker:GetDistance(Hero.Position, Missile.Position) < 300 then
                            return Hero
                        end
                    end
                end
            end
        end
    end
    return nil
end

function Zilean:Combo()
    local QReady    = Engine:SpellReady("HK_SPELL1")
    local WReady    = Engine:SpellReady("HK_SPELL2")
    local EReady    = Engine:SpellReady("HK_SPELL3")

    local StartPos  = myHero.Position
    local QCooldown = myHero:GetSpellSlot(0).Cooldown - GameClock.Time
    
    if self.ComboUseE.Value == 1 and EReady then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        if Target and Target.BuffData:GetBuff("timewarpslow").Count_Alt == 0 and Target.BuffData:GetBuff("Stun").Count_Alt == 0  then
             return Engine:CastSpell("HK_SPELL3",Target.Position, 1)  
        end
    end

    if self.BombPosition then
        if self.ComboUseQ.Value == 1 and QReady then
            return Engine:CastSpell("HK_SPELL1", self.BombPosition, 1)
        end
        if self.ComboUseW.Value == 1 and WReady and QCooldown > 3 then -- only W if second bomb still gets thrown 
            return Engine:ReleaseSpell("HK_SPELL2",nil)
        end
    end
end

function Zilean:Harass()
end

function Zilean:OnTick()
    --myHero.BuffData:ShowAllBuffs()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then      
        self.BombPosition = self:GetBombTarget()
        if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            local RTarget = self:GetRTarget()
            if RTarget then
                return Engine:ReleaseSpell("HK_SPELL4",RTarget.Position)  
            end
        end
        if Engine:IsKeyDown("HK_COMBO") then
            Zilean:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Zilean:Harass()
        end
    end
end

function Zilean:OnDraw()
    if myHero.IsDead == true then return end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if self.BombPosition then
            --Render:DrawCircle(self.BombPosition, 300 ,255,200,55,255)
        end
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,255,200,55,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,50,0,255)
    end
end

function Zilean:OnLoad()
    if myHero.ChampionName ~= "Zilean" then return end
    AddEvent("OnSettingsSave" , function() Zilean:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Zilean:LoadSettings() end)
    Zilean:__init()
    AddEvent("OnDraw", function() Zilean:OnDraw() end)
    AddEvent("OnTick", function() Zilean:OnTick() end)
end

AddEvent("OnLoad", function() Zilean:OnLoad() end)	