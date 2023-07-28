Katarina = {}

function Katarina:__init()
    self.PassiveRange =  350
    self.QRange = 625
    self.QSpeed = math.huge
    self.QWidth = 200
    self.QDelay = 0.25

    self.WRange = 800
    self.WSpeed = math.huge
    self.WWidth = 450
    self.WDelay = 0

    self.ERange = 720
    self.ESpeed = math.huge
    self.EWidth = 150
    self.EDelay = 0

    self.RRange = 550

    self.QHitChance = 0.2
    self.WHitChance = 0.2

    self.KatarinaMenu = Menu:CreateMenu("Katarina")
    self.KatarinaCombo = self.KatarinaMenu:AddSubMenu("Combo")
    self.KatarinaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KatarinaCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.KatarinaCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.KatarinaCombo:AddCheckbox("Use E in combo", 0)
    self.UseRCombo = self.KatarinaCombo:AddCheckbox("Use R in combo", 1)
    self.ComboUseREnemiesSlider = self.KatarinaCombo:AddSlider("Use R if more then x enemies", 2,1,5,1)
    self.KatarinaHarass = self.KatarinaMenu:AddSubMenu("Harass")
    self.KatarinaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KatarinaHarass:AddCheckbox("Use Q in harass", 1)
    self.KatarinaMisc = self.KatarinaMenu:AddSubMenu("Misc")
    self.QLastHit = self.KatarinaMisc:AddCheckbox("Use Q in Lasthit", 1)
    self.QWaveClear = self.KatarinaMisc:AddCheckbox("Use Q in Laneclear", 1)
    self.KatarinaDrawings = self.KatarinaMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KatarinaDrawings:AddCheckbox("Draw Q", 1)
    self.DrawDaggers = self.KatarinaDrawings:AddCheckbox("Draw Daggers", 1)
    self.DrawE = self.KatarinaDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.KatarinaDrawings:AddCheckbox("Draw R", 1)

    self.Daggers = {}
    self.DaggerOnTheWay = 0

    Katarina:LoadSettings()
end

function Katarina:SaveSettings()
	SettingsManager:CreateSettings("Katarina")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies", self.ComboUseREnemiesSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use Q in lasthit", self.QLastHit.Value)
    SettingsManager:AddSettingsInt("Use Q in laneclear", self.QWaveClear.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw Daggers", self.DrawDaggers.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Katarina:LoadSettings()
    SettingsManager:GetSettingsFile("Katarina")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.ComboUseREnemiesSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    -------------------------------------------
    self.QLastHit.Value = SettingsManager:GetSettingsInt("Misc", "Use Q in lasthit")
    self.QWaveClear.Value = SettingsManager:GetSettingsInt("Misc", "Use Q in laneclear")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawDaggers.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Daggers")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Katarina:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Katarina:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Katarina:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Katarina:GetDamage(rawDmg, isPhys, target)
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

function Katarina:GetAllDaggers()
    self.Daggers = {}
    self.DaggerOnTheWay = 0
    
    local Missiles = ObjectManager.MissileList
    local DaggerNames = {"KatarinaQDaggerArc", "KatarinaQDaggerArc2", "KatarinaQDaggerArc3", "KatarinaWDaggerArc","KatarinaQMis"}
    for _, Missile in pairs(Missiles) do
        --print ( Missile.Name)
        --for _, Name in pairs(DaggerNames) do
            if "KatarinaQMis" == Missile.Name and Missile.IsDead == false then
                self.DaggerOnTheWay = 1
            end
        --end
    end

    --if self.DaggerOnTheWay == 0 then
        local Minions = ObjectManager.MinionList
        for _, Minion in pairs(Minions) do
            if Minion.Name == "HiddenMinion" and Minion.IsDead == false then
                self.Daggers[#self.Daggers + 1] = Minion
            end
        end
    --end
    --print(#self.Daggers)
end

function Katarina:GetBestDagger()
    for _, Dagger in pairs(self.Daggers) do
        local Enemies = Orbwalker:SortList(self:EnemiesInRange(Dagger.Position, self.PassiveRange), "LOWHP")
        for _, Enemy in pairs(Enemies) do 
            if self:GetDistance(myHero.Position, Dagger.Position) < self.ERange then
                return Dagger
            end
        end    
    end
    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.WHitChance, 0)
    if Target then
        return Target
    end
    return nil
end

function Katarina:CheckRKillable()
    local QLevel = myHero:GetSpellSlot(0).Level
    local WLevel = myHero:GetSpellSlot(1).Level
    local ELevel = myHero:GetSpellSlot(2).Level
    local RLevel = myHero:GetSpellSlot(3).Level

    local HeroLevel = math.max(1, math.min( 18, (QLevel + WLevel + ELevel + RLevel)))

    local PassiveDamage = {68,72,77,82,89,96,103,112,121,131,142,154,166,180,194,208,224,240}
    local QDamage = {75 , 105 , 135 , 165 , 195}
    local EDamage = {15 , 30 , 45 , 60 , 75}
    local RDamage = {375 , 562.5 , 750}

    local PDMG = 0
    local QDMG = 0
    local EDMG = 0 
    local RDMG = 0
    
    if HeroLevel > 0 then PDMG = PassiveDamage[HeroLevel] + ((0.75 *  myHero.BonusAttack) + (0.88 * myHero.AbilityPower)) end
    if QLevel > 0 then QDMG = QDamage[QLevel] + (0.3 * myHero.AbilityPower) end
    if ELevel > 0 then EDMG = EDamage[ELevel] + ((0.5 * (myHero.BaseAttack + myHero.BonusAttack)) + (0.25 * myHero.AbilityPower)) end
    if RLevel > 0 then RDMG = RDamage[RLevel] + (2.85 * myHero.AbilityPower) end
    
    local MaxDMG = PDMG + QDMG + EDMG + RDMG

    --print(MaxDMG)
    local Enemies = Orbwalker:SortList(self:EnemiesInRange(myHero.Position, self.ERange), "LOWHP")
    for _, Enemy in pairs(Enemies) do    
        if self:GetDistance(myHero.Position, Enemy.Position) < self.RRange and Enemy.Health < MaxDMG then
            return true
        end
    end
    
    return false
end

function Katarina:Combo()
    local RStartTime = myHero:GetSpellSlot(3).StartTime
    local EnemiesInRange = self:EnemiesInRange(myHero.Position, self.RRange)
    if RStartTime > 0 and #EnemiesInRange > 0 then
        return
    end

    local BestDagger = self:GetBestDagger()
    if BestDagger and Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 and self.DaggerOnTheWay == 0 and Orbwalker.ResetReady == 1 then
        return Engine:CastSpell("HK_SPELL3", BestDagger.Position, 1)
    end

    if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
        if Target then
            return Engine:CastSpell("HK_SPELL2", nil, 1)         
        end
    end 

    local RKillable = self:CheckRKillable()
    if (self.UseWCombo.Value == 0 or Engine:SpellReady("HK_SPELL2") == false) and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        if #EnemiesInRange > self.ComboUseREnemiesSlider.Value or RKillable == true then
            return Engine:CastSpell("HK_SPELL4", nil, 1)         
        end
        local Hero 	= Orbwalker.ForceTarget
        if Hero ~= nil and Hero.Team ~= myHero.Team and Hero.IsHero and Hero.IsTargetable then
            if self:GetDistance(myHero.Position, Hero.Position) < self.RRange then
                return Engine:CastSpell("HK_SPELL4", nil, 1)  
            end      
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 1)         
        end
        return
    end   
end

function Katarina:Harass() 
    if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 1)         
        end
        return
    end
end

function Katarina:QKillMinion()
    if Engine:SpellReady("HK_SPELL1") and self.QLastHit.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange - 65)
        if Target then
            local QDmg = 45 + (30 * myHero:GetSpellSlot(0).Level) + 0.3 * myHero.AbilityPower
            if Target.Health <= QDmg then
                return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
            end
        end
    end
end

function Katarina:QLaneclear()
    if Engine:SpellReady("HK_SPELL1") and self.QWaveClear.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange - 65)
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 0)         
        end
    end
end

function Katarina:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:GetAllDaggers()
        --myHero.BuffData:ShowAllBuffs()
        if Engine:IsKeyDown("HK_COMBO") then
            return Katarina:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            return Katarina:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            return Katarina:QKillMinion()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            return Katarina:QLaneclear()
        end
    end
end

function Katarina:OnDraw()
    if myHero.IsDead == true then return end
    if self.DrawDaggers.Value == 1 then
        for _, Dagger in pairs(self.Daggers) do
            Render:DrawCircle(Dagger.Position,self.PassiveRange, 255,155,0,255)
        end
    end
    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange,100,150,255,255)
    end
    if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange,255,155,0,255)
    end
    if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange,255,155,0,255)
    end

    local RStartTime = myHero:GetSpellSlot(3).StartTime
	if RStartTime > 0 then
		Orbwalker:Disable()
		return
	end
	Orbwalker:Enable()
end

function Katarina:OnLoad()
    if myHero.ChampionName ~= "Katarina" then return end
    AddEvent("OnSettingsSave" , function() Katarina:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Katarina:LoadSettings() end)
    Katarina:__init()
    AddEvent("OnTick", function() Katarina:OnTick() end)
    AddEvent("OnDraw", function() Katarina:OnDraw() end)
end

AddEvent("OnLoad", function() Katarina:OnLoad() end)