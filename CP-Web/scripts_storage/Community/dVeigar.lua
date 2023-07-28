--Credits to Critic, Scortch, Christoph

Veigar = {} 

function Veigar:__init() 

    
    self.QRange = 900
    self.WRange = 900
    self.ERange = 720
    self.RRange = 650

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.EDelay = 0.25
    self.RDelay = 0.25

    self.QSpeed = 2000
    self.WSpeed = math.huge
    self.ESpeed = 1400



    self.ScriptVersion = "         dVeigar Ver: 1.01 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("Veigar") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
	self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    --self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.QLasthit = self.MiscMenu:AddCheckbox("Last hit with Q")

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Veigar:LoadSettings()
end

function Veigar:SaveSettings() 
  

    --combo save settings--
    SettingsManager:CreateSettings("Veigar")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Last hit with Q", self.QLasthit.Value)

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Veigar:LoadSettings()
    SettingsManager:GetSettingsFile("Veigar")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.QLasthit.Value = SettingsManager:GetSettingsInt("Misc", "Last hit with Q")
    
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

function Veigar:GetDistance(source, target)
    return math.sqrt(((target.x - source.x) ^ 2) + ((target.z - source.z) ^ 2))
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

function Veigar:GetECastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -225
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Veigar:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLasthit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    local qDmg = GetDamage(40 + (40 * myHero:GetSpellSlot(0).Level) + 0.6 * (myHero.AbilityPower), true, Minion) 
                    if Minion.Health <= qDmg then
                        return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    end
                end
            end
        end
    end
end



function Veigar:Ultr()
    local HeroList = ObjectManager.HeroList
    for i, target in pairs(HeroList) do
        if Engine:SpellReady('HK_SPELL4') and self.ComboR.Value == 1 then
            if target.Team ~= myHero.Team and target.IsTargetable then
                if GetDist(myHero.Position, target.Position) <= 650 then
                    local hBurst = 1 + math.min(1, (1 - target.Health / target.MaxHealth) * 3/2)
                    local pBurst = GetDamage(100 + (75 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75), false, target) *hBurst
                    if pBurst >= target.Health then
                        return Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end
end

-----combo-----


function Veigar:Combo()

	if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local StartPos = myHero.Position
		local CastPos, Target = Prediction:GetCastPos(StartPos, self.ERange-50, self.ESpeed, 375, self.EDelay, 0)
		if CastPos ~= nil and Target ~= nil then
			CastPos = self:GetECastPos(CastPos)
			if GetDist(StartPos, CastPos) <= self.ERange then
				return Engine:CastSpell("HK_SPELL3", Target.Position, 1)
			end
		end
	end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 112, self.WDelay, 0)
            if PredPos ~= nil then
                return Engine:CastSpell("HK_SPELL2", PredPos, 1)
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 225, self.QDelay, 0)
            if PredPos ~= nil then
                return Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end
end

function Veigar:Harass()

	if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local StartPos = myHero.Position
		local CastPos, Target = Prediction:GetCastPos(StartPos, self.ERange, self.ESpeed, 375, self.EDelay, 0)
		if CastPos ~= nil and Target ~= nil then
			CastPos = self:GetECastPos(CastPos)
			if GetDist(StartPos, CastPos) <= self.ERange then
				return Engine:CastSpell("HK_SPELL3", CastPos, 1)
			end
		end
	end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 112, self.WDelay, 0)
            if PredPos ~= nil then
                return Engine:CastSpell("HK_SPELL2", PredPos, 1)
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 225, self.QDelay, 0)
            if PredPos ~= nil then
                return Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end
end

function Veigar:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    return Engine:CastSpell("HK_SPELL1", target.Position, 0)
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
                    return Engine:CastSpell("HK_SPELL2", target.Position, 0)
                end
            end
        end
    end
end


--end---


function Veigar:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Veigar:Ultr()
        if Engine:IsKeyDown("HK_COMBO") then
            Veigar:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Veigar:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Veigar:LastHitQ()
            Veigar:Laneclear()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Veigar:LastHitQ()
        end
	end
end

function Veigar:OnDraw()
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
end

function Veigar:OnLoad()
    if(myHero.ChampionName ~= "Veigar") then return end
	AddEvent("OnSettingsSave" , function() Veigar:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Veigar:LoadSettings() end)


	Veigar:__init()
	AddEvent("OnTick", function() Veigar:OnTick() end)	
    AddEvent("OnDraw", function() Veigar:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Veigar:OnLoad() end)	
