--Credits to Critic, Scortch, Christoph

RekSai = {} 

function RekSai:__init() 

    
    self.UQRange = 325
    self.BQRange = 1650
    self.BWRange = 160
    self.UWRange = 160
    self.UERange = 225 
    self.BERange = 850
    self.RRange = 1500

    self.BQSpeed = math.huge
    self.BESpeed = math.huge

    self.BQWidth = 80
    self.BEWidth = 80

    self.QDelay = 0.1
    self.BEDelay = 0.25

    self.QHitChance = 0.2
    self.EHitChance = 0.2

    self.ScriptVersion = "         dRekSai Ver: 1.001 CREDITS Derang3d" 

    

    self.ChampionMenu = Menu:CreateMenu("RekSai") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.UComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.BComboQ = self.ComboMenu:AddCheckbox("Use burrow Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.BComboW = self.ComboMenu:AddCheckbox("Use W to Burrow > 650", 1) 
    self.UComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.BComboE = self.ComboMenu:AddCheckbox("Use burrow E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R KS in Combo", 1) 
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
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    
    RekSai:LoadSettings()  
end 

function RekSai:SaveSettings() 

    --combo save settings--
    SettingsManager:CreateSettings("RekSai")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in Combo", self.UComboQ.Value)
    SettingsManager:AddSettingsInt("Use burrow Q in Combo", self.BComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use W to Burrow > 600", self.BComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.UComboE.Value)
    SettingsManager:AddSettingsInt("Use burrow E in Combo", self.BComboE.Value)
    SettingsManager:AddSettingsInt("Use R KS in Combo", self.ComboR.Value)
    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function RekSai:LoadSettings()
    SettingsManager:GetSettingsFile("RekSai")
     --------------------------------Combo load----------------------
    self.UComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.BComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use burrow Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.BComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W to Burrow > 600")
    self.UComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.BComboE.Value = SettingsManager:GetSettingsInt("Combo","Use burrow E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R KS in Combo")  
    --------------------------------------------

    --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
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

-----combo-----
--ReksaiQSpellPassive
--ReksaiWSpellPassive
--ReksaiESpellPassive
--RekSaiW
--reksairprey

function RekSai:Ultimate()

    local RDamage = {100, 250, 400}
    local RLevel = myHero:GetSpellSlot(3).Level
    local Rdmg = RDamage[RLevel]

    local UltLvl = myHero:GetSpellSlot(3).Level

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then 
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then 
                local TargetBuffs 		= target.BuffData
                local reskaiB   		= TargetBuffs:GetBuff("reksairprey")
                if GetDist(myHero.Position, target.Position) <= 1500 and reskaiB.Valid == true then
                    local RekR = GetDamage( Rdmg + (myHero.BonusAttack * 1.5), true, target)
                    local RekHPR = (target.MaxHealth - target.Health) * (0.15 + 0.05 * UltLvl)
                    local REKRKILL = RekR + RekHPR
                    if REKRKILL >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end
end

function RekSai:Combo()

    RekSai:Ultimate()
    local burrowed = myHero.BuffData:GetBuff("ReksaiW")

    if self.UComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.UQRange)
        if target  and Orbwalker.ResetReady == 1 then
            if GetDist(myHero.Position, target.Position) <= 450 then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
                return
            end
        end
    end

    if self.UComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and burrowed.Valid == false then
        if myHero.Mana == 100 then
            local target = Orbwalker:GetTarget("Combo", self.UERange)
            if target then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
    end

    if self.BComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.BQRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.BQRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.BQRange, self.BQSpeed, self.BQWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL1") and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Combo", self.BERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= 160 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                return
            end
        end
    end
    
    if self.BComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Combo", self.BERange)
        if target then 
            if GetDist(myHero.Position, target.Position) >= 650 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                return
            end
        end
    end
    
    if self.BComboE.Value == 1 and Engine:SpellReady("HK_SPELL3")  and not Engine:SpellReady("HK_SPELL1") and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Combo", self.BERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.BERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.BERange, self.BESpeed, self.BEWidth, self.BEDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end
end

function RekSai:Harass()

  
    RekSai:Ultimate()
    local burrowed = myHero.BuffData:GetBuff("ReksaiW")

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Harass", self.UQRange)
        if target  and Orbwalker.ResetReady == 1 then
            if GetDist(myHero.Position, target.Position) <= 450 then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
                return
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") and burrowed.Valid == false then
        if myHero.Mana == 100 then
            local target = Orbwalker:GetTarget("Harass", self.UERange)
            if target then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.BQRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.BQRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.BQRange, self.BQSpeed, self.BQWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL1") and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Harass", self.BERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= 160 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                return
            end
        end
    end
    
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Harass", self.BERange)
        if target then 
            if GetDist(myHero.Position, target.Position) >= 650 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                return
            end
        end
    end
    
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3")  and not Engine:SpellReady("HK_SPELL1") and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Harass", self.BERange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.BERange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.BERange, self.BESpeed, self.BEWidth, self.BEDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                    return
                end
            end
        end
    end
end

function RekSai:Laneclear()

    local burrowed = myHero.BuffData:GetBuff("ReksaiW")

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Laneclear", self.UQRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.UQRange then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
                return
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Laneclear", self.BQRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.BQRange then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
                return
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1  and burrowed.Valid == true then
        local target = Orbwalker:GetTarget("Laneclear", self.BWRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= 160 then
                Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                return
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1  and burrowed.Valid == false then
        local target = Orbwalker:GetTarget("Laneclear", self.UERange)
        if myHero.Mana == 100 then
            if target then
                if GetDist(myHero.Position, target.Position) <= self.UERange then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    return
                end
            end
        end
    end

end

--end---

function RekSai:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            RekSai:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            RekSai:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            RekSai:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            RekSai:Laneclear()
		end
	end
end

function RekSai:OnDraw()
    local burrowed = myHero.BuffData:GetBuff("ReksaiW")

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 and burrowed.Valid == false then
        Render:DrawCircle(myHero.Position, self.UQRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 and burrowed.Valid == true then
        Render:DrawCircle(myHero.Position, self.BQRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 and burrowed.Valid == false then
        Render:DrawCircle(myHero.Position, self.UERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 and burrowed.Valid == true then
        Render:DrawCircle(myHero.Position, self.BERange ,0,255,0,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function RekSai:OnLoad()
    if(myHero.ChampionName ~= "RekSai") then return end
	AddEvent("OnSettingsSave" , function() RekSai:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() RekSai:LoadSettings() end)


	RekSai:__init()
	AddEvent("OnTick", function() RekSai:OnTick() end)	
    AddEvent("OnDraw", function() RekSai:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() RekSai:OnLoad() end)	
