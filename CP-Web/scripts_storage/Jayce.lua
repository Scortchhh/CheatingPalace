local Jayce = {}

function Jayce:__init()
    self.QRRange = 1050
    self.QR2Range = 1600
    self.WRRange = 650
    self.ERRange = 650
    self.QMRange = 550
    self.WMRange = 300
    self.EMRange = 285

    self.QRSpeed = 1450
    self.QR2Speed = 2350

    self.QRWidth = 140
    self.QR2Width = 140

    self.QRDelay = 0.25
    self.QR2Delay = 0.25

    self.CurrentForm = nil
    self.GateLastCastT = 0
    self.QMTimer = 0
    self.QRTimer = 0
    self.WMTimer = 0
    self.WRTimer = 0
    self.EMTimer = 0
    self.ERTimer = 0

    self.QHitChance = 0.2

    self.JayceMenu = Menu:CreateMenu("Jayce")
    ------------------------------------------------------------------------------------------------------------------
    self.ComboMenu = self.JayceMenu:AddSubMenu("Combo")
    self.ComboSwitchR = self.ComboMenu:AddCheckbox("Auto switch R", 1)
    self.ComboRangeMenu = self.ComboMenu:AddSubMenu("Range")
    self.ComboRangeUseQ = self.ComboRangeMenu:AddCheckbox("Use Q", 1)
    self.ComboRangeUseW = self.ComboRangeMenu:AddCheckbox("Use W", 1)
    self.ComboRangeUseE = self.ComboRangeMenu:AddCheckbox("Use E", 1)
    self.ComboMeleeMenu = self.ComboMenu:AddSubMenu("Melee")
    self.ComboMeleeUseQ = self.ComboMeleeMenu:AddCheckbox("Use Q", 1)
    self.ComboMeleeUseW = self.ComboMeleeMenu:AddCheckbox("Use W", 1)
    self.ComboMeleeUseE = self.ComboMeleeMenu:AddCheckbox("Use E", 1)
    ------------------------------------------------------------------------------------------------------------------
    self.HarassMenu = self.JayceMenu:AddSubMenu("Harass")
    self.HarassSwitchR = self.HarassMenu:AddCheckbox("Auto switch R", 1)
    self.HarassRangeMenu = self.HarassMenu:AddSubMenu("Range")
    self.HarassRangeUseQ = self.HarassRangeMenu:AddCheckbox("Use Q", 1)
    self.HarassRangeUseW = self.HarassRangeMenu:AddCheckbox("Use W", 1)
    self.HarassRangeUseE = self.HarassRangeMenu:AddCheckbox("Use E", 1)
    self.HarassMeleeMenu = self.HarassMenu:AddSubMenu("Melee")
    self.HarassMeleeUseQ = self.HarassMeleeMenu:AddCheckbox("Use Q", 1)
    self.HarassMeleeUseW = self.HarassMeleeMenu:AddCheckbox("Use W", 1)
    self.HarassMeleeUseE = self.HarassMeleeMenu:AddCheckbox("Use E", 1)
    ------------------------------------------------------------------------------------------------------------------
    self.MiscMenu = self.JayceMenu:AddSubMenu("Misc")
    self.MiscAutoE = self.MiscMenu:AddCheckbox("Auto E", 1)
    self.MiscESlider = self.MiscMenu:AddSlider("Min. Health %", 20, 10, 50, 5)

    Jayce:LoadSettings()
end

function Jayce:SaveSettings()
    SettingsManager:CreateSettings("Jayce")
    ------------------------------------------------------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Auto switch R", self.ComboSwitchR.Value)
    SettingsManager:AddSettingsGroup("ComboRange")
    SettingsManager:AddSettingsInt("Use Q", self.ComboRangeUseQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.ComboRangeUseW.Value)
    SettingsManager:AddSettingsInt("Use E", self.ComboRangeUseE.Value)
    SettingsManager:AddSettingsGroup("ComboMelee")
    SettingsManager:AddSettingsInt("Use Q", self.ComboMeleeUseQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.ComboMeleeUseW.Value)
    SettingsManager:AddSettingsInt("Use E", self.ComboMeleeUseE.Value)
    ------------------------------------------------------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Auto switch R", self.HarassSwitchR.Value)
    SettingsManager:AddSettingsGroup("HarassRange")
    SettingsManager:AddSettingsInt("Use Q", self.HarassRangeUseQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.HarassRangeUseW.Value)
    SettingsManager:AddSettingsInt("Use E", self.HarassRangeUseE.Value)
    SettingsManager:AddSettingsGroup("HarassMelee")
    SettingsManager:AddSettingsInt("Use Q", self.HarassMeleeUseQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.HarassMeleeUseW.Value)
    SettingsManager:AddSettingsInt("Use E", self.HarassMeleeUseE.Value)
    ------------------------------------------------------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Auto E", self.MiscAutoE.Value)
    SettingsManager:AddSettingsInt("Min. Health %", self.MiscESlider.Value)
end

function Jayce:LoadSettings()
    SettingsManager:GetSettingsFile("Jayce")
    ------------------------------------------------------------------------------------------------------------------
    self.ComboSwitchR.Value = SettingsManager:GetSettingsInt("Combo", "Auto switch R")
    self.ComboRangeUseQ.Value = SettingsManager:GetSettingsInt("ComboRange", "Use Q")
    self.ComboRangeUseW.Value = SettingsManager:GetSettingsInt("ComboRange", "Use W")
    self.ComboRangeUseE.Value = SettingsManager:GetSettingsInt("ComboRange", "Use E")
    self.ComboMeleeUseQ.Value = SettingsManager:GetSettingsInt("ComboMelee", "Use Q")
    self.ComboMeleeUseW.Value = SettingsManager:GetSettingsInt("ComboMelee", "Use W")
    self.ComboMeleeUseE.Value = SettingsManager:GetSettingsInt("ComboMelee", "Use E")
    ------------------------------------------------------------------------------------------------------------------
    self.HarassSwitchR.Value = SettingsManager:GetSettingsInt("Harass", "Auto switch R")
    self.HarassRangeUseQ.Value = SettingsManager:GetSettingsInt("HarassRange", "Use Q")
    self.HarassRangeUseW.Value = SettingsManager:GetSettingsInt("HarassRange", "Use W")
    self.HarassRangeUseE.Value = SettingsManager:GetSettingsInt("HarassRange", "Use E")
    self.HarassMeleeUseQ.Value = SettingsManager:GetSettingsInt("HarassMelee", "Use Q")
    self.HarassMeleeUseW.Value = SettingsManager:GetSettingsInt("HarassMelee", "Use W")
    self.HarassMeleeUseE.Value = SettingsManager:GetSettingsInt("HarassMelee", "Use E")
    ------------------------------------------------------------------------------------------------------------------
    self.MiscAutoE.Value = SettingsManager:GetSettingsInt("Misc", "Auto E")
    self.MiscESlider.Value = SettingsManager:GetSettingsInt("Misc", "Min. Health %")
end

local function GetCurrentForm()
    CurrentForm = myHero:GetSpellSlot(0).Info.Name == "JayceShockBlast" and "Range" or "Melee"
    return
end

local function GetTotalAD()
    return myHero.BaseAttack + myHero.BonusAttack
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

local function GetReverseAttackRange()
    local attRange
    if CurrentForm == "Range" then
        attRange = 190
    else
        attRange = 565
    end
end

function Jayce:IsQReady()
    local QLevel = myHero:GetSpellSlot(0).Level
    local QCD
    if CurrentForm == "Range" then
        QCD = ({16, 14, 12, 10, 8, 6})[QLevel > 0 and QLevel or 1]
        if GameClock.Time - QCD >= self.QMTimer then
            return true
        else
            return false
        end
    else
        QCD = 8
        if GameClock.Time - QCD >= self.QRTimer then
            return true
        else
            return false
        end
    end
end

function Jayce:GetQDamage(Target)
    local QLevel = myHero:GetSpellSlot(0).Level
    local rawDamage
    if self:IsQReady() then
        if CurrentForm == "Range" then
            rawDamage = ({55, 95, 135, 175, 215, 255})[QLevel > 0 and QLevel or 1] + 1.2 * GetTotalAD()
            return GetDamage(rawDamage, true, Target)
        else
            rawDamage = ({55, 110, 165, 220, 275, 330})[QLevel > 0 and QLevel or 1] + 1.2 * GetTotalAD()
            return GetDamage(rawDamage, true, Target)
        end
    else
        return 0
    end
end

function Jayce:IsWReady()
    local WLevel = myHero:GetSpellSlot(1).Level
    local WCD
    if CurrentForm == "Range" then
        WCD = 10
        if GameClock.Time - WCD >= self.WMTimer then
            return true
        else
            return false
        end
    else
        WCD = ({13, 11.4, 9.8, 8.2, 6.6, 5})[WLevel > 0 or WLevel or 1]
        if GameClock.Time - WCD >= self.WRTimer then
            return true
        else
            return false
        end
    end
end

function Jayce:GetWDamage(Target)
    local WLevel = myHero:GetSpellSlot(1).Level
    local rawDamage
    if self:IsWReady() then
        if CurrentForm == "Range" then
            rawDamage = (({160, 220, 280, 340, 400})[WLevel > 0 and WLevel or 1] + 1 * myHero.AbilityPower) * 0.5
            return GetDamage(rawDamage, false, Target)
        else
            rawDamage = (({0.7, 0.78, 0.86, 0.94, 1.02, 1.1})[WLevel > 0 and WLevel or 1] * GetTotalAD() + GetTotalAD()) * 3
            return GetDamage(rawDamage, true, Target)
        end
    else
        return 0
    end
end

function Jayce:IsEReady()
    local ELevel = myHero:GetSpellSlot(2).Level
    local ECD
    if CurrentForm == "Range" then
        ECD = ({20, 18, 16, 14, 12, 10})[ELevel > 0 and ELevel or 1]
        if GameClock.Time - ECD >= self.EMTimer then
            return true
        else
            return false
        end
    else
        ECD = 16
        if GameClock.Time - ECD >= self.ERTimer then
            return true
        else
            return false
        end
    end
end

function Jayce:GetEDamage(Target)
    local ELevel = myHero:GetSpellSlot(2).Level
    local maxHp = Target.MaxHealth
    local rawDamage
    if self:IsEReady() then
        if CurrentForm == "Range" then
            rawDamage = (({8, 10.4, 12.8, 15.2, 17.6, 20})[ELevel > 0 and ELevel or 1] * 0.01) * maxHp + GetTotalAD()
            return GetDamage(rawDamage, true, Target)
        else
            return 0
        end
    else
        return 0
    end
end

function Jayce:CanKillWithSwitch(Target)
    local Damage = self:GetQDamage(Target) + self:GetWDamage(Target) + self:GetEDamage(Target)
    if Damage ~= nil then
        if Damage >= Target.Health then
            return true
        else
            return false
        end
    end
    return false
end

function Jayce:GetGatePosition(Target)
    local playerPos = myHero.Position
    local targetPos = Target.Position
    local targetVec = Vector3.new(targetPos.x - playerPos.x, targetPos.y - playerPos.y, targetPos.z - playerPos.z)
    local vecLength	= math.sqrt((targetVec.x) ^ 2 + (targetVec.y) ^ 2 + (targetVec.z) ^ 2)
    local targetNormalized = Vector3.new(targetVec.x/vecLength , targetVec.y/vecLength , targetVec.z/vecLength)

    local i = -400
    local EndPos = Vector3.new(targetPos.x + (targetNormalized.x * i), targetPos.y + (targetNormalized.y * i), targetPos.z + (targetNormalized.z * i))
    return EndPos
end

function Jayce:MeleeConditions(Target)
    if Target and Target.IsDead == false then
        if self:IsQReady() and self:CanKillWithSwitch(Target) and Orbwalker:GetDistance(myHero.Position, Target.Position) <= self.QMRange then
            return true
        end
    end
end

function Jayce:RangeConditions(Target)
    if Target and Target.IsDead == false then
        if Orbwalker:GetDistance(myHero.Position, Target.Position) >= GetAttackRange() + 200 then
            return true
        end
    end
end

function Jayce:CanQE()
    local mana = myHero.Mana
    local QLevel = myHero:GetSpellSlot(0).Level
    local qMana = ({55, 60, 65, 70, 75, 80})[QLevel > 1 or QLevel or 1]
    local eMana = 50
    if mana >= qMana + eMana then
        return true
    else
        return false
    end
end

function Jayce:AutoE()
    local Heros = ObjectManager.HeroList
    local ECondition = myHero.MaxHealth / 100 * self.MiscESlider.Value
    if self.MiscAutoE.Value == 1 then
        for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                if Orbwalker:GetDistance(myHero.Position, Hero.Position) <= self.EMRange then
                    local WBuff = Hero.BuffData:GetBuff("JayceHyperCharge")
                    if Hero.AIData.Dashing == true then
                        if CurrentForm == "Range" then
                            if Engine:SpellReady("HK_SPELL4") and not WBuff.Valid then
                                Engine:CastSpell("HK_SPELL4", nil)
                                if Engine:SpellReady("HK_SPELL3") then
                                    Engine:CastSpell("HK_SPELL3", Hero.Position)
                                    self.EMTimer = GameClock.Time
                                    return
                                end
                            end
                        else
                            if Engine:SpellReady("HK_SPELL3") then
                                Engine:CastSpell("HK_SPELL3", Hero.Position)
                                self.EMTimer = GameClock.Time
                                return
                            end
                        end
                    end
                    if myHero.Health <= ECondition then
                        if CurrentForm == "Range" then
                            if Engine:SpellReady("HK_SPELL4") and not WBuff.Valid then
                                Engine:CastSpell("HK_SPELL4", nil)
                                Orbwalker:IssueAttack(Hero.Position)
                                if Engine:SpellReady("HK_SPELL3") then
                                    Engine:CastSpell("HK_SPELL3", Hero.Position)
                                    self.EMTimer = GameClock.Time
                                    return
                                end
                            end
                        else
                            if Engine:SpellReady("HK_SPELL3") then
                                Orbwalker:IssueAttack(Hero.Position)
                                Engine:CastSpell("HK_SPELL3", Hero.Position)
                                self.EMTimer = GameClock.Time
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function Jayce:Combo()
    local qRCastPos, qRTarget = Prediction:GetCastPos(myHero.Position, self.QRRange, self.QRSpeed, self.QRWidth, self.QRDelay, 1, true, self.QHitChance, 1)
    local qeRCastPos, qeRTarget = Prediction:GetCastPos(myHero.Position, self.QR2Range, self.QR2Speed, self.QR2Width, self.QR2Delay, 1, true, self.QHitChance, 1)
    local wRTarget = Orbwalker:GetTarget("Combo", GetAttackRange())

    local qTarget = Orbwalker:GetTarget("Combo", self.QMRange)
    local wTarget = Orbwalker:GetTarget("Combo", self.WMRange)
    local eTarget = Orbwalker:GetTarget("Combo", self.EMRange)
    local WRange = myHero.CharData.BoundingRadius + myHero.AttackRange + 50
    local target = Orbwalker:GetTarget("Combo", WRange)

    if CurrentForm == "Range" then
        if self.ComboRangeUseE.Value == 1 and self.ComboRangeUseQ and qeRTarget and qeRCastPos then
            if qeRTarget.Team ~= myHero.Team and qeRTarget.IsTargetable then
                if Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") then
--                     if self:CanQE() then
                        GateLastCastT = os.clock()
                        Engine:CastSpell("HK_SPELL3", self:GetGatePosition(qeRTarget))
                        self.ERTimer = GameClock.Time
                        return
--                     end
                end
                if Engine:SpellReady("HK_SPELL1") then
                    local tick = os.clock()
                    if GateLastCastT then
                        if GateLastCastT + 0.5 > tick then
                            Engine:CastSpell("HK_SPELL1", qeRCastPos)
                            self.QRTimer = GameClock.Time
                            return
                        end
                    end
                end
            end
        end
        if self.ComboRangeUseW.Value == 1 and target then
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL2") and Orbwalker:GetDistance(myHero.Position, target.Position) <= WRange then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL1") then
            if self.ComboRangeUseQ.Value == 1 and qRTarget and qRCastPos then
                if qRTarget.Team ~= myHero.Team and qRTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL1", qRCastPos)
                    self.QRTimer = GameClock.Time
                    return
                end
            end
        end
--[[
        if Engine:SpellReady("HK_SPELL2") then
            if self.ComboRangeUseW.Value == 1 and wRTarget then
                if wRTarget.Team ~= myHero.Team and wRTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL2", nil)
                    self.WRTimer = GameClock.Time
                    return
                end
            end
        end ]]

        if Engine:SpellReady("HK_SPELL4") and self.ComboSwitchR.Value == 1 then
            local WBuff = myHero.BuffData:GetBuff("JayceHyperCharge")
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL3") and not WBuff.Valid then
                return Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    else
        if Engine:SpellReady("HK_SPELL1") then
            if self.ComboMeleeUseQ.Value == 1 and qTarget then
                if qTarget.Team ~= myHero.Team and qTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL1", qTarget.Position, 1)
                    self.QMTimer = GameClock.Time
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL2") then
            if self.ComboMeleeUseW.Value == 1 and wTarget then
                if wTarget.Team ~= myHero.Team and wTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL2", nil)
                    self.WMTimer = GameClock.Time
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL3") then
            if self.ComboMeleeUseE.Value == 1 and eTarget then
                if eTarget.Team ~= myHero.Team and eTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL3", eTarget.Position, 1)
                    self.EMTimer = GameClock.Time
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL4") and self.ComboSwitchR.Value == 1 then
            if self:RangeConditions(qeRTarget) then
                return Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    end
end

function Jayce:Harass()
    local qRCastPos, qRTarget = Prediction:GetCastPos(myHero.Position, self.QRRange, self.QRSpeed, self.QRWidth, self.QRDelay, 1, true, self.QHitChance, 1)
    local qeRCastPos, qeRTarget = Prediction:GetCastPos(myHero.Position, self.QR2Range, self.QR2Speed, self.QR2Width, self.QR2Delay, 1, true, self.QHitChance, 1)
    local wRTarget = Orbwalker:GetTarget("Harass", GetAttackRange())

    local qTarget = Orbwalker:GetTarget("Harass", self.QMRange)
    local wTarget = Orbwalker:GetTarget("Harass", self.WMRange)
    local eTarget = Orbwalker:GetTarget("Harass", self.EMRange)

    if CurrentForm == "Range" then
        if self.HarassRangeUseE.Value == 1 and self.HarassRangeUseQ and qeRTarget and qeRCastPos then
            if qeRTarget.Team ~= myHero.Team and qeRTarget.IsTargetable then
                if Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") then
--                     if self:CanQE() then
                        GateLastCastT = os.clock()
                        Engine:CastSpell("HK_SPELL3", self:GetGatePosition(qeRTarget))
                        self.ERTimer = GameClock.Time
                        return
--[[                     end ]]
                end
                if Engine:SpellReady("HK_SPELL1") then
                    local tick = os.clock()
                    if GateLastCastT then
                        if GateLastCastT + 0.5 > tick then
                            Engine:CastSpell("HK_SPELL1", qeRCastPos)
                            self.QRTimer = GameClock.Time
                            return
                        end
                    end
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") then
            if self.HarassRangeUseQ.Value == 1 and qRTarget and qRCastPos then
                if qRTarget.Team ~= myHero.Team and qRTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL1", qRCastPos)
                    self.QRTimer = GameClock.Time
                    return
                end
            end
        end

--[[         if Engine:SpellReady("HK_SPELL2") then
            if self.HarassRangeUseW.Value == 1 and wRTarget then
                if wRTarget.Team ~= myHero.Team and wRTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL2", nil)
                    self.WRTimer = GameClock.Time
                    return
                end
            end
        end ]]

        if Engine:SpellReady("HK_SPELL4") and self.HarassSwitchR.Value == 1 then
            if self:MeleeConditions(qTarget) then
                return Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    else
        if Engine:SpellReady("HK_SPELL1") then
            if self.HarassMeleeUseQ.Value == 1 and qTarget then
                if qTarget.Team ~= myHero.Team and qTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL1", qTarget.Position, 1)
                    self.QMTimer = GameClock.Time
                    Orbwalker:IssueAttack(qTarget.Position)
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL2") then
            if self.HarassMeleeUseW.Value == 1 and wTarget then
                if wTarget.Team ~= myHero.Team and wTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL2", nil)
                    self.WMTimer = GameClock.Time
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL3") then
            if self.HarassMeleeUseE.Value == 1 and eTarget then
                if eTarget.Team ~= myHero.Team and eTarget.IsTargetable then
                    Engine:CastSpell("HK_SPELL3", eTarget.Position, 1)
                    self.EMTimer = GameClock.Time
                    return
                end
            end
        end

        if Engine:SpellReady("HK_SPELL4") and self.HarassSwitchR.Value == 1 then
            if self:RangeConditions(qeRTarget) then
                return Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    end
end

function Jayce:OnTick()
    GetCurrentForm()
    self:AutoE()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
           Jayce:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
           Jayce:Harass()
        end
    end
end

function Jayce:OnDraw()
    if myHero.IsDead == true then return end
    if CurrentForm == "Range" then
        if Engine:SpellReady("HK_SPELL1") then
            Render:DrawCircle(myHero.Position, self.QRRange, 0, 0, 255, 100)
        end
    else
        if Engine:SpellReady("HK_SPELL1") then
            Render:DrawCircle(myHero.Position, self.QMRange, 0, 0, 255, 100)
        end
        if Engine:SpellReady("HK_SPELL3") then
            Render:DrawCircle(myHero.Position, self.EMRange, 0, 0, 255, 100)
        end
    end
end

function Jayce:OnLoad()
    if myHero.ChampionName ~= "Jayce" then return end
    AddEvent("OnSettingsSave" , function() Jayce:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Jayce:LoadSettings() end)
    Jayce:__init()

    AddEvent("OnTick",function() Jayce:OnTick() end)
    AddEvent("OnDraw",function() Jayce:OnDraw() end)
end

AddEvent("OnLoad", function() Jayce:OnLoad() end)







