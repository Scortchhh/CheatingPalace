local Ryze = {}

function Ryze:__init()

    self.QRange = 1000
    self.WRange = 615
    self.ERange = 615
    self.RRange = 3000

    self.QSpeed = 1700
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QWidth = 110

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.EDelay = 0.25
    self.RDelay = 0 + 2.0

    --self.QRadius = 55
    --self.WRadius = 0
    --self.ERadius = 350
    --self.RRadius = 475

    self.SpellDelay = 1.3

    self.QHitChance = 0.2

    self.ScriptVersion = "        **CCRyze Version: 0.3 (BETA)**"

    self.ChampionMenu = Menu:CreateMenu("Ryze")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboAA = self.Combomenu:AddSlider("Use AA's between spells until lvl", 10, 1, 18, 1)
    --self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)
    --self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.HarassW = self.Harassmenu:AddCheckbox("Use W in harass", 1)
    self.HarassWMana = self.Harassmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    --self.ClearW = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    --self.ClearWMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
	
	Ryze:LoadSettings()
end

function Ryze:SaveSettings()
	SettingsManager:CreateSettings("CCRyze")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    --SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    --SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HW", self.HarassW.Value)
    SettingsManager:AddSettingsInt("HWM", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    --SettingsManager:AddSettingsInt("CW", self.ClearW.Value)
    --SettingsManager:AddSettingsInt("CWM", self.ClearWMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Ryze:LoadSettings()
	SettingsManager:GetSettingsFile("CCRyze")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    --self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    --self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","HW")
    self.HarassWMana.Value = SettingsManager:GetSettingsInt("Harass","HWM")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","HE")
    self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass","HEM")
    -------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    --self.ClearW.Value = SettingsManager:GetSettingsInt("Clear", "CW")
    --self.ClearWMana.Value = SettingsManager:GetSettingsInt("Clear", "CWM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
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

function Ryze:GetLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Ryze:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    if(target.IsMinion ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
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


function Ryze:Combo()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
    
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL2", target.Position, 1)
        end
    end
end

function Ryze:Harass()
        if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
            local Target = Orbwalker:GetTarget("Combo", self.ERange)
            local StartPos = myHero.Position
            if Target ~= nil then
                local PredPos, Target = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
        end
        
        if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            if myHero.Mana <= myHero.MaxMana * self.HarassWMana.Value / 100 then return end
            local target = Orbwalker:GetTarget("Combo", self.WRange)
            if target ~= nil then
                Engine:CastSpell("HK_SPELL2", target.Position, 1)
            end
        end

        if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if myHero.Mana <= myHero.MaxMana * self.HarassEMana.Value / 100 then return end
            local target = Orbwalker:GetTarget("Combo", self.ERange)
            if target ~= nil then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
end

function Ryze:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.ClearQMana.Value / 100 then return end
        local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
        local StartPos = myHero.Position
        if Target == nil then return end
        if not ValidTarget(Target) then return end
        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
    end
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if myHero.Mana <= myHero.MaxMana * self.ClearEMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target == nil then return end
        if not ValidTarget(target) then return end
        Engine:CastSpell("HK_SPELL3", target.Position, 1)
    end
end

function Ryze:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Ryze:Combo()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Ryze:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Ryze:Laneclear()
            return
        end
    end
end

function Ryze:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 0, 255, 255)
    end
    --if self:PredCheckPos() == true and self.PredCheck.Value == 1 then
      --  Render:DrawCircle(self:PredCheckPos(), 100, 255, 0, 255, 255)
    --end
end

function Ryze:OnLoad()
    if(myHero.ChampionName ~= "Ryze") then return end
    AddEvent("OnSettingsSave" , function() Ryze:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ryze:LoadSettings() end)

	Ryze:__init()
	AddEvent("OnTick", function() Ryze:OnTick() end)
    AddEvent("OnDraw", function() Ryze:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Ryze:OnLoad() end)