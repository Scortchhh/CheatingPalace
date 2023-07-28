require("SupportLib")

Janna = {}
function Janna:__init()
	self.QRange = 1000
	self.WRange = 625
	self.ERange = 800
	self.RRange = 700

	self.QSpeed = 1700
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

    self.ChampionMenu = Menu:CreateMenu("Janna")
	-------------------------------------------
    self.QSettings 		= self.ChampionMenu:AddSubMenu("QSettings")
    self.UseQGapclose 	= self.QSettings:AddCheckbox("UseQ on Gapclose", 1)
	-------------------------------------------
	self.WSettings		= self.ChampionMenu:AddSubMenu("W Settings")
    self.UseWCombo      = self.WSettings:AddCheckbox("UseW on Combo", 1)
    self.UseWDeEnchant	= self.WSettings:AddCheckbox("UseW on buffed Enemy", 1)
	self.UseWGapclose	= self.WSettings:AddCheckbox("UseW on Gapclose", 1)
	-------------------------------------------
	self.ESettings		= self.ChampionMenu:AddSubMenu("E Settings")
	self.UseEEnchant	= self.ESettings:AddCheckbox("UseE as Buff", 1)
	self.ESettings:AddLabel("HP % for E Shield:")
	self.ETargets		= {}
	-------------------------------------------
	self.RSettings 		= self.ChampionMenu:AddSubMenu("Ultimate")
	self.UseRGapclose	= self.RSettings:AddCheckbox("UseR on Gapclose", 1)
	self.RSettings:AddLabel("HP % for R Save:")
	self.RTargets		= {}
	-------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Janna:LoadSettings()
end

function Janna:SaveSettings()
	SettingsManager:CreateSettings("Janna")
	SettingsManager:AddSettingsGroup("QSettings")
	SettingsManager:AddSettingsInt("UseQGapclose", self.UseQGapclose.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
	SettingsManager:AddSettingsInt("UseWCombo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("UseWDeEnchant", self.UseWDeEnchant.Value)
	SettingsManager:AddSettingsInt("UseWGapclose", self.UseWGapclose.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("UseEEnchant", self.UseEEnchant.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("RSettings")
	SettingsManager:AddSettingsInt("UseRGapclose", self.UseRGapclose.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Janna:LoadSettings()
	SettingsManager:GetSettingsFile("Janna")
	-------------------------------------------------------------
    self.UseQGapclose.Value     = SettingsManager:GetSettingsInt("QSettings","UseQGapclose")
    self.UseWCombo.Value	    = SettingsManager:GetSettingsInt("WSettings","UseWCombo")
    self.UseWDeEnchant.Value	= SettingsManager:GetSettingsInt("WSettings","UseWDeEnchant")
	self.UseWGapclose.Value		= SettingsManager:GetSettingsInt("WSettings","UseWGapclose")
	-------------------------------------------------------------
	self.UseEEnchant.Value		= SettingsManager:GetSettingsInt("ESettings","UseEEnchant")
	-------------------------------------------------------------
	self.UseRGapclose.Value		= SettingsManager:GetSettingsInt("RSettings","UseRGapclose")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")

end

function Janna:W()
    if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if Target then
            return Engine:CastSpell("HK_SPELL2", Target.Position, 1)
        end
    end
end

function Janna:AntiGapclose()
    if self.UseQGapclose.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Enemy, Ally = SupportLib:GetAntiGapCloseTarget(self.QRange, 300)
        if Enemy then
            return Engine:CastSpell("HK_SPELL1", Enemy.AIData.TargetPos, 1)
        end
    end
    if Engine:SpellReady("HK_SPELL2") then
		local Target = nil
		if self.UseWDeEnchant.Value == 1 then
			Target = SupportLib:GetDebuffTarget(self.WRange)
		end
		if self.UseWGapclose == 1 then
			Target = SupportLib:GetAntiGapCloseTarget(self.WRange, 300)
		end
		if Target then
			return Engine:CastSpell("HK_SPELL2", Target.Position, 1)
		end
	end
    if self.UseRGapclose.Value == 1 then
        if self.UseWGapclose.Value == 0 or Engine:SpellReady("HK_SPELL1") == false then
            local Enemy, Ally = SupportLib:GetAntiGapCloseTarget(self.RRange, 450)
            if Ally then
                return Engine:CastSpell("HK_SPELL4", Ally.Position, 1)
            end		
        end
    end
end

function Janna:E()
	if Engine:SpellReady("HK_SPELL3") then
		local ShieldTarget = SupportLib:GetShieldTargetWithTable(self.ERange, self.ETargets)
		if ShieldTarget then
			return Engine:CastSpell("HK_SPELL3", ShieldTarget.Position, 1)
		end
		if self.UseEEnchant.Value == 1 then
			local Target = SupportLib:GetBuffTarget(self.ERange)
			if Target then
				return Engine:CastSpell("HK_SPELL3", Target.Position, 1)
			end	
		end
	end
end

function Janna:R()
	if Engine:SpellReady("HK_SPELL4") then
		local ShieldTarget = SupportLib:GetShieldTargetWithTable(self.RRange, self.RTargets)
		if ShieldTarget then
			Orbwalker:Disable()
			return Engine:CastSpell("HK_SPELL4", ShieldTarget.Position, 1)
		end
		if self.UseRGapclose.Value == 1 then
			if self.UseWGapclose.Value == 0 or Engine:SpellReady("HK_SPELL2") == false then
				local Enemy, Ally = SupportLib:GetAntiGapCloseTarget(self.RRange, 450)
				if Ally then
					Orbwalker:Disable()
					return Engine:CastSpell("HK_SPELL4", Ally.Position, 1)
				end		
			end
		end
	end
end

function Janna:OnTick()
	local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.ETargets[Ally.Index] == nil then
			self.ETargets[Ally.Index] 		= self.ESettings:AddSlider(Ally.ChampionName , 100, 0, 100, 1)
		end
		if string.len(Ally.ChampionName) > 1 and self.RTargets[Ally.Index] == nil then
			self.RTargets[Ally.Index] 		= self.RSettings:AddSlider(Ally.ChampionName , 50, 0, 100, 1)
		end
	end
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		self:E()
        self:AntiGapclose()
		if Engine:IsKeyDown("HK_COMBO") then	
            self:W()
            self:R()
		end
	end
end

function Janna:OnDraw()
	if myHero.IsDead then return end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
    local RStartTime = myHero:GetSpellSlot(3).StartTime
	if RStartTime > 0 then
		Orbwalker:Disable()
		return
	end
	Orbwalker:Enable()
end

function Janna:OnLoad()
    if(myHero.ChampionName ~= "Janna") then return end
	AddEvent("OnSettingsSave" , function() Janna:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Janna:LoadSettings() end)


	Janna:__init()
	AddEvent("OnTick", function() Janna:OnTick() end)	
	AddEvent("OnDraw", function() Janna:OnDraw() end)	
end

AddEvent("OnLoad", function() Janna:OnLoad() end)