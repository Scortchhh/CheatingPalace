Karthus = {
    Init = function(self) 

        self.KeyNames = {}
        self.KeyNames[4] 		= "HK_SUMMONER1"
        self.KeyNames[5] 		= "HK_SUMMONER2"
        
        self.KeyNames[6] 		= "HK_ITEM1"
        self.KeyNames[7] 		= "HK_ITEM2"
        self.KeyNames[8] 		= "HK_ITEM3"
        self.KeyNames[9] 		= "HK_ITEM4"
        self.KeyNames[10] 		= "HK_ITEM5"
        self.KeyNames[11]		= "HK_ITEM6"

        self.QRange = 875
        self.WRange = 1000
        self.ERange = 550

        self.QSpeed = math.huge
        self.ESpeed = math.huge
        self.WSpeed = math.huge

        self.QWidth = 160
        self.WWidth = 150

        self.QDelay = 0.75
        self.EDelay = 0.00
        self.WDelay = 0.25

        self.QHitChance = 0.2
        self.WHitChance = 0.2

        --------------ITEMS---------------
        self.Luden      = false
        self.Liandry    = false
        ----------------------------------

        self.HealthBarDraws		= 0
   
        self.ChampionMenu = Menu:CreateMenu("Karthus")
        -------------------------------------------
        self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Q Settings")
        self.QHitChance     = self.ComboMenu:AddSlider("HitChance for Q: ", 35, 0, 99, 1)
        self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ on Combo", 1)
        self.ClearUseQ 		= self.ComboMenu:AddCheckbox("UseQ on Clear", 1)
        self.LaneClearQMana = self.ComboMenu:AddSlider("Minimum % mana to use Q", 25,1,100,1)
        self.StartBonusDmg  = self.ComboMenu:AddCheckbox("+5dmg Starting Item in Clear", 1)
        -------------------------------------------
        self.WSettings		= self.ChampionMenu:AddSubMenu("W Settings")
        self.ComboUseW	    = self.WSettings:AddCheckbox("UseW on Combo", 1)
        -------------------------------------------
        self.ESettings		= self.ChampionMenu:AddSubMenu("E Settings")
        self.ComboUseE	    = self.ESettings:AddCheckbox("UseE on Combo", 1)
        self.ClearUseE	    = self.ESettings:AddCheckbox("UseE on Clear", 1)
        self.LaneClearEMana = self.ESettings:AddSlider("Minimum % mana to use E", 25,1,100,1)
        -------------------------------------------
        self.RDmgCalc		= self.ChampionMenu:AddSubMenu("RDmgCalcs")
        self.Coup           = self.RDmgCalc:AddCheckbox("TickON == Coup, TickOFF == Last Stand", 1)

        -------------------------------------------
        self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
        self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
        self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
        self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
        self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1) --KillTextXAxis
        self.HealthBarXAxis = self.DrawMenu:AddSlider("KillBar X Axis", 100,100,4000,1)
        self.HealthBarYAxis = self.DrawMenu:AddSlider("KillBar Y Axis", 100,100,4000,1)
        self.KillTextXAxis  = self.DrawMenu:AddSlider("KillText X Axis", 100,100,4000,1)
        self.KillTextYAxis  = self.DrawMenu:AddSlider("KillText Y Axis", 100,100,4000,1)

        self:LoadSettings() 
    end,
    LoadSettings = function(self) 
    	SettingsManager:GetSettingsFile("Karthus")
        self.QHitChance.Value 		= SettingsManager:GetSettingsInt("QSettings","QHitChance")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.ClearUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQClear")
        self.LaneClearQMana.Value   = SettingsManager:GetSettingsInt("QSettings","LaneClearQMana")
        self.StartBonusDmg.Value    = SettingsManager:GetSettingsInt("QSettings","StartBonusDmg")
        -------------------------------------------------------------
        self.ComboUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWCombo")
        -------------------------------------------------------------
        self.ComboUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseECombo")
        self.ClearUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseEClear")
        self.LaneClearEMana.Value   = SettingsManager:GetSettingsInt("ESettings","LaneClearEMana")
        -------------------------------------------------------------
        self.Coup.Value		        = SettingsManager:GetSettingsInt("RDmgCalc","Coup2")
        -------------------------------------------------------------
        self.HealthBarXAxis.Value		= SettingsManager:GetSettingsInt("DrawSettings","HealthBarXAxis")
        self.HealthBarYAxis.Value		= SettingsManager:GetSettingsInt("DrawSettings","HealthBarYAxis")

        self.KillTextXAxis.Value		= SettingsManager:GetSettingsInt("DrawSettings","KillTextXAxis")
        self.KillTextYAxis.Value		= SettingsManager:GetSettingsInt("DrawSettings","KillTextYAxis")
        -------------------------------------------------------------
    end,
    SaveSettings = function(self)
    	SettingsManager:CreateSettings("Karthus")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("QHitChance", self.QHitChance.Value)
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQClear", self.ClearUseQ.Value)
        SettingsManager:AddSettingsInt("LaneClearQMana", self.LaneClearQMana.Value)
        SettingsManager:AddSettingsInt("StartBonusDmg", self.StartBonusDmg.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("WSettings")
        SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("ESettings")
        SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
        SettingsManager:AddSettingsInt("UseEClear", self.ClearUseE.Value)
        SettingsManager:AddSettingsInt("LaneClearEMana", self.LaneClearEMana.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("RDmgCalc")
        SettingsManager:AddSettingsInt("Coup2", self.Coup.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("DrawSettings")
        SettingsManager:AddSettingsInt("HealthBarXAxis", self.HealthBarXAxis.Value)
        SettingsManager:AddSettingsInt("HealthBarYAxis", self.HealthBarYAxis.Value)

        SettingsManager:AddSettingsInt("KillTextXAxis", self.KillTextXAxis.Value)
        SettingsManager:AddSettingsInt("KillTextYAxis", self.KillTextYAxis.Value)
        ------------------------------------------------------------
    end,
    CustomQPrediction = function(self, CastPos, Bound)
        local Direction     = Prediction:GetVectorDirection(myHero.Position, CastPos)
        local Normalized    = Prediction:GetVectorNormalized(Direction)
        return Vector3.new(CastPos.x + Normalized.x * Bound,CastPos.y,CastPos.z + Normalized.z * Bound)
    end,
    ItemCalculator = function(self)
        local LudensBuff = myHero.BuffData:GetBuff("6655buff")
        local LudensBuff_Valid = LudensBuff.Valid or LudensBuff.Count_Alt > 0

        if self.Luden == false and LudensBuff_Valid then
            self.Luden = true
            self.Liandry = false
        end

        local myLevel = self:GetHeroLevel(myHero)
        local ExtraMana = myHero.MaxMana - (440.04 + (21.96 * myLevel))

        if self.Liandry == false and self.Luden == false and myHero.AbilityPower >= 98 and myHero.AbilityHaste >= 20 and ExtraMana >= 500 then
            local Heros = ObjectManager.HeroList
            for I, Hero in pairs(Heros) do
                if Hero.IsDead == false and Hero.Team ~= myHero.Team and Hero.IsTargetable then
                    local LiandryBuff = Hero.BuffData:GetBuff("6653burn")
                    local LiandryBuff_Valid = LiandryBuff.Valid or LiandryBuff.Count_Alt > 0
                    if LiandryBuff_Valid then
                        self.Liandry = true
                    end
                end
            end
        end
    end,
    Combo = function(self)
        local SpellName = myHero.ActiveSpell.Info.Name
        local QCharges = myHero:GetSpellSlot(0).Charges
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange + self.QWidth, self.QSpeed, self.QWidth * 1.3, self.QDelay, 0, 0, self.QHitChance.Value, 0)
        if PredPos then
            local Distance      = Prediction:GetDistance(PredPos, myHero.Position)
            local Difference    = Distance - self.QRange
            if Difference > 0 then
                PredPos = self:CustomQPrediction(PredPos, Difference) 
            end
        end
        local DeadBuff = myHero.BuffData:GetBuff("karthusdeathdefiedrtimer").Valid
        if DeadBuff then
            if Engine:SpellReady("HK_SPELL1") then
                if PredPos then
                    return Engine:ReleaseSpell("HK_SPELL1", PredPos)
                end
            end
        else
            if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 and Orbwalker.Attack == 0 and PredPos and QCharges == 2 and SpellName ~= "KarthusLayWasteA1" then
                Orbwalker.Windup = 1
                return Engine:ReleaseSpell("HK_SPELL1", PredPos)
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            local WPredPos, WTarget = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth * 1.3, self.WDelay, 0, 0, 0.1, 1)
            if WPredPos and WTarget then
                return Engine:ReleaseSpell("HK_SPELL2", WPredPos)
            end
        end
             
        local EBuff     = myHero.BuffData:GetBuff("KarthusDefile")
        local ETarget   = Orbwalker:GetTarget("COMBO", self.ERange)
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 and myHero.IsDead == false and myHero.Mana > 150 then
            if ETarget and EBuff.Count_Alt == 0 then
                return Engine:ReleaseSpell("HK_SPELL3", nil)
            end
            if (ETarget == nil or myHero.Mana < 150) and EBuff.Count_Alt ~= 0 then
                return Engine:ReleaseSpell("HK_SPELL3", nil)
            end
        end
    end,
    GetDamageBeforePlayer = function(self, Minion)
        local MinionList    = ObjectManager.MinionList
        local HeroList      = ObjectManager.HeroList
        local TurretList    = ObjectManager.TurretList
        local Missiles      = ObjectManager.MissileList
        local PlayerMissileSpeed = myHero.AttackInfo.Data.MissileSpeed

        local PlayerAttackTime = 0.75

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
    end,
    LastHit = function(self)
        local SpellName = myHero.ActiveSpell.Info.Name
        local QCharges = myHero:GetSpellSlot(0).Charges
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if self.ClearUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and target then
            local QDmg = self:GetMagicDamage(27.5 + (17.5 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.35, target)
            local AADmg = myHero.BonusAttack + myHero.BaseAttack
            if target.IsMinion and target.MaxHealth > 90 then
                local CastPos, _    = Prediction:GetPredictionPosition(target, myHero.Position, self.QSpeed, self.QDelay, self.QWidth * 1.3, 0, 0, 0.01, 0)
                --print(target.ChampionName) --SRU_ChaosMinionRanged -- SRU_ChaosMinionSiege -- SRU_ChaosMinionMelee
                if target.ChampionName == "SRU_ChaosMinionRanged" or target.ChampionName == "SRU_OrderMinionRanged" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 550+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 

                if target.ChampionName == "SRU_ChaosMinionSiege" or target.ChampionName == "SRU_OrderMinionSiege" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 300+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 

                if target.ChampionName == "SRU_ChaosMinionMelee" or target.ChampionName == "SRU_OrderMinionMelee" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 110+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 
                local Distance      = Prediction:GetDistance(target.Position, myHero.Position)
                local Difference    = Distance - self.QRange
                if Difference > 0 and CastPos then
                    CastPos = self:CustomQPrediction(CastPos, Difference)    
                else
                    if CastPos then
                        CastPos = self:CustomQPrediction(CastPos, 50)    
                    end
                end
                if CastPos and Prediction:GetDistance(CastPos, myHero.Position) < (self.QRange + self.QWidth) and QCharges == 2 and SpellName ~= "KarthusLayWasteA1" then
                    local EnemyMinions = Orbwalker:GetEnemyMinionsInRange(CastPos, 160)
                    if #EnemyMinions == 1 then
                        QDmg = QDmg * 2
                    end
                    if target.Team == 100 or target.Team == 200 then
                        local IncomingDamage, HeroDamage, IncomingMissiles  = self:GetDamageBeforePlayer(target)
                        IncomingDamage                                      = math.floor(IncomingDamage)
                        --print(IncomingDamage)
                        if target.Health <= (QDmg + IncomingDamage) and target.Health > HeroDamage then
                            return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                        end
                    end
                end
            end
        end
    end,
    FixedClearPrediction = function(self, Target)
        local PlayerPos 	= myHero.Position
        local TargetPos 	= Target
        local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
        local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
        local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
        
        local i 			= -105
        local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
        return EndPos
    end,
    OnlyQKillTarget = function(self, Target)
        --local Qs2Kill = 1
        local QDmg = self:GetMagicDamage(27.5 + (17.5 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.35, Target) * 2
        local QMana = 15 + 5 * myHero:GetSpellSlot(0).Level
        local EMana = 70
        local WMana = 28 + 4 * myHero:GetSpellSlot(0).Level
        for Qs2Kill = 1, 10, 1 do
            if Target.Health < QDmg * Qs2Kill then
                return Qs2Kill * QMana + EMana + WMana
            end
        end
        return nil
    end,
    Clear = function(self) 
        local SpellName = myHero.ActiveSpell.Info.Name
        local QCharges  = myHero:GetSpellSlot(0).Charges
        local target    = Orbwalker:GetTarget("Laneclear", self.QRange)

        local QManaSlider   = self.LaneClearQMana.Value
        local QMana         = myHero.MaxMana / 100 * QManaSlider

        local EManaSlider   = self.LaneClearEMana.Value
        local EMana         = myHero.MaxMana / 100 * EManaSlider
        local SaveManaCombo = 0
        local HeroTarget = Orbwalker:GetTarget("Combo", 2000)
        if HeroTarget then
            SaveManCombo = self:OnlyQKillTarget(HeroTarget)
        end
        if self.ClearUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and target then
            --print(target.CharData.BoundingRadius)
            local QDmg = self:GetMagicDamage(27.5 + (17.5 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.35, target)
            local AADmg = myHero.BonusAttack + myHero.BaseAttack
            if target.IsMinion and target.MaxHealth > 90 then
                local CastPos, _    = Prediction:GetPredictionPosition(target, myHero.Position, self.QSpeed, self.QDelay, self.QWidth * 1.3, 0, 0, 0.01, 0)
                --print(target.ChampionName) --SRU_ChaosMinionRanged -- SRU_ChaosMinionSiege -- SRU_ChaosMinionMelee
                if target.ChampionName == "SRU_ChaosMinionRanged" or target.ChampionName == "SRU_OrderMinionRanged" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 550+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 

                if target.ChampionName == "SRU_ChaosMinionSiege" or target.ChampionName == "SRU_OrderMinionSiege" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 300+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 

                if target.ChampionName == "SRU_ChaosMinionMelee" or target.ChampionName == "SRU_OrderMinionMelee" then
                    local AllyMinionsIntoRanged = Orbwalker:GetAllyMinionsInRange(target.Position, 110+55+20+160)
                    if #AllyMinionsIntoRanged > 0 then
                        CastPos = target.Position
                    end
                end 

                local Distance      = Prediction:GetDistance(target.Position, myHero.Position)
                local Difference    = Distance - self.QRange
                if Difference > 0 and CastPos then
                    CastPos = self:CustomQPrediction(CastPos, Difference)    
                else
                    if CastPos then
                        CastPos = self:CustomQPrediction(CastPos, 50)    
                    end
                end
                if target.AIData.Moving == false then
                    CastPos = self:FixedClearPrediction(target.Position)
                end
                if CastPos and Prediction:GetDistance(CastPos, myHero.Position) < (self.QRange + self.QWidth) and QCharges == 2 and SpellName ~= "KarthusLayWasteA1" then
                    if Orbwalker.Attack == 0 or ((os.clock() - Orbwalker.LastMoveTime) > Orbwalker.LastMissileTime * 0.775 and (os.clock() - Orbwalker.LastMoveTime) < Orbwalker.LastMissileTime + 0.3) then
                        local EnemyMinions = Orbwalker:GetEnemyMinionsInRange(CastPos, 160)
                        if #EnemyMinions == 1 then
                            QDmg = QDmg * 2
                        end
                        if target.Team == 100 or target.Team == 200 then
                            Orbwalker.DontAA = 0
                            local IncomingDamage, HeroDamage, IncomingMissiles  = self:GetDamageBeforePlayer(target)
                            IncomingDamage                                      = math.floor(IncomingDamage)
                            if Prediction:GetDistance(myHero.Position, target.Position) <= 450 + myHero.CharData.BoundingRadius - 15 then
                                if target.Health > (IncomingDamage * 1.5 + (AADmg + QDmg) * 1.5) and myHero.Mana >= QMana and myHero.Mana >= SaveManCombo then
                                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                                end
                            else
                                if target.Health >= IncomingDamage * 2 + (QDmg * 2.15) and myHero.Mana >= QMana and myHero.Mana >= SaveManCombo then
                                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                                end
                            end
                            if target.Health <= (QDmg + IncomingDamage) and target.Health > HeroDamage then
                                return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                            end
                            local AllyMinions = Orbwalker:GetAllyMinionsInRange(CastPos, 200)
                            if #AllyMinions == 0 and myHero.Mana >= QMana and myHero.Mana >= SaveManCombo then
                                return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                            end
                        end
                        if target.Team == 300 then
                            --target.BuffData:ShowAllBuffs()
                            local MinionAggro   = math.floor(target.Mana / 25)
                            local KnifeDMg      = self:GetMagicDamage((60 + myHero.AbilityPower * 0.3) / 5, target)
                            local ExtraTick     = 0
                            if target.Mana == 100 then
                                ExtraTick = 1
                            end
                            --print(((QDmg * 0.95)+KnifeDMg) * MinionAggro)
                            if Prediction:GetDistance(target.Position, myHero.Position) <= 450 + 75 and target.Health > ((QDmg * 0.95)+KnifeDMg) * (MinionAggro + ExtraTick) then
                                --print(1)
                                Orbwalker.DontAA = 0
                                if ((os.clock() - Orbwalker.LastMoveTime) > Orbwalker.LastMissileTime * 0.775 and (os.clock() - Orbwalker.LastMoveTime) < Orbwalker.LastMissileTime + 0.3) then
                                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                                end
                            else
                                if target.Health > MinionAggro * KnifeDMg then
                                    Orbwalker.DontAA = 1
                                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                                end
                            end
                        else
                            Orbwalker.DontAA = 0
                        end
                    end
                end
            end
        end

        local EBuff     = myHero.BuffData:GetBuff("KarthusDefile")
        local ETarget   = Orbwalker:GetTarget("LANECLEAR", self.ERange)
        if Engine:SpellReady("HK_SPELL3") and self.ClearUseE.Value == 1 and myHero.IsDead == false then
            if ETarget and EBuff.Count_Alt == 0 and ETarget.IsMinion and ETarget.MaxHealth > 90 then
                local EDmg = self:GetMagicDamage(2.5 + (5 * myHero:GetSpellSlot(0).Level) + myHero.AbilityPower * 0.05, ETarget)
                if myHero.Mana > 150 and myHero.Mana >= EMana and myHero.Mana >= SaveManCombo then
                    return Engine:ReleaseSpell("HK_SPELL3", nil)
                end
                if ETarget.Health <= EDmg then
                    return Engine:ReleaseSpell("HK_SPELL3", nil)
                end
            end
            if (ETarget == nil or myHero.Mana < 150 or myHero.Mana <= EMana or myHero.Mana >= SaveManCombo) and EBuff.Count_Alt ~= 0 then
                return Engine:ReleaseSpell("HK_SPELL3", nil)
            end
        end   
    end,
    GetMagicDamage = function(self, rawDmg, target)
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end,
    GetHeroLevel = function(self, Target)
        local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
        return totalLevel
    end, 
    LiandryBonusDmg = function(self, Target)
        local Multiplier = 1
        local TargetBonusHP = Target.MaxHealth - (525 + self:GetHeroLevel(Target) * 115)
        if TargetBonusHP >= 125 and TargetBonusHP < 250 then
            Multiplier = 1.012
        end
        if TargetBonusHP >= 250 and TargetBonusHP < 375 then
            Multiplier = 1.024
        end
        if TargetBonusHP >= 375 and TargetBonusHP < 500 then
            Multiplier = 1.036
        end
        if TargetBonusHP >= 500 and TargetBonusHP < 625 then
            Multiplier = 1.048
        end
        if TargetBonusHP >= 625 and TargetBonusHP < 750 then
            Multiplier = 1.06
        end
        if TargetBonusHP >= 750 and TargetBonusHP < 875 then
            Multiplier = 1.072
        end
        if TargetBonusHP >= 875 and TargetBonusHP < 1000 then
            Multiplier = 1.084
        end
        if TargetBonusHP >= 1000 and TargetBonusHP < 1125 then
            Multiplier = 1.108
        end
        if TargetBonusHP >= 1250 then
            Multiplier = 1.12
        end
        return Multiplier
    end,
    GetItemKey = function(self, ItemName, Target)
        for i = 6 , 11 do
            local Slot = Target:GetSpellSlot(i)
            if Slot.Info.Name == ItemName then
                return self.KeyNames[i] , Slot.Charges 
            end
        end
        return nil
    end,
    HPotions_Check = function(self, Target)
        local Potions			= {}
                Potions.Key, Potions.Charges	= self:GetItemKey("Item2003", Target) -- HealthPotion	
        if Potions.Key ~= nil or (Target.BuffData:GetBuff("Item2003").Count_Alt > 0) then
            return Potions
        end
        return false
    end,
    RePotions_Check = function(self, Target)
        local Potions			= {}
                Potions.Key, Potions.Charges	= self:GetItemKey("ItemCrystalFlask", Target) -- Refill Potion	
                --print(Potions.Charges)
        if Potions.Key ~= nil or (Target.BuffData:GetBuff("ItemCrystalFlask").Count_Alt > 0) then
            return Potions
        end
        return false
    end,
    CorrPotions_Check = function(self, Target)
        local Potions			= {}
                Potions.Key, Potions.Charges	= self:GetItemKey("ItemDarkCrystalFlask", Target) -- Corrupt Potion	
        if Potions.Key ~= nil or (Target.BuffData:GetBuff("ItemDarkCrystalFlask").Count_Alt > 0) then
            return Potions
        end
        return false
    end,
    RDmg = function(self, Target)
        local RDmg = self:GetMagicDamage(50 + (150 * myHero:GetSpellSlot(3).Level) + myHero.AbilityPower * 0.75, Target)
        local Strike = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Inspiration/FirstStrike/FirstStrikeAvailable.lua").Valid
        local Harvest = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Domination/DarkHarvest/DarkHarvest.lua").Count_Int --ASSETS/Perks/Styles/Domination/DarkHarvest/DarkHarvest.lua
        local HarvestCooldown = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Domination/DarkHarvest/DarkHarvestCooldown.lua").Valid---ASSETS/Perks/Styles/Domination/DarkHarvest/DarkHarvestCooldown.lua
        
        local TargetMissingHP =((Target.MaxHealth - Target.Health) / Target.MaxHealth) * 100
        local MyMissingHP =((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100

        local LudenTrue = 0
        local LiandryTrue = 0

        local HPPotions				= self:HPotions_Check(Target) 
        local RePotions             = self:RePotions_Check(Target)
        local CorrPotions           = self:CorrPotions_Check(Target)

        local RegenationTime = 3

        local MaxRegSecond = 5 + 0.2 * self:GetHeroLevel(Target)

        if self.Luden == true then
            LudenTrue = 1
        end

        if self.Liandry == true then
            LiandryTrue = 1
        end

        if Strike then
            RDmg = RDmg * 1.1
        end

        if Harvest > 0 then
            if HarvestCooldown == false then
                local HarvestDmg = self:GetMagicDamage(20 + 40 / 17 * (self:GetHeroLevel(myHero) - 1) + 0.15 * myHero.AbilityPower + Harvest * 5, Target)
                RDmg = RDmg + HarvestDmg
            end
        end

        if LudenTrue == 1 then
            RDmg = RDmg + 100 + 0.1 * myHero.AbilityPower
        end

        if LiandryTrue == 1 then
            RDmg = RDmg + 60 + 0.06 * myHero.AbilityPower + Target.MaxHealth * 0.04
            RegenationTime = RegenationTime + 4
            RDmg = RDmg * self:LiandryBonusDmg(Target)
        end

        if Harvest > 0 then
            if self.Coup.Value == 1 then
                if TargetMissingHP >= 60 then
                    RDmg = RDmg * 1.08
                end
            else
                if MyMissingHP >= 70 then
                    RDmg = RDmg * 1.11
                end 
                if MyMissingHP < 70 and MyMissingHP >= 60 then
                    RDmg = RDmg * 1.09
                end 
                if MyMissingHP < 60 and MyMissingHP >= 50 then
                    RDmg = RDmg * 1.07
                end 
                if MyMissingHP < 50 and MyMissingHP >= 40 then
                    RDmg = RDmg * 1.05
                end 
            end
        end

        if HPPotions ~= false then
            MaxRegSecond = MaxRegSecond + 10
        end
        if RePotions ~= false then
            MaxRegSecond = MaxRegSecond + 10.42
        end
        if CorrPotions ~= false then
            MaxRegSecond = MaxRegSecond + 10.416
        end

        return RDmg - (RegenationTime * MaxRegSecond)
    end,
    ZhonyasCheck = function(self, Target)
        for i = 6 , 11 do
            local Slot = Target:GetSpellSlot(i)
            --print(Slot.Info.Name)
            if Slot.Info.Name == "ZhonyasHourglass" or Slot.Info.Name == "Item2420" then
                local ZhonyasKey = self.KeyNames[i]
                if Engine:SpellReady(ZhonyasKey) then
                    return true
                end
            end
        end
        return false
    end,
    EnemiesRKillable = function(self)
        local Count = 0 
        local HeroList = ObjectManager.HeroList
        local RCD = myHero:GetSpellSlot(3).Cooldown - GameClock.Time
        local RLevel = myHero:GetSpellSlot(3).Level
        for i, Hero in pairs(HeroList) do	
            if Hero.Team ~= myHero.Team and RLevel > 0 then
                if not Hero.IsDead and Hero.Health <= self:RDmg(Hero) and RCD < 5 and self:ZhonyasCheck(Hero) == false then
                    Count = Count + 1
                end
            end
        end
	    return Count
    end,
    DrawHealthBars = function(self, Target)
        local RCD = myHero:GetSpellSlot(3).Cooldown - GameClock.Time
        local RLevel = myHero:GetSpellSlot(3).Level
        if Target.Team ~= myHero.Team and RLevel > 0 then
            --print(self:RDmg(Target))
            local KillTxt = " Is R Killable"

            if self:ZhonyasCheck(Target) == true then
                KillTxt = " !!ZHONYAS UP!!, But Is R Killable"
            end

            local fullHpDrawWidth = 104
            local hpDrawWidth = 104 * (Target.Health / Target.MaxHealth)
            local HPString = string.format("%.0f", Target.Health) .. " | " .. string.format("%.0f", Target.MaxHealth)
            if not Target.IsDead and Target.Health <= self:RDmg(Target) and RCD < 5 then
                --print("WTF2")
                Render:DrawString(Target.ChampionName .. KillTxt, 100 + self.HealthBarXAxis.Value, 60 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), 255, 255, 255, 255)
                Render:DrawString(HPString, 100 + self.HealthBarXAxis.Value, 78 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), 255, 255, 255, 255)
                Render:DrawFilledBox(98 + self.HealthBarXAxis.Value,98 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), fullHpDrawWidth+4, 17, 255, 255, 255, 255)
                Render:DrawFilledBox(100 + self.HealthBarXAxis.Value, 100 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), fullHpDrawWidth, 13, 0, 0, 0, 255)
                Render:DrawFilledBox(100 + self.HealthBarXAxis.Value, 100 + self.HealthBarYAxis.Value + (self.HealthBarDraws * 55), hpDrawWidth, 13, 252, 3, 3, 255)
                self.HealthBarDraws = self.HealthBarDraws + 1
            end
        end
    end,
    --CALLBACKS
    OnTick = function(self)
        --print(self.Luden)
        self:ItemCalculator()
        if GameHud.Minimized or GameHud.ChatOpen then return end
        if self.StartBonusDmg.Value == 1 then
            Orbwalker.ExtraDamage = 5
        end
        if Engine:IsKeyDown("HK_COMBO") then
            Orbwalker.DontAA = 0	
            return self:Combo()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Orbwalker.DontAA = 0
            return self:LastHit()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            return self:Clear()
        end
    end,
    OnDraw = function(self) 
        self.HealthBarDraws	= 0

        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
        end    
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            self:DrawHealthBars(Hero)
        end
        if self:EnemiesRKillable() > 0 then
            local KillCount = string.format("%.0f", self:EnemiesRKillable()) .. " | Enemies Killable!"
            Render:DrawString(KillCount, 300 + self.KillTextXAxis.Value, 60 + self.KillTextYAxis.Value, 255, 0, 0, 255)
        end
    end,
    OnLoad = function(self) 
        if(myHero.ChampionName ~= "Karthus") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)


        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)	
    end,
}

AddEvent("OnLoad", function() Karthus:OnLoad() end)