Gnar = {}
function Gnar:__init()	
	self.QRange = 1125
    self.Q2Range = 1150
	self.W2Range = 550
	self.ERange = 475
	self.E2Range = 675
    self.RRange = 625

	self.QSpeed = 2500
    self.Q2Speed = 2100
	self.W2Speed = math.huge
	self.ESpeed = math.huge
	self.E2Speed = math.huge
	self.RSpeed = 2500

	self.QWidth = 110
	self.Q2Width = 180
	self.W2Width = 200

	self.QDelay = 0.25 
	self.Q2Delay = 0.5
	self.W2Delay = 0.6
	self.EDelay = 0.25
	self.E2Delay = 0.25
	self.RDelay = 0.25

	self.QHitChance1 = 0.4
	self.QHitChance2 = 0.35
	self.WHitChance = 0.35

    self.ChampionMenu = Menu:CreateMenu("Gnar")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseQ2 = self.ComboMenu:AddCheckbox("UseQ2", 1)
    self.ComboUseW2 = self.ComboMenu:AddCheckbox("UseW2", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	self.ComboUseE2 = self.ComboMenu:AddCheckbox("UseE2", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	self.EnemiesToStun = self.ComboMenu:AddSlider("Enemies to stun", 1, 1, 5, 1)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseQ2 = self.HarassMenu:AddCheckbox("UseQ2", 1)
    self.HarassUseW2 = self.HarassMenu:AddCheckbox("UseW2", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE", 1)
	self.HarassUseE2 = self.HarassMenu:AddCheckbox("UseE2", 1)
	
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawQ2 = self.DrawMenu:AddCheckbox("DrawQ2", 1)
    self.DrawW2 = self.DrawMenu:AddCheckbox("DrawW2", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
	self.DrawE2 = self.DrawMenu:AddCheckbox("DrawE2", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Gnar:LoadSettings()
end

function Gnar:SaveSettings()
	SettingsManager:CreateSettings("Gnar")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseQ2", self.ComboUseQ2.Value)
    SettingsManager:AddSettingsInt("UseW2", self.ComboUseW2.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseE2", self.ComboUseE2.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("Enemies to stun", self.EnemiesToStun.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawQ2", self.DrawQ2.Value)
	SettingsManager:AddSettingsInt("DrawW2", self.DrawW2.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawE2", self.DrawE2.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Gnar:LoadSettings()
	SettingsManager:GetSettingsFile("Gnar")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseQ2.Value = SettingsManager:GetSettingsInt("Combo","UseQ2")
	self.ComboUseW2.Value = SettingsManager:GetSettingsInt("Combo","UseW2")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseE2.Value = SettingsManager:GetSettingsInt("Combo","UseE2")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.EnemiesToStun.Value = SettingsManager:GetSettingsInt("Combo","Enemies to stun")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawQ2.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ2")
	self.DrawW2.Value = SettingsManager:GetSettingsInt("Drawings","DrawW2")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawE2.Value = SettingsManager:GetSettingsInt("Drawings","DrawE2")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Gnar:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Gnar:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function Gnar:JumpSpot(Target, behind)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i = 150
	local EndPos = Vector3.new(TargetPos.x - (TargetNorm.x * i),TargetPos.y - (TargetNorm.y * i),TargetPos.z - (TargetNorm.z * i))
	return EndPos
end

function Gnar:StunCheck(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	for i = 25, self.RRange , 25 do
		local EndPos = Vector3.new(TargetPos.x - (TargetNorm.x * i),TargetPos.y - (TargetNorm.y * i),TargetPos.z - (TargetNorm.z * i))
		if Engine:IsNotWall(EndPos) == false then
			return true, EndPos
		end
	end
	return false, nil
end

function Gnar:EnemiesStunneable()
	local EnemyList = ObjectManager.HeroList
	local counter = 0
	local stunneable, wallPos = nil
	for i, Hero in pairs(EnemyList) do 
		if not Hero.IsDead and Hero.IsTargetable and Hero.Team ~= myHero.Team then
			if self:GetDistance(myHero.Position, Hero.Position) <= self.RRange then
				stunneable, wallPos = self:StunCheck(Hero)
				if stunneable then
					counter = counter + 1
				end
			end
		end
	end
	if wallPos ~= nil and stunneable ~= nil then
		return counter, wallPos
	end
end

local closestMinionToEnemy = nil

function Gnar:Combo()
	local target = Orbwalker:GetTarget("Combo", 1100)
	if target then
		if not myHero.BuffData:GetBuff("gnartransform").Valid then
			if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 and not myHero.BuffData:GetBuff("gnartransformsoon").Valid then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance1, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
			end
			if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 and myHero.BuffData:GetBuff("gnartransformsoon").Valid then
				local enemiesStunneable, wallPos = self:EnemiesStunneable()
				if enemiesStunneable ~= nil then
					if enemiesStunneable >= self.EnemiesToStun.Value then
						Engine:CastSpell("HK_SPELL4", wallPos, 1)
					end
				end
			end
			if myHero.BuffData:GetBuff("gnartransformsoon").Valid and Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 then
				if self:GetDistance(myHero.Position, target.Position) <= self.ERange + 200 then
					local jumpPos = self:JumpSpot(target, false)
					Engine:CastSpell("HK_SPELL3", jumpPos, 1)
				end
				if self:GetDistance(myHero.Position, target.Position) > self.ERange and self:GetDistance(myHero.Position, target.Position) <= (self.ERange * 2) then
					local MinionList = ObjectManager.MinionList
					for i, Minions in pairs(MinionList) do
						if self:GetDistance(myHero.Position, Minions.Position) <= self.ERange then
							if not Minions.IsDead and Minions.IsTargetable and Minions.MaxHealth > 8 then
								if closestMinionToEnemy == nil then
									closestMinionToEnemy = Minions
								end
								if self:GetDistance(Minions.Position, target.Position) < self:GetDistance(closestMinionToEnemy.Position, target.Position) then
									closestMinionToEnemy = Minions
								end
							end
						end
					end
					if closestMinionToEnemy ~= nil then
						Engine:CastSpell("HK_SPELL3", closestMinionToEnemy.Position, 1)
					end
				end
			end
		else
			if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
				local enemiesStunneable, wallPos = self:EnemiesStunneable()
				if enemiesStunneable ~= nil then
					if enemiesStunneable >= self.EnemiesToStun.Value then
						Engine:CastSpell("HK_SPELL4", wallPos, 1)
					end
				end
			end
			if Engine:SpellReady("HK_SPELL2") and self.ComboUseW2.Value == 1 then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.W2Range, self.W2Speed, self.W2Width, self.W2Delay, 0, true, self.WHitChance, 1)
				if PredPos ~= nil and self:GetDistance(myHero.Position, target.Position) <= self.W2Range then
					Engine:CastSpell("HK_SPELL2", PredPos, 1)
					return
				end
			end
			if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ2.Value == 1 then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, self.Q2Width, self.Q2Delay, 1, true, self.QHitChance2, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
			end
		end
	end
end

function Gnar:Harass()
	local target = Orbwalker:GetTarget("Harass", 1100)
	if target then
		if not myHero.BuffData:GetBuff("gnartransform").Valid then
			if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 and not myHero.BuffData:GetBuff("gnartransformsoon").Valid then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance1, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
			end
			if myHero.BuffData:GetBuff("gnartransformsoon").Valid and Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 then
				if self:GetDistance(myHero.Position, target.Position) <= self.ERange + 200 then
					local jumpPos = self:JumpSpot(target, false)
					Engine:CastSpell("HK_SPELL3", jumpPos, 1)
				end
				if self:GetDistance(myHero.Position, target.Position) > self.ERange and self:GetDistance(myHero.Position, target.Position) <= (self.ERange * 2) then
					local MinionList = ObjectManager.MinionList
					for i, Minions in pairs(MinionList) do
						if self:GetDistance(myHero.Position, Minions.Position) <= self.ERange then
							if not Minions.IsDead and Minions.IsTargetable and Minions.MaxHealth > 8 then
								if closestMinionToEnemy == nil then
									closestMinionToEnemy = Minions
								end
								if self:GetDistance(Minions.Position, target.Position) < self:GetDistance(closestMinionToEnemy.Position, target.Position) then
									closestMinionToEnemy = Minions
								end
							end
						end
					end
					if closestMinionToEnemy ~= nil then
						Engine:CastSpell("HK_SPELL3", closestMinionToEnemy.Position, 1)
					end
				end
			end
		else
			if Engine:SpellReady("HK_SPELL2") and self.HarassUseW2.Value == 1 then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.W2Range, self.W2Speed, self.W2Width, self.W2Delay, 0, true, self.WHitChance, 1)
				if PredPos ~= nil and self:GetDistance(myHero.Position, target.Position) <= self.W2Range then
					Engine:CastSpell("HK_SPELL2", PredPos, 1)
					return
				end
			end
			if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ2.Value == 1 then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, self.Q2Width, self.Q2Delay, 1, true, self.QHitChance2, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
			end
		end
	end
end

function Gnar:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			Gnar:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Gnar:Harass()
		end
	end
end

function Gnar:OnDraw()
	if myHero.ChampionName == "Gnar" then

		if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
			local enemiesStunneable, wallPos = self:EnemiesStunneable()
			if enemiesStunneable ~= nil then
				if enemiesStunneable >= 1 then
					Render:DrawCircle(wallPos, 150,100,150,255,255)
				end
			end
		end

		if not myHero.BuffData:GetBuff("gnartransform").Valid then
			if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
				Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
			end
			if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
				Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
			end
		else
			if Engine:SpellReady("HK_SPELL1") and self.DrawQ2.Value == 1 then
				Render:DrawCircle(myHero.Position, self.Q2Range ,100,150,255,255)
			end
			if Engine:SpellReady("HK_SPELL2") and self.DrawW2.Value == 1 then
				Render:DrawCircle(myHero.Position, self.W2Range ,100,150,255,255)
			end
			if Engine:SpellReady("HK_SPELL3") and self.DrawE2.Value == 1 then
				Render:DrawCircle(myHero.Position, self.E2Range ,100,150,255,255)
			end
			if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
				Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
			end
		end
	end
end



function Gnar:OnLoad()
    if(myHero.ChampionName ~= "Gnar") then return end
	AddEvent("OnSettingsSave" , function() Gnar:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Gnar:LoadSettings() end)


	Gnar:__init()
	AddEvent("OnTick", function() Gnar:OnTick() end)	
	AddEvent("OnDraw", function() Gnar:OnDraw() end)	
end

AddEvent("OnLoad", function() Gnar:OnLoad() end)	
