-- Credits to: jet, Derang3d and Critic
Viego = {}
function Viego:__init()	
	self.QRange = 600
    self.WCast  = false
	self.WRange = 300
    self.WMaxRange = 900
	self.ERange = 750
	self.RRange = 500

	self.QSpeed = math.huge
	self.WSpeed = 1300
	self.ESpeed = math.huge
	self.RSpeed = math.huge

    self.QWidth = 125
    self.WWidth = 120
    self.RWidth = 300

	self.QDelay = (1 / 0.658 * myHero.AttackSpeedMod * 0.16477) * 1.4
	self.WDelay = 0
	self.EDelay = 0 
	self.RDelay = 0.5

    self.WWidth = 120

    self.QHitChance = 0.2
    self.WHitChance = 0.2
    self.RHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Viego")
	-------------------------------------------
    self.ComboMenu       = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ       = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboUseW       = self.ComboMenu:AddCheckbox("Use W in Combo", 1)
    self.ComboUseE       = self.ComboMenu:AddCheckbox("Use E in Combo", 1)
    self.ComboUseR       = self.ComboMenu:AddCheckbox("Use R in Combo", 1)
    self.SliderUseR      = self.ComboMenu:AddSlider("Minimum enemies to Ult", 3,1,5,1)
    ---------------------------------------------
    self.HarassMenu      = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ      = self.HarassMenu:AddCheckbox("Use Q in Harass", 1)
    ---------------------------------------------
    self.KsMenu          = self.ChampionMenu:AddSubMenu("Killsteal")
    self.KsUseQ          = self.KsMenu:AddCheckbox("Killsteal with Q", 1)
    self.KsUseR          = self.KsMenu:AddCheckbox("Killsteal with R", 1)
    ---------------------------------------------
    self.LcMenu          = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearUseQ       = self.LcMenu:AddCheckbox("Use Q in Clear", 1)
    self.ClearUseW       = self.LcMenu:AddCheckbox("Use W in Clear", 0)
    self.ClearUseE      = self.LcMenu:AddCheckbox("Use E in Clear", 0)
    --------------------------------------------------
    --------------------------------------------------
    self.LhMenu          = self.ChampionMenu:AddSubMenu("Lasthit")
    self.LhUseQ          = self.LhMenu:AddCheckbox("Use Q to Lasthit", 1)
    ---------------------------------------------
	self.DrawMenu        = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ           = self.DrawMenu:AddCheckbox("Draw Viego Q Range", 1)
    self.DrawW           = self.DrawMenu:AddCheckbox("Draw Viego W Range", 1)
    self.DrawE           = self.DrawMenu:AddCheckbox("Draw Viego E Range", 1)
    self.DrawR           = self.DrawMenu:AddCheckbox("Draw Viego R Range", 1)
    
    
	
	self:LoadSettings()
end

function Viego:SaveSettings()
	SettingsManager:CreateSettings("Viego")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("Use E in Combo", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboUseR.Value)
    SettingsManager:AddSettingsInt("Minimum enemies to Ult", self.SliderUseR.Value)
	------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassUseQ.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Killsteal")
    SettingsManager:AddSettingsInt("Killsteal with Q", self.KsUseQ.Value)
    SettingsManager:AddSettingsInt("Killsteal with R", self.KsUseR.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("Use Q in Clear", self.ClearUseQ.Value)
    SettingsManager:AddSettingsInt("Use W in Clear", self.ClearUseW.Value)
    SettingsManager:AddSettingsInt("Use E in Clear", self.ClearUseE.Value)
    ------------------------------------------------------------
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Lasthit")
    SettingsManager:AddSettingsInt("Use Q to Lasthit", self.LhUseQ.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Draw Viego Q Range", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Draw Viego W Range", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw Viego E Range", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw Viego R Range", self.DrawR.Value)
end

function Viego:LoadSettings()
	SettingsManager:GetSettingsFile("Viego")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    self.SliderUseR.Value= SettingsManager:GetSettingsInt("Combo", "Minimum enemies to Ult")
	-------------------------------------------------------------
    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    -------------------------------------------------------------
    self.ClearUseQ.Value = SettingsManager:GetSettingsInt("Clear","Use Q in Clear")
    self.ClearUseW.Value = SettingsManager:GetSettingsInt("Clear","Use W in Clear")
    self.ClearUseE.Value = SettingsManager:GetSettingsInt("Clear","Use E in Clear")
    -------------------------------------------------------------
    self.LhUseQ.Value = SettingsManager:GetSettingsInt("Lasthit","Use Q to Lasthit")
    -------------------------------------------------------------
    self.KsUseQ.Value    = SettingsManager:GetSettingsInt("Killsteal","Killsteal with Q")
    self.KsUseR.Value    = SettingsManager:GetSettingsInt("Killsteal","Killsteal with R")
    -------------------------------------------------------------
	self.DrawQ.Value     = SettingsManager:GetSettingsInt("Drawings","Draw Viego Q Range")
	self.DrawE.Value     = SettingsManager:GetSettingsInt("Drawings","Draw Viego W Range")
    self.DrawE.Value     = SettingsManager:GetSettingsInt("Drawings","Draw Viego E Range")
    self.DrawE.Value     = SettingsManager:GetSettingsInt("Drawings","Draw Viego R Range")
end

local function GetDist(source, target)
    return math.sqrt(((target.x - source.x) ^ 2) + ((target.z - source.z) ^ 2))
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

-- function Viego:Damage(Target) will finish implementing later

   -- local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
   -- local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    --local QLevel = myHero:GetSpellSlot(0).Level
    --local QDamage
    --local Qbonus
    --local QQdmg
   -- if QLevel ~= 0 then
      --  QDamage = {25, 40, 55, 70, 85}
      --  Qbonus = (TotalAD * 0.6)
       -- QQdmg = (25 * QLevel) + (0.1 + ((0.05 + (0.05 * QLevel)) * (TotalAD / 100) * Target.MaxHealth))
       -- totalqdmg = QQdmg + QQQdmg
   -- end

    --local WLevel = myHero:GetSpellSlot(1).Level
    --local WDamage
    --local WWdmg
    --if WLevel ~= 0 then
     --   WDamage = {80, 100, 120, 140, 160}
     --   Wbonus = (TotalAD * 0.60) + (.10 * (myHero.BonusAttack / 100) * (.25 / (myHero.Mana - myHero.MaxMana)))
     --   WWdmg = WDamage[WLevel] 
   -- end

    --local ELevel = myHero:GetSpellSlot(2).Level
    --local EDamage
   -- local Ebonus
    --local EEdmg
    --if ELevel ~= 0 then
       -- EDamage = {50, 70, 90, 110, 130}
       -- Ebonus = (TotalAD * 0.60)
       -- EEdmg = EDamage[ELevel]
   -- end

    --local RLevel = myHero:GetSpellSlot(3).Level
    --local RDamage
    --local Rbonus
    --local RRdmg
    --if RLevel ~= 0 then
      --  RDamage = {200, 300, 400}
       -- Rbonus = (myHero.BonusAttack * 1)
       -- RRdmg = RDamage[RLevel] + Rbonus
    --end
    --local FinalFullDmg = 0

    --if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
     --   FinalFullDmg = FinalFullDmg + totalqdmg
    --end
    --if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
    --    FinalFullDmg = FinalFullDmg + (WWdmg + Wbonus)
    --end
    --if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
    --    FinalFullDmg = FinalFullDmg + (EEdmg + Ebonus)
    --end
   -- if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
     --   FinalFullDmg = (FinalFullDmg + RRdmg) 
    ---end

   -- return FinalFullDmg
--end


function Viego:WallCheck(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local left, right, top, down = PlayerPos,PlayerPos,PlayerPos,PlayerPos
    for i = 25, 700 , 25 do
        left.x = left.x - i
        if Engine:IsNotWall(left) == false then
            if GetDist(left, TargetPos) <= 700 then
                return left
            end
		end
    end
    for i = 25, 700 , 25 do
        right.x = right.x + i
        if Engine:IsNotWall(right) == false then
            if GetDist(right, TargetPos) <= 700 then
                return right
            end
		end
    end
    for i = 25, 700 , 25 do
        top.z = top.z + i
        if Engine:IsNotWall(top) == false then
            if GetDist(top, TargetPos) <= 700 then
                return top
            end
		end
    end
    for i = 25, 700 , 25 do
        down.z = down.z - i
        if Engine:IsNotWall(down) == false then
            if GetDist(down, TargetPos) <= 700 then
                return down
            end
		end
	end
    return nil
end

function Viego:CastingW()
    local WStartTime = myHero:GetSpellSlot(1).StartTime
    local WChargeTime = GameClock.Time - WStartTime
    local WCharge = myHero.ActiveSpell.Info.Name
    if WCharge == "ViegoW" then
        self.WRange = 300 + (600*WChargeTime)
        if self.WRange <= 300 then self.WRange = 300 end
        if self.WRange >= 900 then self.WRange = 900 end
    else
        self.WRange = 300
        self.WCast = false
    end
    if Engine:IsKeyDown("HK_SPELL2") == true and Engine:SpellReady("HK_SPELL2") == false then
        self.WCast = false
        return Engine:ReleaseSpell("HK_SPELL2", nil)
        
    end
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan <- amigo estou aqui
    local HeroList = ObjectManager.HeroList
    for i,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Viego:HealthCheck(Hero)

    if  Engine:SpellReady("HK_SPELL3") then
			if EnemiesInRange(myHero.Position, 500) == 5 and myHero.Health <= myHero.MaxHealth / 100 * 70 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 4 and myHero.Health <= myHero.MaxHealth / 100 * 60 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 3 and myHero.Health <= myHero.MaxHealth / 100 * 50 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 2 and myHero.Health <= myHero.MaxHealth / 100 * 40 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 1 and myHero.Health <= myHero.MaxHealth / 100 * 35 then
				return true
			end
	end
	return false
end

function Viego:TargetIsImmune(Target)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "WillRevive", "SionPassiveZombie", "rebirthready", "willrevive", "ZileanR"
    }
    for i = 1, #ImmuneBuffs do
        local Buffname = ImmuneBuffs[i]
        local Buff = Target.BuffData:GetBuff(Buffname)
		if Buff.Count_Alt > 0 then
			return true
		end
    end
	return false
end

function Viego:GetLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Viego:TargetIsLH()
    local Count = 0
    local Heros = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
    for _, Heros in pairs(Heros) do
        if Heros.Team ~= myHero.Team and Heros.IsTargetable then
            if GetDist(myHero.Position, Heros.Position) <= self.RRange then
                Count = Count + 1
            end
        end
    end
    return Count
end


function CheckStun()
    local target = Orbwalker:GetTarget("Combo", 1700)
    if target ~= nil then
        TargetStun   = target.BuffData:HasBuffOfType(BuffType.Stun)
        TargetTaunt  = target.BuffData:HasBuffOfType(BuffType.Taunt)
        TargetAsleep = target.BuffData:HasBuffOfType(BuffType.Asleep)
        TargetCharm  = target.BuffData:HasBuffOfType(BuffType.Charm)
        TargetFear   = target.BuffData:HasBuffOfType(BuffType.Fear)
        TargetPoly   = target.BuffData:HasBuffOfType(BuffType.Polymorph)
        TargetSupres = target.BuffData:HasBuffOfType(BuffType.Suppression)
        TargetSnare  = target.BuffData:HasBuffOfType(BuffType.Snare)
        TargetSpellS = target.BuffData:HasBuffOfType(BuffType.SpellShield)
        TargetImmune = target.BuffData:HasBuffOfType(BuffType.Immunity)
    end
    if target ~= nil then
        if TargetSpellS  == false and TargetImmune == false then
            if TargetStun == true or TargetTaunt == true or TargetAsleep == true or TargetCharm == true 
            or TargetFear == true or TargetPoly == true or TargetSupres == true
            or TargetSnare == true then
                TargetIsStunned = true
        else
                TargetIsStunned = false
            end
        end
    end
end

function Viego:CastQ()
    local ViegoQ = myHero:GetSpellSlot(0).Info.Name == "ViegoQ"
    if Engine:SpellReady("HK_SPELL1") and ViegoQ  then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            local StartPos 	= myHero.Position
            local CastPos 	= Prediction:GetCastPos(StartPos, self.QRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if CastPos ~= nil then
                if GetDist(StartPos, CastPos) < self.QRange then
                    Engine:CastSpell("HK_SPELL1", CastPos)
                end
            end
        end
    end
end
          
function Viego:LasthitQ() 
    local ViegoQ = myHero:GetSpellSlot(0).Info.Name == "ViegoQ"
    if Engine:SpellReady("HK_SPELL1") and ViegoQ then
        local target = Orbwalker:GetTarget("Lasthit", self.QRange)
        local totalMultiplierDmg = myHero.CritMod / 4 * 3
        local QLevel             = myHero:GetSpellSlot(0).Level
        local QDamage            = 0
        local PhysDmg            = ((myHero.BaseAttack + myHero.BonusAttack / 10) * 6)
        if target and target.IsDead == false then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", target.Position)
            end
        end
    end
end

function Viego:ClearQ() 
    local ViegoQ = myHero:GetSpellSlot(0).Info.Name == "ViegoQ"
    if Engine:SpellReady("HK_SPELL1") and ViegoQ then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL1", target.Position)
        end
    end
end

function Viego:ClearW() 
    local ViegoW = myHero:GetSpellSlot(1).Info.Name == "ViegoW"
    if Engine:SpellReady("HK_SPELL2") and ViegoW then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL2", target.Position)
        end
    end
end

function Viego:ClearE() 
    local ViegoE = myHero:GetSpellSlot(2).Info.Name == "ViegoE"
    if Engine:SpellReady("HK_SPELL3") and ViegoE then 
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL3", target.Position)
        end
    end
end




function Viego:CastW()
    local ViegoW = myHero:GetSpellSlot(1).Info.Name == "ViegoW"
    if Engine:SpellReady("HK_SPELL2") and ViegoW then
        local target = Orbwalker:GetTarget("Combo", self.WMaxRange)
        if target ~= nil then
            local StartPos 	= myHero.Position
            local CastPos 	= Prediction:GetCastPos(StartPos, self.WMaxRange , self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
            if CastPos ~= nil and TargetIsStunned == false then
                    if GetDist(StartPos, CastPos) < self.WRange then
                        Engine:ReleaseSpell("HK_SPELL2", CastPos)
                        return
                    end
                if self.WCast == false then
                        Engine:ChargeSpell("HK_SPELL2")
                        self.WCast = true
                        return
                end
            end
        end
    end
end   
  

function Viego:CastE()
    local ViegoE = myHero:GetSpellSlot(2).Info.Name == "ViegoE"
    if Engine:SpellReady("HK_SPELL3") and ViegoE then 
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then 
            local wall = self:WallCheck(target)
            if wall ~= nil and self.HealthCheck(Hero) then
                Engine:CastSpell("HK_SPELL3", wall, 0)
            end
            if TargetIsStunned == true and target.MaxHealth - target.Health > target.MaxHealth / 10 then
                Engine:CastSpell("HK_SPELL3", target.Position, 0)
            end
        end
    end
end
function Viego:QKs()
    local ViegoQ = myHero:GetSpellSlot(0).Info.Name == "ViegoQ"
    if ViegoQ then
        local HeroList = ObjectManager.HeroList
        local totalMultiplierQ = myHero.CritMod / 4 * 3
        local Calculate = 25 + ((myHero.BaseAttack + myHero.BonusAttack) / 100 * 60)
        local TotalQDmg = Calculate + (Calculate * totalMultiplierQ)
        for i, target in pairs(HeroList) do
            if GetDist(myHero.Position, target.Position) < self.QRange then
                if target.Team ~= myHero.Team and target.IsDead == false and TotalQDmg >= target.Health then
                    local StartPos 	= myHero.Position
                    local CastPos 	= Prediction:GetCastPos(StartPos, self.QRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                    if CastPos then
                        if GetDist(StartPos, CastPos) < self.QRange and Engine:SpellReady("HK_SPELL1") then
                            Engine:CastSpell("HK_SPELL1", CastPos, 1)
                        end
                    end
                end
            end
        end
    end
end

                    
function Viego:UltimateKS()

    if self.KsUseR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
            local StartPos 	= myHero.Position
            local CastPos 	= Prediction:GetCastPos(StartPos, self.RRange , self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 0)
                if CastPos ~= nil then
                    if GetDist(myHero.Position, target.Position) <= 650 then

                    local TotalMultiplierUlt = myHero.CritMod / 4 * 3
                    local TotalDamageUlt     = ((myHero.BaseAttack + myHero.BonusAttack) / 10) * 12
                    local UltLevel           = myHero:GetSpellSlot(3).Level
                    local PassiveBuff        = myHero.BonusAttack / 100 * 3
                    local MissingHealth      = math.abs(target.MaxHealth * - 1 + target.Health)
                    local ViegoDmg           = 1   

                        if UltLevel == 1 then
                        local ViegoDmg = TotalDamageUlt + (TotalDamageUlt * TotalMultiplierUlt) + (MissingHealth / 100 * (15 + PassiveBuff))
                            if ViegoDmg >= target.Health and self:TargetIsImmune(target) == false then
                            Engine:CastSpell('HK_SPELL4', CastPos, 1)
                            end
                        end
                        if UltLevel == 2 then
                        local ViegoDmg = TotalDamageUlt + (TotalDamageUlt * TotalMultiplierUlt) + (MissingHealth / 100 * (20 + PassiveBuff))
                            if ViegoDmg >= target.Health and self:TargetIsImmune(target) == false then
                            Engine:CastSpell('HK_SPELL4', CastPos, 1)
                            end
                        end
                        if UltLevel == 3 then
                        local ViegoDmg = TotalDamageUlt + (TotalDamageUlt * TotalMultiplierUlt) + (MissingHealth / 100 * (25 + PassiveBuff))
                            if ViegoDmg >= target.Health and self:TargetIsImmune(target) == false then
                            Engine:CastSpell('HK_SPELL4', CastPos, 1)  
                            end
                        end
                    end
                end
            end
        end
    end
end


function Viego:UltimateTF()
    if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
    local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 500 then
                if EnemiesInRange(target.Position, 300) >= self.SliderUseR.Value then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end
end
  

function Viego:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self.QDelay = (1 / 0.658 * myHero.AttackSpeedMod * 0.16477) * 1.4
            CheckStun()
            Viego:CastingW()
            Viego:HealthCheck()

            if self.KsUseQ.Value == 1 then
                Viego:QKs()
            end
            if self.KsUseR.Value == 1 then
            Viego:UltimateKS()
            end
            
		    if Engine:IsKeyDown("HK_COMBO") then
                if self.ComboUseW.Value == 1 then
			    Viego:CastW()
                end
                if self.ComboUseQ.Value == 1 then
                Viego:CastQ()
                Viego:TargetIsLH()
			    end
                if self.ComboUseE.Value == 1 then
                Viego:CastE()
                end
                if self.ComboUseR.Value == 1 then
                Viego:UltimateTF()
                end
            end
            if Engine:IsKeyDown("HK_HARASS") then
                if self.HarassUseQ.Value == 1 then
                Viego:CastQ()
                end
            end
            if Engine:IsKeyDown("HK_LANECLEAR") then
               if self.ClearUseQ.Value == 1 then
                Viego:ClearQ()
               end
               if self.ClearUseW.Value == 1 then
                Viego:ClearW()
               end
               if self.ClearUseE.Value == 1 then
                Viego:ClearE()
               end
            end
            if Engine:IsKeyDown("HK_LASTHIT") then
                if self.LhUseQ.Value == 1 then
                Viego:LasthitQ()
                end
            end

        
    end
end

      

function Viego:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if  Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,0,255,0,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,125,125,125  ,125)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,0,255,255,155)
    end
end

function Viego:OnLoad() 
    if(myHero.ChampionName ~= "Viego") then return end
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

	Viego:__init()
	AddEvent("OnTick", function() self:OnTick() end)
	AddEvent("OnDraw", function() self:OnDraw() end)
end

AddEvent("OnLoad", function() Viego:OnLoad() end)	    