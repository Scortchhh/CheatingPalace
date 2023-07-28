Jinx = {}

local RocketLauncher = 1
local MiniGun 		 = 2

function Jinx:__init()
	if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end

	self.WRange = 1440
	self.ERange = 925

	self.WSpeed = 3300
	self.ESpeed = math.huge

	self.QDelay = 0.4 -- time we have to wait until we can AA after switching
	self.EDelay = 0.9
	self.RDelay = 0.5 -- 0.6

	self.WWidth = 120
	self.EWidth = 150
	self.RWidth = 280

	self.WHitChance = 0.2
	self.EHitChance = 0.2
	self.RHitChance = 0.2
	
    self.ChampionMenu = Menu:CreateMenu("Jinx")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ in combo", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW in combo", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE in combo", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR in combo", 1)
	self.RRange	   = self.ComboMenu:AddSlider("Range for R use", 5000, 2000, 25000, 1000)


	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ in harass", 1)
    self.HarassUseW = self.HarassMenu:AddCheckbox("UseW in harass", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE in harass", 1)

	
	self.AutoRMenu 		= self.ChampionMenu:AddSubMenu("Auto R")
    self.BaseUseR  		= self.AutoRMenu:AddCheckbox("Baseult", 0)
	self.RecallR   		= self.AutoRMenu:AddCheckbox("Recall R", 0)
	self.HideTimeSlider	= self.AutoRMenu:AddSlider("Ignore invisible after X seconds", 10, 8, 15, 1)

	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("Draw Q", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("Draw W", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("Draw E", 1)
	self.DrawR = self.ComboMenu:AddCheckbox("Draw R combo range", 1)
	self.DrawRAlert = self.ComboMenu:AddCheckbox("Draw R Alert", 1)
	self.DrawRAlert_X		= self.ComboMenu:AddSlider("X for R alerter", 0,0,4000,1)
	self.DrawRAlert_Y		= self.ComboMenu:AddSlider("Y for R alerter", 0,0,4000,1)
	
	Jinx:LoadSettings()
end

function Jinx:SaveSettings()
	SettingsManager:CreateSettings("Jinx")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ in combo", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW in combo", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE in combo", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR in combo", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("RSlider", self.RRange.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQ in harass", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseW in harass", self.HarassUseW.Value)
	SettingsManager:AddSettingsInt("UseE in harass", self.HarassUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Auto R")
	SettingsManager:AddSettingsInt("Baseult", self.BaseUseR.Value)
	SettingsManager:AddSettingsInt("Recall R", self.RecallR.Value)
	SettingsManager:AddSettingsInt("HideTimeSlider", self.HideTimeSlider.Value)

	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
	SettingsManager:AddSettingsInt("Draw R Alert", self.DrawRAlert.Value)
	SettingsManager:AddSettingsInt("DrawRAlert_X", self.DrawRAlert_X.Value)
	SettingsManager:AddSettingsInt("DrawRAlert_Y", self.DrawRAlert_Y.Value)

end

function Jinx:LoadSettings()
	SettingsManager:GetSettingsFile("Jinx")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ in combo")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW in combo")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE in combo")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR in combo")
	self.RRange.Value 	 = SettingsManager:GetSettingsInt("Combo","RSlider")
	-------------------------------------------------------------
	self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQ in harass")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseW in harass")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","UseE in harass")
	-------------------------------------------------------------
	self.BaseUseR.Value 	  = SettingsManager:GetSettingsInt("Auto R","Baseult")
	self.RecallR.Value 		  = SettingsManager:GetSettingsInt("Auto R","Recall R")
	self.HideTimeSlider.Value = SettingsManager:GetSettingsInt("Auto R","HideTimeSlider")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
	self.DrawRAlert.Value = SettingsManager:GetSettingsInt("Drawings","Draw R Alert")
	self.DrawRAlert_X.Value = SettingsManager:GetSettingsInt("Drawings","DrawRAlert_X")
	self.DrawRAlert_Y.Value = SettingsManager:GetSettingsInt("Drawings","DrawRAlert_Y")

end

function Jinx:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Jinx:getAttackRange(Gun)
	local JinxQ = myHero.BuffData:GetBuff("JinxQ").Valid
    local AARange = Orbwalker.OrbRange
	local QBonusRange = 50 + 30 * myHero:GetSpellSlot(0).Level

	-- Your Current AA Range
	if Gun == nil then
    	return AARange
	end

	-- AA Range with RocketLauncher
	if Gun == 1 and JinxQ == false then
		return AARange + QBonusRange
	elseif Gun == 1 and JinxQ == true then
		return AARange
	end

	-- AA Range with MiniGun
	if Gun == 2 and JinxQ == true then 
		return AARange - QBonusRange
	elseif Gun == 2 and JinxQ == false then
		return AARange
	end
end

function Jinx:GetEnemiesInRange(Position, Range)
    local Enemies = {} 
	local EnemyList = ObjectManager.HeroList
    for _,Hero in pairs(EnemyList) do
        if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
            if Orbwalker:GetDistance(Hero.Position , Position) < Range then
                Enemies[#Enemies + 1] = Hero			
            end
        end
    end
    return Enemies
end

function Jinx:MinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do    
        if Minion.Team ~= myHero.Team and Minion.IsTargetable then
            if self:GetDist(Minion.Position , Position) <= Range and Minion.MaxHealth > 8 then --Check MaxHealth because plants count as minion ;)
                Count = Count + 1
            end
        end
    end
    return Count
end

function Jinx:MovementOnCD(Target, Time)
    local Spell = Prediction.DashSpell[Target.ChampionName]
    --We check that enemy spell is not available inside given Time variable. If it is function will return false
    local qCdr = Target:GetSpellSlot(0).Cooldown - GameClock.Time < Time
    local wCdr = Target:GetSpellSlot(1).Cooldown - GameClock.Time < Time
    local eCdr = Target:GetSpellSlot(2).Cooldown - GameClock.Time < Time
    local rCdr = Target:GetSpellSlot(3).Cooldown - GameClock.Time < Time
	--if enemy has 0 skillpoints we return true (true = spellcd < time)
	if Target:GetSpellSlot(0).Level == 0 then qCdr = true end
	if Target:GetSpellSlot(1).Level == 0 then wCdr = true end
	if Target:GetSpellSlot(2).Level == 0 then eCdr = true end
	if Target:GetSpellSlot(3).Level == 0 then rCdr = true end
    --We check that enemy spell is not just giving movement speed bonus (it is dash/blink ect)
    if Spell then
		local QNotMS = Spell.QType ~= "MS"
		local WNotMS = Spell.WType ~= "MS"
		local ENotMS = Spell.EType ~= "MS"
		local RNotMS = Spell.EType ~= "MS"

        if (Spell.Q and QNotMS and qCdr) or (Spell.W and WNotMS and wCdr) or (Spell.E and ENotMS and eCdr)  or (Spell.R and RNotMS and rCdr) then
            return false
        end
    end
   return true
end

local function GetHeroLevel(Target)
    return Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
end

function Jinx:GetRSpeed(Distance)
	local Time1		 =  1350 / 1700
	local Time2 	 = (Distance - 1350) / 2200
	local TravelTime = Time1
	if Distance > 1350 then
		TravelTime = Time1 + Time2
	end
	return TravelTime + self.RDelay
end

function Jinx:GetRDamage(Target, Time, Distance, DontDraw)
	--Champions: add garen, pyke and evelynn somehow, maybe somebody else?
	--Runes: Bone Plating, Nullifing orb, Guardian
	--Items: Warmog, Crown, Shieldbow

	local MissingHealth = Target.MaxHealth - Target.Health
	local DistDMGMod = 15
	if Distance < 1500 then
		DistDMGMod = Distance / 100
	end
	if Target.IsVisible == false then
		Time = Time + Awareness:GetMapTimer(Target)
	end

	if Target.ChampionName == "Blitzcrank" then
		local BlitzPassiveCD = Target.BuffData:GetBuff("manabarriercooldown")
		if not BlitzPassiveCD.Valid or (BlitzPassiveCD.Valid and BlitzPassiveCD.EndTime - GameClock.Time < Time) then
			local ManaBarrier = Target.MaxMana * (0.15 + 0.30 / 17 * (GetHeroLevel(Target) - 1))
			local MissingHealth = Target.MaxHealth + ManaBarrier - Target.Health
		end
	end
	if Target.ChampionName == "Yasuo" then
		if Target.BuffData:GetBuff("yasuopassivecounter").Count_Int == 100 then
			local Shield = {100,105,110,115,120,130,140,150,160,170,180,200,220,250,290,350,410,475}
			MissingHealth = Target.MaxHealth + Shield[GetHeroLevel(Target)] - Target.Health
		end
	end
	if Target.ChampionName == "Anivia" then -- ADD OPTION to use it anyway
		local AniviaRebirthCD = Target.BuffData:GetBuff("rebirthcooldown")
		if not AniviaRebirthCD.Valid or (AniviaRebirthCD.Valid and AniviaRebirthCD.EndTime - GameClock.Time < Time) then
			return 0
		end
	end
	if Target.ChampionName == "Zac" then -- ADD OPTION to use it anyway
		local ZacRebirthCD = Target.BuffData:GetBuff("zacrebirthcooldown")
		if not ZacRebirthCD.Valid or (ZacRebirthCD.Valid and ZacRebirthCD.EndTime - GameClock.Time < Time) then
			return 0
		end
	end
	if Target.ChampionName == "Malphite" then -- Passive timer is 8s -> 6s, too much hussle to calculate it, lets just add passive all time. (9% MAX HP)
		MissingHealth = Target.MaxHealth + (Target.MaxHealth * 0.09) - Target.Health 
	end

	--local buff1 = myHero.BuffData:GetBuff("garenpassiveheal")

	local HPRegen = Time * ((10 + 1 * Target.Level) / 5)
	local MissingHealthWithRegen = MissingHealth + HPRegen
	local RLevel = myHero:GetSpellSlot(3).Level

	local RawDamage = (150 + 150 * RLevel + myHero.BonusAttack * 1.5) * (0.1 + 0.06 * DistDMGMod) + MissingHealthWithRegen * (0.20 + 0.05 * RLevel)
--				      |    Base Damage    |         Bonus AD          |      Distance DMG Mod     |              MissingHP DMG Mod                |            

	-- lord dominiks buff calc needed
    local FinalArmor = (Target.Armor * myHero.ArmorPenMod) - (myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(myHero) / 18))
--					   |            Real Armor		       |                            Lethality                          |

	if Target.ChampionName == "Sejuani" then
		local SejuPassiveCD = Target.BuffData:GetBuff("sejuanipassivecd")
		if not SejuPassiveCD.Valid or (SejuPassiveCD.Valid and SejuPassiveCD.EndTime - GameClock.Time < Time) then
			local SejuBaseArmor = 28.55 + 5.45 * GetHeroLevel(Target)
			local SejuBonusArmor = Target.Armor - SejuBaseArmor
			local FinalArmor = ((Target.Armor + SejuBonusArmor) * myHero.ArmorPenMod) - (myHero.ArmorPenFlat * (0.6 + 0.4 * GetHeroLevel(myHero) / 18))
		end
	end

	if FinalArmor <= 0 then
        FinalArmor = 0
    end

	local FinalDamage = (100 / (100 + FinalArmor)) * RawDamage 

	if Target.ChampionName == "Malzahar" then -- 90% dmg reduction
		local MalzaPassiveCD = Target.BuffData:GetBuff("malzaharpassiveshieldcooldownindicator")
		if not MalzaPassiveCD.Valid or (MalzaPassiveCD.Valid and MalzaPassiveCD.EndTime - GameClock.Time < Time) then
			FinalDamage = ((100 / (100 + FinalArmor)) * RawDamage) * 0.1
		end
	end

	if DontDraw then
		return FinalDamage, Target.Health + HPRegen
	end

	if FinalDamage > Target.Health + HPRegen then
		--print(DontDraw)
		return true
	end
	return FinalDamage
end

function Jinx:CheckBaseUlt()
	local HideTime = 0

	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		local Tracker = Awareness.Tracker[Hero.Index]
		if Tracker then
			if Hero.IsVisible == false then
				HideTime = GameClock.Time - Tracker.Map.LastSeen
			end
			if HideTime < self.HideTimeSlider.Value then
				local State = Tracker.Recall.State
				local Start = Tracker.Recall.StartTime
				local End 	= Tracker.Recall.EndTime
				if State == 6 and Start < End then
					local Dist2Target  		= self:GetDistance(self.EnemyBase, myHero.Position)
					local TravelTime 		= self:GetRSpeed(Dist2Target)
					local Killable			= self:GetRDamage(Hero, TravelTime + 0.5, Dist2Target)
					local RecallTime 		= End - GameClock.Time
					local Enemies           = self:GetEnemiesInRange(myHero.Position, 1500)
					if Engine:IsKeyDown("HK_COMBO") == false and #Enemies == 0 then
						if RecallTime > 0 and Killable == true and TravelTime >= RecallTime and TravelTime < RecallTime + 0.5 then
							Engine:CastSpellMap("HK_SPELL4", self.EnemyBase, 1)
						end
					end
				end
			end
		end
	end
end

function Jinx:CheckRecallUlt()
	local HideTime = 0

	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		local Tracker = Awareness.Tracker[Hero.Index]
		if Tracker then
			if Hero.IsVisible == false then
				HideTime = GameClock.Time - Tracker.Map.LastSeen
			end
			if HideTime < self.HideTimeSlider.Value then
				local State = Tracker.Recall.State
				local Start = Tracker.Recall.StartTime
				local End 	= Tracker.Recall.EndTime
				if State == 6 and Start < End then
					local Dist2Target  	   = self:GetDistance(Tracker.Map.LastPosition, myHero.Position)
                    local TravelTime	   = self:GetRSpeed(Dist2Target)                
					local Killable	 	   = self:GetRDamage(Hero, TravelTime, Dist2Target)
					local RecallTime 	   = End - GameClock.Time
					local Enemies          = self:GetEnemiesInRange(myHero.Position, 1500)
					if Engine:IsKeyDown("HK_COMBO") == false and #Enemies == 0 then
						if RecallTime > 0 and Killable == true and TravelTime < RecallTime and TravelTime > (RecallTime - 0.5) then
							Engine:CastSpellMap("HK_SPELL4", Tracker.Map.LastPosition ,1)
						end
					end
				end
			end
		end
	end
end

function Jinx:AAReset()
    local WindUp = (os.clock() - Orbwalker.WindupTimer)
    local LastWindup = Orbwalker.LastWindup

	if WindUp > LastWindup - 0.01 and WindUp < LastWindup + 0.05 then
        return true
    end
    return false
end

function Jinx:InEnemyAARange()
	local SafeDistance = 200
	for I, Hero in pairs(ObjectManager.HeroList) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			--Render:DrawCircle(Hero.Position, Hero.AttackRange + Hero.CharData.BoundingRadius + SafeDistance,255,0,255,255)
			if self:GetDistance(myHero.Position, Hero.Position) <= Hero.AttackRange + Hero.CharData.BoundingRadius + SafeDistance then
				return true
			end
		end
	end
	return false
end

function Jinx:ChasingUs(target)
	local Time = 100 / target.MovementSpeed
	local PredPos = Prediction:GetPredictionPosition(target, myHero.Position, math.huge, Time, self.RWidth, 0, 0, 0.001, 1)

	if PredPos and self:GetDistance(PredPos, myHero.Position) > self:GetDistance(target.Position, myHero.Position) then
		return false
	end

	if PredPos and self:GetDistance(PredPos, myHero.Position) + 50 < self:GetDistance(target.Position, myHero.Position) then
		--Render:DrawCircle(PredPos, 100 ,170,170,170,170)
		return true
    end
end


function Jinx:CastQ()
	if Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", Jinx:getAttackRange(RocketLauncher))
		if Target ~= nil then 
			if Orbwalker.ResetReady or Jinx:AAReset() then
				local JinxQ 	= myHero.BuffData:GetBuff("JinxQ")
				local Distance 	= self:GetDistance(myHero.Position, Target.Position)
				local InExplosionRange = self:GetEnemiesInRange(Target.Position, 250)

				if JinxQ.Valid == false and #InExplosionRange > 1 then
					return Engine:CastSpell("HK_SPELL1", nil, 0)
				end
				if Distance > Jinx:getAttackRange(MiniGun) and JinxQ.Valid == false then
					return Engine:CastSpell("HK_SPELL1", nil, 0)
				end
				if Distance < Jinx:getAttackRange(MiniGun) and JinxQ.Valid == true then
					if #InExplosionRange <= 1 then
						return Engine:CastSpell("HK_SPELL1", nil, 0)
					end
				end
			end
		end
	end
end

-- ToDo:
-- In combo check for TargetHasNoDash, ignore in Harass
-- Check if we just AA and it will deal lethal damage (Dont W if AA will kill him)
function Jinx:CastW()
	if Engine:SpellReady("HK_SPELL2") then
		local bonusAS 	= (myHero.AttackSpeedMod - 1) * 100
		local WCastTime = 0.6 - 0.02 * math.floor(bonusAS / 25)
		if WCastTime < 0.4 then
			WCastTime = 0.4
		end
		local CastPos, WTarget = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, WCastTime-0.1, 1, 0, 0.0001, 1)
		-- Critic: Adjusted CastPos WCastTime
		if CastPos then
			local ZhonPred = Prediction:GetPredictionPosition(WTarget, myHero.Position, self.WSpeed, WCastTime + 0.1, self.WWidth, 0, 1, 0.0001, 1)
			if ZhonPred then
				local Distance			= self:GetDistance(myHero.Position, CastPos)
				local Time2Hit 			= WCastTime + 0.1 + (Distance / self.WSpeed)
				local InWRange 			= Distance <= self.WRange 
				local WOutOfAARange		= Distance >= Jinx:getAttackRange(RocketLauncher)
				local TargetHasNoDash	= self:MovementOnCD(WTarget, Time2Hit) == true
				local OutOfEnemyRange	= Jinx:InEnemyAARange() == false and Jinx:AAReset() == true
				local TargetCC			= Prediction:IsImmobile(WTarget) ~= nil and Prediction:IsImmobile(WTarget) + 0.2 > WCastTime

				if InWRange and TargetCC or (TargetHasNoDash and (WOutOfAARange or OutOfEnemyRange)) then
					Engine:ReleaseSpell("HK_SPELL2", CastPos)
				end
			end
		end
	end
end

function Jinx:CastE()
	if Engine:SpellReady("HK_SPELL3") then
		for I, Enemy in pairs(ObjectManager.HeroList) do
			if Enemy.Team ~= myHero.Team and Enemy.IsDead == false --[[and  Enemy.IsTargetable]] then
				if Enemy.AIData.Dashing and self:GetDistance(myHero.Position, Enemy.AIData.TargetPos) <= self.ERange then
					local DashTime = self:GetDistance(Enemy.Position, Enemy.AIData.TargetPos) / Enemy.AIData.DashSpeed
					--print (DashTime)
					if DashTime + 0.1 >= self.EDelay and DashTime < self.EDelay + 0.4 then
						print ("E on Dash")
						return Engine:ReleaseSpell("HK_SPELL3", Enemy.AIData.TargetPos)
					end
				end

				local TargetCC = Prediction:IsImmobile(Enemy)
				if TargetCC ~= nil and TargetCC + 0.1 >= self.EDelay and TargetCC < self.EDelay + 1 then -- adding 0.1 for CC as E width gives less time for enemy to move after CC
					print ("E on CC")
					return Engine:ReleaseSpell("HK_SPELL3", Enemy.AIData.TargetPos)
				end

				--[[if Enemy.AttackRange < 300 and not Enemy.AIData.Dashing and TargetCC == nil then
					local NearbyEnemies = self:GetEnemiesInRange(myHero.Position, 2250)
					if self:ChasingUs(Enemy) == true then--or #NearbyEnemies < 3 then -- ignore fleeing 
						--local TargetHasNoDash = self:MovementOnCD(Enemy, 1.25) == true
						local PredPos = Prediction:GetPredictionPosition(Enemy, myHero.Position, self.ESpeed, self.EDelay + 0.1, self.EWidth, 0, 1, 0.0001, 1)
						if PredPos then
							print ("3")
							if self:GetDistance(Enemy.Position, myHero.Position) <= self.ERange then
								return Engine:ReleaseSpell("HK_SPELL3", PredPos)
							end
						end
					end
				end]]
			end
		end
	end
end


function Jinx:CastR() -- ADD DONT ULT IF WE ARE CHASED -- CHECK WHAT TARGET IS DOING (DMG DIST MOD)
	if Engine:SpellReady("HK_SPELL4") then
		local AAReset = Jinx:AAReset()
		local AttackSpeed = 0.6 < (1 / Orbwalker:GetAttackSpeed())
		local Enemies = ObjectManager.HeroList
		for I, Enemy in pairs(Enemies) do
			if Enemy.Team ~= myHero.Team and Enemy.IsDead == false then
				local Dist2Target  	   = self:GetDistance(Enemy.Position, myHero.Position)
				if Enemy.AIData.Dashing then
					Dist2Target  	   = self:GetDistance(Enemy.AIData.TargetPos, myHero.Position)
				end
				local TravelTime	   = self:GetRSpeed(Dist2Target)           
				local Killable	 	   = self:GetRDamage(Enemy, TravelTime, Dist2Target)
				if Killable == true then

					local NearbyEnemies = self:GetEnemiesInRange(myHero.Position, 1250)
					if (#NearbyEnemies < 3 or (#NearbyEnemies > 2 and Jinx:InEnemyAARange() == false)) and self:ChasingUs(Enemy) == false then

						local TargetCC = Prediction:IsImmobile(Enemy)
						if Enemy.IsTargetable and TargetCC ~= nil and TargetCC + 0.15 >= TravelTime then
							local PredPos = Prediction:GetPredictionPosition(Enemy, myHero.Position, math.huge, TravelTime, self.RWidth, 0, 0, 0.0001, 1)
							if PredPos then
								return Engine:CastSpellMap("HK_SPELL4", PredPos, 1)
							end
						end

						if Enemy.IsTargetable and Enemy.AIData.Dashing then
							local DashTime = self:GetDistance(Enemy.Position, Enemy.AIData.TargetPos) / Enemy.AIData.DashSpeed
							if DashTime + 0.15 >= TravelTime then
								return Engine:CastSpellMap("HK_SPELL4", Enemy.AIData.TargetPos, 1)
							end
						end
						local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange.Value, math.huge, self.RWidth, TravelTime-0.4, 0, 0, 0.0001, 1)
						if CastPos then
							local ZhonPred = Prediction:GetPredictionPosition(Enemy, myHero.Position, math.huge, TravelTime + 0.1, self.RWidth, 0, 0, 0.0001, 1)
							if ZhonPred then
								local OutofRange = Dist2Target > self:getAttackRange(RocketLauncher) -- and not Engine:SpellReady("HK_SPELL2")
								if OutofRange or (AAReset and AttackSpeed) then 
									return Engine:CastSpellMap("HK_SPELL4", CastPos, 1)
								end
							end
						end
					end
				end
			end
		end
	end
end

function Jinx:Laneclear()
	local JinxQ = myHero.BuffData:GetBuff("JinxQ")
	if Engine:SpellReady("HK_SPELL1") then
		if JinxQ.Valid then
			return Engine:CastSpell("HK_SPELL1", nil ,1)
		end
	end
end

function Jinx:Laneclear2()
	if Orbwalker:GetAttackSpeed() >= 1.5 then
		local target = Orbwalker:GetTarget("Laneclear", 800) or Orbwalker:GetTarget("Lasthit", 800)
		local JinxQ = myHero.BuffData:GetBuff("JinxQ")
		if target then
			local count = self:MinionsInRange(target.Position, 200)
			if count >= 3 then
				if Engine:SpellReady("HK_SPELL1") then
					if not JinxQ.Valid then
						Engine:CastSpell("HK_SPELL1", nil ,1)
					end
				end
			else
				if JinxQ.Valid then
					Engine:CastSpell("HK_SPELL1", nil ,1)
				end
			end
		else
			if JinxQ.Valid then
				Engine:CastSpell("HK_SPELL1", nil ,1)
			end
		end
	else
		local JinxQ = myHero.BuffData:GetBuff("JinxQ")
		if JinxQ.Valid then
			Engine:CastSpell("HK_SPELL1", nil ,1)
		end
	end
end

function Jinx:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		--myHero.BuffData:ShowAllBuffs()

		local JinxQ = myHero.BuffData:GetBuff("JinxQ")
		if JinxQ.Valid == true then
			local qDmg = ((myHero.BaseAttack + myHero.BonusAttack) / 100 * 110) - (myHero.BaseAttack + myHero.BonusAttack)
			Orbwalker.ExtraDamage = qDmg
		else
			Orbwalker.ExtraDamage = 0
		end

		if Engine:SpellReady("HK_SPELL4") then
			if self.BaseUseR.Value == 1 then self:CheckBaseUlt() end
			if self.RecallR.Value == 1 then self:CheckRecallUlt() end
		end

		if Engine:IsKeyDown("HK_COMBO") then
			if self.ComboUseQ.Value == 1 then
				Jinx:CastQ()
			end
			if self.ComboUseW.Value == 1 then
				Jinx:CastW()
			end
			if self.ComboUseE.Value == 1 then
				Jinx:CastE()
			end
			if self.ComboUseR.Value == 1 then
				Jinx:CastR()
			end
		end

		if Engine:IsKeyDown("HK_HARASS") then
			if self.HarassUseQ.Value == 1 then
				Jinx:CastQ()
			end
			if self.HarassUseW.Value == 1 then
				Jinx:CastW()
			end
			if self.HarassUseE.Value == 1 then
				Jinx:CastE()
			end
		end
		if Engine:IsKeyDown("HK_LANECLEAR") and Orbwalker.Attack == 0 then
		--	Jinx:Laneclear()
		end
	end
end

function Jinx:DrawRDamage()
	local DrawROrder = 0
	local Enemies = ObjectManager.HeroList
	for I, Enemy in pairs(Enemies) do
		if Enemy.Team ~= myHero.Team and Enemy.IsDead == false then

			local Dist2Target  		= self:GetDistance(Enemy.Position, myHero.Position)
			local TravelTime 		= self:GetRSpeed(Dist2Target)
			local Damage, HP		= self:GetRDamage(Enemy, TravelTime, Dist2Target, true)
			local Draw 				= Enemy.ChampionName .. " (" .. string.format(math.floor(HP)) .. " HP) - " ..  string.format(math.floor(Damage)) .. " R Damage"
			if Damage > HP then
				--print("3")
				local Y, X = 100, 100

				X = X + self.DrawRAlert_X.Value
				Y = Y + self.DrawRAlert_Y.Value

				local R = 0
				local G = 0
				local B = 0
		
				local RN = 255
				local GN = 255
				local BN = 255
		
				local RG = 128
				local GG = 128
				local BG = 128

				Render:DrawFilledBox(Y -2, X-2+(32*DrawROrder), string.len(Draw) * 9.5 +8, 25+4, RG,GG,BG,128)
				Render:DrawFilledBox(Y+2, X+2+(32*DrawROrder), string.len(Draw) * 9.5, 21, R,G,B,200)
				Render:DrawString(Draw, Y+5, X+2+(32*DrawROrder), RN,GN,BN,225)
				DrawROrder = DrawROrder + 1
			end
		end
	end
end

function Jinx:OnDraw()


	if myHero:GetSpellSlot(0).Level > 0 and self.DrawQ.Value == 1 then
		local JinxQ = myHero.BuffData:GetBuff("JinxQ").Valid
		if JinxQ == false then
        	Render:DrawCircle(myHero.Position, Jinx:getAttackRange(RocketLauncher) ,170,170,170,170)
    	end
		if JinxQ == true then
			Render:DrawCircle(myHero.Position, Jinx:getAttackRange(MiniGun) ,170,170,170,170)
		end
	end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL4") then
		if self.DrawR.Value == 1 then
			Render:DrawCircle(myHero.Position, self.RRange.Value ,100,150,255,255)
		end
		if self.DrawRAlert.Value == 1 then
			Jinx:DrawRDamage()
		end
	end
end



function Jinx:OnLoad()
    if(myHero.ChampionName ~= "Jinx") then return end
	AddEvent("OnSettingsSave" , function() Jinx:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Jinx:LoadSettings() end)


	Jinx:__init()
	AddEvent("OnTick", function() Jinx:OnTick() end)	
	AddEvent("OnDraw", function() Jinx:OnDraw() end)
end

AddEvent("OnLoad", function() Jinx:OnLoad() end)	
