Graves = {}
function Graves:__init()	
	self.QRange = 900
	self.WRange = 950
	self.ERange = 450
	self.RRange = 1100

	self.QSpeed = 2000
	self.WSpeed = 1500
	self.ESpeed = math.huge
	self.RSpeed = 2100

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 0.25

	self.E_Timer = 0
	
    self.ChampionMenu = Menu:CreateMenu("Graves")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW 		= self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE 		= self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR 		= self.ComboMenu:AddCheckbox("UseR", 1)
	-------------------------------------------
    self.HarassMenu 	= self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ 	= self.HarassMenu:AddCheckbox("UseQ", 1)
	self.HarassUseW		= self.HarassMenu:AddCheckbox("UseW", 1)
	-------------------------------------------
    self.LaneclearMenu 	= self.ChampionMenu:AddSubMenu("Laneclear")
    self.LaneclearUseQ 	= self.LaneclearMenu:AddCheckbox("UseQ", 1)
    self.LaneclearUseW 	= self.LaneclearMenu:AddCheckbox("UseW", 1)
    self.LaneclearUseE 	= self.LaneclearMenu:AddCheckbox("UseE", 1)


	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Graves:LoadSettings()
end

function Graves:SaveSettings()
	SettingsManager:CreateSettings("Graves")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQ", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.HarassUseW.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Laneclear")
	SettingsManager:AddSettingsInt("UseQ", self.LaneclearUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.LaneclearUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.LaneclearUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Graves:LoadSettings()
	SettingsManager:GetSettingsFile("Graves")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
	self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQ")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseW")
	-------------------------------------------------------------
	self.LaneclearUseQ.Value = SettingsManager:GetSettingsInt("Laneclear","UseQ")
	self.LaneclearUseW.Value = SettingsManager:GetSettingsInt("Laneclear","UseW")
	self.LaneclearUseE.Value = SettingsManager:GetSettingsInt("Laneclear","UseE")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Graves:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Graves:WallcheckForQ(Position)
	local PlayerPos = myHero.Position
	local ToTargetVec = Vector3.new(Position.x - PlayerPos.x, Position.y - PlayerPos.y, Position.z - PlayerPos.z)

	local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
	local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
	
	for Range = 25 , Distance, 25 do
		local CurrentPos = Vector3.new(PlayerPos.x + (VectorNorm.x*Range), PlayerPos.y + (VectorNorm.y*Range), PlayerPos.z + (VectorNorm.z*Range))
		if Engine:IsNotWall(CurrentPos) == false then
			return false
		end
	end
	
	return true	
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(target) / 18)
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

function Graves:RDmg(Target)
	local RDamageFlat = 100 + (150 * myHero:GetSpellSlot(3).Level) + (myHero.BonusAttack * 1.5)
	local TotalRDMG = GetDamage(RDamageFlat, true, Target)
	if Target.Health < Target.MaxHealth / 100 * 38 then
		TotalRDMG = TotalRDMG * 1.08
	end
	if myHero.ArmorPenFlat >= 40 then
		local Collector = Target.MaxHealth * 0.05
		TotalRDMG = TotalRDMG + Collector
	end
	return TotalRDMG
end

function Graves:ECastPos()
	local PlayerPos 	= GameHud.MousePos
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -375
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Graves:EnemyVSAlly(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.IsTargetable then
            if Hero.Team ~= myHero.Team then
                if self:GetDistance(Hero.Position , Position) < Range then
                    Count = Count + 1
                end
            else
                if self:GetDistance(Hero.Position , Position) < Range then
                    Count = Count - 1
                end
            end
        end
    end
    return Count
end

function Graves:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Graves:EReset()
	if self.E_Timer > 0 then
		if self.E_Timer > 3 or string.find(myHero.ActiveSpell.Info.Name, "Attack") ~= nil or string.find(myHero.ActiveSpell.Info.Name, "attack") ~= nil then
			self.E_Timer = 0
		end
		return true
	else
		return false
	end
end

function Graves:AAReset()
	--print(myHero.ActiveSpell.Name)
	local Action 			= myHero.ActiveSpell.Info.Name
	local AutoAction 		= Action == "GravesBasicAttack" or Action == "GravesAutoAttackRecoil"
	local OrbwalkerReset 	= ((os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 0.0001 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 20) or Orbwalker.ResetReady == 1
	--local NoAmmo 			= myHero.Ammo == 0
	--local Dashing			= myHero.AIData.Dashing
	if AutoAction or OrbwalkerReset then--or NoAmmo then--or Dashing then
		return true
	end
	return false
end

function Graves:EnemiesInRange2(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
            --Render:DrawCircle(Hero.Position, self.QWidth/2 + Hero.CharData.BoundingRadius,0,255,255,255)
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Graves:IsAutoAttackMissile(Name, Target)
    if string.find(Name, "Attack", 1) ~= nil then
        return 1
    end

    local Missiles = {}
    Missiles["Caitlyn"] 		= {"caitlynheadshotmissile"}
    Missiles["Ashe"] 			= {"frostarrow"}
    Missiles["Kennen"] 		    = {"kennenmegaproc"}
    Missiles["Quinn"] 			= {"quinnwenhanced"}
    Missiles["Vayne"] 			= {"vaynecondemn"}
    Missiles["Jhin"] 			= {"jhine"}

    local PossibleAutos = Missiles[Target.ChampionName]
    if PossibleAutos then
        for i = 1, #PossibleAutos do
            if Name:lower() == PossibleAutos[i] then
                return 1.3
            end
        end
    end
    return nil
end

function Graves:IncomingAttack() 
    local Heros     = ObjectManager.HeroList
    local Turrets   = ObjectManager.TurretList
    local Missiles  = ObjectManager.MissileList
    for _, Hero in pairs(Heros) do
        if myHero.Index == Hero.Index then --myHero.Index!
            local Enemies = self:EnemiesInRange2(Hero.Position, 1200)
            if #Enemies > 0 then
                for _, Enemy in pairs(Enemies) do
                    local IsDashing         = Enemy.AIData.Dashing
                    local DashPosition      = Enemy.AIData.TargetPos
                    if Orbwalker:GetDistance(Hero.Position, DashPosition) <= 300 and IsDashing == true then --Ally gets dashed
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local Lethality = Enemy.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Enemy.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Enemy.AbilityPower
                        local realMR    = (Hero.MagicResist - Enemy.MagicPenFlat) * Enemy.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * 1.3) or ((myHero.Health - Health40) < (APDamage * MRMod) * 1.3) then
                            return true
                        end
                    end

                    if Orbwalker:GetDistance(Hero.Position, Enemy.Position) <= 300 and string.len(Enemy.ActiveSpell.Info.Name) > 0 then --Ally in Melee Range
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local Lethality = Enemy.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Enemy.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Enemy.AbilityPower
                        local realMR    = (Hero.MagicResist - Enemy.MagicPenFlat) * Enemy.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Mplier    = 1
                        if Enemy.ActiveSpell.IsAutoAttack then
                            if string.find(Enemy.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(Enemy.ActiveSpell.Info.Name, "crit") ~= nil then
                                Mplier = Mplier + 0.75
                                if Enemy.CritChance >= 0.6 then
                                    Mplier = Mplier + 0.35
                                end
                            end
                        else
                            if string.find(Enemy.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(Enemy.ActiveSpell.Info.Name, "crit") ~= nil then
                                Mplier = Mplier + 1.25
                            else
                                Mplier = Mplier + 0.25
                            end
                        end
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return true
                        end
                    end
                end
            end
        end
    end

    for _, Missile in pairs(Missiles) do
        local Source = Heros[Missile.SourceIndex] or Turrets[Missile.SourceIndex]
        local Target = Heros[Missile.TargetIndex]
        if Source and Target and Source.Team ~= myHero.Team and Target.Index == myHero.Index then --myHero.Index!
            local ADDamage  = Source.BaseAttack + Source.BonusAttack
            local Lethality = Source.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Target) / 18)
            local realArmor = Target.Armor * Source.ArmorPenMod
            local FinalArmor = (realArmor - Lethality)
            if FinalArmor <= 0 then
                FinalArmor = 0
            end
            local ArmorMod  = 100 / (100 + FinalArmor)
            local APDamage  = Source.AbilityPower
            local realMR    = (Target.MagicResist - Source.MagicPenFlat) * Source.MagicPenMod
            local MRMod     = 100 / (100 + realMR)
            local Mplier    = 1
            local EnemyAutoAttack = self:IsAutoAttackMissile(Missile.Name, Source.ChampionName)
            if EnemyAutoAttack ~= nil then
                if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                    Mplier = Mplier + 0.75
                    if Source.CritChance >= 0.6 then
                        Mplier = Mplier + 0.35
                    end
                end
            else
                if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                    Mplier = Mplier + 1.25
                else
                    Mplier = Mplier + 0.25
                end
            end
            local Health40 = myHero.MaxHealth * 0.4
            if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                return true
            end
        end
        if Source and Source.Team ~= myHero.Team then 
            for _, Hero in pairs(Heros) do
                if myHero.Index == Hero.Index then  --myHero.Index!
                    local StartPos  = Missile.MissileStartPos
                    local EndPos    = Missile.MissileEndPos
                    if Prediction:PointOnLineSegment(StartPos, EndPos, Hero.Position, Missile.MissileInfo.Data.MissileWidth + Hero.CharData.BoundingRadius + 300) then
                        local ADDamage  = Source.BaseAttack + Source.BonusAttack
                        local Lethality = Source.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Source.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Source.AbilityPower
                        local realMR    = (Hero.MagicResist - Source.MagicPenFlat) * Source.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Mplier    = 1

                        if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                            Mplier = Mplier + 1.25
                        else
                            Mplier = Mplier + 0.25
                        end
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function Graves:UseR()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local Enemies = self:EnemiesInRange2(myHero.Position, 2000)
		if #Enemies > 0 then
			for _, Enemy in pairs(Enemies) do
				local MyPos 			= myHero.Position
				local PredPos 			= Prediction:GetPredictionPosition(Enemy, MyPos, self.RSpeed, self.RDelay, 200, 0, 1, 0.001, 1)
				local HealthGeneration 	= 10 + ((10 + 1 * GetHeroLevel(Enemy)) / 5)
				local EnemyHP 			= Enemy.Health + HealthGeneration
				local RDmg 				= Graves:RDmg(Enemy)
				if PredPos then
					local Dist				= self:GetDistance(MyPos, PredPos)
					if Dist < (self.RRange - 5) then
						if EnemyHP < RDmg then
							if self:GetDistance(MyPos, Enemy.Position) < Orbwalker.OrbRange + self.ERange * 0.75 then
								local IncomingAttack 	= Graves:IncomingAttack()
								local LowHP				= myHero.Health <= myHero.MaxHealth / 100 * 40
								if LowHP or IncomingAttack == true then
									return Engine:CastSpell("HK_SPELL4", PredPos, 0)
								end
							else
								return Engine:CastSpell("HK_SPELL4", PredPos, 0)
							end
						else
							local QReady = Engine:SpellReady("HK_SPELL1")
							local WReady = Engine:SpellReady("HK_SPELL2")

							local RawQDmg = 80 + (50 * myHero:GetSpellSlot(0).Level) + (0.9 + (0.3 * myHero:GetSpellSlot(0).Level)) * myHero.BonusAttack
							local QDmg = GetDamage(RawQDmg, true, Enemy)
							if QReady then
								RDmg = RDmg + QDmg
							end

							local RawWDmg = 10 + (50 * myHero:GetSpellSlot(0).Level)
							local WDmg = GetDamage(RawWDmg, false, Enemy)
							if WReady then
								RDmg = RDmg + WDmg
							end

							if EnemyHP < RDmg then
								if WReady then
									local WPredPos = Prediction:GetPredictionPosition(Enemy, MyPos, self.WSpeed, self.WDelay, 200, 0, 1, 0.001, 1)
									if WPredPos then
										if self:GetDistance(MyPos, WPredPos) < self.WRange then
											return Engine:CastSpell("HK_SPELL2", WPredPos, 0)
										end
									end
								end
								if QReady then
									local QPredPos = Prediction:GetPredictionPosition(Enemy, MyPos, self.QSpeed, self.QDelay, 200, 0, 1, 0.001, 1)
									if QPredPos then
										if self:GetDistance(MyPos, QPredPos) < self.QRange then
											return Engine:CastSpell("HK_SPELL1", QPredPos, 0)
										end
									end
								end
							end
						end
					else
						if EnemyHP < (RDmg * 0.8) then
							if Dist < 2000 then
								if Engine:SpellReady("HK_SPELL3") then
									return Engine:ReleaseSpell("HK_SPELL3", PredPos)
								end
							end
							if Dist < 1650 then
								return Engine:CastSpell("HK_SPELL4", PredPos, 0)
							end 
						end
					end
				end
			end
		end
	end
end

function Graves:Combo()
	local Range			= myHero.AttackRange + myHero.CharData.BoundingRadius
	local Grit 			= myHero.BuffData:GetBuff("gravesegrit")
	local AAReset 		= Graves:AAReset() == true
	local NoAmmo 		= myHero.Ammo == 0

	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local MyPos = myHero.Position
		local PredPos, Target = Prediction:GetCastPos(MyPos, self.WRange, self.WSpeed, 200, self.WDelay, 0, 1, 0.001, 0)
		if PredPos ~= nil and Target ~= nil then
			if self:GetDistance(MyPos, PredPos) < self.WRange then
				if Grit.Count_Alt >= 4 and GameClock.Time + 1.5 >= Grit.EndTime then
					return Engine:CastSpell("HK_SPELL2", PredPos, 0)
				end
				if myHero.Ammo == 0 then
					return Engine:CastSpell("HK_SPELL2", PredPos, 0)
				else
					local PredPos2 = Prediction:GetCastPos(MyPos, self.WRange, self.WSpeed, 200, self.WDelay, 0, 1, 0.9, 0)
					if PredPos2 then
						return Engine:CastSpell("HK_SPELL2", PredPos2, 0)
					end
				end
			end
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local MyPos = myHero.Position
		local PredPos, Target = Prediction:GetCastPos(MyPos, self.QRange, self.QSpeed, 80, self.QDelay, 0, 1, 0.001, 1)
		if PredPos ~= nil and Target ~= nil then
			if self:GetDistance(MyPos, PredPos) < self.QRange then
				if self:WallcheckForQ(PredPos) then
					if Grit.Count_Alt >= 4 and GameClock.Time + 1 >= Grit.EndTime then
						return Engine:CastSpell("HK_SPELL1", PredPos, 0)
					end
					if AAReset or NoAmmo then
						return Engine:CastSpell("HK_SPELL1", PredPos, 0)
					end
				end
			end
		end
	end

	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 365)
        if Target then
            --[[local HeroList = ObjectManager.HeroList
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                    if self:GetDistance(Hero.Position, self:ECastPos()) < Hero.AttackRange + Hero.CharData.BoundingRadius + 50 then
                        if Hero.AttackRange < 300 then
							--print("OK")
                            return nil
                        end
                    end
                end
            end]]
            if self:EnemyVSAlly(self:ECastPos(), Orbwalker.OrbRange) > 1 then
				--print("OK")
                return nil
            end
            if self:GetDistance(Target.Position, self:ECastPos()) > Orbwalker.OrbRange then
                if ((myHero.Health / myHero.MaxHealth) * 2) > (Target.Health / Target.MaxHealth) then
					--print("OK")
                    return nil
                end
                if Target.Health <= Target.MaxHealth / 100 * 15 then
					--print("OK")
                    return nil
                end
            end
            if self:GetDistance(Target.Position, myHero.Position) > (Orbwalker.OrbRange + 75) and myHero.Ammo < 2 then
                if self:EnemiesInRange(self:ECastPos(), 1000) >= 3 then
					--print("OK")
                    return nil
                end
                --if Engine:IsNotWall(self:ECastPos()) == false then
                    --return nil
                --end
                if self:GetDistance(Target.Position, self:ECastPos()) <= Orbwalker.OrbRange then
					if self.E_Timer == 0 then
						self.E_Timer = GameClock.Time
					end
					return Engine:ReleaseSpell("HK_SPELL3", nil)
                end
            end
            --print("OKAY")
            if AAReset or NoAmmo then
				if self.E_Timer == 0 then
					self.E_Timer = GameClock.Time
				end
                return Engine:ReleaseSpell("HK_SPELL3", nil)	
            end
		end
	end
end

function Graves:Harass()
	if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", self.QRange + myHero.CharData.BoundingRadius)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position, 0)
			return
		end
	end
	if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local Target = Orbwalker:GetTarget("Combo", self.WRange + myHero.CharData.BoundingRadius)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL2", Target.Position, 0)
			return
		end
	end
end

function Graves:MinionsInRange2(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do
        if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.MaxHealth > 100 then
            if Orbwalker:GetDistance(Minion.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Graves:MinionsInQ(Position)
	local Count = 0
	local Minions = ObjectManager.MinionList
	for I,Minion in pairs(Minions) do
		if Minion.IsTargetable == true and Minion.Team ~= myHero.Team  and Minion.MaxHealth > 100 then			
			local PlayerPos = myHero.Position
			local TargetPos = Position
			if self:GetDistance(PlayerPos, TargetPos) <= self.QRange then
				local i 			= self.QRange
				local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
				local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
				local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
				local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))

				local PredPos = Prediction:GetPredictionPosition(Minion, myHero.Position, 2100, 0.25, 200, 0, 1, 0.0001, 1)

				if PredPos and Orbwalker:GetDistance(PredPos, myHero.Position) < self.QRange and Prediction:PointOnLineSegment(PlayerPos, EndPos, PredPos, 75) == true then
					Count = Count + 1
				end
			end
		end
	end
	return Count
end

function Graves:GetQLaneClearTarget()
	local Minions = ObjectManager.MinionList
	for I,Minion in pairs(Minions) do
		if Minion.IsTargetable == true and Minion.Team ~= myHero.Team then			
			local PlayerPos = myHero.Position
			local TargetPos = Minion.Position
			if self:GetDistance(PlayerPos, TargetPos) <= Orbwalker.OrbRange then
				local MinionsInRange = Graves:MinionsInRange2(Minion.Position, self.QRange * 1.3) - 1
				if MinionsInRange > 6 then
					MinionsInRange = 5
				end
				if Graves:MinionsInQ(Minion.Position) >= MinionsInRange then
					return Minion
				end
			end
		end
	end
	return nil
end

function Graves:Laneclear()
	local Grit 			= myHero.BuffData:GetBuff("gravesegrit")
	local AAReset = Graves:AAReset() == true
	local Range = myHero.AttackRange + myHero.CharData.BoundingRadius
	if self.LaneclearUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Laneclear", Range * 2)
		if Target then
			if AAReset then
				if self.E_Timer == 0 then
					self.E_Timer = GameClock.Time
				end
				return Engine:ReleaseSpell("HK_SPELL3", nil)
			end
		end
	end
	if self.LaneclearUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local Target = Orbwalker:GetTarget("Laneclear", self.WRange)
		if Target and Target.Team == 300 and Target.Shield == 0 and Target.MaxHealth > 200 then
			local Time = (Orbwalker:GetDistance(Target.Position, myHero.Position) / 1400) + 0.3
			if Grit.Count_Alt >= 2 and GameClock.Time + Time >= Grit.EndTime then
				return Engine:CastSpell("HK_SPELL2", Target.Position ,1)
			end
		end
	end
	if self.LaneclearUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = self:GetQLaneClearTarget()
		if Target then
			if self:GetDistance(myHero.Position, Target.Position) < self.QRange then
				if AAReset then
					return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
				end
			end
		end
	end
end

function Graves:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		--print(myHero.BuffData:ShowAllBuffs()) --gravesegrit
		--[[local Grit = myHero.BuffData:GetBuff("gravesegrit") --dravenpassivestacks
		if Grit.Count_Alt > 0 then
			print(Grit.Count_Alt, Grit.EndTime)
		end]]
		--print(GravesPassive.Count_Alt)

		Graves:UseR()
		if Engine:IsKeyDown("HK_COMBO") then
			Graves:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Graves:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Graves:Laneclear()
			return
		end
	end
end

function Graves:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,220,20,60,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,140,0,255)
		Render:DrawCircle(myHero.Position, 1690 ,255,140,0,255)
    end
end



function Graves:OnLoad()
    if(myHero.ChampionName ~= "Graves") then return end
	AddEvent("OnSettingsSave" , function() Graves:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Graves:LoadSettings() end)


	Graves:__init()
	AddEvent("OnTick", function() Graves:OnTick() end)	
	AddEvent("OnDraw", function() Graves:OnDraw() end)	
end

AddEvent("OnLoad", function() Graves:OnLoad() end)	
