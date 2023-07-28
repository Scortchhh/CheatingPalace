Chogath = {} 

function Chogath:__init() 

    self.ETimer = 0
    
    self.QRange = 950
    self.WRange = 650
    self.ERange = 500
    self.RRange = 250

    self.WSpeed = math.huge
    self.QSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QWidth = 250
    self.WWidth = 150

    self.WDelay = 0.5
    self.QDelay = 1.127 --knock up after 1 sec and .5 delay
    self.EDelay = 0.25
    self.RDelay = 0.25

    self.QHitChance = 0.35
    self.WHitChance = 0.35

    self.ScriptVersion = "Chogath by Sheep" 

    

    self.ChampionMenu = Menu:CreateMenu("Chogath") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R on low hp", 1) 
    self.ComboRSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
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
    Chogath:LoadSettings()  
end 

function Chogath:SaveSettings() 

    SettingsManager:CreateSettings("Chogath")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R on low hp", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.ComboRSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Chogath:LoadSettings()
    SettingsManager:GetSettingsFile("Chogath")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboRR.Value = SettingsManager:GetSettingsInt("Combo","Use R on low hp")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
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

function Chogath:Damage(Target)
    local Qdmg = GetDamage(25 + (55 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 1.0, false, Target)
    local Wdmg = GetDamage(25 + (50 * myHero:GetSpellSlot(1).Level) + myHero.AbilityPower * 0.70, false, Target)
    local Rdmg = GetDamage(125 + (175 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower * 0.50, false, Target) -- NEED TO ADD HEALTH SCALING
    --local iDmg = 55 + (25 * GetHeroLevel(myHero)) --IGNITE HERE DOWN
    --local Ignite = self:Ignite_Check(2000)
    --local IgniteBuff    = Target.BuffData:GetBuff('SummonerDot') --SummonerDot

    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 and  Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + Qdmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = FinalFullDmg + Wdmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1 then
        FinalFullDmg = FinalFullDmg + Rdmg
    end
   --[[ if Ignite ~= false or IgniteBuff.Valid or IgniteBuff.Count_Alt > 0 then
        FinalFullDmg = FinalFullDmg + iDmg
    end]]
    return FinalFullDmg
end




function Chogath:TargetIsImmune(currentTarget)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "PantheonE",  "WillRevive", "sionpassivezombie", "rebirthready", "willrevive", "ZileanR"
    }
    for i = 1, #ImmuneBuffs do
        local Buff = ImmuneBuffs[i]
        if currentTarget.BuffData:GetBuff(Buff).Valid or currentTarget.BuffData:GetBuff(Buff).Count_Alt > 0 then
            return true
        end
    end
    return false
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


local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end


function Chogath:Ultimate() -- WILL ONLY COMBO IF ALLY IS NEARBY OR KILLABLE
    if self.ComboRR.Value == 1 and Engine:SpellReady('HK_SPELL4') and myHero:GetSpellSlot(3).Info.Name == "Feast" then --  THis is checcking if tibbers myHero:GetSpellSlot(3).Info.Name = "AnnieR" /// Annie:Tibbers() ~= true
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false and Chogath:TargetIsImmune(target) == false then
                if GetDist(myHero.Position, target.Position) <= 225 + myHero.AttackRange - 125 then --- need it to be a little less or will get magnetic
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local RDamage = {300, 475, 650}
                    local Rbonus = (myHero.AbilityPower * 0.50)
                    local RHbonus = (myHero.MaxHealth - (574 + 80 * (GetHeroLevel(myHero) - 1))) * 0.1
                    local RRdmg = (RDamage[RLevel] + Rbonus + RHbonus)
                    if RRdmg >= target.Health then  --Chogath:AlliesInRange(target.Position, 900) > 0 then -- 0 number of ally, 0 will count annie as an ally., may need to decrease 900 range 
                        return Engine:CastSpell("HK_SPELL4", target.Position, 1) -- Engine:ReleaseSpell("HK_SPELL4", CastPos, 1) -- faster cast if not target champions, 0 minions and champs
                        
                    end
                end
            end
        end
    end
end


function Chogath:UltimateObj() -- WILL ONLY COMBO IF ALLY IS NEARBY OR KILLABLE
    if self.ComboRR.Value == 1 and Engine:SpellReady('HK_SPELL4') and myHero:GetSpellSlot(3).Info.Name == "Feast" then --  THis is checcking if tibbers myHero:GetSpellSlot(3).Info.Name = "AnnieR" /// Annie:Tibbers() ~= true
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false and Chogath:TargetIsImmune(target) == false then
                if GetDist(myHero.Position, target.Position) <= 225 + myHero.AttackRange - 125 then --- need it to be a little less or will get magnetic
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local RDamage = {300, 475, 650}
                    local Rbonus = (myHero.AbilityPower * 0.50)
                    local RHbonus = (myHero.MaxHealth - (574 + 80 * (GetHeroLevel(myHero) - 1))) * 0.1
                    local RRdmg = (RDamage[RLevel] + Rbonus + RHbonus)
                    if RRdmg >= target.Health then  --Chogath:AlliesInRange(target.Position, 900) > 0 then -- 0 number of ally, 0 will count annie as an ally., may need to decrease 900 range 
                        return Engine:CastSpell("HK_SPELL4", target.Position, 1) -- Engine:ReleaseSpell("HK_SPELL4", CastPos, 1) -- faster cast if not target champions, 0 minions and champs
                        
                    end
                end
            end
        end
    end
end

function Chogath:Combo()

    
    
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
        if PredPos then
            if GetDist(myHero.Position, PredPos) <= self.WRange then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end
    
    
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
        if PredPos then
            if GetDist(myHero.Position, PredPos) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
    
  --[[  if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local EBuff = myHero.BuffData:GetBuff("VorpalSpikes")
 
        if (os.clock() - Orbwalker.AttackTimer) > Orbwalker.LastWindup * 0.8 and (os.clock() - Orbwalker.AttackTimer) < Orbwalker.LastWindup + 0.1 and not EBuff.Valid and EBuff.Count_Alt == 0 then
            Engine:CastSpell("HK_SPELL3", nil, 0) -- nil instead of my Hero position
        end
    end]]
    

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local EBuff = myHero.BuffData:GetBuff("VorpalSpikes")
        local Target = Orbwalker:GetTarget("Combo", getAttackRange())
 
        if Target and Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0 and not EBuff.Valid and EBuff.Count_Alt == 0 then
            
            Engine:CastSpell("HK_SPELL3", nil, 0) -- nil instead of my Hero position
        end
    end


end


function Chogath:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
        if PredPos then
            if GetDist(myHero.Position, PredPos) <= self.WRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Chogath:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target and target.IsMinion then -- and target.IsMinion  check if target is minion
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target and target.IsMinion then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local EBuff = myHero.BuffData:GetBuff("VorpalSpikes")
        local Target = Orbwalker:GetTarget("Laneclear", getAttackRange())
 
        if Target and Orbwalker.ResetReady == 1 and Orbwalker.Attack == 0 and not EBuff.Valid and EBuff.Count_Alt == 0 then
            
            Engine:CastSpell("HK_SPELL3", nil, 0) -- nil instead of my Hero position
        end
    end

end

--end---


function Chogath:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then

        Chogath:Ultimate()

        --local ChoE = myHero.BuffData:GetBuff("VorpalSpikes"))
     --if ChoE = true then 
        --print(myHero.AttackRange)
            --print(self.RRange)
        --print(myHero:GetSpellSlot(2).Info.Name)
       -- print(myHero:GetSpellSlot(2).Cooldown)
        --Chogath:Ultimate()
        --print(myHero.BuffData:ShowAllBuffs()) ---VorpalSpikes

        

        

        if Engine:IsKeyDown("HK_COMBO") then
            Chogath:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Chogath:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Chogath:Laneclear()
		end
        
	end
end

function Chogath:OnDraw()

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange + myHero.AttackRange - 125 ,100,150,255,255)
    end
end

function Chogath:OnLoad()
    if(myHero.ChampionName ~= "Chogath") then return end
	AddEvent("OnSettingsSave" , function() Chogath:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Chogath:LoadSettings() end)


	Chogath:__init()
	AddEvent("OnTick", function() Chogath:OnTick() end)	
    AddEvent("OnDraw", function() Chogath:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Chogath:OnLoad() end)	
