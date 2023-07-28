LeeSin = {}


--Version 1.11
--Last updated by Derang3d
--added lane clear options q/w/e added R KS

function LeeSin:__init()	
	self.QRange = 1200
	self.WRange = 700
	self.ERange = 420
	self.RRange = 375

	self.QSpeed = 1800
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 120

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

	self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("LeeSin")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
	self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	self.ComboUseR = self.ComboMenu:AddCheckbox("Use R KS", 1)
	
	self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
	self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 

	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	LeeSin:LoadSettings()
end

function LeeSin:SaveSettings()
	SettingsManager:CreateSettings("LeeSin")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("Use R KS", self.ComboUseR.Value)

	SettingsManager:AddSettingsGroup("LaneClear")
	SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
	SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
	
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function LeeSin:LoadSettings()
	SettingsManager:GetSettingsFile("LeeSin")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","Use R KS")

	self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
	self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
	self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
	
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function LeeSin:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function LeeSin:RKS()

	local RDamage = {175, 400, 625}
	local RLevel = myHero:GetSpellSlot(3).Level
	local RRdmg = RDamage[RLevel]

    if self.ComboUseR.Value == 1 and Engine:SpellReady('HK_SPELL4') then 
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then 
                if self:GetDistance(myHero.Position, target.Position) <= self.RRange then
                    local Leeult = GetDamage( RRdmg + (myHero.BonusAttack * 2), true, target)
                    if Leeult >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end

end

function LeeSin:Combo()
	local Passive = myHero.BuffData:GetBuff("blindmonkpassive_cosmetic")
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local QName = myHero:GetSpellSlot(0).Info.Name
		if QName == "BlindMonkQOne" then
			if self.ComboUseQ.Value == 1 then
				local StartPos 	= myHero.Position
				local CastPos 	= Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
				if CastPos ~= nil then
					if self:GetDistance(StartPos, CastPos) < self.QRange then
						Engine:CastSpell("HK_SPELL1", CastPos ,1)
						return
					end
				end
			end
		end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Combo", self.ERange)
		if Passive.Count_Alt == 0 and Target then
			Engine:CastSpell("HK_SPELL3", nil , 0)
			return
		end
	end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local Target = Orbwalker:GetTarget("Combo", self.ERange)
		if Passive.Count_Alt == 0 and Target then
			Engine:CastSpell("HK_SPELL2", myHero.Position , 1)
			return
		end
	end
end

function LeeSin:Laneclear()
	local Passive = myHero.BuffData:GetBuff("blindmonkpassive_cosmetic") 
	if Engine:SpellReady("HK_SPELL2") then
		if self.ClearW.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
			if Target then
				if Passive.Count_Alt == 0 then
					Engine:CastSpell("HK_SPELL2", myHero.Position , 1)
					return
				end
			end
		end
    end
    if Engine:SpellReady("HK_SPELL3") then
		if self.ClearE.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
			if Target then
				if Passive.Count_Alt == 0  then
					Engine:CastSpell("HK_SPELL3", nil , 0)
					return
				end
			end
		end
    end
	if Engine:SpellReady("HK_SPELL1") then
		if self.ClearQ.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
			if Target then
				if Passive.Count_Alt == 0 then
					Engine:CastSpell("HK_SPELL1", Target.Position , 1)
					return
				end
			end
		end
    end
end


function LeeSin:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
		LeeSin:RKS()
		if Engine:IsKeyDown("HK_COMBO") then
			LeeSin:Combo()
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
            LeeSin:Laneclear()
		end
	end
end

function LeeSin:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
end



function LeeSin:OnLoad()
    if(myHero.ChampionName ~= "LeeSin") then return end
	AddEvent("OnSettingsSave" , function() LeeSin:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() LeeSin:LoadSettings() end)


	LeeSin:__init()
	AddEvent("OnTick", function() LeeSin:OnTick() end)	
	AddEvent("OnDraw", function() LeeSin:OnDraw() end)	
end

AddEvent("OnLoad", function() LeeSin:OnLoad() end)	
