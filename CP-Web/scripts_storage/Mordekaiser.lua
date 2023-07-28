--Credits to Critic, Scortch, Christoph

Mordekaiser = {} 

function Mordekaiser:__init() 

    
    self.QRange = 625
    self.WRange = 800
	self.ERange = 700

	self.ESpeed = 3000
	self.RSpeed = math.huge
	self.QSpeed = 1300

    self.QWidth = 160
    self.EWidth = 200
    
	self.QDelay = 0.5 
	self.EDelay = 0.25

    self.QHitChance = 0.2
    self.EHitChance = 0.2

    self.ScriptVersion = "         Mordekaiser Ver: 1.3" 

    

    self.ChampionMenu = Menu:CreateMenu("Mordekaiser") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.WComboHP = self.ComboMenu:AddCheckbox("Use W based on Shield% in combo", 1)
    self.WComboHPSlider = self.ComboMenu:AddSlider("Use 1st W if HP% Below", 20,1,100,1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)  
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Mordekaiser:LoadSettings()  
end 

function Mordekaiser:SaveSettings() 

    SettingsManager:CreateSettings("Mordekaiser")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W based on Shield% in combo", self.WComboHP.Value)
    SettingsManager:AddSettingsInt("Use 1st W if HP% Below", self.WComboHPSlider.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Mordekaiser:LoadSettings()
    SettingsManager:GetSettingsFile("Mordekaiser")
     --------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.WComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use W based on Shield% in combo")
    self.WComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use 1st W if HP% Below") 
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
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
--MordekaiserW
function Mordekaiser:Combo()

    local buff1 = myHero.BuffData:GetBuff("MordekaiserW")

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.WComboHP.Value == 1 and Engine:SpellReady('HK_SPELL2') and buff1.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            local Wcondition = myHero.MaxHealth / 100 * self.WComboHPSlider.Value
            if myHero.Health <= Wcondition then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end

    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
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

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.ERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if PredPos ~= nil then 
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
                
        end
    end

end


function Mordekaiser:Harass()

    local buff1 = myHero.BuffData:GetBuff("MordekaiserW")

    if self.HarassW.Value == 1 and Engine:SpellReady('HK_SPELL2') and buff1.Valid == false then
        local Wcondition = myHero.MaxHealth / 100 * self.WComboHPSlider.Value
        if myHero.Health <= Wcondition then
            if GetDist(myHero.Position, target.Position) <= 1000 then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end

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

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Harass", self.ERange)
        local StartPos = myHero.Position
        if Target ~= nil then
            if GetDist(myHero.Position, Target.Position) <= self.WRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end

end

function Mordekaiser:Laneclear()

    local buff1 = myHero.BuffData:GetBuff("MordekaiserW")
  
    
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for I,Minion in pairs(MinionList) do	
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10  then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if buff1.Valid == false and self.ClearW.Value == 1 and Engine:SpellReady('HK_SPELL2')  then
        local Wcondition = myHero.MaxHealth / 100 * self.WComboHPSlider.Value
        if myHero.Health <= Wcondition then
        Engine:CastSpell("HK_SPELL2", nil, 0)
        return
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for I,Minion in pairs(MinionList) do	
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 then
                if GetDist(myHero.Position, Minion.Position) <= self.ERange then
                    Engine:CastSpell("HK_SPELL3", Minion.Position, 0)
                    return
                end
            end
        end
    end
end

--end---


function Mordekaiser:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Mordekaiser:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Mordekaiser:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Mordekaiser:Laneclear()
		end
	end
end

function Mordekaiser:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Mordekaiser:OnLoad()
    if(myHero.ChampionName ~= "Mordekaiser") then return end
	AddEvent("OnSettingsSave" , function() Mordekaiser:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Mordekaiser:LoadSettings() end)


	Mordekaiser:__init()
	AddEvent("OnTick", function() Mordekaiser:OnTick() end)	
    AddEvent("OnDraw", function() Mordekaiser:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Mordekaiser:OnLoad() end)	
