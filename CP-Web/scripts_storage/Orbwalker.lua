-- PerfectClear Update: 26/02/2023
-- ToDo:
-- Priorities for wave management
-- More range with no stickiness without forcetarget
-- ForceTarget nearest to mouse
-- Better LastHit
-- Better setup?
-- HeroDMG
--
Orbwalker = {

    SafeFlashComboBox = {
        "Off",
        "HK_SUMMONER1 / Left Summoner Spell",
        "HK_SUMMONER2 / Right Summoner Spell",
    },

    TargetOptions = {
        "PRIO_LOWHP",
        "PRIO_NEAREST",
        "PRIO_MOUSE",
        "PRIO_AD",
        "PRIO_AP",
        "PRIO_HYBRID"
    },
    Init = function(self)

        self.ImaginationTower ={}
        --TopLane
        self.ImaginationTower['Top1'] = {Position = Vector3.new(1169.0, 87.0, 4287.0), Lane = "Top"}
        self.ImaginationTower['Top2'] = {Position = Vector3.new(1512.0, 42.0, 6699.0), Lane = "Top"}
        self.ImaginationTower['Top3'] = {Position = Vector3.new(981.0, 37.0, 10441.0), Lane = "Top"}
        self.ImaginationTower['Top4'] = {Position = Vector3.new(4318.0, 38.0, 13875.0), Lane = "Top"}
        self.ImaginationTower['Top5'] = {Position = Vector3.new(7943.0, 38.0, 13411.0), Lane = "Top"}
        self.ImaginationTower['Top6'] = {Position = Vector3.new(10481.0, 88.0 ,13650.0), Lane = "Top"}
        --MidLane
        self.ImaginationTower['Mid1'] = {Position = Vector3.new(3651.0, 91.0, 3696.0), Lane = "Mid"}
        self.ImaginationTower['Mid2'] = {Position = Vector3.new(5048.0, 43.0, 4812.0), Lane = "Mid"}
        self.ImaginationTower['Mid3'] = {Position = Vector3.new(5846.0, 44.0, 6396.0), Lane = "Mid"}
        self.ImaginationTower['Mid4'] = {Position = Vector3.new(8955.0, 38.0, 8510.0), Lane = "Mid"}
        self.ImaginationTower['Mid5'] = {Position = Vector3.new(9767.0, 38.0, 10113.0), Lane = "Mid"}
        self.ImaginationTower['Mid6'] = {Position = Vector3.new(11134.0, 88.0, 11207.0), Lane = "Mid"}
        --BotLane
        self.ImaginationTower['Bot1'] = {Position = Vector3.new(4281.0, 86.0, 1253.0), Lane = "Bot"}
        self.ImaginationTower['Bot2'] = {Position = Vector3.new(6919.0, 43.0, 1483.0), Lane = "Bot"}
        self.ImaginationTower['Bot3'] = {Position = Vector3.new(10504.0, 41.0, 1029.0), Lane = "Bot"}
        self.ImaginationTower['Bot4'] = {Position = Vector3.new(13866.0, 38.0, 4505.0), Lane = "Bot"}
        self.ImaginationTower['Bot5'] = {Position = Vector3.new(13327.0, 38.0, 8226.0), Lane = "Bot"}
        self.ImaginationTower['Bot6'] = {Position = Vector3.new(13624.0, 88.0, 10572.0), Lane = "Bot"}

        self.KeyNames = {}
        self.KeyNames[4] 		= "HK_SUMMONER1"
        self.KeyNames[5] 		= "HK_SUMMONER2"

        self.Enabled            = 1
        self.LastMoveTime       = 0
        self.LastMissileTime    = 0

        self.LastWindup         = 0
        self.LastDelay          = 0
        
        self.LastClick          = 0
        self.WindupTimer        = 0
        self.AttackTimer        = 0

        self.WindupPercent      = 0.35
        self.WindupMod          = 1

        self.Attack             = 0
        self.Windup             = 0
        self.ExtraDamage        = 0

        self.ResetReady         = 0

        self.DontAA             = 0
        self.BlockAttack        = 0
        self.OrbRange           = 0

        self.CaitHSCounts       = {}
        self.CaitHSTimer        = 0
        self.ETimer             = 0
        self.RivenWTimer        = 0

        self.WaitForLasthit     = false
        self.WaitForLastHitTimer = nil
        self.WaitMinion         = nil
        self.BlockWaitMinion    = nil
        self.MClearPredHP       = {}

        self.ToggleTimer = 10
        self.FClearToggleOn = false
        self.CurrentOrbTarget = nil

        self.Menu = Menu:CreateMenu("Orbwalker")
        self.GenericMenu            = self.Menu:AddSubMenu("Generic Settings")
        self.GenericMenu:AddLabel("Hold Radius:")
        self.GenericMenu:AddLabel("-->if mouse closer X to player dont issue move")
        self.HoldRadius             = self.GenericMenu:AddSlider("", 50, 50, 300, 1)
        self.GenericMenu:AddLabel("Block AA:")
        self.GenericMenu:AddLabel("-->dont use AA when level X and higher (disabled = 0)")
        self.BlockAALevel           = self.GenericMenu:AddSlider("", 0, 0, 18, 1)
        self.TargetMode             = self.GenericMenu:AddCombobox("Target Mode", self.TargetOptions)
        self.GenericMenu:AddLabel("Champion Prios:")
        self.LaneclearMenu          = self.Menu:AddSubMenu("Laneclear Settings")
        self.LaneclearMenu:AddLabel("Lower = faster, higher = slower")
        self.AlwaysPush             = self.LaneclearMenu:AddCheckbox("Always push with waveclear", 0)
        self.PrioChampHarass        = self.LaneclearMenu:AddCheckbox("1 == Prio Champion, 0 == Prio LastHits In Harass", 1)
        self.Prio		            = {}
        self.SupportMenu            = self.Menu:AddSubMenu("Support Settings")
        self.SupportMode            = self.SupportMenu:AddCheckbox("Disable attacks on minions", 0)
        self.DrawMenu               = self.Menu:AddSubMenu("Draw Settings")
        self.PlayerRange            = self.DrawMenu:AddCheckbox("Draw Player Range", 1)
        self.EnemyRange             = self.DrawMenu:AddCheckbox("Draw Enemy Range", 1)
        self.DrawTargetCircle       = self.DrawMenu:AddCheckbox("Draw Targetting Circle", 1)
        self.SafeFlashMenu          = self.Menu:AddSubMenu("Safe Flash Settings")
        self.SafeFlashMenu:AddLabel("Safe flash will prevent you from flashing to your mouse while holding down a key")
        self.SafeFlashMenu:AddLabel("Look at FAQ section on how to setup keys for fail flash to work properly")
        self.SafeFlashMenu:AddLabel("Select your Flash button!")
        self.UseSafeFlash           = self.SafeFlashMenu:AddCombobox("SafeFlashComboBox", Orbwalker.SafeFlashComboBox)

        self.MiscMenu               = self.Menu:AddSubMenu("Misc Settings")
        self.AssassinMode           = self.MiscMenu:AddCheckbox("Only Target Your ForceTarget", 0)
        self.UsePrioList            = self.MiscMenu:AddCheckbox("Automatically Set Target Priorities", 1)
        self.BlockAttackForDodge    = self.MiscMenu:AddCheckbox("Block/Cancel AA for Evade", 0)
        self.WindUpSlider           = self.MiscMenu:AddSlider("Windup Percentage", 100, 70, 130, 1)
        self.ApmMenu                = self.Menu:AddSubMenu("APM Modifier")
        self.CustomAPM              = self.ApmMenu:AddCheckbox("Use Custom APM", 0)
        self.ApmModifier            = self.ApmMenu:AddSlider("Out of Combat APM", 350, 50,600,1)
        self.MinimumAPM             = self.ApmMenu:AddSlider("APM Randomization", 30,0,100,1)
        self.CombatAPM              = self.ApmMenu:AddSlider("In Combat APM", 500,300,1000,1)

        self:LoadSettings()
    end,
    SaveSettings = function(self)
        SettingsManager:CreateSettings("Orbwalker")
        SettingsManager:AddSettingsGroup("Settings")
        SettingsManager:AddSettingsInt("HoldRadius", self.HoldRadius.Value)
        SettingsManager:AddSettingsInt("BlockAALevel", self.BlockAALevel.Value)
        SettingsManager:AddSettingsInt("AlwaysPush", self.AlwaysPush.Value)
        SettingsManager:AddSettingsInt("PrioChampHarass", self.PrioChampHarass.Value)
        SettingsManager:AddSettingsInt("SafeFlashComboBox", self.UseSafeFlash.Selected)
        SettingsManager:AddSettingsInt("SupportMode", self.SupportMode.Value)
        SettingsManager:AddSettingsInt("AssassinMode", self.AssassinMode.Value)
        SettingsManager:AddSettingsInt("TargetMode", self.TargetMode.Selected)
        SettingsManager:AddSettingsInt("PlayerRange", self.PlayerRange.Value)
        SettingsManager:AddSettingsInt("EnemyRange", self.EnemyRange.Value)
        SettingsManager:AddSettingsInt("DrawTarget", self.DrawTargetCircle.Value)
        SettingsManager:AddSettingsInt("BlockAttackForDodge", self.BlockAttackForDodge.Value)
        SettingsManager:AddSettingsInt("AutomaticPrio", self.UsePrioList.Value)
        SettingsManager:AddSettingsInt("WindUpSlider", self.WindUpSlider.Value)
        SettingsManager:AddSettingsInt("CustomAPM", self.CustomAPM.Value)
        SettingsManager:AddSettingsInt("ApmModifier", self.ApmModifier.Value)
        SettingsManager:AddSettingsInt("CombatAPM", self.CombatAPM.Value)
        SettingsManager:AddSettingsInt("MinimumAPM", self.MinimumAPM.Value)

    end,
    LoadSettings = function(self)
        SettingsManager:GetSettingsFile			("Orbwalker")
        self.HoldRadius.Value = SettingsManager:GetSettingsInt("Settings","HoldRadius")
        self.BlockAALevel.Value = SettingsManager:GetSettingsInt("Settings","BlockAALevel")
        self.AlwaysPush.Value = SettingsManager:GetSettingsInt("Settings","AlwaysPush")
        self.PrioChampHarass.Value = SettingsManager:GetSettingsInt("Settings","PrioChampHarass")
        self.UseSafeFlash.Selected = SettingsManager:GetSettingsInt("Settings","SafeFlashComboBox")
        self.SupportMode.Value = SettingsManager:GetSettingsInt("Settings","SupportMode")
        self.AssassinMode.Value = SettingsManager:GetSettingsInt("Settings","AssassinMode")
        self.TargetMode.Selected = SettingsManager:GetSettingsInt("Settings","TargetMode")
        self.PlayerRange.Value = SettingsManager:GetSettingsInt("Settings","PlayerRange")
        self.EnemyRange.Value = SettingsManager:GetSettingsInt("Settings","EnemyRange")
        self.DrawTargetCircle.Value = SettingsManager:GetSettingsInt("Settings","DrawTarget")
        self.BlockAttackForDodge.Value = SettingsManager:GetSettingsInt("Settings","BlockAttackForDodge")
        self.UsePrioList.Value = SettingsManager:GetSettingsInt("Settings","AutomaticPrio")
        self.WindUpSlider.Value = SettingsManager:GetSettingsInt("Settings","WindUpSlider")
        self.CustomAPM.Value = SettingsManager:GetSettingsInt("Settings", "CustomAPM")
        self.ApmModifier.Value = SettingsManager:GetSettingsInt("Settings", "ApmModifier")
        self.CombatAPM.Value = SettingsManager:GetSettingsInt("Settings", "CombatAPM")
        self.MinimumAPM.Value = SettingsManager:GetSettingsInt("Settings", "MinimumAPM")
    end,
    --Util functions
    SortList = function(self, List, Mode) 
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end
        if Mode == "CLEAR_LAST" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    local CannonLeft = 0
                    local CannonRight = 0
                    if CurrentList[left].ChampionName == "SRU_ChaosMinionSiege" or CurrentList[left].ChampionName == "SRU_OrderMinionSiege" then
                        CannonLeft = 1000
                    end
                    if CurrentList[right].ChampionName == "SRU_ChaosMinionSiege" or CurrentList[right].ChampionName == "SRU_OrderMinionSiege" then
                        CannonRight = 1000
                    end
                    local PredHPLeft    = self.MClearPredHP[CurrentList[left].Index] - CannonLeft
                    local PredHPRight   = self.MClearPredHP[CurrentList[right].Index] - CannonRight
                    if PredHPLeft > PredHPRight then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right] 
                        CurrentList[right] = Swap
                    end
                end
            end    
        end
        if Mode == "CLEAR_PUSH" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    local PredHPLeft    = self.MClearPredHP[CurrentList[left].Index] * CurrentList[left].AttackRange
                    local PredHPRight   = self.MClearPredHP[CurrentList[right].Index] * CurrentList[right].AttackRange
                    if PredHPLeft > PredHPRight then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right] 
                        CurrentList[right] = Swap
                    end
                end
            end    
        end
        if Mode == "LOWHP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    if CurrentList[left].Health > CurrentList[right].Health then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right] 
                        CurrentList[right] = Swap
                    end
                end
            end    
        end
        if Mode == "MAXHP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    if CurrentList[left].Health < CurrentList[right].Health then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right] 
                        CurrentList[right] = Swap
                    end
                end
            end    
        end
        if Mode == "MAXRANGE" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    if CurrentList[left].AttackRange < CurrentList[right].AttackRange then    
                        local Swap = CurrentList[left]
                        CurrentList[left] = CurrentList[right]
                        CurrentList[right] = Swap  
                    end
                end
            end    
        end
        if Mode == "MAXAD" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    if (CurrentList[left].BaseAttack + CurrentList[left].BonusAttack) < (CurrentList[right].BaseAttack + CurrentList[right].BonusAttack) then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    end
                end
            end    
        end
        if Mode == "MAXAP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do    
                    if CurrentList[left].AbilityPower < CurrentList[right].AbilityPower then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    end
                end
            end    
        end
        return CurrentList
    end,
    PredictDamageToTarget = function(self, Target, Prio)
        local APDamage = myHero.AbilityPower * (100/(100+Target.MagicResist))
        local ADDamage = (myHero.BaseAttack + myHero.BonusAttack) * (100/(100+Target.Armor)) 
        
        if myHero.BonusAttack > myHero.AbilityPower then
            local PrioDamage        = ADDamage * Prio
            return PrioDamage - (Target.Health + Target.Shield + Target.PhysicalShield)
        else
            local PrioDamage        = APDamage * Prio
            return PrioDamage - (Target.Health + Target.Shield + Target.MagicalShield)   
        end

        return 0
    end,
    GetTargetSelectorList = function(self, Position, Range)
        if self.ForceTarget and self.ForceTarget.IsHero then
            if self.AssassinMode.Value == 1 then
                if self.ForceTarget.IsDead == false then
                    if self:GetDistance(self.ForceTarget.Position, Position) < Range + self.ForceTarget.CharData.BoundingRadius then
                        return {self.ForceTarget}
                    else
                        return {}
                    end
                end
            else
                if self.ForceTarget.IsTargetable and self:GetDistance(self.ForceTarget.Position, Position) < Range + self.ForceTarget.CharData.BoundingRadius then
                    return {self.ForceTarget}
                end
            end
        end

        local Mode = self.TargetOptions[self.TargetMode.Selected+1]
        local List = self:GetEnemyHerosInRange(Position, Range)
       
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end

        if Mode == "PRIO_LOWHP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and LeftPrio.Value < RightPio.Value then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        if CurrentList[left].Health > CurrentList[right].Health then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        if Mode == "PRIO_NEAREST" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and LeftPrio.Value < RightPio.Value then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        if self:GetDistance(myHero.Position, CurrentList[left].Position) > self:GetDistance(myHero.Position, CurrentList[right].Position) then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        if Mode == "PRIO_MOUSE" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and LeftPrio.Value < RightPio.Value then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        if self:GetDistance(GameHud.MousePos, CurrentList[left].Position) > self:GetDistance(GameHud.MousePos, CurrentList[right].Position) then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        if Mode == "PRIO_AD" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and LeftPrio.Value < RightPio.Value then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        if CurrentList[left].Armor > CurrentList[right].Armor then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        if Mode == "PRIO_AP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and LeftPrio.Value < RightPio.Value then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        if CurrentList[left].MagicResist > CurrentList[right].MagicResist then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        if Mode == "PRIO_HYBRID" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = self.Prio[CurrentList[left].Index]
                    local RightPio = self.Prio[CurrentList[right].Index]
                    if LeftPrio and RightPio and self:PredictDamageToTarget(CurrentList[left], LeftPrio.Value) < self:PredictDamageToTarget(CurrentList[right], RightPio.Value) then    
                        local Swap = CurrentList[left] 
                        CurrentList[left] = CurrentList[right]  
                        CurrentList[right] = Swap  
                    else
                        local LeftDamage = self:PredictDamageToTarget(CurrentList[left], 1)
                        local RightDamage = self:PredictDamageToTarget(CurrentList[right], 1)
                        if LeftDamage < RightDamage then    
                            local Swap = CurrentList[left] 
                            CurrentList[left] = CurrentList[right]  
                            CurrentList[right] = Swap  
                        end    
                    end   
                end
            end    
        end
        return CurrentList    
    end,
    GetAllEnemyHeros = function(self)
        local Enemies = {}
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
            if Object.Team ~= myHero.Team then
                Enemies[#Enemies+1] = Object
            end
        end
        return Enemies
    end,
    GetAllAllyHeros = function(self)
        local Allies = {}
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
            if Object.Team == myHero.Team then
                Allies[#Allies+1] = Object
            end
        end
        return Allies

    end,
    GetAllEnemyTurrets = function(self)
        local Enemies = {}
        local Turrets = ObjectManager.TurretList
        for _, Object in pairs(Turrets) do
            if Object.Team ~= myHero.Team then
                Enemies[#Enemies+1] = Object
            end
        end
        return Enemies
    end,
    GetAllAllyTurrets = function(self)
        local Allies = {}
        local Turrets = ObjectManager.TurretList
        for _, Object in pairs(Turrets) do
            if Object.Team == myHero.Team then
                Allies[#Allies+1] = Object
            end
        end
        return Allies
    end,
    GetAllLaneTowers = function(self)
        local Towers = {}
        local Turrets = ObjectManager.TurretList
        for _, Object in pairs(Turrets) do
            if Object.MaxHealth > 3000 then
                Towers[#Towers+1] = Object
            end
        end
        return Towers
    end,
    GetLaneTowers = function(self, Lane, Team)
        local Towers = {}
        local Turrets = ObjectManager.TurretList
        for _, Object in pairs(Turrets) do
            if Object.MaxHealth > 3000 and Object.Team == Team and Object.IsDead == false then
                local Name = Object.Name
                if Lane == 1 then
                    if Name == "Turret_T1_C_06_A" or Name == "Turret_T1_L_02_A" or Name == "Turret_T1_L_03_A" or Name == "Turret_T2_L_03_A" or Name == "Turret_T2_L_02_A" or Name == "Turret_T2_L_01_A" then
                        Towers[#Towers+1] = Object
                    end
                elseif Lane == 2 then
                    if Name == "Turret_T1_C_03_A" or Name == "Turret_T1_C_04_A" or Name == "Turret_T1_C_05_A" or Name == "Turret_T2_C_05_A" or Name == "Turret_T2_C_04_A" or Name == "Turret_T2_C_03_A" then
                        Towers[#Towers+1] = Object
                    end
                elseif Lane == 3 then
                    if Name == "Turret_T1_C_07_A" or Name == "Turret_T1_R_02_A" or Name == "Turret_T1_R_03_A" or Name == "Turret_T2_R_03_A" or Name == "Turret_T2_R_02_A" or Name == "Turret_T2_R_01_A" then
                        Towers[#Towers+1] = Object
                    end
                end
            end
        end
        return Towers
    end,
    SortClosestFromTarget = function(self, List, Target)
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end
        for left = 1, #CurrentList do  
            for right = left+1, #CurrentList do
                if self:GetDistance(Target.Position, CurrentList[left].Position) > self:GetDistance(Target.Position, CurrentList[right].Position) then    
                    local Swap = CurrentList[left] 
                    CurrentList[left] = CurrentList[right]  
                    CurrentList[right] = Swap  
                end  
            end
        end
        return CurrentList 
    end,
    TargetsLane = function(self, Target)
        local LaneTowers = self.ImaginationTower
        local Towers = self:SortClosestFromTarget(LaneTowers, Target)
        local Tower1 = Towers[1]
        local Lane = 0
        local Name = Tower1.Name
        local Position = Tower1.Position
        --print(Position.x, ",", Position.y,",", Position.z)
        --print(Tower1.Name)
        Render:DrawCircle(Tower1.Position, 200 ,0,255,255,255)
        if Tower1.Lane == "Top" then
            Lane = 1
        end
        if Tower1.Lane == "Mid" then
            Lane = 2
        end
        if Tower1.Lane == "Bot" then
            Lane = 3
        end
        --print(Lane)
        return Lane
    end,
    GetTowerDiff = function(self, Target)
        local Lane = self:TargetsLane(Target)
        local Diff = 0
        if Lane ~= 0 then
            --print("Lane ", Lane)
            local AllyTeam = myHero.Team
            local EnemyTeam = 100
            if AllyTeam == 100 then
                EnemyTeam = 200
            end
            local AllyTowers = self:GetLaneTowers(Lane, AllyTeam)
            local EnemyTowers = self:GetLaneTowers(Lane, EnemyTeam)
            Diff = #AllyTowers - #EnemyTowers
        end
        return Diff
    end,
    GetAllEnemyMinions = function(self)
        local Enemies = {}
        local Minions = ObjectManager.MinionList
        for _, Object in pairs(Minions) do
            if Object.Team ~= myHero.Team then
                Enemies[#Enemies+1] = Object
            end
        end
        return Enemies
    end,
    GetAllAllyMinions = function(self)
        local Allies = {}
        local Minions = ObjectManager.MinionList
        for _, Object in pairs(Minions) do
            if Object.Team == myHero.Team then
                Allies[#Allies+1] = Object
            end
        end
        return Allies

    end,
    GetAllEnemyMissiles = function(self)
        local Enemies = {}
        local Missiles = ObjectManager.MissileList
        for _, Object in pairs(Missiles) do
            if Object.Team ~= myHero.Team and _ == Object.Index then
                Enemies[#Enemies+1] = Object
            end
        end
        return Enemies
    end,
    GetAllAllyMissiles = function(self)
        local Allies = {}
        local Missiles = ObjectManager.MissileList
        for _, Object in pairs(Missiles) do
            if Object.Team == myHero.Team and _ == Object.Index then
                Allies[#Allies+1] = Object
            end
        end
        return Allies
    end,
    GetEnemyHerosInRange = function(self, Position, Range)
        local InRange = {}
        local Enemies = self:GetAllEnemyHeros()
        for _, Object in pairs(Enemies) do
            if myHero.ChampionName == "Samira" then
                local myLvl = myHero.Level
                local RangeBuff = 150
                if myLvl >= 0 and myLvl < 4 then
                    RangeBuff = 150
                else
                    if myLvl >= 4 and myLvl < 8 then
                        RangeBuff = 150 + 77.5
                    else
                        if myLvl >= 8 and myLvl < 12 then
                            RangeBuff = 150 + 155
                        else
                            if myLvl >= 12 and myLvl < 16 then
                                RangeBuff = 150 + 232.5
                            else
                                if myLvl >= 16 then
                                    RangeBuff = 150 + 310     
                                end
                            end
                        end
                    end
                end
                local Stun 					= Object.BuffData:HasBuffOfType(BuffType.Stun) == true
                local Suppress 				= Object.BuffData:HasBuffOfType(BuffType.Suppression) == true
                local Taunt 				= Object.BuffData:HasBuffOfType(BuffType.Taunt) == true
                local Knockup 				= Object.BuffData:HasBuffOfType(BuffType.Knockup) == true
                local Knockback 			= Object.BuffData:HasBuffOfType(BuffType.Knockback) == true
                local Snare 				= Object.BuffData:HasBuffOfType(BuffType.Snare) == true
                local Charm 				= Object.BuffData:HasBuffOfType(BuffType.Charm) == true
                local Asleep 				= Object.BuffData:HasBuffOfType(BuffType.Asleep) == true
                local CCd = Stun or Suppress or Taunt or Knockup or Knockback or Snare or Charm or Asleep
                if CCd then
                    Range = Range + RangeBuff
                end
            end
            local Distance          = self:GetDistance(Object.Position, Position)
            local RangeCheck        = Distance < Range + Object.CharData.BoundingRadius - 33
            local MousePos          = GameHud.MousePos
            local MouseDist         = self:GetDistance(Object.Position, MousePos)
            local MouseCheck        = MouseDist < Distance - 100
            local EnemyCheck        = self:EnemiesInRange(myHero.Position, Range + Object.CharData.BoundingRadius - 33)
            if MouseCheck and EnemyCheck == 0 then
                RangeCheck = Distance < Range + Object.CharData.BoundingRadius + 55
            end
            local TargetableCheck   = Object.IsTargetable and Object.MaxHealth > 10
            local TargetImmune      = self:TargetIsImmune(Object)
            local GwenCheck         = (Object.BuffData:GetBuff("gwenw_gweninsidew").Valid == false or self:GetDistance(myHero.Position, Object.Position) <= 475)
            if RangeCheck and TargetableCheck and not TargetImmune and GwenCheck then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetAllyHerosInRange = function(self, Position, Range)
        local InRange = {}
        local Allies = self:GetAllAllyHeros()
        for _, Object in pairs(Allies) do
            local Bound =  math.min(55, Object.CharData.BoundingRadius)
            if self:GetDistance(Object.Position, Position) < Range + Bound and Object.IsTargetable and Object.MaxHealth > 10 then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetEnemyMinionsInRange = function(self, Position, Range)
        local InRange = {}
        local Enemies = self:GetAllEnemyMinions()
        for _, Object in pairs(Enemies) do
            local Bound =  math.min(55, Object.CharData.BoundingRadius)
            if self:GetDistance(Object.Position, Position) < Range + Bound and Object.IsTargetable and self:IsValidMinion(Object) and Object.IsDead == false then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetAllyMinionsInRange = function(self, Position, Range)
        local InRange = {}
        local Allies = self:GetAllAllyMinions()
        for _, Object in pairs(Allies) do
            local Bound =  math.min(55, Object.CharData.BoundingRadius)
            if self:GetDistance(Object.Position, Position) < Range + Bound and Object.IsTargetable and self:IsValidMinion(Object) then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetAllJungleMinions = function(self)
        local Allies = {}
        local Minions = ObjectManager.MinionList
        for _, Object in pairs(Minions) do
            if Object.Team == 300 then
                Allies[#Allies+1] = Object
            end
        end
        return Allies
    end,
    GetJungleMinionsInRange = function(self, Position, Range)
        local InRange = {}
        local Jungle = self:GetAllJungleMinions()
        local OffAggro = nil
        for _, Object in pairs(Jungle) do
            local Bound =  math.min(55, Object.CharData.BoundingRadius)
            if self:GetDistance(Object.Position, Position) < Range + Bound and Object.IsTargetable and self:IsValidMinion(Object) then
                InRange[#InRange+1] = Object
                --print(Object.ChampionName) --SRU_Razorbeak, SRU_Red, SRU_Krug, SRU_Murkwolf, SRU_Blue, SRU_Gromp
                if Object.Mana < 100 then
                    if Object.ChampionName == "SRU_Red" or Object.ChampionName == "SRU_Blue" or Object.ChampionName == "SRU_Gromp" then
                        OffAggro = true
                    end
                end
            end
        end
        return InRange, OffAggro
    end,
    GetDistance = function(self, from, to)
        return math.max(0, math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2))
    end,
    --Helper functions
    GetPlayerLevel = function(self) 
        local Q = myHero:GetSpellSlot(0).Level
        local W = myHero:GetSpellSlot(1).Level
        local E = myHero:GetSpellSlot(2).Level
        local R = myHero:GetSpellSlot(3).Level
        return Q + W + E + R
    end,    
    GetAttackSpeed = function(self)
        local AttackRange		    = myHero.AttackRange
        local AttackSpeedMod	    = myHero.AttackSpeedMod
        local BaseAttackSpeed	    = myHero.CharData.BaseAttackSpeed
        local BaseAttackSpeedRatio	= myHero.CharData.BaseAttackSpeedRatio

        if myHero.ChampionName == "Jhin" then
            local AttackSpeedPerLevel = {0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.11,0.12,0.14,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44}
            local CurrentAttackSpeedMod = AttackSpeedPerLevel[math.min(18, math.max(1, self:GetPlayerLevel()))] + 1.1
            return BaseAttackSpeed * CurrentAttackSpeedMod
        end
        if myHero.ChampionName == "Sion" then
            if myHero.BuffData:GetBuff("sionpassivezombie").Count_Alt > 0 then
                return 1.75
            end
        end
        local AttackSpeed = BaseAttackSpeed + (BaseAttackSpeedRatio * (AttackSpeedMod-1))
        --print(AttackSpeed)
        local JinxExcited		= myHero.BuffData:GetBuff("JinxPassiveKillAttackSpeed").Count_Alt > 0
        local LethalTempo		= myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Precision/LethalTempo/LethalTempo.lua")
        local Stacks			= LethalTempo.Count_Int
        --print(Stacks)
        if Stacks >= 6 or JinxExcited then
             return AttackSpeed
        end

        if myHero.ChampionName == "Zeri" then
            return math.min(AttackSpeed, 1.5)
        end
        
        return math.min(AttackSpeed, 2.5);    
    end,   
    IsValidMinion = function(self,Minion)
        if Minion.Name == "k" or  Minion.Name == "hiu" then
            return false
        end
        if self.TeamHasGP == true and Minion.Name == "Barrel" then
            return false
        end
        local CheckNames = {"Unused","Beacon","Camp", "Plant", "Honey", "Fake", "Cupcake", "Feather", "Fiora"}
        for _, Name in pairs(CheckNames) do
            if string.find(Minion.Name,Name, 1) ~= nil then
                return false
            end
        end
        if string.find(Minion.Name, "Seed", 1) ~= nil and Minion.MaxHealth < 8 then
            return false
        end
        if myHero.ChampionName ~= "Senna" then
            if string.find(Minion.ChampionName, "SennaSoul", 1) ~= nil then
                return false
            end
        end  
        return true
    end,   
    SortAsTurretTargetList = function(self, List, Position)
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end
        for left = 1, #CurrentList do  
            for right = left+1, #CurrentList do
                if self:GetDistance(Position, CurrentList[left].AIData.TargetPos) > self:GetDistance(Position, CurrentList[right].AIData.TargetPos) then    
                    local Swap = CurrentList[left] 
                    CurrentList[left] = CurrentList[right]  
                    CurrentList[right] = Swap  
                end    
            end
        end
        return CurrentList   
    end,
    GetInRangeFromList = function(self, List, Position, Range)
        local InRange = {}
        for _, Object in pairs(List) do
            if self:GetDistance(Position, Object.Position) < Range then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetMinionDmg = function(self, Source)
        local AD = Source.BaseAttack + Source.BonusAttack
        local Speed = 1.25
        local Upgrade = math.max(1, math.floor(GameClock.Time/90))
        if Source.ChampionName == "SRU_OrderMinionMelee" then
            AD = 12
            Speed = 1.25
            if Upgrade > 5 then
                AD = 12 + (Upgrade - 5) * 3.41
            end
            if AD > 80 then
                AD = 80
            end
        end
        if Source.ChampionName == "SRU_OrderMinionRanged" then
            AD = 22.5
            Speed = 0.667
            if Upgrade > 0 and Upgrade < 6 then
                AD = 22.5 + Upgrade * 1.5
            end
            if Upgrade > 5 then
                AD = 30 + (Upgrade - 5) * 4.5
            end
            if AD > 120 then
                AD = 120
            end
        end
        if Source.ChampionName == "SRU_OrderMinionSiege" then
            Speed = 0.667
            AD = 39.5 + Upgrade * 1.5
        end
        if Source.ChampionName == "Super" then
            Speed = 0.85
            AD = 225 + Upgrade * 5
        end
        return AD, Speed
    end,
    GetDamageBeforePlayer = function(self, Minion)
        local MinionList    = ObjectManager.MinionList
        local HeroList      = ObjectManager.HeroList
        local TurretList    = ObjectManager.TurretList
        local Missiles      = ObjectManager.MissileList
        local PlayerMissileSpeed = myHero.AttackInfo.Data.MissileSpeed
        local AllyMinions   = self:SortList(self:GetAllyMinionsInRange(Minion.Position, 700), "MAXRANGE")
        --print(PlayerMissileSpeed)
        --expiremental jayce adjustment to fix lasthits
        if myHero.ChampionName == "Jayce" then
            PlayerMissileSpeed = 2500
        end
        if myHero.ChampionName == "Aphelios" then
            --print(1)
            if myHero.BuffData:GetBuff("ApheliosGravitumManager").Valid then
                --print("1UK")
                PlayerMissileSpeed = 1500
                --Orwalker.ExtraDamage = 0
            end
            if myHero.BuffData:GetBuff("ApheliosCrescendumManager").Valid then
                --print("Sentry?")
                PlayerMissileSpeed = 6000
            end
            if myHero.BuffData:GetBuff("ApheliosSeverumManager").Valid then --ApheliosInfernumManager
                --print("2UK")
                PlayerMissileSpeed = 15000
                --Orwalker.ExtraDamage = 0
            end
            if myHero.BuffData:GetBuff("ApheliosCalibrumManager").Valid then --Sniper
                --print("Sniper")
                PlayerMissileSpeed = 3000
                self.ExtraDamage = -1
            end
            if myHero.BuffData:GetBuff("ApheliosInfernumManager").Valid then --ApheliosInfernumManager
               --print("Spread")
                PlayerMissileSpeed = 2000
                self.ExtraDamage = (myHero.BaseAttack + myHero.BonusAttack) * 0.1
            end
        end
        if myHero.ChampionName == "Zeri" then
            PlayerMissileSpeed = math.huge
        end
        --print(PlayerMissileSpeed)
        local PlayerAttackTime = self:GetPlayerAttackWindup()
        if myHero.AttackRange > 300 then
            PlayerAttackTime   = PlayerAttackTime + (self:GetDistance(myHero.Position, Minion.Position)/PlayerMissileSpeed)
        end
        --print(PlayerAttackTime + self.OrbRange/PlayerMissileSpeed)
        local BuffedDMG, Reduction, BuffType    = self:MinionExtraDmg(Minion)
        --print(Reduction)
        BuffedDMG = BuffedDMG - 1
        if BuffedDMG < 0 then
            BuffedDMG = 0
        end
        BuffedDMG = 1 + (BuffedDMG/ 100)
        --print("BuffedDMG",BuffedDMG)
        --print("BuffedDMG: ", BuffedDMG, "Reduction: ", Reduction)
        local Damage                            = 0
        local HeroDamage                        = 0
        local IncomingMissiles                  = {}
        for _, Missile in pairs(Missiles) do
            local Team = Missile.Team
            if Team == 100 or Team == 200 then
                local TargetID = Missile.TargetIndex
                if Team ~= Minion.Team and TargetID == Minion.Index then
                    local SourceID  = Missile.SourceIndex
                    if TurretList[SourceID] then
                        local TimeTillMissileDamage = self:GetDistance(Missile.Position, Minion.Position)/1100
                        if TimeTillMissileDamage < PlayerAttackTime then                       
                            local Source    = TurretList[SourceID]
                            local TrtDMG    = self:GetDamageFromTurretToMinion(Source, Minion)
                            if TrtDMG then
                                Damage = Damage + TrtDMG
                                IncomingMissiles[#IncomingMissiles+1] = Missile
                            end
                        end
                    end
                    if MinionList[SourceID] then
                        local TimeTillMissileDamage = self:GetDistance(Missile.Position, Minion.Position)/650
                        if TimeTillMissileDamage < PlayerAttackTime then 
                            --print(TimeTillMissileDamage, PlayerAttackTime)                      
                            local Source    = MinionList[SourceID]
                            local AD        = (Source.BaseAttack + Source.BonusAttack) * BuffedDMG
                            local Speed     = 1.25
                            AD, Speed = self:GetMinionDmg(Source) --Hardcoded fix for minion dmg!
                            --print(Source.ChampionName, AD)
                            AD = AD * BuffedDMG
                            local Armor     = Minion.Armor
                            --print("MinionARMOR: ",Minion.Armor)
                            Damage = Damage + (AD * (100/(100+Armor))) - Reduction
                            IncomingMissiles[#IncomingMissiles+1] = Missile
                        end
                    end
                    if HeroList[SourceID] then
                        local TimeTillMissileDamage = self:GetDistance(Missile.Position, Minion.Position)/650
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

        --[[local MeleeCount = 0
        local MeleeAD  = 25
        if 0 == 0 and myHero.AttackRange > 300 then --turned off!!
            for _, Ally in pairs(AllyMinions) do --In Development!!!
                --print(Ally.ChampionName)
                if string.len(Ally.ActiveSpell.Info.Name) > 0 then
                    --print("Works!")
                    --print(Ally.CharData.BoundingRadius)
                    local AllyPos = Ally.Position
                    local Modifier  = Ally.AttackRange + Ally.CharData.BoundingRadius *2
                    local MaxDirection = Vector3.new(AllyPos.x + (Ally.Direction.x*Modifier),AllyPos.y ,AllyPos.z + (Ally.Direction.z*Modifier))
                    local Target = self:WillCollideWithMinion(Ally.Position, MaxDirection, 20, Minion)
                    if Target and Target.Index == Minion.Index then   
                        local Source    = Ally
                        local MeleeAD   = 25 --(Source.BaseAttack + Source.BonusAttack) * BuffedDMG
                        local Speed     = 1.25
                        MeleeAD, Speed = self:GetMinionDmg(Source) --Hardcoded fix for minion dmg!
                        MeleeCount = MeleeCount + 1
                        --print(Source.ChampionName, AD, BuffedDMG)
                        --print(Source.Level)
                        --local Armor     = Minion.Armor
                        --Damage = Damage + (AD * (100/(100+Armor))) - Reduction --In Development!!!
                    end
                end
            end
        end
        local MeleeChance   = PlayerAttackTime / 0.8
        local MeleeHits     = math.floor(MeleeChance * MeleeCount)

        if MeleeHits > 0 then -- Indevelopment!!
            --print(MeleeHits)
            local Armor     = Minion.Armor
            --Damage = Damage + (MeleeAD * (100/(100+Armor))) * MeleeHits - (Reduction * MeleeHits)
        end]]
        return Damage, HeroDamage, IncomingMissiles
    end,
    GetDamageFromTurretToMinion = function(self, Turret, Minion)
        local Armor = Minion.Armor
        if Minion.AttackRange == 110 then --Melee
            --45%
            local HPDamage = Minion.MaxHealth * 0.45
            return (HPDamage * (100/(100+Armor))) 
        end
        if Minion.AttackRange == 300 then --Siege
            if Turret.MaxHealth == 5000 then --Outer
                --14%
                local HPDamage = Minion.MaxHealth * 0.14
                return (HPDamage * (100/(100+Armor))) 
            end
            if Turret.MaxHealth == 3600 then --Inner
                --11%
                local HPDamage = Minion.MaxHealth * 0.11
                return (HPDamage * (100/(100+Armor))) 
            end
            if Turret.MaxHealth <= 3300 then --Inhib/Nexus
                --8%
                local HPDamage = Minion.MaxHealth * 0.08
                return (HPDamage * (100/(100+Armor))) 
            end
        end
        if Minion.AttackRange == 550 then --Caster
            --70%
            local HPDamage = Minion.MaxHealth * 0.70
            return (HPDamage * (100/(100+Armor))) 
        end                            
    end,
    GetDamagePercentFromTurretToMinion = function(self, Turret, Minion)
        if Minion.AttackRange == 110 then --Melee
            --45%
            return 0.45
        end
        if Minion.AttackRange == 300 then --Siege
            if Turret.MaxHealth == 5000 then --Outer
                --14%
                return 0.14
            end
            if Turret.MaxHealth == 3600 then --Inner
                --11%
                return 0.11
            end
            if Turret.MaxHealth <= 3300 then --Inhib/Nexus
                --8%
                return 0.08
            end
        end
        if Minion.AttackRange == 550 then --Caster
            --70%
            return 0.70
        end                            
    end,
    CheckTurretAggro = function(self, Minion)
        local TurretList = ObjectManager.TurretList
        for _, Turret in pairs(TurretList) do
            if Turret.IsTargetable and Turret.Team ~= Minion.Team and Minion.Team ~= 300 then
                if self:GetDistance(Turret.Position, Minion.AIData.TargetPos) < 750 then
                    return Turret
                end
            end     
        end

        return nil
    end,
    GetTurretMissile = function(self, Turret)
        local Missiles = self:GetAllAllyMissiles()
        for _, Missile in pairs(Missiles) do
            local SourceID = Missile.SourceIndex
            if SourceID == Turret.Index then
                return Missile 
            end
        end
        return nil
    end,
    PlayerMissileOnTheWay = function(self, Target)
        local PlayerDamage = math.floor((myHero.BaseAttack + myHero.BonusAttack) * (100/(100+Target.Armor)))
        local PlayerMissile = self:GetPlayerMissiles()
        for _, Missile in pairs(PlayerMissile) do
            if Missile.TargetIndex == Target.Index and Target.Health - PlayerDamage < PlayerDamage then return true end
        end
        return false
    end,
    PlayerMissileJustSpawned = function(self)
        local PlayerMissile = self:GetPlayerMissiles()
        for _, Missile in pairs(PlayerMissile) do
            if self:GetDistance(myHero.Position, Missile.Position) < 100 then return true end
        end
        return false
    end,
    GetPlayerDamage = function(self, Minion)
        local CritChance = myHero.CritChance
        if myHero.ChampionName == "Jhin" and myHero.Ammo == 1 then
            CritChance = 1.0
        end
        local PlayerDamage = math.floor((myHero.BaseAttack + myHero.BonusAttack + self.ExtraDamage) * (100/(100+Minion.Armor))) * math.max(1.0, math.min(2.0, math.floor(CritChance+1.5))) --gamble a bit with crit 
        if myHero.ChampionName == "Ashe" then
            PlayerDamage = math.floor((myHero.BaseAttack + myHero.BonusAttack + self.ExtraDamage) * (100/(100+Minion.Armor)))
            local Slow = Minion.BuffData:GetBuff("ashepassiveslow")
            if Slow.Valid then
                PlayerDamage = PlayerDamage + (myHero.BaseAttack + myHero.BonusAttack) * (0.1 + CritChance * 0.75)
            end
        end
        if myHero.ChampionName == "Zeri" then
            local passive = myHero.BuffData:GetBuff("zeriqpassiveready")
            if passive.Valid then
                if myHero.ChampionName == "Zeri" and (Minion.Health / Minion.MaxHealth) > 0.35 then
                    PlayerDamage = 15 + (25 / 17) * (self:GetPlayerLevel() - 1) * (0.7025 + 0.0175 * (self:GetPlayerLevel() - 1)) + myHero.AbilityPower * 0.04
                end
                if myHero.ChampionName == "Zeri" and (Minion.Health / Minion.MaxHealth) <= 0.35 then
                    PlayerDamage = 4 * 15 + (4 * 25 / 17) * (self:GetPlayerLevel() - 1) * (0.7025 + 0.0175 * (self:GetPlayerLevel() - 1)) + myHero.AbilityPower * 0.16
                end 
            else
                PlayerDamage = (5 + (3 * myHero:GetSpellSlot(0).Level)) + (myHero.BaseAttack + myHero.BonusAttack) / 100 * (100 + (5 * myHero:GetSpellSlot(0).Level))
            end
        end

        if myHero.BuffData:GetBuff("6672buff").Count_Alt >= 2 then
            PlayerDamage = PlayerDamage + (50 * (0.4 * myHero.BonusAttack))
        end

        for i = 6 , 11 do
            local Slot = myHero:GetSpellSlot(i)
            if Slot.Info.Name == "BloodthirsterDummySpell" then
                PlayerDamage = PlayerDamage + 20
            end
        end
        return PlayerDamage
    end,
    WillCollideWithMinion = function(self, Start, End, MissileWidth, Minion)
        local Distance1 = Prediction:GetDistance(Start, End)
        local Distance2 = Prediction:GetDistance(Start, Minion.Position)
        if Distance1 > Distance2 and Minion.IsTargetable then
            if Prediction:PointOnLineSegment(Start, End, Minion.Position, MissileWidth) == true then
                return Minion
            end
        end
        return nil
    end,
    GetAllAllyLevels = function(self)
        local LvL = 0
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
            if Object.Team == myHero.Team then
                --print(Object.ChampionName, Object.Level)
                LvL = LvL + Object.Level
            end
        end
        return LvL
    end,
    GetAllEnemyLevels = function(self)
        local LvL = 0
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
            if Object.Team ~= myHero.Team then
                --print(Object.ChampionName, Object.Level)
                LvL = LvL + Object.Level
                --print(Object.Level)
            end
        end
        return LvL
    end,
    MinionExtraDmg = function(self, Minion)
        local myTeamLvL     = self:GetAllAllyLevels()
        local EnemyTeamLvl  = self:GetAllEnemyLevels()
        local Allies        = self:GetAllAllyHeros()
        local Enemies       = self:GetAllEnemyHeros()
        local AC            = #Allies
        local EC            = #Enemies
        local ExtraDmg      = 0
        local DmgReduction  = 0
        local LvLDiff       = (myTeamLvL / AC) - (EnemyTeamLvl / EC)
        if LvLDiff > 3 then
            LvLDiff = 3
        end
        --print(LvLDiff)
        local TowerDiff     = self:GetTowerDiff(Minion)
        local BuffType      = 0
        if GameClock.Time > 210 and EC > 0 then
            if LvLDiff > 0 then
                if TowerDiff < 0 then
                    TowerDiff = 0
                end
                ExtraDmg        = (5 + (5 * TowerDiff)) * LvLDiff
                BuffType        = 1
            end
            if LvLDiff < 0 then
                local EnemyLvlDiff = LvLDiff * -1
                if TowerDiff > 0 then
                    TowerDiff = 0
                end
                if TowerDiff < 0 then
                    TowerDiff = TowerDiff * -1
                end
                DmgReduction    =  1 + TowerDiff * EnemyLvlDiff
                BuffType        = 2
            end
        end
        return ExtraDmg, DmgReduction, BuffType
    end,
    DrawMinionTarget = function(self, Range)
        local EnemyMinions  = self:SortList(self:GetEnemyMinionsInRange(myHero.Position, Range), "MAXRANGE")
        local AllyMinions   = self:SortList(self:GetAllyMinionsInRange(myHero.Position, Range), "MAXRANGE")
        for _, Ally in pairs(AllyMinions) do
            local AllyPos = Ally.Position
            local Modifier  = Ally.AttackRange + Ally.CharData.BoundingRadius *2
            local MaxDirection = Vector3.new(AllyPos.x + (Ally.Direction.x*Modifier),AllyPos.y ,AllyPos.z + (Ally.Direction.z*Modifier))
            local Target = self:WillCollideWithMinion(Ally.Position, MaxDirection, 11, Ally)

            if Ally.AIData.TargetPos then
                local RawCheck = Ally.AIData.TargetPos
                local X = RawCheck.x
                local Y = RawCheck.y
                local Z = RawCheck.z
    
                local RawCheck2 = AllyPos
                local X2 = RawCheck2.x
                local Y2 = RawCheck2.y
                local Z2 = RawCheck2.z
                if Orbwalker:GetDistance(RawCheck, RawCheck2) <= Ally.CharData.BoundingRadius then
                    Render:DrawCircle(RawCheck2, 50 ,0,255,255,255)
                end
            end
            if Target then
                local Dist = Orbwalker:GetDistance(Target.Position, AllyPos)
                local TargetPos = Vector3.new(AllyPos.x + (Ally.Direction.x*Dist),AllyPos.y ,AllyPos.z + (Ally.Direction.z*Dist))
                local Start = Vector3.new()
                local End = Vector3.new()

                Render:World2Screen(AllyPos, Start)
                Render:World2Screen(TargetPos, End)


                Render:DrawLine(Start, End, 0,255,255,255)
                Render:DrawCircle(TargetPos, 15 ,0,255,255,255)
            end
        end
    end,
    PredictMinionHP = function(self, Minion)
        local EnemyMinions  = self:SortList(self:GetEnemyMinionsInRange(Minion.Position, 700), "MAXRANGE")
        local AllyMinions   = self:SortList(self:GetAllyMinionsInRange(Minion.Position, 700), "MAXRANGE")

        local BuffedDMG, Reduction, BuffType    = self:MinionExtraDmg(Minion)
        BuffedDMG = BuffedDMG - 1
        if BuffedDMG < 0 then
            BuffedDMG = 0
        end
        BuffedDMG = 1 + (BuffedDMG/ 100)

        local PlayerMissileSpeed                = myHero.AttackInfo.Data.MissileSpeed
        local PlayerAttackTime                  = self:GetPlayerAttackWindup()
        if myHero.ChampionName == "Jayce" then
            PlayerMissileSpeed = 2500
        end
        if myHero.AttackRange > 300 then
            PlayerAttackTime    = PlayerAttackTime + (Orbwalker.OrbRange/PlayerMissileSpeed)
        end
        local AttackSpeed                       = self:GetAttackSpeed()
        local TimeForDmg                        = PlayerAttackTime + 1 / self:GetAttackSpeed() --Rework this!
        local Damage    = 0
        local PossibleDmg = 0

        for _, Ally in pairs(AllyMinions) do
            --print(Ally.CharData.BoundingRadius)
            local AllyPos = Ally.Position
            local Modifier  = Ally.AttackRange + Ally.CharData.BoundingRadius *3
            local MaxDirection = Vector3.new(AllyPos.x + (Ally.Direction.x*Modifier),AllyPos.y ,AllyPos.z + (Ally.Direction.z*Modifier))
            local Target = self:WillCollideWithMinion(Ally.Position, MaxDirection, 15, Minion)

            if Target and Target.Index == Minion.Index then                
                local Source    = Ally
                local Speed	    = 1.25
                local AD        = 25 --(Source.BaseAttack + Source.BonusAttack) * BuffedDMG
                AD, Speed = self:GetMinionDmg(Source) --Hardcoded fix for minion dmg!
                --print(Source.ChampionName, AD, BuffedDMG)
                AD = AD * BuffedDMG
                Speed = 1 / Speed
                --print(Source.Level)
                local Attacks   = math.max(1, math.ceil(TimeForDmg / Speed))
                local Armor     = Minion.Armor
                Damage = Damage + ((AD * (100/(100+Armor))) * Attacks) - (Reduction * Attacks)
            else
                if Target == nil and Orbwalker:GetDistance(Minion.Position, Ally.Position) <= Ally.AttackRange + Ally.CharData.BoundingRadius *3 then
                    local Source    = Ally
                    local AD        = (Source.BaseAttack + Source.BonusAttack) * BuffedDMG
                    local Speed     = 1.25
                    AD, Speed = self:GetMinionDmg(Source)
                    AD = AD * BuffedDMG
                    local Armor     = Minion.Armor
                    PossibleDmg     = PossibleDmg + (AD * (100/(100+Armor))) - Reduction
                end
            end
        end
        return Damage, PossibleDmg, TimeForDmg
    end,
    GetLaneManagementList = function(self, Range)
        local LasthitList = {}
        local WaitList = {}
        local PrepareList = {}
        local PushList = {}
        local Turret    = nil
        local Minions   = self:SortList(self:GetEnemyMinionsInRange(myHero.Position, Range), "MAXRANGE")
        local WaitCondition3 = nil
        for _, Minion in pairs(Minions) do
            local AttackSpeed               = self:GetAttackSpeed()
            local PlayerDamage              = self:GetPlayerDamage(Minion) 
            --print(PlayerDamage)
            local IncomingDamage, HeroDamage, IncomingMissiles   = self:GetDamageBeforePlayer(Minion)
            IncomingDamage                          = IncomingDamage

            local PredictDmg, PossibleDmg, TimeForDmg   = self:PredictMinionHP(Minion)

            local ClearPredDmg = PredictDmg + HeroDamage --ADD HERO DMG???
            if PredictDmg < IncomingDamage then
                ClearPredDmg = IncomingDamage
            end
            local PredictedHP   = Minion.Health - ClearPredDmg

            if self:PlayerMissileOnTheWay(Minion) == false then
                --local PlayerDamage = self:GetPlayerDamage(Minion)
                --local IncomingDamage, HeroDamage, IncomingMissiles   = self:GetDamageBeforePlayer(Minion)

                --IncomingDamage                          = math.floor(IncomingDamage)
                if HeroDamage < Minion.Health or Minion.MaxHealth < 10 then
                    local CombinedDamage                    = PlayerDamage + IncomingDamage
                        
                    if CombinedDamage >= Minion.Health then --Minion can be lasthitted
                        self.MClearPredHP[Minion.Index] = PredictedHP
                        LasthitList[#LasthitList+1] = Minion
                    end

                    if Minion.Team == 300 then
                        self.MClearPredHP[Minion.Index] = PredictedHP
                        PushList[#PushList+1] = Minion
                    end 

                    Turret = self:CheckTurretAggro(Minion)
                    if Turret then
                        local Turret_AttackSpeed    = 0.83
                        local Player_AttackSpeed    = self:GetAttackSpeed()
                        local AttacksForPrepare     = math.max(1, math.floor(Player_AttackSpeed/Turret_AttackSpeed))
                        
                        local MinionHP_Percent      = (Minion.Health-IncomingDamage) / Minion.MaxHealth
                        local TurretDamage_Percent  = self:GetDamagePercentFromTurretToMinion(Turret, Minion)
                        local PlayerDamage_Percent  = PlayerDamage / Minion.Health
                        if TurretDamage_Percent then
                            local Turret_Shots          = MinionHP_Percent / TurretDamage_Percent
                            local Player_Shots          = MinionHP_Percent / PlayerDamage_Percent                        
                            local HP_AfterTurret        = (Minion.Health-IncomingDamage) - ((Minion.MaxHealth*TurretDamage_Percent)*math.floor(Turret_Shots))
                            local Delta                 = Turret_Shots / Player_Shots  
                            if HP_AfterTurret > PlayerDamage or Delta > 1 then
                                self.MClearPredHP[Minion.Index] = PredictedHP
                                LasthitList[#LasthitList+1] = Minion
                            end 
                        end
                    end      
                end
            end

            if not Turret then
                --local AttackSpeed               = self:GetAttackSpeed()
                --local PlayerDamage              = self:GetPlayerDamage(Minion)
                --print(0.5/AttackSpeed)
                if Minion.Health <= PlayerDamage then
                    self.MClearPredHP[Minion.Index] = PredictedHP
                    LasthitList[#LasthitList+1] = Minion
                end
    
                --local IncomingDamage, HeroDamage, IncomingMissiles   = self:GetDamageBeforePlayer(Minion)
                --IncomingDamage                          = math.floor(IncomingDamage)

                --local PredictDmg, PossibleDmg, TimeForDmg   = self:PredictMinionHP(Minion)
                --PredictDmg = math.floor(PredictDmg)
                --PossibleDmg = math.floor(PossibleDmg)
                --local ClearPredDmg = PredictDmg + HeroDamage --ADD HERO DMG???

                local AllyMinions               = self:GetAllyMinionsInRange(myHero.Position, 500)
                if #AllyMinions == 0 then
                    self.MClearPredHP[Minion.Index] = PredictedHP
                    PushList[#PushList+1] = Minion
                end

                --[[local WaitCondition1 = (IncomingDamage == 0 and Minion.Health - PlayerDamage < (PlayerDamage/AttackSpeed))
                local WaitCondition2 = (IncomingDamage > PlayerDamage and Minion.Health - CombinedDamage  < (PlayerDamage * 0.75))

                local WaitCondition3 = (Minion.Health - CombinedDamage >= 25 and Minion.Health - CombinedDamage <= 150)]]
                local PushCondition = (Minion.Health - (ClearPredDmg + PossibleDmg) >= ClearPredDmg + PossibleDmg + PlayerDamage) --ADD HERO DMG???
                local WaitCondition = (Minion.Health - ClearPredDmg <= PlayerDamage) --ADD HERO DMG???
                
                --print('condition', WaitCondition4 , " Current Health: " , Minion.Health , " Health After calculation: " , Minion.Health - PlayerDamage)
                --print('wait for lasthit ', self.WaitForLasthit)

                if WaitCondition and self.WaitForLastHitTimer == nil then
                    --print('waiting')
                    self.WaitForLastHitTimer = GameClock.Time + TimeForDmg
                else
                    if self.WaitForLastHitTimer and GameClock.Time > self.WaitForLastHitTimer then
                        self.WaitForLastHitTimer = nil
                    end
                end

                if WaitCondition then
                    self.MClearPredHP[Minion.Index] = PredictedHP
                    WaitList[#WaitList+1] = Minion
                end

                local WaitForPush = false
                if self.WaitForLastHitTimer ~= nil then
                    WaitForPush = true
                    if WaitCondition then
                        self.WaitMinion = Minion
                        --print(Minion.Name)
                    end
                end

                if self.WaitMinion and self.WaitMinion.IsDead == true then
                    self.WaitMinion = nil
                end
                --print(self.WaitForLastHitTimer / 60)
                if PushCondition and WaitForPush == false and self.FClearToggleOn == false then
                    --print('pushing!')
                    self.MClearPredHP[Minion.Index] = PredictedHP
                    PushList[#PushList+1] = Minion
                else
                    if self.FClearToggleOn == true then
                        self.MClearPredHP[Minion.Index] = PredictedHP
                        PushList[#PushList+1] = Minion
                    end
                end
            end
        end

        if #LasthitList == 0 then
            local Turrets = self:SortList(ObjectManager.TurretList, "MAXHP")
            for I, Turret in pairs(Turrets) do
                if Turret.Team ~= myHero.Team then
                    if self:GetDistance(myHero.Position, Turret.Position) < (Range + 55) then
                        if Turret.IsTargetable and Turret.IsInvincible == false then
                            return LasthitList, {Turret}
                        end
                    end
                end
            end

            local Inhibs = ObjectManager.InhibList
            for I, Inhib in pairs(Inhibs) do
                if Inhib.Team ~= myHero.Team then
                    if self:GetDistance(myHero.Position, Inhib.Position) < (Range + 200) then
                        if Inhib.IsTargetable and Inhib.IsInvincible == false then
                            return LasthitList, {Inhib}
                        end
                    end
                end
            end
        end

        local Nexuss = ObjectManager.NexusList
		for I, Nexus in pairs(Nexuss) do
			if Nexus.Team ~= myHero.Team then
				if self:GetDistance(myHero.Position, Nexus.Position) < (Range + 300) then
					if Nexus.IsTargetable and Nexus.IsInvincible == false then
                        return {Nexus}, {Nexus}
					end
				end
			end
		end

        if #WaitList > 0 then
            --print("MinionsWaiting: ", #WaitList)
        end

        if #LasthitList > 0 then
            return LasthitList, {}
        end

        if #PushList > 0 then 
            return LasthitList, PushList
        end

        return LasthitList, PushList
    end,
    Enable = function(self)
        self.Enabled = 1
    end,
    Disable = function(self)
        self.Enabled = 0
    end,
    --Kiting functions
    ActionReady = function(self)
        local Timer     = os.clock() - self.LastMoveTime
        if self.CustomAPM.Value == 0 then
            local APMTimer  = (60000 / Settings.ActionsPerMinute) / 1000
            return Timer > APMTimer
        end
        local APMMod        = 300
        if self.ApmModifier.Value > 0 then
            APMMod = self.ApmModifier.Value
        end

        local MinAPM        = self.ApmModifier.Value - self.MinimumAPM.Value
        local FightAPM      = 400
        if self.CombatAPM.Value > 0 then
            FightAPM = self.CombatAPM.Value
        end
                
        local RandomAPM     = math.random(MinAPM, APMMod)
        local APMTimer 		= (60000 / RandomAPM) / 1000
        if  self:GetTarget("COMBO", self.OrbRange + 120) and Engine:IsKeyDown("HK_COMBO") then
            APMTimer = (60000 / FightAPM) / 1000
         end

        if self:GetTarget("HARASS", self.OrbRange + 120) and Engine:IsKeyDown("HK_HARASS") then
            APMTimer = (60000 / FightAPM) / 1000
        end
        return Timer > APMTimer
    end,       
    GetPlayerAttackDelay = function(self)
        local AttackSpeed = self:GetAttackSpeed()
        local Delay = (1 / AttackSpeed) --1.0f/((PlayerAttackSpeed + 1.0f) * 0.658f);
        -- if myHero.ChampionName == "Kalista" and AttackSpeed > 2 then
        --     return Delay * (1 + AttackSpeed/15)
        -- end
        -- quicker AA after AA
        return Delay
    end,
    GetPlayerAttackWindup = function(self)
        local AttackTime 		    = self:GetPlayerAttackDelay()
        local WindupPercent 		= self.WindupPercent/100
        --print("WindupPercent: ", WindupPercent)
        local WindupModifier		= self.WindupMod
        --print("myHero.CharData.CastTimeMod: ", myHero.CharData.CastTimeMod)
        local BaseAttackSpeed       = myHero.CharData.BaseAttackSpeed
        local BonusAttackSpeed      = math.ceil((myHero.AttackSpeedMod - 1) * 100)
        local BaseWindupTime        = (1 / BaseAttackSpeed) * WindupPercent
        local Windup                = math.min(AttackTime, BaseWindupTime + ((AttackTime * WindupPercent) - BaseWindupTime) * WindupModifier)

        --[[if self.WindUpSlider.Value ~= 0 then
            return Windup * (self.WindUpSlider.Value / 100)
        end]]
        return Windup
    end,
    IsAutoAttackMissile = function(self, Name)
        if string.find(Name, "Attack", 1) ~= nil then
            return true
        end
        local Missiles = {}
        Missiles["Caitlyn"] 		= {"caitlynheadshotmissile"}
        Missiles["Ashe"] 			= {"frostarrow"}
        Missiles["Kennen"] 		    = {"kennenmegaproc"}
        Missiles["Quinn"] 			= {"quinnwenhanced"}
        Missiles["Vayne"] 			= {"vaynecondemn"}
        Missiles["Jhin"] 			= {"jhine"}
    
        local PossibleAutos = Missiles[myHero.ChampionName]
        if PossibleAutos then
            for i = 1, #PossibleAutos do
                if Name:lower() == PossibleAutos[i] then
                    return true
                end
            end
        end
        return false
    end,   
    IsSpecialAttack = function(self, Name)
        local Autos = {}
        Autos["MasterYi"] 		= {"masteryidoublestrike"}
        Autos["Garen"] 			= {"garenslash2"}
        --Autos["Kennen"] 		= {"kennenmegaproc"}
        Autos["Renekton"] 		= {"renektonexecute", "renektonsuperexecute"}			
        Autos["Vayne"] 			= {"vaynecondemn"}
        Autos["Jhin"] 			= {"jhine"}
        Autos["Rengar"] 		= {"rengarnewpassivebuffdash"}
        Autos["Trundle"] 		= {"trundleq"}
        Autos["XinZhao"] 		= {"xinzhaoqthrust1","xinzhaoqthrust2","xinzhaoqthrust3"}
        Autos["Pantheon"] 		= {"pantheoneshieldslam"}
        Autos["Viktor"] 		= {"viktorqbuff"}
    
        local PossibleAutos = Autos[myHero.ChampionName]
        if PossibleAutos then
            for i = 1, #PossibleAutos do
                if Name:lower() == PossibleAutos[i] then
                    return true
                end
            end
        end
        return false
    end,  
    CanLasthit = function(self, Target)
        local IncomingDamage		= 0
        local TargetArmorMod 		= 100 / (100 + Target.Armor)
        local PlayerDamage 			= myHero.BaseAttack + myHero.BonusAttack + self.ExtraDamage
        --print(PlayerDamage)
        if myHero.ChampionName == "Zeri" then
            PlayerDamage = 4 * 15 + (4 * 25 / 17) * (self:GetPlayerLevel() - 1) * (0.7025 + 0.0175 * (self:GetPlayerLevel() - 1))
        end
        local PlayerMissileSpeed	= myHero.AttackInfo.Data.MissileSpeed
        if myHero.ChampionName == "Jayce" then
            PlayerMissileSpeed = 2500
        end
        if myHero.ChampionName == "Aphelios" then
            --print(1)
            if myHero.BuffData:GetBuff("ApheliosGravitumManager").Valid then
                PlayerMissileSpeed = 400
                Orwalker.ExtraDamage = 0
            end
            if myHero.BuffData:GetBuff("ApheliosSeverumManager").Valid then --ApheliosInfernumManager
                PlayerMissileSpeed = 0
                Orwalker.ExtraDamage = 0
            end
            if myHero.BuffData:GetBuff("ApheliosInfernumManager").Valid then --ApheliosInfernumManager
               --Print("RED")
                PlayerMissileSpeed = 450
                Orwalker.ExtraDamage = (myHero.BaseAttack + myHero.BonusAttack) * 0.1
            end
        end
        if myHero.AttackRange < 300 then
            PlayerMissileSpeed 		= math.huge
        end
        local PlayerDistance		= math.max(0, self:GetDistance(myHero.Position, Target.Position) - myHero.CharData.BoundingRadius) -- Player Missiles doesnt spawn directly at center of champ, so distance is a bit shorter -> wait a bit longer to shoot
        local PlayerTime			= (PlayerDistance/PlayerMissileSpeed) + self.Windup
        --print(PlayerMissileSpeed)
        local Minions  = ObjectManager.MinionList
        local Missiles = ObjectManager.MissileList
    
        local MissileFilter = {}
        for I,Object in pairs(ObjectManager.MissileList) do
            local Index 	= Object.Index
            local Name		= Object.Name
            if Index > 0 and Index < 3500 and string.len(Name) > 0 and MissileFilter[Index] == nil then
                MissileFilter[Index] = Object
            end
        end
    
        for I,Missile in pairs(MissileFilter) do
            local SourceID				= Missile.SourceIndex
            local TargetID				= Missile.TargetIndex
            local MissileSource			= nil
            local MissileTarget			= nil
            if SourceID > 0 and SourceID < 3500 then
                MissileSource 			= Minions[SourceID]
            end
            if TargetID > 0 and TargetID < 3500 then
                MissileTarget 			= Minions[TargetID]
            end
            if I == Missile.Index and MissileTarget and MissileSource and MissileSource.IsMinion and MissileSource.IsDead == false and MissileSource.AttackRange > 300 then
                local MissileDistance		= self:GetDistance(Missile.Position, Target.Position)
                if MissileDistance > 0 and MissileTarget.Index == Target.Index and Missile.Team == myHero.Team then
                    local MissileDamage 	= (MissileSource.BaseAttack * TargetArmorMod)
                    local MissileTime		= MissileDistance / 650
                    if MissileTime < PlayerTime then
                        IncomingDamage 		= IncomingDamage + MissileDamage
                    end
                end
            end
        end
        IncomingDamage = (IncomingDamage + (PlayerDamage * TargetArmorMod) + self.ExtraDamage)
        if IncomingDamage > Target.Health then
            return true
        end
        return false
    end,
    GetPlayerMissiles = function(self)
        local Missiles = self:GetAllAllyMissiles()
        local PlayerMissiles = {}

        for _, Missile in pairs(Missiles) do
            local TargetID = Missile.TargetIndex
            local SourceID = Missile.SourceIndex
            if SourceID == myHero.Index and TargetID then
                PlayerMissiles[#PlayerMissiles+1] = Missile 
            end
        end
        return PlayerMissiles
    end,
    CanAttackReset = function(self)
        --myHero.BuffData:ShowAllBuffs()
        --print(myHero.ActiveSpell.Info.Name)
        local AAResets = {}
        -- all AA resets that aren't working properly should be adjust in the champion script like so:
        -- When casting the ability check if Orbwalker.ResetReady == 1
        AAResets["Aatrox"] 	    = {"AatroxE"}
        AAResets["Blitzcrank"] 	= {"powerfist"}
        AAResets["Camille"] 	= {"CamilleQ"}
        AAResets["Chogath"] 	= {"VorpalSpikes"}
        AAResets["Darius"] 		= {"dariusnoxiantacticsonh", "DariusNoxianTacticsONH"}
        AAResets["DrMundo"] 	= {"DrMundoE"}		
        --AAResets["Ekko"] 	    = {"EkkoE"} resetready check in its own script
        AAResets["Elise"] 	    = {"EliseSpiderW"}		
        AAResets["Fiora"] 		= {"fioraflurry"}	
        AAResets["Fizz"] 		= {"FizzW"}	
        AAResets["Hecarim"] 	= {"hecarimrapidslash", "hecarimrampspeed"}		
        AAResets["Gangplank"] 	= {"parley", "GangplankQProceed"}
        -- couldn't test rengar
        AAResets["Rengar"] 		= {"rengarq", "rengarqemp"}		
        --AAResets["Samira"] 		= {"SamiraPJuggle"}	
        AAResets["Sivir"] 		= {"sivirwmarker"}		
        AAResets["Garen"] 		= {"garenq"}		
        --illaoi
        AAResets["Jax"] 		= {"jaxempowertwo"}		
        AAResets["Jayce"] 		= {"jaycehypercharge"}		
        AAResets["Kassadin"] 	= {"netherblade"}
        AAResets["Kayle"] 	    = {"kaylee"}
        AAResets["Kindred"]     = {"kindredqasbuff"}		
        AAResets["Leona"] 		= {"leonashieldofdaybreak"}		
        AAResets["Lucian"]      = {"lucianpassivebuff"}
        AAResets["Malphite"]    = {"MalphiteThunderclap"}
        -- doesn't work like that, need to adjust
        -- AAResets["Maokai"]      = {"maokaipassiveready"}
        AAResets["MasterYi"] 	= {"Meditate"}		
        AAResets["Nasus"] 		= {"nasusq"}		
        AAResets["Nidalee"] 	= {"takedown"}
        AAResets["Nilah"] 	    = {"NilahE"}
        AAResets["Olaf"] 	    = {"OlafFrenziedStrikes"}
        AAResets["Pantheon"]    = {"OlafFrenziedStrikes"}	
        AAResets["Mordekaiser"]	= {"mordekaisermaceofspades"}		
        AAResets["Poppy"] 		= {"poppydevastatingblow"}
        -- does not work as intended either
        -- AAResets["RekSai"] 		= {"RekSaiQAttack", "RekSaiQAttack2", "RekSaiQAttack3"}
        AAResets["Renekton"] 	= {"renektonpreexecute", "RenektonExecute"}
        --rengar
        --samira
        AAResets["Sejuani"] 	= {"SejuaniE2"}
        AAResets["Sett"] 	    = {"SettQ"}
        AAResets["Shyvana"] 	= {"ShyvanaDoubleAttack"}
        AAResets["Sivir"] 	    = {"SivirW"}
        AAResets["Sona"] 	    = {"SonaEPassiveAttack"}
        AAResets["Talon"] 		= {"TalonQAttack"}
        AAResets["Trundle"] 	= {"TrundleQ", "TrundleTrollSmash"}
        AAResets["Vayne"] 		= {"vaynetumblebonus"}
        AAResets["Vi"] 			= {"vie"}
        AAResets["Viego"] 		= {"viegowdash"}
        -- AAResets["Volibear"] 	= {"VolibearQ"} NEED Q resetready check in its own script
        -- wukong needs Q ResetReady check in its own script
        AAResets["MonkeyKing"] 	= {"MonkeyKingDoubleAttack"}	
        AAResets["XinZhao"] 	= {"XinZhaoQ"}
        AAResets["Yorick"] 		= {"yorickspectral", "yorickqbuff"}
        AAResets["Zac"] 		= {"ZacQ"}
        --zeri doesnt show E in printing..
        --zoe
        AAResets["Riven"] 		= {"RivenTriCleave"}
    
        local PossibleBuffs = AAResets[myHero.ChampionName]
        if PossibleBuffs then
            for i = 1, #PossibleBuffs do
                local Buffname = PossibleBuffs[i]
                local Buff = myHero.BuffData:GetBuff(Buffname)
                if Buff.Count_Alt > 0 and Buff.Valid == true and (GameClock.Time - Buff.StartTime) < 0.125 then -- used to be 0.1 need to test
                    return true
                end
            end	
        end

        if myHero.ChampionName == "Ashe" then
            local Buff = myHero.BuffData:GetBuff("AsheQ")
            local QBuff = myHero.BuffData:GetBuff("AsheQAttack").Valid
            if Buff ~= nil and Buff.Count_Alt == 0 and QBuff and GameClock.Time - Buff.StartTime < 0.085 then
                return true
            end
        end

        if myHero.ChampionName == "Aphelios" then
            local Crescendum = myHero.BuffData:GetBuff("ApheliosCrescendumManager")
            local Crescendum_Valid = Crescendum.Valid or Crescendum.Count_Alt > 0
            if Crescendum_Valid then
                if Aphelios:CresReset() == true then
                    return true
                end
            end
        end
        if myHero.ChampionName == "Katarina" then
            local KataE = "KatarinaE"
            if myHero.ActiveSpell.Info.Name == KataE then
                return true
            end
        end
        DashResets = { "Lucian", "Riven", "Vayne", "Belveth", "Graves" }
        for _, DashChampName in pairs(DashResets) do
            if myHero.ChampionName == DashChampName and myHero.AIData.Dashing then
                return true
            end
        end
        return false
    end,
    HasNoMissiles = function(self)
        if myHero.AttackRange < 300 then return true end

        local NoMissileRanged = {"Senna", "Kayle"}
        for _, Name in pairs(NoMissileRanged) do
            if myHero.ChampionName == Name then
                return true
            end
        end
        return false
    end,
    ResetTimers = function(self)
        self.Windup         = 0
        self.Attack         = 0
        self.ResetReady     = 0
        self.AttackTimer    = 0
        self.WindupTimer    = 0
    end,
    ManageAttackTimer = function(self)
        local WindupTime        = os.clock() - self.WindupTimer
        local AttackTime        = os.clock() - self.AttackTimer
        
        if (myHero.CharacterState&1 == 0 or myHero.AIData.Dashing) and myHero.ChampionName ~= "Kalista" then
            self:ResetTimers()
            return  
        end
        if self.Windup == 1 then
            self.WindupTimer = os.clock()
            local WindupCheck = (AttackTime > self.LastWindup*2)
            if string.len(myHero.ActiveSpell.Info.Name) == 0 and ((self.PrevTarget and (self.PrevTarget.IsDead or self.PrevTarget.IsTargetable == false)) or WindupCheck) then
                self:ResetTimers()
            end    
        end
        if string.len(myHero.ActiveSpell.Info.Name) > 0 then
            if self.Windup == 1 then 
                self.ResetReady     = 1

                if myHero.ChampionName ~= "Kalista" then
                    if myHero.ChampionName == "Zeri" then
                        self.AttackTimer     = self.WindupTimer
                    else
                        self.AttackTimer     = self.WindupTimer - math.min(0.2, self.LastWindup*2)
                    end
                else
                    if self:GetAttackSpeed() <= 2.5 then
                        self.AttackTimer = self.WindupTimer + (GameHud.Ping/2000)
                    end
                end
            end
            self.Windup         = 0
        end
        --print(self.Attack, self.Windup, self.AttackTimer, self.WindupTimer, os.clock())
    end,    
    CanAttack = function(self)
        local DashCheck         = myHero.AIData.Dashing == false or myHero.ChampionName == "Kalista"
        local TimerCheck        = (os.clock() - self.AttackTimer) > self:GetPlayerAttackDelay()
        local LevelCheck        = (self.BlockAALevel.Value == 0 or self:GetPlayerLevel() < self.BlockAALevel.Value)
        local EvadeCheck        = (self.BlockAttack == 0 or self.BlockAttackForDodge.Value == 0)
        local ChannelCheck      = (myHero.CharacterState&1) == 1 and string.len(myHero.ActiveSpell.Info.Name) == 0
        if self.DontAA == 1 then
            return nil
        end
        if myHero.ChampionName == "Riven" then
            if myHero.AIData.Moving == true and myHero.AIData.Dashing == false and (GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundone").StartTime > 0 and GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundone").StartTime < 0.8) or (GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundtwo").StartTime > 0 and GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundtwo").StartTime < 0.8) or (GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundthree").StartTime > 0 and GameClock.Time - myHero.BuffData:GetBuff("riventricleavesoundthree").StartTime < 0.8) then
                return true
            end
            if myHero.ActiveSpell.Info.Name == "RivenMartyr" then
                --print("WYT")
                self.RivenWTimer = os.clock()
            end
            --print(os.clock() - self.WTimer)
            if myHero:GetSpellSlot(0).Charges ~= 0 and self.RivenWTimer ~= nil then
                if (os.clock() - self.RivenWTimer) > 0 and (os.clock() - self.RivenWTimer) < self.LastWindup then
                    return true
                end
            end
        end
        if myHero.ChampionName == "Samira" then
            local SamiraP = myHero.BuffData:GetBuff("SamiraPJuggle").Valid --samirapcooldown
            if not SamiraP and self.DrawTarget ~= nil and self.DrawTarget.IsHero then
                local Stun 					= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Stun) == true
                local Suppress 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Suppression) == true
                local Taunt 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Taunt) == true
                local Knockup 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Knockup) == true
                local Knockback 			= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Knockback) == true
                local Snare 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Snare) == true
                local Charm 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Charm) == true
                local Asleep 				= self.DrawTarget.BuffData:HasBuffOfType(BuffType.Asleep) == true
                local PassiveCD             = self.DrawTarget.BuffData:GetBuff("samirapcooldown").Valid --samirapcooldown
                local CCd = Stun or Suppress or Taunt or Knockup or Knockback or Snare or Charm or Asleep
                if not PassiveCD and CCd then
                    print("SamiraPassiveAttack")
                    return true
                end
            end
        end
        return (DashCheck and LevelCheck and EvadeCheck) and (self:CanAttackReset() or (TimerCheck and (ChannelCheck or myHero.ChampionName == "Kalista")))
    end,
    CanMove = function(self, Target)
        local AttackSpeed       = self:GetAttackSpeed()
        local TimerCheck        = (self.Attack == 1 and ((os.clock() - self.WindupTimer) > self.LastWindup or myHero.ChampionName == "Kalista" or myHero.ActiveSpell.WindupIsFinished)) 
        local ClickerCheck      = (self.Attack == 0 and self:ActionReady())
        local EvadeCheck        = (self.BlockAttack == 1 and self.BlockAttackForDodge.Value == 1)

        --[[local CritCheck = string.find(myHero.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(myHero.ActiveSpell.Info.Name, "crit") ~= nil
        local NotAttacking = myHero.ActiveSpell.Info.Name == ""
        --print("GameClock.Time", math.floor(GameClock.Time))
        if myHero.CritChance > 0 then
            --print(CritCheck)
            print(NotAttacking)
            print(CritCheck)
            --print(self:GetAttackSpeed())
            if CritCheck or NotAttacking then
                --print("CritAttack")
                return true
            else
                --print("WaitforCrit")
                return false
            end
        end]]
        return TimerCheck or ClickerCheck or EvadeCheck 
    end,
    IssueAttack = function(self, Position, Target)
        self.Attack         =   1
        self.Windup         =   1
        self.ResetReady     =   0
        self.LastWindup     =   self:GetPlayerAttackWindup()
        self.LastDelay      =   self:GetPlayerAttackDelay()            
        local ChampsOnlyClick = 0
        if Target and Target.IsHero == true then
            ChampsOnlyClick = 1
        end
        self.LastClick      =   os.clock()

        --print(Target.Name, Target.CharacterState)
        self.PrevTarget     = Target            
        if myHero.ChampionName == "Zeri" then
            local passive = myHero.BuffData:GetBuff("zeriqpassiveready")
            if passive.Valid then
                Engine:AttackClick(Position, ChampsOnlyClick)
            else
                if Engine:SpellReady("HK_SPELL1") then
                    Engine:CastSpell("HK_SPELL1", Position, ChampsOnlyClick)
                end
            end
        else
            Engine:AttackClick(Position, ChampsOnlyClick)
        end
        self.WindupTimer    =   os.clock()
        self.AttackTimer    =   os.clock()
    end,
    IssueMove = function(self, Position)
        self.Attack         = 0
        self.PrevTarget     = nil            
        self.LastMoveTime   = os.clock()
        local HoldRadius = self.HoldRadius.Value
        if myHero.ChampionName == "Kalista" then
            HoldRadius = 0
        end
        if Position then
            if self:GetDistance(myHero.Position, Position) > HoldRadius then
                Engine:MoveClick(Position)
            end
		else
            if self:GetDistance(myHero.Position, GameHud.MousePos) > HoldRadius then
                Engine:MoveClick(nil)
            end
        end
    end,
    Orbwalk = function(self, Target)        
        self.DrawTarget = Target
        if self:CanMove(Target) then
            if Target and self:CanAttack() then
                self:IssueAttack(Target.Position, Target)
                if myHero.ChampionName ~= "Kalista" then return end
            end
            return self:IssueMove(self.MovePosition)
        end    
    end,
    --Feature functions
    TargetIsImmune = function(self, currentTarget)
        local ImmuneBuffs = {
            "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "PantheonE", "sionpassivezombie", "ChronoShift"
        }
        --print(currentTarget.BuffData:ShowAllBuffs())
        for i = 1, #ImmuneBuffs do
            local Buff = ImmuneBuffs[i]
            if currentTarget.BuffData:GetBuff(Buff).Valid then
                if currentTarget.BuffData:GetBuff("KindredRNoDeathBuff").Valid then
                    local hpPercent = 100 * currentTarget.Health / currentTarget.MaxHealth
                    if hpPercent < 14 or currentTarget.Health < (currentTarget.MaxHealth * 0.1 + myHero.BaseAttack + myHero.BonusAttack) * 2.1 or currentTarget.Health < (currentTarget.MaxHealth * 0.1 + myHero.AbilityPower * 1.5) then
                        return true -- Immune
                    else
                        return false
                    end
                elseif currentTarget.BuffData:GetBuff("UndyingRage").Valid or currentTarget.BuffData:GetBuff("ZileanR").Valid then
                    local hpPercent = 100 * currentTarget.Health / currentTarget.MaxHealth
                    if hpPercent < 6 or currentTarget.Health < (myHero.BaseAttack + myHero.BonusAttack) * 2.1 or currentTarget.Health < myHero.AbilityPower * 1.5 then
                        return true  -- Immune
                    else
                        return false
                    end
                elseif currentTarget.BuffData:GetBuff("PantheonE").Valid then
                    local TargetPos = currentTarget.Position
                    local Modifier  = 100
                    local EPos   = Vector3.new(TargetPos.x + (currentTarget.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (currentTarget.Direction.z*Modifier))
                    if EPos and self:GetDistance(myHero.Position, currentTarget.Position) > self:GetDistance(myHero.Position, EPos) then
                        return true  -- Immune
                    else
                        return false
                    end
                end
                return true
            end
        end
        return false
    end,
    EnemiesInRange = function(self, Position, Range)
        local count = 0
        for _,Hero in pairs(ObjectManager.HeroList) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                if Orbwalker:GetDistance(Hero.Position , Position) < Range then
                    count = count + 1			
                end
            end
        end
        return count
    end,
    IsCannonAboutToDie = function(self, LasthitList)
        for i, Minion in pairs(LasthitList) do
            if not Minion.IsDead and Minion.IsTargetable and self:GetDistance(myHero.Position, Minion.Position) <= 800 then
                if Minion.ChampionName == "SRU_ChaosMinionSiege" or Minion.ChampionName == "SRU_OrderMinionSiege" and self.MClearPredHP[Minion.Index] then
                    if self.MClearPredHP[Minion.Index] <= (myHero.BaseAttack + myHero.BonusAttack) then
                        return true
                    end
                end
            end
        end
        return false
    end,
    IsMinionAboutToDie = function(self, Minion)
        if not Minion.IsDead and Minion.IsTargetable and self:GetDistance(myHero.Position, Minion.Position) <= 800 then
            if Minion.Health <= (myHero.BaseAttack + myHero.BonusAttack) * 1.25 then
                return true
            end
        end
        return false
    end,
    GetTarget = function(self, Mode, Range)
        Mode = Mode:upper() --old champ script compatible
        local HarassPrio = 0
        if self.PrioChampHarass.Value == 1 and self:EnemiesInRange(myHero.Position, Orbwalker.OrbRange+5) >= 1 then
            HarassPrio = 1
        end
        if Mode == "LASTHIT" or (Mode == "HARASS" and self.SupportMode.Value == 0 and HarassPrio == 0) then --LASTHIT OVER CHAMPION HARASS
            local LasthitList, PushList = self:GetLaneManagementList(Range)
            LasthitList     = self:SortList(LasthitList, "CLEAR_LAST")
            PushList        = self:SortList(PushList, "CLEAR_PUSH")
            --print(#PushList)
            if LasthitList[1] then
                return LasthitList[1]
            end
        end
        if Mode == "COMBO" or Mode == "HARASS" then
            local TargetList = self:GetTargetSelectorList(myHero.Position, Range)
            return TargetList[1] 
        end
        if Mode == "LANECLEAR" then
            local LasthitList, PushList = self:GetLaneManagementList(Range)
            LasthitList     = self:SortList(LasthitList, "CLEAR_LAST")
            PushList        = self:SortList(PushList, "CLEAR_PUSH")
            local JungleMinions, OffAggro = self:GetJungleMinionsInRange(myHero.Position, Range)
            if #JungleMinions > 0 and OffAggro == nil then
                --print("WTF")
                PushList = self:SortList(JungleMinions, "MAXHP")
                LasthitList = self:SortList(JungleMinions, "MAXHP")
            end
            if LasthitList[1] then
                return LasthitList[1]
            end
            --print(#PushList)
            return PushList[1]              
        end
        return nil
    end,
    GetClosestToMouse = function(self, List) 
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end
        for left = 1, #CurrentList do  
            for right = left+1, #CurrentList do    
                if self:GetDistance(GameHud.MousePos, CurrentList[left].Position) > self:GetDistance(GameHud.MousePos, CurrentList[right].Position) then    
                    local Swap = CurrentList[left] 
                    CurrentList[left] = CurrentList[right] 
                    CurrentList[right] = Swap
                end
            end
        end
        return CurrentList[1]    
    end,
    GetForceTarget = function(self)
        --[[self.ForceTarget = nil
        local Object = Engine:GetForceTarget()
        if Object and Object.IsHero and Object.Team ~= myHero.Team then
            self.ForceTarget = Object
        end]]

        if Engine:IsKeyDown("HK_FORCETARGET") then
            local Enemy = self:GetClosestToMouse(self:GetEnemyHerosInRange(GameHud.MousePos, 100))
            if Enemy then
                self.ForceTarget = Enemy
                return
            end
            local Minion = self:GetClosestToMouse(self:GetEnemyMinionsInRange(GameHud.MousePos, 100)) 
            if Minion then
                self.ForceTarget = Minion
                return
            end
            self.ForceTarget = nil
        end
    end,
    CheckBuffCount = function(self, Target)
        local BuffCount = 0
        local WBuff_Check = Target.BuffData:GetBuff("CaitlynWSnare").Count_Alt > 0
        local EBuff_Check = Target.BuffData:GetBuff("CaitlynEMissile").Count_Alt > 0
        if EBuff_Check then
            self.ETimer 	= os.clock()
        end
        if WBuff_Check and EBuff_Check == false then
            BuffCount = 1
        end
        if EBuff_Check and WBuff_Check == false then
            BuffCount = 1
        end
        if (EBuff_Check and WBuff_Check) or WBuff_Check and ((os.clock() - self.ETimer) < 2.5 and (os.clock() - self.ETimer) > 0) then
            BuffCount = 2
        end
        return BuffCount
    end,
    GetSummonerKey = function(self, SummonerName)
        for i = 4 , 5 do
            if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
                return self.KeyNames[i], i
            end
        end
        return nil
    end,

    Safe_FlashV2 = function(self)

        local OurSlot = nil
        local OurKey = nil

        if self.UseSafeFlash.Selected == 1 then
            OurSlot = 4
            OurKey = self.KeyNames[4]
        else
            OurSlot = 5
            OurKey = self.KeyNames[5]
        end

        if OurSlot ~= nil and OurKey ~= nil then
            local SpellReady = GameClock.Time >= myHero:GetSpellSlot(OurSlot).Cooldown
            local CurrentSummonerSpell = myHero:GetSpellSlot(OurSlot).Info.Name
            if Engine:IsKeyDown("HK_ITEM6") then
                if CurrentSummonerSpell ~= "SummonerFlashPerksHextechFlashtraptionV2" then
                    if SpellReady then
                        return Engine:ReleaseSpell(OurKey, nil)
                    end
                end
            end
    
            if CurrentSummonerSpell == "SummonerFlashPerksHextechFlashtraptionV2" then -- We have hexflash
                if Engine:IsKeyDown("HK_ITEM6") then
                    if myHero:GetSpellSlot(OurSlot).StartTime > 0 then
                        return
                    end
                    if SpellReady then
                        return Engine:ChargeSpell(OurKey, nil)
                    end
                else
                    if myHero:GetSpellSlot(OurSlot).StartTime > 0 then
                        return Engine:ReleaseSpell(OurKey, nil)
                    end
                end
            end
        end
    end,

    GetCaitlynHeadshotTarget = function(self)
        local Heros = self:SortList(ObjectManager.HeroList, "LOWHP")
        for _, Hero in pairs(Heros) do
            --Hero.BuffData:ShowAllBuffs()
            if Hero.Team ~= myHero.Team and Hero.IsTargetable == true then
                if self:GetDistance(Hero.Position, myHero.Position) <= 1300 then --CaitlynEMissile --eternals_caitlyneheadshottracker
                    --print(self:CheckBuffCount(Hero))
                    if #self.CaitHSCounts < self:CheckBuffCount(Hero) then 
                        return Hero
                    end
                end
            end
        end
        return nil    
    end,
    CresOnWayCheck = function(self)
        local CresMissileName = "ApheliosCrescendumAttackMisInMini"
        local MissileList = ObjectManager.MissileList
        for _, Missile in pairs(MissileList) do
            --print(Missile.Name)
            if Missile.Name == CresMissileName and Missile.Team == myHero.Team then
                return true
            end
        end
        return false
    end,
    GetApheliosSniperTarget = function(self) --aphelioscalibrumbonusrangedebuff
        local Heros = self:SortList(ObjectManager.HeroList, "LOWHP")
        for _, Hero in pairs(Heros) do
            --Hero.BuffData:ShowAllBuffs()
            if Hero.Team ~= myHero.Team and Hero.IsTargetable == true then
                local RangedBuff = Hero.BuffData:GetBuff("aphelioscalibrumbonusrangedebuff")
                local RangedBuffValid = RangedBuff.Valid or RangedBuff.Count_Alt > 0
                if RangedBuffValid then 
                    local Missiles = Orbwalker:GetAllAllyMissiles()
                    for _, Missile in pairs(Missiles) do
                        local SourceID = Missile.SourceIndex
                        local TargetID = Missile.TargetIndex
                        if SourceID == myHero.Index and TargetID == Hero.Index then
                            return nil
                        end
                    end
                    if self:CresOnWayCheck() == true then return nil end
                    if self:GetDistance(Hero.Position, myHero.Position) <= 1800 then --CaitlynEMissile --eternals_caitlyneheadshottracker
                        --print(self:CheckBuffCount(Hero))
                        return Hero
                    end
                end
            end
        end
        return nil    
    end,
    GetTristanaBombTarget = function(self)
        local Heros = self:SortList(ObjectManager.HeroList, "LOWHP")
        for _, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable == true then
                if self:GetDistance(Hero.Position, myHero.Position) <= self.OrbRange then
                    if Hero.BuffData:GetBuff("tristanaecharge").Count_Alt > 0 then
                        return Hero
                    end
                end
            end
        end
        return nil    
    end,
    GetTeamHasGP = function(self)
        if self.TeamHasGP == nil then
            local Allys = self:GetAllAllyHeros()
            for _, Ally in pairs(Allys) do
                if Ally.ChampionName == "Gangplank" then self.TeamHasGP = true return end
            end
            self.TeamHasGP = false
        end
    end,
    GetAttackRange = function(self)
        if myHero.ChampionName == "Zeri" or myHero.ChampionName == "Sion" or myHero.ChampionName == "Annie" then
            if myHero.ChampionName == "Zeri" then
                local passive = myHero.BuffData:GetBuff("zeriqpassiveready")
                if passive.Valid then
                    self.OrbRange = myHero.AttackRange + myHero.CharData.BoundingRadius
                else
                    self.OrbRange = (825 - myHero.AttackRange) + myHero.AttackRange + myHero.CharData.BoundingRadius
                end
            end
            if myHero.ChampionName == "Sion" then
                self.OrbRange = 175 + myHero.CharData.BoundingRadius + 20
            end
            if myHero.ChampionName == "Annie" then
                self.OrbRange = myHero.AttackRange + myHero.CharData.BoundingRadius - 75
            end
        else
            --[[if self.ForceTarget == nil then
                -- added - 33, 1/3 of teemo size. to counter sticky movement when enemy outside of AA range already. might need more if more cases are reported
                self.OrbRange = myHero.AttackRange + myHero.CharData.BoundingRadius
            else
                self.OrbRange = myHero.AttackRange + myHero.CharData.BoundingRadius +55
            end]]
            self.OrbRange = myHero.AttackRange + myHero.CharData.BoundingRadius
        end
        --[[local LethalTempo		= myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Precision/LethalTempo/LethalTempo.lua")
        local Stacks			= LethalTempo.Count_Int
        if self.OrbRange >= 300 then
            if Stacks >= 6 then
                self.OrbRange = self.OrbRange + 50
            end
        else
            if Stacks >= 6 then
                self.OrbRange = self.OrbRange + 50
            end
        end]]
    end,
    Sieve = function(self, x)
        if x < 2 then 
            return false
         end
       
         -- Assume all numbers are prime until proven not-prime.
         local prime = {}
         prime[1] = false
         for i = 2, x do 
             prime[i] = true 
         end 
       
         -- For each prime we find, mark all multiples as not-prime.
         for i = 2, math.sqrt(x) do
             if prime[i] then
                for j = i*i, x, i do
                    prime[j] = false
                end
             end
         end
       
         return prime
    end,
    ToggleFClear = function(self)
        if Engine:IsKeyDown("HK_LASTHIT") and Engine:IsKeyDown("HK_LANECLEAR") and os.clock() - self.ToggleTimer > 0.5 and self.FClearToggleOn == false then
            self.ToggleTimer = os.clock()
            self.FClearToggleOn = true
        end
        if Engine:IsKeyDown("HK_LASTHIT") and Engine:IsKeyDown("HK_LANECLEAR") and os.clock() - self.ToggleTimer > 0.5 and self.FClearToggleOn == true then
            self.ToggleTimer = os.clock()
            self.FClearToggleOn = false
        end
        --print("Toggle on:", self.FlashToggleOn)
    end,
    OnTick = function(self)
        if myHero.AttackInfo.Data.MissileSpeed ~= 2000 then
            --print("WTF")
        end
        --print(myHero:GetSpellSlot(6).Info.Name)
        --print(myHero.Level)
        --myHero.BuffData:ShowAllBuffs()
        -- local test = myHero.BuffData:GetBuff("zhonyasringshield")
        --print(test.Count_Alt)
        --self:TargetsLane(myHero)
        --print(self:GetTowerDiff(myHero))
        --self:MinionExtraDmg(myHero)
        self.DrawTarget = nil
        self:ToggleFClear()
        self:GetTeamHasGP()
        self:GetForceTarget()
        self:GetChampionPrios()
        self:SetUpChampionWindup()
        self:ManageAttackTimer()
        if GameHud.Minimized == false and GameHud.ChatOpen == false and self.Enabled == 1 then

            if self.UseSafeFlash.Selected > 0 then
                self:Safe_FlashV2()
            end

            self:GetAttackRange()
            if Engine:IsKeyDown("HK_FLEE") then
                if self:CanMove() then
                    return self:IssueMove(self.MovePosition)    
                end                
            end
            if Engine:IsKeyDown("HK_COMBO") then
                local Target = nil
                if myHero.ChampionName == "Caitlyn" then
                    self.count = 1
                    local Missiles = Orbwalker:GetAllAllyMissiles()
                    for _, Missile in pairs(Missiles) do
                        local SourceID = Missile.SourceIndex
                        if SourceID == myHero.Index and Missile.Name == "CaitlynPassiveMissile" then
                            --print(Missile.Name)
                            if ((os.clock() - self.CaitHSTimer) > 0.5 or (os.clock() - self.CaitHSTimer) < 0) then
                                self.CaitHSTimer 	= os.clock()
                                table.insert(self.CaitHSCounts, self.count)
                            end
                        end
                    end
                    if (os.clock() - self.CaitHSTimer) > 2 then
                        table.remove(self.CaitHSCounts, self.count)
                    end
                    Target = self:GetCaitlynHeadshotTarget()
                end
                if myHero.ChampionName == "Aphelios" then
                    Target = self:GetApheliosSniperTarget()
                end
                if myHero.ChampionName == "Tristana" then
                    Target = self:GetTristanaBombTarget()
                end
                if Target == nil then
                    Target = self:GetTarget("COMBO", self.OrbRange)
                end
                --local CritCheck = self:GetAttackSpeed() / myHero.CritChance * (GameClock.Time +0.25)
                --CritCheck = math.floor(CritCheck)
                --[[local CritCheck = string.find(myHero.ActiveSpell.Info.Name, "Crit") ~= nil or string.find(myHero.ActiveSpell.Info.Name, "crit") ~= nil
                local NotAttacking = myHero.ActiveSpell.Info.Name == ""
                --print("GameClock.Time", math.floor(GameClock.Time))
                if myHero.CritChance > 0 then
                    --print(CritCheck)
                    print(NotAttacking)
                    print(CritCheck)
                    --print(self:GetAttackSpeed())
                    if CritCheck or NotAttacking then
                        --print("CritAttack")
                        return self:Orbwalk(Target)
                    else
                        --print("WaitforCrit")
                        return self:Orbwalk(nil)
                    end
                    local prime = self:Sieve(CritCheck)
                    if prime[CritCheck] then
                        print("CritAttack")
                        return self:Orbwalk(Target)
                    else
                        print("WaitforCrit")
                        return self:Orbwalk(nil)
                    end
                end]]
                --print(Orbwalker:GetDistance(myHero.Position, Target.Position)) --740
                --print(myHero.AttackRange, "+", myHero.CharData.BoundingRadius, "+", Target.CharData.BoundingRadius,"=", myHero.AttackRange + myHero.CharData.BoundingRadius + Target.CharData.BoundingRadius)
                return self:Orbwalk(Target)
            end   
            if Engine:IsKeyDown("HK_HARASS") then
                local Target = nil
                if myHero.ChampionName == "Caitlyn" then
                    Target = self:GetCaitlynHeadshotTarget()
                end
                if myHero.ChampionName == "Aphelios" then
                    Target = self:GetApheliosSniperTarget()
                end
                if myHero.ChampionName == "Tristana" then
                    Target = self:GetTristanaBombTarget()
                end
                if Target == nil then
                    Target = self:GetTarget("HARASS", self.OrbRange)
                end
                return self:Orbwalk(Target)            
            end   
            if Engine:IsKeyDown("HK_LASTHIT") then
                return self:Orbwalk(self:GetTarget("LASTHIT", self.OrbRange))           
            end   
            if Engine:IsKeyDown("HK_LANECLEAR") then
                return self:Orbwalk(self:GetTarget("LANECLEAR", self.OrbRange))           
            end
        end

        self.BlockAttack  = 0
        -- self.MovePosition = nil
    end,
    OnDraw = function(self)
        -- local Turrets = ObjectManager.TurretList
        -- for _, T in pairs(Turrets) do
        --     print(T:GetTypeFlag())
        -- end

        -- Render:DrawCircle(myHero.Position, 10, 0,255,0,255)

        -- local TroyList = ObjectManager.TroyList
        -- for _ , Troy in pairs(TroyList) do
        --     local vecOut = Vector3.new()
        --     if Render:World2Screen(Troy.Position, vecOut) then
        --         print(Troy.Name)
        --         Render:DrawString(Troy.Name, vecOut.x , vecOut.y , 255, 0, 0, 255)
        --         Render:DrawString(Troy.Index, vecOut.x , vecOut.y+20 , 0, 255, 0, 255)
        --         Render:DrawCircle(Troy.Position, 20, 0,255,0,255)
        --     end
        -- end
        if self.FClearToggleOn == true then
            local vecOutMe = Vector3.new()
            if Render:World2Screen(myHero.Position, vecOutMe) then
                Render:DrawString("FastClear: ON", vecOutMe.x - 70 , vecOutMe.y + 50 , 92, 255, 5, 255)
            end
        end
        if 0 == 1 then
            self:DrawMinionTarget(2000)
        end
        self:GetAttackRange()
        if self.DrawTarget ~= nil and self.DrawTargetCircle.Value == 1 then
            --print(self.DrawTarget.Name)
            local Bound = self.DrawTarget.CharData.BoundingRadius
            if self.DrawTarget.IsInhib then
                Bound = 200
            end
            if self.DrawTarget.IsNexus then
                Bound = 300
            end
            Render:DrawCircle(self.DrawTarget.Position, Bound, 0,255,0,255)
        end
        if self.ForceTarget ~= nil and self.ForceTarget.IsHero then
            local vecOut = Vector3.new()
            if Render:World2Screen(myHero.Position, vecOut) then
                Render:DrawString("ForceTarget: " .. self.ForceTarget.ChampionName, vecOut.x - 100 , vecOut.y + 50, 255, 0, 0, 255)
            end
            if self.ForceTarget.IsTargetable then       
                Render:DrawCircle(self.ForceTarget.Position, self.ForceTarget.CharData.BoundingRadius, 255,255,100,255)
            end
        end
        if self.PlayerRange.Value == 1 then
            Render:DrawCircle(myHero.Position, self.OrbRange, 255, 255, 255, 255)
        end
        --[[if self.WaitMinion ~= nil and self.WaitMinion.IsDead == false and self.WaitForLastHitTimer ~= nil and self.WaitMinion.Health > 0 then
            Render:DrawCircle(self.WaitMinion.Position, 65, 255, 255, 255, 255)
        end]]
        if self.EnemyRange.Value == 1 then
            local Heros = ObjectManager.HeroList
            for I, Hero in pairs(Heros) do
                if Hero.Team ~= myHero.Team then
                    if Hero.IsTargetable then
                        Render:DrawCircle(Hero.Position, Hero.CharData.BoundingRadius + Hero.AttackRange, 255,0,0,255)
                    end
                end
            end    
        end
    end,
    OnLoad = function(self)
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)
        AddEvent("OnDraw", function() self:OnDraw() end)
    end,
    --AutoPrios functions
    GetChampionPrios = function(self)
        for _,Hero in pairs(ObjectManager.HeroList) do 
            if Hero.Team ~= myHero.Team and string.len(Hero.ChampionName) > 1 then
                if self.Prio[Hero.Index] == nil then
                    local Prio = self:GetHeroPrio(Hero.ChampionName)
                    if Prio and self.UsePrioList.Value == 1 then
                        self.Prio[Hero.Index] = self.GenericMenu:AddSlider(Hero.ChampionName, Prio,1,5,1)
                    else
                        self.Prio[Hero.Index] = self.GenericMenu:AddSlider(Hero.ChampionName, 1,1,5,1)
                    end
                end
            end
        end
    end,
    GetRolePrio = function(self, Role)
        if Role == "ADC"        then return 5 end
        if Role == "AP"         then return 4 end
        if Role == "MidAD"      then return 5 end
        if Role == "Support"    then return 3 end
        if Role == "Bruiser"    then return 2 end
        if Role == "Tank"       then return 1 end
        if Role == "FuckMeUpFam"then return 5 end
    end,   
    SetUpChampionWindup = function(self)
        if self.WindupPercent == 0.35 then
            self.WindupPercent, self.WindupMod = self:GetChampionWindUp(myHero.ChampionName)
        else
           --print("ChampionWindUP is setup to: ", self.WindupPercent, self.WindupMod)
        end
    end,
    GetChampionWindUp = function(self, Name)
        if Name == "Aatrox"             then return	19.74,  1 end
        if Name == "Ahri"               then return 20.05,  1 end
        if Name == "Akali"              then return 13.9,   1 end
        if Name == "Akshan"             then return 13.33,  1 end
        if Name == "Alistar"            then return 30,     1 end
        if Name == "Amumu"              then return 23.38,  1 end
        if Name == "Anivia"             then return 20,     1 end
        if Name == "Annie"              then return	19.58,  1 end
        if Name == "Aphelios"           then return	15.33,  1 end
        if Name == "Ashe"               then return	21.93,  1 end
        if Name == "Aurelion"           then return	20,     1 end
        if Name == "Azir"               then return	15.63,  1 end
        if Name == "Bard"               then return	18.75,  1 end
        if Name == "Bel'Veth"           then return	24.75,  1 end
        if Name == "Blitzcrank"         then return	27,     1 end
        if Name == "Brand"              then return	18.75,  1 end
        if Name == "Braum"              then return	23,     1 end
        if Name == "Caitlyn"            then return	17.71,  1 end
        if Name == "Camille"            then return	19.33,  1 end
        if Name == "Cassiopeia"         then return	19.2,   1 end
        if Name == "Chogath"            then return 21.9,   1 end
        if Name == "Corki"              then return	10,     1 end
        if Name == "Darius"             then return	20,     0.5 end
        if Name == "Diana"              then return	20.83,  1 end
        if Name == "DrMundo"            then return 16.03,  1 end
        if Name == "Draven"             then return	15.61,  1 end
        if Name == "Ekko"               then return	16.25,  1 end
        if Name == "Elise"              then return	18.75,  1 end
        if Name == "Evelynn"            then return	15.33,  1 end
        if Name == "Ezreal"             then return	18.84,  1 end
        if Name == "Fiddlesticks"       then return	30,     1 end
        if Name == "Fiora"              then return	13.79,  1 end
        if Name == "Fizz"               then return	20.3,   1 end
        if Name == "Galio"              then return	20.63,  1 end
        if Name == "Gangplank"          then return	16.45,  1 end
        if Name == "Garen"              then return	18,	    0.5 end
        if Name == "Gnar"               then return	14.6,   1 end
        if Name == "Gragas"             then return	25,     1 end
        if Name == "Graves"             then return	0.5,	0.1 end
        if Name == "Gwen"               then return	19.67,  1 end
        if Name == "Hecarim"            then return	25,     1 end
        if Name == "Heimerdinger"       then return	20.08,  1 end
        if Name == "Illaoi"             then return	21.43,  1 end
        if Name == "Irelia"             then return	19.67,  1 end
        if Name == "Ivern"              then return	23,     1 end
        if Name == "Janna"              then return	22,     1 end
        if Name == "JarvanIV"           then return	17.54,  1 end
        if Name == "Jax"                then return	20.81,  1 end
        if Name == "Jayce"              then return	9.5,	0.005 end
        if Name == "Jhin"               then return	15.63,  1 end
        if Name == "Jinx"               then return	16.88,  1 end
        if Name == "KSante"             then return	19.53,  1 end
        if Name == "Kaisa"              then return	16.11,  1 end
        if Name == "Kalista"            then return	36,	    0.75 end
        if Name == "Karma"              then return	16.15,  1 end
        if Name == "Karthus"            then return	34.38,  1 end
        if Name == "Kassadin"           then return	15,     1 end
        if Name == "Katarina"           then return	15,     1 end
        if Name == "Kayle"              then return	19.36,  1 end
        if Name == "Kayn"               then return	18.73,  1 end
        if Name == "Kennen"             then return	20,     1 end
        if Name == "Khazix"             then return	20.05,  1 end
        if Name == "Kindred"            then return	17.54,  1 end
        if Name == "Kled"               then return	17.5,   1 end
        if Name == "Kled&Skaarl"        then return	17.5,   1 end
        if Name == "KogMaw"             then return	16.62,  1 end
        if Name == "LeBlanc"            then return	16.67,  1 end
        if Name == "LeeSin"             then return	19.53,  1 end
        if Name == "Leona"              then return	22.92,  1 end
        if Name == "Lillia"             then return	14.71,  1 end
        if Name == "Lissandra"          then return	18.75,  1 end
        if Name == "Lucian"             then return	15,     1 end
        if Name == "Lulu"               then return	18.75,  1 end
        if Name == "Lux"                then return	15.63,  1 end
        if Name == "Malphite"           then return	24.97,  1 end
        if Name == "Malzahar"           then return	19,     1 end
        if Name == "Maokai"             then return	30,     1 end
        if Name == "MasterYi"           then return	24.38,  1 end
        if Name == "MegaGnar"           then return	14.6,   1 end
        if Name == "MissFortune"        then return	14.8,   1 end
        if Name == "Mordekaiser"        then return	21.13,  1 end
        if Name == "Morgana"            then return	14,     1 end
        if Name == "Nami"               then return	18,     1 end
        if Name == "Nasus"              then return	20.14,  1 end
        if Name == "Nautilus"           then return	30.64,  1 end
        if Name == "Neeko"              then return	21.48,  1 end
        if Name == "Nidalee"            then return	15,     1 end
        if Name == "Nilah"              then return	22,     1 end
        if Name == "Nocturne"           then return	20.05,  1 end
        if Name == "Nunu"               then return	19.36,  1 end
        if Name == "Olaf"               then return	23.44,  1 end
        if Name == "Orianna"            then return	17.54,  1 end
        if Name == "Ornn"               then return	21.88,  1 end
        if Name == "Pantheon"           then return	19.03,  1 end
        if Name == "Poppy"              then return	23.44,  1 end
        if Name == "Pyke"               then return	20,     1 end
        if Name == "Qiyana"             then return	15.33,  1 end
        if Name == "Quinn"              then return	17.54,  1 end
        if Name == "Rakan"              then return	17.14,  1 end
        if Name == "Rammus"             then return	22.92,  1 end
        if Name == "RekSai"             then return	26.67,  1 end
        if Name == "Rell"               then return	42,	    0.4 end
        if Name == "Renata"            then return	18.8,   1 end
        if Name == "Renekton"           then return	17.73,  1 end
        if Name == "Rengar"             then return	20,     1 end
        if Name == "Riven"              then return	16.67,  1 end
        if Name == "Rumble"             then return	22.92,  1 end
        if Name == "Ryze"               then return	20,     1 end
        if Name == "Samira"             then return	15,     1 end
        if Name == "Sejuani"            then return	18.75,  1 end
        if Name == "Senna"              then return	31.25, 	0.6 end
        if Name == "Seraphine"          then return	18.7,   1 end
        if Name == "Sett"               then return	21.43,  1 end
        if Name == "Shaco"              then return	22.15,  1 end
        if Name == "Shen"               then return	17.36,  1 end
        if Name == "Shyvana"            then return	19.74,  1 end
        if Name == "Singed"             then return	23.62,  1 end
        if Name == "Sion"               then return	24.91,  1 end
        if Name == "Sivir"              then return	12,     1 end
        if Name == "Skarner"            then return	18,	    0.5 end
        if Name == "Sona"               then return	17.18,  1 end
        if Name == "Soraka"             then return	18.7,   1 end
        if Name == "Swain"              then return	14,     1 end
        if Name == "Sylas"              then return	16.77,  1 end
        if Name == "Syndra"             then return	18.75,  1 end
        if Name == "TahmKench"          then return	25.02,  1 end
        if Name == "Taliyah"            then return	16.15,  1 end
        if Name == "Talon"              then return	12.38,  1 end
        if Name == "Taric"              then return	18,	    0.25 end
        if Name == "Teemo"              then return	21.57,  1 end
        if Name == "Thresh"             then return	23.96,	0.25 end
        if Name == "Tristana"           then return	14.8,   1 end
        if Name == "Trundle"            then return	20.83,  1 end
        if Name == "Tryndamere"         then return	19,     1 end
        if Name == "TwistedFate"        then return	24.4,   1 end
        if Name == "Twitch"             then return	20.19,  1 end
        if Name == "Udyr"               then return	19.8,   1 end
        if Name == "Urgot"              then return	15,     1 end
        if Name == "Varus"              then return	17.54,  1 end
        if Name == "Vayne"              then return	17.54,  1 end
        if Name == "Veigar"             then return	19.09,  1 end
        if Name == "VelKoz"             then return	20,     1 end
        if Name == "Vex"                then return	15.63,  1 end
        if Name == "Vi"                 then return	22.5,   1 end
        if Name == "Viego"              then return	16.45,  1 end
        if Name == "Viktor"             then return	18,     1 end
        if Name == "Vladimir"           then return	19.74,  1 end
        if Name == "Volibear"           then return	30,     1 end
        if Name == "Warwick"            then return	17.5,   1 end
        if Name == "Wukong"             then return	20.83,  1 end
        if Name == "Xayah"              then return	17.69,  1 end
        if Name == "Xerath"             then return	25.07,  1 end
        if Name == "XinZhao"            then return	18.71,  1 end
        if Name == "Yasuo"              then return	22,     1 end
        if Name == "Yone"               then return	22,     1 end
        if Name == "Yorick"             then return	20.63,  1 end
        if Name == "Yuumi"              then return	15.63,  1 end
        if Name == "Zac"                then return	23.15,  1 end
        if Name == "Zed"                then return	19.76,  1 end
        if Name == "Zeri"               then return	15.63,  1 end
        if Name == "Ziggs"              then return	20.83,  1 end
        if Name == "Zilean"             then return	18,     1 end
        if Name == "Zoe"                then return	16.15,  1 end
        if Name == "Zyra"               then return	14.58,  1 end
    end,
    GetHeroPrio = function(self, Name)
        if Name == "Aatrox" then return        self:GetRolePrio("Bruiser") end
        if Name == "Ahri" then return          self:GetRolePrio("AP") end
        if Name == "Akali" then return         self:GetRolePrio("AP") end
        if Name == "Alistar" then return       self:GetRolePrio("Tank") end
        if Name == "Amumu" then return         self:GetRolePrio("Tank") end
        if Name == "Anivia" then return        self:GetRolePrio("AP") end
        if Name == "Annie" then return         self:GetRolePrio("AP") end
        if Name == "Aphelios" then return      self:GetRolePrio("ADC") end
        if Name == "Ashe" then return          self:GetRolePrio("ADC") end
        if Name == "AurelionSol" then return   self:GetRolePrio("AP") end
        if Name == "Azir" then return          self:GetRolePrio("AP") end
        if Name == "Bard" then return          self:GetRolePrio("Tank") end
        if Name == "Blitzcrank" then return    self:GetRolePrio("Tank") end
        if Name == "Brand" then return         self:GetRolePrio("AP") end
        if Name == "Braum" then return         self:GetRolePrio("Tank") end
        if Name == "Caitlyn" then return       self:GetRolePrio("ADC") end
        if Name == "Camille" then return       self:GetRolePrio("Tank") end
        if Name == "Cassiopeia" then return    self:GetRolePrio("AP") end
        if Name == "Chogath" then return       self:GetRolePrio("Tank") end
        if Name == "Corki" then return         self:GetRolePrio("ADC") end
        if Name == "Darius" then return        self:GetRolePrio("Tank") end
        if Name == "Diana" then return         self:GetRolePrio("AP") end
        if Name == "DrMundo" then return       self:GetRolePrio("Tank") end
        if Name == "Draven" then return        self:GetRolePrio("ADC") end
        if Name == "Ekko" then return          self:GetRolePrio("AP") end
        if Name == "Elise" then return         self:GetRolePrio("Bruiser") end
        if Name == "Evelynn" then return       self:GetRolePrio("AP") end
        if Name == "Ezreal" then return        self:GetRolePrio("ADC") end
        if Name == "FiddleSticks" then return  self:GetRolePrio("AP") end
        if Name == "Fiora" then return         self:GetRolePrio("Bruiser") end
        if Name == "Fizz" then return          self:GetRolePrio("AP") end
        if Name == "Galio" then return         self:GetRolePrio("Tank") end
        if Name == "Gangplank" then return     self:GetRolePrio("Bruiser") end
        if Name == "Garen" then return         self:GetRolePrio("Tank") end
        if Name == "Gnar" then return          self:GetRolePrio("Tank") end
        if Name == "Gragas" then return        self:GetRolePrio("AP") end
        if Name == "Graves" then return        self:GetRolePrio("ADC") end
        if Name == "Hecarim" then return       self:GetRolePrio("Tank") end
        if Name == "Heimerdinger" then return  self:GetRolePrio("AP") end
        if Name == "Illaoi" then return        self:GetRolePrio("Tank") end
        if Name == "Irelia" then return        self:GetRolePrio("Bruiser") end
        if Name == "Ivern" then return         self:GetRolePrio("Bruiser") end
        if Name == "Janna" then return         self:GetRolePrio("Support") end
        if Name == "JarvanIV" then return      self:GetRolePrio("Tank") end
        if Name == "Jax" then return           self:GetRolePrio("Bruiser") end
        if Name == "Jayce" then return         self:GetRolePrio("MidAD") end
        if Name == "Jhin" then return          self:GetRolePrio("ADC") end
        if Name == "Jinx" then return          self:GetRolePrio("ADC") end
        if Name == "Kaisa" then return         self:GetRolePrio("ADC") end
        if Name == "Kalista" then return       self:GetRolePrio("ADC") end
        if Name == "Karma" then return         self:GetRolePrio("Support") end
        if Name == "Karthus" then return       self:GetRolePrio("AP") end
        if Name == "Kassadin" then return      self:GetRolePrio("AP") end
        if Name == "Katarina" then return      self:GetRolePrio("AP") end
        if Name == "Kayle" then return         self:GetRolePrio("AP") end
        if Name == "Kayn" then return          self:GetRolePrio("Bruiser") end
        if Name == "Kindred" then return       self:GetRolePrio("ADC") end
        if Name == "Kennen" then return        self:GetRolePrio("AP") end
        if Name == "Khazix" then return        self:GetRolePrio("Bruiser") end
        if Name == "Kled" then return          self:GetRolePrio("Bruiser") end
        if Name == "KogMaw" then return        self:GetRolePrio("ADC") end
        if Name == "Leblanc" then return       self:GetRolePrio("AP") end
        if Name == "LeeSin" then return        self:GetRolePrio("Bruiser") end
        if Name == "Leona" then return         self:GetRolePrio("Tank") end
        if Name == "Lissandra" then return     self:GetRolePrio("AP") end
        if Name == "Lucian" then return        self:GetRolePrio("ADC") end
        if Name == "Lulu" then return          self:GetRolePrio("Support") end
        if Name == "Lux" then return           self:GetRolePrio("AP") end
        if Name == "Malphite" then return      self:GetRolePrio("Tank") end
        if Name == "Malzahar" then return      self:GetRolePrio("AP") end
        if Name == "Maokai" then return        self:GetRolePrio("Tank") end
        if Name == "MasterYi" then return      self:GetRolePrio("Bruiser") end
        if Name == "MissFortune" then return   self:GetRolePrio("ADC") end
        if Name == "MonkeyKing" then return    self:GetRolePrio("Bruiser") end
        if Name == "Mordekaiser" then return   self:GetRolePrio("AP") end
        if Name == "Morgana" then return       self:GetRolePrio("AP") end
        if Name == "Nami" then return          self:GetRolePrio("Support") end
        if Name == "Nasus" then return         self:GetRolePrio("Tank") end
        if Name == "Nautilus" then return      self:GetRolePrio("Tank") end
        if Name == "Neeko" then return         self:GetRolePrio("AP") end
        if Name == "Nidalee" then return       self:GetRolePrio("AP") end
        if Name == "Nocturne" then return      self:GetRolePrio("Bruiser") end
        if Name == "Nunu" then return          self:GetRolePrio("Tank") end
        if Name == "Olaf" then return          self:GetRolePrio("Bruiser") end
        if Name == "Orianna" then return       self:GetRolePrio("AP") end
        if Name == "Ornn" then return          self:GetRolePrio("Tank") end
        if Name == "Pantheon" then return      self:GetRolePrio("Bruiser") end
        if Name == "Poppy" then return         self:GetRolePrio("Bruiser") end
        if Name == "Pyke" then return          self:GetRolePrio("MidAD") end
        if Name == "Qiyana" then return        self:GetRolePrio("Bruiser") end
        if Name == "Quinn" then return         self:GetRolePrio("ADC") end
        if Name == "Rakan" then return         self:GetRolePrio("Tank") end
        if Name == "Rammus" then return        self:GetRolePrio("Tank") end
        if Name == "RekSai" then return        self:GetRolePrio("AP") end
        if Name == "Renekton" then return      self:GetRolePrio("Tank") end
        if Name == "Rengar" then return        self:GetRolePrio("Bruiser") end
        if Name == "Riven" then return         self:GetRolePrio("Bruiser") end
        if Name == "Rumble" then return        self:GetRolePrio("Bruiser") end
        if Name == "Ryze" then return          self:GetRolePrio("AP") end
        if Name == "Samira" then return        self:GetRolePrio("ADC") end
        if Name == "Sejuani" then return       self:GetRolePrio("Tank") end
        if Name == "Senna" then return         self:GetRolePrio("ADC") end
        if Name == "Seraphine" then return     self:GetRolePrio("AP") end
        if Name == "Sett" then return          self:GetRolePrio("Bruiser") end
        if Name == "Shaco" then return         self:GetRolePrio("AP") end
        if Name == "Shen" then return          self:GetRolePrio("Tank") end
        if Name == "Shyvana" then return       self:GetRolePrio("Tank") end
        if Name == "Singed" then return        self:GetRolePrio("Tank") end
        if Name == "Sion" then return          self:GetRolePrio("AP") end
        if Name == "Sivir" then return         self:GetRolePrio("ADC") end
        if Name == "Skarner" then return       self:GetRolePrio("Tank") end
        if Name == "Sona" then return          self:GetRolePrio("Support") end
        if Name == "Soraka" then return        self:GetRolePrio("FuckMeUpFam") end
        if Name == "Swain" then return         self:GetRolePrio("AP") end
        if Name == "Sylas" then return         self:GetRolePrio("AP") end
        if Name == "Syndra" then return        self:GetRolePrio("AP") end
        if Name == "TahmKench" then return     self:GetRolePrio("Tank") end
        if Name == "Taliyah" then return       self:GetRolePrio("AP") end
        if Name == "Talon" then return         self:GetRolePrio("MidAD") end
        if Name == "Taric" then return         self:GetRolePrio("Tank") end
        if Name == "Teemo" then return         self:GetRolePrio("AP") end
        if Name == "Thresh" then return        self:GetRolePrio("Tank") end
        if Name == "Tristana" then return      self:GetRolePrio("ADC") end
        if Name == "Trundle" then return       self:GetRolePrio("Tank") end
        if Name == "Tryndamere" then return    self:GetRolePrio("Bruiser") end
        if Name == "TwistedFate" then return   self:GetRolePrio("AP") end
        if Name == "Twitch" then return        self:GetRolePrio("ADC") end
        if Name == "Udyr" then return          self:GetRolePrio("Tank") end
        if Name == "Urgot" then return         self:GetRolePrio("ADC") end
        if Name == "Varus" then return         self:GetRolePrio("ADC") end
        if Name == "Vayne" then return         self:GetRolePrio("ADC") end
        if Name == "Veigar" then return        self:GetRolePrio("AP") end
        if Name == "Velkoz" then return        self:GetRolePrio("AP") end
        if Name == "Vi" then return            self:GetRolePrio("Bruiser") end
        if Name == "Viego" then return         self:GetRolePrio("MidAD") end
        if Name == "Viktor" then return        self:GetRolePrio("AP") end
        if Name == "Vladimir" then return      self:GetRolePrio("AP") end
        if Name == "Volibear" then return      self:GetRolePrio("Tank") end
        if Name == "Warwick" then return       self:GetRolePrio("Tank") end
        if Name == "Xerath" then return        self:GetRolePrio("AP") end
        if Name == "Xayah" then return         self:GetRolePrio("ADC") end
        if Name == "XinZhao" then return       self:GetRolePrio("Bruiser") end
        if Name == "Yasuo" then return         self:GetRolePrio("MidAD") end
        if Name == "Yorick" then return        self:GetRolePrio("Tank") end
        if Name == "Yuumi" then return         self:GetRolePrio("Support") end
        if Name == "Zac" then return           self:GetRolePrio("Tank") end
        if Name == "Zed" then return           self:GetRolePrio("MidAD") end
        if Name == "Ziggs" then return         self:GetRolePrio("AP") end
        if Name == "Zilean" then return        self:GetRolePrio("Support") end
        if Name == "Zoe" then return           self:GetRolePrio("AP") end
        if Name == "Zyra" then return          self:GetRolePrio("AP") end
    end,
}

AddEvent("OnLoad", function() Orbwalker:OnLoad() end)