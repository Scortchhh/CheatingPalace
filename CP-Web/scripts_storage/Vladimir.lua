local Vladimir = {}

function Vladimir:__init()

    self.ERange = 600
    self.ESpeed = 4000
    self.EWidth = 120
    self.EDelay = 0


    self.KeyNames = {}

    self.KeyNames[4]         = "HK_SUMMONER1"
    self.KeyNames[5]         = "HK_SUMMONER2"

    self.EHitChance = 0.2

    self.ScriptVersion = "          --ELITE500 Version: 1.0 (FULL RELEASE)--"

    self.ECast = false
    --self.EChargeDmg = 15 + (15 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.025) + (myHero.AbilityPower * 0.35)
    self.EChargeDMG3 = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)

    self.TowerShots = {
        ["SRUAP_Turret_Chaos1BasicAttack"] = "SRUAP_Turret_Chaos1BasicAttack",
        ["SRUAP_Turret_Chaos2BasicAttack"] = "SRUAP_Turret_Chaos2BasicAttack",
        ["SRUAP_Turret_Chaos3BasicAttack"] = "SRUAP_Turret_Chaos3BasicAttack",
        ["SRUAP_Turret_Chaos4BasicAttack"] = "SRUAP_Turret_Chaos4BasicAttack",
    }

    self.ChampionMenu = Menu:CreateMenu("Vladimir")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("Use R in combo", 1)
    self.SingleR = self.Combomenu:AddCheckbox("Single target R if killable", 1)
    self.ForceR = self.Combomenu:AddCheckbox("^ only targed focused enemies", 1)
    self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    self.IgniteUsage = self.Combomenu:AddCheckbox("Use Ignite KS", 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.QaaReset = self.Harassmenu:AddCheckbox("Use Q as AA reset in harass", 1)
    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    -------------------------------------------
    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.QFarmA = self.Clearmenu:AddCheckbox("(ComingSoon) Q auto farm assist", 1)
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    -------------------------------------------
    self.Miscmenu = self.ChampionMenu:AddSubMenu("W Settings")
    self.Miscmenu:AddLabel("1.Comined with low health")
    self.QandEcd = self.Miscmenu:AddCheckbox("Use W only when Q and E on cd", 1)
    self.SmartTowerDiveW = self.Miscmenu:AddCheckbox("1.Tower dive with W", 1)
    self.UseWDodgeOnSpells = self.Miscmenu:AddCheckbox("1.Dodge spells with W", 1)
    self.UseWHealth = self.Miscmenu:AddCheckbox("Use W low hp", 1)
    self.WHealth = self.Miscmenu:AddSlider("% Health to use W", 45, 1, 100, 1)
    self.UseWEnemies = self.Miscmenu:AddCheckbox("1.Use W in combo X more enemies", 1)
    self.WEnemies = self.Miscmenu:AddSlider("Enemies > Allies", 2, 1, 4, 1)
    -------------------------------------------
    self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawKillable = self.Drawings:AddCheckbox("Draw if enemy killable", 1)
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0) self.UseWDodgeOnSpells
	
	Vladimir:LoadSettings()
end

function Vladimir:SaveSettings()
	SettingsManager:CreateSettings("CCVladimir")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("SR", self.SingleR.Value)
    SettingsManager:AddSettingsInt("FR", self.ForceR.Value)
    SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    SettingsManager:AddSettingsInt("IKS", self.IgniteUsage.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("QAAR", self.QaaReset.Value)
    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("QFarmA", self.QFarmA.Value)
    SettingsManager:AddSettingsInt("ClearQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("ClearE", self.ClearE.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("QAECD", self.QandEcd.Value)
    SettingsManager:AddSettingsInt("STDW", self.SmartTowerDiveW.Value)
    SettingsManager:AddSettingsInt("WDS", self.UseWDodgeOnSpells.Value)
    SettingsManager:AddSettingsInt("UWH", self.UseWHealth.Value)
    SettingsManager:AddSettingsInt("WHealthPercent", self.WHealth.Value)
    SettingsManager:AddSettingsInt("UWE", self.UseWEnemies.Value)
    SettingsManager:AddSettingsInt("WEnemies", self.WEnemies.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DK", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Vladimir:LoadSettings()
	SettingsManager:GetSettingsFile("CCVladimir")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.SingleR.Value = SettingsManager:GetSettingsInt("Combo", "SR")
    self.ForceR.Value = SettingsManager:GetSettingsInt("Combo", "FR")
    self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    self.IgniteUsage.Value = SettingsManager:GetSettingsInt("Combo", "IKS")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.QaaReset.Value = SettingsManager:GetSettingsInt("Harass", "QAAR")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","HE")
    -------------------------------------------
    self.QFarmA.Value = SettingsManager:GetSettingsInt("Clear", "QFarmA")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "ClearQ")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "ClearE")
    -------------------------------------------
    self.QandEcd.Value = SettingsManager:GetSettingsInt("Misc", "QAECD")
    self.SmartTowerDiveW.Value = SettingsManager:GetSettingsInt("Misc", "STDW")
    self.UseWDodgeOnSpells.Value = SettingsManager:GetSettingsInt("Misc", "WDS")
    self.UseWHealth.Value = SettingsManager:GetSettingsInt("Misc", "UWH")
    self.WHealth.Value = SettingsManager:GetSettingsInt("Misc", "WHealthPercent")
    self.UseWEnemies.Value = SettingsManager:GetSettingsInt("Misc", "UWE")
    self.WEnemies.Value = SettingsManager:GetSettingsInt("Misc", "WEnemies")
    -------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings", "DK")
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

local function AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Vladimir:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = GetDist(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = GetDist(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if GetDist(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Vladimir:GetSummonerKey(SummonerName)
    for i = 4 , 5 do
        if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
            return self.KeyNames[i]
        end
    end
    return nil
end

function Vladimir:UseIgnite(target)
	Engine:CastSpell(self.IgniteKey, target.Position, 1)
end

function Vladimir:Ignite_Check()
    if self.IgniteUsage.Value == 1 then
        self.IgniteKey                    = self:GetSummonerKey("SummonerDot")    
        if self.IgniteKey     ~= nil then
            self.IgniteUp = Engine:SpellReady(self.IgniteKey)
            self.IgniteDamage = 50 + (20 * GetMyLevel())
        else
            self.IgniteUp = false
            self.IgniteDamage = 0
        end
    else
        self.IgniteUp = false
        self.IgniteDamage = 0
    end
    return self.IgniteUp
end

function Vladimir:IgniteKS()
    if self.IgniteUsage.Value == 1 then
        self.IgniteKey                    = self:GetSummonerKey("SummonerDot")    
        if self.IgniteKey     ~= nil then
            self.IgniteUp = Engine:SpellReady(self.IgniteKey)
            self.IgniteDamage = 50 + (20 * GetMyLevel())
        else
            self.IgniteUp = false
            self.IgniteDamage = 0
        end
    else
        self.IgniteUp = false
        self.IgniteDamage = 0
    end
    local target = Orbwalker:GetTarget("Combo", 600)
    if target ~= nil then
        if self.IgniteUp and self.IgniteDamage > target.Health then
            self:UseIgnite(target)
        end
    end
end

function Vladimir:RCheckIgnite(Target)
    local RDamageFlat = 50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.7)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local EmpQDamageFlat = QDamageFlat * 1.85
    local EDamageFlat = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    local RQDamageFlat = QDamageFlat * 1.1
    local REmpQDamageFlat = EmpQDamageFlat * 1.1
    local REDamageFlat = EDamageFlat * 1.1
    local RAAdmg = 3 * myHero.BaseAttack * 1.1
    local RIgniteDmg = 50 + (20 * GetMyLevel())
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = ((100 / (100 + realMR)) * (RDamageFlat + REmpQDamageFlat + REDamageFlat + QDamageFlat)) + ((100/ (100 + Target.Armor)) * RAAdmg) + RIgniteDmg
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Vladimir:RCheck(Target)
    local RDamageFlat = 50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.7)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local EmpQDamageFlat = QDamageFlat * 1.85
    local EDamageFlat = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    local RQDamageFlat = QDamageFlat * 1.1
    local REmpQDamageFlat = EmpQDamageFlat * 1.1
    local REDamageFlat = EDamageFlat * 1.1
    local RAAdmg = 3 * myHero.BaseAttack * 1.1
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = (((100 / (100 + realMR)) * (RDamageFlat + REmpQDamageFlat + REDamageFlat + QDamageFlat))) + ((100/ (100 + Target.Armor)) * RAAdmg)
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Vladimir:NoRCheck(Target)
    local RDamageFlat = 50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.7)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local EmpQDamageFlat = QDamageFlat * 1.85
    local EDamageFlat = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    local AAdmg = 2 * myHero.BaseAttack
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = (((100 / (100 + realMR)) * (EmpQDamageFlat + EDamageFlat + QDamageFlat))) + ((100/ (100 + Target.Armor)) * AAdmg)
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Vladimir:FastComboII(Target)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local EmpQDamageFlat = QDamageFlat * 1.85
    local EDamageFlat = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = (100 / (100 + realMR)) * (EmpQDamageFlat + EDamageFlat)
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Vladimir:FastComboI(Target)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local EmpQDamageFlat = QDamageFlat * 1.85
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = (100 / (100 + realMR)) * EmpQDamageFlat
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

function Vladimir:Qdmg(Target)
    local QDamageFlat = 60 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local FinalFullDmg = (100 / (100 + realMR)) * QDamageFlat - 5
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end

--function Vladimir:Qhit(Target)
--    local FinalFullDmg = myHero.BaseAttack * 0.93
--    if FinalFullDmg > Target.Health then
--        return true
--    end
--    return false
--end

--function Vladimir:Ignite_Check()
--	local Ignite 					= {}
--			Ignite.Key				= self:GetSummonerKey("Dot")	
--	if Ignite.Key ~= nil then
--		if Engine:SpellReady(Ignite.Key) then
--			Ignite.Target 			= self:GetTarget(500)
--			if Ignite.Target ~= nil then
--				return Ignite
--			end
--		end
--	end
--	return false
--end

--local Ignite				= self:Ignite_Check()
--if self.UseIgnite.Value 	== 1 and Ignite 		~= false and Orbwalker.Attack == 0 then
    --Engine:CastSpell(Ignite.Key,Ignite.Target.Position,1)
    --return
--end	

local function ChargedEdmg()
    local EStartTime = myHero:GetSpellSlot(2).StartTime
    local EChargeTime = GameClock.Time - EStartTime
    --local ECharge = myHero.ActiveSpell.Info.Name
    local EChargeDMG1 = 15 + (15 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.025) + (myHero.AbilityPower * 0.35)
    local EChargeDMG2 = (EChargeTime * (10 + (10 * myHero:GetSpellSlot(2).Level)) + (EChargeTime * (myHero.MaxHealth * 0.0233)) + (EChargeTime * (myHero.AbilityPower * 0.3)))
    local EChargeDMG3 = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    if (EChargeDMG1 + EChargeDMG2) < (EChargeDMG3 -10) then return false end
    return true
end
--function Vladimir:CastingE()
    --local EStartTime = myHero:GetSpellSlot(2).StartTime
    --local EChargeTime = GameClock.Time - EStartTime
    --local ECharge = myHero.ActiveSpell.Info.Name
    --local EChargeDMG1 = 15 + (15 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.025) + (myHero.AbilityPower * 0.35)
    --local EChargeDMG2 = (EChargeTime * (10 + (10 * myHero:GetSpellSlot(2).Level)) + (EChargeTime * (myHero.MaxHealth * 0.0233)) + (EChargeTime * (myHero.AbilityPower * 0.3)))
    --local EChargeDMG3 = 30 + (30 * myHero:GetSpellSlot(2).Level) + (myHero.MaxHealth * 0.06) + (myHero.AbilityPower * 0.8)
    --if ECharge == "VladimirE" then
        --self.EChargeDmg = EChargeDMG1 + EChargeDMG2
        --self.EChargeDMG3 = EChargeDMG3
        --if self.EChargeDmg < EChargeDMG1 then self.EChargeDmg = EChargeDMG1 end
        --if self.EChargeDmg > EChargeDMG3 then self.EChargeDmg = EChargeDMG3 end
        --if Engine:IsKeyDown("HK_SPELL3") == true and Engine:SpellReady("HK_SPELL1") == false then
           -- if self.EChargeDmg > (self.EChargeDMG3 - 10) then
                --Engine:ReleaseSpell("HK_SPELL1")
                --self.ECast = false
            --end
        --end
    --else
        --self.EChargeDmg = EChargeDMG1
        --self.ECast = false
    --end
    --if Engine:IsKeyDown("HK_SPELL3") == true and Engine:SpellReady("HK_SPELL1") == false then
        --if self.EChargeDmg > (self.EChargeDMG3 - 10) then
            --Engine:ReleaseSpell("HK_SPELL1")
            --self.ECast = false
        --end
    --end
--end

function Vladimir:SingleTargetR()
    local target = Orbwalker:GetTarget("Combo", 625)
    if self.SingleR.Value == 1 and self.ForceR.Value == 1 then
        if Engine:GetForceTarget(target) then
            if target ~= nil then
                if self:NoRCheck(target) then return end
                if Engine:SpellReady("HK_SPELL4") and Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") and self.ComboR.Value == 1 then
                    if self:RCheck(target) then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                        return
                    end
                end
            end
        end
    end
    if self.SingleR.Value == 1 and self.ForceR.Value == 0 then
        if target ~= nil then
            if self:NoRCheck(target) then return end
            if Engine:SpellReady("HK_SPELL4") and Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") and self.ComboR.Value == 1 then
                if self:RCheck(target) then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end
end

--function Vladimir:LowHpR()
--    local target = Orbwalker:GetTarget("Combo", 625)
--    if target ~= nil then
--        if myHero.Health >= myHero.MaxHealth / 100 * 30 then return end
--        if Engine:SpellReady("HK_SPELL2") and Engine:SpellReady("HK_SPELL4") then
--            Engine:CastSpell("HK_SPELL4", target.Position, 1)
--        end
--    end
--end


function Vladimir:SmartTowerDive()
    if self.SmartTowerDiveW.Value == 1 and self.ComboW.Value == 1 then
        if Engine:SpellReady("HK_SPELL1") or Engine:SpellReady("HK_SPELL3") then return end
        if myHero.Health >= myHero.MaxHealth / 100 * self.WHealth.Value then return end
        local target = Orbwalker:GetTarget("Combo", 800)
        if target ~= nil then
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(Missiles) do
                if Missile.Team ~= myHero.Team and GetDist(myHero.Position, Missile.Position) <= 620 then 
                    if self.TowerShots[Missile.Name] then
                        if Engine:SpellReady("HK_SPELL2") then
                            Engine:CastSpell("HK_SPELL2", nil ,1)
                        end
                    end
                end
            end
        end
    end
end

function Vladimir:DodgeW()
    if Evade == nil then
        print('Evade not loaded, please enable to not get errors!')
    end
    if Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") and self.QandEcd.Value == 1  then return end
    local target = Orbwalker:GetTarget("Combo", 800)
    local LowHP = myHero.MaxHealth / 100 * self.WHealth.Value
    if target ~= nil then
        if self.UseWDodgeOnSpells.Value == 1 and self.ComboW.Value == 1 then
            if myHero.Health >= LowHP then return end
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(Missiles) do
                if Missile.Team ~= myHero.Team then 
                    local Info = Evade.Spells[Missile.Name]
                    if Info ~= nil and Info.Type == 0 then
                        if self:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius) then
                            if Engine:SpellReady("HK_SPELL2") then
                                Engine:CastSpell("HK_SPELL2", nil ,1)
                            end
                        end
                    end
                end
            end
        else
            if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
                if self.UseWHealth.Value == 1 then
                    if myHero.Health <= LowHP then
                        Engine:CastSpell("HK_SPELL2", nil ,1)
                    end
                end
                if self.UseWEnemies.Value == 1 then
                    local XAllies = AlliesInRange(myHero.Position, 700) - EnemiesInRange(myHero.Position, 700)
                    if XAllies >= self.WEnemies.Value then return end
                    if myHero.Health <= LowHP then
                        Engine:CastSpell("HK_SPELL2", nil ,1)
                    end
                end
            end     
        end
    end
end
        
function Vladimir:Combo()
    if Engine:SpellReady("HK_SPELL4") and  self.ComboR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 625)
        if target ~= nil then
            local XEnemies = EnemiesInRange(target.Position, 315)
            if  XEnemies >= self.REnemies.Value then
                Engine:CastSpell("HK_SPELL4", target.Position ,1)
                return
            end
        end
    end


    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", 600)
        if target ~= nil then
            if self.ForceR.Value == 1 then
                if self:RCheck(target) and Engine:SpellReady("HK_SPELL4") and self:NoRCheck(target) == false and Engine:GetForceTarget(target) then return end
                Engine:CastSpell("HK_SPELL1", target.Position ,1)
                return
            end
            if self.ForceR.Value == 0 then
                if self:RCheck(target) and Engine:SpellReady("HK_SPELL4") and self:NoRCheck(target) == false then return end
                Engine:CastSpell("HK_SPELL1", target.Position ,1)
                return
            end
        end
    end
    
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if Engine:SpellReady("HK_SPELL1") then return end
        local target = Orbwalker:GetTarget("Combo", 550)
        if target ~= nil then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 0)
            if PredPos ~= nil then
                if ChargedEdmg() == true then --GetDist(myHero.Position, target.Position) >= 580
                    Engine:ReleaseSpell("HK_SPELL3", PredPos)
                end
                Engine:ChargeSpell("HK_SPELL3")
            end
        end
    end 
end

function Vladimir:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", 600)
        if target ~= nil then
            if self.QaaReset.Value == 1 then
                if GetDist(myHero.Position, target.Position) < (getAttackRange() - 10) then
                    Engine:CastSpell("HK_SPELL1", target.Position ,1)
                    return
                end
            else
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
        end
    end
    
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if Engine:SpellReady("HK_SPELL1") then return end
        local target = Orbwalker:GetTarget("Combo", 450)
        if target ~= nil then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 0)
            if PredPos ~= nil then
                if ChargedEdmg() == true then --GetDist(myHero.Position, target.Position) >= 580
                    Engine:CastSpell("HK_SPELL3", PredPos,1)
                end
                Engine:ChargeSpell("HK_SPELL3")
            end
        end
    end  
end

function Vladimir:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Laneclear", 600)
        if target == nil then return end 
        if not ValidTarget(target) then return end
        Engine:CastSpell("HK_SPELL1", target.Position ,1)
        return
    end
    
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Laneclear", 500)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if ChargedEdmg() == true then--GetDist(myHero.Position, target.Position) >= 580
            Engine:CastSpell("HK_SPELL3", target.Position,1)
        end
        Engine:ChargeSpell("HK_SPELL3")
    end 
end

--function Vladimir:Lasthit()
--    local target = Orbwalker:GetTarget("Lasthit", 600)
--    if target == nil then return end
--    if not ValidTarget(target) then return end
--    if self:Qhit(target) then
--        if GetDist(myHero.Position, target.Position) < 590 then
--            if self.QFarmA.Value == 1 and Engine:SpellReady("HK_SPELL1") then
--                Engine:CastSpell("HK_SPELL1", target.Position ,1)
--                return
--            end
--        end
        --if GetDist(myHero.Position, target.Position) < 450 then
            --if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
              --  if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                  --  Engine:CastSpell("HK_SPELL1", target.Position ,1)
                   -- return
               -- end
            --end
        --end
--    end  
--end

function Vladimir:OnTick()
    --Vladimir:CastingE()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        --Vladimir:Lasthit()
        if Engine:IsKeyDown("HK_COMBO") then
            Vladimir:IgniteKS()
            Vladimir:Combo()
            Vladimir:SingleTargetR()
            --Vladimir:LowHpR()
            Vladimir:SmartTowerDive()
            Vladimir:DodgeW()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Vladimir:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Vladimir:Laneclear()
            return
        end
    end
end

function Vladimir:DrawFullCombo(Target)

    local CurrentCombo = " "

    if self:FastComboI(Target) then
        CurrentCombo = "EQ"
    elseif  self:FastComboII(Target) then
        CurrentCombo = "EQ>E"
    elseif self:NoRCheck(Target) then
        CurrentCombo = "EQ>E>Q>2XAA"
    elseif self:RCheck(Target) then
        CurrentCombo = "RCombo"
    else
        CurrentCombo = "RCombo+I"
    end

	local KillCombo = "Kill: " .. CurrentCombo
	
	local vecOut = Vector3.new()
    if Render:World2Screen(Target.Position, vecOut) then
		Render:DrawString(KillCombo, vecOut.x - 70 , vecOut.y - 175 , 92, 255, 5, 255)
	end
end

function Vladimir:OnDraw()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
			if self.DrawKillable.Value == 1 then
				if Hero.IsTargetable then
					self:DrawFullCombo(Hero)
				end
			end
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 600, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 350, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, 550, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 625, 255, 0, 255, 255)
    end
    --if self:PredCheckPos() == true and self.PredCheck.Value == 1 then
      --  Render:DrawCircle(self:PredCheckPos(), 100, 255, 0, 255, 255)
    --end
end

function Vladimir:OnLoad()
    if(myHero.ChampionName ~= "Vladimir") then return end
    AddEvent("OnSettingsSave" , function() Vladimir:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Vladimir:LoadSettings() end)

	Vladimir:__init()
	AddEvent("OnTick", function() Vladimir:OnTick() end)
    AddEvent("OnDraw", function() Vladimir:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Vladimir:OnLoad() end)