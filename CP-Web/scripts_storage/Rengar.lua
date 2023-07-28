local Rengar = {
}

function Rengar:__init()

    self.ERange = 1000
    self.ESpeed = 1500
    self.EWidth = 140
    self.EDelay = 0.25

    self.EHitChance = 0.2

    self.RengarMenu = Menu:CreateMenu("Rengar")
    self.RengarCombo = self.RengarMenu:AddSubMenu("Combo")
    self.RengarCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.RengarCombo:AddCheckbox("UseQ in combo", 1)
    self.UseWCombo = self.RengarCombo:AddCheckbox("UseW in combo", 1)
    self.UseECombo = self.RengarCombo:AddCheckbox("UseE in combo", 1)
    self.RengarHarass = self.RengarMenu:AddSubMenu("Harass")
    self.RengarHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.RengarHarass:AddCheckbox("UseQ in harass", 1)
    self.UseWHarass = self.RengarHarass:AddCheckbox("UseW in harass", 1)
    self.RengarDrawings = self.RengarMenu:AddSubMenu("Drawings")
    self.DrawE = self.RengarDrawings:AddCheckbox("UseE in drawings", 1)

    Rengar:LoadSettings()
end

function Rengar:SaveSettings()
	SettingsManager:CreateSettings("Rengar")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseE in drawings", self.DrawE.Value)
end

function Rengar:LoadSettings()
	SettingsManager:GetSettingsFile("Rengar")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
	-------------------------------------------
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "UseE in drawings")
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

function Rengar:CheckEmpowered()
    local empowered = myHero:GetSpellSlot(0).Info.Name
    if empowered == "RengarQEmp" then
        return true
    else
        return false
    end
end

function Rengar:GetLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Rengar:CastQ()
    local isInBush = myHero.BuffData:GetBuff('rengarpassivebuff')
    if isInBush.Valid then
        local target = Orbwalker:GetTarget("Combo", 775)
        if target then
            local QDmg = GetDamage(0 + (30 * myHero:GetSpellSlot(0).Level) + (((0 + 5 * myHero:GetSpellSlot(0).Level) / 10) * myHero.BonusAttack), true, target)
            if Rengar:CheckEmpowered() == true then
                local level = Rengar:GetLevel()
                local QEmpoweredDmg
                if level <= 9 then
                    QEmpoweredDmg = GetDamage(15 + (15 * level) + 0.4 * myHero.BonusAttack, true, target)
                end
                if level > 9 then
                    QEmpoweredDmg = GetDamage(60 + (10 * level) + 0.4 * myHero.BonusAttack, true, target) 
                end
    
                local totalQDmg = QDmg + QEmpoweredDmg
                local percentageQDmg = (totalQDmg / target.MaxHealth) * 100
                if percentageQDmg > 40 or target.Health - totalQDmg <= 0 then
                    if Engine:SpellReady('HK_SPELL1') and ValidTarget(target) then
                        Engine:CastSpell('HK_SPELL1', nil)
                    end
                else
                    Rengar:CastE()
                end
            else
                local QDmg = GetDamage(0 + (30 * myHero:GetSpellSlot(0).Level) + (((0 + 5 * myHero:GetSpellSlot(0).Level) / 10) * myHero.BonusAttack), true, target)
                local percentageQDmg = (QDmg / target.MaxHealth) * 100
                if percentageQDmg > 40 or target.Health - QDmg <= 0 then
                    if Engine:SpellReady('HK_SPELL1') and ValidTarget(target) then
                        Engine:CastSpell('HK_SPELL1', nil)
                    end
                else
                    Rengar:CastE()
                end
            end
        end
    else
        local target = Orbwalker:GetTarget("Combo", 800)
        if target then
            if GetDist(myHero.Position, target.Position) <= getAttackRange() + 35 and Engine:SpellReady('HK_SPELL1') and ValidTarget(target) then
                Engine:CastSpell('HK_SPELL1', nil)
            else
                Rengar:CastE()
            end
        end
    end
end

function Rengar:CastW()
    if Engine:SpellReady('HK_SPELL2') then
        local WBuff = myHero:GetSpellSlot(1).Info.Name
        if WBuff == "RengarWEmp" then
            local myHeroStunned = myHero.BuffData:HasBuffOfType(BuffType.Stun) or myHero.BuffData:HasBuffOfType(BuffType.Snare) or myHero.BuffData:HasBuffOfType(BuffType.Asleep) or myHero.BuffData:HasBuffOfType(BuffType.Suppression) or myHero.BuffData:HasBuffOfType(BuffType.Taunt) or myHero.BuffData:HasBuffOfType(BuffType.Knockup)
            if myHeroStunned then
                Engine:CastSpell('HK_SPELL2', nil)
            end
        else
            local target = Orbwalker:GetTarget("Combo", 400)
            if target == nil then return end
            if GetDist(myHero.Position, target.Position) <= 400 and not Engine:SpellReady(0) and not Engine:SpellReady('HK_SPELL3') then
                Engine:CastSpell('HK_SPELL2', nil)
            end
        end
    end
end

function Rengar:CastE()
    if self.UseECombo.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 900)
        if target then
            local castPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
            if castPos ~= nil and not target.AIData.Dashing then
                Engine:CastSpell("HK_SPELL3", castPos, 1)
            end
        end
    end
end

function Rengar:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseQCombo.Value == 1 then
                Rengar:CastQ()
            end
            if self.UseWCombo.Value == 1 then
                Rengar:CastW()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then
                Rengar:CastQ()
            end
            if self.UseWHarass.Value == 1 then
                Rengar:CastW()
            end
        end
    end
    -- print(myHero:SpellSlot(1).SpellInfo.Name)
    -- for k,v in myHero.BuffManager.Buffs:pairs() do
    --     print(v.Name)
    -- end
end

function Rengar:OnDraw()
    
end

function Rengar:OnLoad()
    if myHero.ChampionName ~= "Rengar" then return end
    AddEvent("OnSettingsSave" , function() Rengar:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Rengar:LoadSettings() end)
    Rengar:__init()
    AddEvent("OnDraw", function() Rengar:OnDraw() end)
    AddEvent("OnTick", function() Rengar:OnTick() end)
end
AddEvent("OnLoad", function() Rengar:OnLoad() end)