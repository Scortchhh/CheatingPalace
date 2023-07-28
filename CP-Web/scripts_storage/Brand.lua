require("SupportLib")

Brand = {}
function Brand:__init()	
	self.QRange = 1040
	self.WRange = 900
	self.ERange = 620
	self.RRange = 750

	self.QSpeed = 1600
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 120
	self.WWidth = 260

	self.QDelay = 0.25 
	self.WDelay = 0.875
	self.EDelay = 0
	self.RDelay = 0

	self.QHitChance = 0.35
	self.WHitChance = 0.4


    self.ChampionMenu = Menu:CreateMenu("Brand")
	-------------------------------------------
    self.QSettings = self.ChampionMenu:AddSubMenu("QSettings")
    self.UseQCombo = self.QSettings:AddCheckbox("UseQ on Combo", 1)
    self.UseQHarass= self.QSettings:AddCheckbox("UseQ on Harass", 1)
	self.UseQFast  = self.QSettings:AddCheckbox("FastQ", 1)
	-------------------------------------------
    self.WSettings = self.ChampionMenu:AddSubMenu("WSettings")
    self.UseWCombo = self.WSettings:AddCheckbox("UseW on Combo", 1)
    self.UseWHarass= self.WSettings:AddCheckbox("UseW on Harass", 1)
	-------------------------------------------
    self.ESettings = self.ChampionMenu:AddSubMenu("ESettings")
    self.UseECombo = self.ESettings:AddCheckbox("UseE on Combo", 1)
    self.UseEHarass= self.ESettings:AddCheckbox("UseE on Harass", 1)
	-------------------------------------------
    self.RSettings = self.ChampionMenu:AddSubMenu("RSettings")
    self.RSlider   = self.RSettings:AddSlider("UseR on min. X Enemies(0 = off)", 2, 0, 5 , 1)
	-------------------------------------------
	self.DrawMenu 	= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 		= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 		= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 		= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 		= self.DrawMenu:AddCheckbox("DrawR", 1)

	self.LastWTimer	 	= 0
	self.LastWPosition 	= nil

	Brand:LoadSettings()
end

function Brand:SaveSettings()
	SettingsManager:CreateSettings("Brand")
	SettingsManager:AddSettingsGroup("QSettings")
	SettingsManager:AddSettingsInt("QCombo", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("QHarass", self.UseQHarass.Value)
	SettingsManager:AddSettingsInt("QFast", self.UseQFast.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
	SettingsManager:AddSettingsInt("WCombo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("WHarass", self.UseWHarass.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("ECombo", self.UseECombo.Value)
	SettingsManager:AddSettingsInt("EHarass", self.UseEHarass.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("RSettings")
	SettingsManager:AddSettingsInt("RSlider", self.RSlider.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Brand:LoadSettings()
	SettingsManager:GetSettingsFile("Brand")
	
	
	-------------------------------------------
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("QSettings","QCombo")
    self.UseQHarass.Value= SettingsManager:GetSettingsInt("QSettings","QHarass")
	self.UseQFast.Value  = SettingsManager:GetSettingsInt("QSettings","QFast")
	-------------------------------------------
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("WSettings","WCombo")
    self.UseWHarass.Value= SettingsManager:GetSettingsInt("WSettings","WHarass")
	-------------------------------------------
    self.UseECombo.Value = SettingsManager:GetSettingsInt("ESettings","ECombo")
    self.UseEHarass.Value= SettingsManager:GetSettingsInt("ESettings","EHarass")
	-------------------------------------------
    self.RSlider.Value   = SettingsManager:GetSettingsInt("RSettings","RSlider")
	-------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end
--brandablaze
function Brand:GetQTargets()
	local QTargets = {}
	local Enemies = SupportLib:GetEnemiesInRange(myHero.Position, self.QRange + 100)
	for _,Enemy in pairs(Enemies) do
		if Enemy.BuffData:GetBuff("brandablaze").Count_Alt > 0 then
			QTargets[#QTargets+1] = Enemy
		end
	end
	if self.UseQFast.Value == 1 and self.LastWPosition ~= nil and Engine:SpellReady("HK_SPELL2") == false then
		local Enemies = SupportLib:GetEnemiesInRange(self.LastWPosition, 350)
		for _,Enemy in pairs(Enemies) do
			local Dist		= SupportLib:GetDistance(myHero.Position, Enemy.Position)
			local Time 		= (Dist / self.QSpeed) + self.QDelay
			if Time > 0.65 then
				QTargets[#QTargets+1] = Enemy
			end
		end	
	end
	return SupportLib:SortList(QTargets, "HP")
end

function Brand:GetETargets()
	local ETargets = SupportLib:GetEnemiesInRange(myHero.Position, self.ERange)
	ETargets = SupportLib:SortList(ETargets, "HP")
	
	local Minions = ObjectManager.MinionList
	for _,Minion in pairs(Minions) do
		if Minion.IsTargetable and Minion.Team ~= myHero.Team and SupportLib:GetDistance(Minion.Position, myHero.Position) < self.ERange+Minion.CharData.BoundingRadius  then
			local Enemies = {}
			if Minion.BuffData:GetBuff("brandablaze").Count_Alt > 0 then
				Enemies = SupportLib:GetEnemiesInRange(Minion.Position, 600)
			else
				Enemies = SupportLib:GetEnemiesInRange(Minion.Position, 300)
			end
			for _,Enemy in pairs(Enemies) do
				if Enemy.IsTargetable then
					ETargets[#ETargets+1] = Minion
				end
			end
		end
	end
	return ETargets
end

function Brand:GetRTargets()
	local RTargets = SupportLib:GetEnemiesInRange(myHero.Position, self.RRange)
	RTarget = SupportLib:SortList(RTargets, "HP")

	local Minions = ObjectManager.MinionList
	for _,Minion in pairs(Minions) do
		if Minion.IsTargetable and Minion.Team ~= myHero.Team and SupportLib:GetDistance(Minion.Position, myHero.Position) < self.RRange+Minion.CharData.BoundingRadius then
			local Enemies = SupportLib:GetEnemiesInRange(Minion.Position, 600)
			for _,Enemy in pairs(Enemies) do
				if Enemy.IsTargetable then
					RTargets[#RTargets+1] = Minion
				end
			end
		end
	end
	return RTargets
end

function Brand:Q()
	if Engine:SpellReady("HK_SPELL1") then
		local StartPos = myHero.Position
		local QTargets = self:GetQTargets()
		for _, Target in pairs(QTargets) do
			local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
			if PredPos and Prediction:WillCollideWithMinion(StartPos, PredPos, 80) == false and SupportLib:GetDistance(PredPos, myHero.Position) < self.QRange then
				return Engine:CastSpell("HK_SPELL1", PredPos, 0)
			end
		end
	end
end

function Brand:W()
	if Engine:SpellReady("HK_SPELL2") then
		local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
		if PredPos and Target then
			self.LastWTimer		= os.clock()
			self.LastWPosition 	= PredPos
			return Engine:CastSpell("HK_SPELL2", PredPos, 0)
		end
	end
end

function Brand:E()
	if Engine:SpellReady("HK_SPELL3") then
		local ETarget = self:GetETargets()
		for _, Target in pairs(ETarget) do
			return Engine:CastSpell("HK_SPELL3", Target.Position, 0)
		end
	end
end

function Brand:R()
	if Engine:SpellReady("HK_SPELL4") then
		local HeroCount= 0
		local RTargets = self:GetRTargets()
		for _, Target in pairs(RTargets) do
			if Target.IsHero then HeroCount = HeroCount+1 end
		end
		local Target = RTargets[1]
		if self.RSlider.Value > 0 and HeroCount >= self.RSlider.Value and Target then
			return Engine:CastSpell("HK_SPELL4",Target.Position, 0)		
		end
	end
end

function Brand:ManageLastWPosition()
	local Timer = os.clock() - self.LastWTimer
	if Timer > 1.0 then
		self.LastWPosition = nil
	end
end

function Brand:OnTick()
	self:ManageLastWPosition()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then	
		if Engine:IsKeyDown("HK_COMBO") then
			if self.UseQCombo.Value == 1 then
				self:Q()
			end
			if self.UseECombo.Value == 1 then
				self:E()
			end
			if self.UseWCombo.Value == 1 then
				self:W()
			end
			self:R()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			if self.UseQHarass.Value == 1 then
				self:Q()
			end
			if self.UseWHarass.Value == 1 then
				self:W()
			end
			if self.UseEHarass.Value == 1 then
				self:E()
			end
		end
	end
end

function Brand:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,255,150,0,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end



function Brand:OnLoad()
    if(myHero.ChampionName ~= "Brand") then return end
	AddEvent("OnSettingsSave" , function() Brand:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Brand:LoadSettings() end)


	Brand:__init()
	AddEvent("OnTick", function() Brand:OnTick() end)	
	AddEvent("OnDraw", function() Brand:OnDraw() end)	
end

AddEvent("OnLoad", function() Brand:OnLoad() end)	
