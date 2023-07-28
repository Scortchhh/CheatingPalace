--Credits to Critic, Scortch, Christoph
Zed = {} 

function Zed:__init() 
    self.QRange = 925
    self.QSpeed = 1700 
    self.QWidth = 100
    self.QDelay = 0.25

    self.WRange = 650
    self.ERange = 280 
    self.RRange = 625

    self.WSpeed = 2500
    self.WDelay = 0
    self.wTimer       = 0
    self.Shad0ws = {}

    self.QHitChance = 0.2

    self.ScriptVersion = "         Zed Ver: 1.0 CREDITS Derang3d" 

    self.ChampionMenu = Menu:CreateMenu("Zed") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use E ability on x minions", 3,1,5,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw if killable w/ R", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    self.DrawFQ = self.DrawMenu:AddCheckbox("Draw W+Q", 1) 
    self.DrawS = self.DrawMenu:AddCheckbox("Draw Shadows", 1) 
    --------------------------------------------
    self.Shadow = nil
    Zed:LoadSettings()  
end 

function Zed:SaveSettings() 
    SettingsManager:CreateSettings("Zed")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use E ability on x minions", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw if killable w/ R", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Draw W+Q", self.DrawFQ.Value)
    SettingsManager:AddSettingsInt("Draw Shadows", self.DrawS.Value)
    --------------------------------------------
end

function Zed:LoadSettings()
    SettingsManager:GetSettingsFile("Zed")
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo") 
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use E ability on x minions")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable w/ R")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    self.DrawFQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw W+Q")
    self.DrawS.Value = SettingsManager:GetSettingsInt("Drawings","Draw Shadows")
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

function Zed:Wallcheck(Position)
	local PlayerPos = myHero.Position
	local ToTargetVec = Vector3.new(Position.x - PlayerPos.x, Position.y - PlayerPos.y, Position.z - PlayerPos.z)
	local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
	local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
	for Range = 30 , Distance, 25 do
		local CurrentPos = Vector3.new(PlayerPos.x + (VectorNorm.x*Range), PlayerPos.y + (VectorNorm.y*Range), PlayerPos.z + (VectorNorm.z*Range))
		if Engine:IsNotWall(CurrentPos) == false then
			return false
		end
	end
	return true	
end

function Zed:Ult(Target)
    local AADmg = myHero.BaseAttack + myHero.BonusAttack
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {80, 115, 150, 185, 220}
        Qbonus = (myHero.BonusAttack * 1)
        QQdmg = QDamage[QLevel] + Qbonus
    end
    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {70, 90, 110, 130, 150}
        Ebonus = (myHero.BonusAttack * 0.80)
        EEdmg = EDamage[ELevel] + Ebonus
    end
    local RLevel = myHero:GetSpellSlot(3).Level
    local RDamage
    local Rbonus
    local RRdmg
    if RLevel ~= 0 then
        RDamage = {0.25, 0.40, 0.55}
        Rbonus = (myHero.BonusAttack * 1)
        RRdmg = RDamage[RLevel]
    end
    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 then
        if Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL2") then
            FinalFullDmg = FinalFullDmg + (QQdmg*2)
        else 
            if Engine:SpellReady("HK_SPELL1") then
                FinalFullDmg = FinalFullDmg + (QQdmg)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        FinalFullDmg = FinalFullDmg + EEdmg
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        FinalFullDmg = (FinalFullDmg + Rbonus) + (AADmg*2) + ((FinalFullDmg + Rbonus) * RRdmg)
    end
    return FinalFullDmg
end

function Zed:ShouldW2(Target)
    local AADmg = myHero.BaseAttack + myHero.BonusAttack
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {80, 115, 150, 185, 220}
        Qbonus = (myHero.BonusAttack * 1)
        QQdmg = QDamage[QLevel] + Qbonus
    end
    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {70, 90, 110, 130, 150}
        Ebonus = (myHero.BonusAttack * 0.80)
        EEdmg = EDamage[ELevel] + Ebonus
    end
    local FinalFullDmg = 0
    FinalFullDmg = FinalFullDmg + AADmg
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + (QQdmg*2)
    end
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        FinalFullDmg = FinalFullDmg + EEdmg
    end
    local HPCondition = (FinalFullDmg / Target.MaxHealth) * 100
    if HPCondition >= 30 then
        return true
    end
    return false
end
--ZedWMissile

function Zed:GetShadowW()
    self.Shad0ws = {}
    self.ShadowOnTheWay = 0
    local Missiles = ObjectManager.MissileList
    local ShadowName = {"ZedWMissile"}
    for _, Missile in pairs(Missiles) do
        if "ZedWMissile" == Missile.Name then
            self.ShadowOnTheWay = 1
        end
    end
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Minion.Name == "Shadow" and Minion.IsDead == false then
            self.Shad0ws[#self.Shad0ws + 1] = Minion
            return Minion
        end
    end
    return nil
end

function Zed:Combo()
        local rtarget = Orbwalker:GetTarget("Combo", 1100)
        local wBuff	= myHero.BuffData:GetBuff("ZedWHandler")
        local canUltKill = false
        if rtarget then
            if self:Ult(rtarget) > rtarget.Health then
                canUltKill = true
            else 
                canUltKill = false
            end
        end
        -- use W closer to enemy to gapclose
        if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and wBuff.Count_Alt == 0 and self.ShadowOnTheWay == 0 and not self.Shadow and canUltKill then
            local target = Orbwalker:GetTarget("Combo", self.WRange + 400)
            if target ~= nil and Zed:Wallcheck(target.Position) then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
        -- gapclose W to be able to ult
        if canUltKill and self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self.ShadowOnTheWay == 0 and not self.Shadow then
            local target = Orbwalker:GetTarget("Combo", 1100)
            if target ~= nil and self.Shadow and Zed:Wallcheck(target.Position) then
                local wPos = self.Shadow.Position
                if GetDist(myHero.Position, target.Position) > GetDist(wPos, target.Position) then
                    Engine:CastSpell("HK_SPELL2", nil)
                    return
                end
            end
        end
        --gapclose W without ult, to deal dmg
        --[[if not canUltKill and self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and not self.Shadow then --and SHADOW 
            local qcd = myHero:GetSpellSlot(0).Cooldown
            local ecd = myHero:GetSpellSlot(2).Cooldown
            local target = Orbwalker:GetTarget("Combo", 1100)
            if target and Zed:Wallcheck(target.Position) then
                if self:ShouldW2(target) and self.Shadow then
                    local wPos = self.Shadow.Position
                    if GetDist(myHero.Position, target.Position) > GetDist(wPos, target.Position) then
                        Engine:CastSpell("HK_SPELL2", nil)
                        return
                    end
                end
                if qcd <= 2 or ecd < 2 then
                    local wPos = self.Shadow.Position
                    if GetDist(myHero.Position, target.Position) > GetDist(wPos, target.Position) then
                        Engine:CastSpell("HK_SPELL2", nil)
                        return
                    end
                end
            end
        end]]
            --check here the "canultkill will make it recast"
        if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") and wBuff.Count_Alt == 1 or self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") and not Engine:SpellReady("HK_SPELL2") then 
            local target = Orbwalker:GetTarget("Combo", 625)
            if target ~= nil then
                local rBuff = target.BuffData:GetBuff("zedrdeathmark")
                local r2Buff = target.BuffData:GetBuff("zedrtargetmark")
                if rBuff.Count_Alt == 0 and r2Buff.Count_Alt == 0 then
                    if canUltKill then 
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    end
                end
            end
        end
        -- using r as finisher when out of range and no gapclose
        if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            local Rstart = myHero:GetSpellSlot(3).StartTime
            local target = Orbwalker:GetTarget("Combo", 625)
            if target ~= nil then
                local rBuff = target.BuffData:GetBuff("zedrdeathmark")
                local r2Buff = target.BuffData:GetBuff("zedrtargetmark")
                if Rstart > 0 and not Engine:SpellReady("HK_SPELL2") and GetDist(myHero.Position, target.Position) >= myHero.AttackRange + 20 and GetDist(myHero.Position, target.Position) <= self.RRange then 
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
        end
        --press R if target has X hp
        if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            if target ~= nil then 
                local target = Orbwalker:GetTarget("Combo", 1200)
                local rBuff = target.BuffData:GetBuff("zedrdeathmark")
                local r2Buff = target.BuffData:GetBuff("zedrtargetmark")
                if rBuff.Count_Alt == 1 and r2Buff.Count_Alt == 1 then
                    local HPCondition = (target.Health / target.MaxHealth) * 100
                    if HPCondition < 12 then 
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    end
                end
            end
        end
        if self.Shadow then
            local wPos = self.Shadow.Position
            if self.ComboQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then
                local HeroList = ObjectManager.HeroList
                for i, target in pairs(HeroList) do
                    if target.Team ~= myHero.Team and target.IsDead == false then
                        local PredPos = Prediction:GetCastPos(wPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                        if wPos and GetDist(wPos, target.Position) <= self.QRange then
                            Engine:CastSpell('HK_SPELL1', PredPos, 0)
                            return
                        end
                    end
                end
            end
        end
        if self.Shadow then
            local wPos = self.Shadow.Position
            if self.ComboE.Value == 1 and Engine:SpellReady('HK_SPELL3') then
                local HeroList = ObjectManager.HeroList
                for i, target in pairs(HeroList) do
                    if target.Team ~= myHero.Team and target.IsDead == false then
                        if wPos and GetDist(wPos, target.Position) <= self.ERange then
                            Engine:CastSpell('HK_SPELL3', nil, 0)
                            return
                        end
                    end
                end
            end
        end
        if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3")  then
            if self.Shadow then
                local wPos = self.Shadow.Position
                local isWEHittable = EnemiesInRange(wPos, self.ERange)
                if isWEHittable >= 1 then
                    Engine:CastSpell('HK_SPELL3', nil, 0)
                    return
                end
            end
        end
        if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos and GetDist(myHero.Position, PredPos) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
        if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and wBuff.Count_Alt == 0 and self.ShadowOnTheWay == 0 and not self.Shadow  then
            local target = Orbwalker:GetTarget("Combo", self.WRange)
            if target ~= nil and Zed:Wallcheck(target.Position) then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
        if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local target = Orbwalker:GetTarget("Combo", 275)
            if target then
                Engine:CastSpell("HK_SPELL3", nil, 0)
                return
            end
        end
end

function Zed:Harass()
    local wBuff	= myHero.BuffData:GetBuff("ZedWHandler")
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") and wBuff.Count_Alt <= 0 and myHero.Mana >= 115 and self.ShadowOnTheWay == 0 and not self.Shadow then
        local target = Orbwalker:GetTarget("Combo", 1500)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL2", target.Position, 0)
            return
        end
    end
    if self.Shadow then
        local wPos = self.Shadow.Position
        if wPos and self.HarassQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then
            local PredwPos = Prediction:GetCastPos(wPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredwPos and GetDist(wPos, PredwPos) <= self.QRange then
                Engine:CastSpell('HK_SPELL1', PredwPos, 0)
                return
            end
        end
    end
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos and GetDist(myHero.Position, PredPos) <= self.QRange then
            if PredPos then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
    if self.Shadow then
        local wPos = self.Shadow.Position
        if self.HarassE.Value == 1 and Engine:SpellReady('HK_SPELL3') then
            local HeroList = ObjectManager.HeroList
            for i, target in pairs(HeroList) do
                if target.Team ~= myHero.Team and target.IsDead == false then
                    if wPos and GetDist(wPos, target.Position) <= self.ERange then
                        Engine:CastSpell('HK_SPELL3', nil, 0)
                        return
                    end
                end
            end
        end
    end
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", 275)
        if target ~= nil then
            Engine:CastSpell("HK_SPELL3", nil, 0)
            return
        end
    end
end

function Zed:Laneclear()
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target and GetDist(myHero.Position, target.Position) <= self.QRange and target.IsMinion == true and target.MaxHealth > 10  then
            Engine:CastSpell("HK_SPELL1", target.Position, 1)
            return
        end
    end
    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then --print(1)
        local target = Orbwalker:GetTarget("Laneclear", self.ERange) --print(2)
        if target ~= nil and GetDist(myHero.Position, target.Position) <= 650 then --print(3)
            if MinionsInRange(myHero.Position, 280) > self.LClearSlider.Value then --print(4)
                Engine:CastSpell("HK_SPELL3", nil, 0)
                return
            end
        end
    end
end

function Zed:KillHealthBox()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if Hero.IsTargetable then
                local CurrentDmg = self:Ult(Hero) --Switch this part of the code from where dmg calcs comes from!
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

function Zed:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self.Shadow = Zed:GetShadowW()
        if Engine:IsKeyDown("HK_COMBO") then
            Zed:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Zed:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Zed:Laneclear()
		end
	end
end

function Zed:OnDraw()
    if self.DrawKillable.Value == 1 then
        Zed:KillHealthBox()
    end
    if self.DrawS.Value == 1 then
        for _, Shad0ws in pairs(self.Shad0ws) do
            Render:DrawCircle(Shad0ws.Position, 100, 0,255,0,255)
        end
    end
	if Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL2") and self.DrawFQ.Value == 1 then
        Render:DrawCircle(myHero.Position, 1500 ,255,0,0,255)
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
        if self.Shadow then
            Render:DrawCircle(self.Shadow.Position, self.RRange ,100,150,255,255) -- values Red, Green, Blue, Alpha(opacity)      
        end
    end
end
function Zed:OnLoad()
    if(myHero.ChampionName ~= "Zed") then return end
	AddEvent("OnSettingsSave" , function() Zed:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Zed:LoadSettings() end)
	Zed:__init()
	AddEvent("OnTick", function() Zed:OnTick() end)	
    AddEvent("OnDraw", function() Zed:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Zed:OnLoad() end)	