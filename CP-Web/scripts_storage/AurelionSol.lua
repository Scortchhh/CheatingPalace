--Credits to Critic, Scortch, Christoph
AurelionSol = {} 

function AurelionSol:__init() 

    
    self.QRange = 600
    self.WRange = 600
    self.ERange = 5500 
    self.RRange = 1500

    self.QSpeed = 850 
    self.WSpeed = math.huge
    self.ESpeed = 850
    self.RSpeed = 4500

    self.QWidth = 75

    self.QDelay = 0
    self.WDelay = 0
    self.EDelay = 0.25
    self.RDelay = 0.35

    self.QHitChance = 0.2

    self.ScriptVersion = "         dAurelionSol Ver: 1.00 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("AurelionSol") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    
    AurelionSol:LoadSettings()  
end 

function AurelionSol:SaveSettings() 


    --combo save settings--
    SettingsManager:CreateSettings("AurelionSol")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    --------------------------------------------
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --------------------------------------------
	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function AurelionSol:LoadSettings()
    SettingsManager:GetSettingsFile("AurelionSol")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
  
    --------------------------------------------
    --------------------------------Harass load----------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    --------------------------------------------
    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --------------------------------------------
    --------------------------------Draw load----------------------
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

---- ultimate2 -----
function AurelionSol:Ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 550 then
                    local SolR = GetDamage(50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.70), false, target)
                    if SolR >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end
end

---- end ultimate------

-----combo-----
--aurelionsolwactive
--aurelionsolqhaste

function AurelionSol:Combo()

    local buff1 = myHero.BuffData:GetBuff("aurelionsolwactive")
    local buff2 = myHero.BuffData:GetBuff("aurelionsolqhaste")


    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff2.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 and buff1.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL2", myHero.Position, 0)
            return
        end
    end
end


function AurelionSol:Harass()


    local buff1 = myHero.BuffData:GetBuff("aurelionsolwactive")
    local buff2 = myHero.BuffData:GetBuff("aurelionsolqhaste")


    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and buff2.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange  then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
                if PredPos then
                    local sliderValue = self.HarassSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 and buff1.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL2", myHero.Position, 1)
                return
            end
        end
    end
end

function AurelionSol:Laneclear()

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
                end
            end
        end
    end


end

--end---


function AurelionSol:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        AurelionSol:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            AurelionSol:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            AurelionSol:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            AurelionSol:Laneclear()
		end
	end
end

function AurelionSol:OnDraw()
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

function AurelionSol:OnLoad()
    if(myHero.ChampionName ~= "AurelionSol") then return end
	AddEvent("OnSettingsSave" , function() AurelionSol:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() AurelionSol:LoadSettings() end)


	AurelionSol:__init()
	AddEvent("OnTick", function() AurelionSol:OnTick() end)	
    AddEvent("OnDraw", function() AurelionSol:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() AurelionSol:OnLoad() end)	
