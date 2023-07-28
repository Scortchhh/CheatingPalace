require("SupportLib")

Soraka = {}
function Soraka:__init()
	self.QRange = 800
    self.QRadius = 250

	self.WRange = 550

	self.ERange = 925
    self.ERadius = 250

    self.RRange = math.huge

	self.QSpeed = 1700
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 235
	self.EWidth = 250

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

	self.QHitChance = 0.2
	self.EHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Soraka")
	-------------------------------------------
    self.QSettings 		= self.ChampionMenu:AddSubMenu("Q  Settings")
    self.ComboUseQ 		= self.QSettings:AddCheckbox("UseQ on Combo", 1)
    self.HarassUseQ     = self.QSettings:AddCheckbox("UseQ on Harass", 1)
	-------------------------------------------
	self.WSettings		= self.ChampionMenu:AddSubMenu("W Settings")
    self.WSettings:AddLabel("HP % for W Heal:")
	self.WTargets		= {}
	self.OwnHP			= self.WSettings:AddSlider("Soraka %HP to not heal others", 30, 0, 100, 1)

	-------------------------------------------
	self.ESettings		= self.ChampionMenu:AddSubMenu("E   Settings")
    self.ComboUseE 		= self.ESettings:AddCheckbox("UseE on Combo", 1)
    self.HarassUseE     = self.ESettings:AddCheckbox("UseE on Harass", 1)
    -------------------------------------------
	self.RSettings 		= self.ChampionMenu:AddSubMenu("R   Settings")
	self.RSettings:AddLabel("HP % for R Save:")
	self.RTargets		= {}
	-------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1)
	
	-- Soraka:LoadSettings()
end

function Soraka:SaveSettings()
	SettingsManager:CreateSettings("Soraka")
	SettingsManager:AddSettingsGroup("QSettings")
	SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
	SettingsManager:AddSettingsInt("OwnHP", self.OwnHP.Value)
	local HeroList = ObjectManager.HeroList
	for i, wTarget in pairs(HeroList) do
		if wTarget.Team == myHero.Team then
			if self.WTargets["W " .. wTarget.Index] ~= nil then
				SettingsManager:AddSettingsInt("WSettings " .. wTarget.Index, self.WTargets["W " .. wTarget.Index].Value)
			end
		end
	end
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseEHarass", self.HarassUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("RSettings")
	for i, rTarget in pairs(HeroList) do
		if rTarget.Team == myHero.Team then
			if self.RTargets["R " .. rTarget.Index] ~= nil then
				SettingsManager:AddSettingsInt("RSettings " .. rTarget.Index, self.RTargets["R " .. rTarget.Index].Value)
			end
		end
	end
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Soraka:LoadSettings()
	SettingsManager:GetSettingsFile("Soraka")
	self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
	-------------------------------------------------------------
	self.OwnHP.Value 		= SettingsManager:GetSettingsInt("WSettings","OwnHP")
	-------------------------------------------------------------
	self.ComboUseE.Value 		= SettingsManager:GetSettingsInt("ESettings","UseECombo")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
	-------------------------------------------------------------
	local HeroList = ObjectManager.HeroList
	for i, Target in pairs(HeroList) do
		if Target.Team == myHero.Team then
			if self.WTargets["W " .. Target.Index] ~= nil then
				self.WTargets["W " .. Target.Index].Value = SettingsManager:GetSettingsInt("WSettings", "WSettings " .. Target.Index)
			end
			if self.RTargets["R " .. Target.Index] ~= nil then
				-- print(self.RTargets["R " .. Target.Index].Value)
				self.RTargets["R " .. Target.Index].Value = SettingsManager:GetSettingsInt("RSettings", "RSettings " .. Target.Index)
			end
		end
	end
end

function Soraka:GetExtendedPosition(EndPos, Range)
	local StartPos = myHero.Position
	
	local X = EndPos.x - StartPos.x
	local Y = EndPos.y - StartPos.y
	local Z = EndPos.z - StartPos.z

	local Length = math.max(1, math.sqrt((X^2)+(Y^2)+(Z^2)))
	local Normal = Vector3.new(X/Length,Y/Length,Z/Length)

	return Vector3.new(StartPos.x + (Normal.x * Range), EndPos.y, StartPos.z + (Normal.z * Range) )
end

function Soraka:Q()
	if Engine:SpellReady("HK_SPELL1") then
		local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange + self.QRadius, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
		if CastPos then
            if SupportLib:GetDistance(myHero.Position, CastPos) > self.QRange then
				local ExtendedCastPos = self:GetExtendedPosition(CastPos, self.QRange)
				return Engine:CastSpell("HK_SPELL1",ExtendedCastPos, 0)		
			else
				return Engine:CastSpell("HK_SPELL1",CastPos, 0)
			end
		end
	end
end

function Soraka:E()
	if Engine:SpellReady("HK_SPELL3") then
		local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange + self.ERadius, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
		if CastPos then
            if SupportLib:GetDistance(myHero.Position, CastPos) > self.ERange then
				local ExtendedCastPos = self:GetExtendedPosition(CastPos, self.ERange)
				return Engine:CastSpell("HK_SPELL3",ExtendedCastPos, 0)		
			else
				return Engine:CastSpell("HK_SPELL3",CastPos, 0)
			end
		end
	end
end

function Soraka:W()
	if Engine:SpellReady("HK_SPELL2") then
		local HealTarget = SupportLib:GetShieldTargetWithTable(self.WRange, self.WTargets, "W ")
		local thresholdHP = myHero.MaxHealth / 100 * self.OwnHP.Value
		if HealTarget and myHero.Health >= thresholdHP then
			return Engine:CastSpell("HK_SPELL2", HealTarget.Position, 1)
		end
	end
end

function Soraka:R()
	if Engine:SpellReady("HK_SPELL4") then
		local HealTarget = SupportLib:GetShieldTargetWithTable(self.RRange, self.RTargets, "R ")
		if HealTarget then
			return Engine:CastSpell("HK_SPELL4", nil, 0)
		end
	end
end

local hasLoadedSettings = false
function Soraka:OnTick()
	local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.WTargets["W " .. Ally.Index] == nil and Ally.Index ~= myHero.Index then
			self.WTargets["W " .. Ally.Index] 		= self.WSettings:AddSlider(Ally.ChampionName, 80, 0, 100, 1)
		end
		if string.len(Ally.ChampionName) > 1 and self.RTargets["R " .. Ally.Index] == nil then
			self.RTargets["R " .. Ally.Index] 		= self.RSettings:AddSlider(Ally.ChampionName .. " " , 30, 0, 100, 1)
		end
	end
	if not hasLoadedSettings then
		-- if GameClock.Time <= 10 then
			self:LoadSettings()
			hasLoadedSettings = true
		-- end
	end
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		self:R()
		self:W()
		if Engine:IsKeyDown("HK_COMBO") then	
			if self.ComboUseQ.Value == 1 then self:Q() end
            if self.ComboUseE.Value == 1 then self:E() end 
        end
		if Engine:IsKeyDown("HK_HARASS") then	
			if self.HarassUseQ.Value == 1 then self:Q() end
            if self.HarassUseE.Value == 1 then self:E() end 
        end
	end
end

function Soraka:OnDraw()
	if myHero.IsDead then return end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,150,255,100,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
    end
end

function Soraka:OnLoad()
    if(myHero.ChampionName ~= "Soraka") then return end
	AddEvent("OnSettingsSave" , function() Soraka:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Soraka:LoadSettings() end)


	Soraka:__init()
	AddEvent("OnTick", function() Soraka:OnTick() end)	
	AddEvent("OnDraw", function() Soraka:OnDraw() end)	
end

AddEvent("OnLoad", function() Soraka:OnLoad() end)