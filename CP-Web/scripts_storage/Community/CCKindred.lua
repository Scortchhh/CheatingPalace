local Kindred = {
    SelectedAlly = {},
    TargetingOptions = {
        "ON",
        "OFF",
    },
}

---///MADE BY: Critic///---
---///CREDITS: Christoph and specially Scortch///---
---///EXTRA CREDITS: Demontime and MrWong///---

function Kindred:__init()

    self.ScriptVersion = "          --CCKindred Version: 0.850-- ///Credits to Scortch and Christoph///"

    self.RangeQ = 340
    self.RangeW = 550
    self.RangeR = 500
    
    self.TimerStart = 0
    self.TimerStart2 = 0
    self.TimerStart3 = 0
    self.TimerStart4 = 0

    self.ChampionMenu = Menu:CreateMenu("Kindred")
    ---------------------------------------------
    self.KindredCombo           = self.ChampionMenu:AddSubMenu("Combo")
    self.KindredCombo:AddLabel("Check Spells for Combo:")
    -----------------COMBO-----------------------
    self.UseQCombo              = self.KindredCombo:AddCheckbox("Use Q in combo", 1)
    --...............Q-MODES...................--
    self.QModes                 = self.KindredCombo:AddSubMenu("Q Modes")
    self.QModes:AddLabel("Manage Q modes:")
    self.QToMouse               = self.QModes:AddCheckbox("Use Q to mouse", 1)
    self.QToTarget              = self.QModes:AddCheckbox("Use Q to target", 0)
    --.........................................--
    self.UseWCombo              = self.KindredCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo              = self.KindredCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo              = self.KindredCombo:AddCheckbox("Use R in combo", 1)
    -----------------R-SETTINGS------------------
    self.KindredR               = self.KindredCombo:AddSubMenu("R settings")
    self.KindredR:AddLabel("Manage R usage:")
    --.........................................--
    self.useRtoSave             = self.KindredR:AddCheckbox("Use R on myself", 1)
    self.useRonAlly             = self.KindredR:AddCheckbox("Use R on ally", 1)
    self.WHPSliderAllyCombo     = self.KindredR:AddSlider("Use R when you or ally below % HP", 20,1,100,1)
    --.........................................--
    self.DontREnemy             = self.KindredR:AddCheckbox("Don't R enemy in R range (silder below)", 1)
    self.WHPSliderEnemyCombo    = self.KindredR:AddSlider("Don't R if enemy below % HP", 30,1,100,1)
    --.........................................--
    self.MoreAllies             = self.KindredR:AddCheckbox("Don't R if more allies than enemies in range", 1)
    self.MoreAlliesSlider       = self.KindredR:AddSlider("X more amount of allies", 2,1,4,1)
    -----------------AllyTargetSelector----------
    self.TargetSelector         = self.ChampionMenu:AddSubMenu("Force R selected allies")
	self.TargetOption           = self.TargetSelector:AddCombobox("Select allies", Kindred.TargetingOptions)
    -----------------Harass----------------------
    self.KindredHarass          = self.ChampionMenu:AddSubMenu("Harass")
    self.KindredHarass:AddLabel("Check Spells for Harass:")

    self.UseQHarass             = self.KindredHarass:AddCheckbox("Use Q in Harass", 1)
    self.HarassQMana            = self.KindredHarass:AddSlider("Minimum % mana to use Q", 45,1,100,1)   
    self.UseWHarass             = self.KindredHarass:AddCheckbox("Use W in Harass", 1)
    self.HarassWMana            = self.KindredHarass:AddSlider("Minimum % mana to use W", 75,1,100,1)
    self.UseEHarass             = self.KindredHarass:AddCheckbox("Use E in Harass", 1)
    self.HarassEMana            = self.KindredHarass:AddSlider("Minimum % mana to use E", 60,1,100,1)
    -----------------Lane/JungleClear------------
    self.ClearMenu              = self.ChampionMenu:AddSubMenu("Lane/JungleClear")
    self.ClearMenu:AddLabel("Spell options for Lane/jungle clear:")
    -----------------Lane------------------------
    self.LaneClearMenu          = self.ClearMenu:AddSubMenu("(BETA:) Lane/Jungle")

    self.LaneClearUseQ          = self.LaneClearMenu:AddCheckbox("Use Q in Laneclear", 1)
    self.QLaneClearSettings     = self.LaneClearMenu:AddSubMenu("Q Laneclear Settings")
    self.LaneClearQMana         = self.QLaneClearSettings:AddSlider("Minimum % mana to use Q", 35,1,100,1)

    self.LaneClearUseW          = self.LaneClearMenu:AddCheckbox("Use W in Laneclear", 1)
    self.WLaneClearSettings     = self.LaneClearMenu:AddSubMenu("W Laneclear Settings")
    self.LaneClearWMana         = self.WLaneClearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)

    self.LaneClearUseE          = self.LaneClearMenu:AddCheckbox("Use E in Laneclear", 1)
    self.ELaneClearSettings     = self.LaneClearMenu:AddSubMenu("E Laneclear Settings")
    self.LaneClearEMana         = self.ELaneClearSettings:AddSlider("Minimum % mana to use E", 25,1,100,1)
    -----------------Jungle-----------------------
    ---self.JungleClearMenu        = self.ClearMenu:AddSubMenu("In Jungle")

    ---self.JungleClearUseQ        = self.JungleClearMenu:AddCheckbox("Use Q in Jungleclear", 1)
    ---self.QJungleClearSettings   = self.JungleClearMenu:AddSubMenu("Q Jungleclear Settings")
    ---self.JungleClearQMana       = self.QJungleClearSettings:AddSlider("Minimum % mana to use Q", 35,1,100,1)

    ---self.JungleClearUseW        = self.JungleClearMenu:AddCheckbox("Use W in Jungleclear", 1)
    ---self.WJungleClearSettings   = self.JungleClearMenu:AddSubMenu("W Jungleclear Settings")
    ---self.JungleClearWMana       = self.WJungleClearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)

    ---self.JungleClearUseE        = self.JungleClearMenu:AddCheckbox("Use E in Jungleclear", 1)    
    ---self.EJungleClearSettings   = self.JungleClearMenu:AddSubMenu("E Jungleclear Settings")
    ---self.JungleClearEMana       = self.EJungleClearSettings:AddSlider("Minimum % mana to use E", 25,1,100,1)
    -----------------DRAWINGS--------------------
    self.KindredDrawings        = self.ChampionMenu:AddSubMenu("Drawings")

    self.DrawQ                  = self.KindredDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW                  = self.KindredDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawR                  = self.KindredDrawings:AddCheckbox("Use R in drawings", 1)
    self.DrawJungleCamp         = self.KindredDrawings:AddCheckbox("Possibe Mark Positions", 1)
    self.DrawRTime              = self.KindredDrawings:AddCheckbox("Draw R time", 1)
    self.DrawJungleMark         = self.KindredDrawings:AddCheckbox("(Alpha)Track Jungle mark", 1)
    self.DrawCheatSheet         = self.KindredDrawings:AddCheckbox("Draw mark cheatsheet", 1)
    --self.DrawEnemyHitMark       = self.KindredDrawings:AddCheckbox("Track enemy mark online", 1)

    Kindred:LoadSettings()
end

function Kindred:SaveSettings()
    SettingsManager:CreateSettings("Kindred")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Qmodes")
    SettingsManager:AddSettingsInt("Use Q to mouse", self.QToMouse.Value)
    SettingsManager:AddSettingsInt("Use Q to target", self.QToTarget.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Rsettings")
    SettingsManager:AddSettingsInt("Use R on myself", self.useRtoSave.Value)
    SettingsManager:AddSettingsInt("Use R on ally", self.useRonAlly.Value)
    SettingsManager:AddSettingsInt("Use R when you or ally below % HP", self.WHPSliderAllyCombo.Value)
    SettingsManager:AddSettingsInt("Don't R enemy in R range (silder below)", self.DontREnemy.Value)
    SettingsManager:AddSettingsInt("Don't R if enemy below % HP", self.WHPSliderEnemyCombo.Value)
    SettingsManager:AddSettingsInt("Don't R if more allies than enemies in range", self.MoreAllies.Value)
    SettingsManager:AddSettingsInt("X more amount of allies", self.MoreAlliesSlider.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.HarassEMana.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in Laneclear", self.LaneClearUseQ.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneClearQMana.Value)
    SettingsManager:AddSettingsInt("Use W in Laneclear", self.LaneClearUseW.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.LaneClearWMana.Value)
    SettingsManager:AddSettingsInt("Use E in Laneclear", self.LaneClearUseE.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneClearEMana.Value)
    ----------------------------------------------
    ---SettingsManager:AddSettingsGroup("Jungleclear")
    ---SettingsManager:AddSettingsInt("Use Q in Jungleclear", self.JungleClearUseQ.Value)
    ---SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.JungleClearQMana.Value)
    ---SettingsManager:AddSettingsInt("Use W in Jungleclear", self.JungleClearUseW.Value)
    ---SettingsManager:AddSettingsInt("Minimum % mana to use W", self.JungleClearWMana.Value)
    ---SettingsManager:AddSettingsInt("Use E in Jungleclear", self.JungleClearUseE.Value)
    ---SettingsManager:AddSettingsInt("Minimum % mana to use E", self.JungleClearEMana.Value)
    ----------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Possibe Mark Positions", self.DrawJungleCamp.Value)
    SettingsManager:AddSettingsInt("Draw R time", self.DrawRTime.Value)
    SettingsManager:AddSettingsInt("Track jungle mark", self.DrawJungleMark.Value)
    SettingsManager:AddSettingsInt("Draw mark cheatsheet",  self.DrawCheatSheet.Value)
    --SettingsManager:AddSettingsInt("Track enemy mark online", self.DrawEnemyHitMark.Value)
end

function Kindred:LoadSettings()
    SettingsManager:GetSettingsFile("Kindred")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    ----------------------------------------------
    self.QToMouse.Value     = SettingsManager:GetSettingsInt("Qmodes", "Use Q to mouse")
    self.QToTarget.Value    = SettingsManager:GetSettingsInt("Qmodes", "Use Q to target")
    ----------------------------------------------
    self.useRtoSave.Value           = SettingsManager:GetSettingsInt("Rsettings", "Use R on myself")
    self.useRonAlly.Value           = SettingsManager:GetSettingsInt("Rsettings", "Use R on ally")
    self.WHPSliderAllyCombo.Value   = SettingsManager:GetSettingsInt("Rsettings", "Use R when you or ally below % HP")
    self.DontREnemy.Value           = SettingsManager:GetSettingsInt("Rsettings", "Don't R enemy in R range (silder below)")
    self.WHPSliderEnemyCombo.Value  = SettingsManager:GetSettingsInt("Rsettings", "Don't R if enemy below % HP")
    self.MoreAllies.Value           = SettingsManager:GetSettingsInt("Rsettings", "Don't R if more allies than enemies in range")
    self.MoreAlliesSlider.Value     = SettingsManager:GetSettingsInt("Rsettings", "X more amount of allies")
    ----------------------------------------------
    self.UseQHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use Q in Harass")
    self.HarassQMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use Q")
    self.UseWHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use W in Harass")
    self.HarassWMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use W")
    self.UseEHarass.Value           = SettingsManager:GetSettingsInt("Harass", "Use E in Harass")
    self.HarassEMana.Value          = SettingsManager:GetSettingsInt("Harass", "Minimum % mana to use E")
    ----------------------------------------------
    self.LaneClearUseQ.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use Q in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneClearUseW.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use W in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use W")
    self.LaneClearUseE.Value        = SettingsManager:GetSettingsInt("Laneclear", "Use E in Laneclear")
    self.LaneClearQMana.Value       = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
    ----------------------------------------------
    ---self.JungleClearUseQ.Value      = SettingsManager:GetSettingsInt("Jungleclear", "Use Q in Jungleclear")
    ---self.JungleClearQMana.Value     = SettingsManager:GetSettingsInt("Jungleclear", "Minimum % mana to use Q")
    ---self.JungleClearUseW.Value      = SettingsManager:GetSettingsInt("Jungleclear", "Use W in Jungleclear")
    ---self.JungleClearQMana.Value     = SettingsManager:GetSettingsInt("Jungleclear", "Minimum % mana to use W")
    ---self.JungleClearUseE.Value      = SettingsManager:GetSettingsInt("Jungleclear", "Use E in Jungleclear")
    ---self.JungleClearQMana.Value     = SettingsManager:GetSettingsInt("Jungleclear", "Minimum % mana to use E")
    ----------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
    self.DrawJungleCamp.Value = SettingsManager:GetSettingsInt("Drawings", "Possibe Mark Positions")
    self.DrawRTime.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R time")
    self.DrawJungleMark.Value = SettingsManager:GetSettingsInt("Drawings", "Track jungle mark")
    self.DrawCheatSheet.Value = SettingsManager:GetSettingsInt("Drawings", "Draw mark cheatsheet")
    --self.DrawEnemyHitMark.Value = SettingsManager:GetSettingsInt("Drawings", "Track enemy mark online")
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

local function AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Kindred:Combo()
    local QRange = getAttackRange() + 240
    local target = Orbwalker:GetTarget("Combo", QRange)
    if target == nil then return end
    if not ValidTarget(target) then return end
    if GetDist(myHero.Position, target.Position) <= QRange then
        if Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 and self.QToMouse.Value == 1 and Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL1", Vector3.new() ,1) 
        end
        if Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 and self.QToTarget.Value == 1 and Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL1", target.Position ,1)
        end
    end

    local target = Orbwalker:GetTarget("Combo", 500)
    if target == nil then return end
    if not ValidTarget(target) then return end
    if GetDist(myHero.Position, target.Position) <=500 then
        if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
            Engine:CastSpell("HK_SPELL2", target.Position ,1)
        end
    end

    local eRange = getAttackRange() + 30
    local target = Orbwalker:GetTarget("Combo", eRange)
    if target == nil then return end
    if not ValidTarget(target) then return end
    if GetDist(myHero.Position, target.Position) <= eRange then
        if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
            Engine:CastSpell("HK_SPELL3", target.Position ,1)
        end
    end
end

function Kindred:Harass()
    local QRange = getAttackRange() + 240
    local target = Orbwalker:GetTarget("Harass", QRange)
    local HQSliderValue = self.HarassQMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local QHarassCondition = myHero.MaxMana / 100 * HQSliderValue
    if myHero.Mana >= QHarassCondition then
        if GetDist(myHero.Position, target.Position) <= QRange then
            if Engine:SpellReady('HK_SPELL1') and self.UseQHarass.Value == 1 and Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
            
            end
        end
    end

    local target = Orbwalker:GetTarget("Harass", 500)
    local HWSliderValue = self.HarassWMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local WHarassCondition = myHero.MaxMana / 100 * HWSliderValue
    if myHero.Mana >= WHarassCondition then
        if GetDist(myHero.Position, target.Position) <=500 then
            if Engine:SpellReady('HK_SPELL2') and self.UseWHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL2", target.Position ,1)
            end
        end
    end

    local eRange = getAttackRange() + 30
    local target = Orbwalker:GetTarget("Harass", eRange)
    local HESliderValue = self.HarassEMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local EHarassCondition = myHero.MaxMana / 100 * HESliderValue
    if myHero.Mana >= EHarassCondition then
        if GetDist(myHero.Position, target.Position) <= eRange then
            if Engine:SpellReady('HK_SPELL3') and self.UseEHarass.Value == 1 then
            Engine:CastSpell("HK_SPELL3", target.Position ,1)
            end
        end
    end
end

function Kindred:SavemyHeroR()
    local target = Orbwalker:GetTarget("Combo", 600)
    if target == nil then return end
    if not ValidTarget(target) then return end
    local DontREnemyHP = target.MaxHealth / 100 * self.WHPSliderEnemyCombo.Value
    local XAllies = AlliesInRange(myHero.Position, 700) - EnemiesInRange(myHero.Position, 700)
    if self.MoreAllies.Value == 1 and XAllies >= self.MoreAlliesSlider.Value then return end
    if self.DontREnemy.Value == 1 and GetDist(myHero.Position, target.Position) <= 600 and target.Health < DontREnemyHP then return end
    if self.useRtoSave.Value == 1 then
        if EnemiesInRange(myHero.Position, 700) >= 1 then
            local saveHP = myHero.MaxHealth / 100 * self.WHPSliderAllyCombo.Value
            if myHero.Health <= saveHP and Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL4", Vector3.new() ,1)
            end
        end
    end
end

function Kindred:SaveAllyR()
    local target = Orbwalker:GetTarget("Combo", 600)
    if target == nil then return end
    if not ValidTarget(target) then return end
    local DontREnemyHP = target.MaxHealth / 100 * self.WHPSliderEnemyCombo.Value
    local XAllies = AlliesInRange(myHero.Position, 700) - EnemiesInRange(myHero.Position, 700)
    if self.MoreAllies.Value == 1 and XAllies >= self.MoreAlliesSlider.Value then return end
    if self.DontREnemy.Value == 1 and GetDist(myHero.Position, target.Position) <= 600 and target.Health < DontREnemyHP then return end
    if self.useRonAlly.Value == 1 then
        for k, Ally in pairs(ObjectManager.HeroList) do
            if Ally.Team == myHero.Team then
                if EnemiesInRange(Ally.Position, 700) >= 1 and GetDist(myHero.Position, Ally.Position) <= 500 then
                    local saveAllyHP = Ally.MaxHealth / 100 * self.WHPSliderAllyCombo.Value
                    if Ally.Health <= saveAllyHP and Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                        Engine:CastSpell("HK_SPELL4", Vector3.new() ,1)
                    end
                end
            end
        end
    end
end

function Kindred:ForceR()
    local target = Orbwalker:GetTarget("Combo", 600)
    if target == nil then return end 
    if not ValidTarget(target) then return end
    if self.useRonAlly.Value == 1 and self.TargetOption.Selected == 0 then
        for k, Ally in pairs(ObjectManager.HeroList) do
            if Ally.Team == myHero.Team then
                local TickOnAlly = self.SelectedAlly[Ally.Index].Value
                if EnemiesInRange(Ally.Position, 700) >= 1 and GetDist(myHero.Position, Ally.Position) <= 500 then
                    if TickOnAlly == 1 then
                        local saveAllyHP = Ally.MaxHealth / 100 * self.WHPSliderAllyCombo.Value
                        if Ally.Health <= saveAllyHP and Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                            Engine:CastSpell("HK_SPELL4", Vector3.new() ,1)
                        end
                    end
                end
            end
        end
    end
end

function Kindred:Laneclear()
    local QRange = getAttackRange() + 240
    local target = Orbwalker:GetTarget("Laneclear", QRange)
    local LQSliderValue = self.LaneClearQMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local QLaneCondition = myHero.MaxMana / 100 * LQSliderValue
    if myHero.Mana >= QLaneCondition then
        if GetDist(myHero.Position, target.Position) <= QRange then
            if Engine:SpellReady('HK_SPELL1') and self.LaneClearUseQ.Value == 1 and Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
            
            end
        end
    end

    local target = Orbwalker:GetTarget("Laneclear", 500)
    local LWSliderValue = self.LaneClearWMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local WLaneCondition = myHero.MaxMana / 100 * LWSliderValue
    if myHero.Mana >= WLaneCondition then
        if GetDist(myHero.Position, target.Position) <=500 then
            if Engine:SpellReady('HK_SPELL2') and self.LaneClearUseW.Value == 1 then
            Engine:CastSpell("HK_SPELL2", target.Position ,1)
            end
        end
    end

    local eRange = getAttackRange() + 30
    local target = Orbwalker:GetTarget("Laneclear", eRange)
    local LESliderValue = self.LaneClearEMana.Value
    if target == nil then return end
    if not ValidTarget(target) then return end
    local ELaneCondition = myHero.MaxMana / 100 * LESliderValue -- 420 for the memes!!
    if myHero.Mana >= ELaneCondition then
        if GetDist(myHero.Position, target.Position) <= eRange then
            if Engine:SpellReady('HK_SPELL3') and self.LaneClearUseE.Value == 1 then
            Engine:CastSpell("HK_SPELL3", target.Position ,1)
            end
        end
    end
end

--function Kindred:DrawHitMark(target)

    --local MarkString = "Offline"


    --local MarkOnTarget = "KindredMark:" .. "\n" .. MarkString

    --local vecOut = Vector3.new()
    --if Render:World2Screen(target.Position, VecOut) then
        --Render:DrawString(MarkOnTarget, vecOut.x + 50 , vecOut.y - 50, 255, 255, 255, 255)
    --end
--end


function Kindred:DrawJungleCampMarks()
    --local JungleTimer =
    local MarkCount = myHero.BuffData:GetBuff("kindredmarkofthekindredstackcounter")
    if MarkCount.Count_Int < 1 then
        Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
        Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
    end
    if myHero.Team == 100 then
        if MarkCount.Count_Int > 0 and MarkCount.Count_Int < 4 then
            Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
            Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
            Render:DrawString("( )", 1776.5, 891, 92, 255, 5, 255) --RedRaptors R
            Render:DrawString("( )", 1861, 946, 92, 255, 5, 255) --RedGromp R
        end
        if MarkCount.Count_Int > 3 and MarkCount.Count_Int < 8 then
            Render:DrawString("( )", 1834.5, 912, 92, 255, 5, 255) --RedWolf R
            Render:DrawString("( )", 1754, 844, 92, 255, 5, 255) --RedKrug R
            Render:DrawString("( )", 1835.4, 937, 92, 255, 5, 255) --RedBLUE R
            Render:DrawString("( )", 1764.3, 867, 92, 255, 5, 255) --RedRED R
        end
    else 
        if MarkCount.Count_Int > 0 and MarkCount.Count_Int < 4 then
            Render:DrawString("( )", 1718.25, 891, 92, 255, 5, 255) --TopScuttle R
            Render:DrawString("( )", 1824, 968, 92, 255, 5, 255) --BotScuttle R
            Render:DrawString("( )", 1765, 965, 92, 255, 5, 255) --BlueRaptors R
            Render:DrawString("( )", 1680, 912, 92, 255, 5, 255) --BlueGromp R
        end
        if MarkCount.Count_Int > 3 and MarkCount.Count_Int < 8 then
            Render:DrawString("( )", 1708, 945, 92, 255, 5, 255) --BlueWolf R
            Render:DrawString("( )", 1787, 1012, 92, 255, 5, 255) --BlueKrug R
            Render:DrawString("( )", 1707.4, 919, 92, 255, 5, 255) --BlueBLUE R
            Render:DrawString("( )", 1775.7, 987, 92, 255, 5, 255) --BlueRED R
        end
    end
    if MarkCount.Count_Int > 7 then
        Render:DrawString("( )", 1815, 980, 92, 255, 5, 255) --Dragons R
        Render:DrawString("( )", 1728, 875, 92, 255, 5, 255) --Baron/Herald R
    end
    Render:DrawString("JungleMark Positions:", 1650, 650, 255, 255, 255, 255)
    Render:DrawString("ON", 1835, 650, 92, 255, 5, 255)
end

function Kindred:DrawJungleTimer()
    local RBuff = myHero.BuffData:GetBuff("kindredhitlistmonsteractivetracker")
    if self.DrawJungleMark.Value == 1 then
        if RBuff.Valid then return end

        local RTime = 41 - GameClock.Time + self.TimerStart2
        local RString = string.format("%.2f", RTime)
        if RTime <= 0 then
            self.TimerStart2 = GameClock.Time
        end
        if RBuff.Valid then
            self.TimerStart2 = GameClock.Time
        end
        local StartMark = 200 - GameClock.Time
        if StartMark < 0 then
            Render:DrawString("JungleMark Online In:", 665, 50, 225, 225, 225, 225)
            Render:DrawString(RString, 850, 50, 92, 255, 5, 255)
        end
    end
end

function Kindred:CheatSheetTimer()
    if self.DrawCheatSheet.Value == 1 then

        local RTime = 30 - GameClock.Time + self.TimerStart4
        local RString = string.format("%.2f", RTime)
        if RTime <= 0 then
            self.TimerStart4 = GameClock.Time
        end
        local StartMark = 200 - GameClock.Time
        if StartMark < 0 then
            Render:DrawString(RString, 1650, 380, 92, 255, 5, 255)
        end
    end
end

function Kindred:RTimer()
    local RBuff = myHero.BuffData:GetBuff("KindredRNoDeathBuff")
    if RBuff.Valid then

        local RTime = 4 - GameClock.Time + self.TimerStart
        local RString = string.format("%.2f", RTime)
        if RTime <= 0 then
            self.TimerStart = GameClock.Time
        end
        Render:DrawString(RString, 750, 500, 92, 255, 5, 255)
    end
end
            

function Kindred:OnTick()
    --print(myHero.BuffData:GetBuff("kindredmarkofthekindredstackcounter").Count_Float)
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        for i,Ally in pairs(ObjectManager.HeroList) do 
			if Ally.Team == myHero.Team and string.len(Ally.ChampionName) > 1 then
				if self.SelectedAlly[Ally.Index] == nil then
                    local Name = Ally.ChampionName
					self.SelectedAlly[Ally.Index] = self.TargetSelector:AddCheckbox(Name, 1)
				end
			end
		end
        if Engine:IsKeyDown("HK_COMBO") then
            Kindred:Combo()
            Kindred:SavemyHeroR()
            Kindred:SaveAllyR()
            Kindred:ForceR()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Kindred:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Kindred:Laneclear()
            --Kindred:Jungleclear()
			return
        end
    end
end
   
function Kindred:OnDraw()
   -- local Heros = ObjectManager.HeroList
   -- for I, Hero in pairs(Heros) do
     --   if Hero.Team ~= myHero.Team then
      --      if self.DrawEnemyHitMark.Value == 1 then
      --          if Hero.IsTargetable then
      --              self:DrawHitMark(Hero)
      --          end
      --      end
     --   end
    -- end
    if self.DrawJungleMark.Value == 1 then
        self:DrawJungleTimer()
    end
    if self.DrawRTime.Value == 1 then
        self:RTimer()
    end
    if self.DrawJungleCamp.Value == 1 then
        self:DrawJungleCampMarks()
    else
        Render:DrawString("JungleMark Positions:", 1650, 650, 255, 255, 255, 255)
        Render:DrawString("OFF", 1835, 650, 255, 0, 0, 255)
    end
    if self.DrawCheatSheet.Value == 1 then
        Render:DrawString("0: Scutt", 1650, 400, 255, 255, 255, 255)
        Render:DrawString("1-3: Scutt, Raptor, Gromp", 1650, 415, 255, 255, 255, 255)
        Render:DrawString("4-7: Krug, Blue , Wolf, Red", 1650, 430, 255, 255, 255, 255)
        Render:DrawString("8: Baron, Dragons", 1650, 445, 255, 255, 255, 255)
        self:CheatSheetTimer()
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeQ ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeW ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RangeR ,100,150,255,255)
    end
end

function Kindred:OnLoad()
    if(myHero.ChampionName ~= "Kindred") then return end
    AddEvent("OnSettingsSave" , function() Kindred:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Kindred:LoadSettings() end)
    

    Kindred:__init()
    AddEvent("OnDraw", function() Kindred:OnDraw() end)
    AddEvent("OnTick", function() Kindred:OnTick() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Kindred:OnLoad() end)