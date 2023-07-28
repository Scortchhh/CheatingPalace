--Credits to Scortch, Christoph, Derang3d

local Sylas = {}


function Sylas:__init()

    
    self.KeyNames = {}

	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"

	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
	self.KeyNames[11]		= "HK_ITEM6"

    self.QRange = 775
    self.WRange = 400
    self.E1Range = 400
    self.E2Range = 800
    self.RRange = 0
    self.GLPRange = 800
    self.BoltRange = 500

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 3000
    self.RSpeed = math.huge

    self.QDelay = 0.4
    self.WDelay = math.huge
    self.EDelay = 0.25
    self.RDelay = 0

    self.QRadius = 180
    self.WRadius = 0
    self.ERadius = 100
    self.RRadius = 0

    self.GLPHitChance = 0.2
    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ScriptVersion = "        **CCSylas Version: 0.81 (50 R's Supported)**"

    self.SylasMenu = Menu:CreateMenu("Sylas")
	-------------------------------------------
    self.Combomenu = self.SylasMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("Use R in combo", 1)
    self.UseBolt = self.Combomenu:AddCheckbox("Use Bolt Items", 1)
    --self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    -------------------------------------------
	self.Harassmenu = self.SylasMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.HarassW = self.Harassmenu:AddCheckbox("Use W in harass", 1)
    self.HarassWMana = self.Harassmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
    self.Clearmenu = self.SylasMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearW = self.Clearmenu:AddCheckbox("Use W in clear", 1)
    self.ClearWMana = self.Clearmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
    self.Miscmenu = self.SylasMenu:AddSubMenu("Misc")
    self.WHealth = self.Miscmenu:AddSlider("% Health to use W in Combo", 40, 0, 100, 1)
    self.WHealth2 = self.Miscmenu:AddSlider("% Health to use W in Harass", 70, 0, 100, 1)
    --self.WEnemies = self.Miscmenu:AddSlider("X enemies force W", 3, 1, 5, 1)
    -------------------------------------------
	self.Drawings = self.SylasMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
	
	Sylas:LoadSettings()
end

function Sylas:SaveSettings()
	SettingsManager:CreateSettings("Sylas")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("UB", self.UseBolt.Value)
    --SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HW", self.HarassW.Value)
    SettingsManager:AddSettingsInt("HWM", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    SettingsManager:AddSettingsInt("CW", self.ClearW.Value)
    SettingsManager:AddSettingsInt("CWM", self.ClearWMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("WH", self.WHealth.Value)
    SettingsManager:AddSettingsInt("WH2", self.WHealth2.Value)
    --SettingsManager:AddSettingsInt("WE", self.WEnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Sylas:LoadSettings()
	SettingsManager:GetSettingsFile("Sylas")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.UseBolt.Value = SettingsManager:GetSettingsInt("Combo", "UB")
    --self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","HW")
    self.HarassWMana.Value = SettingsManager:GetSettingsInt("Harass","HWM")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","HE")
    self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass","HEM")
    -------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    self.ClearW.Value = SettingsManager:GetSettingsInt("Clear", "CW")
    self.ClearWMana.Value = SettingsManager:GetSettingsInt("Clear", "CWM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")
    -------------------------------------------
    self.WHealth.Value = SettingsManager:GetSettingsInt("Misc", "WH")
    self.WHealth2.Value = SettingsManager:GetSettingsInt("Misc", "WH2")
    --self.WEnemies.Value = SettingsManager:GetSettingsInt("Misc", "WE")
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

--[[function Sylas:UltimatePriority()
    local priorityTable = {
        p1 = {"Ahri", "Alistar", "Ashe", "Braum", "ChoGath", "Ekko", "Fiddlestick", "Hecarim", "Kayle", "Kennen", "Leona", "Lissandra", "Malphite", "Morgana", "Nautilus", "Ornn", "Pyke", "Sejuani", "Skarner", "Swain", "Varus", "Vi", "Vladimir", "Volibear" }
        p2 = {"Aatrox", "Akali", "Amumu", "Annie", "Azir", "Corki", "Evelynn", "Fizz", "Talon", "Jarvan", "Malzahar", "Mordekaiser", "Nami", "Nasus", "Neeko", "Nocturne", "Rakan", "Sona", "Trundle", "Urgot" }
        p3 = {"Caitlyn", "Camille", "Mundo", "Ezreal", "Ganplank", "Garen", "Kindred", "Lucian", "Lulu", "Lux", "Soraka", "Taric", "Tresh", "Tryndamere" }
    }

end]]

function Sylas:GetQCastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

--[[function Sylas:GetEnemyHeroes()
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team then
            print(Hero.ChampionName)
        end
    end
end

function Sylas:GetEnemyHeroes2()
    local _EnemyHeroes = {}
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team then
            table.insert(_EnemyHeroes, Hero)
        end
    end
    return _EnemyHeroes
end]]

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Sylas:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Sylas:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Sylas:GetBonusHealth()
    local Health = {525,608,695,786,881,980,1083,1190,1301,1416,1535,1658,1785,1916,2051,2190,2333,2480}
    local Level = GetMyLevel()
    local BonusHP = myHero.MaxHealth - Health[Level] 
    if Level > 18 then --URF ?
        BonusHP = myHero.MaxHealth - 2480
    end
    return BonusHP
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

function Sylas:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end

function Sylas:GetItemKey(ItemName)
	for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Sylas:GLP_Check()
	local GLP			= {}
			GLP.Key				= self:GetItemKey("ItemWillBoltSpellBase")	
	if GLP.Key ~= nil then
		if Engine:SpellReady(GLP.Key) then
			return GLP
		end
	end
	return false
end

function Sylas:Bolt_Check()
	local Bolt			= {}
			Bolt.Key				= self:GetItemKey("ItemSoFBoltSpellBase")	
	if Bolt.Key ~= nil then
		if Engine:SpellReady(Bolt.Key) then
			return Bolt
		end
	end
	return false
end

function Sylas:TargetIsImmune(currentTarget)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "WillRevive", "SionPassiveZombie", "rebirthready", "willrevive", "ZileanR"
    }
    for i = 1, #ImmuneBuffs do
        local Buff = ImmuneBuffs[i]
		if currentTarget.BuffData:GetBuff(Buff).Valid then
			return true
		end
	end
	return false
end

function Sylas:FindUltPos(Position)
    local UR = Position
    local UL = Position
    local DR = Position
    local DL = Position
    UR.z = UR.z + 200
    UR.x = UR.x + 200
    UL.z = UL.z + 200
    UL.x = UL.x - 200
    DR.z = DR.z - 200
    DR.x = DR.x + 200
    DL.z = DL.z - 200
    DL.x = DL.x - 200
    if GetDist(myHero.Position, UR) < 750 then
        return UR
    end
    if GetDist(myHero.Position, UL) < 750 then
        return UL
    end
    if GetDist(myHero.Position, DR) < 750 then
        return DR
    end
    if GetDist(myHero.Position, DL) < 750 then
        return DL
    end
    return nil
end

function Sylas:PykeUltimate()
    
    local Target = Orbwalker:GetTarget("Combo", 900)
    local Timer = os.clock() - self.UltTimer
    
    if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") and Timer >= 0.5 and Target then
        local UltTable  = {250,290,330,370,400,430,450,470,490,510,530,540,550}
        local GetLvl    = GetMyLevel()
        local Lvl       = math.max(1, GetLvl - 5)
        local UltFlat   = UltTable[Lvl]
        local Dmg       = UltFlat + 0.32 * myHero.AbilityPower
        if Target.Health < Dmg and self:TargetIsImmune(Target) == false and Target.IsDead == false and not Target.BuffData:HasBuffOfType(30) then
            local PredPos = Prediction:GetPredPos(myHero.Position, Target, math.huge, 0.5)
            if GetDist(myHero.Position, PredPos) <= 750 then
                Engine:CastSpell("HK_SPELL4", PredPos ,1)
                self.UltTimer = os.clock()
                return
            else
                local UltPos = self:FindUltPos(PredPos)
                if UltPos then
                    Engine:CastSpell("HK_SPELL4", UltPos ,1)
                    self.UltTimer = os.clock()
                    return
                end
            end
        end
    end
end

function Sylas:EveRDmg(Target)
    local RDmg = Sylas:GetDamage(125 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.75, false, Target)
    if Target.Health < (Target.MaxHealth * 0.3) then
        RDmg = RDmg * 2.4
    end
    if RDmg > Target.Health then
        return true
    end
    return false
end

function Sylas:EveEnemiesRKillable(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:EveRDmg(Hero) then
                if GetDist(Hero.Position , Position) < Range then
                    Count = Count + 1
                end
            end
        end
    end
    return Count
end

function Sylas:GetChronoShadow()
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Minion.Name == "Ekko"  then
            return Minion
        end
    end
    return nil
end

function Sylas:CassRCheck(Target)
	local RCount = 0
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Target.Position, Hero.Position) < 550 then
				if GetDist(myHero.Position , Hero.Position) < 815 then
					RCount = RCount + 1	
				end
 			end
		end
    end

	if RCount >= 3 then
		return true
	end
	return false
end

function Sylas:CassGetRTarget()
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(myHero.Position, Hero.Position) < 815 then
				if self:CassRCheck(Hero) == true then
					return Hero
				end
			end
		end
	end
	return nil
end

function Sylas:WdmgKS(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local PassiveDmg = Sylas:GetDamage(1.3 * TotalAD + 0.25 * myHero.AbilityPower, false, Target)
    local WDmg = Sylas:GetDamage(30 + 35 * myHero:GetSpellSlot(1).Level + 0.85 * myHero.AbilityPower, false, Target)
    local FinalFullDmg = PassiveDmg + WDmg
    if FinalFullDmg > Target.Health then
        return true
    end
end

function Sylas:GLPusage()
    local GLP = self:GLP_Check()
    local CastPos, target = Prediction:GetCastPos(myHero.Position, self.GLPRange, 2000, 50, 0.25, 1, true, self.GLPHitChance, 1)
    if CastPos then
        if self.UseBolt.Value == 1 and GLP ~= false then
            Engine:CastSpell(GLP.Key, CastPos, 1)
        end
    end
end

function Sylas:BoltCapClose()
    local target = Orbwalker:GetTarget("Combo", self.BoltRange)
    if target then
        local Bolt = self:Bolt_Check()
        if self.UseBolt.Value == 1 and Bolt ~= false then
            Engine:CastSpell(Bolt.Key, target.Position, 1)
        end
    end
end

function Sylas:ItemUsage()
    Sylas:BoltCapClose()
    Sylas:GLPusage()
end


function Sylas:Combo()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
                if self:WdmgKS(target) and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end  
            else
                if Passive.Count_Alt < 3 then
                    if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end
                    if self:WdmgKS(target) and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end  
                end
                if myHero.Health <= myHero.MaxHealth / 100 * (self.WHealth.Value * 0.7) then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 and not Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.QRange - 70)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL1", CastPos, 1)
                    return
                end
            else
                if Passive.Count_Alt < 3 then
                    local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                        return
                    end
                end
            end    
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        local target1 = Orbwalker:GetTarget("Combo", self.E1Range + 450)
        local target2 = Orbwalker:GetTarget("Combo", self.E2Range - 200)
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if target1 then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    return
                end
            else
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    return
                end
            end
        end
        if target2 then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() then
                if EBuff.Valid == true then
                    local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1, true, self.EHitChance, 1)
                    if CastPos then
                        CastPos = self:GetQCastPos(CastPos)
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                        return
                    end
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == true then
                        local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1, true, self.EHitChance, 1)
                        if CastPos then
                            CastPos = self:GetQCastPos(CastPos)
                            Engine:CastSpell("HK_SPELL3", CastPos, 1)
                            return
                        end
                    end
                end
            end
        end          
    end


 
end

function Sylas:Harass()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")

    if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassWMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth2.Value then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
                if self:WdmgKS(target) and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end  
            else
                if Passive.Valid == false then
                    if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth2.Value then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end
                    if self:WdmgKS(target) and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end  
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.QRange - 70)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL1", CastPos, 1)
                    return
                end
            else
                if Passive.Valid == false then
                    local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0, true, self.QHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                        return
                    end
                end
            end    
        end
    end
    
    if Engine:SpellReady("HK_SPELL3") and self.HarassE.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassEMana.Value / 100 then return end
        local target1 = Orbwalker:GetTarget("Combo", self.E1Range + 450)
        local target2 = Orbwalker:GetTarget("Combo", self.E2Range - 200)
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if target1 then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    return
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == false then
                        Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                        return
                    end
                end
            end
        end
        if target2 then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() then
                if EBuff.Valid == true then
                    local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1, true, self.EHitChance, 1)
                    if CastPos then
                        CastPos = self:GetQCastPos(CastPos)
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                        return
                    end
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == true then
                        local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1, true, self.EHitChance, 1)
                        if CastPos then
                            CastPos = self:GetQCastPos(CastPos)
                            Engine:CastSpell("HK_SPELL3", CastPos, 1)
                            return
                        end
                    end
                end
            end
        end          
    end

end

function Sylas:Laneclear()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.ClearWMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target and target.IsMinion and target.Health > 10 then
            if Passive.Valid == false then
                Engine:CastSpell("HK_SPELL2", target.Position, 1)
                return
            end 
        end
    end
    
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.ClearQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", self.QRange - 70)
        if target and target.IsMinion and target.Health > 10 then 
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                Engine:CastSpell("HK_SPELL1", target.Position, 1) 
                return
            else
                if Passive.Valid == false then 
                    Engine:CastSpell("HK_SPELL1", target.Position, 1) 
                    return
                end
            end    
        end
    end
    
    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.ClearEMana.Value / 100 then return end
        local target1 = Orbwalker:GetTarget("Laneclear", self.E1Range + 450)
        local target2 = Orbwalker:GetTarget("Laneclear", self.E2Range - 200)
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if target1 and target1.IsMinion and target1.Health > 10 then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    return
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == false then
                        Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                        return
                    end
                end
            end
        end
        if target2 and target2.IsMinion and target2.Health > 10 then
            if EBuff.Valid == true and Passive.Valid == false then
                Engine:CastSpell("HK_SPELL3", target2.Position, 1)
                return
            end
        end          
    end
end

function Sylas:UseR()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")
    local target = Orbwalker:GetTarget("Combo", 25000)
    if target and Engine:SpellReady("HK_SPELL4") then
        local hp = target.Health

        if myHero:GetSpellSlot(3).Info.Name == "AatroxR" then                                                                                                                                                          --Aatrox R
            if EnemiesInRange(myHero.Position, 650) > 1 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "AhriTumble" then                                                                                                                                                       --Ahri R
            if GetDist(myHero.Position, target.Position) <= 500 then
                if GetDist(myHero.Position, target.Position) >= self:getAttackRange() then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                else
                    if Passive.Valid == false then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                        return
                    end
                end 
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "AkaliR" then
            local AkaliR1 = Sylas:GetDamage(25 + 100 * myHero:GetSpellSlot(3).Level + 0.2 * myHero.AbilityPower, false, target)
            local AkaliR2 = Sylas:GetDamage((Target.MaxHealth - Target.Health + AkaliR1) / Target.MaxHealth * 3 * (35 + (70 * myHero:GetSpellSlot(3).Level) + 0.3 * myHero.AbilityPower), false, target)
            local TotalDamage = AkaliR1 + AkaliR2                                                                                                                                                                       --Akali R
            if GetDist(myHero.Position, target.Position) <= 600 then
                if HP < TotalDamage then
                    Engine:CastSpell("HK_SPELL4", Target.Position, 1)
                    return
                end
            end
        end
        
        if myHero:GetSpellSlot(3).Info.Name == "AkaliRb" then
            --local AkaliR1 = Sylas:GetDamage(25 + 100 * myHero:GetSpellSlot(3).Level + 0.2 * myHero.BonusAttack, false, target)
            local AkaliR2 = Sylas:GetDamage((Target.MaxHealth - Target.Health) / Target.MaxHealth * 3 * (35 + (70 * myHero:GetSpellSlot(3).Level) + 0.3 * myHero.AbilityPower), false, target)
            local TotalDamage = AkaliR2                                                                                                                                                                                 --Akali R
            if GetDist(myHero.Position, target.Position) <= 750 then
                if HP < TotalDamage then
                    Engine:CastSpell("HK_SPELL4", Target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "FerociousHowl" then                                                                                                                                                    --Alistar R Working
            if EnemiesInRange(myHero.Position, 800) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
            local heroUltCondition = myHero.MaxHealth / 100 * 40
            if myHero.Health <= heroUltCondition and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "CurseoftheSadMummy" then                                                                                                                                               --Amumu R
            if EnemiesInRange(myHero.Position, 550) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "GlacialStorm" then                                                                                                                                                     --Anivia
            if GetDist(myHero.Position, target.Position) <= 750 then
                if EnemiesInRange(target.Position, 350) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "AnnieR" then                                                                                                                                                           --Annie R
            if GetDist(myHero.Position, target.Position) <= 600 then
                if EnemiesInRange(target.Position, 300) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "EnchantedCrystalArrow" then                                                                                                                                            --Ashe R
            if GetDist(myHero.Position, target.Position) <= 1500 then
                local CastPos, target = Prediction:GetCastPos(myHero.Position, 1500, 1600, 130, 0.25, 0, true, self.RHitChance, 1)
                if CastPos then
                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                    return
                end
            end
        end
        
        if myHero:GetSpellSlot(3).Info.Name == "AurelionSolR" then                                                                                                                                                     --AurelionSol
            if GetDist(myHero.Position, target.Position) <= 1400 then
                if EnemiesInRange(target.Position, 500) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "StaticField" then                                                                                                                                                       --BlitzCrank R Working
            if EnemiesInRange(myHero.Position, 600) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
            if GetDist(myHero.Position, target.Position) <= 600 then
                local BlitzR = Sylas:GetDamage(125 + 125 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower, false, target)
                if hp < BlitzR then
                    Engine:CastSpell("HK_SPELL4", nil, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "BrandR" then                                                                                                                                                           --Brand R
            if GetDist(myHero.Position, target.Position) <= 750 then
                if EnemiesInRange(target.Position, 450) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "BraumRWrapper" then                                                                                                                                                    --Braum
            if GetDist(myHero.Position, target.Position) <= 1150 then
                if EnemiesInRange(target.Position, 200) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "CaitlynAceintheHole" then                                                                                                                                               --Caitlyn R
            if GetDist(myHero.Position, target.Position) <= 3500 and EnemiesInRange(myHero.Position, 1000) == 0 then
                if EnemiesInRange(target.Position, 400) == 1 then
                    local CaitlynR = Sylas:Killable(75 + 225 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.8, false, target)
                    if hp < CaitlynR then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                        return
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "CamilleR" then
            target2 = Orbwalker:GetTarget("Combo", 1000)                                                                                                                                                                --Camille R
            if GetDist(myHero.Position, target2.Position) <= 475 then
                if EnemiesInRange(target2.Position, 425) > 2 then
                    Engine:CastSpell("HK_SPELL4", target2.Position, 1)
                    return
                end
            end
        end
        
        if myHero:GetSpellSlot(3).Info.Name == "CassiopeiaR" then                                                                                                                                                       --Cassiopeia R
            local Target = self:CassGetRTarget()
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL4", Target.Position ,1)
                return			
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "Feast" then                                                                                                                                                             --Cho'gath R
            local ChoR = Sylas:GetDamage(125 + 175 * myHero:GetSpellSlot(3).Level + 0.5 * myHero.AbilityPower + 0.1 * Sylas:GetBonusHealth(), false, target)
            if GetDist(myHero.Position, target.Position) <= 175  and hp < ChoR then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "MissileBarrage" then                                                                                                                                                    --Corki R
            if GetDist(myHero.Position, target.Position) <= self:getAttackRange() then
                if Passive.Count_Alt < 3 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "DariusExecute" then                                                                                                                                                     --Darius R Working
            local HeroList = ObjectManager.HeroList
            for i, target5 in pairs(HeroList) do
                if target5.Team ~= myHero.Team then
                    if GetDist(myHero.Position, target5.Position) <= 470 then
                        local DariusR = 100 * myHero:GetSpellSlot(3).Level + 0.3 * myHero.AbilityPower
                        if target5.Health < DariusR then
                            Engine:CastSpell('HK_SPELL4', target5.Position, 1)
                            return
                        end
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "DianaR" then                                                                                                                                                            --Diana R
            if EnemiesInRange(myHero.Position, 450) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "DravenRCast" then                                                                                                                                                       --Draven R
            local R2 = myHero.BuffData:GetBuff("DravenRDoublecast")
            if R2.Valid then
                Engine:CastSpell("HK_SPELL4", GameHud.MousePos, 1)
                return
            end
            local Heros = ObjectManager.HeroList
            for I, Hero in pairs(Heros) do
                if Hero.Team ~= myHero.Team then
                    local rDmg = Sylas:GetDamage(75 + (100 * myHero:GetSpellSlot(3).Level) + ((0.9 + (0.2 * myHero:GetSpellSlot(3).Level)) * myHero.AbilityPower) * 0.4, false, target)
                    local totalDmg = rDmg * 2
                    if Hero.Health <= totalDmg then
                        local castPos = Prediction:GetCastPos(myHero.Position, 1900, 2000, 150, 0.25, 0, true, self.RHitChance, 1)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL4", castPos, 1)
                            return
                        end
                    end
                end
            end
        end

        local rPos = Sylas:GetChronoShadow()
        if rPos then                                                                                                                                                                                                    --Ekko
            local HeroList = ObjectManager.HeroList
            for i, target3 in pairs(HeroList) do
                if target3.Team ~= myHero.Team and target3.IsDead == false then
                    if GetDist(rPos.Position, target3.Position) <= 375 then
                        local EkkoR = Sylas:GetDamage((150 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 1.5), false, target3)
                        if EkkoR > target3.Health then
                            Engine:CastSpell('HK_SPELL4', nil, 0)
                            return
                        end
                    end
                    if EnemiesInRange(rPos.Position, 375) > 2 then
                        Engine:CastSpell('HK_SPELL4', nil, 0)
                        return
                    end
                end
            end

            local Rcondition = myHero.MaxHealth / 100 * 35
            if myHero.Health <= Rcondition and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell('HK_SPELL4', nil, 0)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "EvelynnR" then                                                                                                                                                          --Evelynn R
            if GetDist(myHero.Position, target.Position) <= 440 then
                if myHero.Health <= myHero.MaxHealth / 100 * 40 and not Engine:SpellReady("HK_SPELL2") then
                    if self:EveRDmg(target) then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                        return
                    end
                end
                if Engine:GetForceTarget(target) then
                    if self:EveRDmg(target) then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                        return
                    end
                end
                if self:EveEnemiesRKillable(myHero.Position, 440) >= 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "EzrealR" then                                                                                                                                                           --Ezreal R
            local StartPos 			= myHero.Position
            local CastPos ,Target	= Prediction:GetCastPos(StartPos, 2500, 2000, 0, 0.25, 0, true, self.RHitChance, 1)
            if CastPos ~= nil and Target ~= nil then
                local RDMG = Sylas:GetDamage(200 + 150 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.9, false, target)
                if hp < RDMG then
                    Engine:CastSpellMap("HK_SPELL4", CastPos ,1)
                    return
                end
            end
        end

        --Fiddlestick R NO needed

        --Galio R NO needed

        --Gangplank R NO needed

        if myHero:GetSpellSlot(3).Info.Name == "GarenR" then                                                                                                                                                            --Garen R                                                                                                                                                          
            local UltLvl = myHero:GetSpellSlot(3).Level
            local HeroList = ObjectManager.HeroList
            for i, target4 in pairs(HeroList) do
                if target4.Team ~= myHero.Team then
                    if GetDist(myHero.Position, target4.Position) <= 400 then
                        local Demacia = UltLvl * 150 + (target4.MaxHealth - target4.Health) * (0.15 + 0.05 * UltLvl)
                        if target4.Health + 77 < Demacia then
                            Engine:CastSpell('HK_SPELL4', target4.Position, 1)
                            return
                        end
                    end
                end
            end
        end

        --Gnar Coming soon

        --Gragas Coming soon

        if myHero:GetSpellSlot(3).Info.Name == "GravesChargeShot" then                                                                                                                                                  --Graves R                                                                                      
            local MyPos = myHero.Position
            local PredPos, Target = Prediction:GetCastPos(MyPos, 1000, 2000, 0, 0.25, 0, true, self.RHitChance, 1)
            if PredPos ~= nil and Target ~= nil then
                if GetDist(MyPos, PredPos) < 1100 then
                    local GravesR = Sylas:GetDamage(100 + 150 * myHero:GetSpellSlot(3).Level + 0.6 * myHero.AbilityPower, false, Target)
                    if hp < GravesR then
                        Engine:CastSpell("HK_SPELL4", PredPos)
                        return
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "HecarimUlt" then                                                                                                                                                        --Hecarim R
            local HecarimR = Sylas:GetDamage(50 + 100 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower, false, target)
            if GetDist(myHero.Position, target.Position) <= 1350 then
                if EnemiesInRange(target.Position, 280) > 2 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    return
                end
            end
            if hp < HecarimR then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
            if GetDist(myHero.Position, target.Position) <= 1000 then
                if EnemiesInRange(target.Position, 280) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
                if hp < HecarimR then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
        
        --Heimerdinger soon!

        --Illaoi NO needed!

        if myHero:GetSpellSlot(3).Info.Name == "IreliaR" then                                                                                                                                                           --Irelia
            if GetDist(myHero.Postion, target.Postion) <= 888 then
                if EnemiesInRange(target.Position, 350) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
                if target.Health <= target.MaxHealth / 100 * 40 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        --Ivern IDK?!?

        if myHero:GetSpellSlot(3).Info.Name == "JarvanIVCataclysm" then
            local target6 = Orbwalker:GetTarget(1000)
            if target6 then                                                                                                                                                                                             --JarvanIV R
                if GetDist(myHero.Position, target6.Position) < 640 then
                    if EnemiesInRange(target6.Position, 325) > 2 then
                        Engine:CastSpell("HK_SPELL4", target6.Position, 1)
                        return
                    end
                    if target6.Health <= target6.MaxHealth / 100 * 45 then
                        Engine:CastSpell("HK_SPELL4", target6.Position, 1)
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "JaxRelentlessAssault" then                                                                                                                                              --Jax R          
            if EnemiesInRange(myHero.Position, 650) > 1 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "JinxR" then                                                                                                                                                             --Jinx R                                                                                                                                                                                         
            local StartPos 			= myHero.Position
            local CastPos ,Target	= Prediction:GetCastPos(StartPos, 2500, 2500, 0, 0.75, 0, true, self.RHitChance, 1)
            if CastPos ~= nil and Target ~= nil then
                local RDMG = Sylas:GetDamage(150 + (100 * myHero.GetSpellSlot(3).Level) * 2 + (myHero.AbilityPower * 0.6) + ((Target.MaxHealth - Target.Health) * (0.20 + (0.05 * myHero.GetSpellSlot(3).Level))) )
                if hp < RDMG then
                    Engine:CastSpellMap("HK_SPELL4", CastPos ,1)
                    return
                end
            end
        end

        --Kalista soon!

        --Karma NO need!

        --Karthus soon!

        --Kassadin NO need!

        --Katarina soon!

        --Kaisa NO need!

        if myHero:GetSpellSlot(3).Info.Name == "KaynR" then                                                                                                                                                             --Kayn R                                              
            local selfCondition = myHero.MaxHealth / 100 * 40
            local canR = target.BuffData:GetBuff("kaynrenemymark")
            if canR.Valid then
                if GetDist(myHero.Position, target.Position) <= 550 then
                    if myHero.Health <= selfCondition and not Engine:SpellReady("HK_SPELL2") then
                        Engine:CastSpell("HK_SPELL4", target.Position)
                        return
                    end
                    local KaynR = Sylas:GetDamage(50 + 100 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.7, false, target)
                    if hp < KaynR then
                        Engine:CastSpell("HK_SPELL4", target.Position)
                        return
                    end
                end
            end
        end
      
        if myHero:GetSpellSlot(3).Info.Name == "KennenShurikenStorm" then                                                                                                                                               --Kennen
            if EnemiesInRange(myHero.Position, 550) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "LeonaSolarFlare" then                                                                                                                                                    --Leona R
            if GetDist(myHero.Position, target.Position) <= 1100 then
                if EnemiesInRange(target.Position, 250) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "UFSlash" then                                                                                                                                                           --Malphite R
            local castPos = Prediction:GetCastPos(myHero.Position, 1000, 1650, 370, 0.25, 0, true, self.RHitChance, 1)
            if castPos ~= nil then
                local targetCount = EnemiesInRange(castPos, 370)
                if targetCount >= 2 then
                    Engine:CastSpell("HK_SPELL4", castPos,1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "Sadism" then                                                                                                                                                            --Mundo R                                         
            local heroUltCondition = myHero.MaxHealth / 100 * 40
            if EnemiesInRange(myHero.Position, 650) > 1 then
                if myHero.Health <= heroUltCondition then
                    Engine:CastSpell("HK_SPELL4", nil, 1)
                    return
                end
            end
        end


        if myHero:GetSpellSlot(3).Info.Name == "MorganaR" then                                                                                                                                                          --Morgana R
            if EnemiesInRange(myHero.Position, 550) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "PykeR" then                                                                                                                                                             --Pyke R           
            Sylas:PykeUltimate()
            return
        end

        if myHero:GetSpellSlot(3).Info.Name == "SejuaniR" then                                                                                                                                                          --Sejuani
            local castPos = Prediction:GetCastPos(myHero.Position, 1200, 1500, 370, 0.25, 0, true, self.RHitChance, 1)
            if castPos ~= nil then
                local targetCount = EnemiesInRange(castPos, 400)
                if targetCount >= 2 then
                    Engine:CastSpell("HK_SPELL4", castPos,1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "VarusR" then                                                                                                                                                            --Varus R
            local castPos = Prediction:GetCastPos(myHero.Position, 900, 1850, 370, 0.25, 0, true, self.RHitChance, 1)
            if castPos ~= nil then
                local targetCount = EnemiesInRange(castPos, 550)
                if targetCount >= 2 then
                    Engine:CastSpell("HK_SPELL4", castPos,1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "VladimirHemoplague" then                                                                                                                                                --Vladimir R
            if GetDist(myHero.Position, target.Position) <= 600 then
                if EnemiesInRange(target.Position, 370) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "VolibearR" then                                                                                                                                                         --Volibear R
            if GetDist(myHero.Position, target.Position) <= 700 then
                if EnemiesInRange(target.Position, 500) > 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "ChronoShift" then                                                                                                                                                       --Zilean R
            local heroUltCondition = myHero.MaxHealth / 100 * 25
            if myHero.Health <= heroUltCondition and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL4", myHero.Position)
                return
            end
            for i, Ally in pairs(ObjectManager.HeroList) do
                if Ally.Team == myHero.Team and Ally.ChampionName ~= myHero.ChampionName then
                    local allyUltCondition = Ally.MaxHealth / 100 * 15
                    if Ally.Health <= allyUltCondition then
                        Engine:CastSpell("HK_SPELL4", Ally.Position)
                        return
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "FizzR" then                                                                                                                                                             --Fizz R                                                                                                                                                                                                     --Sejuani
            local castPos = Prediction:GetCastPos(myHero.Position, 1150, 1300, 0, 0.25, 0, true, self.RHitChance, 1)
            if castPos ~= nil then
                if hp <= target.MaxHealth / 100 * 45 then
                    Engine:CastSpell("HK_SPELL4", castPos,1)
                    return
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "TeemoRCast" then                                                                                                                                                        --Teemo R
            if GetDist(myHero.Position, target.Position) <= getAttackRange() and Passive.Count_Alt < 3 then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                return
            end
        end
        
        if myHero:GetSpellSlot(3).Info.Name == "NasusR" then                                                                                                                                                            --Nasus
            if EnemiesInRange(myHero.Position, 650) > 1 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "NeekoR" then                                                                                                                                                            --Neeko
            if EnemiesInRange(myHero.Position, 580) > 2 then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end
        
        if myHero:GetSpellSlot(3).Info.Name == "KayleR" then                                                                                                                                                            --Kayle R
            local heroUltCondition = myHero.MaxHealth / 100 * 25
            if myHero.Health <= heroUltCondition and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL4", myHero.Position)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "VeigarR" then                                                                                                                                                           --Veigar                                          
            local HeroList = ObjectManager.HeroList
            for i, RTarget in pairs(HeroList) do
                if RTarget.Team ~= myHero.Team and RTarget.IsTargetable then
                    if GetDist(myHero.Position, RTarget.Position) <= 650 then
                        local hBurst = 1 + math.min(1, (1 - RTarget.Health / RTarget.MaxHealth) * 3/2)
                        local pBurst = Sylas:GetDamage(100 + (75 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.75), false, RTarget) *hBurst
                        if pBurst >= RTarget.Health then
                            return Engine:CastSpell('HK_SPELL4', RTarget.Position, 1)
                        end
                    end
                end
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "LissandraR" then                                                                                                                                                        --Lissandra                   
            local Rcondition = myHero.MaxHealth / 100 * 25
            if myHero.Health <= Rcondition and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell('HK_SPELL4', myHero.Position, 1)
                return
            end
        end

        if myHero:GetSpellSlot(3).Info.Name == "SamiraR" then                                                                                                                                                           --Samira R
            if EnemiesInRange(myHero.Position, 600) > 2 then
                Engine:CastSpell('HK_SPELL4', nil, 1) 
                return
            end
        end

    end
end

function Sylas:RSupport()
    if myHero:GetSpellSlot(3).Info.Name == "AatroxR" or myHero:GetSpellSlot(3).Info.Name == "AhriTumble" or myHero:GetSpellSlot(3).Info.Name == "AkaliR" or myHero:GetSpellSlot(3).Info.Name == "AkaliRb" or myHero:GetSpellSlot(3).Info.Name == "FerociousHowl" or myHero:GetSpellSlot(3).Info.Name == "CurseoftheSadMummy" or myHero:GetSpellSlot(3).Info.Name == "GlacialStorm" or myHero:GetSpellSlot(3).Info.Name == "AnnieR" or myHero:GetSpellSlot(3).Info.Name == "EnchantedCrystalArrow" or myHero:GetSpellSlot(3).Info.Name == "AurelionSolR" or myHero:GetSpellSlot(3).Info.Name == "StaticField" or myHero:GetSpellSlot(3).Info.Name == "BrandR" or myHero:GetSpellSlot(3).Info.Name == "BraumRWrapper" or myHero:GetSpellSlot(3).Info.Name == "CaitlynAceintheHole" or myHero:GetSpellSlot(3).Info.Name == "CamilleR" or myHero:GetSpellSlot(3).Info.Name == "CassiopeiaR" or myHero:GetSpellSlot(3).Info.Name == "Feast" or myHero:GetSpellSlot(3).Info.Name == "MissileBarrage" or myHero:GetSpellSlot(3).Info.Name == "DariusExecute" or myHero:GetSpellSlot(3).Info.Name == "DianaR" or myHero:GetSpellSlot(3).Info.Name == "DravenRCast" or Sylas:GetChronoShadow() or myHero:GetSpellSlot(3).Info.Name == "EvelynnR" or myHero:GetSpellSlot(3).Info.Name == "EzrealR" or myHero:GetSpellSlot(3).Info.Name == "GarenR" or myHero:GetSpellSlot(3).Info.Name == "GravesChargeShot" or myHero:GetSpellSlot(3).Info.Name == "HecarimUlt" or myHero:GetSpellSlot(3).Info.Name == "IreliaR" or myHero:GetSpellSlot(3).Info.Name == "JarvanIVCataclysm" or myHero:GetSpellSlot(3).Info.Name == "JaxRelentlessAssault" or myHero:GetSpellSlot(3).Info.Name == "JinxR" or myHero:GetSpellSlot(3).Info.Name == "KaynR" or myHero:GetSpellSlot(3).Info.Name == "KennenShurikenStorm" or myHero:GetSpellSlot(3).Info.Name == "LeonaSolarFlare" or myHero:GetSpellSlot(3).Info.Name == "UFSlash" or myHero:GetSpellSlot(3).Info.Name == "Sadism" or myHero:GetSpellSlot(3).Info.Name == "MorganaR" or myHero:GetSpellSlot(3).Info.Name == "PykeR" or myHero:GetSpellSlot(3).Info.Name == "SejuaniR" or myHero:GetSpellSlot(3).Info.Name == "VarusR" or myHero:GetSpellSlot(3).Info.Name == "VladimirHemoplague" or myHero:GetSpellSlot(3).Info.Name == "VolibearR" or myHero:GetSpellSlot(3).Info.Name == "ChronoShift" or myHero:GetSpellSlot(3).Info.Name == "FizzR" or myHero:GetSpellSlot(3).Info.Name == "TeemoRCast" or myHero:GetSpellSlot(3).Info.Name == "NasusR" or myHero:GetSpellSlot(3).Info.Name == "NeekoR" or myHero:GetSpellSlot(3).Info.Name == "KayleR" or myHero:GetSpellSlot(3).Info.Name == "VeigarR" or myHero:GetSpellSlot(3).Info.Name == "LissandraR" or myHero:GetSpellSlot(3).Info.Name == "SamiraR" then
        return true
    end
    return false
end

function Sylas:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        --self:GetEnemyHeroes()
        --Sylas:GetAllItemNames()
        -- print(myHero:GetSpellSlot(3).Info.Name)
        --print(myHero.BuffData:GetBuff("SylasPassiveAttack").Count_Alt)
        if Engine:IsKeyDown("HK_COMBO") then
            Sylas:UseR()
            Sylas:ItemUsage()
            Sylas:Combo()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sylas:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sylas:Laneclear()
            return
        end
    end
end

function Sylas:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if EBuff.Valid == false then
            Render:DrawCircle(myHero.Position, self.E1Range, 225, 0, 225, 225)
        end
        if EBuff.Valid == true then
            Render:DrawCircle(myHero.Position, self.E2Range, 228, 185, 10, 225)
        end
    end
    --if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        --Render:DrawCircle(myHero.Position, 1000, 255, 0, 255, 255)
    --end
    if self:RSupport() == true then
        Render:DrawString("R is supported with script!", 850, 50, 0, 255, 76, 255)
    end
end

function Sylas:OnLoad()
    if(myHero.ChampionName ~= "Sylas") then return end
    AddEvent("OnSettingsSave" , function() Sylas:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sylas:LoadSettings() end)

	Sylas:__init()
	AddEvent("OnTick", function() Sylas:OnTick() end)
    AddEvent("OnDraw", function() Sylas:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Sylas:OnLoad() end)