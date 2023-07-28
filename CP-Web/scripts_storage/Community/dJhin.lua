--Credits to Critic, Scortch, Christoph

Jhin = {} 

function Jhin:__init() 

    
    self.QRange = 550 + myHero.CharData.BoundingRadius + 20
    self.WRange = 2500
    self.ERange = 750
    self.RRange = 3500

    self.QDelay = 0.25
    self.WDelay = 0.75
    self.EDelay = 0.25

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.SpellDelay1 = 0.2
    self.SpellDelay2 = 1.3

    self.ScriptVersion = "         dJhin Ver: 1.01 CREDITS Derang3d" 

    -- Major credits to Critic for the Q and R!

    self.ChampionMenu = Menu:CreateMenu("Jhin") 
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
    self.BounceAmount = self.HarassMenu:AddCheckbox("X minions to hit Q", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    Jhin:LoadSettings()
end

function Jhin:SaveSettings() 
  

    --combo save settings--
    SettingsManager:CreateSettings("Jhin")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboE.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
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

function Jhin:LoadSettings()
    SettingsManager:GetSettingsFile("Jhin")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")     
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass") 
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------

     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
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

function Jhin:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end


local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function ClosestMinion(target)
    local closestTarget = nil
    for i, minion in pairs(ObjectManager.MinionList) do
        if minion.Team ~= myHero.Team and minion.IsDead == false and minion.IsTargetable then
            if Jhin:GetDistance(target.Position, minion.Position) <= 400 then
                if closestTarget == nil then
                    closestTarget = minion
                end
                local closestTargetDistance = Jhin:GetDistance(target.Position, closestTarget.Position)
                local newTargetDistance = Jhin:GetDistance(target.Position, minion.Position)
                if closestTargetDistance < newTargetDistance then
                    closestTarget = minion
                end
            end
        end
    end
    return closestTarget
end

function VectorWay(A,B)
    WayX = B.x - A.x
    WayY = B.y - A.y
    WayZ = B.z - A.z
    return Vector3.new(WayX, WayY, WayZ)
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


function Jhin:GetQTarget()
    local MinionList = ObjectManager.MinionList
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(MinionList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                    if Jhin:GetDistance(myHero.Position, Minion.Position) <= 1400 then
                        local castPos = Prediction:GetCastPos(Minion.Position, 300, 5000, 90, 0.25, 0)
                        if castPos ~= nil then
                            local checkPosX = myHero.Position.x + (Minion.Position.x - myHero.Position.x)/Jhin:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPosY = myHero.Position.y + (Minion.Position.y - myHero.Position.y)/Jhin:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPosZ = myHero.Position.z + (Minion.Position.z - myHero.Position.z)/Jhin:GetDistance(myHero.Position,Minion.Position)*775
                            local checkPos = Vector3.new(checkPosX, checkPosY, checkPosZ)
                            if Jhin:GetDistance(castPos, checkPos) < 300 then
                                return Minion
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

function Jhin:QDmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = GetDamage(20 + (25 * myHero:GetSpellSlot(0).Level) + TotalAD * (0.375 + 0.075 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.6, true, Target)
    if QDmg > Target.Health then
        return true
    end
    return false
end

function Jhin:QMinionsKillable(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do 
        if Minion.Team ~= myHero.Team and Minion.IsDead == false then
            if self:QDmg(Minion) then
                if GetDist(Minion.Position , Position) < Range then
                    Count = Count + 1
                end
            end
        end
    end
    return Count
end

-----combo-----


function Jhin:Combo()
    local RStartTime = myHero:GetSpellSlot(3).StartTime

    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        if RStartTime > 0 then
            local StartPos = myHero.Position
            local CastPos = Prediction:GetCastPos(StartPos, self.RRange, 5000, 80, 0.25, 0)
            if CastPos ~= nil then
                if GetDist(StartPos, CastPos) < self.RRange then
                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                    return
                end
            end
            return
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 then
        if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
            DelayAction(function()
                local target = Orbwalker:GetTarget("Combo", self.QRange)
                if target then
                    if Jhin:GetDistance(myHero.Position, target.Position) < getAttackRange() then
                         Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end, self.SpellDelay1)
        end
    end

	if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
			if target.AIData.IsDashing == true or target.BuffData:HasBuffOfType(BuffType.Stun) == true or target.BuffData:HasBuffOfType(BuffType.Snare) == true then
				Engine:CastSpell("HK_SPELL3",target.Position, 1)											 
            end
		end	
    end		
    
    --jhinetrapslow
    --jhinespotteddebuff
    --jhinrsight
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) < getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 and not Engine:SpellReady("HK_SPELL2") then
                    DelayAction(function()
                        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 1)
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end, self.SpellDelay2)
                end
            else
                local eBuff = target.BuffData:GetBuff("jhinetrapslow")
                if eBuff.Valid then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 0)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    end
                end
            end
		end
	end
end

--self.BounceAmount
function Jhin:Harass()

    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
            DelayAction(function()
                local target = Orbwalker:GetTarget("Combo", self.QRange)
                if target then
                    if Jhin:GetDistance(myHero.Position, target.Position) < getAttackRange() then
                         Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end, self.SpellDelay1)
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
		local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) < getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 and not Engine:SpellReady("HK_SPELL2") then
                    DelayAction(function()
                        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 1)
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end, self.SpellDelay2)
                end
            else
                local eBuff = target.BuffData:GetBuff("jhinespotteddebuff")
                if eBuff.Valid then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 400, self.WDelay, 0)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    end
                end
            end
		end
	end
end

function Jhin:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
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


function Jhin:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Jhin:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Jhin:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
             Jhin:Laneclear()
		end
	end
end

function Jhin:OnDraw()
    if myHero.IsDead then return end

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
	local RStartTime = myHero:GetSpellSlot(3).StartTime
	if RStartTime > 0 then
		Orbwalker:Disable()
		return
	end
	Orbwalker:Enable()
end

function Jhin:OnLoad()
    if(myHero.ChampionName ~= "Jhin") then return end
	AddEvent("OnSettingsSave" , function() Jhin:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Jhin:LoadSettings() end)


	Jhin:__init()
	AddEvent("OnTick", function() Jhin:OnTick() end)	
    AddEvent("OnDraw", function() Jhin:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Jhin:OnLoad() end)	
