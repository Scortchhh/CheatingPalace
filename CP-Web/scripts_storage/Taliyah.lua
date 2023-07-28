--Credits to Critic, Scortch, Christoph
--1.5
Taliyah = {} 

function Taliyah:__init() 

    
    self.QRange = 1000
    self.WRange = 900
    self.ERange = 650

    self.QSpeed = math.huge 
    self.WSpeed = math.huge
    self.ESpeed = 850

    self.QDelay = 0.25
    self.WDelay = 1.3
    self.EDelay = 0.25

    self.ScriptVersion = "         Taliyah Ver: 1" 

    

    self.ChampionMenu = Menu:CreateMenu("Taliyah") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
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
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw Killbox", 1) 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Taliyah:LoadSettings()  
end 

function Taliyah:SaveSettings() 

    SettingsManager:CreateSettings("Taliyah")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
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
    SettingsManager:AddSettingsInt("Draw Killbox", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Taliyah:LoadSettings()
    SettingsManager:GetSettingsFile("Taliyah")
     ------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo") 
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw Killbox")
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

function Taliyah:Damage(Target)

    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {70, 95, 120, 145, 170}
        Qbonus = (myHero.AbilityPower * 0.45)
        QQdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
        totalqdmg = QQdmg + ((QQdmg  / 2) * 5)
    end

    local WLevel = myHero:GetSpellSlot(1).Level
    local WDamage
    local WWdmg
    if WLevel ~= 0 then
        WDamage = {60, 80, 100, 125, 150}
        Wbonus = (myHero.AbilityPower * 0.40)
        WWdmg = GetDamage(WDamage[WLevel] + Wbonus, false, Target)
    end

    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {50, 75, 100, 125, 150}
        Ebonus = (myHero.AbilityPower * 0.40)
        EEDamage = {50, 60, 70, 80, 90}
        EEbonus = (myHero.AbilityPower * 0.40)
        EEdmg = (EDamage[ELevel] + Ebonus) + ((EEDamage[ELevel] + EEbonus) * 3)
    end

    local FinalFullDmg = 0

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + totalqdmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = FinalFullDmg + WWdmg
    end
    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EEdmg
    end

    return FinalFullDmg
end


function Taliyah:GetWCastBehind(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

--taliyahemineslow
-----combo-----
function Taliyah:Combo()

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 40, self.QDelay, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.QRange then 
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end 

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.ERange then 
            Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
    end 
     
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", 1000)
        if target ~= nil then
            local mines = target.BuffData:GetBuff("taliyahemineslow")
            local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
            if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.WRange and mines.Count_Alt > 0 then
                if EnemiesInRange(myHero.Position, 300) < 1 then
                    return Engine:CastSpell2Points("HK_SPELL2", PredPos, myHero.Position, 0)
                else
                    local CastPos   = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
                    CastPos = self:GetWCastBehind(CastPos)
                    return Engine:CastSpell2Points("HK_SPELL2", PredPos, CastPos, 0)
                end
            end
        end
    end
end

function Taliyah:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 70, self.QDelay, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.QRange then 
            Engine:CastSpell("HK_SPELL1", PredPos, 0)
            return
        end
    end 

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.ERange then 
            Engine:CastSpell("HK_SPELL3", PredPos, 0)
            return
        end
    end 
     
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.WRange then
            if EnemiesInRange(myHero.Position, 300) < 1 then
                return Engine:CastSpell2Points("HK_SPELL2", PredPos, myHero.Position, 0)
            else
                local CastPos   = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
                CastPos = self:GetWCastBehind(CastPos)
                return Engine:CastSpell2Points("HK_SPELL2", PredPos, CastPos, 0)
            end
        end
    end
end

function Taliyah:Laneclear()

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.WRange  then
                    Engine:CastSpell("HK_SPELL2", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 and Minion.IsTargetable then
                if GetDist(myHero.Position, Minion.Position) <= self.ERange then
                    Engine:CastSpell("HK_SPELL3", Minion.Position, 0)
                    return
                end
            end
        end
    end

end

function Taliyah:KillHealthBox()
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


function Taliyah:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsDead == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Taliyah:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Taliyah:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Taliyah:Laneclear()
		end
	end
end

function Taliyah:OnDraw()
    if self.DrawKillable.Value == 1 then
        Taliyah:KillHealthBox()
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        RRange = {3000, 4500, 6000}
        RLevel = myHero:GetSpellSlot(3).Level
        RRdraw = RRange[RLevel]
        Render:DrawCircle(myHero.Position, RRdraw ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Taliyah:OnLoad()
    if(myHero.ChampionName ~= "Taliyah") then return end
	AddEvent("OnSettingsSave" , function() Taliyah:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Taliyah:LoadSettings() end)


	Taliyah:__init()
	AddEvent("OnTick", function() Taliyah:OnTick() end)	
    AddEvent("OnDraw", function() Taliyah:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Taliyah:OnLoad() end)	
