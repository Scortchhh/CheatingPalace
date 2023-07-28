Jinx = {}
function Jinx:__init()

	if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end

	
	self.QRange = 175
	self.WRange = 1500
	self.ERange = 475

	self.QSpeed = math.huge
	self.WSpeed = 2000
	self.ESpeed = math.huge
	self.RSpeed = 2500

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 1.3

    self.ChampionMenu = Menu:CreateMenu("Jinx")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	self.RRange	   = self.ComboMenu:AddSlider("Range for R use", 5000, 2000, 25000, 1000)
	-------------------------------------------
	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
	self.HarassUseW = self.HarassMenu:AddCheckbox("UseW", 1)
	-------------------------------------------
	self.BaseMenu  = self.ChampionMenu:AddSubMenu("BaseUlt")
    self.BaseUseR  = self.BaseMenu:AddCheckbox("Enabled", 1)
	-------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	Jinx:LoadSettings()
end

function Jinx:SaveSettings()
	SettingsManager:CreateSettings("Jinx")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("RSlider", self.RRange.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseW", self.HarassUseW.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("BaseUlt")
	SettingsManager:AddSettingsInt("Enabled", self.BaseUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawEValue)
end

function Jinx:LoadSettings()
	SettingsManager:GetSettingsFile("Jinx")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.RRange.Value 	 = SettingsManager:GetSettingsInt("Combo","RSlider")
	-------------------------------------------------------------
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseW")
	-------------------------------------------------------------
	self.BaseUseR.Value = SettingsManager:GetSettingsInt("BaseUlt","Enabled")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Jinx:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Jinx:CastRToEnemyBase()
	Engine:CastSpellMap("HK_SPELL4", self.EnemyBase ,1)
end

function Jinx:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local ArmorMod 					= 100 / (100 + Target.Armor)
	local RLevel 					= myHero:GetSpellSlot(3).Level
	local DMG 						= 150 + (100 * RLevel) * 2 + (myHero.BonusAttack * 1.5) + (MissingHealth * (0.20 + (0.05*RLevel))) 
	return DMG * ArmorMod
end

function Jinx:CheckBaseUlt()
	local Distance 					= self:GetDistance(self.EnemyBase, myHero.Position)
	local GameTime					= GameClock.Time
	local TravelTime 				= (Distance / self.RSpeed) + self.RDelay
	
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
			local State = Hero.RecallState
			if State == 6 then
				local RDMG				= self:GetRDamage(Hero)
				local RecallTime 		= 8 - (GameTime - Awareness.RecallTimes[Hero.Index])
				if RDMG > Hero.Health and TravelTime >= RecallTime then
					return true
				end
			end
		end
	end
	
	return false
end

function Jinx:GapCloseTarget()
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
			if Hero.AIData.IsDashing == true then
				local TargetPos = Target.AIData.TargetPos
				local Distance = self:GetDistance(TargetPos, myHero.Position)
				if Distance < self.ERange then
					return Hero
				end
			end
		end
	end
	return nil
end

function Jinx:Combo()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local StartPos 			= myHero.Position
		local CastPos ,Target	= Prediction:GetCastPos(StartPos, self.RRange.Value, self.RSpeed, 0, 0.75, 0)
		if CastPos ~= nil and Target ~= nil then
			local Distance 		= self:GetDistance(StartPos, CastPos)
			if Distance < self.RRange.Value and Distance > self.WRange then
				local RDMG = self:GetRDamage(Target)
				if RDMG > Target.Health then
					Engine:CastSpellMap("HK_SPELL4", CastPos ,1)
					return
				end
			end
		end
	end
	
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos 			= myHero.Position
		local CastPos 			= Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, 80, self.WDelay, 1)
		if CastPos ~= nil then
			local Distance 		= self:GetDistance(StartPos, CastPos)
			if Distance < self.WRange and Distance > self.QRange then
				Engine:CastSpell("HK_SPELL2", CastPos ,1)
				return
			end
		end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = self:GapCloseTarget()
		if Target ~= nil then
			local StartPos 			= myHero.Position
			local CastPos = Prediction:GetPredPos(StartPos, Target, self.ESpeed, self.EDelay)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL3", CastPos ,1)
				return
			end	
		end
	end
	
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local AttackRange 		= myHero.AttackRange + myHero.CharData.BoundingRadius
		local AttackBaseRange 	= 525 + myHero.CharData.BoundingRadius	--without rapidfire	
		local Target 			= Orbwalker:GetTarget("Combo", self.QRange)
		if Target ~= nil then 
			local JinxQ 		= myHero.BuffData:GetBuff("JinxQ")
			local Distance 		= self:GetDistance(myHero.Position, Target.Position)
			if Distance > AttackRange and JinxQ.Valid == false then
				Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
				return
			end		
			if Distance < AttackBaseRange and JinxQ.Valid == true then
				Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
				return
			end		
		end
	end
end

function Jinx:Harass()
	if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos 			= myHero.Position
		local CastPos 			= Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, 80, self.WDelay, 1)
		if CastPos ~= nil then
			local Distance 		= self:GetDistance(StartPos, CastPos)
			if Distance < self.WRange and Distance > self.QRange then
				Engine:CastSpell("HK_SPELL2", CastPos ,1)
				return
			end
		end
	end
end

function Jinx:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		self.QRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50 + (myHero:GetSpellSlot(0).Level * 25)
		if self.BaseUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
			if self:CheckBaseUlt() == true then
				self:CastRToEnemyBase()
			end
		end
			if Engine:IsKeyDown("HK_COMBO") and Orbwalker.Attack == 0 then
			Jinx:Combo()
			return
		end
			if Engine:IsKeyDown("HK_HARASS") and Orbwalker.Attack == 0 then
			Jinx:Harass()
			return
		end
	end
end

function Jinx:OnDraw()
	local JinxQ = myHero.BuffData:GetBuff("JinxQ")
	if JinxQ.Valid == false and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL3") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
end



function Jinx:OnLoad()
    if(myHero.ChampionName ~= "Jinx") then return end
	AddEvent("OnSettingsSave" , function() Jinx:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Jinx:LoadSettings() end)


	Jinx:__init()
	AddEvent("OnTick", function() Jinx:OnTick() end)	
	AddEvent("OnDraw", function() Jinx:OnDraw() end)	
end

AddEvent("OnLoad", function() Jinx:OnLoad() end)	
