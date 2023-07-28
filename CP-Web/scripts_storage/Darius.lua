local Darius = {
}

function Darius:__init()
	self.QRange = 425
	self.WRange = 535
	self.ERange = 535
	self.RRange = 460

	self.QSpeed = 1600
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.EWidth = 120

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0.25
	self.RDelay = 0

	self.UsedQ 		= false
	self.WReset 	= false
	self.QFailTimer = nil
	self.WFailTimer = nil


    self.DariusMenu         = Menu:CreateMenu("Darius")
    self.DariusCombo        = self.DariusMenu:AddSubMenu("Combo")
    self.DariusCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo          = self.DariusCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo          = self.DariusCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo          = self.DariusCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo          = self.DariusCombo:AddCheckbox("Use R as killsteal", 1)
    self.DariusHarass       = self.DariusMenu:AddSubMenu("Harass")
    self.DariusHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass         = self.DariusHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass         = self.DariusHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass         = self.DariusHarass:AddCheckbox("Use E in harass", 1)
    self.DariusDrawings     = self.DariusMenu:AddSubMenu("Drawings")
    self.DrawQ              = self.DariusDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawE              = self.DariusDrawings:AddCheckbox("Use E in drawings", 1)
    self.DrawR              = self.DariusDrawings:AddCheckbox("Use R in drawings", 1)
    self.DariusMisc     	= self.DariusMenu:AddSubMenu("Misc")
    self.UseMagneticQ       = self.DariusMisc:AddCheckbox("Use Magnetic Q", 1)
    Darius:LoadSettings()
end

function Darius:SaveSettings()
	SettingsManager:CreateSettings("Darius")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R as killsteal", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use Magnetic Q", self.UseMagneticQ.Value)

end

function Darius:LoadSettings()
    SettingsManager:GetSettingsFile("Darius")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R as killsteal")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
    -------------------------------------------
    self.UseMagneticQ.Value = SettingsManager:GetSettingsInt("Misc", "Use Magnetic Q")
end

function Darius:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Darius:ExecuteTarget(Range)
    local Heros = ObjectManager.HeroList
    for Index, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and self:GetDistance(myHero.Position, Hero.Position) < Range and Hero.IsTargetable then
            local Buff = Hero.BuffData:GetBuff("DariusHemo")
			local Stacks = Buff.Count_Alt
			if Stacks > 5 then
				print("WTF STACKS: ",Buff.Count_Alt)
				Stacks = 1
			end
			local SpellDamage = myHero:GetSpellSlot(3).Level * 125 + myHero.BonusAttack * 0.75
			local StackDamage = (myHero:GetSpellSlot(3).Level * 25 + (myHero.BonusAttack * 0.15)) * Stacks
			local TotalDamage = SpellDamage + StackDamage
			if Hero.Health < TotalDamage then
				return Hero
			end
        end
    end 
    return nil
end

function Darius:QPos2Target(Target, Range)
	if Range == nil then return nil end
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -1 * Range
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Darius:MagneticQPosition()
	local searchsize = 75
    local dodgePos = nil
    local limiter = 600
	local ActualRangeToGetInto = self.QRange - 60
	local timeToPosTime = 0.75
	local PlayerPos = myHero.Position
	local Enemy = Orbwalker:GetTarget("Combo", self.QRange * 2)
	------------OLD MAGNETICPOS--------------------
	--[[if Enemy ~= nil then
		local BoundingRadius = Enemy.CharData.BoundingRadius
		if self:GetDistance(evadePos, Enemy.Position) <= ActualRangeToGetInto and self:GetDistance(evadePos, Enemy.Position) > BoundingRadius and self:GetDistance(evadePos, Enemy.Position) > myHero.AttackRange + myHero.CharData.BoundingRadius then
			local distanceFromMyHeroToPos = self:GetDistance(myHero.Position, evadePos)
			local timeToMouse = distanceFromMyHeroToPos / myHero.MovementSpeed
			if timeToMouse <= timeToPosTime then
				return evadePos
			end
		end
	end]]




	------------NEW MAGNETICPOS--------------------
	if Enemy then
		local Bound 		= Enemy.CharData.BoundingRadius
		local Range2Q 		= 350
		local PredPos, PredTime     = Prediction:GetPredictionPosition(Enemy, myHero.Position, math.huge, 1, 25, 0, 0, 0.001, 1)
		local SpeedDiff     = math.min(110, math.max(55, Enemy.MovementSpeed - myHero.MovementSpeed))
		if PredPos then
			if self:GetDistance(PredPos, myHero.Position) > self:GetDistance(Enemy.Position, myHero.Position) then
				Range2Q = 240 + SpeedDiff
			end
			if self:GetDistance(PredPos, myHero.Position) < self:GetDistance(Enemy.Position, myHero.Position) then
				Range2Q = 460 - SpeedDiff
			end
		end
		local evadePos 		= Darius:QPos2Target(Enemy, Range2Q)
		if evadePos then
			local distanceFromMyHeroToPos = self:GetDistance(myHero.Position, evadePos)
			local timeToMouse = distanceFromMyHeroToPos / myHero.MovementSpeed
			if timeToMouse <= timeToPosTime then
				return evadePos
			end
		end
	end
    return nil
end

function Darius:Combo()
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local Target = self:ExecuteTarget(self.RRange)
        if Target ~= nil then
            Engine:CastSpell("HK_SPELL4", Target.Position, 1)
			return
        end
    end

	local OrbTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)

	if Engine:SpellReady("HK_SPELL2") == false then
		self.WReset = false
	else
		if self.WFailTimer ~= nil and (GameClock.Time - self.WFailTimer) > 0.05 then
			self.WReset = false
		end
	end

	if self.WReset == true and Engine:SpellReady("HK_SPELL2") and OrbTarget then
		--print("SpecialAttack")
		return Engine:AttackClick(OrbTarget.Position, 1)
	end

    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if OrbTarget == nil and Orbwalker.Attack == 0 then
            local Target = Orbwalker:GetTarget("Combo", 600)
            if Target ~= nil then
				local Bound 			= Target.CharData.BoundingRadius
				local CastPos, PredTime = Prediction:GetPredictionPosition(Target, myHero.Position, self.ESpeed, self.EDelay, self.EWidth, 0, 0, 0.001, 1)
				if CastPos then
					local Dist2Pred 	= self:GetDistance(myHero.Position, CastPos)
					local Dist2Target 	= self:GetDistance(myHero.Position, Target.Position)
					local Range 		= 535 + Bound
					if Dist2Pred < Range and Dist2Target < Range - (Target.MovementSpeed * 0.25) then
						return Engine:CastSpell("HK_SPELL3", CastPos, 1)      
					end
				end
            end
		else 
			if OrbTarget and OrbTarget.AIData.Dashing == true then
				local Bound 			= OrbTarget.CharData.BoundingRadius
				local CastPos, PredTime = Prediction:GetPredictionPosition(OrbTarget, myHero.Position, self.ESpeed, self.EDelay, self.EWidth, 0, 0, 0.001, 1)
				if CastPos then
					local Dist2Pred 	= self:GetDistance(myHero.Position, CastPos)
					local Range 		= 535 + Bound
					if Dist2Pred < Range then
						return Engine:CastSpell("HK_SPELL3", CastPos, 1)      
					end
				end
			end
        end       
    end
	local WStartTime = myHero:GetSpellSlot(1).Info.Name
	--if WStartTime > 0 then
	--myHero.BuffData:ShowAllBuffs() --DariusNoxianTacticsONH
	--end
    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if OrbTarget then--and Orbwalker:CanAttack() == false then
			local WBuff = myHero.BuffData:GetBuff("DariusNoxianTacticsONH")
			local Buff = OrbTarget.BuffData:GetBuff("DariusHemo")
			
			if WBuff.Count_Alt == 0 and (os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 1.62 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup * 2.5 then--and Buff.Count_Alt > 0 then
				--print(os.clock() - Orbwalker.AttackTimer)
				--print("LastWindUp",Orbwalker.LastWindup)
				self.WReset = true 
				self.WFailTimer = GameClock.Time
				return Engine:CastSpell("HK_SPELL2", nil, 0) 
			end 
        end
    end

    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL2") == false then
		local Target = Orbwalker:GetTarget("Combo", 460)
		local QSlot = myHero:GetSpellSlot(0).Cooldown
		local difference = QSlot - GameClock.Time
		--local QStartTime = myHero:GetSpellSlot(0).StartTime
		if myHero.BuffData:GetBuff("dariusqcast").Count_Alt == 0 then
			if Target then
				local Buff = Target.BuffData:GetBuff("DariusHemo")
				if Buff.Count_Alt > 1 then
					if OrbTarget == nil and Orbwalker.Attack == 0 then
						self.QFailTimer = GameClock.Time
						self.UsedQ 		= true
						return Engine:CastSpell("HK_SPELL1", nil, 1)       
					end
					--print(Buff.Count_Alt)
					if Buff.Count_Alt >= 2 then
						self.QFailTimer = GameClock.Time
						self.UsedQ 		= true
						return Engine:CastSpell("HK_SPELL1", nil, 1)
					end
				end
			end
		end
    end
end

function Darius:Harass()
    local OrbTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if OrbTarget ~= nil and Orbwalker.ResetReady == 1 then
            return Engine:CastSpell("HK_SPELL2", nil, 1)           
        end
    end
    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if OrbTarget == nil and Orbwalker.Attack == 0 then
            return Engine:CastSpell("HK_SPELL1", nil, 1)           
        end
    end
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if OrbTarget == nil and Orbwalker.Attack == 0 then
            local Target = Orbwalker:GetTarget("Combo", self.ERange)
            if Target ~= nil then
                return Engine:CastSpell("HK_SPELL3", Target.Position, 1)           
            end
        end       
    end
end

local hasWalkedToQ = false
function Darius:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:SpellReady("HK_SPELL1") == false then
			self.UsedQ = false
		else
			if self.QFailTimer ~= nil and (GameClock.Time - self.QFailTimer) > 0.25 then
				self.UsedQ = false
			end
		end
		if self.UseMagneticQ.Value == 1 then
			local movePos = self:MagneticQPosition()
			local QSlot = myHero:GetSpellSlot(0).Cooldown
			local difference = QSlot - GameClock.Time
			--local QStartTime = myHero:GetSpellSlot(0).StartTime
			if Engine:IsKeyDown("HK_COMBO") or Engine:IsKeyDown("HK_HARASS") then
				if myHero.BuffData:GetBuff("dariusqcast").Valid or GameClock.Time < QSlot or self.UsedQ == true then
					--print("NotMoving?",difference)
					if movePos ~= nil and (self.UsedQ == true or ((difference >= 1 or difference >= -1 and difference <= 0) and GameClock.Time + difference - 1 < QSlot - difference)) then
						Orbwalker.Enabled = 0
						if Orbwalker:CanMove() and Orbwalker:ActionReady() then
							-- print('qslot', QSlot)
							-- print('difference', difference)
							-- print('gametime', GameClock.Time)
							Engine:MoveClick(movePos)
						end
					else
						Orbwalker.Enabled = 1
					end
				else
					Orbwalker.Enabled = 1
				end
			end
		end
        if Engine:IsKeyDown("HK_COMBO") then
            Darius:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Darius:Harass()
        end
    end
end

function Darius:OnDraw()
    if myHero.IsDead == true then return end
	local movePos = self:MagneticQPosition()
	if movePos ~= nil then
        Render:DrawCircle(movePos, 50,255,0,255,255)
	end
    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange,255,0,255,255)
    end
    if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange,255,0,255,255)
    end
    if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange,255,0,255,255)
    end
end

function Darius:OnLoad()
    if myHero.ChampionName ~= "Darius" then return end
    AddEvent("OnSettingsSave" , function() Darius:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Darius:LoadSettings() end)
    Darius:__init()
    AddEvent("OnDraw", function() Darius:OnDraw() end)
    AddEvent("OnTick", function() Darius:OnTick() end)
end

AddEvent("OnLoad", function() Darius:OnLoad() end)	