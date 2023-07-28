SupportLib = {
    --Util functions
    SortList = function(self, List, Mode) 
        local CurrentList = {}
        for _, Object in pairs(List) do
            CurrentList[#CurrentList+1] = Object
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
    GetAllEnemies = function(self)
        local Enemies = {}
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
            if Object.Team ~= myHero.Team then
                Enemies[#Enemies+1] = Object
            end
        end
        return Enemies
    end,
    GetAllAllies = function(self)
        local Allies = {}
        local Heros = ObjectManager.HeroList
        for _, Object in pairs(Heros) do
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
    GetEnemiesInRange = function(self, Position, Range)
        local InRange = {}
        local Enemies = self:GetAllEnemies()
        for _, Object in pairs(Enemies) do
            if self:GetDistance(Object.Position, Position) < Range and Object.IsTargetable then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetAlliesInRange = function(self, Position, Range)
        local InRange = {}
        local Allies = self:GetAllAllies()
        for _, Object in pairs(Allies) do
            if self:GetDistance(Object.Position, Position) < Range and Object.IsTargetable then
                InRange[#InRange+1] = Object
            end
        end
        return InRange
    end,
    GetDistance = function(self, from, to)
        return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
    end,
    PointOnLineSegment = function(self, Start, End, Point, Radius)
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
    --Save Ally functions
    GetHealTarget = function(self, Range, HealPercent) 
        local Allies = self:GetAlliesInRange(myHero.Position, Range)
        local Sorted = self:SortList(Allies, "LOWHP")
        for _, Object in pairs(Sorted) do
            local CurrentHealthInPercent = Object.Health/Object.MaxHealth
            if Object.IsTargetable and CurrentHealthInPercent <= HealPercent and Object.Index ~= myHero.Index then
                return Object
            end
        end
        return nil 
    end,
    GetHealTargetWithTable = function(self, Range, Table) 
        local Allies    = self:GetAlliesInRange(myHero.Position, Range)
        local Sorted    = self:SortList(Allies, "LOWHP")
        for _, Object in pairs(Sorted) do
            local CurrentAlly               = Table[Object.Index]
            if CurrentAlly then
                local HealPercent            = CurrentAlly.Value/100
                local CurrentHealthInPercent = Object.Health/Object.MaxHealth
                if CurrentHealthInPercent <= HealPercent then
                    return Object
                end
            end
        end
    end,
    GetShieldTarget = function(self, Range, ShieldPercent) 
        local Enemies   = self:GetAllEnemies()
        local Allies    = self:GetAlliesInRange(myHero.Position, Range)
        local Sorted    = self:SortList(Allies, "LOWHP")

        local Heros     = ObjectManager.HeroList
        local Turrets   = ObjectManager.TurretList
        local Minions   = ObjectManager.MinionList
        local Missiles  = ObjectManager.MissileList

        for _, Object in pairs(Sorted) do
            local CurrentHealthInPercent = Object.Health/Object.MaxHealth
            if CurrentHealthInPercent <= ShieldPercent then
                for _, Missile in pairs(Missiles) do
                    local SourceID = Missile.SourceIndex
                    local TargetID = Missile.TargetIndex

                    local Source = Heros[SourceID]
                    if Source == nil then Source = Turrets[SourceID] end
                    if Source == nil then Source = Minions[SourceID] end
                    if Source and Source.Team ~= myHero.Team and ((Source.IsHero or Source.IsTurret) or Source.Team == 300) then
                        if TargetID > 0 and TargetID < 3500 then
                            if TargetID == Object.Index then 
                                return Object, Missile
                            end
                        else
                            local Radius = 70
                            local StartPos, EndPos = Missile.MissileStartPos, Missile.MissileEndPos
                            if Evade and Evade.Spells[Missile.Name] then
                                Radius = Evade.Spells[Missile.Name].Radius
                                StartPos, EndPos = Evade:CalcLinearMissileStartEndPos(Missile, StartPos, EndPos, Evade.Spells[Missile.Name])
                            end
                            if self:GetDistance(Object.Position, Missile.Position) <= Object.CharData.BoundingRadius + Radius*2 and self:PointOnLineSegment(StartPos, EndPos, Object.Position, Radius*2) then
                                return Object, Missile
                            end
                        end    
                    end
                end
            end
        end
        for _, Enemy in pairs(Enemies) do
            if Enemy.IsTargetable then
                if string.len(Enemy.ActiveSpell.Info.Name) > 0 and Enemy.ActiveSpell.IsAutoAttack == false then
                    local Type                      = 0
                    local Radius                    = 70
                    local StartPos, EndPos, CastPos = Enemy.ActiveSpell.StartPos, Enemy.ActiveSpell.EndPos, Enemy.ActiveSpell.CastPos
                    if Evade and Evade.Spells[Enemy.ActiveSpell.Info.Name] then
                        Type                = Evade.Spells[Enemy.ActiveSpell.Info.Name].Type
                        Radius              = Evade.Spells[Enemy.ActiveSpell.Info.Name].Radius
                        StartPos, EndPos    = Evade:CalcLinearSpellStartEndPos(StartPos, EndPos, Evade.Spells[Enemy.ActiveSpell.Info.Name]);
                    end

                    local Allies = self:GetAlliesInRange(myHero.Position, Range)
                    local Sorted    = self:SortList(Allies, "LOWHP")
                    for _, Ally in pairs(Sorted) do
                        local CurrentHealthInPercent = Ally.Health/Ally.MaxHealth
                        if CurrentHealthInPercent <= ShieldPercent then
                            if Type == 0 then
                                if self:GetDistance(StartPos, Ally.Position) <= Ally.CharData.BoundingRadius + Radius*2 and self:PointOnLineSegment(StartPos, EndPos, Ally.Position, Radius*2) then
                                    return Ally, Enemy
                                end    
                            else
                                if self:GetDistance(EndPos, Ally.Position) <= Ally.CharData.BoundingRadius + Radius then
                                    return Ally, Enemy
                                end    
                            end
                        end
                    end 
                end

                if Enemy.AttackRange < 300 then
                    local StartPos = Enemy.Position
                    if Enemy.AIData.Dashing then
                        StartPos = Enemy.AIData.TargetPos
                    end

                    local Allies = self:GetAlliesInRange(StartPos, Enemy.AttackRange + 200)
                    local Sorted    = self:SortList(Allies, "LOWHP")
                    for _, Ally in pairs(Sorted) do
                        local CurrentHealthInPercent = Ally.Health/Ally.MaxHealth
                        if CurrentHealthInPercent <= ShieldPercent and self:GetDistance(Ally.Position, myHero.Position) < Range then
                            return Ally, Enemy
                        end
                    end 
                end       
            end
        end

        return nil, nil
    end,
    GetShieldTargetWithTable = function(self, Range, Table, Prefix) 
        if Prefix == nil then
            Prefix = ""
        end
        local Enemies   = self:GetAllEnemies()
        local Allies    = self:GetAlliesInRange(myHero.Position, Range)
        local Sorted    = self:SortList(Allies, "LOWHP")

        local Heros     = ObjectManager.HeroList
        local Turrets   = ObjectManager.TurretList
        local Minions   = ObjectManager.MinionList
        local Missiles  = ObjectManager.MissileList

        for _, Object in pairs(Sorted) do
            local CurrentAlly               = Table[Prefix .. Object.Index]
            if CurrentAlly then
                local ShieldPercent          = CurrentAlly.Value/100
                local CurrentHealthInPercent = Object.Health/Object.MaxHealth
                if CurrentHealthInPercent <= ShieldPercent then
                    for _, Missile in pairs(Missiles) do
                        local SourceID = Missile.SourceIndex
                        local TargetID = Missile.TargetIndex

                        local Source = Heros[SourceID]
                        if Source == nil then Source = Turrets[SourceID] end
                        if Source == nil then Source = Minions[SourceID] end
                        if Source and Source.Team ~= myHero.Team and ((Source.IsHero or Source.IsTurret) or Source.Team == 300) then
                            if TargetID > 0 and TargetID < 3500 then
                                if TargetID == Object.Index then 
                                    return Object, Missile
                                end
                            else
                                local Radius = 70
                                local StartPos, EndPos = Missile.MissileStartPos, Missile.MissileEndPos
                                if Evade and Evade.Spells[Missile.Name] then
                                    Radius = Evade.Spells[Missile.Name].Radius
                                    StartPos, EndPos = Evade:CalcLinearMissileStartEndPos(Missile, StartPos, EndPos, Evade.Spells[Missile.Name])
                                end
                                if self:GetDistance(Object.Position, Missile.Position) <= Object.CharData.BoundingRadius + Radius*2 and self:PointOnLineSegment(StartPos, EndPos, Object.Position, Radius*2) then
                                    return Object, Missile
                                end
                            end    
                        end
                    end
                end
            end
        end
        for _, Enemy in pairs(Enemies) do
            if Enemy.IsTargetable then
                if string.len(Enemy.ActiveSpell.Info.Name) > 0 and Enemy.ActiveSpell.IsAutoAttack == false then
                    local Type                      = 0
                    local Radius                    = 70
                    local StartPos, EndPos, CastPos = Enemy.ActiveSpell.StartPos, Enemy.ActiveSpell.EndPos, Enemy.ActiveSpell.CastPos
                    if Evade and Evade.Spells[Enemy.ActiveSpell.Info.Name] then
                        Type                = Evade.Spells[Enemy.ActiveSpell.Info.Name].Type
                        Radius              = Evade.Spells[Enemy.ActiveSpell.Info.Name].Radius
                        StartPos, EndPos    = Evade:CalcLinearSpellStartEndPos(StartPos, EndPos, Evade.Spells[Enemy.ActiveSpell.Info.Name]);
                    end

                    local Allies = self:GetAlliesInRange(myHero.Position, Range)
                    local Sorted = self:SortList(Allies, "LOWHP")
                    for _, Ally in pairs(Sorted) do
                        local CurrentAlly            = Table[Prefix .. Ally.Index]
                        if CurrentAlly then
                            local ShieldPercent          = CurrentAlly.Value/100
                            local CurrentHealthInPercent = Ally.Health/Ally.MaxHealth
                            if CurrentHealthInPercent <= ShieldPercent then
                                if Type == 0 then
                                    if self:GetDistance(StartPos, Ally.Position) <= Ally.CharData.BoundingRadius + Radius*2 and self:PointOnLineSegment(StartPos, EndPos, Ally.Position, Radius*2) then
                                        return Ally, Enemy
                                    end    
                                else
                                    if self:GetDistance(EndPos, Ally.Position) <= Ally.CharData.BoundingRadius + Radius then
                                        return Ally, Enemy
                                    end    
                                end
                            end
                        end
                    end  
                end

                if Enemy.AttackRange < 300 then
                    local StartPos = Enemy.Position
                    if Enemy.AIData.Dashing then
                        StartPos = Enemy.AIData.TargetPos
                    end

                    local Allies = self:GetAlliesInRange(StartPos, Enemy.AttackRange + 200)
                    local Sorted = self:SortList(Allies, "LOWHP")
                    for _, Ally in pairs(Sorted) do
                        local CurrentAlly            = Table[Prefix .. Ally.Index]
                        if CurrentAlly then
                            local ShieldPercent          = CurrentAlly.Value/100
                            local CurrentHealthInPercent = Ally.Health/Ally.MaxHealth
                            if CurrentHealthInPercent <= ShieldPercent and self:GetDistance(Ally.Position, myHero.Position) < Range then
                                return Ally, Enemy
                            end
                        end
                    end  
                end      
            end
        end
        local Allies = self:GetAlliesInRange(myHero.Position, math.huge)
        local Sorted = self:SortList(Allies, "LOWHP")
        for _, Ally in pairs(Sorted) do
            local CurrentAlly            = Table[Prefix .. Ally.Index]
            if CurrentAlly then
                local ShieldPercent          = CurrentAlly.Value/100
                local CurrentHealthInPercent = Ally.Health/Ally.MaxHealth
                if CurrentHealthInPercent <= ShieldPercent and self:GetDistance(Ally.Position, myHero.Position) < Range then
                    return Ally, Enemy
                end
            end
        end  
        return nil, nil
    end,
    GetAntiGapCloseTarget = function(self, Range, Radius) 
        local Enemies = self:GetEnemiesInRange(myHero.Position, Range)
        for _, Enemy in pairs(Enemies) do
            if Enemy.IsTargetable and Enemy.AIData.Dashing and self:GetDistance(Enemy.AIData.TargetPos, myHero.Position) < Range then
                return Enemy, nil
            end
            if Enemy.IsTargetable and Enemy.AttackRange < 300 then
                local Allies = self:GetAlliesInRange(Enemy.Position, Enemy.AttackRange + 200)
                local Sorted = self:SortList(Allies, "LOWHP")
                for _, Ally in pairs(Sorted) do
                    if Ally.IsTargetable and self:GetDistance(Ally.Position, myHero.Position) < Range then
                        return Enemy, Ally
                    end
                end        
            end
        end
        return nil
    end,
    --Make Ally stronger functions
    GetBuffTarget = function(self, Range) 
        local AttackingFriends = {}
        local Heros     = ObjectManager.HeroList
        local Turrets   = ObjectManager.TurretList
        local AllyM     = self:GetAllAllyMissiles()
        for _, Missile in pairs(AllyM) do
            if Missile.Name ~= "Perks_Aery_Tar" then
                local SourceID = Missile.SourceIndex
                local TargetID = Missile.TargetIndex
                local Source = Heros[SourceID]
                if Source and TargetID and self:GetDistance(Source.Position, myHero.Position) < Range then
                    local Target = Heros[TargetID]
                    if Target and Target.Team ~= Source.Team then
                        AttackingFriends[#AttackingFriends+1] = Source
                    end
                end
            end
        end
        local Allies = self:GetAlliesInRange(myHero.Position, Range)
        for _, Ally in pairs(Allies) do 
            if Ally.AttackRange < 300 and Ally.IsTargetable and string.find(Ally.ActiveSpell.Info.Name, "Attack", 1) ~= nil then
                local Enemies = self:GetEnemiesInRange(Ally.Position, 300)
                if #Enemies > 0 then
                    AttackingFriends[#AttackingFriends+1] = Ally
                end
            end
        end
        local Sorted = self:SortList(AttackingFriends, "MAXAD")
        return Sorted[1] 
    end,
    --Make Enemy weaker functions
    GetDebuffTarget = function(self, Range) 
        local AttackingEnemies = {}
        local Heros     = ObjectManager.HeroList
        local Turrets   = ObjectManager.TurretList
        local EnemyM    = self:GetAllEnemyMissiles()
        for _, Missile in pairs(EnemyM) do
            local SourceID = Missile.SourceIndex
            local TargetID = Missile.TargetIndex

            local Source = Heros[SourceID]
            if Source and TargetID and self:GetDistance(Source.Position, myHero.Position) < Range then
                local Target = Heros[TargetID]
                if Target == nil then Target = Turrets[TargetID] end

                if Target and Target.Team == Source.Team then
                    AttackingEnemies[#AttackingEnemies+1] = Source
                end
            end
        end
        local Enemies = self:GetEnemiesInRange(myHero.Position, Range)
        for _, Enemy in pairs(Enemies) do
            if Enemy.AttackRange < 300 and Enemy.IsTargetable and string.len(Enemy.ActiveSpell.Info.Name) > 0 then
                local Allies = self:GetAlliesInRange(Enemy.Position, 300)
                if #Allies > 0 then
                    AttackingEnemies[#AttackingEnemies+1] = Enemy
                end
            end
        end
        local Sorted = self:SortList(AttackingEnemies, "MAXAD")
        return Sorted[1] 
    end,
}