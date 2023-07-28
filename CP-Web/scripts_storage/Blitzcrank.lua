Blitzcrank = {}
function Blitzcrank:__init()
	self.QRange = 1100
	self.WRange = 0
	self.ERange = 0
	self.RRange = 600

	self.QSpeed = 1800
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 140

	self.QDelay = 0
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0.25

	self.QHitChance = 0.45

    self.ChampionMenu = Menu:CreateMenu("Blitzcrank")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)

	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)
	Blitzcrank:LoadSettings()
end

function Blitzcrank:SaveSettings()
	SettingsManager:CreateSettings("Blitzcrank")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Blitzcrank:LoadSettings()
	SettingsManager:GetSettingsFile("Blitzcrank")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Blitzcrank:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Blitzcrank:CastRToEnemyBase()
	Engine:CastSpellMap("HK_SPELL4", self.EnemyBase ,1)
end

function Blitzcrank:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local MagicResistMod			= 100 / (100 + Target.MagicResist)
	local RLevel 					= myHero:GetSpellSlot(3).Level
	local DMG 						= 125 + (125 * RLevel) + (myHero.AbilityPower * 1.0) 
	return DMG * MagicResistMod
end

function Blitzcrank:Combo()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local Target = Orbwalker:GetTarget("Combo", self.RRange)
		if Target ~= nil then
			local DMG = self:GetRDamage(Target)
			if DMG > Target.Health then
				Engine:CastSpell("HK_SPELL4", nil ,1)
				return
			end
		end
	end

	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Range = myHero.AttackRange + myHero.CharData.BoundingRadius
		local Target = Orbwalker:GetTarget("Combo", Range)
		if Target ~= nil and Orbwalker.ResetReady == 1 then
			Engine:CastSpell("HK_SPELL3", nil ,1)
			return
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos = myHero.Position
		local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
		if PredPos ~= nil then
			if self:GetDistance(StartPos, PredPos) < self.QRange then
				Engine:CastSpell("HK_SPELL1", PredPos ,1)
				return
			end
		end
	end
end

function Blitzcrank:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
		if Engine:IsKeyDown("HK_COMBO") then
			Blitzcrank:Combo()
			return
		end
	end
end

function Blitzcrank:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
	end
	local StartPos = myHero.Position
	local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
	if PredPos ~= nil then
		if self:GetDistance(StartPos, PredPos) < self.QRange then
			Render:DrawCircle(PredPos, 100,100,150,255,255)
			return
		end
	end
end



function Blitzcrank:OnLoad()
    if(myHero.ChampionName ~= "Blitzcrank") then return end
	AddEvent("OnSettingsSave" , function() Blitzcrank:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Blitzcrank:LoadSettings() end)


	Blitzcrank:__init()
	AddEvent("OnTick", function() Blitzcrank:OnTick() end)	
	AddEvent("OnDraw", function() Blitzcrank:OnDraw() end)	
end

AddEvent("OnLoad", function() Blitzcrank:OnLoad() end)	
