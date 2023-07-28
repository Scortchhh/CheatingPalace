--Credits to Critic, Scortch, Christoph

Veigar = {} 

function Veigar:__init() 

    
    self.QRange = 950
    self.WRange = 900
    self.ERange = 725
    self.RRange = 650
    self.WmaxRange = 400
    self.WminRange = 200

    self.QDelay = 0.25
    self.WDelay = 1.45
    self.EDelay = 1.3
    self.RDelay = 0.25

    self.QWidth = 140
    self.WWidth = 240
    self.EWidth = 390

    self.QSpeed = 2200
    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.QHitChance = 0.2
    self.WHitChance = 0.2
    self.EHitChance = 0.2

    self.ScriptVersion = "         Veigar Ver: 2 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("Veigar") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
	self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)
	self.AutoStunned = self.ComboMenu:AddCheckbox("Auto Stun Stunned", 1)
    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    --self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.QLasthit = self.MiscMenu:AddCheckbox("Last hit with Q")

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw Killable", 1) 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Veigar:LoadSettings()
end

function Veigar:SaveSettings() 
  

    --combo save settings--
    SettingsManager:CreateSettings("Veigar")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Auto Stun Stunned", self.AutoStunned.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Last hit with Q", self.QLasthit.Value)

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Veigar:LoadSettings()
    SettingsManager:GetSettingsFile("Veigar")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo")
    self.AutoStunned.Value = SettingsManager:GetSettingsInt("Combo", "Auto Stun Stunned")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.QLasthit.Value = SettingsManager:GetSettingsInt("Misc", "Last hit with Q")
    
     --------------------------------Draw load----------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw Killable")
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

function Veigar:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLasthit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false and Minion.MaxHealth > 10  then
                if GetDist(myHero.Position, Minion.Position) <= self.QRange then
                    local qDmg = GetDamage(40 + (40 * myHero:GetSpellSlot(0).Level) + 0.6 * (myHero.AbilityPower), true, Minion) 
                    if Minion.Health <= qDmg then
                        return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    end
                end
            end
        end
    end
end



function Veigar:Ultr()
    local HeroList = ObjectManager.HeroList
    for i, target in pairs(HeroList) do
        if Engine:SpellReady('HK_SPELL4') and self.ComboR.Value == 1 then
            if target.Team ~= myHero.Team and target.IsTargetable then
                if GetDist(myHero.Position, target.Position) <= 650 then
                    local hBurst = 1 + math.min(1, (1.5 - target.Health / target.MaxHealth) * 20/7)
                    local pBurst = GetDamage(100 + (75 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75), false, target) * hBurst
                    if pBurst >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end
end

-----combo-----
function Veigar:GetECastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 390
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Veigar:GetECastPos2(CastPos2)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos2
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -390
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end


function Veigar:AutoStun()
    if self.AutoStunned.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local CastPos, Target 		= Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
		if CastPos ~= nil and Target ~= nil then
            if Target.BuffData:HasBuffOfType(BuffType.Stun) or Target.BuffData:HasBuffOfType(BuffType.Snare) or Target.BuffData:HasBuffOfType(BuffType.Asleep) or Target.BuffData:HasBuffOfType(BuffType.Suppression) or Target.BuffData:HasBuffOfType(BuffType.Knockup) then
                CastPos = self:GetECastPos(CastPos)
                if GetDist(myHero.Position, CastPos) < self.ERange then
                    Engine:CastSpell("HK_SPELL3", CastPos ,1)
                    return
                end
            end
        end
		local CastPos2, Target 		= Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
		if CastPos2 ~= nil and Target ~= nil then
            if Target.BuffData:HasBuffOfType(BuffType.Stun) or Target.BuffData:HasBuffOfType(BuffType.Snare) or Target.BuffData:HasBuffOfType(BuffType.Asleep) or Target.BuffData:HasBuffOfType(BuffType.Suppression) or Target.BuffData:HasBuffOfType(BuffType.Knockup) then
                CastPos2 = self:GetECastPos2(CastPos2)
                if GetDist(myHero.Position, CastPos2) < self.ERange then
                    Engine:CastSpell("HK_SPELL3", CastPos2 ,1)
                    return
                end
            end
        end
    end
end

function Veigar:Combo()
	if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
		if PredPos ~= nil then
            if GetDist(myHero.Position, PredPos) < self.ERange then
                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                return
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2")  then 
        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
		if PredPos ~= nil and target ~= nil then
            local WKS = GetDamage(50 + (50 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 1), false, target)
            if WKS > target.Health then
                if GetDist(myHero.Position, PredPos) < self.WRange then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
            if target.BuffData:HasBuffOfType(BuffType.Stun) or target.BuffData:HasBuffOfType(BuffType.Snare) or target.BuffData:HasBuffOfType(BuffType.Asleep) or target.BuffData:HasBuffOfType(BuffType.Suppression) or target.BuffData:HasBuffOfType(BuffType.Knockup) then
                if GetDist(myHero.Position, target.Position) < self.WRange then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end

   if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL3") then 
        local ecd = myHero:GetSpellSlot(2).Cooldown - GameClock.Time
        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
		if PredPos ~= nil and ecd < 8 and ecd > 6  then
            if GetDist(myHero.Position, PredPos) < self.WRange then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.QRange then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end
end

function Veigar:Harass()

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
        if CastPos ~= nil  then
            CastPos = self:GetECastPos(CastPos)
            if GetDist(myHero.Position, CastPos) < self.ERange then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                return
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2")  then 
        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
		if PredPos ~= nil and target ~= nil then
            local WKS = GetDamage(50 + (50 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 1), false, target)
            if WKS > target.Health then
                if GetDist(myHero.Position, PredPos) < self.WRange then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
            if target.BuffData:HasBuffOfType(BuffType.Stun) or target.BuffData:HasBuffOfType(BuffType.Snare) or target.BuffData:HasBuffOfType(BuffType.Asleep) or target.BuffData:HasBuffOfType(BuffType.Suppression) or target.BuffData:HasBuffOfType(BuffType.Knockup) then
                if GetDist(myHero.Position, target.Position) < self.WRange then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) < self.QRange then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end
end

function Veigar:Laneclear()

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
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
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", Minion.Position, 0)
                    return
                end
            end
        end
    end
end


function Veigar:Damage(Target)

    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {80, 120, 160, 200, 240}
        Qbonus = (myHero.AbilityPower * .6)
        totalqdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
    end

    local WLevel = myHero:GetSpellSlot(1).Level
    local WDamage
    local WWdmg
    if WLevel ~= 0 then
        WDamage = {100, 150, 200, 250, 300}
        Wbonus = (myHero.AbilityPower * 1)
        totalwdmg = GetDamage(WDamage[WLevel] + Wbonus, false, Target)
    end

    local RLevel = myHero:GetSpellSlot(3).Level
    local RRdmg
    if RLevel ~= 0 then
        local hBurst = 1 + math.min(1, (1.5 - Target.Health / Target.MaxHealth) * 20/7)
        totalrdmg = GetDamage(100 + (75 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75), false, Target) * hBurst
    end
    local FinalFullDmg = 0

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + totalqdmg
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = FinalFullDmg + totalwdmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        FinalFullDmg = FinalFullDmg + totalrdmg 
    end

    return FinalFullDmg
end

function Veigar:KillHealthBox()
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

--end---


function Veigar:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Veigar:AutoStun()
        Veigar:Ultr()
        if Engine:IsKeyDown("HK_COMBO") then
            Veigar:Combo()
            Veigar:Ultr()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Veigar:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Veigar:LastHitQ()
            Veigar:Laneclear()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Veigar:LastHitQ()
        end
	end
end

function Veigar:OnDraw()
    if self.DrawKillable.Value == 1 then
        Veigar:KillHealthBox()
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
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Veigar:OnLoad()
    if(myHero.ChampionName ~= "Veigar") then return end
	AddEvent("OnSettingsSave" , function() Veigar:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Veigar:LoadSettings() end)


	Veigar:__init()
	AddEvent("OnTick", function() Veigar:OnTick() end)	
    AddEvent("OnDraw", function() Veigar:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Veigar:OnLoad() end)	
