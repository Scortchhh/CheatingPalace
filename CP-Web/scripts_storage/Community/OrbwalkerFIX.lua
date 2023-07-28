Orbwalker = {
	Prio = {},
	TargetingOptions = {
		"Nearest",
		"Lowest",
		"AD priotity",
		"AP priority",
	},
}

function Orbwalker:__init()
	self.Enabled        = 1

	self.Attack 		= 0
	self.WindingUp		= 0
	
	self.Timer_WindUp 	= 0
	self.Timer_Delay 	= 0
	self.Timer_LastMove = 0
	
	self.ExtraWindup    = 0
	self.ExtraDamage	= 0	

	self.ResetReady		= 0	
	self.PrevTarget		= nil
	self.DrawTarget     = nil
	self.ForceTarget 	= nil
	-------------------------------------------
	self.OrbMenu 							= Menu:CreateMenu("Orbwalker")
    self.OrbDelay 							= self.OrbMenu:AddSlider("Delay in %", 100, 75, 125, 1)
	self.OrbWindup 							= self.OrbMenu:AddSlider("Windup in %", 100, 75, 125, 1)	
	-------------------------------------------
	self.OrbTargetSelector                  = self.OrbMenu:AddSubMenu("Target Selector")
	self.TargetOption                       = self.OrbTargetSelector:AddCombobox("Targeting Options", Orbwalker.TargetingOptions)
	-------------------------------------------
    self.OrbWaveclear						= self.OrbMenu:AddSubMenu("Waveclear")
    self.SupportMode                        = self.OrbWaveclear:AddCheckbox("SupportMode", 0)
	self.TraditionalWaveclear				= self.OrbWaveclear:AddCheckbox("Traditional", 1)
	self.NewWaveclear						= self.OrbWaveclear:AddCheckbox("New", 0)
	-------------------------------------------
	self.OrbDrawings						= self.OrbMenu:AddSubMenu("Drawings")
	self.MyRange							= self.OrbDrawings:AddCheckbox("MyRange", 1)
	self.EnemyRange							= self.OrbDrawings:AddCheckbox("EnemyRange", 1)
	-------------------------------------------
	self.OrbDebug							= self.OrbMenu:AddSubMenu("Debug")
	self.DebugEnabled						= self.OrbDebug:AddCheckbox("Enable Debug", 0)
	self.DebugOnlyMove						= self.OrbDebug:AddCheckbox("Only move", 0)
	
	self.BlockAA		= false
	self.MovePosition	= Vector3.new()

	Orbwalker:LoadSettings()
end



function Orbwalker:SaveSettings()
	SettingsManager:CreateSettings			("Orbwalker")
	SettingsManager:AddSettingsGroup		("Slider")
	SettingsManager:AddSettingsFloat		("Delay", self.OrbDelay.Value)
	SettingsManager:AddSettingsFloat		("Windup", self.OrbWindup.Value)
	------------------------------------------------------------
    SettingsManager:AddSettingsGroup		("Waveclear")
    SettingsManager:AddSettingsInt			("Support", self.SupportMode.Value)
	SettingsManager:AddSettingsInt			("Traditional", self.TraditionalWaveclear.Value)
	SettingsManager:AddSettingsInt			("New", self.NewWaveclear.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup		("Drawings")
	SettingsManager:AddSettingsInt			("MyRange", self.MyRange.Value)
	SettingsManager:AddSettingsInt			("EnemyRange", self.EnemyRange.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup		("Debug")
	SettingsManager:AddSettingsInt			("DebugEnabled", self.DebugEnabled.Value)
	SettingsManager:AddSettingsInt			("DebugOnlyMove", self.DebugOnlyMove.Value)
end

function Orbwalker:LoadSettings()
	SettingsManager:GetSettingsFile			("Orbwalker")
	self.OrbDelay.Value 					= SettingsManager:GetSettingsFloat("Slider","Delay")
	self.OrbWindup.Value 					= SettingsManager:GetSettingsFloat("Slider","Windup")
    -------------------------------------------------------------
    self.SupportMode.Value 		            = SettingsManager:GetSettingsInt("Waveclear","Support")
	self.TraditionalWaveclear.Value 		= SettingsManager:GetSettingsInt("Waveclear","Traditional")
	self.NewWaveclear.Value 				= SettingsManager:GetSettingsInt("Waveclear","New")
	-------------------------------------------------------------
	self.MyRange.Value 						= SettingsManager:GetSettingsInt("Drawings","MyRange")
	self.EnemyRange.Value 					= SettingsManager:GetSettingsInt("Drawings","EnemyRange")
	-------------------------------------------------------------
	self.DebugEnabled.Value 				= SettingsManager:GetSettingsInt("Debug","DebugEnabled")
	self.DebugOnlyMove.Value 				= SettingsManager:GetSettingsInt("Debug","DebugEnabled")
end

function Orbwalker:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Orbwalker:CanLasthit(Target)
	local IncomingDamage		= 0
	local TargetArmorMod 		= 100 / (100 + Target.Armor)
	local PlayerDamage 			= myHero.BaseAttack + myHero.BonusAttack
	local PlayerMissileSpeed	= myHero.AttackInfo.Data.MissileSpeed
	if myHero.AttackRange < 300 then
		PlayerMissileSpeed 		= math.huge
	end
	local PlayerDistance		= math.max(0,self:GetDistance(myHero.Position, Target.Position) - myHero.CharData.BoundingRadius)
	local PlayerTime			= (PlayerDistance/PlayerMissileSpeed) + self:GetWindup() + self.ExtraWindup

	local MissileFilter = {}
	local Missiles = ObjectManager.MissileList
	for I,Object in pairs(ObjectManager.MissileList) do
		local Index 	= Object.Index
		local Name		= Object.Name
		if Index > 0 and string.len(Name) > 0 and MissileFilter[Index] == nil then
			MissileFilter[Index] = Object
		end
	end
	
	for I,Missile in pairs(MissileFilter) do
		local SourceID				= Missile.SourceIndex
		local TargetID				= Missile.TargetIndex
		local MissileSource			= nil
		local MissileTarget			= nil
		if SourceID > 0 and SourceID < 10000 then
			MissileSource 			= ObjectManager:GetObjectByID(SourceID)
		end
		if TargetID > 0 and TargetID < 10000 then
			MissileTarget 			= ObjectManager:GetObjectByID(TargetID)
		end
		if I == Missile.Index and MissileTarget and MissileSource and MissileSource.IsMinion and MissileSource.IsDead == false and MissileSource.AttackRange > 300 then
			local MissileDistance		= self:GetDistance(Missile.Position, Target.Position)
			if MissileDistance > 0 and MissileTarget.Index == Target.Index and Missile.Team == myHero.Team then
				local MissileDamage 	= (MissileSource.BaseAttack * TargetArmorMod) - 2
				local MissileTime		= MissileDistance / 650
				if MissileTime < PlayerTime then
					IncomingDamage 		= IncomingDamage + MissileDamage
				end
			end
		end
	end
	IncomingDamage = IncomingDamage + (PlayerDamage * TargetArmorMod) + self.ExtraDamage - 5
	if IncomingDamage > Target.Health then
		return true
	end
	
	return false
end

function Orbwalker:AllyMinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do   
        if Minion.Team == myHero.Team and Minion.IsDead == false then
            if Orbwalker:GetDistance(Minion.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Orbwalker:CanWaveClear(Target)
	local IncomingDamage		= 0
	local TargetArmorMod 		= 100 / (100 + Target.Armor)
	local PlayerDamage 			= myHero.BaseAttack + myHero.BonusAttack
	local PlayerMissileSpeed	= myHero.AttackInfo.Data.MissileSpeed
	local AttackSpeed			= myHero.AttackSpeedMod
	if myHero.AttackRange < 300 then
		PlayerMissileSpeed 		= math.huge
	end
	local PlayerDistance		= math.max(0,self:GetDistance(myHero.Position, Target.Position) - myHero.CharData.BoundingRadius)
	local PlayerTime			= (PlayerDistance/PlayerMissileSpeed) + self:GetWindup() + self.ExtraWindup

	local MissileFilter = {}
	local Missiles = ObjectManager.MissileList
	for I,Object in pairs(ObjectManager.MissileList) do
		local Index 	= Object.Index
		local Name		= Object.Name
		if Index > 0 and string.len(Name) > 0 and MissileFilter[Index] == nil then
			MissileFilter[Index] = Object
		end
	end
	
	--[[local MinionList = ObjectManager.MinionList -- Critic: Fully modded
	if AttackSpeed < 1.85 then
		for i, Minion in pairs(MinionList) do   
			if Minion.Team ~= myHero.Team and Minion.IsDead == false then
				if self:GetDistance(myHero.Position, Minion.Position) <= myHero.AttackRange + 50 then
					for I,Missile in pairs(MissileFilter) do
						local SourceID				= Missile.SourceIndex
						local TargetID				= Missile.TargetIndex
						local MissileSource			= nil
						local MissileTarget			= nil
						if SourceID > 0 and SourceID < 10000 then
							MissileSource 			= ObjectManager:GetObjectByID(SourceID)
						end
						if TargetID > 0 and TargetID < 10000 then
							MissileTarget 			= ObjectManager:GetObjectByID(TargetID)
						end
						if I == Missile.Index and MissileTarget and MissileSource and MissileSource.IsMinion and MissileSource.IsDead == false and MissileSource.AttackRange > 300 then
							local MissileDistance		= self:GetDistance(Missile.Position, Minion.Position)
							if MissileDistance > 0 and MissileTarget.Index == Minion.Index and Missile.Team == myHero.Team then
								local MissileDamage 	= ((MissileSource.BaseAttack * TargetArmorMod) - 2) * 1.8
								local MissileTime		= MissileDistance / 650
								if MissileTime < PlayerTime then
									IncomingDamage 		= IncomingDamage + MissileDamage
								end
							end
						end
					end
					IncomingDamage = IncomingDamage + (PlayerDamage * TargetArmorMod)
					if IncomingDamage > Minion.Health then
						return false
					end
				end
			end
		end
	end]]

	if Orbwalker:AllyMinionsInRange(myHero.Position, 650) <= 0 then
		return true
	end

	local damage = (PlayerDamage * TargetArmorMod) -- Critic: (removed) + self.ExtraDamage - 5

	local MinionList = ObjectManager.MinionList -- Critic
	if AttackSpeed < 1.85 then
		if Orbwalker:AllyMinionsInRange(myHero.Position, 650) > 0 then
			for i, Minion in pairs(MinionList) do   
				if Minion.Team ~= myHero.Team and Minion.IsDead == false then
					if self:GetDistance(myHero.Position, Minion.Position) <= myHero.AttackRange + 100 then
						if Minion.Health - damage <= damage * 1.35 then
							return false
						end
					end
				end
			end
		end
	end

	local DmgMod = 0 -- Critic: Made DmgMod for different AttackSpeeds
	if AttackSpeed < 1.5 then
		DmgMod = 2.20
	end
	if AttackSpeed > 1.5 and AttackSpeed < 1.95 then
		DmgMod = 1.6
	end
	if AttackSpeed > 1.95 and AttackSpeed < 2.27  then
		DmgMod = 1.4
	end
	if AttackSpeed > 2.27 and AttackSpeed < 2.6  then
		DmgMod = 1.3
	end
	if AttackSpeed > 2.6 and AttackSpeed < 2.9 then
		DMgMod = 1.2
	end
	if AttackSpeed > 2.9 and AttackSpeed < 3.35 then
		DmgMod = 1.1
	end
	if AttackSpeed > 3.35 then
		DmgMod = 1
	end

	if Target.Health - damage <= damage * DmgMod then -- Critic: Modded from 1.4 to DmgMod
		return false
	end

	return true
end

function Orbwalker:IsValidMinion(Minion)
	if Minion.Name == "k" then
		return false
	end
	if string.find(Minion.Name, "Camp", 1) ~= nil then
		return false
	end
	if string.find(Minion.Name, "Plant", 1) ~= nil then
		return false
	end
	if string.find(Minion.Name, "Fake", 1) ~= nil then
		return false
	end
	if string.find(Minion.Name, "Cupcake", 1) ~= nil then
		return false
	end
	if string.find(Minion.Name, "Feather", 1) ~= nil then
		return false
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
end

function Orbwalker:SortToNearest(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return self:GetDistance(myHero.Position, left.Position) < self:GetDistance(myHero.Position, right.Position)
        end)
    end
    return SortedTable
end

function Orbwalker:SortToLowestHealth(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return left.Health < right.Health
        end)
    end
    return SortedTable
end

function Orbwalker:SortToADPrio(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return (1 + left.Armor / 100) * left.Health < (1 + right.Armor / 100) * right.Health
        end)
    end
    return SortedTable
end

function Orbwalker:SortToAPPrio(Table)
    local SortedTable = {}
    for _, Object in pairs(Table) do
        SortedTable[#SortedTable + 1] = Object    
    end
    if #SortedTable > 1 then
        table.sort(SortedTable, function (left, right)
            return (1 + left.MagicResist / 100) * left.Health < (1 + right.MagicResist / 100) * right.Health
        end)
    end
    return SortedTable
end

function Orbwalker:SortTargetSelection(Table)
	-- 0 nearest
	if self.TargetOption.Selected == 0 then
		return Orbwalker:SortToNearest(Table)
	end
	-- 1 = lowest
	if self.TargetOption.Selected == 1 then
		return Orbwalker:SortToLowestHealth(Table)
	end
	-- 2 = AD prio
	if self.TargetOption.Selected == 2 then
		return Orbwalker:SortToADPrio(Table)
	end
	-- 3 = AP prio
	if self.TargetOption.Selected == 3 then
		return Orbwalker:SortToAPPrio(Table)
	end
end

function Orbwalker:GetForceTarget()
	local MouseObject = Engine:GetForceTarget()
	if MouseObject ~= nil then
		if MouseObject.IsMinion then
			self.ForceTarget = nil
			return
		end
		if MouseObject.Team ~= myHero.Team and MouseObject.IsHero and MouseObject.IsTargetable then
			self.ForceTarget = MouseObject
			return
		end
	end
	self.ForceTarget = nil
	return
end

function Orbwalker:GetTarget(OrbMode, Range)
	local currentHighest = nil
	local currentTarget = nil
    if OrbMode == "Combo" then
		if self.ForceTarget ~= nil then
			if self:GetDistance(myHero.Position, self.ForceTarget.Position) < (Range + self.ForceTarget.CharData.BoundingRadius) then
				local outVec = Vector3.new()
				local HeroPos = self.ForceTarget.Position		
				if Render:World2Screen(HeroPos, outVec) == true then
					return self.ForceTarget
				end
			end
		end

		local Heros = self:SortTargetSelection(ObjectManager.HeroList)
		for i, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team then
				local Minions = ObjectManager.MinionList
				for i, Minion in pairs(Minions) do
					if Minion.IsTargetable and myHero.Team ~= Minion.Team then
						if Minion.ChampionName == Hero.ChampionName then
							if Minion.ChampionName == "Shaco" then
								return
							end
							if self:GetDistance(myHero.Position, Minion.Position) <= 1000 then
								return Minion
							end
						end
					end
				end
				if self:GetDistance(myHero.Position, Hero.Position) < (Range + Hero.CharData.BoundingRadius) then
					local outVec = Vector3.new()
					local HeroPos = Hero.Position
					if Hero.IsTargetable and Render:World2Screen(HeroPos, outVec) == true then
						local currentPrio = self.Prio[Hero.Index].Value
						if currentHighest == nil then
							currentHighest = currentPrio
							currentTarget = Hero
						else
							if currentPrio > currentHighest then
								currentHighest = currentPrio
								currentTarget = Hero
							end
						end
					end
				end
			end
		end
		return currentTarget
	end
	
    if OrbMode == "Harass" then
        if self.SupportMode.Value == 0 then
            local Minions = self:SortToLowestHealth(ObjectManager.MinionList)
            for I, Minion in ipairs(Minions) do
                if Minion.Team ~= myHero.Team then
                    if self:GetDistance(myHero.Position, Minion.Position) < (Range + Minion.CharData.BoundingRadius) then
                        if Minion.IsTargetable and self:IsValidMinion(Minion) and self:CanLasthit(Minion) then
                            local outVec = Vector3.new()
                            local MinionPos = Minion.Position		
                            if Render:World2Screen(MinionPos, outVec)== true then
                                return Minion
                            end
                        end
                    end
                end
            end
        end
	
		if self.ForceTarget ~= nil then
			if self:GetDistance(myHero.Position, self.ForceTarget.Position) < (Range + self.ForceTarget.CharData.BoundingRadius) then
				local outVec = Vector3.new()
				local HeroPos = self.ForceTarget.Position		
				if Render:World2Screen(HeroPos, outVec) then
					return self.ForceTarget
				end
			end
		end

		local Heros = self:SortTargetSelection(ObjectManager.HeroList)
		for i, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team then
				if self:GetDistance(myHero.Position, Hero.Position) < (Range + Hero.CharData.BoundingRadius) then
					local outVec = Vector3.new()
					local HeroPos = Hero.Position
					if Hero.IsTargetable and Render:World2Screen(HeroPos, outVec) == true then
						local currentPrio = self.Prio[Hero.Index].Value
						if currentHighest == nil then
							currentHighest = currentPrio
							currentTarget = Hero
						else
							if currentPrio > currentHighest then
								currentHighest = currentPrio
								currentTarget = Hero
							end
						end
					end
				end
			end
		end
		return currentTarget
	end
	
	if OrbMode == "Laneclear" then 
		local Minions = self:SortToLowestHealth(ObjectManager.MinionList)
		for I, Minion in ipairs(Minions) do
			if Minion.Team ~= myHero.Team then
				if self:GetDistance(myHero.Position, Minion.Position) < (Range + Minion.CharData.BoundingRadius) then
					if self.TraditionalWaveclear.Value == 1 then
						if Minion.IsTargetable and self:IsValidMinion(Minion) then
							local outVec = Vector3.new()
							local MinionPos = Minion.Position		
							if Render:World2Screen(MinionPos, outVec) == true then
								return Minion
							end
						end
					end
					if self.NewWaveclear.Value == 1 then
						if self:CanWaveClear(Minion) == false then
							if Minion.IsTargetable and self:IsValidMinion(Minion) and self:CanLasthit(Minion) then
								local outVec = Vector3.new()
								local MinionPos = Minion.Position		
								if Render:World2Screen(MinionPos, outVec) == true then
									return Minion
								end
							end
						end
						
						if self:CanWaveClear(Minion) == true then
							if Minion.IsTargetable and self:IsValidMinion(Minion) then
								local outVec = Vector3.new()
								local MinionPos = Minion.Position		
								if Render:World2Screen(MinionPos, outVec) == true then
									return Minion
								end
							end
						end
					end
				end
			end
		end
    end
    if OrbMode == "Lasthit" then 
		local Minions = self:SortToLowestHealth(ObjectManager.MinionList)
		for I, Minion in ipairs(Minions) do
			if Minion.Team ~= myHero.Team then
				if self:GetDistance(myHero.Position, Minion.Position) < (Range + Minion.CharData.BoundingRadius) then
					if Minion.IsTargetable and self:IsValidMinion(Minion) and self:CanLasthit(Minion) then
						local outVec = Vector3.new()
						local MinionPos = Minion.Position		
						if Render:World2Screen(MinionPos, outVec) == true then
							return Minion
						end
					end
				end
			end
		end
    end
    return nil          
end

function Orbwalker:ActionReady()
	local Timer 		= self.Timer_LastMove
	local Elapsed 		= os.clock() -  Timer
	local APMTimer 		= (60000 / Settings.ActionsPerMinute) / 1000
	if Elapsed > APMTimer then
		return true
	end
	
	return false
end

function Orbwalker:GetDelay()
	local AttackSpeed 			= GameHud.AttackSpeed
	local AttackDelay 			= (1 / AttackSpeed)

	if myHero.ChampionName == "Graves" then
		AttackDelay = AttackDelay / 2
	end

	return AttackDelay
end

function Orbwalker:GetWindup()
	local AttackDelay 			= self:GetDelay()
	local Multiplicator 		= 0.3 + (math.min(0 ,myHero.CharData.CastTimeAdd) * myHero.CharData.CastTimeMod)
	return math.min((AttackDelay * Multiplicator) ,AttackDelay) + 0.03
end

function Orbwalker:IsChanneling()	
	local ThreshCheck = myHero:GetSpellSlot(0).Info.Name
	if ThreshCheck == "ThreshQLeap" then
		return true
	end

	local Channels = {
		"KaisaE","varusq","xerathlocusofpower2","lucianr","vladimire","kayler","yuumir","xeratharcanopulsechargeup"
	}
	local ActiveSpellName = myHero.ActiveSpell.Info.Name
	for i = 1, #Channels do
		local Channel = Channels[i]
		if string.find(ActiveSpellName, Channel, 1) ~= nil then
			return true
		end
	end
	
	local Buffs = {
		"dariusqcast","garene","lucianr","vladimire","vladimirsanguinepool","xayahr","yuumir","xeratharcanopulsechargeup"
	}
	for i = 1, #Buffs do
		local Buff = Buffs[i]
		if myHero.BuffData:GetBuff(Buff).Valid then
			return true
		end
	end

	return false
end

function Orbwalker:CanMove() 
	if myHero.ChampionName == "Kalista" then
		return true
	end

	local Timer 		= self.Timer_WindUp
	local Elapsed		= os.clock() - Timer
	if Elapsed > (self:GetWindup() * (self.OrbWindup.Value / 100)) then
		return true
	end	
	return false
end

function Orbwalker:CanAAReset()
	local AAResets = {
			"dariusnoxiantacticsonh", "sivirwmarker" , "rengarq", "rengarqemp", "garenq", "jaxempowertwo",
			"fioraflurry", "hecarimrapidslash", "jaycehypercharge", "leonashieldofdaybreak", "lucianpassivebuff",
			"monkeykingdoubleattack", "mordekaisermaceofspades", "nasusq", "nautiluspiercinggaze", "netherblade",
			"parley", "poppydevastatingblow", "powerfist", "renektonpreexecute", "shyvanadoubleattack",
			"takedown", "talonnoxiandiplomacy", "trundletrollsmash", "vie", "volibearq","xenzhaocombotarget", "yorickspectral", 
			"reksaiq","itemtitanichydracleavebuff"
	}
	for i = 1, #AAResets do
		local Buff = AAResets[i]
		if myHero.BuffData:GetBuff(Buff).Valid then
			return true
		end
	end
	return false
end
function Orbwalker:GetLevel()
	local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
	return totalLevel
end

function Orbwalker:CanAttack()---------------------------------TODO Champions with ammo
	if self:IsChanneling() == false then
		if self:CanAAReset() then
			return true
		end

		if myHero.MaxAmmo > 0 and myHero.Ammo < 1 and myHero.ChampionName ~= "Corki" and myHero.ChampionName ~= "Xayah" and myHero.ChampionName ~= "Sona" and myHero.ChampionName ~= "Ryze" then
			return false
		end

		local Timer 		= self.Timer_Delay
		local Elapsed		= os.clock() - Timer
		if myHero.ChampionName == "Kalista" then
			local AttackSpeed = GameHud.AttackSpeed
			if AttackSpeed > 2 then
				Elapsed = Elapsed * 1.5
			end
		end		 
		if Elapsed > (self:GetDelay() * (self.OrbDelay.Value / 100)) then
			return true
		end
	end
	return false
end

function Orbwalker:IsAutoAttack(Name)
	--print(Name)
	if string.find(Name, "Attack", 1) ~= nil then
		return true
	end
	local Autos = { "caitlynheadshotmissile","masteryidoublestrike","frostarrow", "garenslash2",
					"kennenmegaproc", "quinnwenhanced", "renektonexecute", "vaynecondemn",
					"renektonsuperexecute", "rengarnewpassivebuffdash", "trundleq", "xenzhaothrust", "xenzhaothrust2",
					"xenzhaothrust3", "viktorqbuff","xinzhaoqthrust1","xinzhaoqthrust2","xinzhaoqthrust3" }
	for i = 1, #Autos do
		if Name:lower() == Autos[i] then
			return true
		end
	end
	
	return false
end

function Orbwalker:IssueAttack(Position, ChampionClick)
	self.Attack 		= 1
	self.WindingUp 		= 1
	self.ResetReady 	= 0
	self.Timer_WindUp 	= os.clock()
	self.Timer_Delay	= os.clock()
	self.Timer_LastMove = os.clock()

	Engine:AttackClick(Position, ChampionClick)
end

function Orbwalker:IssueMove(Position)
	if self.Attack == 1 then
		self.Attack = 0
		if self:GetDistance(myHero.Position, GameHud.MousePos) > 65 then
			Engine:MoveClick(Position)
			self.Timer_LastMove = os.clock()
			return
		end
	end
	if self:ActionReady() == true then
		if self:GetDistance(myHero.Position, GameHud.MousePos) > 65 then
			Engine:MoveClick(Position)
			self.Timer_LastMove = os.clock()
			return
		end
	end
end

function Orbwalker:Orbwalk(Target)
	if Target ~= nil and self:IsChanneling() == false then 
        self.DrawTarget 		= Target
    else
		self.DrawTarget 			= nil
	end
	
	if self.WindingUp == 1 then
		self.Timer_WindUp 		= os.clock()
		self.Timer_Delay		= os.clock()
		
		
		local Timer 			= self.Timer_LastMove
		local Elapsed 			= os.clock() -  Timer

		local AttackName 		= myHero.ActiveSpell.Info.Name
		local Length 			= string.len(AttackName)
		if (Length > 0 and self:IsAutoAttack(AttackName) == true) or Elapsed > (self:GetWindup()*1.25) then
			self.WindingUp		= 0
		end
		return
	end
	
	if self:CanMove() == true then
		if self.Attack == 1 then
			self.ResetReady = 1
		end
		self:IssueMove(self.MovePosition)

		if self:CanAttack() == true and self.BlockAA == false then
			if Target ~= nil then
				if self.DebugEnabled.Value == 1 then

					print(" ")
					print(" ")
					print("Target: " .. Target.Name)
					print("Health: " .. Target.Health)
					print("IsHero: " .. tostring(Target.IsHero))
					print("IsMinion: " .. tostring(Target.IsMinion))
					local outVec 		= Vector3.new()
					local HeroPos 		= Target.Position		
					print("Target OnScreen: " .. tostring(Render:World2Screen(HeroPos, outVec)))
					print("Target ScreenPos.x: " .. outVec.x)
					print("Target ScreenPos.y: " .. outVec.y)

					if self.DebugOnlyMove.Value == 1 then
						self:Orbwalk(nil)
					end
				end

				self:IssueAttack(Target.Position, Target.IsHero)
				return
			end
		end	
		self.PrevTarget = nil
	end
end

function Orbwalker:Disable()
	self.Enabled = 0
end

function Orbwalker:Enable()
	self.Enabled = 1
end

function Orbwalker:OnTick()
	--print(myHero.AttackSpeedMod)
	self:GetForceTarget()
	if GameHud.Minimized == false and GameHud.ChatOpen == false and self.Enabled == 1 then
		for i,Hero in pairs(ObjectManager.HeroList) do 
			if Hero.Team ~= myHero.Team and string.len(Hero.ChampionName) > 1 then
				if self.Prio[Hero.Index] == nil then
					local Name = Hero.ChampionName
					self.Prio[Hero.Index] = self.OrbTargetSelector:AddSlider(Name, 1,1,5,1)
				end
			end
		end
        self.DrawTarget 		= nil
		self.OrbRange 			= myHero.AttackRange + myHero.CharData.BoundingRadius
        if Engine:IsKeyDown("HK_COMBO") then
            local Target = self:GetTarget("Combo", self.OrbRange)
            return self:Orbwalk(Target)
        end
        if Engine:IsKeyDown("HK_HARASS") then
            local Target = self:GetTarget("Harass", self.OrbRange)
            return self:Orbwalk(Target)
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            local Target = self:GetTarget("Laneclear", self.OrbRange)
            return self:Orbwalk(Target)
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            local Target = self:GetTarget("Lasthit", self.OrbRange)
            return self:Orbwalk(Target)
        end
	end
end

function Orbwalker:OnDraw()
	--[[local MissileFilter = {}
	local Missiles = ObjectManager.MissileList
	for I,Object in pairs(ObjectManager.MissileList) do
		local Index 	= Object.Index
		local Name		= Object.Name
		if Index > 0 and string.len(Name) > 0 and MissileFilter[Index] == nil then
			MissileFilter[Index] = Object
		end
	end

	for I,Missile in pairs(MissileFilter) do
		local SourceID				= Missile.SourceIndex
		local TargetID				= Missile.TargetIndex
		local MissileSource			= nil
		local MissileTarget			= nil
		if SourceID > 0 and SourceID < 10000 then
			MissileSource 			= ObjectManager:GetObjectByID(SourceID)
		end
		if TargetID > 0 and TargetID < 10000 then
			MissileTarget 			= ObjectManager:GetObjectByID(TargetID)
		end
		if I == Missile.Index and MissileTarget and MissileSource and MissileSource.IsMinion and MissileSource.IsDead == false and MissileSource.AttackRange > 300 then
			print("I: ", I, "|", " Index: ", Missile.Index,"|", " Name: ", Missile.Name,"|", "SourceID: ", SourceID,"|", "SourceName: ", MissileSource.Name,"|", "TargetID: ", TargetID,"|", "TargetName: ", MissileTarget.Name)
		end	
	end
		print("_____________________")]]
	
		--local Direction = myHero.Direction
	--print(Direction.x, Direction.y, Direction.z)

    if self.DrawTarget ~= nil then 
        Render:DrawCircle(self.DrawTarget.Position, self.DrawTarget.CharData.BoundingRadius, 0,255,0,255)
    end
    if self.ForceTarget ~= nil then 
        Render:DrawCircle(self.ForceTarget.Position, self.ForceTarget.CharData.BoundingRadius, 255,255,100,255)
    end
	if self.MyRange.Value == 1 then
		Render:DrawCircle(myHero.Position, myHero.CharData.BoundingRadius + myHero.AttackRange, 255,255,255,255)
	end
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
end

function Orbwalker:OnLoad()
	AddEvent("OnSettingsSave" , function() Orbwalker:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Orbwalker:LoadSettings() end)

	Orbwalker:__init()
	AddEvent("OnTick", function() Orbwalker:OnTick() end)
	AddEvent("OnDraw", function() Orbwalker:OnDraw() end)
end

AddEvent("OnLoad", function() Orbwalker:OnLoad() end)