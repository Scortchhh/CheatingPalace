local Twitch = {
    WModes = {
        "Smart",
        "Simple",
        "Off",
    },
    PoisonBuff = "TwitchDeadlyVenom",
    StealthBuff = "TwitchHideInShadows",
    AttackspeedBuff = "twitchhideinshadowsbuff",
    UltBuff = "TwitchFullAutomatic",
    QManaCost = 40,
    WManaCost = 70,
    EManaCost = {
        [0] = 0,
        [1] = 50, 
        [2] = 60, 
        [3] = 70, 
        [4] = 80, 
        [5] = 90,
    },
    QDuration = {
        [0] = 0,
        [1] = 10, 
        [2] = 11, 
        [3] = 12, 
        [4] = 13, 
        [5] = 14,
    },
    RManaCost = 100,

    Rune = {
        "Coup de Grace",
        "Cut Down",
        "Last Stand",
        "None",
    },
}

function Twitch:__init()
    self.WRange = 950
    self.WSpeed = 1400
    self.WDelay = 0.25
    self.WWidth = 340
    self.ERange = 1200 --Center to Center, smallest unit has 55 Radius (Teemo)
    self.EDelay = 0.25

    self.QTimer = 0

    ------------------|| Menu ||------------------
    self.Menu           = Menu:CreateMenu("Twitch")
    -------------|| Runes & Items ||---------------
    self.RunesItems     = self.Menu:AddSubMenu("Runes and Items")
    self.aaa4           = self.RunesItems:AddLabel("Select your current Rune")
    self.SelectRune     = self.RunesItems:AddCombobox("runeeeee", Twitch.Rune)
    self.aaa3           = self.RunesItems:AddLabel("Untick items below if you built something else, like")
    self.aaa5           = self.RunesItems:AddLabel("Mortal Reminder or other lethality item, otherwise")
    self.aaa6           = self.RunesItems:AddLabel("keep it ALWAYS ON and forget about this section ;)")
    self.TheCollector   = self.RunesItems:AddCheckbox("The Collector", 1)
    self.LDR            = self.RunesItems:AddCheckbox("Lord Dominik's Regards", 1)
    -------------|| Combo Settings ||-------------
    self.ComboSettings  = self.Menu:AddSubMenu("Combo Mode")
    self.UseQCombo      = self.ComboSettings:AddCheckbox("Use Q before Attack in Combo", 1)
    self.aaa            = self.ComboSettings:AddLabel("W Logic")
    self.aaa2           = self.ComboSettings:AddLabel("Smart = Compare MS, don't use in Ult, don't use if loss of DPS")
    self.UseWCombo      = self.ComboSettings:AddCombobox("W Logic", self.WModes) --WCheck2
    self.PrioritizeUtility = self.ComboSettings:AddCheckbox("Prioritize Utility in SmartW", 1)
    self.StealthW       = self.ComboSettings:AddCheckbox("Use W while stealthed", 0)  --use W with Q Stealth buff WCheck1
    self.UseR           = self.ComboSettings:AddCheckbox("Auto R", 1)
    -------------|| Harass Settings ||------------
    self.HarassSettings = self.Menu:AddSubMenu("Harass Mode")
    self.UseWHarass     = self.HarassSettings:AddCheckbox("Use W in Harass", 1)
    self.UseEHarass     = self.HarassSettings:AddCheckbox("Use E in Harass if fully stacked", 1)
    -----------|| Automatic Settings ||-----------
    self.GeneralSettings = self.Menu:AddSubMenu("General Settings")
    self.HoldMana       = self.GeneralSettings:AddCheckbox("Hold Mana for E", 1) --keep Mana for E
    self.UseEFullstack  = self.GeneralSettings:AddCheckbox("Use E if fully stacked", 0)
    self.FullstackCheck = self.GeneralSettings:AddCheckbox("^only if out of AA Range", 0) --if out of AA Range of Main Target in E Range
    self.UseEKillable   = self.GeneralSettings:AddSlider("Use E if can kill # Enemies", 2, 1, 5, 1)
    self.IgnoreSlider   = self.GeneralSettings:AddCheckbox("^Ignore if in 1v1", 1) --~900 Range enemy count check
    self.UseEKillableAA = self.GeneralSettings:AddCheckbox("Use E if 1 target killable and outside AA range", 0) --~900 Range enemy count check
    ------------|| Drawing Settings ||------------
    self.DrawingSettings = self.Menu:AddSubMenu("Drawings")
    self.ShowQTimer     = self.DrawingSettings:AddCheckbox("Draw Q Time left", 1)
    self.DrawQCircle    = self.DrawingSettings:AddCheckbox("Draw Q Range left", 1) --Show how far u can walk with stealth as a circle with current MS
    self.DrawWRange     = self.DrawingSettings:AddCheckbox("Draw W Range", 1)
    self.DrawERange     = self.DrawingSettings:AddCheckbox("Draw E Range", 0)
    self.DrawRRange     = self.DrawingSettings:AddCheckbox("Draw R Range", 0)
    self.DrawEDMG       = self.DrawingSettings:AddCheckbox("Draw remaining DMG to Execute with E", 1)
    ----------------------------------------------

    Twitch:LoadSettings()
end

function Twitch:SaveSettings()
    SettingsManager:CreateSettings("Twitch")
    -------------|| Runes & Items ||---------------
    SettingsManager:AddSettingsGroup("RunesItems")
    SettingsManager:AddSettingsInt("Rune", self.SelectRune.Selected)
    SettingsManager:AddSettingsInt("TheCollector", self.TheCollector.Value)
    SettingsManager:AddSettingsInt("LDR", self.LDR.Value)
    -------------|| Combo Settings ||-------------
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("ComboQ", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("WMode", self.aaa.Value)
    SettingsManager:AddSettingsInt("ComboW", self.UseWCombo.Selected)
    SettingsManager:AddSettingsInt("UtilityW", self.PrioritizeUtility.Value)
    SettingsManager:AddSettingsInt("StealthW", self.StealthW.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseR.Value)
    -------------|| Harass Settings ||------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HarassW", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("HarassE", self.UseEHarass.Value)
    -----------|| Automatic Settings ||-----------
    SettingsManager:AddSettingsGroup("General")
    SettingsManager:AddSettingsInt("HoldMana", self.HoldMana.Value)
    SettingsManager:AddSettingsInt("EStack", self.UseEFullstack.Value)
    SettingsManager:AddSettingsInt("ECheck", self.FullstackCheck.Value)
    SettingsManager:AddSettingsInt("EKillable", self.UseEKillable.Value)
    SettingsManager:AddSettingsInt("1v1e", self.IgnoreSlider.Value)
    SettingsManager:AddSettingsInt("UseEKillableAA", self.UseEKillableAA.Value)
    ------------|| Drawing Settings ||------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("QTimer", self.ShowQTimer.Value)
    SettingsManager:AddSettingsInt("QCircle", self.DrawQCircle.Value)
    SettingsManager:AddSettingsInt("WRange", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("ERange", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("RRange", self.DrawRRange.Value)
    SettingsManager:AddSettingsInt("DrawEDMG", self.DrawEDMG.Value)

    ----------------------------------------------
end

function Twitch:LoadSettings()
    SettingsManager:GetSettingsFile("Twitch")
    -------------|| Runes & Items ||---------------
    self.SelectRune.Selected = SettingsManager:GetSettingsInt("RunesItems", "Rune")
    self.TheCollector.Value = SettingsManager:GetSettingsInt("RunesItems", "TheCollector")
    self.LDR.Value = SettingsManager:GetSettingsInt("RunesItems", "LDR")
    -------------|| Combo Settings ||-------------
	self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo","ComboQ")
    self.UseWCombo.Selected = SettingsManager:GetSettingsInt("Combo","ComboW")
    self.aaa.Value = SettingsManager:GetSettingsInt("Combo","WMode")
    self.PrioritizeUtility.Value = SettingsManager:GetSettingsInt("Combo", "UtilityW")
    self.StealthW.Value = SettingsManager:GetSettingsInt("Combo","StealthW")
    self.UseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
    -------------|| Harass Settings ||------------
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass","HarassW")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass","HarassE")
    -----------|| Automatic Settings ||-----------
    self.HoldMana.Value = SettingsManager:GetSettingsInt("General","HoldMana")
    self.UseEFullstack.Value = SettingsManager:GetSettingsInt("General","EStack")
    self.FullstackCheck.Value = SettingsManager:GetSettingsInt("General","ECheck")
    self.UseEKillable.Value = SettingsManager:GetSettingsInt("General","EKillable")
    self.IgnoreSlider.Value = SettingsManager:GetSettingsInt("General","1v1e")
    self.UseEKillableAA.Value = SettingsManager:GetSettingsInt("General","UseEKillableAA")
    ------------|| Drawing Settings ||------------
    self.ShowQTimer.Value = SettingsManager:GetSettingsInt("Drawings","QTimer")
    self.DrawQCircle.Value = SettingsManager:GetSettingsInt("Drawings","QCircle")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings","WRange")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings","ERange")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings","RRange")
    self.DrawEDMG.Value = SettingsManager:GetSettingsInt("Drawings","DrawEDMG")
    --------------------------------------------
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Twitch:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local FinalArmor = (target.Armor * myHero.ArmorPenMod) - (myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(myHero) / 18))
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg
    end

    if not isPhys then
        local FinalMagicResist = (target.MagicResist * myHero.MagicPenMod) - myHero.MagicPenFlat
        if FinalMagicResist <= 0 then
            FinalMagicResist = 0
        end
        return (100 / (100 + FinalMagicResist)) * rawDmg
    end
    return 0
end

function Twitch:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Twitch:GetAttackRange(target)
    local attRange = target.AttackRange + target.CharData.BoundingRadius + 20
    return attRange
end

function Twitch:CalcIgnite()
    local dmg = 50 + 20 * GetHeroLevel(myHero)
    return dmg
end

function Twitch:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do    
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Twitch:GetExecuteDMG(target)
    local EStacks = target.BuffData:GetBuff("twitchdeadlyvenom").Count_Int
    local Level = myHero:GetSpellSlot(2).Level

    if Level > 0 and EStacks > 0 then
        --ECalculations
        local BaseDamagePerLevel    = {20, 30, 40, 50, 60}
        local BaseDamage            = BaseDamagePerLevel[Level]

        local AdditionalDamagePerLevel  = {15,20,25,30,35}
        local AdditionalDamage          = AdditionalDamagePerLevel[Level]

        local AD_DamagePerStack   = AdditionalDamage + (myHero.BonusAttack * 0.35)
        local AP_DamagePerStack   = myHero.AbilityPower * 0.30 -- Updated 13.5 Patch

        local AD = Twitch:GetDamage((BaseDamage + (AD_DamagePerStack*EStacks)), true, target)
        local AP = Twitch:GetDamage((AP_DamagePerStack*EStacks), false, target)

        local LDR          = 0 -- Mixed Damage (E), we need it inside "EDamage"
        if self.LDR.Value == 1 and myHero.ArmorPenMod < 0.7 and target.MaxHealth > myHero.MaxHealth then -- Lord Dominik's Regards
            local HPDiff1 = target.MaxHealth - myHero.MaxHealth
            if HPDiff1 > 2500 then HPDiff1 = 2500 end
            if HPDiff1 > 100 then 
                LDR = (HPDiff1 / 10000) * AD
            end
        end
        
        local EDamage  = math.max(0, (math.max(0, (AD + LDR) - target.PhysicalShield) + math.max(0, AP - target.MagicalShield)) - target.Shield) 

        -- Runes and Finishers
        local TheCollector = 0
        local CoupDeGrace  = 0
        local CutDown      = 0
        local LastStand    = 0

        local OneSecondHPReg = ((10 + 1 * target.Level) / 5)

        if self.TheCollector.Value == 1 and myHero.ArmorPenFlat > 11 then -- The Collector
		    TheCollector = target.MaxHealth * 0.05
        end
        
        if self.SelectRune.Selected == 0 and target.Health <= target.MaxHealth / 100 * 39 then -- Coup De Grace
            CoupDeGrace = EDamage * 0.08
        end

        if self.SelectRune.Selected == 1 and target.MaxHealth > myHero.MaxHealth then -- Cut Down
            local HPDiff2 = ((target.MaxHealth - myHero.MaxHealth) / myHero.MaxHealth)
            if HPDiff2 > 1 then HPDiff2 = 1 end
            if HPDiff2 > 0.1 then 
                CutDown = ((HPDiff2 - 0.1) * 1/9 + 0.05) * EDamage  
            end
        end

        if self.SelectRune.Selected == 2 then -- Last Stand
            local MyMissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth)
    
            if MyMissingHP > 0.7 then MyMissingHP = 0.7 end
            if MyMissingHP > 0.4 then 
                LastStand = ((MyMissingHP - 0.4) * 0.2 + 0.05) * EDamage
            end
        end

        local FullDamage = EDamage + CoupDeGrace + CutDown + LastStand - OneSecondHPReg

        if myHero.BuffData:GetBuff("ElderDragonBuff").Valid then
            return FullDamage + target.MaxHealth * 0.2
        end

        return FullDamage + TheCollector
    end
    return 0
end

function Twitch:DrawEDamage()
	for I, Enemy in pairs(ObjectManager.HeroList) do
		if Enemy.Team ~= myHero.Team and Enemy.IsDead == false then
            local eDmg = self:GetExecuteDMG(Enemy)
            if eDmg > 0 then
                local DrawExecuteDMG
                if myHero.BuffData:GetBuff("ElderDragonBuff").Valid then
                    DrawExecuteDMG = string.format(math.floor(Enemy.Health - (Enemy.MaxHealth * 0.2) - eDmg))
                else
                    DrawExecuteDMG = string.format(math.floor(Enemy.Health - eDmg))
                end
                

                local ScreenPos = Vector3.new()
			    Render:World2Screen(Enemy.Position, ScreenPos)

                if Enemy.Health <= eDmg then
                    Render:DrawFilledBox(ScreenPos.x - 25, ScreenPos.y - 60, 5, 19, 255,0,0,255)
                    Render:DrawFilledBox(ScreenPos.x - 20, ScreenPos.y - 60, string.len("Killable") * 9, 19, 0,0,0,200)
                    Render:DrawString("Killable", ScreenPos.x - 15, ScreenPos.y - 60, 255,0,0,255)
                else
                    Render:DrawFilledBox(ScreenPos.x - 25, ScreenPos.y - 60, 5, 19, 255,0,0,255)
                    Render:DrawFilledBox(ScreenPos.x - 20, ScreenPos.y - 60, string.len(DrawExecuteDMG) * 13, 19, 0,0,0,200)
                    Render:DrawString(DrawExecuteDMG, ScreenPos.x - 15, ScreenPos.y - 60, 255,0,0,255)
                end
            end
		end
	end
end

function Twitch:StealthCheck()
    local buff = Twitch.StealthBuff
    if myHero.BuffData:GetBuff(buff).Valid then
        local qDuration = self.QDuration[myHero:GetSpellSlot(0).Level]
        if self.QEndTime == nil then
            self.QEndTime = myHero.BuffData:GetBuff(buff).StartTime + qDuration
        end
        return true
    else
        self.QEndTime = nil
        return false 
    end
    if self.StealthW.Value == 1 then
        self.QEndTime = nil
        return false
    end
end

function Twitch:WCheck2()
    if Orbwalker.Attack == 1 then return false end
    if self.PrioritizeUtility.Value == 0 then
        if (os.clock() - Orbwalker.AttackTimer - self.WDelay) < (Orbwalker:GetPlayerAttackDelay(myHero)) then return false end
    end
    local buff = Twitch.UltBuff
    if myHero.BuffData:GetBuff(buff).Valid then return false else return true end
end

function Twitch:WCheck3(target)
    local dist = self:GetDist(myHero.Position, target.Position)
    local range = self:GetAttackRange(target)
    local A = dist - range
    if A < 0 then return false end
    local speed = target.MovementSpeed
    local B = A / speed
    if B < 0.25 then return false else return true end
end

function Twitch:CheckQTimer()
    local Delay = Orbwalker:GetPlayerAttackDelay(myHero)
    local Windup = Orbwalker:GetPlayerAttackWindup(myHero)
    local Both = Delay + Windup
    local CurrentTime = os.clock()
    local NextAttack = CurrentTime - Orbwalker.AttackTimer + Delay
    local Timer = 0 + NextAttack + Windup
    if Timer > 1 then
        if NextAttack < 1 then return false end
    end
    repeat
        Timer = Timer + Both
    until Timer > 1
    if Timer > 1 then
        if Timer - Windup <= 1 then return false end
    end
    return true
end

function Twitch:QWCombo()
    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") and (os.clock() - self.QTimer) > 1 then
        if Twitch:CheckQTimer() then
            local buff = myHero.BuffData:GetBuff(Twitch.StealthBuff).Valid
            if not buff then
                local target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
                if target then
                    Engine:CastSpell("HK_SPELL1", nil, 0)
                    self.QTimer = os.clock()
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") then
        if not self:StealthCheck() then
            local selectedOption = self.UseWCombo.Selected
            if selectedOption == 0 then
                if self:WCheck2() then 
                    -- smart
                    local HeroList = ObjectManager.HeroList
                    for i, Hero in pairs(HeroList) do
                        if not Hero.IsDead and Hero.IsTargetable and myHero.Team ~= Hero.Team then
                            if self:WCheck3(Hero) then
                                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, 0.2, 0)
                                if CastPos ~= nil then
                                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                                end
                            end
                        end
                    end
                end
            elseif selectedOption == 1 then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, 0.2, 0)
                if CastPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                end
            end
        end
    end
end

function Twitch:QWHarass()
    if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            local buff = target.BuffData:GetBuff(Twitch.PoisonBuff).Count_Int
            if buff >= 6 then
                Engine:CastSpell("HK_SPELL3", nil, 1)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
        if not self:StealthCheck() then
            local selectedOption = self.UseWCombo.Selected
            if selectedOption == 0 then
                if self:WCheck2() then 
                    -- smart
                    local HeroList = ObjectManager.HeroList
                    for i, Hero in pairs(HeroList) do
                        if not Hero.IsDead and Hero.IsTargetable and myHero.Team ~= Hero.Team then
                            if self:WCheck3(Hero) then
                                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, 0.2, 0)
                                if CastPos ~= nil then
                                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                                end
                            end
                        end
                    end
                end
            elseif selectedOption == 1 then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, 0.2, 0)
                if CastPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", CastPos, 1)
                end
            end
        end
    end
end

function Twitch:E()
    if Engine:SpellReady("HK_SPELL3") then
        local HeroList = ObjectManager.HeroList
        local enemiesKillable = 0
        local enemyCountSlider = self.UseEKillable.Value
        for i, Hero in pairs(HeroList) do
            if not Hero.IsDead and Hero.IsTargetable and myHero.Team ~= Hero.Team then
                if self.UseEFullstack.Value == 1 then
                    if self.FullstackCheck.Value == 1 then
                        local target = Orbwalker:GetTarget("Combo", self.ERange)
                        if target and self:GetDist(myHero.Position, target.Position) > Orbwalker.OrbRange then
                            local buff = target.BuffData:GetBuff(Twitch.PoisonBuff).Count_Int
                            if buff >= 6 then
                                Engine:CastSpell("HK_SPELL3", nil, 1)
                            end
                        end
                    else
                        local target = Orbwalker:GetTarget("Combo", self.ERange)
                        if target then
                            local buff = target.BuffData:GetBuff(Twitch.PoisonBuff).Count_Int
                            if buff >= 6 then
                                Engine:CastSpell("HK_SPELL3", nil, 1)
                            end
                        end
                    end
                end
                local eDmg = self:GetExecuteDMG(Hero)
                if Hero.Health < eDmg then
                    enemiesKillable = enemiesKillable + 1
                end
            end
        end
        if self.IgnoreSlider.Value == 1 and self:EnemiesInRange(myHero.Position, 1100) == 1 then
            if enemiesKillable > 0 then
                Engine:CastSpell("HK_SPELL3", nil, 1)
            end
            if self.UseEKillableAA.Value == 1 then
                for i, Hero in pairs(HeroList) do
                    if not Hero.IsDead and Hero.IsTargetable and myHero.Team ~= Hero.Team then
                        if Hero.Health < self:GetExecuteDMG(Hero) and self:GetDist(myHero.Position, Hero.Position) > Orbwalker.OrbRange then
                            Engine:CastSpell("HK_SPELL3", nil, 1)
                        end
                    end
                end
            end
        else
            if self.UseEKillableAA.Value == 1 then
                for i, Hero in pairs(HeroList) do
                    if not Hero.IsDead and Hero.IsTargetable and myHero.Team ~= Hero.Team then
                        if Hero.Health < self:GetExecuteDMG(Hero) and self:GetDist(myHero.Position, Hero.Position) > Orbwalker.OrbRange then
                            Engine:CastSpell("HK_SPELL3", nil, 1)
                        end
                    end
                end
            end
            if enemyCountSlider > 0 then
                if enemiesKillable >= enemyCountSlider then
                    Engine:CastSpell("HK_SPELL3", nil, 1)
                end
            end
        end
    end
end

function Twitch:R()
    local target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 300) 
    if target then
        local enemiesAround = self:EnemiesInRange(target.Position, 300)
        if enemiesAround >= 3 then
            local enemiesAroundMe = self:EnemiesInRange(myHero.Position, 450)
            if enemiesAroundMe == 0 then
                if myHero.Health >= myHero.MaxHealth * 0.6 then
                    Engine:CastSpell("HK_SPELL4", nil, 0)
                end
            end
        end
    end
end

function Twitch:Combo()
    if self.UseR.Value == 1 then
        self:R()
    end
    if self.HoldMana.Value == 1 then
        local HoldManaForE = self.EManaCost[myHero:GetSpellSlot(2).Level]
        if myHero.Mana >= HoldManaForE * 1.875 then
            self:QWCombo()
        end
    else
        self:QWCombo()
    end
end

function Twitch:Harass()
    if self.HoldMana.Value == 1 then
        local HoldManaForE = self.EManaCost[myHero:GetSpellSlot(2).Level]
        if myHero.Mana >= HoldManaForE * 1.875 then
            self:QWHarass()
        end
    else
        self:QWHarass()
    end
end

function Twitch:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:E()
        if Engine:IsKeyDown("HK_COMBO") then
            return self:Combo()	
        end
        if Engine:IsKeyDown("HK_HARASS") then
            return self:Harass()	
        end
    end
end

function Twitch:OnDraw()
    if Engine:SpellReady("HK_SPELL1") then
        if self:StealthCheck() then
            local remainingStealthInSeconds = self.QEndTime - GameClock.Time
			local outVec = Vector3.new()
            if Render:World2Screen(myHero.Position, outVec) and self.ShowQTimer.Value == 1 then
                Render:DrawString("Q buff lasts for: " .. math.ceil(remainingStealthInSeconds) .. " seconds", outVec.x + 49, outVec.y + 30, 255,255,255,255)
            end	
            if self.DrawQCircle.Value == 1 then
                local walkAbleDistanceInQ = myHero.MovementSpeed * remainingStealthInSeconds
                Render:DrawCircle(myHero.Position, walkAbleDistanceInQ,255,0,255,255)
                Render:DrawCircleMap(myHero.Position, walkAbleDistanceInQ ,255,0,255,255)    
            end
        else
            if self.DrawQCircle.Value == 1 then
                local qDuration = self.QDuration[myHero:GetSpellSlot(0).Level]
                local walkAbleDistanceInQ = myHero.MovementSpeed * qDuration
                Render:DrawCircle(myHero.Position, walkAbleDistanceInQ,255,0,255,255)
                Render:DrawCircleMap(myHero.Position, walkAbleDistanceInQ ,255,0,255,255)         
            end
        end
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, Orbwalker.OrbRange + 300 ,170,170,170,170)
    end
    if self.DrawEDMG.Value == 1 then
        self:DrawEDamage()
    end
end

function Twitch:OnLoad()
    if(myHero.ChampionName ~= "Twitch") then return end
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
    Twitch:__init()
    AddEvent("OnTick", function() self:OnTick() end)	
    AddEvent("OnDraw", function() self:OnDraw() end)
end
AddEvent("OnLoad", function() Twitch:OnLoad() end)
