local Kaisa = {}

function Kaisa:__init()

    self.QRange = 650
    self.WRange = 3000
    --self.ERange = math.huge
    self.RRange = 750 + (750 * myHero:GetSpellSlot(3).Level)

    self.QSpeed = math.huge
    self.WSpeed = 1750
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.WRange = 3000
    self.WSpeed = 1750
    self.WWidth = 200
    self.WDelay = 0.4

    self.QDelay = 0
    self.WDelay = 0.4
    self.EDelay = 1.2
    self.RDelay = 0

    self.WHitChance = 0.2

    --self.QRadius = 55
    --self.WRadius = 0
    --self.ERadius = 350
    --self.RRadius = 475

    self.ScriptVersion = "        **CCKaisa Version: 0.5 (BETA)**"

    self.ChampionMenu = Menu:CreateMenu("Kaisa")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.QSettings = self.Combomenu:AddSubMenu("Q Settings")
    self.ComboAutoQ = self.QSettings:AddCheckbox("Auto Q", 1)
    self.SingleQCombo = self.QSettings:AddCheckbox("Single Q in combo", 0)
    self.ComboKSQ = self.QSettings:AddCheckbox("Use KS Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.WSettings = self.Combomenu:AddSubMenu("W Settings")
    self.StackWCombo = self.WSettings:AddCheckbox("Long W with stacks in Combo", 1)
    self.SlowWCombo = self.WSettings:AddCheckbox("Use slow pred combo", 1)
    self.ComboKSW = self.WSettings:AddCheckbox("Use KS W in combo", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    --self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)
    --self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.QHarassSettings = self.Harassmenu:AddSubMenu("Q Settings")
    self.HarassQMana = self.QHarassSettings:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.SingleQHarass = self.QHarassSettings:AddCheckbox("Single Q in harass", 0)
    self.HarassW = self.Harassmenu:AddCheckbox("Use W in harass", 1)
    self.WHarassSettings = self.Harassmenu:AddSubMenu("W Settings")
    self.HarassWMana = self.WHarassSettings:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.StackWHarass = self.WHarassSettings:AddCheckbox("Long W with stacks in Harass", 1)
    self.SlowWHarass = self.WHarassSettings:AddCheckbox("Use slow pred harass", 1)
    --self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    --self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
--[[    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearW = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearWMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)]]
    -------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    --self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
	
	Kaisa:LoadSettings()
end

function Kaisa:SaveSettings()
	SettingsManager:CreateSettings("CCKaisa")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("AQ", self.ComboAutoQ.Value)
    SettingsManager:AddSettingsInt("SQC", self.SingleQCombo.Value)
    SettingsManager:AddSettingsInt("KSQ", self.ComboKSQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("SWC", self.StackWCombo.Value)
    SettingsManager:AddSettingsInt("SlowWC", self.SlowWCombo.Value)
    SettingsManager:AddSettingsInt("KSW", self.ComboKSW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    --SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    --SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("SQH", self.SingleQHarass.Value)
    SettingsManager:AddSettingsInt("HW", self.HarassW.Value)
    SettingsManager:AddSettingsInt("HWM", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("SWH", self.StackWHarass.Value)
    SettingsManager:AddSettingsInt("SlowWH", self.SlowWHarass.Value)
    --SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    --SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
 --[[   SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    SettingsManager:AddSettingsInt("CW", self.ClearW.Value)
    SettingsManager:AddSettingsInt("CWM", self.ClearWMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)]]
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    --SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Kaisa:LoadSettings()
	SettingsManager:GetSettingsFile("CCKaisa")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboAutoQ.Value = SettingsManager:GetSettingsInt("Combo","AQ")
    self.SingleQCombo.Value = SettingsManager:GetSettingsInt("Combo","SQC")
    self.ComboKSQ.Value = SettingsManager:GetSettingsInt("Combo","KSQ")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.StackWCombo.Value = SettingsManager:GetSettingsInt("Combo","SWC")
    self.SlowWCombo.Value = SettingsManager:GetSettingsInt("Combo","SlowWC")
    self.ComboKSW.Value = SettingsManager:GetSettingsInt("Combo","KSW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    --self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    --self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.SingleQHarass.Value = SettingsManager:GetSettingsInt("Harass","SQH")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","HW")
    self.HarassWMana.Value = SettingsManager:GetSettingsInt("Harass","HWM")
    self.StackWHarass.Value = SettingsManager:GetSettingsInt("Harass","SWH")
    self.SlowWHarass.Value = SettingsManager:GetSettingsInt("Harass","SlowWH")
    --self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","HE")
    --self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass","HEM")
    -------------------------------------------
--[[    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    self.ClearW.Value = SettingsManager:GetSettingsInt("Clear", "CW")
    self.ClearWMana.Value = SettingsManager:GetSettingsInt("Clear", "CWM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")]]
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    --self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end
function Kaisa:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = target.MagicResist * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Kaisa:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
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

function Kaisa:EnemyMinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do   
        if Minion.Team ~= myHero.Team and Minion.IsDead == false then
            if GetDist(Minion.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Kaisa:AutoQ()
    if Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            if EnemiesInRange(myHero.Position, self.QRange + 5) < 2 and self:EnemyMinionsInRange(myHero.Position, self.QRange + 5) < 1 then
                Engine:CastSpell("HK_SPELL1", nil, 1)
            end
        end
    end
end
--kaisapassivemarker, KaisaWEvolved

function Kaisa:QDmg(Target)
    local QDmg = Kaisa:GetDamage(65 + (36 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.9) + (myHero.AbilityPower * 0.5625), true, Target)
    if myHero.BuffData:GetBuff("KaisaQEvolved").Valid then
        QDmg = Kaisa:GetDamage(107 + (61 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 1.5) + (myHero.AbilityPower * 0.9375), true, Target)
    end
    if QDmg > Target.Health then
        return true
    end
    return false
end
function Kaisa:WDmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local WDmg = Kaisa:GetDamage(5 + (25 * myHero:GetSpellSlot(1).Level) + (TotalAD * 1.3) + (myHero.AbilityPower * 0.7), false, Target)
    if WDmg > Target.Health then
        return true
    end
    return false
end

function Kaisa:Killsteal()
    if self.ComboKSQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            if self:QDmg(target) then
                Engine:CastSpell("HK_SPELL1", nil, 1)
            end
        end
    end
    if self.ComboKSW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target2 = Orbwalker:GetTarget("Combo", self.WRange)
        local StartPos = myHero.Position
        if target2 ~= nil then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() + 20 then
                if self:WDmg(target2) then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    end
                end
            end
        end
    end
end

function Kaisa:Combo()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            if self.SingleQCombo.Value == 0 then
                Engine:CastSpell("HK_SPELL1", nil, 1)
            end
            if self.SingleQCombo.Value == 1 then 
                if EnemiesInRange(myHero.Position, self.QRange + 5) < 2 and self:EnemyMinionsInRange(myHero.Position, self.QRange + 5) < 1 then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local additionalAttackSpeed = myHero.AttackSpeedMod - myHero.CharData.BaseAttackSpeed
            if additionalAttackSpeed >= 1.45 then
                Engine:CastSpell("HK_SPELL3", nil, 1)
                return
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target1 = Orbwalker:GetTarget("Combo", self:getAttackRange())
        local target2 = Orbwalker:GetTarget("Combo", self.WRange)
        local StartPos = myHero.Position
        if target1 ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
            if PredPos ~= nil then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
            local wBuff = target1.BuffData:GetBuff("kaisapassivemarker")
            if wBuff.Valid then
                if wBuff.Count_Alt >= 3 then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        return
                    end
                end
            end
        end
        if target2 ~= nil then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() + 20 then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos ~= nil then
                    if self.SlowWCombo.Value == 1 then
                        if target2.AIData.IsDashing == true or target2.BuffData:HasBuffOfType(BuffType.Stun) == true or target2.BuffData:HasBuffOfType(BuffType.Slow) == true or target2.BuffData:HasBuffOfType(BuffType.Snare) == true then
                            local mark = target2.BuffData:GetBuff("kaisapassivemarker")
                            local WStacks = 3
                            if myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
                                WStacks = 2
                            end
                            if self.StackWCombo.Value == 1 then
                                if mark.Count_Alt >= WStacks then
                                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                                end
                            end
                            if self.StackWCombo.Value == 0 then
                                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                            end
                        end
                    end
                    if self.SlowWCombo.Value == 0 then
                        local mark = target2.BuffData:GetBuff("kaisapassivemarker")
                        local WStacks = 3
                        if myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
                            WStacks = 2
                        end
                        if self.StackWCombo.Value == 1 then
                            if mark.Count_Alt >= WStacks then
                                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                            end
                        end
                        if self.StackWCombo.Value == 0 then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                end
            end
        end  
    end
end

function Kaisa:ShowAllEnemyBuffs(Position, Range)
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.team ~= myHero.Team and Hero.IsTargetable then
            if Hero ~= nil then
                print(Hero.BuffData:GetBuff("kaisapassivemarker").Count_Alt)
            end
        end
    end
end

function Kaisa:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            if self.SingleQHarass.Value == 0 then
                Engine:CastSpell("HK_SPELL1", nil, 1)
            end
            if self.SingleQHarass.Value == 1 then 
                if EnemiesInRange(myHero.Position, self.QRange + 5) < 2 and self:EnemyMinionsInRange(myHero.Position, self.QRange + 5) < 1 then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                end
            end
        end
    end
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero.Mana <= myHero.MaxMana * self.HarassWMana.Value / 100 then return end
        local target1 = Orbwalker:GetTarget("Combo", self:getAttackRange())
        local target2 = Orbwalker:GetTarget("Combo", self.WRange)
        local StartPos = myHero.Position
        if target1 ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
            if PredPos ~= nil then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                end
            end
        end
        if target2 ~= nil then 
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() + 20 then 
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos ~= nil then 
                    if self.SlowWHarass.Value == 1 then 
                        if target2.AIData.IsDashing == true or target2.BuffData:HasBuffOfType(BuffType.Stun) == true or target2.BuffData:HasBuffOfType(BuffType.Slow) == true or target2.BuffData:HasBuffOfType(BuffType.Snare) == true then 
                            local mark = target2.BuffData:GetBuff("kaisapassivemarker")
                            local WStacks = 3
                            if myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
                                WStacks = 2
                            end
                            if self.StackWHarass.Value == 1 then
                                if mark.Count_Alt >=  WStacks then
                                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                                end
                            end
                            if self.StackWHarass.Value == 0 then
                                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                            end
                        end
                    end
                    if self.SlowWHarass.Value == 0 then 
                        local mark = target2.BuffData:GetBuff("kaisapassivemarker")
                        local WStacks = 3
                        if myHero.BuffData:GetBuff("KaisaWEvolved").Valid then
                            WStacks = 2
                        end
                        if self.StackWHarass.Value == 1 then
                            if mark.Count_Alt >=  WStacks then
                                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                            end
                        end
                        if self.StackWHarass.Value == 0 then 
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                end
            end
        end  
    end
end
function Kaisa:EattackDisabler()
    if myHero.BuffData:GetBuff("KaisaE").Valid then
        Orbwalker:IssueMove(nil)
    end
end

function Kaisa:Laneclear()
    
end

function Kaisa:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.ComboAutoQ.Value == 1 then
            Kaisa:AutoQ()
        end
        if Engine:IsKeyDown("HK_COMBO") then
            Kaisa:Combo()
            Kaisa:Killsteal()
            --Kaisa:EattackDisabler()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Kaisa:Harass()
            --Kaisa:EattackDisabler()
            return
        end
        --Kaisa:ShowAllEnemyBuffs()
        --[[if Engine:IsKeyDown("HK_LANECLEAR") then
            Kaisa:Laneclear()
            return
        end]]
    end
end

function Kaisa:OnDraw()
    if self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 750 + (750 * myHero:GetSpellSlot(3).Level), 255, 0, 255, 255)
    end
end

function Kaisa:OnLoad()
    if(myHero.ChampionName ~= "Kaisa") then return end
    AddEvent("OnSettingsSave" , function() Kaisa:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kaisa:LoadSettings() end)

	Kaisa:__init()
	AddEvent("OnTick", function() Kaisa:OnTick() end)
    AddEvent("OnDraw", function() Kaisa:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Kaisa:OnLoad() end)