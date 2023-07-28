--SUPER Malzahar UNLEASHED

-- Malzahar In It Function with Range, Menu, and Delay
Malzahar = {} 
function Malzahar:__init()

    self.KeyNames = {}
    
    self.KeyNames[4]         = "HK_SUMMONER1"
    self.KeyNames[5]         = "HK_SUMMONER2"
    
    self.KeyNames[6]         = "HK_ITEM1"
    self.KeyNames[7]         = "HK_ITEM2"
    self.KeyNames[8]         = "HK_ITEM3"
    self.KeyNames[9]         = "HK_ITEM4"
    self.KeyNames[10]         = "HK_ITEM5"
    self.KeyNames[11]        = "HK_ITEM6"

    self.RTimer = 0

    self.QRange = 900 
    self.WRange = 700
    self.ERange = 650 
    self.RRange = 650

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.RSpeed = math.huge

    self.QDelay = 0
    self.WDelay = 0
    self.RDelay = 0

    self.ScriptVersion = "Malzahar by Sheep" 
    self.ChampionMenu = Menu:CreateMenu("Malzahar") 
    
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)
    
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1)
    -- no ult logic needed in harass 
   
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw if killable", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 

    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc") 
    self.MaxStun = self.MiscMenu:AddCheckbox("Use E to build Q stun", 1) 
    self.MaxSlider = self.MiscMenu:AddSlider("Build stun if mana above %", 20,1,100,1)
    self.QLasthit = self.MiscMenu:AddCheckbox("LaneClear/LastHit with Q")
    Malzahar:LoadSettings()  
end 

-- Save Settings Function
function Malzahar:SaveSettings() 
    
    SettingsManager:CreateSettings("Malzahar")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)

    -- HARASS
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
  
    -- LANE CLEAR
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
 
	-- DRAW
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw if killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
  -- SETTINGsS
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use E to build Q stun", self.MaxStun.Value)
    SettingsManager:AddSettingsInt("Build stun if mana above %", self.MaxSlider.Value)
    SettingsManager:AddSettingsInt("LaneClear/LastHit with Q", self.QLasthit.Value)
end
-- Load Settings Function
function Malzahar:LoadSettings()
    SettingsManager:GetSettingsFile("Malzahar")
    
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
   
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
   
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
   
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
  
    self.MaxStun.Value = SettingsManager:GetSettingsInt("Misc","Use E to build Q stun")
    self.MaxSlider.Value = SettingsManager:GetSettingsInt("Misc","Build stun if mana above %")
    self.QLasthit.Value = SettingsManager:GetSettingsInt("Misc", "LaneClear/LastHit with Q")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20 ---?????????
    return attRange
end

local function GetDist(source, target) --- GetDist needs to be the same all the way throughout, if you do, function Annine:GetDist then self:GetDist will also work or Malzahar:GetDist
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
	return Count ---
end

local function MinionsInRange(Position, Range)
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

local function GetHeroLevel(Target) -- This will check Target level (need it for ignite because ignite is checking dmg for levels and will scale with levels)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Malzahar:Damage(Target)
    local Qdmg = GetDamage(35 + (35 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.55, false, Target)
    local Wdmg = GetDamage(45 + (35 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.8, false, Target)
    local Rdmg = GetDamage(50 + (75 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower * 0.8, false, Target)
    local iDmg = 55 + (25 * GetHeroLevel(myHero)) --IGNITE HERE DOWN
    local Ignite = self:Ignite_Check(2000)
    local IgniteBuff    = Target.BuffData:GetBuff('SummonerDot') --SummonerDot

    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 and  Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + Qdmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = FinalFullDmg + Wdmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        FinalFullDmg = FinalFullDmg + Rdmg
    end
    if Ignite ~= false or IgniteBuff.Valid or IgniteBuff.Count_Alt > 0 then
        FinalFullDmg = FinalFullDmg + iDmg
    end
    return FinalFullDmg
end


function Malzahar:SortToLowestHealth(Table)
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
------ Malzahar Ignite need paste in InIt as well, as well as in MalzaharDmg, also need new function for IgniteKs and for it to be in combo
function Malzahar:GetTarget(Range, HealthPercentage)
    local Heros = self:SortToLowestHealth(ObjectManager.HeroList)
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position, myHero.Position) < Range + myHero.CharData.BoundingRadius then
                return Hero
            end
        end
    end    
    return nil
end

function Malzahar:GetSummonerKey(SummonerName)
    for i = 4 , 5 do
        if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
            return self.KeyNames[i]
        end
    end
    return nil
end

function Malzahar:Ignite_Check(Range)
    local Ignite                     = {}
            Ignite.Key                = self:GetSummonerKey("Dot")    
    if Ignite.Key ~= nil then
        if Engine:SpellReady(Ignite.Key) then
            Ignite.Target             = self:GetTarget(Range)
            if Ignite.Target ~= nil then
                return Ignite
            end
        end
    end
    return false
end
-----------

function Malzahar:AlliesInRange(Position, Range)
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

--[[function Malzahar:IgniteKS()
    local Ignite                = self:Ignite_Check(600)
    if Ignite ~= false then -- if Ignite ~= false and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
        if self:Damage(Ignite.Target) >= (Ignite.Target.Health) then
            return Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)
         end  
    end    
end]]


function Malzahar:Ignite()
        
    local Ignite                = self:Ignite_Check(600)
    if Ignite ~= false then -- if Ignite ~= false and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
        return Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)  
    end  
end

function Malzahar:IgniteEarly()
    local Ignite                = self:Ignite_Check(600)
    if Ignite ~= false then
        local MissingHP = ((Ignite.Target.MaxHealth - Ignite.Target.Health) / Ignite.Target.MaxHealth) * 100
       -- print(1)
        if MissingHP >= 25 then
       -- print(2)
            return Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)
         end  
    end  

end





------------- FULL COMBO MODE
function Malzahar:Combo()
    --Malzahar:Ultimate()
    --Malzahar:IgniteEarly()
    --Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)
    if self.ComboW.Value == 1 then --and Engine:SpellReady("HK_SPELL3")
    
    end




    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.QRange then
                return Engine:CastSpell("HK_SPELL1", CastPos, 1)
            end
        end
    end




    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.ERange then
                return Engine:CastSpell("HK_SPELL3", CastPos, 1)
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.ERange then
                return Engine:CastSpell("HK_SPELL2", CastPos, 1)
            end
        end
    end


end


function Malzahar:Ultimate()
    local RBuff = myHero.BuffData:GetBuff("malzaharrsound")
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") and (GameClock.Time - myHero:GetSpellSlot(0).Cooldown) < -0.25 and (GameClock.Time - myHero:GetSpellSlot(1).Cooldown) < -0.25 and (GameClock.Time - myHero:GetSpellSlot(2).Cooldown) < -0.25 then -- inside if you need ==, checking if it is same value, = is to make it that value
        local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange - 50, 1400, 90, 0.25, 0) -- positionHero, range of spell - 50, speed of missle, width, delay, chanel time(most 0.25), 0 or 1 does not need minion check 0
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.RRange then
                self.RTimer = os.clock()
                return Engine:CastSpell("HK_SPELL4", CastPos, 1)
            end
        end
    end
      
end



function Malzahar:Harass() 
    --(harass)
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then

        
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                return Engine:CastSpell("HK_SPELL1", target.Position, 1)
                
            end
        end
    end
    
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then 
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                return Engine:CastSpell("HK_SPELL2", nil, 1)
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then

        
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                return Engine:CastSpell("HK_SPELL3", target.Position, 1)
                
            end
        end
    end


end
function Malzahar:Laneclear()

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition and MinionsInRange(myHero.Position, 500) >= 2 then
                    Engine:CastSpell("HK_SPELL2", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition and MinionsInRange(myHero.Position, 500) >= 2 then
                    Engine:CastSpell("HK_SPELL3", nil, 0)
                    return
                end
            end
        end
    end

end

function Malzahar:KillHealthBox()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if Hero.IsTargetable then

                local CurrentDmg = self:Damage(Hero) --Switch this part of the code from where dmg calcs comes from!
                local KillCombo = "KILLABLE"
                local CurrentHP = Hero.Health
                local MaxHP = Hero.MaxHealth
                local KillDraw = string.format("%.0f", CurrentDmg) .. " / " .. string.format("%.0f", CurrentHP)
                local fullHpDrawWidth = 104
                local damageDrawWidth = 0
                local damageStartingX = 0
                local damageEndingPos = 0
                local hpDrawWidth = 104 * (Hero.Health / Hero.MaxHealth)
                local lostHP = 104 - (Hero.MaxHealth - Hero.Health) / Hero.MaxHealth

                damageDrawWidth = (hpDrawWidth - hpDrawWidth * ((Hero.Health - CurrentDmg) / Hero.Health))
                damageEndingPos = damageDrawWidth
                if CurrentDmg >= Hero.Health then
                    damageEndingPos =  hpDrawWidth
                end

                damageStartingX = hpDrawWidth - damageDrawWidth
                if damageStartingX <= 0 then
                    damageStartingX = 0
                end
    
                local vecOut = Vector3.new()

                if Render:World2Screen(Hero.Position, vecOut) then 
                    if CurrentDmg < CurrentHP then
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 248, 252, 3, 255)
                    end
                    if CurrentDmg > CurrentHP then
                        Render:DrawString(KillCombo, vecOut.x - 50 , vecOut.y - 220, 92, 255, 5, 255)
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 92, 255, 5, 255)
                    end
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 , fullHpDrawWidth,  6, 0, 0, 0, 200)
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180, hpDrawWidth,  6, 92, 255, 5, 200)
                    Render:DrawFilledBox(vecOut.x - 49 + damageStartingX , vecOut.y - 180 , damageEndingPos,  6,153, 0, 0, 240)
                end
            end
        end
    end
end

function Malzahar:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then

        local MalzaR = myHero.ActiveSpell.Info.Name  
        --print(GameClock.Time - myHero:GetSpellSlot(0).Cooldown) 
       -- print(myHero:GetSpellSlot(3).Info.Name)
        --print(myHero.BuffData:ShowAllBuffs()) -- malzaharrsound
        --print(myHero.BuffData:GetBuff("malzaharrsound").Count_Alt)
        local RBuff = myHero.BuffData:GetBuff("malzaharrsound") 
       -- print(myHero.ActiveSpell.Info.Name) MalzaharR
        Malzahar:IgniteEarly() --- need it before r so it will use before.
        if MalzaR ~= "MalzaharR" or (os.clock() - self.RTimer) == 0 or (os.clock() - self.RTimer) > 2.5 then -- prevents using abilities during r
            
            
            Orbwalker.Enabled = 1 --- when you do not have r buff it will enable orbwalker Needs Else Orbwalker Enabled = 0


            if Engine:IsKeyDown("HK_COMBO") then
                Malzahar:Combo() -- can either have this on here or in combo function

                Malzahar:Ultimate()
            end
            if Engine:IsKeyDown("HK_HARASS") then
                Malzahar:Harass()
                Engine:IsKeyDown("HK_LASTHIT")
            end
            if Engine:IsKeyDown("HK_LANECLEAR") then
                Malzahar:Laneclear()
                Engine:IsKeyDown("HK_LASTHIT")

            end 

        else 
            Orbwalker.Enabled = 0 --- take off orbwalker
        end
    end
end
function Malzahar:OnDraw()
    if self.DrawKillable.Value == 1 then
        Malzahar:KillHealthBox()
    end
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
function Malzahar:OnLoad()
    if(myHero.ChampionName ~= "Malzahar") then return end
	AddEvent("OnSettingsSave" , function() Malzahar:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Malzahar:LoadSettings() end)
	Malzahar:__init()
	AddEvent("OnTick", function() Malzahar:OnTick() end)	
    AddEvent("OnDraw", function() Malzahar:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Malzahar:OnLoad() end)	









