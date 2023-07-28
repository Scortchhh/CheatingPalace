local Tristana = {
    champs = {},
}

function Tristana:__init()
    self.TristanaMenu = Menu:CreateMenu("Tristana")
    self.TristanaCombo = self.TristanaMenu:AddSubMenu("Combo")
    self.TristanaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.TristanaCombo:AddCheckbox("UseQ in combo", 1)
    self.UseECombo = self.TristanaCombo:AddCheckbox("UseE in combo", 1)
    self.ComboFocusETarget = self.TristanaCombo:AddCheckbox("Force AA E target in combo", 1)
    self.UseRCombo = self.TristanaCombo:AddCheckbox("UseR in combo", 1)
    self.ETargetsCombo = self.TristanaCombo:AddSubMenu("E Whitelisting in combo")
    self.TristanaHarass = self.TristanaMenu:AddSubMenu("Harass")
    self.TristanaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.TristanaHarass:AddCheckbox("UseQ in harass", 1)
    self.UseEHarass = self.TristanaHarass:AddCheckbox("UseE in harass", 0)
    self.TristanaLaneclear = self.TristanaMenu:AddSubMenu("Laneclear")
    self.TristanaLaneclear:AddLabel("Check Spells for Laneclear:")
    self.UseQLaneclear = self.TristanaLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.QLaneclearSettings = self.TristanaLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.UseELaneclear = self.TristanaLaneclear:AddCheckbox("UseE in laneclear", 1)
    self.ELaneclearSettings = self.TristanaLaneclear:AddSubMenu("E Laneclear Settings")
    self.LaneclearEMana = self.ELaneclearSettings:AddSlider("Minimum % mana to use E", 30,1,100,1)
    self.TristanaKillSteal = self.TristanaMenu:AddSubMenu("Killsteal")
    self.TristanaKillSteal:AddLabel("Killsteal with R + E logics:")
    self.UseRKillsteal = self.TristanaKillSteal:AddCheckbox("UseR in killsteal", 1)

    Tristana:LoadSettings()
end

function Tristana:SaveSettings()
	SettingsManager:CreateSettings("Tristana")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Force AA E target in combo", self.ComboFocusETarget.Value)

    SettingsManager:AddSettingsGroup("E Whitelisting in combo")
    -- local heroList = ObjectManager.HeroList
    -- for i = 1, #heroList do
    --     if heroList[i].Team ~= myHero.Team then
    --         SettingsManager:AddSettingsInt("UseE" .. heroList[i].Index, self.champs.Value)
    --     end
    -- end
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseE in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseQ in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("UseE in laneclear", self.UseELaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneclearEMana.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Killsteal")
    SettingsManager:AddSettingsInt("UseR in killsteal", self.UseRKillsteal.Value)
end

function Tristana:LoadSettings()
	SettingsManager:GetSettingsFile("Tristana")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR in combo")
    self.ComboFocusETarget.Value = SettingsManager:GetSettingsInt("Combo", "Force AA E target in combo")
    self.champs.Value = SettingsManager:GetSettingsInt("E Whitelisting in combo", "Force AA E target in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseE in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseQ in laneclear")
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseE in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneclearEMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
	-------------------------------------------
    self.UseRKillsteal.Value = SettingsManager:GetSettingsInt("Killsteal", "UseR in killsteal")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
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


local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Tristana:TargetIsImmune(Target)
    local IsImmune          = Orbwalker:TargetIsImmune(Target)
    local GwenCheck         = (Target.BuffData:GetBuff("gwenw_gweninsidew").Valid == false or Orbwalker:GetDistance(myHero.Position, Target.Position) <= 475)
    if IsImmune == false and GwenCheck then
        return false
    else
        return true
    end
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

function Tristana:ComboQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 10)
        if target then
            return Engine:CastSpell('HK_SPELL1', nil, 0) 
        end 
    end
end

function Tristana:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Tristana:EnemiesInRange2(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if Orbwalker:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Tristana:ETargetSelector(List)
    local CurrentList = {}
    for _, Object in pairs(List) do
        CurrentList[#CurrentList+1] = Object
    end
    for left = 1, #CurrentList do  
        for right = left+1, #CurrentList do
            local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
            local RightPio = Orbwalker.Prio[CurrentList[right].Index]
            if LeftPrio and RightPio and Orbwalker:PredictDamageToTarget(CurrentList[left], LeftPrio.Value) < Orbwalker:PredictDamageToTarget(CurrentList[right], RightPio.Value) then    
                local Swap = CurrentList[left] 
                CurrentList[left] = CurrentList[right]  
                CurrentList[right] = Swap  
            else
                local LeftDamage = Orbwalker:PredictDamageToTarget(CurrentList[left], 1)
                local RightDamage = Orbwalker:PredictDamageToTarget(CurrentList[right], 1)
                if LeftDamage < RightDamage then    
                    local Swap = CurrentList[left] 
                    CurrentList[left] = CurrentList[right]  
                    CurrentList[right] = Swap  
                end    
            end   
        end
    end
    return CurrentList 
end

-- DO TOTAL REWORK THIS IS NOt WORKING AT ALL!!
function Tristana:ComboE()
    if Engine:SpellReady('HK_SPELL3') then
        local List = self:EnemiesInRange(myHero.Position, Orbwalker.OrbRange + 900 + 55)
        local Enemies = self:ETargetSelector(List) --Make targetselector
        if #Enemies > 0 then
            for _, Enemy in pairs(Enemies) do
                local Prio = Orbwalker:GetHeroPrio(Enemy.ChampionName)
                if Prio == nil then
                    Prio = 3
                end
                local Dist = Orbwalker:GetDistance(myHero.Position, Enemy.Position) <= Orbwalker.OrbRange
                if Prio > 2 then
                    if Dist then
                        return Engine:CastSpell('HK_SPELL3', Enemy.Position, 1) 
                    end
                else
                    if #Enemies == 1 then
                        if Dist then
                            return Engine:CastSpell('HK_SPELL3', Enemy.Position, 1) 
                        end
                    else
                        local rDmg      = Tristana:RDmg(Enemy)
                        local eDmg      = Tristana:EDmg(Enemy, true)
                        local AADmg     = GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, Enemy)
                        local ExtraHP 	= 10 + ((10 + 1 * GetHeroLevel(Enemy)) / 5)
                        local TargetHP  = Enemy.Health + ExtraHP * 3
                        local totalDmg = eDmg + (AADmg * (1 + myHero.CritChance * 0.5) * 4)
                        if Engine:SpellReady('HK_SPELL4') then
                            totalDmg = totalDmg + rDmg
                        end
                        if TargetHP < totalDmg then
                            return Engine:CastSpell('HK_SPELL3', Enemy.Position, 1) 
                        end 
                    end
                end
            end
        end  
    end
end

function Tristana:RDmg(Target)
    local rDmg = GetDamage(200 + (100 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower, false, Target)
    return rDmg
end

function Tristana:EDmg(Target, useMaxStacks)
    local EDmg = GetDamage(60 + (10 * myHero:GetSpellSlot(2).Level) + (0.25 + (0.25 * myHero:GetSpellSlot(2).Level)) * myHero.BonusAttack + 0.5 * myHero.AbilityPower, true, Target)
    local tristE = Target.BuffData:GetBuff('tristanaecharge').Count_Alt
    if tristE >= 2 then
        tristE = tristE + 1
    end
    if tristE > 4 or useMaxStacks == true then
        tristE = 4
    end
    if tristE > 0 then
        EDmg = EDmg * (1 + tristE * 0.3)
    end
    if myHero.CritChance > 0 then
        EDmg = EDmg + (EDmg * myHero.CritChance * 0.33)
    end
    --print(EDmg)
    return EDmg
end

function Tristana:AAReset()
	--print(myHero.ActiveSpell.Info.Name)
	local Action 			= myHero.ActiveSpell.Info.Name
	local Name 				= "Attack"
	local AutoAction		= string.find(Action, Name) ~= nil
    local CritName 			= "Crit"
	local CritAction		= string.find(Action, CritName) ~= nil
    if AutoAction then
        return 1
    else
        if CritAction then
            return 2
        end
    end
    return false
end

function Tristana:IsAutoAttackMissile(Name, Target)
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

function Tristana:IncomingAttack() 
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
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * 1.3) or ((myHero.Health - Health40) < (APDamage * MRMod) * 1.3) then
                            return true
                        end
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
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return true
                        end
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
            local EnemyAutoAttack = self:IsAutoAttackMissile(Missile.Name, Source.ChampionName)
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
            local Health40 = myHero.MaxHealth * 0.4
            if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                return true
            end
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
                        local Health40 = myHero.MaxHealth * 0.4
                        if ((myHero.Health - Health40)  < (ADDamage * ArmorMod) * Mplier) or ((myHero.Health - Health40) < (APDamage * MRMod) * Mplier) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function Tristana:ComboR()
    local AAReset = Tristana:AAReset()
    if Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team then
                if GetDist(myHero.Position, target.Position) <= Orbwalker.OrbRange then 
                    if ValidTarget(target) and self:TargetIsImmune(target) == false then 
                        local IncomingAttack 	= self:IncomingAttack()
                        local LowHP				= myHero.Health <= myHero.MaxHealth / 100 * 40
                        local tristE    = target.BuffData:GetBuff('tristanaecharge')
                        local rDmg      = Tristana:RDmg(target)
                        local eDmg      = Tristana:EDmg(target, false)
                        local AADmg     = GetDamage(myHero.BaseAttack + myHero.BonusAttack, true, target)
                        local ExtraHP 	= 10 + ((10 + 1 * GetHeroLevel(target)) / 5)
                        local TargetHP  = target.Health + ExtraHP * 1.5
                        if LowHP or IncomingAttack == true then
                            if tristE.Count_Alt > 0 then
                                local totalDmg = rDmg + eDmg + AADmg
                                if AAReset == 1 then
                                    totalDmg = totalDmg + AADmg
                                else
                                    if AAReset == 2 then
                                        totalDmg = totalDmg + AADmg * 1.75
                                    end 
                                end
                                if TargetHP < totalDmg then
                                    return Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                end
                            else
                                local totalDmg = rDmg + AADmg
                                if AAReset == 1 then
                                    totalDmg = totalDmg + AADmg
                                else
                                    if AAReset == 2 then
                                        totalDmg = totalDmg + AADmg * 1.75
                                    end 
                                end
                                if TargetHP < rDmg then
                                    return Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                end
                            end
                        else
                            local Enemies = self:EnemiesInRange2(myHero.Position, Orbwalker.OrbRange + 400)
                            local Divine = 1
                            if Enemies == 2 then
                                Divine = 1.5
                            end
                            if Enemies == 3 then
                                Divine = 2
                            end
                            if Enemies == 4 then
                                Divine = 3
                            end
                            if Enemies == 5 then
                                Divine = 4
                            end
                            local KillAA = AADmg * myHero.AttackSpeedMod * 0.656 * (1 + myHero.CritChance * 0.75) * 3
                            KillAA = KillAA / Divine
                            if TargetHP > KillAA then
                                if tristE.Count_Alt > 0 then
                                    local totalDmg = rDmg + eDmg + AADmg
                                    if AAReset == 1 then
                                        totalDmg = totalDmg + AADmg
                                    else
                                        if AAReset == 2 then
                                            totalDmg = totalDmg + AADmg * 1.75
                                        end 
                                    end
                                    if TargetHP < totalDmg then
                                        return Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                    end
                                else
                                    local totalDmg = rDmg + AADmg
                                    if AAReset == 1 then
                                        totalDmg = totalDmg + AADmg
                                    else
                                        if AAReset == 2 then
                                            totalDmg = totalDmg + AADmg * 1.75
                                        end 
                                    end
                                    if TargetHP < rDmg then
                                        return Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Tristana:LaneclearQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Laneclear", Orbwalker.OrbRange)
        if target then 
            local sliderValue = self.LaneclearQMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if GetDist(myHero.Position, target.Position) <= Orbwalker.OrbRange + 30 and myHero.Mana >= condition then
                Engine:CastSpell('HK_SPELL1', nil, 0)
                return
            end
        end
    end
end

function Tristana:LaneclearE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Laneclear", Orbwalker.OrbRange)
        if target then
            local sliderValue = self.LaneclearEMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
           if GetDist(myHero.Position, target.Position) <= 650 and myHero.Mana >= condition and target.Health >= 800 then
                Engine:CastSpell('HK_SPELL3', target.Position, 0) 
                return
            end
        end
    end
end

function Tristana:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Tristana:AAReset()
        local heroList = ObjectManager.HeroList
        for i, target in pairs(heroList) do
            if target.Team ~= myHero.Team and string.len(target.ChampionName) > 1 then
                if self.champs["UseE" .. target.Index] == nil then
                    self.champs["UseE" .. target.Index] = self.ETargetsCombo:AddCheckbox("UseE on " .. target.ChampionName, 1)
                end
            end
        end
        if self.UseRKillsteal.Value == 1 then
            Tristana:ComboR()
        end
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseQCombo.Value == 1 then 
                Tristana:ComboQ()
            end
            if self.UseECombo.Value == 1 then 
                Tristana:ComboE()
            end
            if self.UseRCombo.Value == 1 then 
                Tristana:ComboR()
            end
        end
        
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then 
                Tristana:ComboQ()
            end
            if self.UseEHarass.Value == 1 then 
                Tristana:ComboE()
            end
        end
    
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                Tristana:LaneclearQ()
            end
            if self.UseELaneclear.Value == 1 then
                Tristana:LaneclearE()
            end
        end
    end
end

function Tristana:OnDraw()
    if myHero.IsDead == true then return end
end

function Tristana:OnLoad()
    if myHero.ChampionName ~= "Tristana" then return end
    AddEvent("OnSettingsSave" , function() Tristana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Tristana:LoadSettings() end)
    Tristana:__init()

    AddEvent("OnTick",function() Tristana:OnTick() end)
    AddEvent("OnDraw",function() Tristana:OnDraw() end)
end

AddEvent("OnLoad", function() Tristana:OnLoad() end)	