require("SupportLib")

Lulu = {
	SelectedAlly = {team},
}

local Yup		  = 1
local Nah    	  = 2
local SpellImmune = 3

function Lulu:__init()
	self.QRange = 950
	self.WRange = 650
	self.ERange = 650
	self.RRange = 900
	self.RRangeKnockup = 400

	self.QSpeed = 1450
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QWidth = 120

	self.QDelay = 0.15 -- 0.25
	self.WDelayAlly = 0
	self.WDelayEnemy = 0.15 -- 0.2419
	self.EDelay = 0
	self.RDelay = 0

	self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Lulu")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Q Settings")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
	self.ComboUseEQ		= self.ComboMenu:AddCheckbox("Extend Q with E", 1)
	self.EQHPSlider		= self.ComboMenu:AddSlider("Extend only people below %HP", 20, 0, 100, 1)
	-------------------------------------------
	self.WSettings		= self.ChampionMenu:AddSubMenu("W Settings")
	self.UseWDeEnchant	= self.WSettings:AddCheckbox("Use W on dangerous spells", 1)
	-------------------------------------------
	self.ESettings		= self.ChampionMenu:AddSubMenu("E Settings")
	self.UseEShield		= self.ESettings:AddCheckbox("Auto Shield", 1)
	self.UseEEnchant	= self.ESettings:AddCheckbox("Use E to refresh moonstone buff", 1)
	-------------------------------------------
	self.AntiGapCloserMenu		= self.ChampionMenu:AddSubMenu("AntiGapCloser Settings")
	self.UseWGapclose			= self.AntiGapCloserMenu:AddCheckbox("Use W on Gapclose", 1)
	self.UseRGapclose			= self.AntiGapCloserMenu:AddCheckbox("Use R on Gapclose", 1)
	self.UseRGapcloseFlee		= self.AntiGapCloserMenu:AddCheckbox("Use R on Flee dash", 1)
	self.TargetSelector         = self.AntiGapCloserMenu:AddSubMenu("Only on:")
	-------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("Draw Q", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("Draw W", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("Draw E", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("Draw R", 1)
	self.DrawPix 		= self.DrawMenu:AddCheckbox("Draw Pix", 1)

	Lulu:LoadSettings()
end

function Lulu:SaveSettings()
	SettingsManager:CreateSettings("Lulu")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseEQ", self.ComboUseEQ.Value)
	SettingsManager:AddSettingsInt("EQHPSlider", self.EQHPSlider.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("WSettings")
	SettingsManager:AddSettingsInt("UseWDeEnchant", self.UseWDeEnchant.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("ESettings")
	SettingsManager:AddSettingsInt("UseEEnchant", self.UseEEnchant.Value)
	SettingsManager:AddSettingsInt("UseEShield", self.UseEShield.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("GapCloseSettings")
	SettingsManager:AddSettingsInt("UseWGapclose", self.UseWGapclose.Value)
	SettingsManager:AddSettingsInt("UseRGapclose", self.UseRGapclose.Value)
	SettingsManager:AddSettingsInt("UseRGapcloseFlee", self.UseRGapcloseFlee.Value)

	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
	SettingsManager:AddSettingsInt("DrawPix", self.DrawPix.Value)

end

function Lulu:LoadSettings()
	SettingsManager:GetSettingsFile("Lulu")
	self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseEQ.Value 		= SettingsManager:GetSettingsInt("Combo","UseEQ")
	self.EQHPSlider.Value 		= SettingsManager:GetSettingsInt("Combo","EQHPSlider")
	-------------------------------------------------------------
	self.UseWDeEnchant.Value	= SettingsManager:GetSettingsInt("WSettings","UseWDeEnchant")
	-------------------------------------------------------------
	self.UseEShield.Value 		= SettingsManager:GetSettingsInt("ESettings","UseEShield")
	self.UseEEnchant.Value		= SettingsManager:GetSettingsInt("ESettings","UseEEnchant")
	-------------------------------------------------------------
	self.UseWGapclose.Value		= SettingsManager:GetSettingsInt("GapCloseSettings","UseWGapclose")
	self.UseRGapclose.Value		= SettingsManager:GetSettingsInt("GapCloseSettings","UseRGapclose")
	self.UseRGapcloseFlee.Value	= SettingsManager:GetSettingsInt("GapCloseSettings","UseRGapcloseFlee")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
	self.DrawPix.Value = SettingsManager:GetSettingsInt("Drawings","DrawPix")
end

function Lulu:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Lulu:GetPixi()
	local MinionList = ObjectManager.MinionList
	for I,Minion in pairs(MinionList) do	
		if Minion.Team == myHero.Team then
			if Minion.Name == "RobotBuddy" and Minion.IsVisible then
				return Minion
			end
		end
	end
	return nil
end

function Lulu:GetEDamage(Target)
	local ELevel		   = myHero:GetSpellSlot(2).Level
	local RawDamage  	   = 40 + 40 * ELevel + myHero.AbilityPower * 0.4
	local FinalMagicResist = (Target.MagicResist * myHero.MagicPenMod) - myHero.MagicPenFlat

	if FinalMagicResist <= 0 then
        FinalMagicResist = 0
    end

	return (100 / (100 + FinalMagicResist)) * RawDamage
end

function Lulu:GetAlliesInRange(Position, Range)
    local Allies = {} 
	local AllyList = ObjectManager.HeroList
    for _,Hero in pairs(AllyList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
            if Orbwalker:GetDistance(Hero.Position , Position) < Range then
                Allies[#Allies + 1] = Hero			
            end
        end
    end
    return Allies
end

function Lulu:GetMinionsForExtendedQ()
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.IsTargetable and not Minion.IsDead then
			if Minion.Team ~= Minion.Team then
				if self:GetEDamage(Minion) < Minion.Health then
					if Lulu:GetDistance(myHero.Position , Minion.Position) < self.ERange then
						return Minion
					end
				end
			end
			if Minion.Team == Minion.Team then
				if Lulu:GetDistance(myHero.Position , Minion.Position) < self.ERange then
					return Minion
				end
			end
		end
    end
    return false
end

local LastPredWasFlee
function Lulu:IsFleeingAway(target)
	local PredPos = Prediction:GetPredictionPosition(target, target.AIData.TargetPos, target.MovementSpeed, 1, 0, 0, 0, 0.001, 1)

	if PredPos and self:GetDistance(PredPos, myHero.Position) > self:GetDistance(target.Position, myHero.Position) then
       	LastPredWasFlee = true
    end

	if PredPos and self:GetDistance(PredPos, myHero.Position) < self:GetDistance(target.Position, myHero.Position) then
		LastPredWasFlee = false
	end

	return LastPredWasFlee
end


function Lulu:Q()
	local target = Orbwalker:GetTarget("Combo", 1750) -- should be enough for extended Q
	if target then
		if Engine:SpellReady("HK_SPELL3") and self.ComboUseEQ.Value == 1 then
			if target.Health <= target.MaxHealth / 100 * self.EQHPSlider.Value and self:IsFleeingAway(target) == true then
				if self:GetDistance(myHero.Position, target.Position) > self.QRange and self:GetDistance(self:GetPixi().Position, target.Position) > self.QRange then
					local Allies = Lulu:GetAlliesInRange(myHero.Position, self.ERange)
					if #Allies > 0 then
						for _, ally in pairs(Allies) do
							if ally.Index ~= myHero.Index then
								if self:GetDistance(ally.Position, target.Position) < self.QRange then
									PredCastPosFromAlly = Prediction:GetCastPos(ally.Position, self.QRange - 100, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1) -- Minus 100 because we are still casting from pix pos not exactly from inside ally
									if PredCastPosFromAlly ~= nil then
										Engine:CastSpell("HK_SPELL3", ally.Position, 0)
										Engine:CastSpell("HK_SPELL1", PredCastPosFromAlly, 0)
									end
								end
							end
						end 
					end 
					local minion = Lulu:GetMinionsForExtendedQ()
					if minion then
						if self:GetDistance(minion.Position, target.Position) < self.QRange then
							PredCastPosFromMinion = Prediction:GetCastPos(minion.Position, self.QRange - 100, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
							if PredCastPosFromMinion ~= nil then
								Engine:CastSpell("HK_SPELL3", minion.Position, 0)
								Engine:CastSpell("HK_SPELL1", PredCastPosFromMinion, 0)
							end
						end
					end
				end
			end 
		end

		if self:GetDistance(myHero.Position, target.Position) > self:GetDistance(self:GetPixi().Position, target.Position) then
			CastPos = Prediction:GetCastPos(self:GetPixi().Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
		else
			CastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1) 
		end
		if CastPos ~= nil then
			Engine:CastSpell("HK_SPELL1", CastPos, 0)
		end
	end
end


	--[[
heim: r
irelia: w??
morgana: r (disable if E active)
quinn: r
rammus: e
ryze: r?
swain: r?
sylas: should work without doing anything
tf: r?
twitch: r?
vlad: w
wu: r??
yasuo: check if Q2 is in air or teammate is in air in R range??
yone: e?
yuumi; if possible always

	]]

function Lulu:TargetHasSpellShield()

	local SpellShields =
	{
		"bansheesveil",
		"itemmagekillerveil", -- Edge of Night
		"FioraW",
		"NocturneShroudofDarkness", -- Nocturne W
		"malzaharpassiveshield", -- Malzahar P
		"SivirE",
	}

	for I, Enemy in pairs(ObjectManager.HeroList) do
		if Enemy.Team ~= myHero.Team and not Enemy.IsDead and Enemy.IsTargetable then
			if self:GetDistance(myHero.Position, Enemy.Position) < self.WRange then
				if Enemy.BuffData:GetBuff("SamiraW").Valid then
					return SpellImmune
				end

				if Enemy.BuffData:GetBuff("MorganaE").Valid then
					if self:GetEDamage(Enemy) > Enemy.MagicalShield then
						return Yup
					end
					return SpellImmune
				end

				for I, Buff in pairs(SpellShields) do
					if Enemy.BuffData:GetBuff(Buff).Valid then
						return Yup
					end
				end
			end	
		end
	end
	return Nah
end	

function Lulu:W()

	local InterruptSpells = 
	{
		"AkshanR",
		"ZacE",
		"XerathArcanopulseChargeUp", -- Xerath Q
		"XerathLocusOfPower2", -- Xerath R
		"ViegoW",
		"ViQ",
		"VelkozR",
		"SkarnerImpale", -- Skarner R, Faster than GetBuff, works shorter
		"SionQ",
		"ShenR",
		"PykeQ",
		"PoppyR",
		"PantheonR",
		"OrnnR",
		"NunuR",
		"NunuW",
		"KatarinaR",
		"KarthusFallenOne", -- Karthus R
		"JhinR",
		"ReapTheWhirlwind", -- Janna R
		"CaitlynR",
		"FiddleSticksW",
		"FiddleSticksR",
		"Meditate", -- Master Yi W
		"MissFortuneBulletTime", -- Miss Fortune R
		"MalzaharR",
		"GalioW",
		"GalioR",
		"IllaoiR",
		"TahmKenchW",
		"WarwickRChannel", -- Warwick R Suppression
		"WarwickR", -- Warwick R Dash
		"KennenShurikenStorm", -- Kennen R, Faster then GetBuff, works shorter
	}
	local InterruptBuffs = 
	{
		"RakanR",
		"NeekoR",
		"GlacialStorm", -- Anivia R
		"aurelionsolelinearflight", -- Aurelion Sol E
		"BelvethE",
		"skarnerimpalevo", -- Skarner R
		"skarnerimpalebuff", -- Skarner R
		"skarnerpassivecrystalmsmax", -- Skarner R
		"KennenShurikenStorm", -- Kennen R
		"vexr2timer", -- Vex R, Recast / Dash
		"ZedR2", -- Zed R, "he is able to recast", maybe check if ally has death mark?
		"camilleqprimingcomplete", -- Camille Q, True damage attack ready
		"NilahW",
		"tahmkenchroutline", -- Tahm Kench R
		"varusqwithwmaterial", -- Varus Q with W buff
		"VarusQ",
		"taliyahrsurfing", -- Taliyah R Dash
		"SamiraR", -- Samira R Activated
	}

	--print ("")
	--myHero.BuffData:ShowAllBuffs()
	--print (myHero.ActiveSpell.Info.Name)

	for I, Enemy in pairs(ObjectManager.HeroList) do
		if Enemy.Team ~= myHero.Team and not Enemy.IsDead and Enemy.IsTargetable then
			if self:GetDistance(myHero.Position, Enemy.Position) < self.WRange then
				if Lulu:TargetHasSpellShield() ~= SpellImmune then
					if string.len(Enemy.ActiveSpell.Info.Name) ~= 0 then
						for I, Spell in pairs(InterruptSpells) do
							if Enemy.ActiveSpell.Info.Name == Spell then
								--print("ActiveSpell")
								if Lulu:TargetHasSpellShield() == Nah then
									Engine:CastSpell("HK_SPELL2", Enemy.Position, 1)
								end
								if Lulu:TargetHasSpellShield() == Yup then
									if Engine:SpellReady("HK_SPELL3") then
										Engine:CastSpell("HK_SPELL3", Enemy.Position, 1)
										Engine:CastSpell("HK_SPELL2", Enemy.Position, 1)
									end
								end
							end
						end
					end
					for I, Buff in pairs(InterruptBuffs) do
						if Enemy.BuffData:GetBuff(Buff).Valid then
							--print("GetBuff")
							if Lulu:TargetHasSpellShield() == Nah then
								Engine:CastSpell("HK_SPELL2", Enemy.Position, 1)
							end
							if Lulu:TargetHasSpellShield() == Yup then
								if Engine:SpellReady("HK_SPELL3") then
									Engine:CastSpell("HK_SPELL3", Enemy.Position, 1)
									Engine:CastSpell("HK_SPELL2", Enemy.Position, 1)
								end
							end
						end
					end
				end	
			end
		end
	end
end

function Lulu:WillCollideWithHero(Start, End, MissileWidth, Hero)
	local Distance1 = Prediction:GetDistance(Start, End)
	local Distance2 = Prediction:GetDistance(Start, Hero.Position)
	if Distance1 > Distance2 then
		if Prediction:PointOnLineSegment(Start, End, Hero.Position, MissileWidth) == true then
			return true
		end
	end
	return nil
end

--ToDo Thresh AA
function Lulu:GetShieldTarget(Range)
    local HeroList 		= ObjectManager.HeroList
	local MissileList 	= ObjectManager.MissileList
	local Turrets 		= ObjectManager.TurretList

	--Ranged AA and TowerShots
	for I, Missile in pairs(MissileList) do
		local SourceIndex = Missile.SourceIndex
		local TargetIndex = Missile.TargetIndex
		local Ally 		  = HeroList[TargetIndex]  

		local Source = HeroList[SourceIndex]
		if Source == nil then Source = Turrets[SourceIndex] end

		if Source and Source.Team ~= myHero.Team then
			if Ally and Ally.Team == myHero.Team and Ally.IsTargetable and not Ally.IsDead then
           		if Lulu:GetDistance(Ally.Position, myHero.Position) < Range then
                   	return Ally
				end
			end
		end
	end
	--Melee
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.AttackRange < 350 then -- only lethaltempo rakan or lilia will break it
			if Hero.ActiveSpell.IsAutoAttack then
				local GetEnemyAARange = Hero.AttackRange + Hero.CharData.BoundingRadius
				local Modifier  = GetEnemyAARange + 55 -- no need to *2
				if Orbwalker:GetDistance(myHero.Position, Hero.Position) < Range + GetEnemyAARange then -- Checking if he can do AA in our skillrange (we need he AA range cuz ally can be closer to us than he is)
					local Allies = Lulu:GetAlliesInRange(Hero.Position, Modifier) --Extra after bounding radius for ally to walk away from range
					-- Now we have person that can make AA inside our Range and people that this person can AA inside his Range
					if #Allies > 0 then
						for _, Ally in pairs(Allies) do
							local EnemyPos = Hero.Position
							local MaxDirection = Vector3.new(EnemyPos.x + (Hero.Direction.x*Modifier),EnemyPos.y ,EnemyPos.z + (Hero.Direction.z*Modifier))
							local AllyAtMelee = self:WillCollideWithHero(EnemyPos, MaxDirection, 20, Ally)
							if AllyAtMelee == true then
								return Ally
							end
						end
					end
				end
			end
		end
	end
	--Skillshots (Dont work if spell is very close / melee range)
	for I, Missile in pairs(MissileList) do	
		if Missile.Team ~= myHero.Team then 
			local Info = Evade.Spells[Missile.Name]
			if Evade and Info then
				local Allies = Lulu:GetAlliesInRange(myHero.Position, Range)
				if #Allies > 0 then
					for _, Ally in pairs(Allies) do
						if Prediction:PointOnLineSegment(Missile.MissileStartPos, Missile.MissileEndPos, Ally.Position, Info.Radius * 2) then -- *2 should be enough <3
							if Missile.Name ~= "ZileanQMissile" then
								return Ally
							end
							if Missile.Name == "ZileanQMissile" and Ally.BuffData:GetBuff("ZileanQEnemyBomb").Valid then
								return Ally
							end
						end
					end
				end
			end
		end
	end
	-- Buffs
	for I,Ally in pairs(HeroList) do
		if Ally and Ally.Team == myHero.Team and Ally.IsTargetable and not Ally.IsDead then
			if Lulu:GetDistance(Ally.Position, myHero.Position) < Range then
				local ZileanQ = Ally.BuffData:GetBuff("ZileanQEnemyBomb")

				if ZileanQ.Valid and ZileanQ.EndTime - GameClock.Time < 2.4 then -- 2.5s Zilean Q
					return Ally
				end
			end
		end
	end
	--[[
	--Senna test -- works flawless unless minion is in front or behind you, you will always shield yourself no matter who is target
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team then
			local AAName = Hero.ActiveSpell.Info.Name
			if Hero.ActiveSpell.IsAutoAttack and (AAName == "SennaBasicAttack" or AAName == "SennaBasicAttack2" or AAName == "SennaBasicAttack3" or AAName == "SennaBasicAttackSouls") then
				local GetEnemyAARange = Hero.AttackRange + Hero.CharData.BoundingRadius
				local Modifier  = GetEnemyAARange + 55 -- no need to *2
				if Orbwalker:GetDistance(myHero.Position, Hero.Position) < Range + GetEnemyAARange then -- Checking if he can do AA in our skillrange (we need he AA range cuz ally can be closer to us than he is)
					local Allies = Lulu:GetAlliesInRange(Hero.Position, Modifier) --Extra after bounding radius for ally to walk away from range
					-- Now we have person that can make AA inside our Range and people that this person can AA inside his Range
					if #Allies > 0 then
						for _, Ally in pairs(Allies) do
							local EnemyPos = Hero.Position
							local MaxDirection = Vector3.new(EnemyPos.x + (Hero.Direction.x*Modifier),EnemyPos.y ,EnemyPos.z + (Hero.Direction.z*Modifier))
							local AllyAtMelee = self:WillCollideWithHero(EnemyPos, MaxDirection, 20, Ally)
							if AllyAtMelee == true then
								return Ally
							end
						end
					end
				end
			end
		end
	end
	]]
	return nil
end

function Lulu:AutoShield()
	local AllyE = Lulu:GetShieldTarget(self.ERange)
	local AllyR = Lulu:GetShieldTarget(self.RRange)

	if Engine:SpellReady("HK_SPELL3") and AllyE ~= nil and not Engine:IsKeyDown("HK_HARASS") then
		return Engine:CastSpell("HK_SPELL3", AllyE.Position, 1)
	end
	if Engine:SpellReady("HK_SPELL4") and AllyR ~= nil and (not Engine:SpellReady("HK_SPELL3") or self:GetDistance(myHero.Position, AllyR.Position) > self.ERange) then
		if AllyR.Health <= AllyR.MaxHealth / 100 * 7.5 then -- ToDo: Calculate incoming damage, get lethal damage and use R instead this.
			return Engine:CastSpell("HK_SPELL4", AllyR.Position, 1)
		end
	end
	return nil
end

function Lulu:WhimsySentTo(Target)
	local Missiles = ObjectManager.MissileList
	for _, Object in pairs(Missiles) do
		if Object.Team == myHero.Team and _ == Object.Index and string.find(Object.Name, "LuluWTwo") ~= nil then
			if Object.TargetIndex == Target.Index then
				return true
			end
		end
	end
	return false
end

--ToDo; Filter out dashes like Yasuo E, Aatrox E etc and make priority to R to dashes like panth W
function Lulu:AntiGapCloser()
	local HeroList = ObjectManager.HeroList
	for k, Ally in pairs(HeroList) do
		if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
			if self.SelectedAlly[Ally.Index].Value == 1 then
				for I, Enemy in pairs(HeroList) do
					if Enemy.Team ~= myHero.Team and not Enemy.IsDead and Enemy.IsTargetable then
						if Enemy.AIData.Dashing == true and Prediction:IsImmobile(Enemy) == nil then -- test

							local CurrentDistance = self:GetDistance(Enemy.Position, Ally.Position)
							local AfterDashDistance = self:GetDistance(Enemy.AIData.TargetPos, Ally.Position)

							if self.UseWGapclose.Value == 1 and Engine:SpellReady("HK_SPELL2") then
								if CurrentDistance < self.WRange then
									Engine:CastSpell("HK_SPELL2", Enemy.Position, 1)
								end
							end

							if (self.UseRGapclose.Value == 1 and Engine:SpellReady("HK_SPELL4")) and (self.UseWGapclose.Value == 0 or not Engine:SpellReady("HK_SPELL2")) then									
								if myHero.ActiveSpell.Info.Name ~= "LuluWTwo" and not Enemy.BuffData:GetBuff("LuluWTwo").Valid and self:WhimsySentTo(Enemy) == false then
									if CurrentDistance < self.RRangeKnockup and ((AfterDashDistance < CurrentDistance) or (self.UseRGapcloseFlee.Value == 1 and AfterDashDistance >= CurrentDistance and CurrentDistance < 350)) then -- 400 was failing on fast dashes, 350 for test
										Engine:CastSpell("HK_SPELL4", Ally.Position, 1)
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

function Lulu:AAReset()
    local WindUp = (os.clock() - Orbwalker.WindupTimer)
    local LastWindup = Orbwalker.LastWindup

    if WindUp > LastWindup - 0.1 and WindUp < LastWindup then
        return true
    end
    return false
end

function Lulu:Harass()
	local target = Orbwalker:GetTarget("Combo", self.QRange)
	if target then
		if self.AAReset() == true and Engine:SpellReady("HK_SPELL3") then
			Engine:CastSpell("HK_SPELL3", target.Position, 1)
			if Engine:SpellReady("HK_SPELL1") then
				local CastPos = Prediction:GetCastPos(self:GetPixi().Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
				if CastPos then
					Engine:CastSpell("HK_SPELL1", CastPos, 0)
				end
			end
		end
	end
end

function Lulu:KeepMoonstoneStacks()
	for k, Ally in pairs(ObjectManager.HeroList) do
		if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
			if self:GetDistance(myHero.Position, Ally.Position) < self.ERange then
				local Moonstone = myHero.BuffData:GetBuff("6617stackcounter")
				if Moonstone.Valid and Moonstone.EndTime - GameClock.Time < 0.20 then
					if string.len(Ally.ActiveSpell.Info.Name) > 0 or Ally.ActiveSpell.IsAutoAttack == true then -- Maybe copy and paste nami E function here?
						Engine:CastSpell("HK_SPELL3", Ally.Position, 1)
					end
				end
			end
		end
	end
end

function Lulu:OnTick()
	local Allies = SupportLib:GetAllAllies()
	for _, Ally in pairs(Allies) do
		if string.len(Ally.ChampionName) > 1 and self.SelectedAlly[Ally.Index] == nil then
			self.SelectedAlly[Ally.Index] = self.TargetSelector:AddCheckbox(Ally.ChampionName, 1)
		end
	end

	if GameHud.Minimized == false and GameHud.ChatOpen == false then

		if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Engine:IsKeyDown("HK_COMBO") then
			self:Q()
		end

		if self.UseWDeEnchant.Value == 1 and Engine:SpellReady("HK_SPELL2") then
			self:W()
		end

		if (self.UseRGapclose.Value == 1 and Engine:SpellReady("HK_SPELL4")) or (self.UseWGapclose.Value == 1 and Engine:SpellReady("HK_SPELL2")) then
			self:AntiGapCloser() 
		end

		if Engine:IsKeyDown("HK_HARASS") then
			self:Harass()
		end

		if self.UseEEnchant.Value == 1 and Engine:SpellReady("HK_SPELL3") then
			self:KeepMoonstoneStacks()
		end
		
		if self.UseEShield.Value == 1 then
			self:AutoShield()
		end
	end
end

function Lulu:OnDraw()
	if myHero.IsDead then return end
	local Pixi = Lulu:GetPixi()
	
	if Pixi and self.DrawPix.Value == 1 then
		Render:DrawCircle(Pixi.Position, 25 ,255,100,255,255)
	end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		if Pixi then
			Render:DrawCircle(Pixi.Position, self.QRange ,100,150,255,255)
		end
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Lulu:OnLoad()
    if(myHero.ChampionName ~= "Lulu") then return end
	AddEvent("OnSettingsSave" , function() Lulu:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Lulu:LoadSettings() end)


	Lulu:__init()
	AddEvent("OnTick", function() Lulu:OnTick() end)	
	AddEvent("OnDraw", function() Lulu:OnDraw() end)	
end

AddEvent("OnLoad", function() Lulu:OnLoad() end)