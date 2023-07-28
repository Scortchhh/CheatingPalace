Aatrox = {} 
function Aatrox:__init() 
    self.QRange = 625
    self.QRange2 = 475
    self.QRange3 = 200+180
    self.WRange = 765
    self.ERange = 350 
    self.RRange = 600

    self.QSpeed = math.huge 
    self.WSpeed = 1800
    self.ESpeed = 850

    self.QDelay = 0.6
    self.WDelay = 0.25
    self.EDelay = 0

    self.QWidth = 100
    self.WWidth = 160+55

    self.QHitChance = 0.0001
    self.WHitChance = 0.9

    self.QTimer = 0
    self.Angle  = 0
    self.ChampionMenu = Menu:CreateMenu("Aatrox") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on %HP in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)    
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Aatrox:LoadSettings()  
end 

function Aatrox:SaveSettings() 

    SettingsManager:CreateSettings("Aatrox")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Aatrox:LoadSettings()
    SettingsManager:GetSettingsFile("Aatrox")
     ------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")    
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function Aatrox:TargetIsImmune(Target)
    local IsImmune          = Orbwalker:TargetIsImmune(Target)
    local GwenCheck         = (Target.BuffData:GetBuff("gwenw_gweninsidew").Valid == false or Orbwalker:GetDistance(myHero.Position, Target.Position) <= 475)
    if IsImmune == false and GwenCheck then
        return false
    else
        return true
    end
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


function Aatrox:Ultimate(QName)
    if QName == "AatroxQ3" or QName == "AatroxQ2" then
        if self.RComboHP.Value == 1 and Engine:SpellReady('HK_SPELL4') then
            local IncomingAttack 	= self:IncomingAttack()
            local LowHP				= myHero.Health <= myHero.MaxHealth / 100 * self.RComboHPSlider.Value
            local Enemies = self:EnemiesInRange(myHero.Position, 575+300)
            if #Enemies > 0 then
                if LowHP or IncomingAttack == true then
                    return true
                end
                for _, Enemy in pairs(Enemies) do
                    local QDmg = GetDamage(-10 + 20 * myHero:GetSpellSlot(0).Level + (0.55 +  0.05 * myHero:GetSpellSlot(0).Level) * ((myHero.BaseAttack + myHero.BonusAttack) * (1.1 + 0.1 * myHero:GetSpellSlot(3).Level)), true, Enemy) * 1.6
                    local AADMG = GetDamage((myHero.BaseAttack + myHero.BonusAttack) * (1.1 + 0.1 * myHero:GetSpellSlot(3).Level), true, Enemy)
                    if Enemy.Health < QDmg * 1.5 + AADMG then
                        if QName == "AatroxQ3" then
                            return true
                        end
                    else
                        if Enemy.Health < QDmg * 2.75 + AADMG then
                            if QName == "AatroxQ2" then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function Aatrox:EnemiesInRange(Position, Range)
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

function Aatrox:IsAutoAttackMissile(Name, Target)
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

function Aatrox:IncomingAttack() 
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
                        local Health40 = myHero.MaxHealth * self.RComboHPSlider.Value / 100
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
                        local Health40 = myHero.MaxHealth * self.RComboHPSlider.Value / 100
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
            local Health40 = myHero.MaxHealth * self.RComboHPSlider.Value / 100
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
                        local Health40 = myHero.MaxHealth * self.RComboHPSlider.Value / 100
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

function Aatrox:CalcEVector(StartPos, EndPos, Range)
	local ToTargetVec = Vector3.new(EndPos.x - StartPos.x, EndPos.y - StartPos.y, EndPos.z - StartPos.z)

	local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
	local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
	
	return Vector3.new(StartPos.x + (VectorNorm.x*Range), StartPos.y , StartPos.z + (VectorNorm.z*Range))
end

function Aatrox:CalcECd()
    local ECD = 10 - myHero:GetSpellSlot(2).Level
    local Haste = myHero.AbilityHaste
    ECD = ECD * (100 / (100+Haste))
    return ECD
end

function Aatrox:GetEPosition(QName)
    local ActiveSpell = myHero.ActiveSpell.Info.Name
    local ETimer = GameClock.Time - self.QTimer 
    local QEndDelay = self.QDelay + 0.1 - ETimer
    if QEndDelay < 0.1 then
        QEndDelay = 0.1
    end
    --print(ActiveSpell)
    if ActiveSpell == "AatroxQWrapperCast" then
        local PredPos = nil
        local QPos = Aatrox:FindQ(QName)
        if QName == "AatroxQ2" then
            --print("ok?")
            PredPos, Hero = Prediction:GetCastPos(QPos, self.QRange + 300, self.QSpeed, self.QWidth, QEndDelay, 0, 0, 0.00001, 0)
            if PredPos then
                local Range = Orbwalker:GetDistance(myHero.Position, PredPos) - (self.QRange - 50)
                local FixedRange = Aatrox:QE_FixedRange(Hero, PredPos, 0.25)
                if Orbwalker:GetDistance(PredPos, QPos) > 100 and Orbwalker:GetDistance(PredPos, QPos) < 100 + FixedRange then
                    return self:CalcEVector(myHero.Position, PredPos, Range)
                end
            end
        end
        if QName == "AatroxQ3" then
            PredPos, Hero = Prediction:GetCastPos(QPos, 575 + 300, self.QSpeed, self.QWidth, QEndDelay, 0, 0, 0.00001, 0)
            if PredPos then
                local Range = Orbwalker:GetDistance(myHero.Position, PredPos) - (self.QRange2 - 50)
                local FixedRange = Aatrox:QE_FixedRange(Hero, PredPos, 0.15)
                if Orbwalker:GetDistance(PredPos, QPos) > 100 and Orbwalker:GetDistance(PredPos, QPos) < 100 + FixedRange then
                    return self:CalcEVector(myHero.Position, PredPos, Range)
                end
            end
        elseif QName == "AatroxQ" then
            PredPos = Prediction:GetCastPos(QPos, self.QRange3 + 300, self.QSpeed, self.QWidth, QEndDelay, 0, 0, 0.00001, 0)
            if PredPos then
                --print("E3")
                if Orbwalker:GetDistance(PredPos, QPos) > 100 and Orbwalker:GetDistance(PredPos, QPos) < 300+100 then
                    return PredPos
                end
            end
        end
    end
    return nil
end

function Aatrox:FixedPos(Position)
	local PlayerPos 	= Position
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -550
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Aatrox:QAngle(Position) --425 range >> 575
    local Modifier  = 450
    local Angle = 0
    local QPos = nil
    local TargetPos = myHero.Position
    local Dist = Orbwalker:GetDistance(TargetPos, Position)
    if Dist > 425 then
        Angle = Angle + 30
    end
    --[[if Dist > 440 then
        Angle = Angle + 3.3
    end
    if Dist > 455 then
        Angle = Angle + 3.3
    end
    if Dist > 470 then
        Angle = Angle + 3.3
    end
    if Dist > 485 then
        Angle = Angle + 3.3
    end
    if Dist > 500 then
        Angle = Angle + 3.3
    end
    if Dist > 515 then
        Angle = Angle + 3.3
    end
    if Dist > 530 then
        Angle = Angle + 3.3
    end
    if Dist > 545 then
        Angle = Angle + 3.3
    end
    if Dist > 560 then
        Angle = Angle + 3.3
    end]]
    local Norm = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Position, TargetPos))
    local Qx, Qy, Qz, a = Norm.x, Norm.y, Norm.z, Angle * math.pi / 180 --45 is angle
    local X = Qx * math.cos(a) - Qz * math.sin(a)
    local Y = Qy
    local Z = Qx * math.sin(a) + Qz * math.cos(a)
    QPos = Vector3.new(TargetPos.x + (X*Modifier),TargetPos.y ,TargetPos.z + (Z*Modifier))
    return QPos, Angle
end

function Aatrox:UseFlash()
    local Flash = {}
    Flash.Key, Number = Orbwalker:GetSummonerKey("SummonerFlash")	
    if Flash.Key ~= nil then
        local FlashCD = GameClock.Time >= myHero:GetSpellSlot(Number).Cooldown
        if FlashCD then
            return Flash
        end
    end
    return false
end

function Aatrox:FlashQ()
    local QName = myHero:GetSpellSlot(0).Info.Name
    local QPos = Aatrox:FindQ(QName)

    local ECD = GameClock.Time >= myHero:GetSpellSlot(2).Cooldown and myHero:GetSpellSlot(2).Level > 0
    local RCD = GameClock.Time >= myHero:GetSpellSlot(3).Cooldown and myHero:GetSpellSlot(3).Level > 0


    local Flash = Aatrox:UseFlash()
    local ActiveSpell = myHero.ActiveSpell.Info.Name
    local FlashTimer = GameClock.Time - self.QTimer
    local Enemies = self:EnemiesInRange(myHero.Position, 575+300)
    if #Enemies > 0 and Flash then
        for _, Enemy in pairs(Enemies) do
            if Aatrox:TargetIsImmune(Enemy) == false then
                local Dist2 = Orbwalker:GetDistance(Enemy.Position, myHero.Position)
                local QDmg = GetDamage(-10 + 20 * myHero:GetSpellSlot(0).Level + (0.55 +  0.05 * myHero:GetSpellSlot(0).Level) * (myHero.BaseAttack + myHero.BonusAttack), true, Enemy) * 1.6
                if Enemy.Health < QDmg * 1.5 then
                    --print("FLASHQ?")
                    if ActiveSpell == "AatroxQWrapperCast" and QName == "AatroxQ" then
                        local Dist = Orbwalker:GetDistance(Enemy.Position, QPos)
                        if Dist < 580 then
                           -- print(1)
                            if Dist > 160 then
                              --  print(2)
                                if FlashTimer > 0.45 then
                                    return Engine:ReleaseSpell(Flash.Key, Enemy.Position)
                                end
                            end
                        else
                            if ECD and Dist < 800 then
                                return Engine:ReleaseSpell("HK_SPELL3", Enemy.Position)
                            end
                        end
                    else
                        if QName == "AatroxQ3" and Engine:SpellReady("HK_SPELL1") then
                           -- print("USEQ")
                            local MaxRange = 780
                            if ECD then
                                MaxRange = MaxRange + 300
                            end
                            if Dist2 < MaxRange then
                                self.QTimer = GameClock.Time
                                return Engine:CastSpell("HK_SPELL1", Enemy.Position)
                            end
                        end
                    end
                else
                    if RCD then
                        QDmg = GetDamage(-10 + 20 * myHero:GetSpellSlot(0).Level + (0.55 +  0.05 * myHero:GetSpellSlot(0).Level) * ((myHero.BaseAttack + myHero.BonusAttack) * (1.1 + 0.1 * myHero:GetSpellSlot(3).Level)), true, Enemy) * 1.6
                        if Enemy.Health < QDmg * 1.5 then
                            local MaxRange = 1100
                            if ECD then
                                MaxRange = MaxRange + 300
                            end
                            if Dist2 < MaxRange then
                                return Engine:CastSpell("HK_SPELL4", nil, 0)
                            end
                        end
                    end
                end
            end
        end
    end
end

function Aatrox:FindQ(QName)
    local ActiveSpell = myHero.ActiveSpell.Info.Name
    local QPos = nil
    local TargetPos = myHero.Position
    if ActiveSpell == "AatroxQWrapperCast" then
        if QName == "AatroxQ2" then
            --print("ok?")
            local Modifier  = 625-75
            QPos            = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier))
        elseif QName == "AatroxQ3" then
            local Modifier  = 450
            local Angle = 0
            if self.Angle > 0 then
                Modifier = 450
                Angle = 360 - self.Angle - 5
            end
            local Qx, Qy, Qz, a = myHero.Direction.x, myHero.Direction.y, myHero.Direction.z, Angle * math.pi / 180 --45 is angle
            --print(angle)
            local X = Qx * math.cos(a) - Qz * math.sin(a)
            local Y = Qy
            local Z = Qx * math.sin(a) + Qz * math.cos(a)
            QPos = Vector3.new(TargetPos.x + (X*Modifier),TargetPos.y ,TargetPos.z + (Z*Modifier))
            --QPos = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier))
        elseif QName == "AatroxQ" then
            local Modifier  = 200
            QPos            = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier))
        end
    end
    if QPos then
        --print(Wut)
        Render:DrawCircle(QPos, 100, 255, 0, 0, 225)
        return QPos
    else
        return nil
    end
end

function Aatrox:AAReset()
	--print(myHero.ActiveSpell.Info.Name)
	local Action 			= myHero.ActiveSpell.Info.Name
	local Name 				= "Attack"
	local AutoAction		= string.find(Action, Name) ~= nil
    if AutoAction then
        return true
    end
    return false
end

function Aatrox:GetDamageBeforePlayer(Minion)
	local MinionList    = ObjectManager.MinionList
	local HeroList      = ObjectManager.HeroList
	local TurretList    = ObjectManager.TurretList
	local Missiles      = ObjectManager.MissileList
	local PlayerMissileSpeed = myHero.AttackInfo.Data.MissileSpeed

	local PlayerAttackTime = 0.6

	local Damage            = 0
	local HeroDamage        = 0
	local IncomingMissiles  = {}
	for _, Missile in pairs(Missiles) do
		local Team = Missile.Team
		if Team == 100 or Team == 200 then
			local TargetID = Missile.TargetIndex
			if Team ~= Minion.Team and TargetID == Minion.Index then
				local SourceID  = Missile.SourceIndex
				if MinionList[SourceID] then
					local TimeTillMissileDamage = Prediction:GetDistance(Missile.Position, Minion.Position)/650
					if TimeTillMissileDamage < PlayerAttackTime then                       
						local Source    = MinionList[SourceID]
						local AD        = Source.BaseAttack + Source.BonusAttack
						local Armor     = Minion.Armor
						Damage = Damage + (AD * (100/(100+Armor)))
						IncomingMissiles[#IncomingMissiles+1] = Missile
					end
				end
				if HeroList[SourceID] then
					local TimeTillMissileDamage = Prediction:GetDistance(Missile.Position, Minion.Position)/650
					if TimeTillMissileDamage < PlayerAttackTime then                       
						local Source    = HeroList[SourceID]
						local AD        = Source.BaseAttack + Source.BonusAttack
						local Armor     = Minion.Armor
						Damage = Damage + (AD * (100/(100+Armor)))
						HeroDamage = HeroDamage + (AD * (100/(100+Armor)))
						IncomingMissiles[#IncomingMissiles+1] = Missile
					end
				end
			end
		end
	end
	return Damage, HeroDamage, IncomingMissiles
end

function Aatrox:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") then
        local MinionList 	= ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false and Minion.Team ~= 300 then
                local QName = myHero:GetSpellSlot(0).Info.Name
                local PredPos = nil
                local QDmg = 0
                ObrTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
                if ObrTarget == nil then
                    if QName == "AatroxQ" then
                        local PredPos2 =  Prediction:GetPredictionPosition(Minion, myHero.Position, self.QSpeed, self.QDelay, 100, 0, 0, 0.001, 0)
                        if PredPos2 then
                            if Orbwalker:GetDistance(PredPos2, myHero.Position) > self.QRange - 180 and Orbwalker:GetDistance(PredPos2, myHero.Position) < self.QRange - 25 then
                                QDmg = GetDamage(-10 + 20 * myHero:GetSpellSlot(0).Level + (0.55 +  0.05 * myHero:GetSpellSlot(0).Level) * (myHero.BaseAttack + myHero.BonusAttack), true, Minion) * 0.55 * 1.6
                                PredPos = PredPos2
                            end
                        end
                    elseif QName == "AatroxQ2" then
                        local PredPos2 =  Prediction:GetPredictionPosition(Minion, myHero.Position, self.QSpeed, self.QDelay, 100, 0, 0, 0.001, 0)
                        if PredPos2 then
                            if Orbwalker:GetDistance(PredPos2, myHero.Position) > self.QRange2 - 180 and Orbwalker:GetDistance(PredPos2, myHero.Position) < self.QRange2 - 25 then
                                QDmg = GetDamage(-10 + 20 * myHero:GetSpellSlot(0).Level + (0.55 +  0.05 * myHero:GetSpellSlot(0).Level) * (myHero.BaseAttack + myHero.BonusAttack), true, Minion) * 1.25 * 0.55 * 1.6
                                PredPos = PredPos2
                            end
                        end
                    end
                end
                local IncomingDamage, HeroDamage, IncomingMissiles  = self:GetDamageBeforePlayer(Minion)
                IncomingDamage                                      = math.floor(IncomingDamage)

                if PredPos and Minion.Health < (QDmg + IncomingDamage) then
                    self.QTimer = GameClock.Time
                    return Engine:CastSpell("HK_SPELL1", PredPos, 0)
                end
            end
        end
    end
end

function Aatrox:QE_FixedRange(Hero, PredPos2, Mult)
    local Multplier = Mult
    local isImmobile = Prediction:IsImmobile(Hero)
    local isAttacking = Prediction:IsAttacking(Hero, 0)
    local isAAing     = Prediction:UsingAA(Hero)
    if isImmobile then
        Multplier = Multplier - isImmobile
    end
    if isAttacking then
        Multplier = Multplier - isAttacking
    end
    if isAAing then
        Multplier = Multplier - isAAing
    end
    if Orbwalker:GetDistance(Hero.Position, myHero.Position) > Orbwalker:GetDistance(PredPos2, myHero.Position) and Prediction.ActionTimer[Hero.Index] ~= nil then
        local LastAction = GameClock.Time - Prediction.ActionTimer[Hero.Index]
        local Time2React = 0.3
        local TimeLeft = Time2React - LastAction
        if TimeLeft > 0 then
            Multplier = Multplier - TimeLeft
        end
    end
    if Multplier <= 0 then
        Multplier = 0
    end
    local FixedRange = 300 - Hero.MovementSpeed * Multplier
    return FixedRange
end

function Aatrox:Combo()
    local ECD = Aatrox:CalcECd()
    local QName = myHero:GetSpellSlot(0).Info.Name
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if Engine:SpellReady("HK_SPELL3") == false or QName ~= "AatroxQ" then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, 1, 0.85, 1)
            if PredPos and Orbwalker:GetDistance(PredPos, myHero.Position) < self.WRange then
                return Engine:CastSpell("HK_SPELL2", PredPos, 0)
            end
        end
    end
    --print(QName)
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = nil
        local AAReset = Aatrox:AAReset()
        ObrTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
        if ObrTarget and QName ~= "AatroxQ3" then
            --print(1)
            if AAReset then
                --print(QName)
                if QName == "AatroxQ" then
                    --print(2)
                    PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                elseif QName == "AatroxQ2" then
                    PredPos = Prediction:GetCastPos(myHero.Position, self.QRange2, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                end
            end
        else
            if QName == "AatroxQ" then
                if Engine:SpellReady("HK_SPELL3") and ECD and ECD < 4 and Engine:SpellReady("HK_SPELL2") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange + 300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > self.QRange2 - 180 and PredDist < self.QRange + FixRange then
                            PredPos = PredPos2
                        end
                    end
                else
                    local PredPos2, Hero =  Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > self.QRange - 180 and PredDist < self.QRange then
                            PredPos = PredPos2
                        end
                    end
                end
            elseif QName == "AatroxQ2" then
                if Engine:SpellReady("HK_SPELL3") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, 575+300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        local HeroDist = Orbwalker:GetDistance(Hero.Position, myHero.Position)
                        if HeroDist < 550 + FixRange then
                            PredPos, self.Angle = Aatrox:QAngle(PredPos2)
                        end
                    end
                else
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, 575, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > 325 and PredDist < 550 then
                            PredPos, self.Angle = Aatrox:QAngle(PredPos2)
                        end
                    end
                end
            elseif QName == "AatroxQ3" then
                if Engine:SpellReady("HK_SPELL3") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange3+300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local HeroDist = Orbwalker:GetDistance(Hero.Position, myHero.Position)
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        if HeroDist < self.QRange3 + FixRange then
                            PredPos = PredPos2
                        end
                    end
                else
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange3, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist < self.QRange3 - 25 then
                            PredPos = PredPos2
                        end
                    end
                end
            end
        end
        if PredPos then
            if Aatrox:Ultimate(QName) == true then
                Engine:ReleaseSpell("HK_SPELL4", nil)
            end
            self.QTimer = GameClock.Time
            return Engine:CastSpell("HK_SPELL1", PredPos, 0)
        end
    end 

    local ETimer = GameClock.Time - self.QTimer 
    --print(ETimer)
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") and ETimer > 0.25 then
        if QName ~= "AatroxQ2" or ECD < 4 then
            local PredPos = self:GetEPosition(QName)
            if PredPos then
                return Engine:ReleaseSpell("HK_SPELL3", PredPos)
            end
        end
    end
end

function Aatrox:Harass()
    local ECD = Aatrox:CalcECd()
    local QName = myHero:GetSpellSlot(0).Info.Name
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if Engine:SpellReady("HK_SPELL3") == false or QName ~= "AatroxQ" then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, 1, 0.95, 1)
            if PredPos and Orbwalker:GetDistance(PredPos, myHero.Position) < self.WRange then
                return Engine:CastSpell("HK_SPELL2", PredPos, 0)
            end
        end
    end
    local AAReset = Aatrox:AAReset()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = nil
        ObrTarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
        if ObrTarget and QName ~= "AatroxQ3" then
            if AAReset then
                if QName == "AatroxQ" then
                    PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                elseif QName == "AatroxQ2" then
                    PredPos = Prediction:GetCastPos(myHero.Position, self.QRange2, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                end
            end
        else
            if QName == "AatroxQ" then
                if Engine:SpellReady("HK_SPELL3") and ECD and ECD < 4 and Engine:SpellReady("HK_SPELL2") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange + 300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, 0.25, 0)
                    if PredPos2 then
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > self.QRange2 - 180 and PredDist < self.QRange + FixRange then
                            PredPos = PredPos2
                        end
                    end
                else
                    local PredPos2, Hero =  Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, 0.25, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > self.QRange - 180 and PredDist < self.QRange then
                            PredPos = PredPos2
                        end
                    end
                end
            elseif QName == "AatroxQ2" then
                if Engine:SpellReady("HK_SPELL3") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, 575+300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, 0.2, 0)
                    if PredPos2 then
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        local HeroDist = Orbwalker:GetDistance(Hero.Position, myHero.Position)
                        if HeroDist < 550 + FixRange then
                            PredPos, self.Angle = Aatrox:QAngle(PredPos2)
                        end
                    end
                else
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, 575, self.QSpeed, self.QWidth, self.QDelay, 0, 0, 0.2, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist > 325 and PredDist < 550 then
                            PredPos, self.Angle = Aatrox:QAngle(PredPos2)
                        end
                    end
                end
            elseif QName == "AatroxQ3" then
                if Engine:SpellReady("HK_SPELL3") then
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange3+300, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local HeroDist = Orbwalker:GetDistance(Hero.Position, myHero.Position)
                        local FixRange = Aatrox:QE_FixedRange(Hero, PredPos2, 0.6)
                        if HeroDist < self.QRange3 + FixRange then
                            PredPos = PredPos2
                        end
                    end
                else
                    local PredPos2, Hero = Prediction:GetCastPos(myHero.Position, self.QRange3, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 0)
                    if PredPos2 then
                        local PredDist = Orbwalker:GetDistance(PredPos2, myHero.Position)
                        if PredDist < self.QRange3 - 25 then
                            PredPos = PredPos2
                        end
                    end
                end
            end
        end
        if PredPos then
            self.QTimer = GameClock.Time
            return Engine:CastSpell("HK_SPELL1", PredPos, 0)
        end
    end 

    local ETimer = GameClock.Time - self.QTimer 
    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") and ETimer > 0.25 then
        if QName ~= "AatroxQ2" or ECD < 4 then
            local PredPos = self:GetEPosition(QName)
            if PredPos then
                return Engine:ReleaseSpell("HK_SPELL3", PredPos)
            end
        end
    end
end

function Aatrox:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        local QName = myHero:GetSpellSlot(0).Info.Name
        --Aatrox:CalcECd()
        Aatrox:FindQ(QName)
        Aatrox:Ultimate()
        if Engine:IsKeyDown("HK_COMBO") then
            Aatrox:FlashQ()
            Aatrox:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Aatrox:FlashQ()
            Aatrox:LastHitQ()
            Aatrox:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") or Engine:IsKeyDown("HK_LANECLEAR") then
            Aatrox:LastHitQ()
        end
	end
end

function Aatrox:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if myHero.BuffData:GetBuff("AatroxQ2").Valid then
            Render:DrawCircle(myHero.Position, self.QRange2+100 ,100,150,255,255)
            else        
                if myHero.BuffData:GetBuff("AatroxQ3").Valid then
                Render:DrawCircle(myHero.Position, self.QRange3 ,100,150,255,255)
            else
                
                Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
            end
        end
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Aatrox:OnLoad()
    if(myHero.ChampionName ~= "Aatrox") then return end
	AddEvent("OnSettingsSave" , function() Aatrox:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Aatrox:LoadSettings() end)


	Aatrox:__init()
	AddEvent("OnTick", function() Aatrox:OnTick() end)	
    AddEvent("OnDraw", function() Aatrox:OnDraw() end)
end

AddEvent("OnLoad", function() Aatrox:OnLoad() end)	
