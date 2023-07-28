--Credits to Critic, Scortch, Christoph
Sejuani = {} 

function Sejuani:__init() 

    
    self.QRange = 650
    self.WRange = 600
    self.ERange = 600
    self.RRange = 1300

    self.QSpeed = 1000 
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.QWidth = 100
    self.WWidth = 100

    self.QDelay = 0
    self.WDelay = 1
    self.EDelay = 0.25
    self.RDelay = 0.25

    self.QHitChance = 0.2
    self.WHitChance = 0.2

    self.ScriptVersion = "         Sejuani Ver: 1.1 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Sejuani") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R to KS", 1) 
    self.ComboMenu:AddLabel("R usage")
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R on grouped enemies", 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)
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
    --------------------------------------------
    Sejuani:LoadSettings()  
end 

function Sejuani:SaveSettings() 

    SettingsManager:CreateSettings("Sejuani")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R to KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R on grouped enemies", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)
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

function Sejuani:LoadSettings()
    SettingsManager:GetSettingsFile("Sejuani")
     --------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R to KS")
    self.ComboRR.Value = SettingsManager:GetSettingsInt("Combo", "Use R on grouped enemies")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")    
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

----ultimate-----
function Sejuani:Ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) >= 400 then
                    if GetDist(myHero.Position, target.Position) <= 1300 then
                        local LissR = GetDamage(50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.8), false, target)
                        if LissR >= target.Health then
                            Engine:CastSpell('HK_SPELL4', target.Position, 1)
                            return
                        end
                    end
                end
            end
        end

        if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1 then
            local target = Orbwalker:GetTarget("Combo", self.RRange)
            if target ~= nil then
                if EnemiesInRange(target.Position, 650) > self.ComboRSlider.Value then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end
end
----------

-----combo-----
--SejuaniE
--SejuaniEMarkerMax

function Sejuani:Combo()

    local buff1 = myHero.BuffData:GetBuff("SejuaniEMarkerMax")

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 0)
            return
        end
    end

end


function Sejuani:Harass()

    local buff1 = myHero.BuffData:GetBuff("SejuaniEMarkerMax")

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") and buff1.Valid == true then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 0)
            return
        end
    end

end

function Sejuani:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 0)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", target.Position, 0)
                    return
                end
            end
        end
    end


end

--end---


function Sejuani:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Sejuani:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Sejuani:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sejuani:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sejuani:Laneclear()
		end
	end
end

function Sejuani:OnDraw()
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
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Sejuani:OnLoad()
    if(myHero.ChampionName ~= "Sejuani") then return end
	AddEvent("OnSettingsSave" , function() Sejuani:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sejuani:LoadSettings() end)


	Sejuani:__init()
	AddEvent("OnTick", function() Sejuani:OnTick() end)	
    AddEvent("OnDraw", function() Sejuani:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Sejuani:OnLoad() end)	
