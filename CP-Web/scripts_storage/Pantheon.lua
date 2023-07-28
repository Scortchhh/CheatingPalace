--Credits to Critic, Scortch, Christoph

Pantheon = {} 

function Pantheon:__init() 

    self.QCast = false

    self.QRange = 575
    self.QMaxRange = 1200
    self.WRange = 600
    self.ERange = 525
    self.RRange = 5500 

    self.QSpeed = 2700 
    self.WSpeed = 0
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QWidth = 120
    self.EWidth = 100
    self.RWidth = 450

    self.QDelay = 0.25
    self.EDelay = 0
    self.RDelay = 0.1

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ScriptVersion = "         dPantheon Ver: 1.01 CREDITS Derang3d" 

  

    self.ChampionMenu = Menu:CreateMenu("Pantheon") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("R KS", 1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    -------------------------------------------
    
    Pantheon:LoadSettings() 
end

function Pantheon:SaveSettings() -- this is the save settings for Pantheon.
    --save settings from menu--

    --combo save settings--
    SettingsManager:CreateSettings("Pantheon")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Pantheon:LoadSettings()
    SettingsManager:GetSettingsFile("Pantheon")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS") 
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Pantheon:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
	local Count = 0 
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

-----combo-----

function Pantheon:CastingQ()
	local QStartTime = myHero:GetSpellSlot(0).StartTime
	local QChargeTime = GameClock.Time - QStartTime
	local QCharge = myHero.ActiveSpell.Info.Name
	if QCharge == "PantheonQ" then
		self.QRange = 750 + (500*QChargeTime)
 		if self.QRange < 750 then self.QRange = 750 end
		if self.QRange > 1400 then self.QRange = 1400 end
	else
		self.QRange = 750
		self.QCast = false
	end
	if Engine:IsKeyDown("HK_SPELL1") == true and Engine:SpellReady("HK_SPELL1") == false then
		Engine:ReleaseSpell("HK_SPELL1", nil)
		self.QCast = false
	end
end



function Pantheon:ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 5500 then
                    local Panthdmg = (100 + (200 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 1))
                    if Panthdmg >= target.Health then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                        if PredPos then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end
end

function Pantheon:Combo()

    local buff1 = myHero.BuffData:GetBuff("PantheonE")
    local buff2 = myHero.BuffData:GetBuff("PantheonPassiveReady")

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
        if target then
            if buff2.Count_Alt == 0 or EnemiesInRange(myHero.Position, 650) < 1 then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if GetDist(StartPos, CastPos) < self.QRange-300 then
                        Engine:ReleaseSpell("HK_SPELL1", CastPos)
                        return
                    end
                    if self.QCast == false then
                        Engine:ChargeSpell("HK_SPELL1")
                        self.QCast = true
                         return
                    end
                end
            end
        end
    end
        local MWDmg = {20,32,45,58,71,84,97,110,123,136,149,162,175,188,201,214,227,240}
        local Level = GetMyLevel()
        local WMDDmg = MWDmg[Level]
        local QDmg = (40 + (35 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 1))
        local QQDmg = WMDDmg + QDmg

        if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff2.Count_Alt > 0 then
            local target = Orbwalker:GetTarget("Combo", self.QMaxRange)
            if target then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if QQDmg >= target.Health then
                        if GetDist(StartPos, CastPos) < self.QRange-300 then
                            Engine:ReleaseSpell("HK_SPELL1", CastPos)
                            return
                        end
                    end
                    if self.QCast == false then
                        if QQDmg >= target.Health then
                            Engine:ChargeSpell("HK_SPELL1")
                            self.QCast = true
                            return
                        end
                    end
                end
            end
        end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
            return
        end
    end

    
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3")  and buff1.Count_Alt == 0 and (buff2.Count_Alt == 0 or not Engine:SpellReady("HK_SPELL2"))  then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target and not target.BuffData:HasBuffOfType(5)  then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

end



function Pantheon:Harass()

    local buff1 = myHero.BuffData:GetBuff("PantheonE")
    local buff2 = myHero.BuffData:GetBuff("PantheonPassiveReady")

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QMaxRange)
        if target then
            if buff2.Valid == false then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if GetDist(StartPos, CastPos) < self.QRange-300 then
                        Engine:ReleaseSpell("HK_SPELL1", CastPos)
                        return
                    end
                    if self.QCast == false then
                        Engine:ChargeSpell("HK_SPELL1")
                        self.QCast = true
                         return
                    end
                end
            end
        end
    end
        local MWDmg = {20,32,45,58,71,84,97,110,123,136,149,162,175,188,201,214,227,240}
        local Level = GetMyLevel()
        local WMDDmg = MWDmg[Level]
        local QDmg = (40 + (35 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 1))
        local QQDmg = WMDDmg + QDmg

        if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff2.Count_Alt > 0 then 
            local target = Orbwalker:GetTarget("Harass", self.QMaxRange)
            if target then
                local StartPos 	= myHero.Position
                local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos ~= nil then
                    if QQDmg >= target.Health then
                        if GetDist(StartPos, CastPos) < self.QRange-300 then
                            Engine:ReleaseSpell("HK_SPELL1", CastPos)
                            return
                        end
                    end
                    if self.QCast == false then
                        if QQDmg >= target.Health then
                            Engine:ChargeSpell("HK_SPELL1")
                            self.QCast = true
                            return
                        end
                    end
                end
            end
        end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
            return
        end
    end

    
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3")  and buff1.Count_Alt == 0 and (buff2.Count_Alt == 0 or not Engine:SpellReady("HK_SPELL2")) then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target and not target.BuffData:HasBuffOfType(5)  then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end


end

function Pantheon:Laneclear()

    local buff1 = myHero.BuffData:GetBuff("PantheonE")

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    local sliderValue = self.LClearSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                        return
                    end
                end
            end
        end
    end

    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.WRange  then
                    local sliderValue = self.LClearSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL2", Minion.Position, 0)
                        return
                    end
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") and buff1.Count_Alt == 0 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.ERange then
                    local sliderValue = self.LClearSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL3", Minion.Position, 0)
                        return
                    end
                end
            end
        end
    end

end

function Pantheon:OnTick()
    
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            Pantheon:ultimate()
            Pantheon:CastingQ()
        if Engine:IsKeyDown("HK_COMBO") then        
            Pantheon:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Pantheon:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Pantheon:Laneclear()
		end
	end
end

function Pantheon:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMaxRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Pantheon:OnLoad()
    if(myHero.ChampionName ~= "Pantheon") then return end
	AddEvent("OnSettingsSave" , function() Pantheon:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Pantheon:LoadSettings() end)


	Pantheon:__init()
	AddEvent("OnTick", function() Pantheon:OnTick() end)	
    AddEvent("OnDraw", function() Pantheon:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Pantheon:OnLoad() end)	
