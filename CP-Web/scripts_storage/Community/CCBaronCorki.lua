local Corki = {}

function Corki:__init()
    self.QRange = 825
    self.RRange = 1250
    self.BigRRange = 1400

    self.QSpeed = 1000
    self.RSpeed = 2000

    self.QDelay = 0.3
    self.RDelay = 0.25

self.ScriptVersion = "       **CCBaronCorki Version: 1.0 (FULL RELEASE)**"

    self.ChampionMenu = Menu:CreateMenu("Corki")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboQKS = self.Combomenu:AddCheckbox("Use ext range Q to ks", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("Use R in combo", 1)
    self.ComboRKS = self.Combomenu:AddCheckbox("Use ext range R to ks", 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass (extended range)")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 10)
    self.HarassR = self.Harassmenu:AddCheckbox("Use R in harass", 1)
    self.HarassRMana = self.Harassmenu:AddSlider("Minimum % mana to use R", 30, 0, 100, 10)
	-------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
	
	Corki:LoadSettings()
end

function Corki:SaveSettings()
	SettingsManager:CreateSettings("CCBaronCorki")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CQKS", self.ComboQKS.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("CRKS", self.ComboRKS.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HR", self.HarassR.Value)
    SettingsManager:AddSettingsInt("HRM", self.HarassRMana.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Corki:LoadSettings()
	SettingsManager:GetSettingsFile("CCBaronCorki")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboQKS.Value = SettingsManager:GetSettingsInt("Combo", "CQKS")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.ComboRKS.Value = SettingsManager:GetSettingsInt("Combo", "CRKS")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.HarassR.Value = SettingsManager:GetSettingsInt("Harass","HR")
    self.HarassRMana.Value = SettingsManager:GetSettingsInt("Harass","HRM")
	-------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

function Corki:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Corki:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Corki:GetDamage(rawDmg, isPhys, target)
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

--local function PredCheckPos()
    --if self.PredCheck.Value == 1 then
        --local PredPos, Target = Prediction:GetCastPos(myHero.Position, 1300, 2000, 70, 0.25, 1)
        --if PredPos ~= nil then
            --return PredPos
        --end
   -- end
--end


function Corki:KillStealQ(Target)
    local QDmg = Corki:GetDamage(30 + (45 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.5) + (myHero.AbilityPower * 0.5), false, Target)
    if QDmg > Target.Health then
        return true
    end
    return false
end

function Corki:KillStealR(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local RDmgraw = 55 + (35 * myHero:GetSpellSlot(3).Level) + ((TotalAD * -0.15) + (TotalAD * 0.3 * myHero:GetSpellSlot(3).Level)) + (myHero.AbilityPower * 0.2)
    local realMR = Target.MagicResist * myHero.MagicPenMod
    local RDmg = (100 / (100 + realMR)) * RDmgraw
    if myHero.BuffData:GetBuff("mbcheck2").Valid then
        RDmg = RDmg * 2
    end
    if RDmg > Target.Health then
        return true
    end
    return false
end

function Corki:KillSteal()
    if self.ComboRKS.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", 1400)
        if target ~= nil then
            if myHero.BuffData:GetBuff("mbcheck2").Valid then
                if self:KillStealR(target) then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.BigRRange, self.RSpeed, 70, self.RDelay, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                        return
                    end
                end
            else
                if self:KillStealR(target) then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 70, self.RDelay, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                        return
                    end
                end 
            end
        end
    end

    if self.ComboQKS.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", 825)
        if target ~= nil then
            if self:KillStealQ(target) then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 0, self.QDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Corki:Combo()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self:getAttackRange())
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 0, self.QDelay, 0)
            if PredPos ~= nil then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end
    
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self:getAttackRange())
        if target ~= nil then
            Engine:CastSpell("HK_SPELL3", Vector3.new() ,1)
        end
    end

    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self:getAttackRange())
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 70, self.RDelay, 1)
            if PredPos ~= nil then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Corki:Harass()
    if self.HarassR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", 1400)
        if myHero.Mana <= myHero.MaxMana * self.HarassRMana.Value / 100 then return end
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 70, self.RDelay, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL4", PredPos, 1)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", 825)
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 0, self.QDelay, 0)
            if PredPos ~= nil then
                if self:GetDist(myHero.Position, PredPos) <= 950 then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Corki:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Corki:Combo()
            Corki:KillSteal()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Corki:Harass()
            return
        end
    end
end

function Corki:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 825, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        if myHero.BuffData:GetBuff("mbcheck2").Valid then
            Render:DrawCircle(myHero.Position, 1500, 255, 0, 255, 255)
        else
            Render:DrawCircle(myHero.Position, 1300, 255, 0, 255, 255)
        end
    end
    --if PredCheckPos() ~= nil and self.PredCheck.Value == 1 then
        ---Render:DrawCircle(PredCheckPos(), 100, 255, 0, 255, 255)
    --end
end

function Corki:OnLoad()
    if(myHero.ChampionName ~= "Corki") then return end
    AddEvent("OnSettingsSave" , function() Corki:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Corki:LoadSettings() end)

	Corki:__init()
	AddEvent("OnTick", function() Corki:OnTick() end)
    AddEvent("OnDraw", function() Corki:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Corki:OnLoad() end)