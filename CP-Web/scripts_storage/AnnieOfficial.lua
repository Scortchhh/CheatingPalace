
Annie = {} 
function Annie:__init()

    self.KeyNames = {}
    self.KeyNames[4]         = "HK_SUMMONER1"
    self.KeyNames[5]         = "HK_SUMMONER2"
    
    self.KeyNames[6]         = "HK_ITEM1"
    self.KeyNames[7]         = "HK_ITEM2"
    self.KeyNames[8]         = "HK_ITEM3"
    self.KeyNames[9]         = "HK_ITEM4"
    self.KeyNames[10]         = "HK_ITEM5"
    self.KeyNames[11]        = "HK_ITEM6"

    self.QRange = 625 
    self.WRange = 600
    self.ERange = 800 
    self.RRange = 600

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.RSpeed = math.huge

    self.QDelay = 0
    self.WDelay = 0
    self.RDelay = 0

    self.ScriptVersion = "            Annie by Sheep" 
    self.ChampionMenu = Menu:CreateMenu("Annie") 
    
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
    Annie:LoadSettings()  
end 

-- Save Settings Function
function Annie:SaveSettings() 
    
    SettingsManager:CreateSettings("Annie")
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
function Annie:LoadSettings()
    SettingsManager:GetSettingsFile("Annie")
    
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

local function EnemiesInRange(Position, Range) ---- 
	local Count = 0 
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count -----------????
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

local function GetHeroLevel(Target) -- 
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Annie:Damage(Target)
    local Qdmg = GetDamage(45 + (35 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.75, false, Target)
    local Wdmg = GetDamage(25 + (45 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.85, false, Target)
    local Rdmg = GetDamage(25 + (125 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower * 0.75, false, Target)
    local iDmg = 55 + (25 * GetHeroLevel(myHero)) 
    local Ignite = self:Ignite_Check(2000)
    local IgniteBuff    = Target.BuffData:GetBuff('SummonerDot') 

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

--local Annie

function Annie:LastHitQ() 
    if Engine:SpellReady("HK_SPELL1") and self.QLasthit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    local qDmg = GetDamage(45+ (35 * myHero:GetSpellSlot(0).Level) + 0.8 * (myHero.AbilityPower), true, Minion) 
                    if Minion.Health <= qDmg then
                        return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    end
                end
            end
        end
    end
end
function Annie:BuildStun() 
    
    if Engine:SpellReady("HK_SPELL3") then
        
        local Q = Engine:SpellReady("HK_SPELL1")
        local W = Engine:SpellReady("HK_SPELL2")
        local R = Engine:SpellReady("HK_SPELL4")
        local target = Orbwalker:GetTarget("Combo", 610)
        local Stack = myHero.BuffData:GetBuff("anniepassivestack")
        local Stun = myHero.BuffData:GetBuff("anniepassiveprimed ")
        if Stun.Count_Alt == 0 and target then 
            if Stack.Count_Alt == 3 then
                if R or W or Q then
                    return Engine:ReleaseSpell("HK_SPELL3", nil) 
                end 
            end
            if Stack.Count_Alt == 2 then
                if (Q and W) then
                    return Engine:ReleaseSpell("HK_SPELL3", nil)
                end
                if myHero:GetSpellSlot(3).Info.Name == "AnnieR" then                                                                                                                                                    
                    if (Annie:Damage(target) >= target.Health or Annie:AlliesInRange(target.Position, 900) > 0 and R and W) or (Annie:Damage(target) >= target.Health or Annie:AlliesInRange(target.Position, 900) > 0 and R and Q) then
                        return Engine:ReleaseSpell("HK_SPELL3", nil)  
                    end
                end
            end 
        end 
    end
end

function Annie:SortToLowestHealth(Table)
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

function Annie:GetTarget(Range, HealthPercentage)
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

function Annie:GetSummonerKey(SummonerName)
    for i = 4 , 5 do
        if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
            return self.KeyNames[i]
        end
    end
    return nil
end

function Annie:Ignite_Check(Range)
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

function Annie:AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
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

function Annie:Tibbers()
    local Minions = ObjectManager.MinionList 
    for _, Minion in pairs(Minions) do 
     
        if Minion.Name == "Tibbers" then 
              return true 
        end
    end 
    return false 
end

function Annie:IgniteKS()
    local Ignite                = self:Ignite_Check(600)
    if Ignite ~= false then 
        if self:Damage(Ignite.Target) >= (Ignite.Target.Health) then
            return Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)
         end  
    end    
end

function Annie:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLasthit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    local qDmg = GetDamage(45+ (35 * myHero:GetSpellSlot(0).Level) + 0.8 * (myHero.AbilityPower), true, Minion) 
                    if Minion.Health <= qDmg then
                        return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    end
                end
            end
        end
    end
end

------------- FULL COMBO MODE
function Annie:Combo()
    Annie:Ultimate()
    Annie:IgniteKS()
    if self.ComboE.Value == 1 then 
        Annie:BuildStun()
    end

 

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange, self.QDelay, 0.25) -- 
        if target ~= nil then
            return Engine:CastSpell("HK_SPELL1", target.Position, 1) 
        end
    end
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange - 50, 1400, 90, 0.25, 0) 
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.WRange then
                return Engine:CastSpell("HK_SPELL2", CastPos, 1)
            end
        end
    end
end


function Annie:Ultimate() 
    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') and myHero:GetSpellSlot(3).Info.Name == "AnnieR" then --  THis is checcking if tibbers myHero:GetSpellSlot(3).Info.Name = "AnnieR" /// Annie:Tibbers() ~= true
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 600 then
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local RDamage = {150, 275, 400}
                    local Rbonus = (myHero.AbilityPower * 0.75)
                    local RRdmg = GetDamage(RDamage[RLevel] + Rbonus, false, target)
                    if Annie:Damage(target) >= target.Health or Annie:AlliesInRange(target.Position, 900) > 0 then -- 0 number of ally, 0 will count annie as an ally., may need to decrease 900 range 
                        local CastPos, target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 0, self.RDelay, 0) 
                        if CastPos ~= nil then
                            return Engine:ReleaseSpell("HK_SPELL4", CastPos) 
                        end
                    end
                end
            end
        end
    end
end
function Annie:Harass()
   -- print(harass)
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
    if self.HarassWValue == 1 and Engine:SpellReady("HK_SPELL2") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
        if CastPos ~= nil then
            if GetDist(myHero.Position, CastPos) <= self.WRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    return Engine:CastSpell("HK_SPELL2", CastPos, 1) 
                end
            end
        end
    end
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then 
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                return Engine:CastSpell("HK_SPELL3", nil, 1)
            end
        end
    end
end
function Annie:Laneclear()

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

function Annie:KillHealthBox()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if Hero.IsTargetable then

                local CurrentDmg = self:Damage(Hero) 
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

function Annie:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        
        if Evade.CanEvadeInTime == false and Evade.evadePos ~= nil then
            if Engine:SpellReady("HK_SPELL3") then
                return Engine:ReleaseSpell("HK_SPELL3", Evade.evadePos)
            end
        end 

        if Engine:IsKeyDown("HK_COMBO") then
            --Annie:Ultimate()
            Annie:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Annie:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Annie:LastHitQ()
            Annie:Laneclear()
		end 
        if Engine:IsKeyDown("HK_LASTHIT") then
            Annie:LastHitQ()
        end
	end
end
function Annie:OnDraw()
    if self.DrawKillable.Value == 1 then
        Annie:KillHealthBox()
    end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end
function Annie:OnLoad()
    if(myHero.ChampionName ~= "Annie") then return end
	AddEvent("OnSettingsSave" , function() Annie:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Annie:LoadSettings() end)
	Annie:__init()
	AddEvent("OnTick", function() Annie:OnTick() end)	
    AddEvent("OnDraw", function() Annie:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Annie:OnLoad() end)	









