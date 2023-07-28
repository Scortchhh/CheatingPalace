Prediction = {
    Init = function(self) 
        self.KeyNames           = {}
        self.KeyNames[6] 		= "HK_ITEM1"
        self.KeyNames[7] 		= "HK_ITEM2"
        self.KeyNames[8] 		= "HK_ITEM3"
        self.KeyNames[9] 		= "HK_ITEM4"
        self.KeyNames[10] 		= "HK_ITEM5"
        self.KeyNames[11]		= "HK_ITEM6"

        self.DashSpell     ={}
        self.DashSpell['Amumu'] = {Q = 0.25, QSpeed = 1800, QType = "AT"}
        self.DashSpell['Bard'] = {E = 0.25, ESpeed = 900, EType = "AT"}
        self.DashSpell['Ivern'] = {Q = 0.25, QSpeed = 1300, QType = "AT"}
        self.DashSpell['Leona'] = {E = 0.25, ESpeed = 2000, EType = "AT"}
        self.DashSpell['Thresh'] = {Q = 0.05, QSpeed = 1400, QType = "AT"}
        self.DashSpell['Vex'] = {R = 0, RSpeed = 2200, RType = "AT"}
        self.DashSpell['Ziggs'] = {W = 0.25, WSpeed = 1750, WType = "AT"}
        self.DashSpell['Shaco'] = {Q = 0.125, QSpeed = math.huge, QType = "DT", R = 0.25, RSpeed = math.huge, RType = "BLOCK"}
        self.DashSpell['MasterYi'] = {Q = 0, QSpeed = math.huge, QType = "UT"}
        
        --Direction-targeted:
        
        self.DashSpell['Ezreal'] = {E = 0.25, ESpeed = math.huge, EType = "DT"}
        self.DashSpell['Aatrox'] = {E = 0, ESpeed = 1340, EType = "DT"}
        self.DashSpell['Caitlyn'] = {E = 0.15, ESpeed = 2200, EType = "DT"}
        self.DashSpell['Gragas:'] = {E = 0, ESpeed = 2200, EType = "DT"}
        self.DashSpell['Graves'] = {E = 0, ESpeed = 2200, EType = "DT"}
        self.DashSpell['Kalista'] = {P = 0, PSpeed = 1160, PType = "UT", Q = 0, QSpeed = 1160, QType = "DT"}
        self.DashSpell['Kled'] = {E = 0, ESpeed = 2200, EType = "DT", R = 0, RSpeed = 1650, RType = "AT"}
        self.DashSpell['Lucian'] = {E = 0, ESpeed = 1350, EType = "DT"}
        self.DashSpell['Ornn'] = {E = 0.35, ESpeed = 1600, EType = "DT"}
        self.DashSpell['Pyke'] = {E = 0, ESpeed = 3000, EType = "DT"}
        self.DashSpell['Renekton'] = {E = 0, ESpeed = 1300, EType = "DT"}
        self.DashSpell['Riven'] = {Q = 0, E = 0, QSpeed = 2200, QType = "DT", ESpeed = 2200, EType = "DT"}
        self.DashSpell['Sejuani'] = {Q = 0, QSpeed = 2200, QType = "DT"}
        self.DashSpell['Shen'] = {E = 0, ESpeed = 1350, EType = "DT"}
        self.DashSpell['Taliyah'] = {R = 0, RSpeed = 1500, RType = "DT"}
        self.DashSpell['Tryndamere'] = {E = 0, ESpeed = 1500, EType = "DT", R = 0, RSpeed = math.huge, RType = "BLOCK"}
        self.DashSpell['Urgot'] = {E = 0.45, ESpeed = 1650, EType = "DT"}
        self.DashSpell['Vayne'] = {Q = 0, QSpeed = 2200, QType = "DT"}
        self.DashSpell['Viego'] = {W = 0, WSpeed = 1000, WType = "DT", E = 0, ESpeed = 750, EType = "DT"}
        self.DashSpell['Warwick'] = {R = 0.1, RSpeed = 2200, RType = "DT", Q = 0.2, QSpeed = 2200, QType = "AT"}
        self.DashSpell['Yone'] = {Q = 0.11, QSpeed = 1500, QType = "DT", E = 0, ESpeed = 1200, EType = "AT"}
        
        --Location-Targeted:
        
        self.DashSpell['Ahri'] = {R = 0, RSpeed = 1650, RType = "LT"}
        self.DashSpell['Akshan'] = {E = 0, ESpeed = 1200, EType = "DT"}
        self.DashSpell['Aurelion Sol'] = {E = 0, ESpeed = 800, EType = "LT"}
        self.DashSpell['Corki'] = {E = 0, ESpeed = 1500, EType = "LT"}
        self.DashSpell['Ekko'] = {E = 0, ESpeed = 2200, EType = "LT", R = 0.5, RSpeed = math.huge, RType = "AT"}
        self.DashSpell['Fiora'] = {Q = 0, QSpeed = 2200, QType = "LT", W = 0, WSpeed = math.huge, WType = "BLOCK"}
        self.DashSpell['Galio'] = {E = 0, ESpeed = 2300, EType = "LT"}
        self.DashSpell['Gnar'] = {E = 0, ESpeed = 2200, EType = "LT"}
        self.DashSpell['Gwen'] = {E = 0, ESpeed = 2200, EType = "LT"}
        self.DashSpell['Kaisa'] = {R = 0, RSpeed = 2200, RType = "LT", E = 0, ESpeed = 1200, EType = "LT"}
        self.DashSpell['Kindred'] = {Q = 0, QSpeed = 1000, QType = "LT"}
        self.DashSpell['Khazix'] = {E = 0, ESpeed = 2200, EType = "LT"}
        self.DashSpell['LeBlanc'] = {W = 0, WSpeed = 1450, WType = "LT", R = 0, RSpeed = 1450, RType = "LT"}
        self.DashSpell['Lillia'] = {W = 0, WSpeed = 1550, WType = "LT"}
        self.DashSpell['Malphite'] = {R = 0, RSpeed = 2000, RType = "LT"}
        self.DashSpell['Nidalee'] = {W = 0, WSpeed = 2200, WType = "LT"}
        self.DashSpell['Qiyana'] = {W = 0, WSpeed = 900, WType = "LT", E = 0, ESpeed = 1100, EType = "LT"}
        self.DashSpell['Rammus'] = {R = 0, RSpeed = 900, RType = "LT"}
        self.DashSpell['Shyvana'] = {R = 0.25, RSpeed = 2200, RType = "LT"}
        self.DashSpell['Tristana'] = {E = 0.25, ESpeed = 1100, EType = "LT"}
        self.DashSpell['Zac'] = {E = 0.2, ESpeed = 2200, EType = "LT"}
        
        --Unit Targeted:
        
        self.DashSpell['Katarina'] = {E = 0, ESpeed = math.huge, EType = "UT"}
        self.DashSpell['Akali'] = {R = 0, RSpeed = 3000, RType = "UT", E = 0, ESpeed = 1800, EType = "AT"}
        self.DashSpell['Alistar'] = {W = 0, WSpeed = 1600, WType = "UT"}
        self.DashSpell['Azir'] = {E = 0, ESpeed = 2200, EType = "UT"}
        self.DashSpell['Braum'] = {W = 0, WSpeed = 1500, WType = "UT"}
        self.DashSpell['Camille'] = {R = 0, RSpeed = math.huge, RType = "UT", E = 0, ESpeed = 1500, EType = "TT", EType = "LT"}
        self.DashSpell['Diana'] = {E = 0, ESpeed = 2200, EType = "UT"}
        self.DashSpell['Elise'] = {Q = 0.25, QSpeed = 2200, QType = "UT", E = 0, ESpeed = math.huge, EType = "BLOCK"}
        self.DashSpell['Evelynn'] = {R = 0, RSpeed = math.huge, RType = "BLOCK"}
        self.DashSpell['Fizz'] = {Q = 0, QSpeed = 2200, QType = "UT", E = 0, ESpeed = math.huge, EType = "BLOCK"}
        self.DashSpell['Hecarim'] = {E = 0, ESpeed = 1200, EType = "UT", R = 0, RSpeed = 1100, RType = "LT"}
        self.DashSpell['Illaoi'] = {W = 0, WSpeed = 1200, WType = "UT"}
        self.DashSpell['Irelia'] = {Q = 0, QSpeed = 1900, QType = "UT"}
        self.DashSpell['JarvanIV'] = {R = 0, RSpeed = 2200, RType = "UT", Q = 0.4, QSpeed = 2200, QType = "AT"}
        self.DashSpell['Jax'] = {Q = 0, QSpeed = 1650, QType = "UT"}
        self.DashSpell['Jayce'] = {Q = 0, QSpeed = 1200, QType = "UT"}
        self.DashSpell['Kayn'] = {R = 0, RSpeed = math.huge, RType = "BLOCK", Q = 0, QSpeed = 1650, QType = "DT"}
        self.DashSpell['Lee Sin'] = {E = 0, ESpeed = 1800, EType = "UT", Q = 0, QSpeed = 1800, QType = "AT"}
        self.DashSpell['Maokai'] = {W = 0, WSpeed = math.huge, WType = "BLOCK"}
        self.DashSpell['Nocturne'] = {R = 0.25, RSpeed = 1800, RType = "UT"}
        self.DashSpell['Pantheon'] = {W = 0, WSpeed = math.huge, WType = "BLOCK"}
        self.DashSpell['Poppy'] = {E = 0, ESpeed = 1650, EType = "UT"}
        self.DashSpell['Quinn'] = {E = 0, ESpeed = 2500, EType = "UT"}
        self.DashSpell['Rakan'] = {E = 0, ESpeed = 1650, EType = "UT", W = 0, WSpeed = 1700, WType = "LT"}
        self.DashSpell['RekSai'] = {R = 0.25, RSpeed = math.huge, RType = "Block", E = 0, ESpeed = math.huge, EType = "DT"}
        self.DashSpell['Rell'] = {W = 0, WSpeed = 600, WType = "LT"}
        self.DashSpell['Rengar'] = {P = 0, PSpeed = 1450, PType = "UT"}
        self.DashSpell['Samira'] = {E = 0, ESpeed = 1600, EType = "UT"}
        self.DashSpell['Sett'] = {R = 0, RSpeed = 1350, RType = "UT"}
        self.DashSpell['Sylas'] = {E = 0, WSpeed = 3000, WType = "UT", W = 0, ESpeed = 1450, EType = "DT"}
        self.DashSpell['Talon'] = {--[[E = 0, ESpeed = 1, EType = "MS",]] R = 0, ESpeed = 1.7, EType = "MS"}
        self.DashSpell['Vi'] = {R = 0.25, RSpeed = 800, RType = "UT", Q = 0.2, QSpeed = 1400, QType = "DT"}
        self.DashSpell['Volibear'] = {Q = 0, QSpeed = 1.6, QType = "MS", R = 0, RSpeed = 750, RType = "LT"}
        self.DashSpell['Wukong'] = {W = 0, WSpeed = 1200, WType = "UT", E = 0, ESpeed = 1400, EType = "DT"}
        self.DashSpell['XinZhao'] = {E = 0, ESpeed = 2500, EType = "UT", R = 0.35, RSpeed = math.huge, RType = "BLOCK"}
        self.DashSpell['Yasuo'] = {E = 0, ESpeed = 1100, EType = "UT"}
        self.DashSpell['Yuumi'] = {E = 0, ESpeed = 1600, EType = "UT"}
        self.DashSpell['Zed'] = {W = 0, WSpeed = 2500, WType = "LT", R = 0, RSpeed = math.huge, RType = "BLOCK"}

        self.Enabled         = 1
        self.LockCamPressed  = 0
        self.TickTime        = os.clock()
        self.LastTick        = os.clock()
        self.LockCamTime     = os.clock()

        self.Path       = {}
        --self.PathSimulated = {}
        self.Swing      = {}

        self.Visible    = {}
        self.VisTime    = {}

        self.AttackTimer = {}
        self.ActionTimer = {}
        self.Action = {}

        self.LastTarget = nil
        self.LastTargetTime = nil

        self.Menu 							    = Menu:CreateMenu("Prediction")
        self.Menu:AddLabel("COMBO and LockCam same key(e.g. SPACE:")
        self.PlayWithLockedCamOnSpace 		    = self.Menu:AddCheckbox("Enabled", 0)
        self.Menu:AddLabel("Only cast spells on ForceTarget if set:")
        self.ForceTargetOnly					= self.Menu:AddCheckbox("Enabled", 1)
        self.ReactionTime					    = self.Menu:AddSlider("ReactionTime:", 15, 1, 30, 1)
        self.SetYourPing                        = self.Menu:AddSlider("Set your ping over what you have:", 30, 1, 200, 1)	
        self.PredHitChance  					= self.Menu:AddSlider("Prediction HitChance:", 35, 0, 99, 1)	
        self.PredictHitBox                      = self.Menu:AddCheckbox("HitBox Prediction", 1)
	    self.AdvancedSettingsMenu               = self.Menu:AddSubMenu("Advanced Settings Menu")
        self.UseCachedTargetPrio                = self.AdvancedSettingsMenu:AddCheckbox("Enable Cached Enemy", 1)
        self.CacheTimeForLastTarget             = self.AdvancedSettingsMenu:AddSlider("Seconds to stay on same target", 3, 1, 8, 1)	

        self:LoadSettings()
    end,
    SaveSettings = function(self) 
    	SettingsManager:CreateSettings			("Prediction")
	    SettingsManager:AddSettingsGroup		("Settings")
        SettingsManager:AddSettingsInt			("ForceTargetOnly", self.ForceTargetOnly.Value)
        SettingsManager:AddSettingsInt			("PlayWithLockedCamOnSpace", self.PlayWithLockedCamOnSpace.Value)
        SettingsManager:AddSettingsInt			("SetYourPing", self.SetYourPing.Value)
        SettingsManager:AddSettingsInt			("ReactionTime", self.ReactionTime.Value)
        SettingsManager:AddSettingsInt			("PredHitChance", self.PredHitChance.Value)
        SettingsManager:AddSettingsInt			("PredictHitBox", self.PredictHitBox.Value)
        SettingsManager:AddSettingsInt			("UseTargetCache", self.UseCachedTargetPrio.Value)
        SettingsManager:AddSettingsInt			("CacheTimeTarget", self.CacheTimeForLastTarget.Value)

    end,
    LoadSettings = function(self) 
        SettingsManager:GetSettingsFile			("Prediction")
        self.ForceTargetOnly.Value              = SettingsManager:GetSettingsInt("Settings","ForceTargetOnly")
        self.PlayWithLockedCamOnSpace.Value     = SettingsManager:GetSettingsInt("Settings","PlayWithLockedCamOnSpace")
        self.SetYourPing.Value 				    = SettingsManager:GetSettingsInt("Settings","SetYourPing")
        self.ReactionTime.Value 				= SettingsManager:GetSettingsInt("Settings","ReactionTime")
        self.PredHitChance.Value 				= SettingsManager:GetSettingsInt("Settings","PredHitChance")
        self.PredictHitBox.Value 				= SettingsManager:GetSettingsInt("Settings","PredictHitBox")
        self.CacheTimeForLastTarget.Value 		= SettingsManager:GetSettingsInt("Settings","CacheTimeTarget")
        self.UseCachedTargetPrio.Value 		    = SettingsManager:GetSettingsInt("Settings","UseTargetCache")
    end,
    --HELPER FUNCTIONS
    GetDistance = function(self, from, to)
        return math.max(0, math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2) - 10)
    end,
    PointOnLineSegment = function(self, Start, End, Point, Radius)
        local Dist1 = self:GetDistance(Start, End)      
        local Dist2 = self:GetDistance(Start, Point)        
        local Dist3 = self:GetDistance(Point, End)        
        if Dist2 > Dist1 or Dist3 > Dist1 then return false end

        if 	Point.x - math.max(Start.x, End.x) > Radius or
            math.min(Start.x, End.x) - Point.x > Radius or
            Point.z - math.max(Start.z, End.z) > Radius or
            math.min(Start.z, End.z) - Point.z > Radius then
            return false
        end
        
        if math.abs(End.x - Start.x) < Radius then
            return math.abs(Start.x - Point.x) < Radius or math.abs(End.x - Point.x) < Radius
        end
        if (math.abs(End.z - Start.z) < Radius) then
            return math.abs(Start.z - Point.z) < Radius or math.abs(End.z - Point.z) < Radius
        end
        
        local x = Start.x + (Point.z - Start.z) * (End.x - Start.x) / (End.z - Start.z);
        local z = Start.z + (Point.x - Start.x) * (End.z - Start.z) / (End.x - Start.x);

        return math.abs(Point.x - x) < Radius or math.abs(Point.z - z) < Radius
    end,
    WillCollideWithMinion = function(self, Start, End, MissileWidth)
        local Minions = ObjectManager.MinionList
        for I,Minion in pairs(Minions) do
            local Distance1 = self:GetDistance(Start, End)
            local Distance2 = self:GetDistance(Start, Minion.Position)
            if Distance1 > Distance2 and Minion.IsTargetable and Minion.Team ~= myHero.Team and Minion.MaxHealth > 100  then
                if self:PointOnLineSegment(Start, End, Minion.Position, Minion.CharData.BoundingRadius + MissileWidth) == true then
                    return true
                end
            end
        end
        
        return false
    end,
    WillCollideWithMinionPrediction = function(self, Start, End, Speed, Delay, Width, BoundCheck)
        local Minions = ObjectManager.MinionList
        for I,Minion in pairs(Minions) do
            if Minion.IsTargetable and Minion.Team ~= myHero.Team and Minion.MaxHealth > 100  then
                local MovePosition  = self:GetMinionPrediction(Minion, Start, Speed, Delay, Width, BoundCheck)
                if MovePosition then
                    local TargetBound = 0
                    if BoundCheck == 1 or BoundCheck == true then
                        TargetBound = Minion.CharData.BoundingRadius
                    end
                    local Distance1     = self:GetDistance(Start, End)
                    local Distance2     = self:GetDistance(Start, MovePosition)
                    if Distance1 > Distance2 and self:PointOnLineSegment(Start, End, MovePosition, TargetBound + Width) == true  then
                        return true
                    end
                end
            end
        end
        
        return false
    end,
    WillCollideWithHero = function(self, Start, End, MissileWidth, Target)
        local Heroes = ObjectManager.HeroList
        for I,Hero in pairs(Heroes) do
            local Distance1 = self:GetDistance(Start, End)
            local Distance2 = self:GetDistance(Start, Hero.Position)
            if Distance1 > Distance2 and Hero.IsTargetable and Hero.Team ~= myHero.Team and Hero.MaxHealth > 100  then
                if self:PointOnLineSegment(Start, End, Hero.Position, Hero.CharData.BoundingRadius + MissileWidth) == true then
                    return true
                end
            end
        end
        
        return false
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
    GetVectorNormalized = function(self, Vector)
        local Length = math.max(1, math.sqrt((Vector.x^2)+(Vector.y^2)+(Vector.z^2)))
        return Vector3.new(Vector.x/Length, Vector.y/Length, Vector.z/Length)
    end,
    GetVectorDirection = function(self, Point1, Point2)
        return Vector3.new(Point1.x - Point2.x,Point1.y - Point2.y,Point1.z - Point2.z)
    end,
    GetVectorAddition = function(self, Point1, Point2)
        return Vector3.new(Point1.x + Point2.x,Point1.y + Point2.y,Point1.z + Point2.z)
    end,
    Wallcheck = function(self, StartPos, Position)
        local PlayerPos = StartPos
        local ToTargetVec = Vector3.new(Position.x - PlayerPos.x, Position.y - PlayerPos.y, Position.z - PlayerPos.z)

        local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
        local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
        
        for Range = 25 , Distance, 25 do
            local CurrentPos = Vector3.new(PlayerPos.x + (VectorNorm.x*Range), PlayerPos.y + (VectorNorm.y*Range), PlayerPos.z + (VectorNorm.z*Range))
            if Engine:IsNotWall(CurrentPos) == false then
                return false
            end
        end
        
        return true	
    end,
    GetTargetItemKey = function(self, ItemName, Target)
        for i = 6 , 11 do
            local Slot = Target:GetSpellSlot(i)
            if Slot.Info.Name == ItemName then
                return self.KeyNames[i] , Slot.Charges 
            end
        end
        return nil
    end,
    SpellDodgeCheck = function(self, Target, Time2Hit, Radius)
        if Target.AIData.Dashing == true then print("Dash?") return false end
        local ZhonyasBuff = Target.BuffData:GetBuff("zhonyasringshield")
        local ZhonyasValid = ZhonyasBuff.Valid or ZhonyasBuff.Count_Alt > 0

        if ZhonyasValid then 
            --print("ZhonyasUsed?")
            return false 
        end

        for i = 6 , 11 do
            local Slot = Target:GetSpellSlot(i)
            --print(Slot.Info.Name)
            if Slot.Info.Name == "ZhonyasHourglass" or Slot.Info.Name == "Item2420" then
                local ZhonyasKey = self.KeyNames[i]
                if Engine:SpellReady(ZhonyasKey) then
                    --print("ZonREADY")
                    return true
                else
                    --print("NotZON")
                end
            end
        end
        local Spell = self.DashSpell[Target.ChampionName]
        local CCTime = 0
        local ReactTimer = 0 --self.ReactionTime.Value / 150
        local AttackTimer = 0
        if Spell ~= nil then
            if Spell.Q ~= nil and Spell.QType ~= "MS" then
                local QTimer = 0
                if GameClock.Time - Target:GetSpellSlot(0).Cooldown < 0 then
                    QTimer = GameClock.Time - Target:GetSpellSlot(0).Cooldown
                elseif self:IsImmobile(Target) ~= nil then
                    CCTime = self:IsImmobile(Target)
                elseif self:IsAttacking(Target, 1) ~= nil then
                    AttackTimer = self:IsAttacking(Target, 1)
                else
                    ReactTimer = self.ReactionTime.Value / 150
                end
                if Time2Hit < (Spell.Q + (Radius / Spell.QSpeed)) + QTimer - CCTime - ReactTimer then
                    return true
                end
            end
            if Spell.W ~= nil and Spell.WType ~= "MS" then
                local WTimer = 0
                if GameClock.Time - Target:GetSpellSlot(1).Cooldown < 0 then
                    WTimer = GameClock.Time - Target:GetSpellSlot(1).Cooldown
                elseif self:IsImmobile(Target) ~= nil then
                    CCTime = self:IsImmobile(Target)
                elseif self:IsAttacking(Target, 2) ~= nil then
                    AttackTimer = self:IsAttacking(Target, 2)
                else
                    ReactTimer = self.ReactionTime.Value / 150
                end
                if Time2Hit < (Spell.W + (Radius / Spell.WSpeed)) + WTimer - CCTime - ReactTimer then
                    return true
                end
            end
            if Spell.E ~= nil and Spell.EType ~= "MS" then
                local ETimer = 0
                if GameClock.Time - Target:GetSpellSlot(2).Cooldown < 0 then
                    ETimer = GameClock.Time - Target:GetSpellSlot(2).Cooldown
                elseif self:IsImmobile(Target) ~= nil then
                    CCTime = self:IsImmobile(Target)
                elseif self:IsAttacking(Target, 3) ~= nil then
                    AttackTimer = self:IsAttacking(Target, 3)
                else
                    ReactTimer = self.ReactionTime.Value / 150
                end
                if Time2Hit < (Spell.E + (Radius / Spell.ESpeed)) + ETimer - CCTime - ReactTimer then
                    return true
                end
            end
            if Spell.R ~= nil and Spell.RType ~= "MS" then
                local RTimer = 0
                if GameClock.Time - Target:GetSpellSlot(3).Cooldown < 0 then
                    RTimer = GameClock.Time - Target:GetSpellSlot(3).Cooldown
                elseif self:IsImmobile(Target) ~= nil then
                    CCTime = self:IsImmobile(Target)
                elseif self:IsAttacking(Target, 4) ~= nil then
                    AttackTimer = self:IsAttacking(Target, 4)
                else
                    ReactTimer = self.ReactionTime.Value / 150
                end
                if Time2Hit < (Spell.R + (Radius / Spell.RSpeed)) + RTimer - CCTime - ReactTimer then
                    return true
                end
            end
        end
        return false
    end,
    GetWallPosition = function(self, StartPos, EndPos)
        local Distance  = self:GetDistance(StartPos,EndPos)
        local Norm      = self:GetVectorNormalized(self:GetVectorDirection(EndPos, StartPos))

        for Range = 10 , Distance, 10 do
            local CurrentPos = Vector3.new(StartPos.x + (Norm.x*Range), EndPos.y, StartPos.z + (Norm.z*Range))
            if Engine:IsNotWall(CurrentPos) == false then
                local Mod = math.max(0, Range-100)
                return Vector3.new(StartPos.x + (Norm.x*Mod), EndPos.y, StartPos.z + (Norm.z*Mod))
            end
        end
        
        return EndPos	
    end,
    --FEATURE FUNCTIONS
    GetMinionPrediction = function(self, Target, Start, Speed, Delay, Width, BoundCheck)
        local Path                  = self:GetPath(Target)
        local PredictedPosition     = nil
        local TargetBound           = 0
        local Time2Predict          = 0
        if BoundCheck == 1 or BoundCheck == true then
            TargetBound = Target.CharData.BoundingRadius
        end

        local MovementSpeed = Target.MovementSpeed
        if Path and #Path > 0 then
            local TargetDirPos          = Path[#Path]
            local MovementSpeed         = Target.MovementSpeed
            if Target.AIData.Dashing then
                MovementSpeed = Target.AIData.DashSpeed
            end

            if AkshanSwing and AkshanSwing == true then
                MovementSpeed = 1000
            end
            
            if LastAction ~= nil and LastAction < Time2React then
                LastActionTimer = Time2React - LastAction
            end
            --OpenPredMethod:
            ------------------------------------------------------
            local t = self.SetYourPing.Value * 0.001 + Delay --30 = ping

            if Speed ~= math.huge then
                ----------------Predicted Time with current path-------------------------------
                local eP = TargetDirPos
                local sP = Target.Position
                local timeMissing = Time

                local dx, dy, dz = eP.x - sP.x, eP.y - sP.y, eP.z - sP.z
                local magnitude = math.sqrt(dx * dx + dz * dz)
                local velocity = MovementSpeed
                local travelTime = magnitude / velocity

                dx, dy, dz = (dx / magnitude) * velocity, dy / magnitude, (dz / magnitude) * velocity

                local a = (dx * dx) + (dz * dz) - (Speed * Speed)
                local b = 2 * ((sP.x * dx) + (sP.z * dz) - (Start.x * dx) - (Start.z * dz))
                local c = (sP.x * sP.x) + (sP.z * sP.z) + (Start.x * Start.x) + (Start.z * Start.z) - (2 * Start.x * sP.x) - (2 * Start.z * sP.z)
                local discriminant = (b * b) - (4 * a * c)

                local t1 = (-b + math.sqrt(discriminant)) / (2 * a)
                local t2 = (-b - math.sqrt(discriminant)) / (2 * a)
                
                -- Greater of the two roots
                t = t + math.max(t1, t2)
            end  

            --------------------Path-Multiplier---------------------
            local PathMultiplier = 1
            local PathTime = self:GetPathLength(Path) / MovementSpeed
            if PathTime > 0 and Target.AIData.NavLength > 1 then
                local PathHitRate = PathTime/t
                if PathHitRate < 1 then
                    PathMultiplier = math.min(1,PathTime/t)
                end
            end

            local PredictModifier2Angle          = math.max(MovementSpeed * 0.125, (MovementSpeed * t))

            local PredictedPosition2Angle        = self:GetPointOnPath(Path, PredictModifier2Angle)

            local HitAngle = self:CheckAngle(Start, PredictedPosition2Angle, Target.Position)

            local AdjustMultiplier = 1
            local Degrees = HitAngle * 57.2957795
            if Degrees < 90 then
                local OverAngle = 90 - Degrees
                --print("OverAngle: ",OverAngle)
                if OverAngle < 45 then
                    --print("Too many Degrees: ",Degrees)
                    AdjustMultiplier = math.min(1, (math.max(0, 1 - (OverAngle * 4.444444444) / 100)))
                else
                    --print("Too many Degrees for 0: ",Degrees)
                    AdjustMultiplier = 0
                end
            else
                if Degrees > 90 then
                    AdjustMultiplier = 0
                end
            end

            if self.PredictHitBox.Value == 0 then
                AdjustMultiplier = 0
            end

            if PathMultiplier < 1 then
                AdjustMultiplier = 0
            end
            if Target.AIData.Dashing == true then
                AdjustMultiplier = 0
            end

            local Adjustment            = ((Width / 2) + TargetBound) * AdjustMultiplier

            local PredictModifier       = math.max(MovementSpeed * 0.125, (MovementSpeed * t) - Adjustment)

            Time2Predict                = t
            PredictedPosition           = self:GetPointOnPath(Path, PredictModifier)
            if Speed < 3000 then
                PredictedPosition.y         = Start.y 
            end 
        end
        return PredictedPosition, Time2Predict
    end,
    FixedPosAfterDelay = function(self, Target, Path, Speed, Delay)
        local PathPos 	    = Path
        local TargetPos 	= Target.Position
        local TargetVec 	= Vector3.new(TargetPos.x - PathPos.x, TargetPos.y - PathPos.y, TargetPos.z - PathPos.z)
        local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
        local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
        
        local i 			= math.max(Target.CharData.BoundingRadius, Speed * Delay) * -1
        local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
        return EndPos
    end,
    CheckAngle = function(self, APos, BPos, CPos)
        local VectorB2A = self:GetVectorDirection(APos, BPos)
        local VectorB2C = self:GetVectorDirection(CPos, BPos)

        local DotProductAxB2 = VectorB2A.x * VectorB2C.x + VectorB2A.y * VectorB2C.y + VectorB2A.z * VectorB2C.z

        local AVecSquare2 = VectorB2A.x ^ 2 + VectorB2A.y ^ 2 + VectorB2A.z ^ 2
        local BVecSquare2 = VectorB2C.x ^ 2 + VectorB2C.y ^ 2 + VectorB2C.z ^ 2

        local MagnitudeOfA2 = math.sqrt(AVecSquare2)
        local MagnitudeOfB2 = math.sqrt(BVecSquare2)

        local Beta = DotProductAxB2 / (MagnitudeOfB2 * MagnitudeOfA2)
        
        local AngleOfB = math.acos(Beta)
        return AngleOfB
    end,
    UnknownSideTriangle = function(self, Side1, Side2, Radiants)
        local Cos   = math.cos(Radiants)
        local SqrOfSide3  = Side1^2 + Side2^2 - 2*Side1*Side2 * Cos
        local UnknownSide = math.sqrt(SqrOfSide3)
        return UnknownSide
    end,
    FixedPosHitBox = function(self, Pos2Fix, Path, Adjustment)
        local PathPos 	    = Path
        local TargetPos 	= Pos2Fix
        local TargetVec 	= Vector3.new(TargetPos.x - PathPos.x, TargetPos.y - PathPos.y, TargetPos.z - PathPos.z)
        local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
        local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
        
        local i 			= Adjustment
        local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
        --print("WTF")
        return EndPos
    end,
    TestPredPos = function(self, StartPos, EndPos, CheckPos, TargetSpeed, CastPos, MissileSpeed)
        local Distance      = self:GetDistance(StartPos,EndPos)
        local FirstCastDist = self:GetDistance(StartPos,CastPos)
        local Norm          = self:GetVectorNormalized(self:GetVectorDirection(EndPos, StartPos))
        local Time          = 0

        for Range = 5 , Distance, 5 do
            Time = Time + (5 / TargetSpeed)
            local CurrentPos = Vector3.new(CheckPos.x + (Norm.x*Range), EndPos.y, CheckPos.z + (Norm.z*Range))
            local Side1 = self:GetDistance(StartPos, CurrentPos)
            local Side2 = FirstCastDist
            local Angle = self:CheckAngle(CastPos, StartPos, CurrentPos)
            local UnknownSide = self:UnknownSideTriangle(Side1, Side2, Angle)
            local Time2HitTarget = UnknownSide / MissileSpeed
            local Modifier = 6 / TargetSpeed
            local HitAngle = self:CheckAngle(CastPos, CurrentPos, StartPos)
            --print("Time2HitTarget: ", Time2HitTarget)
            --print("Time: ", Time)
            --print("Distance: ", Distance)
            --print("Range", Range)
            if Time2HitTarget >= (Time - Modifier) and Time2HitTarget <= (Time + Modifier) then
                --print("Works?")
                --print("Angle: ", Angle)
                return Time, CurrentPos, UnknownSide, HitAngle
            end
        end
        
        return nil	
    end,
    IsImmobile = function(self, Hero)
        local ImmobileBuffs = {}
        ImmobileBuffs[Hero.ChampionName] 	= {"Asleep", "Charm", "Fear", "Grounded", "Knockback", "Knockup", "Snare", "Stun", "Suppression", "Taunt"}
    
        local PossibleBuffs = ImmobileBuffs[Hero.ChampionName]
        if PossibleBuffs then
            for i = 1, #PossibleBuffs do
                local Buffname = PossibleBuffs[i]
                local Buff = Hero.BuffData:GetBuff(Buffname)
                if Buff.Count_Alt > 0 and Buff.Valid == true then
                    return Buff.EndTime - GameClock.Time
                end
            end	
        end
        
        return nil	
    end,
    GetHeroLevel = function(self, Hero) 
        local Q = Hero:GetSpellSlot(0).Level
        local W = Hero:GetSpellSlot(1).Level
        local E = Hero:GetSpellSlot(2).Level
        local R = Hero:GetSpellSlot(3).Level
        return Q + W + E + R
    end,    
    GetAttackSpeed = function(self, Hero)
        local AttackRange		    = Hero.AttackRange
        local AttackSpeedMod	    = Hero.AttackSpeedMod
        local BaseAttackSpeed	    = Hero.CharData.BaseAttackSpeed
        local BaseAttackSpeedRatio	= Hero.CharData.BaseAttackSpeedRatio

        if Hero.ChampionName == "Jhin" then
            local AttackSpeedPerLevel = {0.04,0.05,0.06,0.07,0.08,0.09,0.10,0.11,0.12,0.14,0.16,0.20,0.24,0.28,0.32,0.36,0.40,0.44}
            local CurrentAttackSpeedMod = AttackSpeedPerLevel[math.min(18, math.max(1, self:GetHeroLevel(Hero)))] + 1.1
            return BaseAttackSpeed * CurrentAttackSpeedMod
        end
        if Hero.ChampionName == "Sion" then
            if Hero.BuffData:GetBuff("sionpassivezombie").Count_Alt > 0 then
                return 1.75
            end
        end
        local AttackSpeed = BaseAttackSpeed + (BaseAttackSpeedRatio * (AttackSpeedMod-1))
        --print(AttackSpeed)
        local JinxExcited		= Hero.BuffData:GetBuff("JinxPassiveKillAttackSpeed").Count_Alt > 0
        local LethalTempo		= Hero.BuffData:GetBuff("ASSETS/Perks/Styles/Precision/LethalTempo/LethalTempo.lua")
        local Stacks			= LethalTempo.Count_Int
         --print(Stacks)
        if Stacks == 6 or JinxExcited then
             return AttackSpeed
        end

        if Hero.ChampionName == "Zeri" then
            return math.min(AttackSpeed, 1.5)
        end

        return math.min(AttackSpeed, 2.5);    
    end,
    GetHeroAttackDelay = function(self, Hero)
        local AttackSpeed = self:GetAttackSpeed(Hero)
        if Hero.ChampionName == "Graves" then
            return (1 / AttackSpeed) / 2
        end
        return (1 / AttackSpeed)    
    end,
    GetHeroAttackWindup = function(self, Hero)
        local AttackTime 		    = self:GetHeroAttackDelay(Hero)
        local WindupPercent 		= (0.3 + Hero.CharData.CastTimeAdd)
        local WindupModifier		= Hero.CharData.CastTimeMod
        local BaseAttackSpeed       = Hero.CharData.BaseAttackSpeed
        local BaseWindupTime        = (1 / BaseAttackSpeed) * WindupPercent
        return BaseWindupTime + ((AttackTime * WindupPercent) - BaseWindupTime) * WindupModifier --lol wiki
    end,
    ChampionAttackTimer = function(self)
		local AttackTimer = {}
		for _, Hero in pairs(ObjectManager.HeroList) do
            if AttackTimer[Hero.Index] == nil then
                AttackTimer[Hero.Index] = {
                    Object 		= Hero,
                    Timer		= os.clock(),
                }	
            end
            
            local Attacking = AttackTimer[Hero.Index]
            --print(Attacking)
            for _, Element in pairs(self.AttackTimer) do
                local Target      = Element.Object
                local Time   	  = Element.Timer
                --print(Time)
                if Time < os.clock() then
                    local Info = Evade.Spells[Target.ActiveSpell.Info.Name]
                    if Info ~= nil and Info.Delay > 0 then
                        AttackTimer[Hero.Index] = {
                            Object 		= Hero,
                            Timer		= os.clock() + Info.Delay,
                        }	
                    else
                        if Hero.ActiveSpell.IsAutoAttack == true then
                            AttackTimer[Hero.Index] = {
                                Object 		= Hero,
                                Timer		= os.clock() + self:GetHeroAttackWindup(Hero),
                            }
                        end
                    end
                end
            end
		end
		return AttackTimer
	end,
    BlockPredActiveSpells = function(self, Target)
        local QA = GameClock.Time - Target:GetSpellSlot(0).StartTime
        local WA = GameClock.Time - Target:GetSpellSlot(1).StartTime
        local EA = GameClock.Time - Target:GetSpellSlot(2).StartTime
        local RA = GameClock.Time - Target:GetSpellSlot(3).StartTime
        if QA < 0 then
            if Target.ChampionName == "Amumu" or Target.ChampionName == "Kled" or Target.ChampionName == "Yone" or Target.ChampionName == "JarvanIV" or Target.ChampionName == "Nautilus" then
                return true
            end
        end
        if WA < 0 then
            if Target.ChampionName == "Tristana" then
                return true
            end
        end
        if EA < 0 then
            if Target.ChampionName == "Ezreal" or Target.ChampionName == "Leona" or Target.ChampionName == "Caitlyn" or Target.ChampionName == "Ornn" or Target.ChampionName == "Urgot" or Target.ChampionName == "Galio" or Target.ChampionName == "Katarina" or Target.ChampionName == "Zac" or Target.ChampionName == "Akali" then
                return true
            end
        end
        if RA < 0 then
            if Target.ChampionName == "Warwick" or Target.ChampionName == "Shyvana" or Target.ChampionName == "Akali" or Target.ChampionName == "Evelynn" or Target.ChampionName == "RekSai" or Target.ChampionName == "Vi" then
                return true
            end
        end
        return nil	
    end,
    IsAttacking = function(self, Target, NotThisSpell)
        --[[for _, Element in pairs(self.AttackTimer) do
			local Hero      = Element.Object
			local Timer 	= Element.Timer
            if Target.Index == Hero.Index and os.clock() < Timer then
                return Timer
            end
        end]]
        local QA = GameClock.Time - Target:GetSpellSlot(0).StartTime
        local WA = GameClock.Time - Target:GetSpellSlot(1).StartTime
        local EA = GameClock.Time - Target:GetSpellSlot(2).StartTime
        local RA = GameClock.Time - Target:GetSpellSlot(3).StartTime
        if QA < 0 and NotThisSpell ~= 1 then
            if Target.ChampionName == "Amumu" or Target.ChampionName == "Kled" or Target.ChampionName == "Yone" or Target.ChampionName == "JarvanIV" or Target.ChampionName == "Nautilus" then return nil end
            return QA * -1
        end
        if WA < 0 and NotThisSpell ~= 2 then
            if Target.ChampionName == "Tristana" then return nil end
            return WA * -1
        end
        if EA < 0 and NotThisSpell ~= 3 then
            if Target.ChampionName == "Ezreal" or Target.ChampionName == "Leona" or Target.ChampionName == "Caitlyn" or Target.ChampionName == "Ornn" or Target.ChampionName == "Urgot" or Target.ChampionName == "Galio" or Target.ChampionName == "Katarina" or Target.ChampionName == "Zac" or Target.ChampionName == "Akali" then return nil end
            return EA * -1
        end
        if RA < 0 and NotThisSpell ~= 4 then
            if Target.ChampionName == "Warwick" or Target.ChampionName == "Shyvana" or Target.ChampionName == "Akali" or Target.ChampionName == "Evelynn" or Target.ChampionName == "RekSai" or Target.ChampionName == "Vi" then return nil end
            return RA * -1
        end
        return nil	
    end,
    UsingAA = function(self, Target)
        if Target.ActiveSpell.IsAutoAttack == true then
            return self:GetHeroAttackWindup(Target)
        end
        return nil     
    end,
    GetPredictionPosition = function(self, Target, Start, Speed, Delay, Width, Collision, BoundCheck, HitChancePrecentage, Linear)
        if self.Enabled == 0 then return nil, nil end
        if self:BlockPredActiveSpells(Target) == true then return nil, nil end
        local ZhonyasBuff = Target.BuffData:GetBuff("zhonyasringshield")
        local ZhonyasTimer = nil
        local Zhonyas_Valid = ZhonyasBuff.Valid or ZhonyasBuff.Count_Alt > 0

        if Zhonyas_Valid then
            ZhonyasTimer = ZhonyasBuff.EndTime - GameClock.Time
        end

        self:SetupPathAndVisibility(Target)
        --local Morde_Check = Target.BuffData:GetBuff("mordekaiserr_statstealenemy")

        local Vis   = Target.IsVisible
        local Time  = 0
        local PredictedPosition = nil

        -- 0.2 and below default hit pred calculation
        -- 0.3 slow
        -- 0.4 stun
        local hitChance = 0
        local HitChanceOutside = nil

        local IsLinear = 0
        if Linear == true or Linear == 1 then
            IsLinear = 1
        end
            
        

        if HitChancePrecentage ~= nil and HitChancePrecentage >= 1 then
            HitChanceOutside = HitChancePrecentage / 100
        else
            if HitChancePrecentage ~= nil and HitChancePrecentage < 1 then
                HitChanceOutside = HitChancePrecentage
            end
        end

        local LastAction = nil

        if self.ActionTimer[Target.Index] ~= nil then
            LastAction = GameClock.Time - self.ActionTimer[Target.Index]
        end

        local LastActionTimer = 0

        local TargetBound           = 0

        local Time2React            = self.ReactionTime.Value / 100

        if BoundCheck == 1 or BoundCheck == true then
            TargetBound = Target.CharData.BoundingRadius
        end

        if (Target.IsDead == false and Vis == false) or Target.IsTargetable or Zhonyas_Valid then
            if Vis == false then
                Time = Awareness:GetMapTimer(Target)
            end
        
            local Path, AkshanSwing = self.Path[Target.Index], self.Swing[Target.Index]
            if Target.IsMinion then
                Path = self:GetPath(Target)
            end
            if Path and #Path > 0 and Time < 2 then
                local TargetDirPos          = Path[#Path]
                local MovementSpeed         = Target.MovementSpeed
                if Target.AIData.Dashing then
                    MovementSpeed = Target.AIData.DashSpeed
                end

                if AkshanSwing and AkshanSwing == true then
                    MovementSpeed = 1000
                end
                
                if LastAction ~= nil and LastAction < Time2React then
                    LastActionTimer = Time2React - LastAction
                end
                --OpenPredMethod:
                ------------------------------------------------------
                local pingT = self.SetYourPing.Value * 0.001
                local t = pingT + Delay --30 = ping

                if Speed ~= math.huge then
                    ----------------Predicted Time with current path-------------------------------
                    local eP = TargetDirPos
                    local sP = Target.Position
                    local timeMissing = Time

                    local dx, dy, dz = eP.x - sP.x, eP.y - sP.y, eP.z - sP.z
                    local magnitude = math.sqrt(dx * dx + dz * dz)
                    local velocity = MovementSpeed
                    local travelTime = magnitude / velocity

                    if timeMissing < 1 and travelTime > timeMissing then
                        dx, dy, dz = (dx / magnitude) * velocity, dy / magnitude, (dz / magnitude) * velocity

                        local a = (dx * dx) + (dz * dz) - (Speed * Speed)
                        local b = 2 * ((sP.x * dx) + (sP.z * dz) - (Start.x * dx) - (Start.z * dz))
                        local c = (sP.x * sP.x) + (sP.z * sP.z) + (Start.x * Start.x) + (Start.z * Start.z) - (2 * Start.x * sP.x) - (2 * Start.z * sP.z)
                        local discriminant = (b * b) - (4 * a * c)

                        local t1 = (-b + math.sqrt(discriminant)) / (2 * a)
                        local t2 = (-b - math.sqrt(discriminant)) / (2 * a)
                        
                        -- Greater of the two roots
                        t = t + math.max(t1, t2)
                    end
                end  
                ----------------------Test-Prediction-------------------------
                if 0 == 1 then
                    local OpenPredMod = math.max(5, MovementSpeed * t)
                    local OpenPredPos = self:GetPointOnPath(Path, OpenPredMod)
                    Render:DrawCircle(OpenPredPos, 50 ,0,255,0,255)
                end
                --------------------------------------------------------
                --------------------Path-Multiplier---------------------
                local PathMultiplier = 1
                local PathTime = self:GetPathLength(Path) / MovementSpeed
                if PathTime > 0 and Target.AIData.NavLength > 1 then
                    local PathHitRate = PathTime/t
                    if PathHitRate < 1 then
                        PathMultiplier = math.min(1,PathTime/t)
                    else
                        if LastActionTimer > 0 then
                            local TimerAdjustment = LastActionTimer / Time2React
                            PathMultiplier = math.min((math.min(1,PathTime/t) + (PathHitRate - 1) / 10)*TimerAdjustment, 1.5)
                        end
                    end
                end
                --------------------------------------------------------
                local t2HitStandBy = math.max(t, (self.SetYourPing.Value * 0.001 + Delay + (self:GetDistance(Target.Position, Start) / Speed)))
                --------------------------------------------------------
                local isImmobile = self:IsImmobile(Target)
                local isAttacking = self:IsAttacking(Target, 0)
                local isAAing     = self:UsingAA(Target)
                if AkshanSwing and AkshanSwing == true then
                    hitChance = 0.99
                elseif Target.AIData.Dashing then
                    hitChance = 0.99
                elseif isImmobile ~= nil then
                    if t < isImmobile then
                        hitChance = 0.99
                    else
                        hitChance = math.min(0.99, ((Width/2 + TargetBound) / MovementSpeed) / (t - isImmobile))
                    end
                elseif isAttacking ~= nil then
                    hitChance = math.min(0.99, ((Width/2 + TargetBound) / MovementSpeed) / (t - isAttacking))
                elseif isAAing ~= nil then
                    hitChance = math.min(0.99, ((Width/2 + TargetBound) / MovementSpeed) / (t - isAAing))
                elseif Target.AIData.Moving == true and Target.AIData.NavLength > 1 then
                    hitChance = math.min(0.99, ((Width/2 + TargetBound) / MovementSpeed) / (t - LastActionTimer))
                else
                    hitChance = math.min(0.7, ((Width/2 + TargetBound) / MovementSpeed) / (t2HitStandBy - LastActionTimer))
                end
                --print("NavL: ",Target.AIData.NavLength)
                hitChance = hitChance * PathMultiplier

                if Vis == false then
                    hitChance = hitChance * 0.5
                end

                local PredictModifier2Angle          = math.max(MovementSpeed * 0.125, (MovementSpeed * t))

                local PredictedPosition2Angle        = self:GetPointOnPath(Path, PredictModifier2Angle)

                local HitAngle = self:CheckAngle(Start, PredictedPosition2Angle, Target.Position)

                local AdjustMultiplier = 1
                local Degrees = HitAngle * 57.2957795
                if IsLinear == 1 and PathTime > 0 and Target.AIData.NavLength > 1 then
                    if Degrees < 90 then
                        local OverAngle = 90 - Degrees
                        --print("OverAngle: ",OverAngle)
                        if OverAngle < 20 then
                            --print("Too many Degrees: ",Degrees)
                            AdjustMultiplier = math.min(1, (math.max(0, 1 - (OverAngle * 5) / 100)))
                        else
                            --print("Too many Degrees for 0: ",Degrees)
                            AdjustMultiplier = 0
                        end
                    else
                        if Degrees > 90 then
                            local OverAngle = Degrees - 90
                            --print("OverAngle: ",OverAngle)
                            if OverAngle < 5 then
                                --print("Too many Degrees: ",Degrees)
                                AdjustMultiplier = math.min(1, (math.max(0, 1 - (OverAngle * 20) / 100)))
                            else
                                --print("Too many Degrees for 0: ",Degrees)
                                AdjustMultiplier = 0
                            end
                        end
                    end
                end

                if Collision == 1 and IsLinear == 1 then
                    if self:WillCollideWithMinionPrediction(Start, PredictedPosition2Angle, Speed, Delay, Width + TargetBound, BoundCheck) == true then
                        --print("MinionsCollide: True")
                        hitChance = hitChance * 1.5
                        AdjustMultiplier = 0
                        --print("MinionsCollide: false")
                    end
                end

                if self.PredictHitBox.Value == 0 and IsLinear == 1 then
                    AdjustMultiplier = 0
                end

                if PathMultiplier < 1 and IsLinear == 1 then
                    AdjustMultiplier = 0
                end
                if Target.AIData.Dashing == true then
                    AdjustMultiplier = 0
                end
                --print(AdjustMultiplier)
                
                local Adjustment            = ((Width / 2) + TargetBound) * AdjustMultiplier
                if Adjustment > 0 and IsLinear == 1 then
                    hitChance = hitChance + hitChance * ((Adjustment/MovementSpeed)/2) 
                end
                --print(HitChanceOutside)
                --print("timing: ",t)
                if Zhonyas_Valid then
                    hitChance = 10
                    --print(ZhonyasTimer)
                    local ZhonyasHit = math.max(t, (self.SetYourPing.Value * 0.001 + Delay + ((self:GetDistance(Target.Position, Start) - ((Width / 2) + TargetBound)) / Speed)))
                    t = ZhonyasHit
                    if ZhonyasTimer ~= nil and ZhonyasTimer > t then
                        --print("Shouldnt Cast: ",ZhonyasTimer)
                        return nil, nil
                    else
                        --print("Should Cast: ",ZhonyasTimer)
                        --print("timing: ",t)
                        return Target.Position, t
                    end
                end

                local PredictModifier       = math.max(MovementSpeed * 0.125, (MovementSpeed * t) - Adjustment)
                --print("Degrees2Hit: ",Degrees)
                --print("Adjustment2Hit: ",Adjustment)
                --checkpoint
                PredictedPosition           = self:GetPointOnPath(Path, PredictModifier)
                if Speed < 3000 then
                    PredictedPosition.y         = Start.y  
                end
            end
        end
        if Vis == false and PredictedPosition and self:CheckFoWPosition(PredictedPosition) == false then
            return nil, nil
        end
        --print("HitChance: ",hitChance)
        if HitChanceOutside == nil and self.PredHitChance.Value / 100 >= hitChance then
            return nil, nil
        else
            --print(hitChance)
            if HitChanceOutside ~= nil and HitChanceOutside >= hitChance then
                return nil, nil
            end
        end

        if Collision == 1 and Linear == 1 then
            if self:WillCollideWithMinionPrediction(Start, PredictedPosition, Speed, Delay, Width, BoundCheck) == true and self:WillCollideWithMinion(Start, Target.Position, Width/2) == true then
                return nil, nil
            end
        end
        --print("HittingHitChance: ",hitChance)
        return PredictedPosition, t
    end,
    GetTargetSelectorList = function(self, Position, Range)
        local ForceTarget = Orbwalker.ForceTarget
        if ForceTarget and self.ForceTargetOnly.Value == 1 and ForceTarget.IsDead == false and ForceTarget.Health > 0 and ForceTarget.IsHero then
            return { ForceTarget }
        end	
        
        local Mode = Orbwalker.TargetOptions[Orbwalker.TargetMode.Selected+1]
        local List = self:GetAllEnemyHeros()
       
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
        end

        if Mode == "PRIO_LOWHP" then
            for left = 1, #CurrentList do  
                for right = left+1, #CurrentList do
                    local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
                    local RightPio = Orbwalker.Prio[CurrentList[right].Index]
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
                    local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
                    local RightPio = Orbwalker.Prio[CurrentList[right].Index]
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
                    local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
                    local RightPio = Orbwalker.Prio[CurrentList[right].Index]
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
                    local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
                    local RightPio = Orbwalker.Prio[CurrentList[right].Index]
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
                    local LeftPrio = Orbwalker.Prio[CurrentList[left].Index]
                    local RightPio = Orbwalker.Prio[CurrentList[right].Index]
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
        end
        return CurrentList    
    end,
    GetCastPos = function(self, StartPosition, Range, MissileSpeed, MissileWidth, CastTime, Collision, BoundCheck, HitChancePrecentage, Linear)
        Range = Range * 0.95
        local ScreenPosition    = Vector3.new()
        local TargetSelector    = self:GetTargetSelectorList()
        for _, Hero in pairs(TargetSelector) do
            -- print('LastTargetTime', self.LastTargetTime)
            -- print('LastTarget', self.LastTarget)
            if self.LastTargetTime ~= nil and GameClock.Time < self.LastTargetTime and self.UseCachedTargetPrio.Value == 1 then
                if Hero.ChampionName == self.LastTarget then
                    if Hero.IsDead or not Hero.IsTargetable then
                        self.LastTargetTime = nil
                        self.LastTarget = nil
                        ::continue::
                    end
                    -- add multiple checks eg. if cache enemy can't be hit then after x seconds of self.CacheTimeForLastTarget.Value total time to cast on other enemy
                    -- sorry christoph for making a mess of this code block, i will fix it :pepolove:
                    local PredictionPosition, TimeToHit = self:GetPredictionPosition(Hero, StartPosition, MissileSpeed, CastTime, MissileWidth, Collision, BoundCheck, HitChancePrecentage, Linear)
                    local HeroRadius = 0
                    if BoundCheck == 1 or BoundCheck == true then
                        HeroRadius = Hero.CharData.BoundingRadius
                    end
                    if PredictionPosition and self:GetDistance(StartPosition, PredictionPosition) < Range and self:GetDistance(StartPosition, Hero.Position) < Range + MissileWidth/2+HeroRadius then
                        if Render:World2Screen(PredictionPosition, ScreenPosition) == true then
                            if Collision == 0 or (self:WillCollideWithMinionPrediction(StartPosition, PredictionPosition, MissileSpeed, CastTime, MissileWidth, BoundCheck) == false and self:WillCollideWithMinion(StartPosition, Hero.Position, MissileWidth/2) == false) then
                                self.LastTargetTime = GameClock.Time + self.CacheTimeForLastTarget.Value
                                self.LastTarget = Hero.ChampionName
                                return PredictionPosition, Hero
                            end
                        end
                    end
                end
            else
                local PredictionPosition, TimeToHit = self:GetPredictionPosition(Hero, StartPosition, MissileSpeed, CastTime, MissileWidth, Collision, BoundCheck, HitChancePrecentage, Linear)
                local HeroRadius = 0
                if BoundCheck == 1 or BoundCheck == true then
                    HeroRadius = Hero.CharData.BoundingRadius
                end
                if PredictionPosition and self:GetDistance(StartPosition, PredictionPosition) < Range and self:GetDistance(StartPosition, Hero.Position) < Range + MissileWidth/2+HeroRadius then
                    if Render:World2Screen(PredictionPosition, ScreenPosition) == true then
                        if Collision == 0 or (self:WillCollideWithMinionPrediction(StartPosition, PredictionPosition, MissileSpeed, CastTime, MissileWidth, BoundCheck) == false and self:WillCollideWithMinion(StartPosition, Hero.Position, MissileWidth/2) == false) then
                            self.LastTargetTime = GameClock.Time + self.CacheTimeForLastTarget.Value
                            self.LastTarget = Hero.ChampionName
                            return PredictionPosition, Hero
                        end
                    end
                end
            end 
        end        
        return nil, nil
    end,
    --OLD FUNCTIONS
    GetPredPos = function(self, StartPos, Target, Speed, CastTime)
        return self:GetPredictionPosition(Target, StartPos, Speed, CastTime, 0, 0, 0, 0.001, 1)
    end,
    LockedCamOnSpaceFix = function(self)
        if Engine:IsKeyDown("HK_COMBO") == false then
            self.LockCamPressed = 0
        end
        if Engine:IsKeyDown("HK_COMBO") == true and self.Enabled == 1 and self.LockCamPressed == 0 then
            self.Enabled        = 0
            self.LockCamPressed = 1
            self.LockCamTime    = os.clock()
        end
        if self.Enabled == 0 then
            local Timer = os.clock() - self.LockCamTime
            if Timer > 0.2 then
                self.Enabled = 1
            end
        end
    end,
    DistanceToLine2D = function(self, line_start, line_end, point)
        local normalLength = math.hypot(line_start.x - line_end.x, line_start.y - line_end.y);
        local distance = ((point.x - line_end.x) * (line_start.y - line_end.y) - (point.y - line_end.y) * (line_start.x - line_end.x)) / normalLength;
        return math.abs(distance);
    end,
    DistanceToLine3D = function(self, line_start, line_end, point)
        local normalLength = math.hypot(line_start.x - line_end.x, line_start.z - line_end.z);
        local distance = ((point.x - line_end.x) * (line_start.z - line_end.z) - (point.z - line_end.z) * (line_start.x - line_end.x)) / normalLength;
        return math.abs(distance);
    end,
    GetShortestPointToLine3D = function(self, LineStart, LineEnd, Point)
        local xDiff = LineEnd.x - LineStart.x
        local zDiff = LineEnd.z - LineStart.z
        local lenLine2 = xDiff * xDiff + zDiff * zDiff
        local partDiv = ((Point.x - LineStart.x) * xDiff + (Point.z - LineStart.z) * zDiff) / lenLine2
        local x = (LineStart.x + partDiv * (LineEnd.x - LineStart.x))
        local z = (LineStart.z + partDiv * (LineEnd.z - LineStart.z))
        return Vector3.new(x, Point.y, z)
    end,
    LineIntersection3D = function(self, line1_start, line1_end, line2_start, line2_end)
        local s1_x = line1_end.x - line1_start.x   
        local s1_z = line1_end.z - line1_start.z
        local s2_x = line2_end.x - line2_start.x   
        local s2_z = line2_end.z - line2_start.z

        local s = (-s1_z * (line1_start.x - line2_start.x) + s1_x * (line1_start.z - line2_start.z)) / (-s2_x * s1_z + s1_x * s2_z)
        local t = (s2_x * (line1_start.z - line2_start.z) - s2_z * (line1_start.x - line2_start.x)) / (-s2_x * s1_z + s1_x * s2_z)

        if (s >= 0 and s <= 1 and t >= 0 and t <= 1)then
            --Collision detected
            local I_Point = Vector3.new(line1_start.x + (t * s1_x), line1_start.y, line1_start.z + (t * s1_z))
            return true, I_Point
        end
        return false, nil --No collision
    end,
    GetAkshanCircle = function(self, Target)       
        local Center    = nil
        local Radius    = nil
        local Direction = nil
        local Missiles = ObjectManager.MissileList
        for _, Missile in pairs(Missiles) do
            if Missile.SourceIndex == Target.Index and (Missile.Name == "AkshanEOrbitalClockwise" or Missile.Name == "AkshanEOrbitalCounterClockwise") then
                Center      = Missile.MissileEndPos
                Radius      = self:GetDistance(Target.Position, Center)
                Direction   = Missile.Position
                break
            end
        end

        local Circle = { Target.Position }
        if Direction and Center and Radius then
            local Pos  = Target.Position
            local Norm = self:GetVectorNormalized(self:GetVectorDirection(Direction, Pos))

            local Points = 10
            for Index = 1, Points do
                local Predict   = Vector3.new(Pos.x + (Norm.x*100)*Index, Pos.y, Pos.z + (Norm.z*100)*Index)
                local Normalize = self:GetVectorNormalized(self:GetVectorDirection(Predict, Center))
                local Point     = Vector3.new(Center.x + (Normalize.x*Radius), Center.y, Center.z + (Normalize.z*Radius))
                if Engine:IsNotWall(Point) then
                    Circle[#Circle+1] = Point
                else
                    break 
                end
            end
            return Circle, true
        end
        return nil, false
    end,
    GetPath = function(self, Target)
        local TargetPos         = Target.Position
        local NavPoints         = { TargetPos }

        local NunuW = Target.BuffData:GetBuff("NunuW")
        if NunuW.Count_Alt > 0 then
            local Time      = NunuW.EndTime - GameClock.Time
            local Modifier  = Target.MovementSpeed * math.max(0, math.min(1, Time))
            local Predict   = Vector3.new(TargetPos.x + (Target.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (Target.Direction.z*Modifier))
            NavPoints[#NavPoints+1] = self:GetWallPosition(Target.Position, Predict)
        else
            local AkshanCircle = self:GetAkshanCircle(Target)
            if AkshanCircle then return AkshanCircle else
                if Target.AIData.Dashing == false then
                    if Target.AIData.Moving then
                        local MaxNavLength      = Target.AIData.NavLength
                        local NextNavPoint      = Target.AIData.NextNavPoint
                        for Current = NextNavPoint, math.max(0, MaxNavLength - 1) do
                            NavPoints[#NavPoints+1] = Target.AIData:GetNavPoint(Current)
                        end
                    end
                else
                    NavPoints[#NavPoints+1] = Target.AIData.TargetPos
                end
            end         
        end
        return NavPoints
    end,
    GetPathDraw = function(self, Target)
        local TargetPos         = Target.Position
        local NavPoints         = { TargetPos }

        local NunuW = Target.BuffData:GetBuff("NunuW")
        if NunuW.Count_Alt > 0 then
            local Time      = NunuW.EndTime - GameClock.Time
            local Modifier  = Target.MovementSpeed * math.max(0, math.min(1, Time))
            local Predict   = Vector3.new(TargetPos.x + (Target.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (Target.Direction.z*Modifier))
            NavPoints[#NavPoints+1] = self:GetWallPosition(Target.Position, Predict)
        else
            local AkshanCircle = self:GetAkshanCircle(Target)
            if AkshanCircle then return AkshanCircle else
                if Target.AIData.Dashing == false then
                    if Target.AIData.Moving then
                        local MaxNavLength      = Target.AIData.NavLength
                        local NextNavPoint      = Target.AIData.NextNavPoint
                        for Current = NextNavPoint, math.max(0, MaxNavLength - 1) do
                            NavPoints[#NavPoints+1] = Target.AIData:GetNavPoint(Current)    
                        end
                    end
                else
                    NavPoints[#NavPoints+1] = Target.AIData.TargetPos
                end
            end         
        end
        return NavPoints
    end,
    GetPathLength = function(self, Path)
        local Length = 0
        for Current = 1, math.max(1, #Path - 1) do
            local CurrentPoint  = Path[Current]
            local NextPoint     = Path[Current+1]
            if CurrentPoint and NextPoint then Length = Length + self:GetDistance(CurrentPoint, NextPoint) end   
        end
        return Length
    end,
    GetPointOnPath = function(self, Path, Distance)
        local Traveled = 0
        for Current = 1, math.max(1, #Path - 1) do
            local CurrentPoint  = Path[Current]
            local NextPoint     = Path[Current+1]
            if CurrentPoint and NextPoint then
                Traveled = Traveled + self:GetDistance(CurrentPoint, NextPoint)
                if Traveled >= Distance then
                    local Diff = Traveled - Distance
                    local Norm = self:GetVectorNormalized(self:GetVectorDirection(CurrentPoint, NextPoint))
                    local X = NextPoint.x + (Norm.x * Diff)
                    local Y = NextPoint.y + (Norm.y * Diff)
                    local Z = NextPoint.z + (Norm.z * Diff)                
                    return Vector3.new(X,Y,Z)
                end
            end
        end 
        return Path[#Path]
    end,
    GetCirclePoints = function(self, Center, Radius)
        local Points = 6
        local Circle = {}
        local WedgeAngle = (2 * math.pi) / Points
        for i = 0, Points do
            local Theta = i * WedgeAngle;
            local X = math.cos(Theta) * Radius + Center.x
            local Y = Center.y
            local Z = math.sin(Theta) * Radius + Center.z
            Circle[#Circle+1] = Vector3.new(X,Y,Z)
        end
        return Circle
    end, 
    CheckFoWPosition = function(self, CheckPos)
        if CheckPos then
            local FoWCircle = self:GetCirclePoints(CheckPos, 150)
            if Engine:IsNotWall(CheckPos) == false then return false end 
            for _, Point in pairs(FoWCircle) do
                if Engine:IsInFoW(Point) == false then
                    return false
                end
            end
        end
        return true
    end,   
    SetupPathAndVisibility = function(self, Enemy)
        if Enemy.IsDead or (GameClock.Time - Awareness:GetRecallFinishTime(Enemy) < 1) then
            self.Path[Enemy.Index]      = {}
            self.Swing[Enemy.Index]     = nil
            return
        end
        if Enemy.IsVisible ~= self.Visible[Enemy.Index] then
            self.Visible[Enemy.Index] = Enemy.IsVisible
            if Enemy.IsVisible then
                self.Path[Enemy.Index]      = {}
                self.Swing[Enemy.Index]     = nil
                self.VisTime[Enemy.Index]   = os.clock()
                return
            else
                self.VisTime[Enemy.Index] = 0
                return
            end
        end
        if Enemy.AIData.NavLength > 0 then
            self.Path[Enemy.Index], self.Swing[Enemy.Index] = self:GetPath(Enemy)
            --Render:DrawCircle(Target.AIData.TargetPos, )
            local CurrentClick = Enemy.AIData.TargetPos.x
            if CurrentClick ~= self.Action[Enemy.Index] then
                self.ActionTimer[Enemy.Index] = GameClock.Time
                self.Action[Enemy.Index] = Enemy.AIData.TargetPos.x
            end
        end
    end,
    --CALLBACK FUNCTIONS
    OnTick = function(self)
        self.AttackTimer = self:ChampionAttackTimer()
        local Enemies = self:GetAllEnemyHeros()
        for _, Enemy in pairs(Enemies) do
            self:SetupPathAndVisibility(Enemy)
            --if self:IsImmobile(Enemy) ~= nil then
                --print(self:IsImmobile(Enemy))
            --end
           -- if self:IsAttacking(Enemy) ~= nil then
                --print(self:IsAttacking(Enemy))
            --else
                --print("Not Attacking")
            --end
            --Enemy.BuffData:ShowAllBuffs()
        end
        --[[if self:IsAttacking(myHero) then
            print(self:IsAttacking(myHero))
        end]]
        if self.PlayWithLockedCamOnSpace.Value == 1 then
            self:LockedCamOnSpaceFix()
        end

        if self.UseCachedTargetPrio.Value == 1 and self.LastTargetTime ~= nil then
            if GameClock.Time >= self.LastTargetTime then
                self.LastTarget = nil
                self.LastTargetTime = nil
            end
        end
    end,
    OnDraw = function(self)
       -- print(GameClock.Time)--myHero.AIData:GetBase())
        --local CheckPos  = GameHud.MousePos
        --print(self:CheckFoWPosition(CheckPos))
        -- local Path = self:GetPathDraw(myHero)
        -- for _,Point in pairs(Path) do
        --     Render:DrawCircle(Point, 65,255,255,255,255)
        -- end
        --[[
        local PredPos = self:GetPredictionPosition(myHero, myHero.Position, 500, 1, 0, 0, 0, HitChancePrecentage, Linear)
        if PredPos then
            Render:DrawCircle(PredPos, 65,255,0,0,255)
        end]]
    end,
    OnLoad = function(self) 
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)
        AddEvent("OnDraw", function() self:OnDraw() end)
    end,
}

AddEvent("OnLoad", function() Prediction:OnLoad() end)














function math.hypot(x, y)
	local t
	x = math.abs(x)
	y = math.abs(y)
	t = math.min(x, y)
	x = math.max(x, y)
	if x == 0 then return 0 end
	t = t / x
	return x * math.sqrt(1 + t * t)
end
