Nocturne = {}

function Nocturne:__init()
    self.QRange = 1200
    self.RRange = 2500
    self.ERange = 425

    self.QSpeed = 1600
    self.QWidth = 120
    self.QDelay = 0.25

    self.QHitChance = 0.2

    self.HealthBarDraws		= 0

    self.NocturneMenu               = Menu:CreateMenu("Nocturne")
    self.NocturneCombo              = self.NocturneMenu:AddSubMenu("Combo")
    self.NocturneCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo                  = self.NocturneCombo:AddCheckbox("Use Q in combo", 1)
    self.UseECombo                  = self.NocturneCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo                  = self.NocturneCombo:AddCheckbox("Use R in combo", 1)
    self.RNocturneConditionCombo    = self.NocturneCombo:AddSlider("Use R over X% HP", 30,1,100,1)
    self.UseWCombo                  = self.NocturneCombo:AddCheckbox("Use W With R", 1)
    -------------------------------------------------------------------------------------------
    self.NocturneHarass             = self.NocturneMenu:AddSubMenu("Harass")
    self.NocturneHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass                 = self.NocturneHarass:AddCheckbox("Use Q in harass", 1)
    self.UseEHarass                 = self.NocturneHarass:AddCheckbox("Use E in harass", 1)
    -------------------------------------------------------------------------------------------
    self.NocturneClear              = self.NocturneMenu:AddSubMenu("Clear")
    self.NocturneClear:AddLabel("Check Spells for Clear:")
    self.UseQClear                  = self.NocturneClear:AddCheckbox("Use Q in clear", 1)
    self.UseEClear                  = self.NocturneClear:AddCheckbox("Use E in clear", 1)
    -------------------------------------------------------------------------------------------
    self.NocturneMisc               = self.NocturneMenu:AddSubMenu("Misc")
    self.NocturneMisc:AddLabel("Check Spells for Misc:")
    self.UseW                       = self.NocturneMisc:AddCheckbox("Use W to dodge abilities", 1)
    -------------------------------------------------------------------------------------------
    self.NocturneDrawings           = self.NocturneMenu:AddSubMenu("Drawings")
    self.DrawQ                      = self.NocturneDrawings:AddCheckbox("Draw Q", 1)
    self.DrawE                      = self.NocturneDrawings:AddCheckbox("Draw E", 1)
    self.DrawR                      = self.NocturneDrawings:AddCheckbox("Draw R", 1)
    self.NocturneDrawings:AddLabel("Adjust R Kill HealthBar Check")
    self.HealthBarXAxis		        = self.NocturneDrawings:AddSlider("X Axis", 100,100,4000,1)
	self.HealthBarYAxis		        = self.NocturneDrawings:AddSlider("Y Axis", 100,100,4000,1)
    Nocturne:LoadSettings()
end

function Nocturne:SaveSettings()
	SettingsManager:CreateSettings("Nocturne")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R over % HP and target in range", self.RNocturneConditionCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    ------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("Use Q in Clear", self.UseQClear.Value)
    SettingsManager:AddSettingsInt("Use E in Clear", self.UseEClear.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("WDodge", self.UseW.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    SettingsManager:AddSettingsInt("XAxis2", self.HealthBarXAxis.Value)
	SettingsManager:AddSettingsInt("YAxis2", self.HealthBarYAxis.Value)
end

function Nocturne:LoadSettings()
    SettingsManager:GetSettingsFile("Nocturne")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.RNocturneConditionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R over % HP and target in range")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.UseQClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Q in Clear")
    self.UseEClear.Value = SettingsManager:GetSettingsInt("Clear", "Use E in Clear")
    -------------------------------------------
    self.UseW.Value = SettingsManager:GetSettingsInt("Misc", "WDodge")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
    self.HealthBarXAxis.Value 		= SettingsManager:GetSettingsInt("Drawings","XAxis2")
	self.HealthBarYAxis.Value 		= SettingsManager:GetSettingsInt("Drawings","YAxis2")
end

function Nocturne:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Nocturne:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Nocturne:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Nocturne:GetTowersAround(Position, Range)
    local Count = 0 --FeelsBadMan
	local TowerList = ObjectManager.TurretList
	for i, Tower in pairs(TowerList) do	
		if Tower.Team ~= myHero.Team and Tower.Health > 100 and Tower.MaxHealth > 1000 then
			if Nocturne:GetDistance(Tower.Position, Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Nocturne:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Nocturne:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end
function Nocturne:HeroLvl() 
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Nocturne:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * self:HeroLvl() / 18)
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

function Nocturne:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = self:GetDistance(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = self:GetDistance(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if self:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

function Nocturne:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Nocturne:RDmg(Hero)
    local AAs = myHero.AttackSpeedMod * 0.721 * 1.3
    local specialAA = self:GetDamage(0.2 + myHero.BonusAttack, true, Hero)
    local aaDmg = self:GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, Hero)
    local qDmg = self:GetDamage(20 + 45 * myHero:GetSpellSlot(0).Level + 0.75 * myHero.BonusAttack, true, Hero) 
    local eDmg = self:GetDamage(35 + 45 * myHero:GetSpellSlot(2).Level + myHero.AbilityPower, false, Hero)
    local rDmg = self:GetDamage(25 + 125 * myHero:GetSpellSlot(3).Level + 1.25 * myHero.BonusAttack, true, Hero)  
    local AATimer = 2
    local TotalDmg = rDmg
    if Engine:SpellReady("HK_SPELL1") then
        TotalDmg = TotalDmg + qDmg
    end
    if Engine:SpellReady("HK_SPELL3") then
        TotalDmg = TotalDmg + eDmg
        AATimer = AATimer + 1 + 0.25 * myHero:GetSpellSlot(2).Level
    end
    TotalDmg = TotalDmg + (aaDmg * AAs * AATimer) + specialAA + aaDmg
    TotalDmg = (TotalDmg * (myHero.Health / myHero.MaxHealth)) / (self:EnemiesInRange(Hero.Position, 750) + self:GetTowersAround(Hero.Position, 750))
    if TotalDmg < (rDmg + aaDmg) then
        TotalDmg = rDmg + aaDmg
    end
    --print(TotalDmg)
    return TotalDmg
end
--nocturneparanoiadash
function Nocturne:Combo() 
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local RBuff = myHero.BuffData:GetBuff("nocturneparanoiaparticle")
        local RRangeCircle = 1750 + (750 * myHero:GetSpellSlot(3).Level)
        if RBuff.Count_Alt > 0 then
            local HeroList = ObjectManager.HeroList
            for i, Hero in pairs(ObjectManager.HeroList) do
                if Hero.Team ~= myHero.Team and not Hero.IsDead and Hero.IsTargetable then
                    local HPCondition = self.RNocturneConditionCombo.Value 
                    if myHero.Health >= myHero.MaxHealth / 100 * HPCondition then
                        if self:GetDistance(myHero.Position, Hero.Position) >= 450 and self:GetDistance(myHero.Position, Hero.Position) <= RRangeCircle then
                            if Hero.Health <= self:RDmg(Hero) then
                                return Engine:CastSpellMap("HK_SPELL4", Hero.Position, 1)
                            end
                        end
                    end
                    if Engine:GetForceTarget(Hero) then
                        return Engine:CastSpellMap("HK_SPELL4", Hero.Position, 1)
                    end
                end
            end
        end
    end


    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if self:GetDistance(myHero.Position, target.Position) <= self.ERange and target.IsMinion == false then
                return Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
        if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local RBuff = myHero.BuffData:GetBuff("nocturneparanoiaparticle")
            if self:GetDistance(myHero.Position, target.Position) >= self:GetAttackRange() then
                local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if castPos ~= nil then
                    return Engine:CastSpell("HK_SPELL1", castPos)
                end
            else
                if RBuff.Count_Alt > 0 then
                    local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                    if castPos ~= nil then
                        return Engine:CastSpell("HK_SPELL1", castPos)
                    end
                end 
            end
        end
    end
end

function Nocturne:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1000)
    if target then
        if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if self:GetDistance(myHero.Position, target.Position) <= self.ERange and target.IsMinion == false then
                return Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
        if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            if self:GetDistance(myHero.Position, target.Position) >= self:GetAttackRange() then
                local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if castPos ~= nil then
                    return Engine:CastSpell("HK_SPELL1", castPos)
                end
            end
        end
    end
end

function Nocturne:JungleClear()
    if self.UseEClear.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local AAs = myHero.AttackSpeedMod * 0.721
        local aaDmg = myHero.BaseAttack + myHero.BonusAttack
        local totalDmg = aaDmg + (AAs * aaDmg) + (myHero.BonusAttack * 0.2)
        local Minions = ObjectManager.MinionList
        for I, Minion in pairs(Minions) do
            if self:GetDistance(Minion.Position, myHero.Position) <= self.ERange then
                if Minion.Name == "Sru_Crab16.1.1" or Minion.Name == "Sru_Crab15.1.1" or Minion.Name == "SRU_Gromp14.1.1" or Minion.Name == "SRU_Gromp13.1.1" or Minion.Name == "SRU_Krug11.1.1" or Minion.Name == "SRU_Red10.1.1" or Minion.Name == "SRU_Razorbeak9.1.1" or Minion.Name == "SRU_Murkwolf8.1.1" or Minion.Name == "SRU_Blue7.1.1" or Minion.Name == "SRU_Krug5.1.1" or Minion.Name == "SRU_Red4.1.1" or Minion.Name == "SRU_Razorbeak3.1.1" or Minion.Name == "SRU_Murkwolf2.1.1" or Minion.Name == "SRU_Blue1.1.1" then
                    if Minion.Health > totalDmg then
                        return Engine:CastSpell("HK_SPELL3", Minion.Position)
                    end
                end
            end
        end
    end

    if self.UseQClear.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if target.IsTargetable and target.Team ~= myHero.Team and target.MaxHealth > 10 and target.IsMinion then
                local PredPos = Prediction:GetPredPos(myHero.Position, target, 1200, 0.25)
                if PredPos and self:GetDistance(myHero.Position, PredPos) < self.QRange  then
                    return Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
        end
    end
end

function Nocturne:DrawHealthBars(Target)
    local RCD = myHero:GetSpellSlot(3).Cooldown - GameClock.Time
    local RLevel = myHero:GetSpellSlot(3).Level
	if Target.Team ~= myHero.Team and RLevel > 0 then
        local fullHpDrawWidth = 104
		local hpDrawWidth = 104 * (Target.Health / Target.MaxHealth)
		local HPString = string.format("%.0f", Target.Health) .. " | " .. string.format("%.0f", Target.MaxHealth)
		if not Target.IsDead and Target.Health <= self:RDmg(Target) and RCD < 30 and Target.IsVisible then
            --print("WTF2")
			Render:DrawString(Target.ChampionName .. " Is R Killable", 100 + self.HealthBarXAxis.Value, 60 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), 255, 255, 255, 255)
			Render:DrawString(HPString, 100 + self.HealthBarXAxis.Value, 78 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), 255, 255, 255, 255)
			Render:DrawFilledBox(98 + self.HealthBarXAxis.Value,98 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), fullHpDrawWidth+4, 17, 255, 255, 255, 255)
			Render:DrawFilledBox(100 + self.HealthBarXAxis.Value, 100 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), fullHpDrawWidth, 13, 0, 0, 0, 255)
			Render:DrawFilledBox(100 + self.HealthBarXAxis.Value, 100 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), hpDrawWidth, 13, 252, 3, 3, 255)
			self.HealthBarDraws = self.HealthBarDraws + 1
		end
    end
end

function Nocturne:OnTick()
    --myHero.BuffData:ShowAllBuffs()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.UseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(Missiles) do
                if Missile.Team ~= myHero.Team then 
                    local Info = Evade.Spells[Missile.Name]
                    if Info ~= nil and Info.Type == 0 then
                        if self:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius) then
                            return Engine:CastSpell("HK_SPELL2",  GameHud.MousePos)
                        end
                    end
                end
            end
        end

        if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local RDashBuff = myHero.BuffData:GetBuff("nocturneparanoiadash")
            if RDashBuff.Count_Alt > 0 then
                --print("ParanoidDashing")
                return Engine:CastSpell("HK_SPELL2",  GameHud.MousePos)
            end
        end

        if Engine:IsKeyDown("HK_COMBO") then
            Nocturne:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Nocturne:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
            Nocturne:JungleClear()
        end
    end
end

function Nocturne:OnDraw()
    self.HealthBarDraws	= 0

    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 1100,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 425,255,0,255,255)
        end
    end

    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        local RRangeCircle = 1750 + (750 * myHero:GetSpellSlot(3).Level)
        Render:DrawCircleMap(myHero.Position, RRangeCircle, 255, 255, 255, 255)
    end

    local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
        self:DrawHealthBars(Hero)
    end
end

function Nocturne:OnLoad()
    if myHero.ChampionName ~= "Nocturne" then return end
    AddEvent("OnSettingsSave" , function() Nocturne:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nocturne:LoadSettings() end)
    Nocturne:__init()
    AddEvent("OnTick", function() Nocturne:OnTick() end)
    AddEvent("OnDraw", function() Nocturne:OnDraw() end)
end

AddEvent("OnLoad", function() Nocturne:OnLoad() end)