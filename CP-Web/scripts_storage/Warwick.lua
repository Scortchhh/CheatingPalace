
Warwick = {} 
function Warwick:__init()

    self.KeyNames = {}
    
    self.KeyNames[4]         = "HK_SUMMONER1"
    self.KeyNames[5]         = "HK_SUMMONER2"
    
    self.KeyNames[6]         = "HK_ITEM1"
    self.KeyNames[7]         = "HK_ITEM2"
    self.KeyNames[8]         = "HK_ITEM3"
    self.KeyNames[9]         = "HK_ITEM4"
    self.KeyNames[10]         = "HK_ITEM5"
    self.KeyNames[11]        = "HK_ITEM6"

    self.QRange = 350
    self.WRange = 4000
    self.ERange = 300 
    self.RRange = myHero.MovementSpeed / 100 * 250

    self.QWidth = myHero.CharData.BoundingRadius
    self.WWidth = nil
    self.EWidth = myHero.CharData.BoundingRadius
    self.RWidth = 150

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = myHero.MovementSpeed / 100 * 250

    self.QDelay = 0
    self.WDelay = 0.5
    self.EDelay = 0
    self.RDelay = 0.1

    self.ChampionMenu = Menu:CreateMenu("Warwick") 
    
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1)
   
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    Warwick:LoadSettings()  
end 

-- Save Settings Function
function Warwick:SaveSettings() 
    
    SettingsManager:CreateSettings("Warwick")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)

    -- HARASS
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
  
    -- LANE CLEAR
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
 
	-- DRAW
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end
-- Load Settings Function
function Warwick:LoadSettings()
    SettingsManager:GetSettingsFile("Warwick")
    
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
   
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
   
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
   
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
end

function Warwick:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Warwick:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Warwick:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Warwick:ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Warwick:EnemiesInRange(Position, Range)
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

function Warwick:MinionsInRange(Position, Range)
	local Count = 0 
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Warwick:SortToLowestHealth(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        if Object.Health > 0 then
            SortedTable[#SortedTable + 1] = Object
        end
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return left.Health < right.Health
        end)
    end
    return SortedTable
end    

function Warwick:AlliesInRange(Position, Range)
    local Count = 0 
    local HeroList = ObjectManager.HeroList
    for I,Hero in pairs(HeroList) do    
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Warwick:Combo()
    local eBuff = myHero.BuffData:GetBuff("WarwickE").Valid
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        if Orbwalker.ForceTarget ~= nil then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, 0, 0.1, 1)
            if CastPos then
                Engine:CastSpell("HK_SPELL4", CastPos, 1)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 and not eBuff then
        local checkRange = self.QRange + 200
        local target = Orbwalker:GetTarget("Combo", checkRange)
        if target then
            if self:GetDist(myHero.Position, target.Position) <= checkRange then
                return Engine:CastSpell("HK_SPELL3", nil, 0)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() then
                local Spell = Prediction.DashSpell[target.ChampionName]
                if Spell ~= nil then
                    if Spell.Q ~= nil then
                        if GameClock.Time >= target:GetSpellSlot(0).Cooldown then
                            -- hold Q to gapclose
                        end
                    end
                    if Spell.W ~= nil then
                        if GameClock.Time >= target:GetSpellSlot(1).Cooldown then
                            -- hold Q to gapclose
                        end
                    end
                    if Spell.E ~= nil then
                        if GameClock.Time >= target:GetSpellSlot(2).Cooldown then
                            -- hold Q to gapclose
                        end
                    end
                    if Spell.R ~= nil then
                        if GameClock.Time >= target:GetSpellSlot(3).Cooldown then
                            -- hold Q to gapclose
                        end
                    end
                    if eBuff then
                        return Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    else
                        return Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 and eBuff then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() then
                return Engine:CastSpell("HK_SPELL3", nil, 0)
            end
        end
    end
end

function Warwick:Harass() 
    if Engine:SpellReady("HK_SPELL3") and self.HarassE.Value == 1 and not eBuff then
        local checkRange = self.QRange + 200
        local target = Orbwalker:GetTarget("Harass", checkRange)
        if target then
            if target.IsHero then
                if self:GetDist(myHero.Position, target.Position) <= checkRange then
                    return Engine:CastSpell("HK_SPELL3", nil, 0)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            if target.IsHero then
                if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() then
                    local eBuff = myHero.BuffData:GetBuff("WarwickE").Valid
                    local Spell = Prediction.DashSpell[target.ChampionName]
                    if Spell ~= nil then
                        if Spell.Q ~= nil then
                            if GameClock.Time >= target:GetSpellSlot(0).Cooldown then
                                -- hold Q to gapclose
                            end
                        end
                        if Spell.W ~= nil then
                            if GameClock.Time >= target:GetSpellSlot(1).Cooldown then
                                -- hold Q to gapclose
                            end
                        end
                        if Spell.E ~= nil then
                            if GameClock.Time >= target:GetSpellSlot(2).Cooldown then
                                -- hold Q to gapclose
                            end
                        end
                        if Spell.R ~= nil then
                            if GameClock.Time >= target:GetSpellSlot(3).Cooldown then
                                -- hold Q to gapclose
                            end
                        end
                    end
                    if eBuff then
                        return Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    else
                        return Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 and eBuff then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() then
                return Engine:CastSpell("HK_SPELL3", nil, 0)
            end
        end
    end
end

function Warwick:Laneclear() 
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() then
                return Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ClearE.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            if self:GetDist(myHero.Position, target.Position) <= self.ERange then
                return Engine:CastSpell("HK_SPELL3", nil, 0)
            end
        end
    end
end

function Warwick:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Warwick:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Warwick:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Warwick:Laneclear()
        end
    end
end

function Warwick:OnDraw()
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

function Warwick:OnLoad()
    if(myHero.ChampionName ~= "Warwick") then return end
	AddEvent("OnSettingsSave" , function() Warwick:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Warwick:LoadSettings() end)
	Warwick:__init()
	AddEvent("OnTick", function() Warwick:OnTick() end)	
    AddEvent("OnDraw", function() Warwick:OnDraw() end)
end
AddEvent("OnLoad", function() Warwick:OnLoad() end)	