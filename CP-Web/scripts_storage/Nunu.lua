Nunu = {}
function Nunu:__init()
	self.ERange = 690

	self.ESpeed = math.huge

	self.EWidth = 80

	self.EDelay = 0

	self.EHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Nunu")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	-------------------------------------------
    self.LaneclearMenu 	= self.ChampionMenu:AddSubMenu("Laneclear")
    self.LaneUseQ 		= self.LaneclearMenu:AddCheckbox("UseQ", 1)
    self.LaneUseE 		= self.LaneclearMenu:AddCheckbox("UseE", 1)

	self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawE 			= self.ComboMenu:AddCheckbox("DrawE", 1)
	
	Nunu:LoadSettings()
end

function Nunu:SaveSettings()
	SettingsManager:CreateSettings("Nunu")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Laneclear")
	SettingsManager:AddSettingsInt("UseQ", self.LaneUseQ.Value)
	SettingsManager:AddSettingsInt("UseE", self.LaneUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Nunu:LoadSettings()
	SettingsManager:GetSettingsFile("Nunu")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	-------------------------------------------------------------
	self.LaneUseQ.Value = SettingsManager:GetSettingsInt("Laneclear","UseQ")
	self.LaneUseE.Value = SettingsManager:GetSettingsInt("Laneclear","UseE")
	-------------------------------------------------------------
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Nunu:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Nunu:Combo()
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local StartPos = myHero.Position
		local CastPos = Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.ERange then
				Engine:CastSpell("HK_SPELL3", CastPos ,1)
				return
			end
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.ResetReady == 1 then
		local Target = Orbwalker:GetTarget("Combo", myHero.AttackRange + myHero.CharData.BoundingRadius)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position ,1)
			return
		end
	end
end

function Nunu:Laneclear()
	if self.LaneUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL3", Target.Position ,1)
			return
		end
	end
	if self.LaneUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.ResetReady == 1 then
		local Target = Orbwalker:GetTarget("Laneclear", myHero.AttackRange + myHero.CharData.BoundingRadius)
		if Target ~= nil then
			Engine:CastSpell("HK_SPELL1", Target.Position ,1)
			return
		end
	end
end

function Nunu:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			Nunu:Combo()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Nunu:Laneclear()
			return
		end
	end
end

function Nunu:OnDraw()
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
end



function Nunu:OnLoad()
    if(myHero.ChampionName ~= "Nunu") then return end
	AddEvent("OnSettingsSave" , function() Nunu:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nunu:LoadSettings() end)


	Nunu:__init()
	AddEvent("OnTick", function() Nunu:OnTick() end)	
	AddEvent("OnDraw", function() Nunu:OnDraw() end)	
end

AddEvent("OnLoad", function() Nunu:OnLoad() end)	
