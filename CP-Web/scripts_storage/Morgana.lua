require("SupportLib")

Morgana = {}
function Morgana:__init()	
	self.QRange = 1300

	self.WRange 	= 900
	self.WWidth 	= 275

	self.ERange = 800

	self.RRange = 625

	self.QWidth = 140

	self.QSpeed = 1200
	self.WSpeed = math.huge
	self.ESpeed = math.huge

	self.QDelay = 0.25
	self.WDelay = 0.25
	self.EDelay = 0

	self.QHitChance = 0.2
	self.WHitChance = 0.2


    self.ChampionMenu = Menu:CreateMenu("Morgana")
	-------------------------------------------
    self.QSettings 	= self.ChampionMenu:AddSubMenu("QSettings")
    self.QCombo 	= self.QSettings:AddCheckbox("UseQ on Combo", 1)
    self.QHarass 	= self.QSettings:AddCheckbox("UseQ on Harass", 1)
	self.WSettings	= self.ChampionMenu:AddSubMenu("WSettings")
	self.WCombo 	= self.WSettings:AddCheckbox("UseW on Combo", 1)
	self.WHarass 	= self.WSettings:AddCheckbox("UseW on Harass", 1)
	self.ESettings 	= self.ChampionMenu:AddSubMenu("ESettings")
	self.EOnCC 		= self.ESettings:AddCheckbox("UseE on CC", 1)
	self.ESettings:AddLabel("HP % for E Shield:")
	self.ETargets	= {}

	self.RSettings 	= self.ChampionMenu:AddSubMenu("RSettings")
	self.RCombo 	= self.RSettings:AddCheckbox("UseR", 1)
	self.RSlider 	= self.RSettings:AddSlider("R on min X enemies", 2, 1, 5, 1)	
	-------------------------------------------
	self.DrawSettings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawSettings:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawSettings:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawSettings:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawSettings:AddCheckbox("DrawR", 1)

	Morgana:LoadSettings()
end

function Morgana:SaveSettings()
	SettingsManager:CreateSettings("Morgana")
	SettingsManager:AddSettingsGroup("QSettings")
	SettingsManager:AddSettingsInt("QCombo", self.QCombo.Value)
	SettingsManager:AddSettingsInt("QHarass", self.QHarass.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
	SettingsManager:AddSettingsInt("WCombo", self.WCombo.Value)
	SettingsManager:AddSettingsInt("WHarass", self.WHarass.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("EOnCC", self.EOnCC.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("RSettings")
	SettingsManager:AddSettingsInt("RCombo", self.RCombo.Value)
	SettingsManager:AddSettingsInt("RSlider", self.RSlider.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Morgana:LoadSettings()
	SettingsManager:GetSettingsFile("Morgana")
	self.QCombo.Value = SettingsManager:GetSettingsInt("QSettings","QCombo")
	self.QHarass.Value = SettingsManager:GetSettingsInt("QSettings","QHarass")
	self.WCombo.Value = SettingsManager:GetSettingsInt("WSettings","WCombo")
	self.WHarass.Value = SettingsManager:GetSettingsInt("WSettings","WHarass")
	self.EOnCC.Value = SettingsManager:GetSettingsInt("ESettings","EOnCC")
	self.RCombo.Value = SettingsManager:GetSettingsInt("RSettings","RCombo")
	self.RSlider.Value = SettingsManager:GetSettingsInt("RSettings","RSlider")
	------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Morgana:Q()
	if Engine:SpellReady("HK_SPELL1") then
		local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
		if CastPos then
			return Engine:CastSpell("HK_SPELL1",CastPos, 0)
		end	
	end
end

function Morgana:GetExtendedWPosition(EndPos)
	local StartPos = myHero.Position
	
	local X = EndPos.x - StartPos.x
	local Y = EndPos.y - StartPos.y
	local Z = EndPos.z - StartPos.z

	local Length = math.max(1, math.sqrt((X^2)+(Y^2)+(Z^2)))
	local Normal = Vector3.new(X/Length,Y/Length,Z/Length)

	return Vector3.new(StartPos.x + (Normal.x * self.WRange), EndPos.y, StartPos.z + (Normal.z * self.WRange) )
end
function Morgana:W()
	if Engine:SpellReady("HK_SPELL2") then
		local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange + self.WWidth, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
		if CastPos then
			if SupportLib:GetDistance(myHero.Position, CastPos) > self.WRange then
				local ExtendedCastPos = self:GetExtendedWPosition(CastPos)
				return Engine:CastSpell("HK_SPELL2",ExtendedCastPos, 0)		
			else
				return Engine:CastSpell("HK_SPELL2",CastPos, 0)
			end
		end	
	end
end
function Morgana:E()
	if Engine:SpellReady("HK_SPELL3") then
		local Ally, Object = SupportLib:GetShieldTargetWithTable(self.ERange, self.ETargets)
		if Ally and Object then
			if Object.IsMissile then
				if Evade and Evade.Spells[Object.Name] and Evade.Spells[Object.Name].CC == 1 then
					return Engine:ReleaseSpell("HK_SPELL3",Ally.Position)
				end	
			end
			if Object.IsHero then
				local ActiveSpell = Object.ActiveSpell.Info.Name
				if string.len(ActiveSpell) > 0 then
					return Engine:ReleaseSpell("HK_SPELL3",Ally.Position)
				end			
			end
		end
	end
end
function Morgana:R()
	if Engine:SpellReady("HK_SPELL4") then
		local Enemies = SupportLib:GetEnemiesInRange(myHero.Position, self.RRange)
		if #Enemies >= self.RSlider.Value then
			return Engine:ReleaseSpell("HK_SPELL4",nil)
		end
	end
end

function Morgana:OnTick()
	local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.ETargets[Ally.Index] == nil then
			self.ETargets[Ally.Index] 		= self.ESettings:AddSlider(Ally.ChampionName , 100, 0, 100, 1)
		end
	end
	
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if self.EOnCC.Value == 1 then
			self:E()
		end
		if Engine:IsKeyDown("HK_COMBO") then
			if self.RCombo.Value == 1 then
				self:R()
			end
			if self.QCombo.Value == 1 then
				self:Q()
			end
			if self.WCombo.Value == 1 then
				self:W()
			end
		end
		if Engine:IsKeyDown("HK_HARASS") then
			if self.QHarass.Value == 1 then
				self:Q()
			end
			if self.WHarass.Value == 1 then
				self:W()
			end
		end
	end
end

function Morgana:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,255,200,55,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,0,255,0,255)
    end
	local RSlot = myHero:GetSpellSlot(3)
	local RLevel = RSlot.Level
	local RCooldown = RSlot.Cooldown - GameClock.Time
    if RLevel > 0 and RCooldown <= 0 and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end



function Morgana:OnLoad()
    if(myHero.ChampionName ~= "Morgana") then return end
	AddEvent("OnSettingsSave" , function() Morgana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Morgana:LoadSettings() end)


	Morgana:__init()
	AddEvent("OnTick", function() Morgana:OnTick() end)	
	AddEvent("OnDraw", function() Morgana:OnDraw() end)	
end

AddEvent("OnLoad", function() Morgana:OnLoad() end)	
