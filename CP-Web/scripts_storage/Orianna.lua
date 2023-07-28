require("SupportLib")
Orianna = {}
function Orianna:__init()
	self.QRange = 800
	self.WRange = 250
	self.ERange = 1100
	self.RRange = 400

	self.QSpeed = 1600
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 160
	self.RWidth = 415

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0.5

	self.QHitChance = 0.2
	self.RHitChance = 0.2


    self.ChampionMenu = Menu:CreateMenu("Orianna")
		-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
    self.RTargets  = self.ComboMenu:AddSlider("Minimum R Targets", 3, 1, 5, 1)
    self.RPercent  = self.ComboMenu:AddSlider("HP % for Solo R", 30, 0, 100, 1)
		-------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)

	Orianna:LoadSettings()
end

function Orianna:SaveSettings()
	SettingsManager:CreateSettings("Orianna")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("RTargets", self.RTargets.Value)
	SettingsManager:AddSettingsInt("RPercent", self.RPercent.Value)
		-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Orianna:LoadSettings()
	SettingsManager:GetSettingsFile("Orianna")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.RTargets.Value = SettingsManager:GetSettingsInt("Combo","RTargets")
	self.RPercent.Value = SettingsManager:GetSettingsInt("Combo","RPercent")
		------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end


function Orianna:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Orianna:EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Orianna:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Orianna:GetBallPosition()
	local Missiles = ObjectManager.MissileList
	for I, Missile in pairs(Missiles) do	
		if Missile.Team == myHero.Team then
			if Missile.Name == "OrianaIzuna" then --QCast
				self.QPos = Missile.MissileEndPos
				return nil
			end
			if Missile.Name == "OrianaRedact" then--ECast
				return nil
			end
		end
	end
	local meBall = myHero.BuffData:GetBuff("orianaghostself")
	if meBall.Count_Alt > 0 then
		return myHero.Position
	end
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do	
		if Hero.Team == myHero.Team then
			local allyBall = Hero.BuffData:GetBuff("orianaghost")
			if allyBall.Count_Alt > 0 then
				return Hero.Position
			end
		end
	end
	local Minions = ObjectManager.MinionList
	for I,Minion in pairs(Minions) do	
		if Minion.Team == myHero.Team and Minion.IsDead == false then
			if Minion.Name == "TheDoomBall" then
				if self.QPos ~= nil then
					if self:GetDistance(Minion.Position, self.QPos) < 20 then
						return Minion.Position
					end
				end
			end
		end
	end
	return nil
end

function Orianna:Combo()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local StartPos 				= self.BallPos
		if StartPos ~= nil then
			local TargetCount 		= self:EnemiesInRange(StartPos, self.RRange)
			if TargetCount >= self.RTargets.Value then
				Engine:CastSpell("HK_SPELL4", nil ,1)
				return
			end
			
			local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.RRange, self.RSpeed, self.RWidth,self.RDelay, 0, true, self.RHitChance, 0)
			if Target ~= nil then
				local HPPercent = Target.Health / Target.MaxHealth * 100
				if HPPercent <= self.RPercent.Value then
					Engine:CastSpell("HK_SPELL4", nil ,1)
					return
				end
			end
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 		= myHero.Position
		local Target 		= Orbwalker:GetTarget("Combo", self.QRange)
		if Target ~= nil then
			local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth,self.QDelay, 0, true, self.QHitChance, 0)
			if CastPos ~= nil then
				if self:GetDistance(myHero.Position , CastPos) < self.QRange then
					Engine:CastSpell("HK_SPELL1", CastPos ,1)
					return
				end
			end
		end
	end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos 				= self.BallPos
		if StartPos ~= nil then
			local TargetCount 		= self:EnemiesInRange(StartPos, self.WRange)
			if TargetCount > 0 then
				Engine:CastSpell("HK_SPELL2", nil ,1)
				return
			end
		end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local ShieldTarget = SupportLib:GetShieldTarget(self.ERange, 0.7)
		if ShieldTarget ~= nil then
			Engine:CastSpell("HK_SPELL3", ShieldTarget.Position ,1)
			return
		end
		local Target = Orbwalker:GetTarget("Combo", self.ERange)
		if Target ~= nil and self.BallPos ~= nil then
			if Prediction:PointOnLineSegment(myHero.Position, self.BallPos, Target.Position, 80) == true then
				Engine:CastSpell("HK_SPELL3", myHero.Position ,1)
				return
			end
		end
	end
end

function Orianna:getHeroLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Orianna:GetPassiveDMG()
	return 10 + 8 * math.floor((Orianna:getHeroLevel() - 1) / 3) + 0.15*myHero.AbilityPower
end

function Orianna:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		
		Orbwalker.ExtraWindup = 0.05
		Orbwalker.ExtraDamage = self:GetPassiveDMG()

		self.BallPos = self:GetBallPosition()
		if Engine:IsKeyDown("HK_COMBO") and Orbwalker.Attack == 0 then
			self:Combo()
			return
		end
	end
end

function Orianna:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
	if self.BallPos ~= nil then
		if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
			Render:DrawCircle(self.BallPos, self.WRange ,100,150,255,255)
		end
		if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
			Render:DrawCircle(self.BallPos, self.RRange ,100,150,255,255)
		end
	end
end



function Orianna:OnLoad()
    if(myHero.ChampionName ~= "Orianna") then return end
	AddEvent("OnSettingsSave" , function() Orianna:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Orianna:LoadSettings() end)


	Orianna:__init()
	AddEvent("OnTick", function() Orianna:OnTick() end)	
	AddEvent("OnDraw", function() Orianna:OnDraw() end)	
end

AddEvent("OnLoad", function() Orianna:OnLoad() end)	
