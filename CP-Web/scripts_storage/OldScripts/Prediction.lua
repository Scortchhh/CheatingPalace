Prediction = {
    Init = function(self) 
        self.Enabled         = 1
        self.LockCamPressed  = 0
        self.TickTime        = os.clock()
        self.LastTick        = os.clock()
        self.LockCamTime     = os.clock()

        self.Path       = {}
        self.Swing      = {}

        self.Visible    = {}
        self.VisTime    = {}

        self.Menu 							    = Menu:CreateMenu("Prediction")
        self.Menu:AddLabel("COMBO and LockCam same key(e.g. SPACE:")
        self.PlayWithLockedCamOnSpace 		    = self.Menu:AddCheckbox("Enabled", 0)
        self.Menu:AddLabel("Only cast spells on ForceTarget if set:")
        self.ForceTargetOnly					= self.Menu:AddCheckbox("Enabled", 1)
        self.Menu:AddLabel("Prediction Percentage:")
        self.PredPercentage						= self.Menu:AddSlider("", 100, 75, 125, 1)	

        self:LoadSettings()
    end,
    SaveSettings = function(self) 
    	SettingsManager:CreateSettings			("Prediction")
	    SettingsManager:AddSettingsGroup		("Settings")
        SettingsManager:AddSettingsInt			("ForceTargetOnly", self.ForceTargetOnly.Value)
        SettingsManager:AddSettingsInt			("PlayWithLockedCamOnSpace", self.PlayWithLockedCamOnSpace.Value)
        SettingsManager:AddSettingsInt			("PredPercentage", self.PredPercentage.Value)

    end,
    LoadSettings = function(self) 
        SettingsManager:GetSettingsFile			("Prediction")
        self.ForceTargetOnly.Value              = SettingsManager:GetSettingsInt("Settings","ForceTargetOnly")
        self.PlayWithLockedCamOnSpace.Value     = SettingsManager:GetSettingsInt("Settings","PlayWithLockedCamOnSpace")
        self.PredPercentage.Value 				= SettingsManager:GetSettingsInt("Settings","PredPercentage")
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
    WillCollideWithMinionPrediction = function(self, Start, End, Speed, Delay, Width)
        local Minions = ObjectManager.MinionList
        for I,Minion in pairs(Minions) do
            if Minion.IsTargetable and Minion.Team ~= myHero.Team and Minion.MaxHealth > 100  then
                local MovePosition  = self:GetMinionPrediction(Minion, Start, Speed, Delay, Width)
                if MovePosition then
                    local Distance1     = self:GetDistance(Start, End)
                    local Distance2     = self:GetDistance(Start, MovePosition)
                    if Distance1 > Distance2 and self:PointOnLineSegment(Start, End, MovePosition, Minion.CharData.BoundingRadius + Width) == true  then
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
    GetMinionPrediction = function(self, Target, Start, Speed, Delay, Width)
        local Path                  = self:GetPath(Target)
        local PredictTime           = 0
        local PredictedPosition     = nil
        if Path and #Path > 0 then
            local ObjectDistance        = self:GetDistance(Path[1], Start)
            PredictTime                 = Delay + (ObjectDistance/Speed)
            local MovementSpeed         = Target.MovementSpeed

            local PredictSlider         = self.PredPercentage.Value / 100.0
            local PredictModifier       = math.max(Target.CharData.BoundingRadius, (MovementSpeed * PredictTime) - Target.CharData.BoundingRadius) * PredictSlider

            PredictedPosition           = self:GetPointOnPath(Path, PredictModifier)
        end
        return PredictedPosition, PredictTime
    end,
    GetPredictionPosition = function(self, Target, Start, Speed, Delay, Width, Collision)
        if self.Enabled == 0 then return nil, nil end
        self:SetupPathAndVisibility(Target)
        --local Morde_Check = Target.BuffData:GetBuff("mordekaiserr_statstealenemy")

        local Vis   = Target.IsVisible
        local Time  = 0
        local PredictTime = 0
        local PredictedPosition = nil

        if (Target.IsDead == false and Vis == false) or Target.IsTargetable then
            if Vis == false then
                Time = Awareness:GetMapTimer(Target)
            end

            local Path, AkshanSwing = self.Path[Target.Index], self.Swing[Target.Index]
            if Target.IsMinion then
                Path = self:GetPath(Target)
            end
            if Path and #Path > 0 and Time < 2 then
                local Bound                 = Target.CharData.BoundingRadius/2
                local ObjectPosition        = Target.Position
                local ObjectDistance        = self:GetDistance(Path[1], Start) 
                
                PredictTime                 = Delay + (ObjectDistance/Speed) + Time
                local MovementSpeed         = Target.MovementSpeed
                if AkshanSwing and AkshanSwing == true then
                    MovementSpeed = 1000
                end
                if Target.AIData.Dashing then
                    MovementSpeed = Target.AIData.DashSpeed
                end

                local PredictSlider         = self.PredPercentage.Value / 100.00
                local PredictModifier       = math.max(Target.CharData.BoundingRadius, (MovementSpeed * PredictTime) - Bound) * PredictSlider
                local TargetPosition        = Path[#Path]
                
                PredictedPosition           = self:GetPointOnPath(Path, PredictModifier)
            end
        end
        if Vis == false and PredictedPosition and self:CheckFoWPosition(PredictedPosition) == false then
            return nil, nil
        end
        return PredictedPosition, PredictTime
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
    GetCastPos = function(self, StartPosition , Range, MissileSpeed, MissileWidth, CastTime, Collision)
        local ScreenPosition    = Vector3.new()
        local TargetSelector    = self:GetTargetSelectorList()
        for _, Hero in pairs(TargetSelector) do
            local PredictionPosition, TimeToHit = self:GetPredictionPosition(Hero, StartPosition, MissileSpeed, CastTime, MissileWidth, Collision)
            if PredictionPosition and self:GetDistance(StartPosition, PredictionPosition) < Range and self:GetDistance(StartPosition, Hero.Position) < Range + 100 then
                if Render:World2Screen(PredictionPosition, ScreenPosition) == true then
                    if Collision == 0 or (self:WillCollideWithMinionPrediction(StartPosition, PredictionPosition, MissileSpeed, CastTime, MissileWidth) == false and self:WillCollideWithMinion(StartPosition, Hero.Position, MissileWidth/2) == false) then
                        return PredictionPosition, Hero
                    end
                end
            end    
        end        
        return nil, nil
    end,
    --OLD FUNCTIONS
    GetPredPos = function(self, StartPos, Target, Speed, CastTime)
        return self:GetPredictionPosition(Target, StartPos, Speed, CastTime, 0, 0)
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
        end
    end,
    --CALLBACK FUNCTIONS
    OnTick = function(self)
        local Enemies = self:GetAllEnemyHeros()
        for _, Enemy in pairs(Enemies) do
            self:SetupPathAndVisibility(Enemy)
        end

        if self.PlayWithLockedCamOnSpace.Value == 1 then
            self:LockedCamOnSpaceFix()
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
        local PredPos = self:GetPredictionPosition(myHero, myHero.Position, 500, 1, 0, 0)
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
