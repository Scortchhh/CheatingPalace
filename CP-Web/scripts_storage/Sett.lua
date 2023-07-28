--Credits to Critic, Scortch, Christoph, Jett
Sett = {} 

function Sett:__init() 
    self.QRange = 400
    self.WRange = 725
    self.ERange = 490
    self.RRange = 400 

    self.QSpeed = math.huge 
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.WWidth = 60

    self.QDelay = 0.25
    self.WDelay = 0.75
    self.EDelay = 0.30

    self.WHitChance = 0.2

    self.ScriptVersion = "         Sett Ver: 2.0 CREDITS Derang3d" 

    self.ChampionMenu = Menu:CreateMenu("Sett") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
	self.ComboWSlider = self.ComboMenu:AddSlider("Use W if Grit Above %", 20, 0, 100, 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("R KS", 1)
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R in Combo w/ enemies", 1)
    self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 1, 4, 1)
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
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw if killable", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    self.DrawRR = self.DrawMenu:AddCheckbox("Draw R knockback", 1)
    --------------------------------------------
    Sett:LoadSettings()  
end 

function Sett:SaveSettings() 
    SettingsManager:CreateSettings("Sett")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W if Grit Above %", self.ComboWSlider.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R in Combo w/ enemies", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)
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
    SettingsManager:AddSettingsInt("Draw if killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Draw R knockback", self.DrawRR.Value)
    --------------------------------------------
end

function Sett:LoadSettings()
    SettingsManager:GetSettingsFile("Sett")
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboWSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use W if Grit Above %")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo w/ enemies")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    self.DrawRR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R knockback")
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

function Sett:Damage(Target)

    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local Righthanddmg = (5 * totalLevel) + (TotalAD * .5)
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {10, 20, 30, 40, 50}
        Qbonus = (myHero.BonusAttack * 1)
        QQdmg = (10 * QLevel) + (0.1 + ((0.05 + (0.05 * QLevel)) * (TotalAD / 100) * Target.MaxHealth))
        QQQdmg = (10 * QLevel) + (0.1 + ((0.05 + (0.05 * QLevel)) * (TotalAD / 100) * Target.MaxHealth)) + Righthanddmg
        totalqdmg = QQdmg + QQQdmg
    end

    local WLevel = myHero:GetSpellSlot(1).Level
    local WDamage
    local WWdmg
    if WLevel ~= 0 then
        WDamage = {80, 100, 120, 140, 160}
        Wbonus = (TotalAD * 0.60) + (.10 * (myHero.BonusAttack / 100) * (.25 / (myHero.Mana - myHero.MaxMana)))
        WWdmg = WDamage[WLevel] 
    end

    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {50, 70, 90, 110, 130}
        Ebonus = (TotalAD * 0.60)
        EEdmg = EDamage[ELevel]
    end

    local RLevel = myHero:GetSpellSlot(3).Level
    local RDamage
    local Rbonus
    local RRdmg
    if RLevel ~= 0 then
        RDamage = {200, 300, 400}
        Rbonus = (myHero.BonusAttack * 1)
        RRdmg = RDamage[RLevel] + Rbonus
    end
    local FinalFullDmg = 0

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + totalqdmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = FinalFullDmg + (WWdmg + Wbonus)
    end
    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        FinalFullDmg = FinalFullDmg + (EEdmg + Ebonus)
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        FinalFullDmg = (FinalFullDmg + RRdmg) 
    end

    return FinalFullDmg
end

function Sett:RCastPos(Target)
    local Target = Orbwalker:GetTarget("Combo", 1200)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 600
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Sett:rUlti()
    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 400 then
                    local Settdmg = GetDamage(100 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.BonusAttack * 1.0), true, target)
                    if Settdmg >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1 then
        local Target = Orbwalker:GetTarget("Combo", self.RRange)
        if Target ~= nil then
                if EnemiesInRange(self:RCastPos(), 600) >= self.ComboRSlider.Value then
                    Engine:CastSpell("HK_SPELL4", Target.Position, 1)
                    return
                end
        end
    end

end

function Sett:HealthCheck(Hero)

    if  Engine:SpellReady("HK_SPELL2") then
			if EnemiesInRange(myHero.Position, 500) == 5 and myHero.Health <= myHero.MaxHealth / 100 * 70 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 4 and myHero.Health <= myHero.MaxHealth / 100 * 60 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 3 and myHero.Health <= myHero.MaxHealth / 100 * 50 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 2 and myHero.Health <= myHero.MaxHealth / 100 * 40 then
				return true
			end
			if EnemiesInRange(myHero.Position, 500) == 1 and myHero.Health <= myHero.MaxHealth / 100 * 30 then
				return true
			end
	end
	return false
end


function Sett:Combo()
    local wcd = (myHero:GetSpellSlot(1).Cooldown - GameClock.Time > 1)

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target ~= nil then
            Engine:CastSpell("HK_SPELL1", nil , 1)
            return
        end
    end
        -- combo w grit manager
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL3") then
        local sliderValue = self.ComboWSlider.Value
        local condition = myHero.MaxMana / 100 * sliderValue
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if PredPos and Target and GetDist(PredPos,myHero.Position) < self.WRange-15 and myHero.Mana >= condition then
            Engine:CastSpell("HK_SPELL2", PredPos, 0)
            return
        end
    end
    -- combo w health check
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then 
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if PredPos and Target and GetDist(PredPos,myHero.Position) < self.WRange-15 and self:HealthCheck(Hero) then
            Engine:CastSpell("HK_SPELL2", PredPos, 0)
            return
        end
    end
        
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1   and not wcd then
        local Heros1 = ObjectManager.HeroList
        local Heros2 = ObjectManager.HeroList
        for _, Hero1 in pairs(Heros1)  do
            for _, Hero2 in pairs(Heros2)  do
                if Hero1 ~= Hero2  and GetDist(Hero2.Position,myHero.Position) < self.ERange and GetDist(Hero1.Position,myHero.Position) < self.ERange  then
                    if Hero1.IsTargetable and Hero1.Team ~= myHero.Team and Hero2.IsTargetable and Hero2.Team ~= myHero.Team and Prediction:PointOnLineSegment(Hero1.Position, Hero2.Position , myHero.Position, 70) then
                        Engine:CastSpell("HK_SPELL3", Hero1.Position , 1)
                        return
                    end
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1  and not wcd then
        local Heros1 = ObjectManager.HeroList
        local Minion1 = ObjectManager.MinionList
        for _, Hero1 in pairs(Heros1)  do
            for _, Minion1 in pairs(Minion1)  do
                if Hero1 ~= Hero2  and GetDist(Minion1.Position,myHero.Position) < self.ERange and GetDist(Hero1.Position,myHero.Position) < self.ERange  then
                    if Hero1.IsTargetable and Hero1.Team ~= myHero.Team and Minion1.IsDead == false and Minion1.MaxHealth > 10 and Prediction:PointOnLineSegment(Hero1.Position, Minion1.Position , myHero.Position, 70) then
                        Engine:CastSpell("HK_SPELL3", Hero1.Position , 1)
                        return
                    end
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and EnemiesInRange(myHero.Position, 1000) < 2 and MinionsInRange(myHero.Position, 500) < 1  and not wcd then 
        local Target = Orbwalker:GetTarget("Harass", self.ERange)
        if Target ~= nil and GetDist(Target.Position,myHero.Position) < self.ERange-15 then
            Engine:CastSpell("HK_SPELL3", Target.Position, 1)
        end
    end
end

function Sett:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Harass", self.QRange)
        if Target ~= nil and Target.IsHero then
            Engine:CastSpell("HK_SPELL1", nil , 1)
            return
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL3") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if PredPos and Target and GetDist(PredPos,myHero.Position) < self.WRange-15  and Target.IsHero  then
            Engine:CastSpell("HK_SPELL2", PredPos, 0)
            return
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Harass", self.ERange)
        if Target ~= nil and GetDist(Target.Position,myHero.Position) < self.ERange-15 and Target.IsHero then
            Engine:CastSpell("HK_SPELL3", Target.Position, 1)
        end
    end
end

function Sett:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target and Target.MaxHealth > 10 and Target.IsTargetable then
            Engine:CastSpell("HK_SPELL1", nil , 0)
            return
        end
    end

    if self.ClearW.Value == 1  and Engine:SpellReady("HK_SPELL2") then
        local Target = Orbwalker:GetTarget("Laneclear", self.WRange - 15)
        local sliderValue = self.ComboWSlider.Value
        local condition = myHero.MaxMana / 100 * sliderValue
        if Target and Target.MaxHealth > 10 and Target.IsTargetable and myHero.Mana >= condition then
            Engine:CastSpell("HK_SPELL2", Target.Position , 0)
            return
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Laneclear", self.ERange - 15)
        if Target and Target.MaxHealth > 10 and Target.IsTargetable then
            Engine:CastSpell("HK_SPELL3", Target.Position , 0)
            return
        end
    end
end

function Sett:KillHealthBox()
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

function Sett:OnTick()
   
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            Sett:rUlti()
            Sett:HealthCheck()
        if Engine:IsKeyDown("HK_COMBO") then
            Sett:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sett:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sett:Laneclear()
		end
	end
end

function Sett:OnDraw()
    if self.DrawKillable.Value == 1 then
        Sett:KillHealthBox()
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
    if Engine:SpellReady("HK_SPELL4") and self.DrawRR.Value == 1 then
        local Target = Orbwalker:GetTarget("Combo", 1200)
        if Target ~= nil then
            Render:DrawCircle(Sett:RCastPos(), 400,100,150,255,255)
        end
    end
end

function Sett:OnLoad()
    if(myHero.ChampionName ~= "Sett") then return end
	AddEvent("OnSettingsSave" , function() Sett:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sett:LoadSettings() end)


	Sett:__init()
	AddEvent("OnTick", function() Sett:OnTick() end)	
    AddEvent("OnDraw", function() Sett:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Sett:OnLoad() end)	
