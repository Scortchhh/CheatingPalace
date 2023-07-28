Awareness = {}
function Awareness:__init()
    self.RecallDraws		= 0
    self.FlashDraws		= 0
	self.RecallTimes 		= {}

    self.AwarenessMenu 		= Menu:CreateMenu("Awareness")
	------------------------------------------------------------
	self.CooldownTracker 	= self.AwarenessMenu:AddSubMenu("CooldownTracker")	
    self.DrawEnemyCD 		= self.CooldownTracker:AddCheckbox("Enemy CD", 1)
    self.DrawFriendCD 		= self.CooldownTracker:AddCheckbox("Friendly CD", 1)
	------------------------------------------------------------
    self.RecallTracker 		= self.AwarenessMenu:AddSubMenu("RecallTracker")	
	self.DrawTestRecall 	= self.RecallTracker:AddCheckbox("TestRecalls", 0)
	self.RecallXAxis		= self.RecallTracker:AddSlider("X Axis", 100,100,1000,1)
	self.RecallYAxis		= self.RecallTracker:AddSlider("Y Axis", 100,100,1000,1)
	------------------------------------------------------------
    self.WardTracker 		= self.AwarenessMenu:AddSubMenu("WardTracker")	
    self.DrawEnemyWards		= self.WardTracker:AddCheckbox("Enemy Wards", 1)
	------------------------------------------------------------
    self.AdditionalAwareness= self.AwarenessMenu:AddSubMenu("Additional Awareness")
    self.FlashTrack         = self.AdditionalAwareness:AddCheckbox("(BETA) FlashTracker", 0)
	self.ESPLines           = self.AdditionalAwareness:AddCheckbox("ESP lines", 0)
	self.TowerSettings      = self.AwarenessMenu:AddSubMenu("Tower Settings")
	self.AllyOuterTowers         = self.TowerSettings:AddCheckbox("Draw Ally outer towers", 1)
	self.AllyMiddleTowers         = self.TowerSettings:AddCheckbox("Draw Ally middle towers", 1)
	self.AllyInnerTowers         = self.TowerSettings:AddCheckbox("Draw Ally inner towers", 1)
	self.AllyNexusTowers        = self.TowerSettings:AddCheckbox("Draw Ally nexus towers", 1)
	self.EnemyOuterTowers        = self.TowerSettings:AddCheckbox("Draw Enemy outer towers", 1)
	self.EnemyMiddleTowers        = self.TowerSettings:AddCheckbox("Draw Enemy middle towers", 1)
	self.EnemyInnerTowers        = self.TowerSettings:AddCheckbox("Draw Enemy inner towers", 1)
	self.EnemyNexusTowers        = self.TowerSettings:AddCheckbox("Draw Enemy nexus towers", 1)
	
	self:LoadSettings()
end

function Awareness:SaveSettings()
	SettingsManager:CreateSettings("Awareness")
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("CooldownTracker")
	SettingsManager:AddSettingsInt("EnemyCD", self.DrawEnemyCD.Value)
	SettingsManager:AddSettingsInt("FriendCD", self.DrawFriendCD.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("RecallTracker")
	SettingsManager:AddSettingsInt("XAxis", self.RecallXAxis.Value)
	SettingsManager:AddSettingsInt("YAxis", self.RecallYAxis.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("WardTracker")
	SettingsManager:AddSettingsInt("EnemyWards", self.DrawEnemyWards.Value)
	------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Additional Awareness")
    SettingsManager:AddSettingsInt("FlashTracker", self.FlashTrack.Value)
	SettingsManager:AddSettingsInt("ESP lines", self.ESPLines.Value)
	SettingsManager:AddSettingsInt("Draw Ally outer towers", self.AllyOuterTowers.Value)
	SettingsManager:AddSettingsInt("Draw Ally middle towers", self.AllyMiddleTowers.Value)
	SettingsManager:AddSettingsInt("Draw Ally inner towers", self.AllyInnerTowers.Value)
	SettingsManager:AddSettingsInt("Draw Ally nexus towers", self.AllyNexusTowers.Value)
	SettingsManager:AddSettingsInt("Draw Enemy outer towers", self.EnemyOuterTowers.Value)
	SettingsManager:AddSettingsInt("Draw Enemy middle towers", self.EnemyMiddleTowers.Value)
	SettingsManager:AddSettingsInt("Draw Enemy inner towers", self.EnemyInnerTowers.Value)
	SettingsManager:AddSettingsInt("Draw Enemy nexus towers", self.EnemyNexusTowers.Value)
end

function Awareness:LoadSettings()
	SettingsManager:GetSettingsFile("Awareness")
	-------------------------------------------------------------
	self.DrawEnemyCD.Value 		= SettingsManager:GetSettingsInt("CooldownTracker","EnemyCD")
	self.DrawFriendCD.Value 	= SettingsManager:GetSettingsInt("CooldownTracker","FriendCD")
	-------------------------------------------------------------
	self.RecallXAxis.Value 		= SettingsManager:GetSettingsInt("RecallTracker","XAxis")
	self.RecallYAxis.Value 		= SettingsManager:GetSettingsInt("RecallTracker","YAxis")
	-------------------------------------------------------------
	self.DrawEnemyWards.Value 	= SettingsManager:GetSettingsInt("WardTracker","EnemyWards")
    -------------------------------------------------------------
    self.FlashTrack.Value         = SettingsManager:GetSettingsInt("Additional Awareness", "FlashTracker")
	self.ESPLines.Value         = SettingsManager:GetSettingsInt("Additional Awareness", "ESP lines")
	self.AllyOuterTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Ally outer towers")
	self.AllyMiddleTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Ally middle towers")
	self.AllyInnerTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Ally inner towers")
	self.AllyNexusTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Ally nexus towers")
	self.EnemyOuterTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Enemy outer towers")
	self.EnemyMiddleTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Enemy middle towers")
	self.EnemyInnerTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Enemy inner towers")
	self.EnemyNexusTowers.Value  = SettingsManager:GetSettingsInt("Additional Awareness", "Draw Enemy nexus towers")
end

function Awareness:GetSummonerName(Name)
	if string.find(Name, "Dot", 8) ~= nil then
		return "Ignite"
	end
	if string.find(Name, "HextechFlash", 8) ~= nil then
		return "HexFlash"
	end
	if string.find(Name, "Flash", 8) ~= nil then
		return "Flash"
	end
	if string.find(Name, "Haste", 8) ~= nil then
		return "Ghost"
	end
	if string.find(Name, "Heal", 8) ~= nil then
		return "Heal"
	end
	if string.find(Name, "Barrier", 8) ~= nil then
		return "Barrier"
	end
	if string.find(Name, "Exhaust", 8) ~= nil then
		return "Exhaust"
	end
	if string.find(Name, "Teleport", 8) ~= nil then
		return "Teleport"
	end
	if string.find(Name, "Smite", 8) ~= nil then
		return "Smite"
	end
	if string.find(Name, "Boost", 8) ~= nil then
		return "Cleanse"
	end
	
	return Name
end

function Awareness:DrawCooldowns(Target)
	local QSlot = Target:GetSpellSlot(0)
	local WSlot = Target:GetSpellSlot(1)
	local ESlot = Target:GetSpellSlot(2)
	local RSlot = Target:GetSpellSlot(3)
	local DSlot = Target:GetSpellSlot(4)
	local FSlot = Target:GetSpellSlot(5)
	
	local QLevel = QSlot.Level
	local WLevel = WSlot.Level
	local ELevel = ESlot.Level
	local RLevel = RSlot.Level

	local GameTime = GameClock.Time
	local QCD = QSlot.Cooldown - GameTime
	local WCD = WSlot.Cooldown - GameTime
	local ECD = ESlot.Cooldown - GameTime
	local RCD = RSlot.Cooldown - GameTime
	local DCD = DSlot.Cooldown - GameTime
	local FCD = FSlot.Cooldown - GameTime
	
	local QString = " "
	local WString = " "
	local EString = " "
	local RString = " "
	
	if QLevel > 0 then
		QString = "Q"
	end
	if WLevel > 0 then
		WString = "W"
	end
	if ELevel > 0 then
		EString = "E"
	end
	if RLevel > 0 then
		RString = "R"
	end
	
	local DString = self:GetSummonerName(DSlot.Info.Name)
	local FString = self:GetSummonerName(FSlot.Info.Name)

	if QCD > 0 then
		QString = tostring(math.floor(QCD))
	end
	if WCD > 0 then
		WString = tostring(math.floor(WCD))
	end
	if ECD > 0 then
		EString = tostring(math.floor(ECD))
	end
	if RCD > 0 then
		RString = tostring(math.floor(RCD))
	end
	if DCD > 0 then
		DString = tostring(math.floor(DCD))
	end
	if FCD > 0 then
		FString = tostring(math.floor(FCD))
	end
	
	local AbilityString = QString .. " " .. WString .. " " .. EString .. " " .. RString
	local SummonerString = DString .. "\n" .. FString
	
	local vecOut = Vector3.new()
	if Render:World2Screen(Target.Position, vecOut) then
		Render:DrawString(AbilityString, vecOut.x - 30 , vecOut.y + 30, 255, 255, 255, 255)
		Render:DrawString(SummonerString, vecOut.x + 50 , vecOut.y - 5, 255, 255, 255, 255)
	end
end

function Awareness:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Awareness:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Awareness:DrawESPLines(Target, Range)
	if Target.Team ~= myHero.Team and not Target.IsDead then
		local Start     = myHero.Position
		local End       = Target.Position
		local Vec       = Vector3.new(End.x - Start.x ,End.y - Start.y ,End.z - Start.z) 
		
		local Length    = self:GetDist(Start,End)
		local VecNorm   = Vector3.new(Vec.x / Length,Vec.y / Length,Vec.z / Length)
		local Mod
		local Point
		local PointScreen
		if (Range <= 6250) then
			if (Range <= 6250 and Range >= 4165) then
				Mod = Length / 15
			end
			if (Range <= 4165 and Range >= 2000) then
				Mod = Length / 8
			end
			if (Range <= 2000) then
				Mod = Length / 2
			end
			Point     = Vector3.new(Start.x + (VecNorm.x * Mod) , Start.y + (VecNorm.y * Mod) , Start.z + (VecNorm.z * Mod))	
			PointScreen           = Vector3.new()
			Render:World2Screen(Point, PointScreen)
		end
		local StartScreen           = Vector3.new()
		local EndScreen             = Vector3.new()
		
		Render:World2Screen(Start, StartScreen)
		Render:World2Screen(End, EndScreen)
		if Awareness:GetDist(myHero.Position, Target.Position) <= 2000 then
			local time = math.floor(Awareness:GetDist(myHero.Position, Target.Position) / Target.MovementSpeed)
			Render:DrawLine(StartScreen, EndScreen, 204,204,0,255)
			Render:DrawString(time, PointScreen.x, PointScreen.y, 255,255,255,255)
			if Awareness:GetDist(myHero.Position, Target.Position) <= Awareness:getAttackRange() then
				local time = math.floor(Awareness:GetDist(myHero.Position, Target.Position) / Target.MovementSpeed)
				Render:DrawLine(StartScreen, EndScreen, 255,0,0,255)
				Render:DrawString(time, PointScreen.x, PointScreen.y, 255,255,255,255)
			end
		end
		if Awareness:GetDist(myHero.Position, Target.Position) >= 2000 and Awareness:GetDist(myHero.Position, Target.Position) <= 4165 then
			local time = math.floor(Awareness:GetDist(myHero.Position, Target.Position) / Target.MovementSpeed)
			Render:DrawLine(StartScreen, EndScreen, 128,0,128,255)
			Render:DrawString(time, PointScreen.x, PointScreen.y, 255,255,255,255)
		end
		if Awareness:GetDist(myHero.Position, Target.Position) >= 4165 and Awareness:GetDist(myHero.Position, Target.Position) <= 6250 then
			local time = math.floor(Awareness:GetDist(myHero.Position, Target.Position) / Target.MovementSpeed)
			Render:DrawLine(StartScreen, EndScreen, 0,255,0,255)
			Render:DrawString(time, PointScreen.x, PointScreen.y, 255,255,255,255)
		end
	end
end

function Awareness:DrawTowers()
	local teamSide = myHero.Team
	if teamSide == 100 then
		if self.AllyOuterTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(10500, 50, 1040),
				Vector3.new(5840, 52, 6410),
				Vector3.new(980, 52, 10445),
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyMiddleTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(1510.2917480469, 52.838012695313, 6710.5688476563),
				Vector3.new(5041.2426757813, 50.256469726563, 4825.1508789063),
				Vector3.new(6920.4887695313, 49.448608398438, 1495.9188232422),
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyInnerTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(4278.4096679688, 95.748046875, 1266.9205322266),
				Vector3.new(3650.9770507813, 95.748046875, 3712.5590820313),
				Vector3.new(1165.9887695313, 95.747802734375, 4300.4536132813),
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyNexusTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(1745.1547851563, 95.748046875, 2281.1142578125),
				Vector3.new(2170.5983886719, 95.748046875, 1820.3920898438)
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.EnemyOuterTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(13862.0, 52, 4510.0),
				Vector3.new(8950, 54, 8520.0),
				Vector3.new(4320, 52, 13880),
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyMiddleTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(9765.494140625, 52.294921875, 10120.1328125),
				Vector3.new(13329.375976563, 52.30615234375, 8229.7685546875),
				Vector3.new(7940.0395507813, 52.837890625, 13417.553710938)
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyInnerTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(10480.225585938, 95.49560546875, 13655.857421875),
				Vector3.new(11130.123046875, 93.336303710938, 11215.3046875),
				Vector3.new(13620.3125, 93.3359375, 10580.763671875)
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyNexusTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(13050.366210938, 93.336303710938, 12625.783203125),
				Vector3.new(12606.698242188, 93.336181640625, 13096.665039063)
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end
	else
		if self.AllyOuterTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(13862.0, 52, 4510.0),
				Vector3.new(8950, 54, 8520.0),
				Vector3.new(4320, 52, 13880),
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyMiddleTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(9765.494140625, 52.294921875, 10120.1328125),
				Vector3.new(13329.375976563, 52.30615234375, 8229.7685546875),
				Vector3.new(7940.0395507813, 52.837890625, 13417.553710938)
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyInnerTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(10480.225585938, 95.49560546875, 13655.857421875),
				Vector3.new(11130.123046875, 93.336303710938, 11215.3046875),
				Vector3.new(13620.3125, 93.3359375, 10580.763671875)
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.AllyNexusTowers.Value == 1 then
			local allyTowerPositions = {
				Vector3.new(13050.366210938, 93.336303710938, 12625.783203125),
				Vector3.new(12606.698242188, 93.336181640625, 13096.665039063)
			}
			for i = 1, #allyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(allyTowerPositions[i], outVec) then
					Render:DrawCircle(allyTowerPositions[i], 850, 0, 200, 100, 255)
				end
			end
		end

		if self.EnemyOuterTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(10500, 50, 1040),
				Vector3.new(5840, 52, 6410),
				Vector3.new(980, 52, 10445),
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyMiddleTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(1510.2917480469, 52.838012695313, 6710.5688476563),
				Vector3.new(5041.2426757813, 50.256469726563, 4825.1508789063),
				Vector3.new(6920.4887695313, 49.448608398438, 1495.9188232422),
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyInnerTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(4278.4096679688, 95.748046875, 1266.9205322266),
				Vector3.new(3650.9770507813, 95.748046875, 3712.5590820313),
				Vector3.new(1165.9887695313, 95.747802734375, 4300.4536132813),
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end

		if self.EnemyNexusTowers.Value == 1 then
			local enemyTowerPositions = {
				Vector3.new(1745.1547851563, 95.748046875, 2281.1142578125),
				Vector3.new(2170.5983886719, 95.748046875, 1820.3920898438)
			}
			for i = 1, #enemyTowerPositions do
				local outVec = Vector3.new()
				if Render:World2Screen(enemyTowerPositions[i], outVec) then
					Render:DrawCircle(enemyTowerPositions[i], 850, 255, 0, 0, 255)
				end
			end
		end
	end
end

function Awareness:DrawRecalls(Target)
	local State = Target.RecallState
	local GameTime = GameClock.Time
	if self.DrawTestRecall.Value == 1 then
		local RecallTime = 6
		local RecallString = myHero.Name .. string.format(":        %.2f", RecallTime)
		if RecallTime > 0 then
			if RecallTime > 2 then
				Render:DrawFilledBox(self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 20 * RecallTime, 20, 155, 155, 155, 155)
				Render:DrawString(RecallString, self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 255, 255, 255, 255)
				self.RecallDraws = self.RecallDraws + 1
			end
			if RecallTime < 2 then --last 2 secs draw red
				Render:DrawFilledBox(self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 20 * RecallTime, 20, 255, 100, 100, 155)
				Render:DrawString(RecallString, self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 255, 255, 255, 255)
				self.RecallDraws = self.RecallDraws + 1
			end
		end
	else
		if self.RecallTimes[Target.Index] ~= nil then
			local RecallTime = 8 - (GameTime - self.RecallTimes[Target.Index])
			if State == 6 then
				local RecallString = Target.ChampionName .. string.format(":        %.2f", RecallTime)
				if RecallTime > 0 then
					if RecallTime > 2 then
						Render:DrawFilledBox(self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 20 * RecallTime, 20, 155, 155, 155, 155)
						Render:DrawString(RecallString, self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 255, 255, 255, 255)
						self.RecallDraws = self.RecallDraws + 1
						return
					end
					if RecallTime < 2 then --last 2 secs draw red
						Render:DrawFilledBox(self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 20 * RecallTime, 20, 255, 100, 100, 155)
						Render:DrawString(RecallString, self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 255, 255, 255, 255)
						self.RecallDraws = self.RecallDraws + 1
						return
					end
				end
			end
			if RecallTime > -3 and RecallTime < 0 then
				local RecallString = Target.ChampionName .. ":        recall finished!"
				Render:DrawString(RecallString, self.RecallXAxis.Value, self.RecallYAxis.Value + (20 * self.RecallDraws), 0, 255, 100, 255)
				self.RecallDraws = self.RecallDraws + 1
			else
				self.RecallTimes[Target.Index] = GameTime
			end
		else
			self.RecallTimes[Target.Index] = GameTime
		end	
	end
end

function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00:00";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return mins..":"..secs
    end
  end

function Awareness:FlashTracker(Target)
    local DSlot = Target:GetSpellSlot(4)
    local FSlot = Target:GetSpellSlot(5)
    
    local GameTime = GameClock.Time
    local DCD = DSlot.Cooldown - GameTime
    local FCD = FSlot.Cooldown - GameTime
    
    local DString = self:GetSummonerName(DSlot.Info.Name)
    local FString = self:GetSummonerName(FSlot.Info.Name)

    local String = 0
    local OnCD = 0

    if DString == "Flash" then
        String = DCD
        OnCD = DCD
    end
    if FString == "Flash" then
        String = FCD
        OnCD = FCD
    end

    if String > 0 then
		String = tostring(math.floor(String))
	end
    
    local FlashString = Target.ChampionName .. " Flash: " .. SecondsToClock(String + GameTime)
    if OnCD > 0 then
        Render:DrawString(FlashString, 1700, 300 + (20 * self.FlashDraws), 255, 255, 255, 255)
        self.FlashDraws = self.FlashDraws + 1
        return
    end
end

function Awareness:DrawWards(Target)
	DrawThis = false		
	if Target.Name == "SightWard" then
		DrawThis = true
	end
	if Target.Name == "VisionWard" then
		DrawThis = true
	end
	if Target.Name == "JammerDevice" then
		DrawThis = true
	end
	if Target.Name == "Noxious Trap" then
		DrawThis = true
	end
	if Target.Name == "Jack In The Box" then
		DrawThis = true
	end
	if DrawThis == true then
		Render:DrawCircle(Target.Position, 65, 0, 200, 100, 255)
		local outVec = Vector3.new()
		if Render:World2Screen(Target.Position, outVec) then
			Render:DrawString(Target.Name, outVec.x, outVec.y, 0, 200, 100, 255)
			--Render:DrawString(Target.Mana, outVec.x, outVec.y+40, 0, 200, 100, 255)
		end
	end
end

function Awareness:OnTick()
end

function Awareness:OnDraw()
    self.RecallDraws = 0
    self.FlashDraws = 0
	
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if self.DrawFriendCD.Value == 1 and Hero.Team == myHero.Team then
			if Hero.IsTargetable then
				self:DrawCooldowns(Hero)
			end
		end
		if Hero.Team ~= myHero.Team then
			if self.DrawEnemyCD.Value == 1 then
				if Hero.IsTargetable then
                    self:DrawCooldowns(Hero)
				end
			end
            self:DrawRecalls(Hero)
            if self.FlashTrack.Value == 1 then
                self:FlashTracker(Hero)
            end
        end
		if self.ESPLines.Value == 1 then
			Awareness:DrawESPLines(Hero, Awareness:GetDist(myHero.Position, Hero.Position))
		end
		self:DrawTowers()
    end
		
	if self.DrawEnemyWards.Value == 1 then
		local Minions = ObjectManager.MinionList
		for I, Minion in pairs(Minions) do
			if Minion.Team ~= myHero.Team then
				self:DrawWards(Minion)
			end
		end
	end
end



function Awareness:OnLoad()
	AddEvent("OnSettingsSave" , function() Awareness:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Awareness:LoadSettings() end)


	Awareness:__init()
	AddEvent("OnTick", function() Awareness:OnTick() end)	
	AddEvent("OnDraw", function() Awareness:OnDraw() end)	
end

AddEvent("OnLoad", function() Awareness:OnLoad() end)	
