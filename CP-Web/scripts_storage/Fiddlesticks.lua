--Credits to Critic, Scortch, Christoph

FiddleSticks = {} 

function FiddleSticks:__init() 

    self.UsingW = false
    self.QRange = 575
    self.WRange = 575
    self.ERange = 850
    self.RRange = 800

    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.EWidth = 100

    self.EDelay = 0.4
    self.RDelay = 0.25    

    self.EHitChance = 0.5

    self.ChampionMenu = Menu:CreateMenu("FiddleSticks") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R on X enemies", 1) 
    self.REnemyCount = self.ComboMenu:AddSlider("Minimum amount of enemies to R", 3,1,5,1)
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
    FiddleSticks:LoadSettings()  
end 

function FiddleSticks:SaveSettings() 

    SettingsManager:CreateSettings("FiddleSticks")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R on X enemies", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Minimum amount of enemies to R", self.REnemyCount.Value)
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

function FiddleSticks:LoadSettings()
    SettingsManager:GetSettingsFile("FiddleSticks")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R on X enemies")
    self.REnemyCount.Value = SettingsManager:GetSettingsInt("Combo", "Minimum amount of enemies to R")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
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

function unpack (t, i)
    i = i or 1
    if t[i] ~= nil then
      return t[i], unpack(t, i + 1)
    end
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

function FiddleSticks:Ultimate()

    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 800 then
                if EnemiesInRange(target.Position, 600) > self.REnemyCount.Value then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end
end

function FiddleSticks:Combo()

    local WStartTime = myHero:GetSpellSlot(1).StartTime
    if WStartTime > 0 then
        return
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
                return
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local target = Orbwalker:GetTarget("Combo", self.WRange)
            if target then
                if GetDist(myHero.Position, target.Position) <= self.WRange then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end
end



function FiddleSticks:Harass()
    FiddleSticks:Ultimate()

    if self.UsingW == false then

        if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local target = Orbwalker:GetTarget("Harass", self.QRange)
            if target then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
			    if myHero.Mana >= condition then
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                end
            end
        end
    
        if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local target = Orbwalker:GetTarget("Harass", self.ERange)
            if target then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
			    if myHero.Mana >= condition then
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
    end

    if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
        if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local target = Orbwalker:GetTarget("Harass", self.WRange)
            if target then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
			    if myHero.Mana >= condition then
                    if GetDist(myHero.Position, target.Position) <= self.WRange then
                        Orbwalker.Enabled = 0
                        self.UsingW = true
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        FiddleSticks:SetOrbActive()
                        return
                    end
                end
            end
        end
    end
end

function FiddleSticks:Laneclear()

    FiddleSticks:Ultimate()

    if self.UsingW == false then

        
        if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local target = Orbwalker:GetTarget("Laneclear", self.QRange)
            if target then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL1", target.Position, 0)
                        return
                    end
                end

            end
        end
    
        if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local target = Orbwalker:GetTarget("Laneclear", self.ERange)
            if target then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if GetDist(myHero.Position, target.Position) <= self.QRange then
                        Engine:CastSpell("HK_SPELL3", target.Position, 0)
                        return
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local target = Orbwalker:GetTarget("Laneclear", self.WRange)
            if target then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if GetDist(myHero.Position, target.Position) <= self.WRange then
                        Orbwalker.Enabled = 0
                        self.UsingW = true
                        Engine:CastSpell("HK_SPELL2", target.Position, 0)
                        FiddleSticks:SetOrbActive()
                        return
                    end
                end
            end
        end
    end
end

--end---


function FiddleSticks:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        FiddleSticks:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            FiddleSticks:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            FiddleSticks:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            FiddleSticks:Laneclear()
		end
	end
end

function FiddleSticks:OnDraw()

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
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

    local WStartTime = myHero:GetSpellSlot(1).StartTime
	if WStartTime > 0 then
		Orbwalker:Disable()
		return
	end
	Orbwalker:Enable()

end

function FiddleSticks:OnLoad()
    if(myHero.ChampionName ~= "FiddleSticks") then return end
	AddEvent("OnSettingsSave" , function() FiddleSticks:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() FiddleSticks:LoadSettings() end)


	FiddleSticks:__init()
	AddEvent("OnTick", function() FiddleSticks:OnTick() end)	
    AddEvent("OnDraw", function() FiddleSticks:OnDraw() end)
end

AddEvent("OnLoad", function() FiddleSticks:OnLoad() end)	
