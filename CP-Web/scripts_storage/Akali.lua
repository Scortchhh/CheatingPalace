Akali = {}

require("DamageLib")

function Akali:__init()
    self.QRange = 500
    self.WRange = 650
    self.ERange = 750
    self.RRange = 670

    self.QSpeed = 2000
    self.WSpeed = math.huge
    self.ESpeed = 2000
    self.RSpeed = math.huge

    self.QWidth = 350
    self.EWidth = 120
    self.RWidth = 110
    
    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0.25
    self.RDelay = 0

    self.QHitChance = 0.35
    self.EHitChance = 0.5
    self.RHitChance = 0.4

    self.AkaliMenu = Menu:CreateMenu("Akali")
    self.AkaliCombo = self.AkaliMenu:AddSubMenu("Combo")
    self.AkaliCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.AkaliCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.AkaliCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.AkaliCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.AkaliCombo:AddCheckbox("Use R in combo", 1)
    self.AkaliHarass = self.AkaliMenu:AddSubMenu("Harass")
    self.AkaliHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.AkaliHarass:AddCheckbox("Use Q in harass", 1)
    self.UseEHarass = self.AkaliHarass:AddCheckbox("Use E in harass", 0)
    self.MiscMenu = self.AkaliMenu:AddSubMenu("Misc")
    self.QLasthit = self.MiscMenu:AddCheckbox("Last hit with Q")
    self.AkaliDrawings = self.AkaliMenu:AddSubMenu("Drawings")
    self.DrawQ = self.AkaliDrawings:AddCheckbox("Draw Q", 1)
    self.DrawE = self.AkaliDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.AkaliDrawings:AddCheckbox("Draw R", 1)

    Akali:LoadSettings()
end

function Akali:SaveSettings()
	SettingsManager:CreateSettings("Akali")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Last hit with Q", self.QLasthit.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Akali:LoadSettings()
    SettingsManager:GetSettingsFile("Akali")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.QLasthit.Value = SettingsManager:GetSettingsInt("Misc", "Last hit with Q")
    ---------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Akali:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
end

 function Akali:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Akali:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLasthit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if Akali:GetDistance(myHero.Position, Minion.Position) <= self.QRange then
                    local qDmg = self:GetDamage(5 + (25 * myHero:GetSpellSlot(0).Level) + (myHero.BonusAttack * 0.65) + (myHero.AbilityPower * 0.6) , true, Minion) 
                    if Minion.Health <= qDmg then
                        return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    end
                end
            end
        end
    end
end

function Akali:Combo()
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local EName = myHero:GetSpellSlot(2).Info.Name
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, 1, self.EHitChance, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
        if EName == "AkaliEb" then
            return Engine:CastSpell("HK_SPELL3", nil, 1)
        end
    end
    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 1)
        if target then
            if myHero.Mana <= 40 and self:GetDistance(myHero.Position, target.Position) <= self.QRange then
                return Engine:CastSpell("HK_SPELL2", nil, 0)
            end
        end
    end
    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 1)
        if PredPos then
            if myHero.BuffData:GetBuff("AkaliPWeapon").Valid then
                if self:GetDistance(myHero.Position, target.Position) > (myHero.AttackRange + myHero.CharData.BoundingRadius) * 1.5 then
                    return Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            else
                return Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end
    end 
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            local QDmg = DamageLib.Akali:GetQDmg(target)
            local EDmg = DamageLib.Akali:GetQDmg(target)
            local RDmg = DamageLib.Akali:GetQDmg(target)
            local totalDamage = QDmg + EDmg + RDmg
            local R2 = myHero.BuffData:GetBuff("AkaliR").Valid
            if R2 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, 0, self.RHitChance, 1)
                if PredPos then
                    return Engine:CastSpell("HK_SPELL4", PredPos, 1)
                end
            else
                if target.Health <= totalDamage then
                    return Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
        end
    end 
end

function Akali:Harass() 
    if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local EName = myHero:GetSpellSlot(2).Info.Name
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, 1, self.EHitChance, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
        if EName == "AkaliEb" then
            return Engine:CastSpell("HK_SPELL3", nil, 1)
        end
    end
    if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end 
end

function Akali:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        if Engine:IsKeyDown("HK_COMBO") then
            return self:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            return self:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            return self:LastHitQ()
        end
    end
end

function Akali:OnDraw()
    if myHero.IsDead then return end
    if self.DrawE.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then 
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if self.DrawR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Akali:OnLoad()
    if myHero.ChampionName ~= "Akali" then return end
    AddEvent("OnSettingsSave" , function() Akali:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Akali:LoadSettings() end)
    Akali:__init()
    AddEvent("OnTick", function() Akali:OnTick() end)
    AddEvent("OnDraw", function() Akali:OnDraw() end)
end

AddEvent("OnLoad", function() Akali:OnLoad() end)