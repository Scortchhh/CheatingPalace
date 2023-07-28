require("SupportLib")

Karma = {}
function Karma:__init()
	self.QRange = 890
	self.WRange = 650
	self.ERange = 850
	self.RRange = 900

	self.QSpeed = 1700
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

    self.QWidth = 120

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

    self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Karma")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Q Settings")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ on Combo", 1)
	-------------------------------------------
	self.WSettings		= self.ChampionMenu:AddSubMenu("W Settings")
	self.ComboUseW	    = self.WSettings:AddCheckbox("UseW on Combo", 1)
	-------------------------------------------
	self.ESettings		= self.ChampionMenu:AddSubMenu("E Settings")
	self.UseEEnchant	= self.ESettings:AddCheckbox("UseE as Buff", 1)
	self.ESettings:AddLabel("HP % for E Shield:")
	self.ETargets		= {}
	-------------------------------------------
	self.RSettings 		= self.ChampionMenu:AddSubMenu("R Settings")
    self.ComboUseRQ 	= self.RSettings:AddCheckbox("UseRQ on Combo", 1)
    self.ComboUseRW 	= self.RSettings:AddCheckbox("UseRW on Combo", 1)
    self.ComboUseRE 	= self.RSettings:AddCheckbox("UseRE", 1)
    self.RESlider       = self.RSettings:AddSlider("Team HP % for RE" , 75, 0, 100, 1)
    -------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Karma:LoadSettings()
end

function Karma:SaveSettings()
	SettingsManager:CreateSettings("Karma")
	SettingsManager:AddSettingsGroup("QSettings")
	SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
    SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("UseEEnchant", self.UseEEnchant.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("RSettings")
    SettingsManager:AddSettingsInt("ComboUseRQ", self.ComboUseRQ.Value)
    SettingsManager:AddSettingsInt("ComboUseRW", self.ComboUseRW.Value)
    SettingsManager:AddSettingsInt("ComboUseRE", self.ComboUseRE.Value)
    SettingsManager:AddSettingsInt("RESlider", self.RESlider.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Karma:LoadSettings()
	SettingsManager:GetSettingsFile("Karma")
	self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
	-------------------------------------------------------------
	self.ComboUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWCombo")
	-------------------------------------------------------------
	self.UseEEnchant.Value		= SettingsManager:GetSettingsInt("ESettings","UseEEnchant")
	-------------------------------------------------------------
	self.ComboUseRQ.Value		= SettingsManager:GetSettingsInt("RSettings","ComboUseRQ")
	self.ComboUseRW.Value		= SettingsManager:GetSettingsInt("RSettings","ComboUseRW")
	self.ComboUseRE.Value		= SettingsManager:GetSettingsInt("RSettings","ComboUseRE")
    self.RESlider.Valdue        = SettingsManager:GetSettingsInt("RSettings","RESlider")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

------------------------------------------------------------------------------------------
function Karma:Q()
	if self.ComboUseQ.Value == 1 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
		if PredPos then
			return true, PredPos
		end
	end
    return false
end
function Karma:RQ()
    if self.ComboUseRQ.Value == 1 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
        if PredPos then
            return true, PredPos
        end    
    end
    return false
end
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
function Karma:W()
	if self.ComboUseW.Value == 1 then
		local Target = Orbwalker:GetTarget("Combo", self.WRange)
		if Target then
			return true, Target.Position
		end
	end
    return false
end
function Karma:RW()
	if self.ComboUseRW.Value == 1 then
        local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
        if HPPercent < 20 then 
            local Target = Orbwalker:GetTarget("Combo", self.WRange)
            if Target then
                return true, Target.Position
            end                  
        end
    end
    return false
end
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
function Karma:E()
    local ShieldTarget = SupportLib:GetShieldTargetWithTable(self.ERange, self.ETargets)
    if ShieldTarget then
        return true, ShieldTarget.Position
    end
    if self.UseEEnchant.Value == 1 then
        local Target = SupportLib:GetBuffTarget(self.ERange)
        if Target then
            local ETargets = SupportLib:GetAlliesInRange(myHero.Position, self.ERange)
            if #ETargets > 1 then
                if Target.Index ~= myHero.Index then
                    return true, Target.Position
                end
            else
                return true, Target.Position
            end
        end	
    end
    return false
end
function Karma:RE()
    if self.ComboUseRE.Value == 1 then      
        local Enemies  = SupportLib:GetEnemiesInRange(myHero.Position, 1500)    
        local ETargets = SupportLib:GetAlliesInRange(myHero.Position, self.ERange)
        ETargets = SupportLib:SortList(ETargets, "HP")

        local MaxHealthTeam = 0
        local CurrentHealthTeam = 0
        for _, Target in pairs(ETargets) do
            MaxHealthTeam = MaxHealthTeam + Target.MaxHealth
            CurrentHealthTeam = CurrentHealthTeam + Target.Health
        end

        local TeamHPPercentage = (CurrentHealthTeam / MaxHealthTeam) * 100
        if TeamHPPercentage <= self.RESlider.Value and #ETargets > 1 and #Enemies > 2 then
            local Target = SupportLib:GetShieldTarget(self.ERange, 100)
            if Target then
                return true, Target.Position
            end
        end
    end
    return false
end
------------------------------------------------------------------------------------------

function Karma:OnTick()
	local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.ETargets[Ally.Index] == nil then
			self.ETargets[Ally.Index] 		= self.ESettings:AddSlider(Ally.ChampionName , 100, 0, 100, 1)
		end
	end
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
        local RActivated = myHero.BuffData:GetBuff("KarmaMantra").Count_Alt > 0
           
        local Q, QCastPos = self:Q()
        local W, WCastPos = self:W()
        local E, ECastPos = self:E()

        local RQ, RQCastPos = self:RQ()
        local RW, RWCastPos = self:RW()
        local RE, RECastPos = self:RE()
        
        if Engine:SpellReady("HK_SPELL3") then
            if RActivated then
                if RE == true then
                    return Engine:CastSpell("HK_SPELL3", RECastPos, 1)
                end
            else
                if RE == true and Engine:SpellReady("HK_SPELL4") then
                    return Engine:ReleaseSpell("HK_SPELL4", nil)
                else
                    if E == true then
                        return Engine:CastSpell("HK_SPELL3", ECastPos, 1)
                    end  
                end
            end
        end

        if Engine:IsKeyDown("HK_COMBO") then	
            if Engine:SpellReady("HK_SPELL2") then
                if RActivated then
                    if RW == true and RE == false then
                        return Engine:CastSpell("HK_SPELL2", RWCastPos, 1)
                    end
                else
                    if RW == true and Engine:SpellReady("HK_SPELL4") then
                        return Engine:ReleaseSpell("HK_SPELL4", nil)
                    else
                        if W == true then
                            return Engine:CastSpell("HK_SPELL2", WCastPos, 1)  
                        end
                    end
                end
            end
            if Engine:SpellReady("HK_SPELL1") then
                if RActivated then
                    if RQ == true and RW == false and RE == false then
                        return Engine:CastSpell("HK_SPELL1", RQCastPos, 0)
                    end
                else
                    if RQ == true and Engine:SpellReady("HK_SPELL4") then
                        return Engine:ReleaseSpell("HK_SPELL4", nil)
                    else
                        if Q == true then
                            return Engine:CastSpell("HK_SPELL1", QCastPos, 0)
                        end 
                    end
                end
            end
        end
    end
end

function Karma:OnDraw()
	if myHero.IsDead then return end
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

function Karma:OnLoad()
    if(myHero.ChampionName ~= "Karma") then return end
	AddEvent("OnSettingsSave" , function() Karma:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Karma:LoadSettings() end)


	Karma:__init()
	AddEvent("OnTick", function() Karma:OnTick() end)	
	AddEvent("OnDraw", function() Karma:OnDraw() end)	
end

AddEvent("OnLoad", function() Karma:OnLoad() end)