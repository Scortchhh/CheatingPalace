-- 1.21
Lucian = {}
function Lucian:__init()	
	self.QRange = 500
	self.WRange = 850
	self.ERange = 450
	self.RRange = 1140

	self.QSpeed = 2000
	self.WSpeed = 2000
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.WWidth = 110
	self.RWidth = 220

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 0

	self.RTarget    = nil
	
    self.ChampionMenu = Menu:CreateMenu("Lucian")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW 		= self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE 		= self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR 		= self.ComboMenu:AddCheckbox("UseR", 1)
	-------------------------------------------
    self.HarassMenu 	= self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ 	= self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseLongQ = self.HarassMenu:AddCheckbox("UseLongQ", 1)


	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	Lucian:LoadSettings()
end

function Lucian:SaveSettings()
	SettingsManager:CreateSettings("Lucian")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("ComboUseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQ", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseLongQ", self.HarassUseLongQ.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawW.Value)
end

function Lucian:LoadSettings()
	SettingsManager:GetSettingsFile("Lucian")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","ComboUseR")
	-------------------------------------------------------------
	self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQ")
	self.HarassUseLongQ.Value = SettingsManager:GetSettingsInt("Harass","UseLongQ")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Lucian:FindR()
    local Missiles = ObjectManager.MissileList
    for _, Object in pairs(Missiles) do
		--if Orbwalker:GetDistance(Object.Position, myHero.Position) > 1500 then return nil end
		--print(Object.Name)
        if Object.Team == myHero.Team and _ == Object.Index and string.find(Object.Name, "LucianR", 1) ~= nil then
			--print(Object.Name)
			--print(GameClock.Time)
			--Render:DrawCircle(Object.MissileEndPos, 50 ,0,255,255,255)
            return Object
        end
    end
    return nil
end

function Lucian:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Lucian:GetAttackRange(target)
    local attRange = target.AttackRange + target.CharData.BoundingRadius + 20
    return attRange
end

function Lucian:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function myDot(a, b)
    return (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
end

function Lucian:CheckCollision(startPos, endPos, r, Pos)
	if Pos and startPos and endPos and r then
		if Orbwalker:GetDistance(myHero.Position, Pos) <= 1625 then
			local distanceP1_P2 = Orbwalker:GetDistance(startPos, endPos) -5
			local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
			local unitPos = Pos
			local distanceP1_Unit = Orbwalker:GetDistance(startPos, unitPos)
			if distanceP1_Unit <= distanceP1_P2 then --and Orbwalker:GetDistance(endPos, unitPos) > 300 then
				--Render:DrawCircle(endPos, 50 ,0,255,255,255)
				local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
				--Render:DrawCircle(checkPos, 50 ,0,255,255,255)
				if Orbwalker:GetDistance(unitPos, checkPos) < r + myHero.CharData.BoundingRadius then
					return true, checkPos
				else
					return false, checkPos
				end
			else
				local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
				if Orbwalker:GetDistance(unitPos, checkPos) < r + myHero.CharData.BoundingRadius then
					return false, checkPos
				else
					return false, checkPos
				end
			end
		end
	end
    return nil
end

function Lucian:FixedEnemyPos(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local Range 		= (Target.CharData.BoundingRadius + Target.AttackRange + 25) * 1.45
	if Range < Orbwalker.OrbRange then
		Range = Orbwalker.OrbRange * 1.45
	end
	local i 			= -1 * Range
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Lucian:FixedEnemyPos2(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 250
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Lucian:FixedEnemyPos3(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -250
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Lucian:FixedEPos(Pos, Target)
	if Pos and Target then
		local Dist2Pos 		= Orbwalker:GetDistance(Pos, myHero.Position)
		local Dist2Target 	= Orbwalker:GetDistance(Pos, Target.Position)

		if Dist2Pos <= 0 then
			Dist2Pos = 1
		end
		if Dist2Pos >= 499 then
			Dist2Pos = 499
		end

		local Diff 			= 500 - Dist2Pos

		local Norm = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Target.Position, Pos))
		local X = Pos.x + (Norm.x * Diff)
		local Y = Pos.y + (Norm.y * Diff)
		local Z = Pos.z + (Norm.z * Diff)  
		local EPos = Vector3.new(X,Y,Z)
		return EPos
	end
end

function Lucian:EnemiesInRange2(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if Orbwalker:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Lucian:MinionsInRange2(Position, Range)
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

function Lucian:EnemyHasRange(Position)
	local HeroList = ObjectManager.HeroList
	local Count = 0 --FeelsBadMan
	for i, Hero in pairs(HeroList) do
		if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
			if Hero.AttackRange < 300 and self:GetDistance(Hero.Position, Position) < (Hero.AttackRange + Hero.CharData.BoundingRadius + 50) + Hero.MovementSpeed * 0.35 then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Lucian:GetEPos()	
	local Enemies = self:EnemiesInRange(myHero.Position, 1000)
	if #Enemies > 0 then
		for _, Enemy in pairs(Enemies) do
			local PredPos = Prediction:GetPredictionPosition(Enemy, myHero.Position, math.huge, 0.25, 200, 0, 1, 0.0001, 1)
			if PredPos then
				local x, y, z, r = PredPos.x, PredPos.y, PredPos.z, Orbwalker.OrbRange
				for i = 1, 18 do
					local angle = i * math.pi / 180 * 10 * 2
					local ptx, pty, ptz = x + r * math.cos( angle ), y + r * math.sin( angle ), z + r * math.sin( angle )
					local EPos = Vector3.new(ptx,y,ptz)
					local MousePos = GameHud.MousePos
					local Dist1 = Orbwalker:GetDistance(myHero.Position, EPos)
					local Dist2 = Orbwalker:GetDistance(MousePos, EPos)
					--Render:DrawCircle(EPos, 50 ,0,255,255,255)
					if Dist1 > 200 and Dist1 < 550 and Engine:IsNotWall(EPos) and Dist2 < 900 then
						if self:EnemiesInRange2(EPos, 600) < 3 and Lucian:EnemyHasRange(EPos) == 0  then
							return EPos
						end
					end
				end
			end
		end
	end
end

function Lucian:MagneticR()
	local RBuff = myHero.BuffData:GetBuff("lucianr")
	if RBuff.Count_Alt > 0 and self.RTarget and self.RTarget.IsDead == false and self.RTarget.IsVisible and Orbwalker:EnemiesInRange(myHero.Position, 800) <= 2 then
		local PredPos = Prediction:GetPredictionPosition(self.RTarget, myHero.Position, math.huge, 0.25, 200, 0, 1, 0.0001, 1)
		if PredPos then
			local Modifier 		= Orbwalker:GetDistance(self.RTarget.Position, PredPos) 
			local myPos 		= myHero.Position
			local mySpeed 		= myHero.MovementSpeed * 0.25
			local TargetSpeed 	= self.RTarget.MovementSpeed * 0.25
			local SpeedDif 		= TargetSpeed - mySpeed
			Modifier = Modifier + SpeedDif
			local MagneticPos 	= Vector3.new(myPos .x + (self.RTarget.Direction.x*Modifier), myPos.y, myPos.z + (self.RTarget.Direction.z * Modifier))
			local REndPos		= nil
			if Lucian:FindR() then
				REndPos = Lucian:FindR().MissileEndPos
			end
			local Hitting, CheckPos = Lucian:CheckCollision(myHero.Position, REndPos, 110, PredPos)
			if Hitting == true then
				--print("HitsTarget")
				if MagneticPos and Engine:IsNotWall(MagneticPos) then
					local Start3 = Vector3.new()
                    local End3 = Vector3.new()

					Render:World2Screen(MagneticPos, Start3)
				    Render:World2Screen(PredPos, End3)
                    
					if Start3 and End3 then
						Render:DrawCircle(MagneticPos, 50 ,0,255,255,255)
                    	Render:DrawLine(Start3, End3, 0,255,255,255)
					end

					Orbwalker.MovePosition = MagneticPos
					Evade.IsMovePosisitionSetByExternal = true
					return
				else
					local FixedMagneticPos = Lucian:FixedEnemyPos(self.RTarget)
					if FixedMagneticPos and Engine:IsNotWall(FixedMagneticPos) then
						Orbwalker.MovePosition = FixedMagneticPos
						Evade.IsMovePosisitionSetByExternal = true
						return
					else
						local FixedMagneticPos2 = Lucian:FixedEnemyPos2(self.RTarget)
						if FixedMagneticPos2 and Engine:IsNotWall(FixedMagneticPos2) then
							Orbwalker.MovePosition = FixedMagneticPos2
							Evade.IsMovePosisitionSetByExternal = true
							return
						else
							local FixedMagneticPos3 = Lucian:FixedEnemyPos3(self.RTarget)
							if FixedMagneticPos3 and Engine:IsNotWall(FixedMagneticPos3) then
								Orbwalker.MovePosition = FixedMagneticPos3
								Evade.IsMovePosisitionSetByExternal = true
								return
							end
						end
					end
				end
			else
				if CheckPos then
					--print("ForcePos")
					local TargetPos = self.RTarget.Position
					local Dist1 	= Orbwalker:GetDistance(CheckPos, myPos)
					local Dist2 	= Orbwalker:GetDistance(CheckPos, PredPos)
					local Dist3		= Orbwalker:GetDistance(myPos, TargetPos)
					--local Angle		= Prediction:CheckAngle(CastPos, CurrentPos, StartPos)
					local APos 		= CheckPos	
					local BPos 		= PredPos
					local DPos 		= myPos

					--[[local VectorA2D = Prediciton:GetVectorDirection(DPos, APos)
					local VectorA2B = Prediciton:GetVectorDirection(BPos, APos)
					local BVecSquare2 = VectorA2D.x ^ 2 + VectorA2D.y ^ 2 + VectorA2D.z ^ 2
					local DVecSquare2 = VectorA2B.x ^ 2 + VectorA2B.y ^ 2 + VectorA2B.z ^ 2

					local MagnitudeOfB2 = math.sqrt(BVecSquare2)
					local MagnitudeOfD2 = math.sqrt(DVecSquare2)

					local AtoC2 = MagnitudeOfB2 + MagnitudeOfD2]]

					local Norm = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(BPos, APos))
                    local X = DPos.x + (Norm.x * Dist2)
                    local Y = DPos.y + (Norm.y * Dist2)
                    local Z = DPos.z + (Norm.z * Dist2)  
					local ForceMagneticPos = Vector3.new(X,Y,Z)

					local Start = Vector3.new()
                    local End = Vector3.new()
					Render:World2Screen(ForceMagneticPos, Start)
				    Render:World2Screen(CheckPos, End)

					if Start and End then
						Render:DrawCircle(CheckPos, 50 ,0,255,255,255)
                    	Render:DrawLine(Start, End, 0,255,255,255)
					end

					local End2 = Vector3.new()
				    Render:World2Screen(self.RTarget.Position, End2)
                    
					local KappaEPos = Lucian:FixedEPos(ForceMagneticPos, self.RTarget)

					if Start and End2 then
						Render:DrawCircle(KappaEPos, 50 ,255,0,0,255)
                   		Render:DrawLine(Start, End2, 255,0,0,255)
					end

					if ForceMagneticPos and Engine:IsNotWall(ForceMagneticPos) then
						if Dist2 > 275 or Dist3 > 1150 and Engine:SpellReady("HK_SPELL3") then
							local EPos = Lucian:FixedEPos(ForceMagneticPos, self.RTarget)
							if EPos and Engine:IsNotWall(EPos) then
								Engine:CastSpell("HK_SPELL3", EPos, 0)
								return
							end
						end
						Orbwalker.MovePosition = ForceMagneticPos
						Evade.IsMovePosisitionSetByExternal = true
						return
					end
				end
			end
		end
	end
end

function Lucian:AutoR()
	if Engine:SpellReady("HK_SPELL4") then
		local RBuff = myHero.BuffData:GetBuff("lucianr")
		local Enemies = self:EnemiesInRange(myHero.Position, self.RRange)
		if #Enemies > 0 then
			for _, Enemy in pairs(Enemies) do
				if Enemy and RBuff.Count_Alt == 0 then
					if self:GetDistance(myHero.Position, Enemy.Position) > self:GetAttackRange(myHero) then
						local amountOfShots = 22 + (myHero.CritChance / 4)
						local rDmg = (0 + (15 * myHero:GetSpellSlot(3).Level) + ((myHero.BaseAttack + myHero.BonusAttack) * 0.25) + (myHero.AbilityPower * 0.15)) * amountOfShots
						rDmg = self:GetDamage(rDmg, true, Enemy) * 1.25
						if Enemy.Health <= rDmg then
							local CastPos = Prediction:GetPredictionPosition(Enemy, myHero.Position, self.RSpeed, self.RDelay, self.RWidth, 1, 1, 0.2, 1)
							if CastPos then
								if Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, CastPos) < 1010 then
									return Engine:CastSpell("HK_SPELL2", CastPos, 1)
								end
								if Orbwalker:GetDistance(myHero.Position, CastPos) < self.RRange then
									self.RTarget = Enemy
									return Engine:CastSpell("HK_SPELL4", CastPos, 1)
								end
							end
						end
					end
				end
			end
		end
	end
end

function Lucian:Combo()
	if self.ComboUseR.Value == 1 then
		self:AutoR()
	end
	local AttackName 	= myHero.ActiveSpell.Info.Name
	local Range 		= Orbwalker.OrbRange
	local RBuff 		= myHero.BuffData:GetBuff("lucianr")
	local Passive 		= myHero.BuffData:GetBuff("lucianpassivebuff")
	local ECooldown 	= self.ComboUseE.Value == 0 or (myHero:GetSpellSlot(2).Cooldown - GameClock.Time > 1.5 or myHero:GetSpellSlot(2).Level == 0)

	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1 then
		local Target = Orbwalker:GetTarget("Combo", Range)
		if Target ~= nil and Passive.Count_Alt == 0 and RBuff.Valid == false then
			local EPos = Lucian:GetEPos()
			if EPos then
				Engine:CastSpell("HK_SPELL3", EPos ,0)
				return
			end
		end
	end
	if self.ComboUseQ.Value == 1 and ECooldown and myHero.AIData.Dashing == false and Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
		if Target ~= nil and Passive.Count_Alt == 0 and RBuff.Valid == false then
			Engine:CastSpell("HK_SPELL1", Target.Position ,1)
			return
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target2 = self:GetQHarassTarget()
		if Target2 ~= nil then
			Engine:CastSpell("HK_SPELL1", Target2.Position ,0)
			return
		end
	end
	if self.ComboUseW.Value == 1 and ECooldown and myHero.AIData.Dashing == false and Engine:SpellReady("HK_SPELL2") then
		local Target = Orbwalker:GetTarget("Combo", Range)
		if Target ~= nil and Passive.Count_Alt == 0 and RBuff.Valid == false then
			local CastPos = Prediction:GetPredictionPosition(Target, myHero.Position, self.RSpeed, self.RDelay, self.RWidth, 1, 1, 0.001, 1)
			if CastPos and Orbwalker:GetDistance(CastPos, myHero.Position) <= 1010 then
				Engine:CastSpell("HK_SPELL2", CastPos ,0)
				return
			end
		end
	end
end

function Lucian:EnemiesInRange(Position, Range)
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

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Lucian:GetQHarassTarget()
	local Enemies = self:EnemiesInRange(myHero.Position, 1000)
	if #Enemies > 0 then
		for _, Enemy in pairs(Enemies) do
			local Minions = ObjectManager.MinionList
			for I,Minion in pairs(Minions) do
				if Minion.IsTargetable == true and Minion.Team ~= myHero.Team then			
					local PlayerPos = myHero.Position
					local TargetPos = Minion.Position
					if self:GetDistance(PlayerPos, TargetPos) <= Orbwalker.OrbRange then

						local i 			= 1000
						local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
						local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
						local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
						local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))
						local CastTime 		= 0.4 - 0.15 / 17 * (GetHeroLevel(myHero) - 1)
						if CastTime < 0.2 or CastTime > 0.4 then
							CastTime = 0.4
						end
						local PredPos = Prediction:GetPredictionPosition(Enemy, myHero.Position, math.huge, CastTime, 200, 0, 1, 0.0001, 1)

						if PredPos and Orbwalker:GetDistance(PredPos, myHero.Position) < 990 and Prediction:PointOnLineSegment(PlayerPos, EndPos, PredPos, 20) == true then
							return Minion
						end
					end
				end
			end
		end
	end
	return nil
end

function Lucian:MinionsInQ(Position)
	local Count = 0
	local Minions = ObjectManager.MinionList
	for I,Minion in pairs(Minions) do
		if Minion.IsTargetable == true and Minion.Team ~= myHero.Team  and Minion.MaxHealth > 100 then			
			local PlayerPos = myHero.Position
			local TargetPos = Position
			if self:GetDistance(PlayerPos, TargetPos) <= 1100 then
				local i 			= 1000
				local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
				local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
				local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
				local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))
				local CastTime 		= 0.4 - 0.15 / 17 * (GetHeroLevel(myHero) - 1)
				if CastTime < 0.2 or CastTime > 0.4 then
					CastTime = 0.4
				end
				local PredPos = Prediction:GetPredictionPosition(Minion, myHero.Position, math.huge, CastTime, 200, 0, 1, 0.0001, 1)

				if PredPos and Orbwalker:GetDistance(PredPos, myHero.Position) < 990 and Prediction:PointOnLineSegment(PlayerPos, EndPos, PredPos, 45) == true then
					Count = Count + 1
				end
			end
		end
	end
	return Count
end

function Lucian:GetQLaneClearTarget()
	local Minions = ObjectManager.MinionList
	for I,Minion in pairs(Minions) do
		if Minion.IsTargetable == true and Minion.Team ~= myHero.Team then			
			local PlayerPos = myHero.Position
			local TargetPos = Minion.Position
			if self:GetDistance(PlayerPos, TargetPos) <= Orbwalker.OrbRange then
				local MinionsInRange = Lucian:MinionsInRange2(Minion.Position, 1000)
				if MinionsInRange > 3 then
					MinionsInRange = MinionsInRange - 1
				end
				if MinionsInRange > 6 then
					MinionsInRange = 5
				end
				if Lucian:MinionsInQ(Minion.Position) >= MinionsInRange and MinionsInRange >= 3 then
					return Minion
				end
				if GetHeroLevel(myHero) == 1 and Lucian:MinionsInQ(Minion.Position) > 3 then
					return Minion
				end
			end
		end
	end
	return nil
end

function Lucian:Harass()
	if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position ,1)
			return
		end
	end
	if self.HarassUseLongQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = self:GetQHarassTarget()
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position ,0)
			return
		end
	end
end

function Lucian:LaneClear()
	if self.HarassUseLongQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = self:GetQHarassTarget() or Lucian:GetQLaneClearTarget()
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position ,0)
			return
		end
	end
end


function Lucian:OnTick()
	Orbwalker.MovePosition = nil
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Lucian:FindR() then
			--Render:DrawCircle(Lucian:FindR().Position, 50 ,0,255,255,255)
		end
		if Engine:IsKeyDown("HK_COMBO") then
			Lucian:MagneticR()
			Lucian:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Lucian:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Lucian:LaneClear()
			return
		end
	end
end

function Lucian:OnDraw()
	if Orbwalker.MovePosition ~= nil then
		Render:DrawCircle(Orbwalker.MovePosition, 55 ,100,150,255,255)
	end
	Lucian:GetEPos()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		local QRange = self.QRange + myHero.CharData.BoundingRadius
		local ARange = myHero.AttackRange + myHero.CharData.BoundingRadius
		if ARange > QRange then
			Render:DrawCircle(myHero.Position, QRange ,100,150,255,255)
		end
		Render:DrawCircle(myHero.Position, 1000 ,255,140,0,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
end



function Lucian:OnLoad()
    if(myHero.ChampionName ~= "Lucian") then return end
	AddEvent("OnSettingsSave" , function() Lucian:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Lucian:LoadSettings() end)


	Lucian:__init()
	AddEvent("OnTick", function() Lucian:OnTick() end)	
	AddEvent("OnDraw", function() Lucian:OnDraw() end)	
end

AddEvent("OnLoad", function() Lucian:OnLoad() end)	
