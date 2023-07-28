Olaf = {}
function Olaf:__init()	
	self.QRange = 1000
	self.WRange = 0
	self.ERange = 325
	self.RRange = 600

	self.QSpeed = 1600
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 180

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

	self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Olaf")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)

	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	self:LoadSettings()
end

function Olaf:SaveSettings()
	SettingsManager:CreateSettings("Olaf")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Olaf:LoadSettings()
	SettingsManager:GetSettingsFile("Olaf")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Olaf:GetDistance(source, target)
    return math.sqrt(((target.x - source.x) ^ 2) + ((target.z - source.z) ^ 2))
end

function Olaf:GetQCastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Olaf:Combo()
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1 then
		local Target = Orbwalker:GetTarget("Combo", self.ERange)
		if Target ~= nil and Orbwalker.Attack == 0 then
			Engine:CastSpell("HK_SPELL3", Target.Position ,1)
			return
		end
	end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local Target = Orbwalker:GetTarget("Combo", myHero.AttackRange + myHero.CharData.BoundingRadius)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL2", nil ,1)
			return
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 				= myHero.Position
		local CastPos, Target 		= Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
		if CastPos ~= nil and Target ~= nil then
			CastPos = self:GetQCastPos(CastPos)
			local Distance = self:GetDistance(StartPos, Target.Position)
			if Distance < myHero.AttackRange + myHero.CharData.BoundingRadius then
				if Orbwalker.ResetReady == 1 then
					if self:GetDistance(StartPos, CastPos) < self.QRange then
						Engine:CastSpell("HK_SPELL1", CastPos ,1)
						return
					end
				end
			else
				if self:GetDistance(StartPos, CastPos) < self.QRange then
					Engine:CastSpell("HK_SPELL1", CastPos ,1)
					return
				end
			end
		end
	end
end

function Olaf:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
			return
		end
	end
end

function Olaf:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
end

function Olaf:OnLoad()
    if(myHero.ChampionName ~= "Olaf") then return end
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

	Olaf:__init()
	AddEvent("OnTick", function() self:OnTick() end)
	AddEvent("OnDraw", function() self:OnDraw() end)
end

AddEvent("OnLoad", function() Olaf:OnLoad() end)	
