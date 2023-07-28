Udyr = {}

function Udyr:__init()

    self.RRange = 370

    self.UdyrMenu         = Menu:CreateMenu("Udyr")
    ------------------------------------------------------------------------------
    self.UdyrCombo        = self.UdyrMenu:AddSubMenu("#Combo: ->")
    self.UseQCombo        = self.UdyrCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo        = self.UdyrCombo:AddCheckbox("Use W", 1)
    self.UseECombo        = self.UdyrCombo:AddCheckbox("Use E", 1)
    self.UseRCombo        = self.UdyrCombo:AddCheckbox("Use R", 1)
    -------------------------------------------------------------------------------
    self.UdyrHarass       = self.UdyrMenu:AddSubMenu("#Harass: ->")
    self.UseQHarass       = self.UdyrHarass:AddCheckbox("Use Q", 1)
    self.UseWHarass       = self.UdyrHarass:AddCheckbox("Use W", 1)
    self.UseEHarass       = self.UdyrHarass:AddCheckbox("Use E", 1)
    self.UseRHarass       = self.UdyrHarass:AddCheckbox("Use R", 1)

    --------------------------------------------------------------------------------
    self.UdyrDrawings     = self.UdyrMenu:AddSubMenu("#Drawings: ->")
    self.DrawR            = self.UdyrDrawings:AddCheckbox("Draw R Range", 1)
    --------------------------------------------------------------------------------
    self.UdyrInfo         = self.UdyrMenu:AddSubMenu("#Info: ->")
                                                                                                                                        
    self.UdyrInfo:AddLabel("==================")
    self.UdyrInfo:AddLabel("Credits:")
    self.UdyrInfo:AddLabel("- Critic")
    self.UdyrInfo:AddLabel("==================")
    self.UdyrInfo:AddLabel("")
    self.UdyrInfo:AddLabel("==============================================")
    self.UdyrInfo:AddLabel("Current Version: 1.0 by Critic")
    self.UdyrInfo:AddLabel("==============================================")
    self.UdyrInfo:AddLabel("")
    self.UdyrInfo:AddLabel("=======================================================================")
    self.UdyrInfo:AddLabel("Last Update: 24/08/2022")
    self.UdyrInfo:AddLabel("=======================================================================")
    self.UdyrInfo:AddLabel("")
    self.UdyrInfo:AddLabel("=======================================================================")
    self.UdyrInfo:AddLabel("ToDo:")
    self.UdyrInfo:AddLabel("=======================================================================")
    --------------------------------------------------------------------------------
    Udyr:LoadSettings()
end

function Udyr:SaveSettings()
	SettingsManager:CreateSettings("Udyr")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQHarass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseWHarass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("UseEHarass", self.UseEHarass.Value)
    SettingsManager:AddSettingsInt("UseRHarass", self.UseRHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Udyr:LoadSettings()
    SettingsManager:GetSettingsFile("Udyr")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQHarass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseWHarass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseEHarass")
    self.UseRHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseRHarass")
    -------------------------------------------
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "DrawR")
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(target) / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Udyr:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            --Render:DrawCircle(Hero.Position, self.QWidth/2 + Hero.CharData.BoundingRadius,0,255,255,255)
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Udyr:InRangeOfEnemy()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
            local Distance = Orbwalker:GetDistance(myHero.Position, Hero.Position)
            local HeroRange = Hero.CharData.BoundingRadius + Hero.AttackRange + 25
            if Distance <= HeroRange then
                return true
            end
        end
    end
    return false
end

function Udyr:FindR()
    local Missiles = ObjectManager.MissileList
    for _, Object in pairs(Missiles) do
        if Object.Team == myHero.Team and _ == Object.Index and Object.Name == "UdyrR" then
            return Object
        end
    end
    return nil
end

function Udyr:IsAutoAttackMissile(Name, Target)
    if string.find(Name, "Attack", 1) ~= nil then
        return 1
    end

    local Missiles = {}
    Missiles["Caitlyn"] 		= {"caitlynheadshotmissile"}
    Missiles["Ashe"] 			= {"frostarrow"}
    Missiles["Kennen"] 		    = {"kennenmegaproc"}
    Missiles["Quinn"] 			= {"quinnwenhanced"}
    Missiles["Vayne"] 			= {"vaynecondemn"}
    Missiles["Jhin"] 			= {"jhine"}

    local PossibleAutos = Missiles[Target.ChampionName]
    if PossibleAutos then
        for i = 1, #PossibleAutos do
            if Name:lower() == PossibleAutos[i] then
                return 1.3
            end
        end
    end
    return nil
end

function Udyr:IncomingAttack() --if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
    local Heros     = ObjectManager.HeroList
    local Turrets   = ObjectManager.TurretList
    local Missiles  = ObjectManager.MissileList
    for _, Hero in pairs(Heros) do
        if myHero.Index == Hero.Index then --myHero.Index!
            local Enemies = self:EnemiesInRange(Hero.Position, 1200)
            if #Enemies > 0 then
                for _, Enemy in pairs(Enemies) do
                    local IsDashing         = Enemy.AIData.Dashing
                    local DashPosition      = Enemy.AIData.TargetPos
                    if Orbwalker:GetDistance(Hero.Position, DashPosition) <= 300 and IsDashing == true then --Ally gets dashed
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local Lethality = Enemy.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Enemy.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Enemy.AbilityPower
                        local realMR    = (Hero.MagicResist - Enemy.MagicPenFlat) * Enemy.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Health20 = myHero.MaxHealth * 0.2
                        local Health40 = myHero.MaxHealth * 0.4
                        if (Health20 < (ADDamage * ArmorMod) * 1.3) or (Health20 < (APDamage * MRMod) * 1.3) then
                            return 2
                        end
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * 1.3) or ((myHero.Health - Health40) < (APDamage * MRMod) * 1.3) then
                            return 2
                        end
                        return 1
                    end

                    if Orbwalker:GetDistance(Hero.Position, Enemy.Position) <= 300 and string.len(Enemy.ActiveSpell.Info.Name) > 0 then --Ally in Melee Range
                        local ADDamage  = Enemy.BaseAttack + Enemy.BonusAttack
                        local Lethality = Enemy.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Enemy.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Enemy.AbilityPower
                        local realMR    = (Hero.MagicResist - Enemy.MagicPenFlat) * Enemy.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Mplier    = 1
                        if Enemy.ActiveSpell.IsAutoAttack then
                            if string.find(Enemy.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(Enemy.ActiveSpell.Info.Name, "crit") ~= nil then
                                Mplier = Mplier + 0.75
                                if Enemy.CritChance >= 0.6 then
                                    Mplier = Mplier + 0.35
                                end
                            end
                        else
                            if string.find(Enemy.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(Enemy.ActiveSpell.Info.Name, "crit") ~= nil then
                                Mplier = Mplier + 1.25
                            else
                                Mplier = Mplier + 0.25
                            end
                        end
                        local Health20 = myHero.MaxHealth * 0.2
                        local Health40 = myHero.MaxHealth * 0.4
                        if (Health20 < (ADDamage * ArmorMod) * Mplier) or (Health20 < (APDamage * MRMod) * Mplier) then
                            return 2
                        end
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return 2
                        end
                        return 1
                    end
                end
            end
        end
    end

    for _, Missile in pairs(Missiles) do
        local Source = Heros[Missile.SourceIndex] or Turrets[Missile.SourceIndex]
        local Target = Heros[Missile.TargetIndex]
        if Source and Target and Source.Team ~= myHero.Team and Target.Index == myHero.Index then --myHero.Index!
            local ADDamage  = Source.BaseAttack + Source.BonusAttack
            local Lethality = Source.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Target) / 18)
            local realArmor = Target.Armor * Source.ArmorPenMod
            local FinalArmor = (realArmor - Lethality)
            if FinalArmor <= 0 then
                FinalArmor = 0
            end
            local ArmorMod  = 100 / (100 + FinalArmor)
            local APDamage  = Source.AbilityPower
            local realMR    = (Target.MagicResist - Source.MagicPenFlat) * Source.MagicPenMod
            local MRMod     = 100 / (100 + realMR)
            local Mplier    = 1
            local EnemyAutoAttack = Udyr:IsAutoAttackMissile(Missile.Name, Source.ChampionName)
            if EnemyAutoAttack ~= nil then
                if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                    Mplier = Mplier + 0.75
                    if Source.CritChance >= 0.6 then
                        Mplier = Mplier + 0.35
                    end
                end
            else
                if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                    Mplier = Mplier + 1.25
                else
                    Mplier = Mplier + 0.25
                end
            end
            local Health20 = myHero.MaxHealth * 0.2
            local Health40 = myHero.MaxHealth * 0.4
            if (Health20 < (ADDamage * ArmorMod) * Mplier) or (Health20 < (APDamage * MRMod) * Mplier) then
                return 2
            end
            if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                return 2
            end
            return 1
        end
        if Source and Source.Team ~= myHero.Team then 
            for _, Hero in pairs(Heros) do
                if myHero.Index == Hero.Index then  --myHero.Index!
                    local StartPos  = Missile.MissileStartPos
                    local EndPos    = Missile.MissileEndPos
                    if Prediction:PointOnLineSegment(StartPos, EndPos, Hero.Position, Missile.MissileInfo.Data.MissileWidth + Hero.CharData.BoundingRadius + 300) then
                        local ADDamage  = Source.BaseAttack + Source.BonusAttack
                        local Lethality = Source.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(Hero) / 18)
                        local realArmor = Hero.Armor * Source.ArmorPenMod
                        local FinalArmor = (realArmor - Lethality)
                        if FinalArmor <= 0 then
                            FinalArmor = 0
                        end
                        local ArmorMod  = 100 / (100 + FinalArmor)
                        local APDamage  = Source.AbilityPower
                        local realMR    = (Hero.MagicResist - Source.MagicPenFlat) * Source.MagicPenMod
                        local MRMod     = 100 / (100 + realMR)
                        local Mplier    = 1

                        if string.find(Missile.Name, "Crit") ~= nil or string.find(Missile.Name, "crit") ~= nil then
                            Mplier = Mplier + 1.25
                        else
                            Mplier = Mplier + 0.25
                        end
                        local Health20 = myHero.MaxHealth * 0.2
                        local Health40 = myHero.MaxHealth * 0.4
                        if (Health20 < (ADDamage * ArmorMod) * Mplier) or (Health20 < (APDamage * MRMod) * Mplier) then
                            return 2
                        end
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return 2
                        end
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

function Udyr:QWER(Mode)
    local PStacks   = myHero.BuffData:GetBuff("UdyrPAttackReady").Count_Int
    local EUp       = myHero.BuffData:GetBuff("UdyrE") --UdyrPassive
    local PassiveUp = myHero.BuffData:GetBuff("UdyrPassive").Count_Int

    local RecastE = myHero.BuffData:GetBuff("udyrerecastready").Count_Alt
    local RecastW = myHero.BuffData:GetBuff("udyrwrecastready").Count_Alt
    local RecastR = myHero.BuffData:GetBuff("udyrrrecastready").Count_Alt

    local IncomingHit = Udyr:IncomingAttack()

    local RTarget = Orbwalker:GetTarget("Combo", self.RRange)
    --print(myHero.BuffData:ShowAllBuffs())
    --print(PassiveUp.Count_Int)

    --print(PStacks) --udyrerecastready
    local TestTarget = Orbwalker:GetTarget("Combo", 800)
    --[[if TestTarget then
        print(TestTarget.BuffData:ShowAllBuffs())
    end]]
    --local llmyMissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100
    --print(llmyMissingHP)

    if (Mode == "Combo" and self.UseWCombo.Value == 1) or (Mode == "Harass" and self.UseWHarass.Value == 1) then
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            if RecastW == 0 then
                --local IncomingHit = Udyr:IncomingAttack()
                local SaveR = 0
                if RecastR == 1 then
                    local ReRTarget = Orbwalker:GetTarget("Combo", self.RRange + 150)
                    if ReRTarget then
                        local myMissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100 
                        local TargetMissingHP = ((ReRTarget.MaxHealth - ReRTarget.Health) / ReRTarget.MaxHealth) * 100 
                        if (myMissingHP + 20) < TargetMissingHP or myMissingHP < 30 then
                            SaveR = 1
                        end
                    end
                end

                if SaveR == 0 then
                    if IncomingHit ~= 0 then
                        local RTStunUp = nil 
                        if RTarget then
                            RTStunUp = RTarget.BuffData:GetBuff("UdyrEStunCheck")
                        end 
                        local Stunning = 0
                        if EUp.Count_Alt == 1 and RTStunUp ~= nil and RTStunUp.Count_Alt == 0 then
                            local Stunning = 1
                        end
                        if Stunning == 0 then
                            return Engine:CastSpell("HK_SPELL2", nil, 0)
                        else
                            if IncomingHit == 2 then
                                return Engine:CastSpell("HK_SPELL2", nil, 0)
                            end
                        end
                    end
                    local Heros = ObjectManager.HeroList
                    for I, Hero in pairs(Heros) do
                        if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                            local Distance = Orbwalker:GetDistance(myHero.Position, Hero.Position)
                            local HeroRange = Hero.CharData.BoundingRadius + Hero.AttackRange
                            if Distance <= HeroRange then
                                if Distance <= Orbwalker.OrbRange + 5 then
                                    if PStacks == 0 then
                                        return Engine:CastSpell("HK_SPELL2", nil, 0)
                                    end
                                else
                                    local TStunUp = Hero.BuffData:GetBuff("UdyrEStunCheck")
                                    local Stunning = 0
                                    if EUp.Count_Alt == 1 and TStunUp.Count_Alt == 0 then
                                        local Stunning = 1
                                    end
                                    if Stunning == 0 then
                                        return Engine:CastSpell("HK_SPELL2", nil, 0)
                                    else
                                        if IncomingHit == 2 then
                                            return Engine:CastSpell("HK_SPELL2", nil, 0)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                --local IncomingHit = Udyr:IncomingAttack()
                local myMissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100
                if myMissingHP >= 75 then
                    print("Wut1")
                    return Engine:CastSpell("HK_SPELL2", nil, 0)
                end

                if IncomingHit == 2 and myMissingHP > 30 then
                    print("Wut2")
                    return Engine:CastSpell("HK_SPELL2", nil, 0)
                end

                local Heros = ObjectManager.HeroList
                for I, Hero in pairs(Heros) do
                    if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                        local Distance = Orbwalker:GetDistance(myHero.Position, Hero.Position)
                        local HeroRange = Hero.CharData.BoundingRadius + Hero.AttackRange + 25
                        if Distance <= HeroRange then 
                            local HeroMissingHP = ((Hero.MaxHealth - Hero.Health) / Hero.MaxHealth) * 100 
                            if (myMissingHP + 20) >= HeroMissingHP and PStacks == 0 and myMissingHP > 30 then
                                print("Wut3")
                                return Engine:CastSpell("HK_SPELL2", nil, 0)
                            end
                        end
                    end
                end
            end
        end
    end

    if Mode == "Combo" then
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            if RecastE == 0 then
                local ETarget = Orbwalker:GetTarget("Combo", self.RRange)
                local OrbTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
                if ETarget then
                    if OrbTarget then
                        local OrbTStunUp = OrbTarget.BuffData:GetBuff("UdyrEStunCheck")
                        if PStacks == 0 and OrbTStunUp.Count_Alt == 0 then
                            return Engine:CastSpell("HK_SPELL3", nil, 0)
                        end
                    else
                        local ETStunUp = ETarget.BuffData:GetBuff("UdyrEStunCheck")
                        if ETStunUp.Count_Alt == 0 then
                            return Engine:CastSpell("HK_SPELL3", nil, 0)
                        end
                    end
                else
                    local Heros = ObjectManager.HeroList
                    for I, Hero in pairs(Heros) do
                        if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                            local ESpeed = 1
                            if myHero:GetSpellSlot(1).Level > 0 then
                                ESpeed = 1.23 + myHero:GetSpellSlot(1).Level * 0.07
                            end
                            local mySpeed = myHero.MovementSpeed
                            local HeroSpeed = Hero.MovementSpeed
                            local Distance = Orbwalker:GetDistance(myHero.Position, Hero.Position)
                            local LongTStunUp = Hero.BuffData:GetBuff("UdyrEStunCheck")
                            if LongTStunUp.Count_Alt == 0 and Distance < ((mySpeed * ESpeed) - HeroSpeed) * 2.5 then
                                return Engine:CastSpell("HK_SPELL3", nil, 0)
                            end
                        end
                    end
                end
            else
                --Make it use before CC Hits!
            end
        end
    else
        if Mode == "Harass" then
            if RecastE == 0 then
                if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                    local ETarget = Orbwalker:GetTarget("Combo", self.RRange)
                    local OrbTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
                    if ETarget then
                        if OrbTarget then
                            local OrbTStunUp = OrbTarget.BuffData:GetBuff("UdyrEStunCheck")
                            if PStacks == 0 and OrbTStunUp.Count_Alt == 0 then
                                return Engine:CastSpell("HK_SPELL3", nil, 0)
                            end
                        else
                            local ETStunUp = ETarget.BuffData:GetBuff("UdyrEStunCheck")
                            if ETStunUp.Count_Alt == 0 then
                                return Engine:CastSpell("HK_SPELL3", nil, 0)
                            end
                        end
                    end
                end
            else
                --Make it use before CC Hits!
            end
        end
    end

    if (Mode == "Combo" and self.UseRCombo.Value == 1) or (Mode == "Harass" and self.UseRHarass.Value == 1) then
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            if RecastR == 0 then
                if RTarget then
                    local RTStunUp = RTarget.BuffData:GetBuff("UdyrEStunCheck")
                    local Stunning = 0
                    if EUp.Count_Alt == 1 and RTStunUp.Count_Alt == 0 then
                        local Stunning = 1
                    end
                    if Stunning == 0 then
                        if Orbwalker:GetDistance(myHero.Position, RTarget.Position) <= Orbwalker.OrbRange + 45 then
                            if PStacks == 0 then
                                return Engine:CastSpell("HK_SPELL4", nil, 0)
                            end
                        else
                            return Engine:CastSpell("HK_SPELL4", nil, 0)
                        end
                    end
                end
            else
                if RTarget then
                    local myMissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100 
                    local TargetMissingHP = ((RTarget.MaxHealth - RTarget.Health) / RTarget.MaxHealth) * 100 
                    if (myMissingHP + 20) < TargetMissingHP or myMissingHP < 30 then
                        if Orbwalker:GetDistance(myHero.Position, RTarget.Position) <= Orbwalker.OrbRange + 45 then
                            if PStacks == 0 then
                                return Engine:CastSpell("HK_SPELL4", nil, 0)
                            end
                        else
                            return Engine:CastSpell("HK_SPELL4", nil, 0)
                        end
                    end
                end
            end
        end
    end
end

function Udyr:Laneclear() 

end

function Udyr:Lasthit() 

end

function Udyr:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local RLevel 					= myHero:GetSpellSlot(3).Level
    local DamagePerLevel            = {350, 55, 750}
    local DamagePerLevelMod         = {2.2, 2.6, 3}
    local Stacks                    = myHero.BuffData:GetBuff("Udyrpassivestacks").Count_Int --Udyrpassivestacks
    
	local DMG 						= DamagePerLevel[RLevel] + (myHero.BonusAttack * DamagePerLevelMod[RLevel])
    local MissingHP                 = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100 
    local Runes                     = 1
    if MissingHP > 0.45 then
        Runes = Runes + 0.05
    end
    if MissingHP > 0.55 then
        Runes = Runes + 0.02
    end
    if MissingHP > 0.65 then
        Runes = Runes + 0.02
    end
    if MissingHP > 0.75 then
        Runes = Runes + 0.02
    end
	return GetDamage(DMG, true, Target) * Runes + Stacks
end

function Udyr:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false then

        if Engine:IsKeyDown("HK_COMBO") then
            self:QWER("Combo")
		end

        if Engine:IsKeyDown("HK_HARASS") then
            self:QWER("Harass")
        end

        if Engine:IsKeyDown("HK_LANECLEAR") then
            self:Laneclear()
		end

		if Engine:IsKeyDown("HK_LASTHIT") then
            self:Lasthit()
        end
    end
end

function Udyr:OnDraw()
    if myHero.IsDead == true then return end

    if self.DrawR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        Render:DrawCircle(myHero.Position, self.RRange, 255,155,0,255)
    end
end

function Udyr:OnLoad()
    if myHero.ChampionName ~= "Udyr" then return end
    AddEvent("OnSettingsSave" , function() Udyr:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Udyr:LoadSettings() end)
    Udyr:__init()
    AddEvent("OnTick", function() Udyr:OnTick() end)
    AddEvent("OnDraw", function() Udyr:OnDraw() end)
end

AddEvent("OnLoad", function() Udyr:OnLoad() end)