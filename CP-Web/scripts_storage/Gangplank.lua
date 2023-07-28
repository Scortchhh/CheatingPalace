require("Enums")
require("VectorCalculations")
require("ObjectLib")
require("MapPositions")
require("DamageLib")
require("BuffLib")
require("SpellLib")

Gangplank = {}
function Gangplank:__init()
    self.BarrelList = {}

    self.ChampionMenu = Menu:CreateMenu("Gangplank")
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.UseComboQ = self.ComboMenu:AddCheckbox("UseQ", 1)

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.UseHarassQ = self.HarassMenu:AddCheckbox("UseQ", 1)

    self.FarmMenu = self.ChampionMenu:AddSubMenu("Farm")
    self.UseFarmQ = self.FarmMenu:AddCheckbox("UseQ to Farm/laneclear", 1)
    self.UseBarrelFarm = self.FarmMenu:AddCheckbox("Use Barrel to Farm/laneclear", 1)
    self.UseBarrelAtXMinions = self.FarmMenu:AddSlider("Execute Barrel at x killable Minions", 3,1,5,1)

    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.UseAutoBarrel = self.MiscMenu:AddCheckbox("Use auto barrel placement/execution", 1)
    self.UseAutoW = self.MiscMenu:AddCheckbox("Use Auto W on buff or <20% hp", 1)

    self.KSMenu = self.ChampionMenu:AddSubMenu("KS")
    self.UseKSQ = self.KSMenu:AddCheckbox("UseQ to KS", 1)
    self.UseKSR = self.KSMenu:AddCheckbox("Use R to KS", 1)

    Gangplank:LoadSettings()
end
local LastAABarrel = 0

function Gangplank:SaveSettings()
    SettingsManager:CreateSettings("Gangplank")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.UseComboQ.Value)
    -------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ", self.UseHarassQ.Value)
    -------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Farm")
    SettingsManager:AddSettingsInt("UseQ", self.UseFarmQ.Value)
    SettingsManager:AddSettingsInt("UseBarrel", self.UseBarrelFarm.Value)
    SettingsManager:AddSettingsInt("UseBarrelAtXMinions", self.UseBarrelAtXMinions.Value)
    -------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("UseAutoBarrel", self.UseAutoBarrel.Value)
    SettingsManager:AddSettingsInt("UseAutoW", self.UseAutoW.Value)
    -------------------------------------------------------------
    SettingsManager:AddSettingsGroup("KS")
    SettingsManager:AddSettingsInt("UseQ", self.UseKSQ.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseKSR.Value)
end

function Gangplank:LoadSettings()
    SettingsManager:GetSettingsFile("Gangplank")
    self.UseComboQ.Value = SettingsManager:GetSettingsInt("Combo", "UseQ")
    -------------------------------------------------------------
    self.UseHarassQ.Value = SettingsManager:GetSettingsInt("Harass", "UseQ")
    -------------------------------------------------------------
    self.UseFarmQ.Value = SettingsManager:GetSettingsInt("Farm", "UseQ")
    self.UseBarrelFarm.Value = SettingsManager:GetSettingsInt("Farm", "UseBarrel")
    self.UseBarrelAtXMinions.Value = SettingsManager:GetSettingsInt("Farm", "UseBarrelAtXMinions")

    if self.UseBarrelAtXMinions.Value == 0 then
        self.UseBarrelAtXMinions.Value = 3
    end
    -------------------------------------------------------------
    self.UseAutoBarrel.Value = SettingsManager:GetSettingsInt("Misc","UseAutoBarrel")
    self.UseAutoW.Value = SettingsManager:GetSettingsInt("Misc", "UseAutoW")
    -------------------------------------------------------------
    self.UseKSQ.Value = SettingsManager:GetSettingsInt("KS", "UseQ")
    self.UseKSR.Value = SettingsManager:GetSettingsInt("KS", "UseR")
end

function Gangplank:KillMinionWithQ()
    local MinionList = self:SortToHighestHealth(ObjectManager.MinionList)
    local bestBarrel = self:GetBarrelThatKillsxEnemies(self.UseBarrelAtXMinions.Value, MinionList)

    if bestBarrel ~= nil and self.UseBarrelFarm.Value == 1 then
        if Engine:SpellReady(SpellKey.Q) and self.UseFarmQ.Value == 1 then
            if VectorCalculations:GetDistance(myHero.Position, bestBarrel.Position) <= SpellLib.Gangplank.Q:Range() 
            and Orbwalker.Attack == 0 then
                return Engine:CastSpell(SpellKey.Q, bestBarrel.Position)
            end
        else 
            if VectorCalculations:GetDistance(myHero.Position, bestBarrel.Position) <= Orbwalker.OrbRange + 10 
            and Orbwalker.Attack == 0 and Orbwalker:CanAttack() then
                Orbwalker:IssueAttack(bestBarrel.Position, 0)
            end
        end
    end

    if Engine:SpellReady(SpellKey.Q) and self.UseFarmQ.Value == 1 then
        for i, minion in pairs(MinionList) do
            if minion.Team ~= myHero.Team and minion.IsTargetable and minion.IsMinion and minion.Name ~= ObjectLib.Gangplank.Barrel then
                if VectorCalculations:GetDistance(myHero.Position, minion.Position) <= SpellLib.Gangplank.Q:Range() and minion.Health <= DamageLib.Gangplank:GetQDmg(minion) then
                    Engine:CastSpell(SpellKey.Q, minion.Position)
                end
            end
        end
    end
end

function Gangplank:SortToHighestHealth(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return left.Health > right.Health
        end)
    end
    return SortedTable
end

function Gangplank:IsInQRange(target)
    return VectorCalculations:GetDistance(myHero.Position, target.Position) <= SpellLib.Gangplank.Q:Range() - 20
end

function Gangplank:IsInAARange(target)
    return VectorCalculations:GetDistance(myHero.Position, target.Position) <= Orbwalker.OrbRange 
end

function Gangplank:SortToNearest(List)
    local CurrentList = {}
    for _, Object in pairs(List) do
        CurrentList[#CurrentList+1] = Object
    end

    for left = 1, #CurrentList do  
        for right = left+1, #CurrentList do    
            if VectorCalculations:GetDistance(myHero.Position, CurrentList[left].Position) > VectorCalculations:GetDistance(myHero.Position, CurrentList[right].Position) then    
                local Swap = CurrentList[left] 
                CurrentList[left] = CurrentList[right] 
                CurrentList[right] = Swap
            end
        end
    end    
    return CurrentList
end

function Gangplank:AutoAAClosestBarrel() 
    local barrels = self:SortToNearest(self.BarrelList)
    local AATimer = GameClock.Time - LastAABarrel
    for i, Barrel in pairs(barrels) do
        if VectorCalculations:GetDistance(myHero.Position, Barrel.Position) <= Orbwalker.OrbRange + 10 and Barrel.Health > 1 
        and Orbwalker.Attack == 0 and Orbwalker:CanAttack() then
            --Orbwalker:IssueMove(Barrel.Position)
            LastAABarrel = GameClock.Time
            Orbwalker:IssueAttack(Barrel.Position, 0)
            --Orbwalker:Orbwalk(Barrel)
        end
    end
end

function Gangplank:OtherBarrelInRadiusOfPoint(center, radius)
    local Barrels = self:SortToNearest(self.BarrelList)
    local BarrelsInRange = {}
    for i, Barrel in pairs(Barrels) do
        if Barrel.Team ~= myHero.Team and Barrel.IsTargetable and Barrel.IsDead == false then
            if VectorCalculations:GetDistance(center, Barrel.Position) <= radius then
                table.insert(BarrelsInRange, Barrel)
            end
        end
    end

    return BarrelsInRange
end

function Gangplank:NoBarrelsInRange(center, radius)
    return #self:OtherBarrelInRadiusOfPoint(center, radius) == 0
end

function Gangplank:GetBestTargetInRange(Barrel)
    local Heroes = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
	for _, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable == true and VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= SpellLib.Gangplank.E:Range() * 1.5 then
            if Hero.Health < self:GetEDmg(Hero, Engine:SpellReady(SpellKey.Q)) * 0.99 and VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= SpellLib.Gangplank.Q:Range() + SpellLib.Gangplank.Barrel:Width()*2 then
                return Hero
            end
                
            if Barrel ~= nil then
                if VectorCalculations:GetDistance(Hero.Position, Barrel.Position) <= SpellLib.Gangplank.Barrel:Width() * 2.5 then
                    return Hero
                elseif VectorCalculations:GetDistance(Hero.Position, Barrel.Position) <= SpellLib.Gangplank.Barrel:Width() * 3.5 then
                    return Hero
                elseif VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= 6 * SpellLib.Gangplank.Barrel:Width() then
                    return Hero
                end
            elseif VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= 6 * SpellLib.Gangplank.Barrel:Width() then
                return Hero
            end
                -- body
		end
	end

	return nil
end

function Gangplank:GetBestBarrelToExecute(connectedBarrelInfo)
    local SortedTable = {}
    for _, Object in pairs(connectedBarrelInfo.Barrels) do
        SortedTable[#SortedTable + 1] = Object    
    end

    if #connectedBarrelInfo.Heroes == 0 then
        if #SortedTable > 1 then
            table.sort(SortedTable, function (left, right)
                return VectorCalculations:GetDistance(myHero.Position, left.Position) < VectorCalculations:GetDistance(myHero.Position, right.Position)
            end)
        end
        return SortedTable[1]
    else
        local GetBestHeroToTarget = Orbwalker:SortList(connectedBarrelInfo.Heroes, "LOWHP")[1]
       
        if #SortedTable > 1 then
            table.sort(SortedTable, function (left, right)
                return VectorCalculations:GetDistance(GetBestHeroToTarget.Position, left.Position) > VectorCalculations:GetDistance(GetBestHeroToTarget.Position, right.Position)
            end)
        end
        return SortedTable[1]
    end
end

function Gangplank:GetBarrels()
    local MinionList = ObjectManager.MinionList
    self.BarrelList = {}
    for i, minion in pairs(MinionList) do
        if minion.Team ~= myHero.Team and minion.Name == ObjectLib.Gangplank.Barrel and minion.IsDead == false and minion.IsTargetable then
            table.insert(self.BarrelList, minion)
        end
    end
end

function Gangplank:GetConnectedBarrels()
    local ConnectedBarrels = {}
    local Heroes = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")

    for i, Barrel in pairs(self.BarrelList) do
        local connectedInfo = {}
        connectedInfo.Barrels = {}
        connectedInfo.Heroes = self:HeroesInRangeOfBarrel(Heroes, Barrel)
        connectedInfo.AmountOfBarrels = 1
        connectedInfo.AmountOfHeroes = 0
        connectedInfo.IsInQRange = self:IsInQRange(Barrel)
        connectedInfo.IsInAARange = self:IsInAARange(Barrel)
        connectedInfo.ClosestHP = Barrel.Health
        connectedInfo.QBarrel = nil
        connectedInfo.AABarrel = nil

        if connectedInfo.IsInAARange and Barrel.Health == 1 then
            connectedInfo.AABarrel = Barrel
        end

        if connectedInfo.IsInQRange and (Barrel.Health == 1 or (BuffLib.Gangplank:BarrelStartTime(Barrel) + SpellLib.Gangplank.Barrel:DecayTime() * 2) - SpellLib.Gangplank.Q:Delay() - (SpellLib.Gangplank.Barrel:ExplosionDelay() * 0.7) <= GameClock.Time) then
            connectedInfo.QBarrel = Barrel
        end
        
        table.insert(connectedInfo.Barrels, Barrel)

        for j, OtherBarrel in pairs(self.BarrelList) do
            if Barrel ~= OtherBarrel and VectorCalculations:GetDistance(Barrel.Position, OtherBarrel.Position) <= SpellLib.Gangplank.Barrel:Width() * 2 then
                table.insert(connectedInfo.Barrels, OtherBarrel)

                connectedInfo.Heroes = union(connectedInfo.Heroes, self:HeroesInRangeOfBarrel(Heroes, OtherBarrel))

                if connectedInfo.IsInQRange == false then
                    connectedInfo.IsInQRange = self:IsInQRange(OtherBarrel)
                    
                    if OtherBarrel.Health == 1 and connectedInfo.IsInQRange then
                        connectedInfo.QBarrel = OtherBarrel
                    end
                end

                if connectedInfo.IsInAARange == false then
                    connectedInfo.IsInAARange = self:IsInAARange(OtherBarrel)
                    connectedInfo.ClosestHP = OtherBarrel.Health

                    if connectedInfo.IsInAARange and OtherBarrel.Health == 1 then
                        connectedInfo.AABarrel = OtherBarrel
                    end
                end
            end
        end

        connectedInfo.AmountOfBarrels = #connectedInfo.Barrels
        connectedInfo.AmountOfHeroes = #connectedInfo.Heroes

        table.insert(ConnectedBarrels, connectedInfo)
    end

    local SortedTable = {}
    for _, Object in pairs(ConnectedBarrels) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return left.AmountOfHeroes > right.AmountOfHeroes or 
            (left.AmountOfHeroes == right.AmountOfHeroes and left.AmountOfBarrels > right.AmountOfBarrels)
        end)
    end

    return SortedTable
end

function union ( a, b )
    local result = {}
    for k,v in pairs ( a ) do
        table.insert( result, v )
    end
    for k,v in pairs ( b ) do
        table.insert( result, v )
    end

    local hash = {}
    local res = {}

    for _,v in ipairs(result) do
        if (not hash[v]) then
            res[#res+1] = v -- you could print here instead of saving to result table if you wanted
            hash[v] = true
        end
    end

    return res
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return '\r\n' .. s .. '} ' .. '\r\n'
    else
       return tostring(o)
    end
end

function Gangplank:HeroesInRangeOfBarrel(herosList, barrel)
    local heros = {}
    
    for _, Hero in pairs(herosList) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable and self:HeroIsInRangeOfBarrel(Hero, barrel)  then
            table.insert(heros, Hero)
        end
    end

    return heros
end

function Gangplank:HeroIsInRangeOfBarrel(hero, barrel)
    if VectorCalculations:GetDistance(hero.Position, barrel.Position) <= SpellLib.Gangplank.Barrel:Width() then
        return true
    end
    return false
end

function Gangplank:HeroIsInRangeOfABarrel(Hero)
    for _, Barrel in pairs(self.BarrelList) do
        if VectorCalculations:GetDistance(Hero.Position, Barrel.Position) <= SpellLib.Gangplank.Barrel:Width() then
            return true
        end
    end
    return false
end

function Gangplank:SortToFurthest(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return VectorCalculations:GetDistance(myHero.Position, left.Position) < VectorCalculations:GetDistance(myHero.Position, right.Position)
        end)
    end
    return SortedTable
end

function Gangplank:KS()
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and BuffLib:HasNoBuffOfType(Hero, {BuffType.Invulnerability}) then

            if VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= Orbwalker.OrbRange 
            and Hero.Health <= DamageLib.Gangplank:GetAADmg(Hero, myHero.CritMod >= 0.6, true) 
            and Orbwalker.Attack == 0 and Orbwalker:CanAttack() then
                return Orbwalker:IssueAttack(Hero, 1)
            end

            if self.UseKSQ.Value == 1 and Engine:SpellReady(SpellKey.Q)
            and VectorCalculations:GetDistance(myHero.Position, Hero.Position) <= SpellLib.Gangplank.Q:Range()
            and Hero.Health <= DamageLib.Gangplank:GetQDmg(Hero)
            and Orbwalker.Attack == 0 then
                return Engine:CastSpell(SpellKey.Q, Hero.Position, 1)
            end

            if self.UseKSR.Value == 1 and Engine:SpellReady(SpellKey.R)
            and Orbwalker.Attack == 0
            and Hero.Health <= DamageLib.Gangplank:GetRDmg(Hero, 6)
            and VectorCalculations:GetDistance(myHero.Position, Hero.Position) >= SpellLib.Gangplank.E:Range() + 100 then
                local predPosExtra = VectorCalculations:GetPointAtDistanceOnPath(Hero.Position, MapPositions:EnemyBaseSpawn(), SpellLib.Gangplank.R:Width() * 0.83)
                local PredPos = Prediction:GetPredPos(myHero.Position, Hero, SpellLib.Gangplank.R:Range(), SpellLib.Gangplank.R:Speed(), SpellLib.Gangplank.R:Delay())
                return Engine:CastSpellMap(SpellKey.R, predPosExtra, 1)
            end
        end
    end
end

function Gangplank:Combo()
end

function Gangplank:Harass()
end

function Gangplank:UseQ()
    local QTarget = Orbwalker:GetTarget("Combo", SpellLib.Gangplank.Q:Range())

    if QTarget ~= nil and Engine:SpellReady(SpellKey.Q) and (#self.BarrelList == 0 or (self:NoBarrelsInRange(QTarget.Position, SpellLib.Gangplank.Barrel:Width()*2) and (not(Engine:SpellReady(SpellKey.E)) or myHero:GetSpellSlot(SpellSlot.E).Charges == 0))) then
        if Orbwalker.Attack == 0 and QTarget ~= nil then
            Engine:CastSpell(SpellKey.Q, QTarget.Position, 1)
        end
    end
end

function Gangplank:AutoW()
    if Engine:SpellReady(SpellKey.W) then
        local hasBuff = BuffLib:HasOneBuffOfType(myHero, {
            BuffType.Slow,
            BuffType.Stun,
            BuffType.Suppression,
            BuffType.Taunt
        })

        if (myHero.Health < myHero.MaxHealth * 0.2 or hasBuff) and Orbwalker.Attack == 0 then
            Engine:CastSpell(SpellKey.W, myHero.Position, 1)
        end
    end
end

function Gangplank:GetBarrelThatKillsxEnemies(x, enemyList)
    for i, Barrel in pairs(self.BarrelList)do
        local killableEnemies = {}
        if (Engine:SpellReady(SpellKey.Q) and VectorCalculations:GetDistance(myHero.Position, Barrel.Position) <= SpellLib.Gangplank.Q:Range() + 10) 
            or VectorCalculations:GetDistance(myHero.Position, Barrel.Position) <= Orbwalker.OrbRange + 10
            then
            for j, Enemy in pairs(enemyList) do
                if Enemy.Name ~= ObjectLib.Gangplank.Barrel and Enemy.IsTargetable and Enemy.IsDead == false
                and VectorCalculations:GetDistance(Barrel.Position, Enemy.Position) <= SpellLib.Gangplank.Barrel:Width() 
                and Enemy.Health < DamageLib.Gangplank:GetEDmg(Enemy) + DamageLib.Gangplank:GetQDmg(Enemy)
                and Enemy.Team ~= myHero.Team
                and Enemy.MaxHealth > 10
                then
                    table.insert(killableEnemies, Enemy)
                end
            end

            --print(#killableEnemies >= x)
            if #killableEnemies >= x then
                return Barrel
            end
        end
    end
end

function Gangplank:AutoBarrel()
    for _,Minion in pairs(ObjectManager.MinionList) do
        if VectorCalculations:GetDistance(Minion.Position, myHero.Position) <= SpellLib.Gangplank.E:Range() and Minion.Name == ObjectLib.Gangplank.Barrel then
            if (myHero.ActiveSpell.IsAutoAttack or myHero.ActiveSpell.Info.Name == "GangplankQProceed") 
            and Minion.Health == 1
            and Minion.Position.x == myHero.ActiveSpell.EndPos.x
            and Minion.Position.z == myHero.ActiveSpell.EndPos.z then  
                for i,Hero in pairs(ObjectManager.HeroList) do
                    if Hero.Team ~= myHero.Team and Hero.IsTargetable and Engine:SpellReady(SpellKey.E)
                    and myHero:GetSpellSlot(SpellSlot.E).Charges > 0
                    and VectorCalculations:GetDistance(Minion.Position, Hero.Position) <= SpellLib.Gangplank.Barrel:Width() * 2.6
                    and VectorCalculations:GetDistance(Minion.Position, Hero.Position) >= SpellLib.Gangplank.Barrel:Width() * 0.8
                    then
                        local pred = Prediction:GetPredPos(Minion.Position, Hero, SpellLib.Gangplank.E:Speed(), SpellLib.Gangplank.E:Delay())
                        if pred then
                            local predPos = VectorCalculations:GetPointAtDistanceOnPath(Minion.Position, pred, SpellLib.Gangplank.Barrel:Width() * 2)
                            if self:NoBarrelsInRange(predPos, 50) and not(self:HeroIsInRangeOfABarrel(Hero)) then
                                Engine:CastSpell(SpellKey.E, predPos, 0)
                                self:GetBarrels()
                            end
                        end
                    end
                end
            end

            if (Engine:SpellReady(SpellKey.Q) or VectorCalculations:GetDistance(myHero.Position, Minion.Position) <= Orbwalker.OrbRange)
            and (Minion.Health == 1 or (BuffLib.Gangplank:BarrelStartTime(Minion) + SpellLib.Gangplank.Barrel:DecayTime() * 2) - SpellLib.Gangplank.Q:Delay() - (SpellLib.Gangplank.Barrel:ExplosionDelay() * 0.7) <= GameClock.Time) and Minion.IsTargetable then
                
                for i,Hero in pairs(ObjectManager.HeroList) do
                    if Hero.Team ~= myHero.Team and Hero.IsTargetable and Engine:SpellReady(SpellKey.E)
                    and myHero:GetSpellSlot(SpellSlot.E).Charges > 0
                    and VectorCalculations:GetDistance(Minion.Position, Hero.Position) <= SpellLib.Gangplank.Barrel:Width() * 2.6
                    and VectorCalculations:GetDistance(Minion.Position, Hero.Position) >= SpellLib.Gangplank.Barrel:Width() * 0.8
                    then
                        local pred = Prediction:GetPredPos(Minion.Position, Hero, SpellLib.Gangplank.E:Speed(), SpellLib.Gangplank.E:Delay())
                        if pred then
                            local predPos = VectorCalculations:GetPointAtDistanceOnPath(Minion.Position, pred, SpellLib.Gangplank.Barrel:Width() * 2)
                            if self:NoBarrelsInRange(predPos, 50) and not(self:HeroIsInRangeOfABarrel(Hero)) then
                                Engine:CastSpell(SpellKey.E, predPos, 0)
                                self:GetBarrels()
                            end
                        end
                    end
                end
            end
        end
    end
    
    local barrels = self:GetConnectedBarrels()
    for _,connectedInfo in pairs(barrels) do
        if connectedInfo.AmountOfHeroes > 0 and connectedInfo.AABarrel ~= nil and Orbwalker:CanAttack() then
            Orbwalker:Disable()
            Orbwalker:IssueAttack(connectedInfo.AABarrel.Position, 0)
            Orbwalker:Enable()
            return;
        end

        if connectedInfo.AmountOfHeroes > 0 and connectedInfo.QBarrel ~= nil and Engine:SpellReady(SpellKey.Q) then
            return Engine:CastSpell(SpellKey.Q, connectedInfo.QBarrel.Position, 0)
        end
    end

    local HeroList = ObjectManager.HeroList
    for i,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and Engine:SpellReady(SpellKey.E) then
            local AATarget = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange + 50)
            if self:NoBarrelsInRange(myHero.Position, SpellLib.Gangplank.Q:Range()) and AATarget ~= nil 
            and AATarget.IsTargetable
            and (AATarget.Health > DamageLib.Gangplank:GetQDmg(AATarget) or not(Engine:SpellReady(SpellKey.Q)))
            and Engine:SpellReady(SpellKey.E) 
            and myHero:GetSpellSlot(SpellSlot.E).Charges > 0
            and not(self:HeroIsInRangeOfABarrel(Hero)) then
                return Engine:CastSpell(SpellKey.E, myHero.Position, 0)
            end
        end
    end

--[[     local BarrelTarget = Orbwalker:GetTarget("Combo", SpellLib.Gangplank.Barrel:Width() * 2)

    if self:NoBarrelsInRange(myHero.Position, SpellLib.Gangplank.E:Range()) and BarrelTarget ~= nil 
    and BarrelTarget.IsTargetable
    and Engine:SpellReady(SpellKey.E)
    and myHero:GetSpellSlot(SpellSlot.E).Charges > 2 then
        return Engine:CastSpell(SpellKey.E, myHero.Position, 0)
    end ]]

end

function Gangplank:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsDead == false then
        self:GetBarrels()

        if self.UseAutoW.Value == 1 then
            self:AutoW()
        end

        self:KS()
        if self.UseAutoBarrel.Value == 1 then
            self:AutoBarrel()
        end

        if Engine:IsKeyDown(UIKeys.Combo) and Orbwalker.Attack == 0 then
            if self.UseComboQ.Value == 1 then
			    self:UseQ()
            end
		end
		if Engine:IsKeyDown(UIKeys.Harass) and Orbwalker.Attack == 0 then
            if self.UseHarassQ.Value == 1 then
			    self:UseQ()
            end
		end
        if (Engine:IsKeyDown(UIKeys.LastHit) or Engine:IsKeyDown(UIKeys.LaneClear)) and Orbwalker.Attack == 0 then
            self:KillMinionWithQ()
		end
	end
end

function Gangplank:DrawDmg()
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team then
			local Damages = {}
			table.insert( Damages, {
				Damage = DamageLib.Gangplank:GetAADmg(Hero, myHero.CritMod >= 0.6, true),
				Color = Colors.Pink,
			})

			if Engine:SpellReady(SpellKey.Q) then
				table.insert( Damages, {
					Damage = DamageLib.Gangplank:GetQDmg(Hero),
					Color = Colors.Blue,
				})
			end

            if Engine:SpellReady(SpellKey.E) then
				table.insert( Damages, {
					Damage = DamageLib.Gangplank:GetEDmg(Hero),
					Color = Colors.BlueLight,
				})
			end

			if Engine:SpellReady(SpellKey.R) then
				table.insert(Damages, {
					Damage = DamageLib.Gangplank:GetRDmg(Hero, 6),
					Color = Colors.PurpleDarker
				})
			end

            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
end

function Gangplank:OnDraw()
    if myHero.IsDead == nil then return end
	if Engine:SpellReady(SpellKey.Q) then
        Render:DrawCircle(myHero.Position, SpellLib.Gangplank.Q:Range() ,100,150,255,255)
    end
    if Engine:SpellReady(SpellKey.E) then
        Render:DrawCircle(myHero.Position, SpellLib.Gangplank.E:Range() ,100,150,255,255)
    end

    self:DrawDmg()
end

function Gangplank:OnLoad()
    if(myHero.ChampionName ~= "Gangplank") then return end
    AddEvent("OnSettingsSave", function() Gangplank:SaveSettings() end)
    AddEvent("OnSettingsLoad", function() Gangplank:LoadSettings() end)

    Gangplank:__init()
    AddEvent("OnTick", function() Gangplank:OnTick() end)
    AddEvent("OnDraw", function() Gangplank:OnDraw() end)
end

AddEvent("OnLoad", function() Gangplank:OnLoad() end)