Xerath = {}
function Xerath:__init()
	self.QCast = false
	self.QMaxRange = 1400
	self.QChargeRange = 750
	self.WRange = 1000
	self.ERange = 950
	self.RRange = 2200

	self.QSpeed = math.huge
	self.WSpeed = math.huge
	self.ESpeed = 1600
	self.RSpeed = math.huge

	self.QDelay = 0.5
	self.WDelay = 0.45
	self.EDelay = 0.25
	self.RDelay = 0.5

	
    self.ChampionMenu = Menu:CreateMenu("Xerath")
	------------------------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQCombo", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseWCombo", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseECombo", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseRCombo", 1)
	------------------------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	------------------------------------------------------------
	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
	self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQHarass", 1)
	self.HarassUseW = self.HarassMenu:AddCheckbox("UseWHarass", 1)
	self.HarassUseE = self.HarassMenu:AddCheckbox("UseEHarass", 1)
	self.HarassUseR = self.HarassMenu:AddCheckbox("UseRHarass", 1)
	
	Xerath:LoadSettings()
end

function Xerath:SaveSettings()
	SettingsManager:CreateSettings("Xerath")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseRCombo", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseWHarass", self.HarassUseW.Value)
	SettingsManager:AddSettingsInt("UseEHarass", self.HarassUseE.Value)
	SettingsManager:AddSettingsInt("UseRHarass", self.HarassUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)

end

function Xerath:LoadSettings()
	SettingsManager:GetSettingsFile("Xerath")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQCombo")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseWCombo")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseECombo")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseRCombo")
	------------------------------------------------------------
	self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQHarass")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseWHarass")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","UseEHarass")
	self.HarassUseR.Value = SettingsManager:GetSettingsInt("Harass","UseRHarass")
	------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")

end

function Xerath:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Xerath:CastingQ()
	local QStartTime = myHero:GetSpellSlot(0).StartTime
	local QChargeTime = GameClock.Time - QStartTime
	local QCharge = myHero.ActiveSpell.Info.Name	
	if QCharge == "XerathArcanopulseChargeUp" then
		self.QChargeRange = 750.0 + (500*QChargeTime)
		if self.QChargeRange < 750 then self.QChargeRange = 750 end
		if self.QChargeRange > 1600 then self.QChargeRange = 1600 end
	else
		self.QChargeRange = 750.0
		self.QCast = false
	end
	if Engine:IsKeyDown("HK_SPELL1") == true and Engine:SpellReady("HK_SPELL1") == false then
		Engine:ReleaseSpell("HK_SPELL1")
		self.QCast = false
	end
end

function Xerath:Combo()
	local RStartTime = myHero:GetSpellSlot(3).StartTime
	
	self.RRange = 0
	local RLevel = myHero:GetSpellSlot(3).Level
	if RLevel > 0 then
		self.RRange = 2200 + 1320 * RLevel
	end
	
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		if RStartTime > 0 then
			local StartPos 	= GameHud.MousePos
			local CastPos 	= Prediction:GetCastPos(StartPos, 500, math.huge, 80, self.RDelay, 0)
			if CastPos ~= nil then
				if self:GetDistance(StartPos, CastPos) < self.RRange then
					Engine:CastSpell("HK_SPELL4", CastPos ,1)
					return
				end
			end
			return
		end
	end
	
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self.QCast == false then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, 0, self.WDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.WRange then
				Engine:CastSpell("HK_SPELL2", CastPos ,1)
				return
			end
		end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and self.QCast == false then
		local StartPos 			= myHero.Position
		local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, 80, self.EDelay, 1)
		if CastPos ~= nil and Target ~= nil then
			if Target.AIData.IsDashing == true or Target.BuffData:HasBuffOfType(BuffType.Stun) == true or Target.BuffData:HasBuffOfType(BuffType.Slow) == true or Target.BuffData:HasBuffOfType(BuffType.Snare) == true then
				if self:GetDistance(StartPos, CastPos) < self.ERange then
					Engine:CastSpell("HK_SPELL3", CastPos ,1)
					return
				end
			end
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , math.huge, 0, self.QDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QChargeRange-200 then
				Engine:CastSpell("HK_SPELL1", CastPos ,1)
				return
			end
			if self.QCast == false then
				Engine:ChargeSpell("HK_SPELL1")
				self.QCast = true
			end
		end
	end	
end

function Xerath:Harass()
	local RStartTime = myHero:GetSpellSlot(3).StartTime
	
	self.RRange = 0
	local RLevel = myHero:GetSpellSlot(3).Level
	if RLevel > 0 then
		self.RRange = 2200 + 1320 * RLevel
	end
	
	if self.HarassUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		if RStartTime > 0 then
			local StartPos 	= GameHud.MousePos
			local CastPos 	= Prediction:GetCastPos(StartPos, 500, math.huge, 80, self.RDelay, 0)
			if CastPos ~= nil then
				if self:GetDistance(StartPos, CastPos) < self.RRange then
					Engine:CastSpell("HK_SPELL4", CastPos ,1)
					return
				end
			end
			return
		end
	end
	
	if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self.QCast == false then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, 0, self.WDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.WRange then
				Engine:CastSpell("HK_SPELL2", CastPos ,1)
				return
			end
		end
	end
	if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and self.QCast == false then
		local StartPos 			= myHero.Position
		local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, 80, self.EDelay, 1)
		if CastPos ~= nil and Target ~= nil then
			if Target.AIData.IsDashing == true or Target.BuffData:HasBuffOfType(BuffType.Stun) == true or Target.BuffData:HasBuffOfType(BuffType.Slow) == true or Target.BuffData:HasBuffOfType(BuffType.Snare) == true then
				if self:GetDistance(StartPos, CastPos) < self.ERange then
					Engine:CastSpell("HK_SPELL3", CastPos ,1)
					return
				end
			end
		end
	end
	if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , math.huge, 0, self.QDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QChargeRange-200 then
				Engine:CastSpell("HK_SPELL1", CastPos ,1)
				return
			end
			if self.QCast == false then
				Engine:ChargeSpell("HK_SPELL1")
				self.QCast = true
			end
		end
	end	
end

function Xerath:OnTick()
	Xerath:CastingQ()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			self:Harass()
			return
		end

	end

end

function Xerath:OnDraw()
	if myHero.IsDead then return end
	
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMaxRange ,100,150,255,255)
        --Render:DrawCircle(myHero.Position, self.QChargeRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
	local RStartTime = myHero:GetSpellSlot(3).StartTime
	if RStartTime > 0 then
		Orbwalker:Disable()
		local MousePos = GameHud.MousePos
		Render:DrawCircle(MousePos,500,255,255,255,255)
		return
	end
	Orbwalker:Enable()
end


function Xerath:OnLoad()
    if(myHero.ChampionName ~= "Xerath") then return end
	AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)


	self:__init()
	AddEvent("OnTick", function() self:OnTick() end)	
	AddEvent("OnDraw", function() self:OnDraw() end)	
end

AddEvent("OnLoad", function() Xerath:OnLoad() end)	