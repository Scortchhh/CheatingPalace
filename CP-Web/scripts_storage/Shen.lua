--Credits to Critic, Scortch, Christoph

Shen = {} 

function Shen:__init() 

    
    self.QRange = 3000
    self.WRange = 300
    self.ERange = 600

    self.ESpeed = 800 + myHero.MovementSpeed

    self.EWidth = 60

    self.EDelay = 0
    
    self.RDrawCount		= 0

    self.EHitChance = 0.2

    self.ScriptVersion = "         Shen Ver: 1.00 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("Shen") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if energy above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if energy above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawMaxRHeal = self.DrawMenu:AddCheckbox("Draw R if ally low", 1)
    self.RAllyPrec = self.DrawMenu:AddSlider("Ally hp % to draw", 45, 1, 100, 1)
    --------------------------------------------
    Shen:LoadSettings()  
end 

function Shen:SaveSettings() 

    SettingsManager:CreateSettings("Shen")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if energy above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if energy above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw MaxHeal", self.DrawMaxRHeal.Value)
    SettingsManager:AddSettingsInt("Draw RAllyPrec", self.RAllyPrec.Value)
    
    --------------------------------------------
end

function Shen:LoadSettings()
    SettingsManager:GetSettingsFile("Shen")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if energy above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if energy above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawMaxRHeal.Value = SettingsManager:GetSettingsInt("Drawings","Draw MaxHeal")
    self.RAllyPrec.Value = SettingsManager:GetSettingsInt("Drawings","Draw RAllyPrec")
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

local delayedActions, delayedActionsExecuter = {}, nil
local DelayAction = function(func, delay, args)
        if not delayedActionsExecuter then
                delayedActionsExecuter = function()
                        for t, funcs in pairs(delayedActions) do
                                if t <= GameClock.Time then
                                        for j, f in ipairs(funcs) do
                                                f.func(unpack(f.args or {}))
                                        end
                                        delayedActions[t] = nil         
                                end
                        end
                end
                AddEvent("OnTick", delayedActionsExecuter)
        end

        local t = GameClock.Time + (delay or 0)
        if delayedActions[t] then
                table.insert(delayedActions[t], { func = func, args = args })
        else
                delayedActions[t] = { { func = func, args = args } }
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

function Shen:Combo()

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                Engine:CastSpell("HK_SPELL1", nil, 1)
                return
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target and Orbwalker.ResetReady == 1  then
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                Engine:CastSpell("HK_SPELL2", nil, 1)
                return
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil then
            if GetDist(myHero.Position, PredPos) <= self.ERange then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end
end


function Shen:Harass()

 
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                    return
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if GetDist(myHero.Position, target.Position) <= self.ERange then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if PredPos ~= nil then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if GetDist(myHero.Position, PredPos) <= self.ERange then
                        Engine:CastSpell("HK_SPELL3", PredPos, 1)
                        return
                    end
                end
            end
        end
    end

end

function Shen:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= getAttackRange()  then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= getAttackRange()  then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
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
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    return
                end
            end
        end
    end

end

function Shen:ShenR(Hero)
    local AllyName = Hero.ChampionName

	local RDrawing = AllyName .. ": Save With R!"
    if Hero.Health <= Hero.MaxHealth / 100 * self.RAllyPrec.Value then
        Render:DrawString(RDrawing, 850, 50 + (20 * self.RDrawCount), 122, 235, 52, 255)
        self.RDrawCount = self.RDrawCount + 1
    end
end

--end---


function Shen:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Shen:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Shen:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Shen:Laneclear()
		end
	end
end

function Shen:OnDraw()

    self.RDrawCount = 0

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if self.DrawMaxRHeal.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            if Hero.Team == myHero.Team and Hero.ChampionName ~= myHero.ChampionName then
                if Hero.IsTargetable then
                    self:ShenR(Hero)
                end
            end
        end
    end
end

function Shen:OnLoad()
    if(myHero.ChampionName ~= "Shen") then return end
	AddEvent("OnSettingsSave" , function() Shen:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Shen:LoadSettings() end)


	Shen:__init()
	AddEvent("OnTick", function() Shen:OnTick() end)	
    AddEvent("OnDraw", function() Shen:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Shen:OnLoad() end)	
