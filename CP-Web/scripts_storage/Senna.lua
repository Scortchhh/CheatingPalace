require("Enums")
require("DamageLib")
require("SupportLib")

Senna = {}
function Senna:__init()	
	if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end

	self.QRange = 600
	self.QMaxRange = 1300
	
	self.WRange = 1300

	self.QSpeed = math.huge
	self.WSpeed = 1200
	self.ESpeed = math.huge
	self.RSpeed = 20000

	self.WWidth = 140

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 1

	self.E_Timer = 0

	self.WHitChance = 0.2
	
    self.ChampionMenu = Menu:CreateMenu("Senna")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseQHeal  = self.ComboMenu:AddCheckbox("UseQ healing", 1)
    self.ComboUseLongQ 	= self.ComboMenu:AddCheckbox("UseLongQ", 1)
    self.ComboUseW 		= self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboSlowW		= self.ComboMenu:AddCheckbox("W on CC only", 1)
    self.ComboUseR 		= self.ComboMenu:AddCheckbox("UseR", 1)
	self.RRange	   		= self.ComboMenu:AddSlider("Range for R use", 5000, 2000, 25000, 1000)
	self.RPercent   	= self.ComboMenu:AddSlider("HP of Ally in % for R use", 25, 0, 100, 20)

	-------------------------------------------
    self.HarassMenu 	= self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ 	= self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseLongQ = self.HarassMenu:AddCheckbox("UseLongQ", 1)


	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
	
	Senna:LoadSettings()
end

function Senna:SaveSettings()
	SettingsManager:CreateSettings("Senna")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseQ healing", self.ComboUseQHeal.Value)
	SettingsManager:AddSettingsInt("UseLongQ", self.ComboUseLongQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("SlowedW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboSlowW.Value)
	SettingsManager:AddSettingsInt("RSlider", self.RRange.Value)
	SettingsManager:AddSettingsInt("RPercent", self.RPercent.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQ", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseLongQ", self.HarassUseLongQ.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
end

function Senna:LoadSettings()
	SettingsManager:GetSettingsFile("Senna")
	self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseQHeal.Value 	= SettingsManager:GetSettingsInt("Combo","UseQ healing")
	self.ComboUseLongQ.Value 	= SettingsManager:GetSettingsInt("Combo","UseLongQ")
	self.ComboUseW.Value 		= SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboSlowW.Value 		= SettingsManager:GetSettingsInt("Combo","SlowedW")
	self.ComboUseR.Value 		= SettingsManager:GetSettingsInt("Combo","UseR")
	self.RRange.Value 	 		= SettingsManager:GetSettingsInt("Combo","RSlider")
	self.RPercent.Value 	 	= SettingsManager:GetSettingsInt("Combo","RPercent")
	-------------------------------------------------------------
	self.HarassUseQ.Value 		= SettingsManager:GetSettingsInt("Harass","UseQ")
	self.HarassUseLongQ.Value 	= SettingsManager:GetSettingsInt("Harass","UseLongQ")
	-------------------------------------------------------------
	self.DrawQ.Value 			= SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value 			= SettingsManager:GetSettingsInt("Drawings","DrawW")
end

function Senna:GetQDmg()
    local qDmg      = {40, 70, 100, 130, 160}
    local qLevel    = myHero:GetSpellSlot(0).Level

    if qLevel == 0 then
        return 0
    end
    
    return qDmg[qLevel] + (myHero.BonusAttack * 0.5)
end

function Senna:GetWDmg()
    local wDmg      = {70, 115, 160, 205, 250}
    local wLevel    = myHero:GetSpellSlot(1).Level

    if wLevel == 0 then
        return 0
    end
    
    return wDmg[wLevel] + myHero.BonusAttack * 0.7
end

function Senna:GetRDmg()
    local rDmg      = {250, 375, 500}
    local rLevel    = myHero:GetSpellSlot(3).Level

    if rLevel == 0 then
        return 0
    end
    
    return rDmg[rLevel] + myHero.BonusAttack + (myHero.AbilityPower * 0.5)
end

function Senna:AADmg()
    return myHero.BonusAttack + myHero.BaseAttack + (myHero.BonusAttack * 0.2)
end

function Senna:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * HeroLvl() / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
		if FinalArmor < 0 then
			FinalArmor = 0
		end

        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod

		if realMR < 0 then
			realMR = 0
		end

        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Senna:KSandStun()
	local Distance 					= self:GetDistance(self.EnemyBase, myHero.Position)
	local GameTime					= GameClock.Time
	local TravelTime 				= (Distance / self.RSpeed) + self.RDelay
	
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team  and Hero.IsDead == false then

            if Engine:SpellReady("HK_SPELL4") then
				local Tracker = Awareness.Tracker[Hero.Index]
				if Tracker then
					local State = Tracker.Recall.State
					local Start = Tracker.Recall.StartTime
					local End 	= Tracker.Recall.EndTime
					if State == 6 and Start < End then
						local RDMG				= self:GetDamage(self:GetRDmg(), true, Hero)
						local RecallTime 		= End - GameTime
						-- print('4', TravelTime < (RecallTime + 0.5))
						local enemyHP = Hero.Health + 50
						if RecallTime > 0 and RDMG > enemyHP and TravelTime + 0.1 >= (RecallTime) then
							Engine:CastSpellMap("HK_SPELL4", self.EnemyBase ,1)
						end
					end
				end
			end

            if Hero.IsTargetable then
                if Engine:SpellReady("HK_SPELL2") 
                and self:GetDistance(myHero.Position, Hero.Position) < self.WRange - 50
                and
                    (
                        (self:GetDamage(self:GetWDmg(), true, Hero) > Hero.Health)
                        or ( self:GetDistance(myHero.Position, Hero.Position) <= 100)
                        or ( Hero.Health < self:GetDamage(self:GetWDmg(), true, Hero) + self:GetDamage(self:GetQDmg(), true, Hero) 
                            and Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QRange - 50
                            )
                        or ( Hero.Health < self:GetDamage(self:GetWDmg(), true, Hero) + self:GetDamage(self:GetQDmg(), true, Hero) + self:GetDamage(self:GetRDmg(),true,Hero)
                            and Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QRange - 50
                            and Engine:SpellReady("HK_SPELL4")
                            )
                    )
                and Orbwalker.ResetReady ~= 1 and Orbwalker.Attack == 0 then
                    local outVec = Vector3.new()
                    local PredPos, HitChance = Prediction:GetPredPos(myHero.Position, Hero, self.WSpeed, self.WDelay)	
                    if PredPos == nil or self:GetDistance(myHero.Position, PredPos) > self.WRange + 120 then
                        goto continue
                    end
                    if Render:World2Screen(PredPos, outVec) == true then
                        if Prediction:WillCollideWithMinion(myHero.Position, PredPos, 100) == false then
                            Engine:CastSpell("HK_SPELL2", PredPos, 1)
                        end
                    end
                end

                ::continue::

                if Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QMaxRange - 50
                and Hero.Health < self:GetDamage(self:GetQDmg(), true, Hero)
                then
                    local LongQTarget = self:GetLongQTarget(Hero)

                    if LongQTarget ~= nil then
                        Engine:CastSpell("HK_SPELL1", LongQTarget.Position ,0)
                    else
                        if Orbwalker.ResetReady == 1 then					
                            Engine:CastSpell("HK_SPELL1", Hero.Position, 1)
                        end
                    end
                end

                if Hero.Health < self:GetDamage(self:AADmg(), true, Hero) and self:GetDistance(myHero.Position, Hero.Position) < Orbwalker.OrbRange - 50 then
                    Orbwalker:Orbwalk(Hero)
                end
            end
		end
	end
end

function Senna:DrawDmg()
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team then
			local Damages = {}
			table.insert( Damages, {
				Damage = self:GetDamage(self:AADmg(), true, Hero),
				Color = Colors.Pink,
			})

			if Engine:SpellReady("HK_SPELL1") then
				table.insert( Damages, {
					Damage = self:GetDamage(self:GetQDmg(), true, Hero),
					Color = Colors.Blue,
				})
			end

			if Engine:SpellReady("HK_SPELL2") then
				table.insert(Damages, {
					Damage = self:GetDamage(self:GetWDmg(), true, Hero),
					Color = Colors.Turqoise
				})
			end

			if Engine:SpellReady("HK_SPELL4") then
				table.insert(Damages, {
					Damage = self:GetDamage(self:GetRDmg(), true, Hero),
					Color = Colors.PurpleDarker
				})
			end

            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
end

function Senna:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Senna:GetLongQTarget(Hero)
    local Target = Hero

    if Hero == nil then
        Target = Orbwalker:GetTarget("Combo", self.QMaxRange)
    end

	if Target ~= nil then
		local Heros = ObjectManager.HeroList
		for I,Hero in pairs(Heros) do
			if Hero.IsTargetable == true and Hero.IsDead == false and Hero.Index ~= myHero.Index then			
				local PlayerPos = myHero.Position
				local TargetPos = Hero.Position
				if self:GetDistance(PlayerPos, TargetPos) < self.QRange + myHero.CharData.BoundingRadius then
                    local i 			= self.QMaxRange
					local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
					local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
					local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
					local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))
		
					if Prediction:PointOnLineSegment(PlayerPos, EndPos, Target.Position, 20) == true and self:GetDistance(PlayerPos, Target.Position) <= self.QMaxRange - 50 then
						return Hero
					end
				end
			end
		end
		
		local Minions = ObjectManager.MinionList
		for I,Minion in pairs(Minions) do
			if Minion.IsTargetable == true and Minion.IsDead == false then			
				local PlayerPos = myHero.Position
				local TargetPos = Minion.Position
				if self:GetDistance(PlayerPos, TargetPos) < self.QRange + myHero.CharData.BoundingRadius then
                    local i 			= self.QMaxRange
					local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
					local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
					local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
					local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))
		
					if Prediction:PointOnLineSegment(PlayerPos, EndPos, Target.Position, 20) == true and self:GetDistance(PlayerPos, Target.Position) <= self.QMaxRange - 50 then
						return Minion
					end
				end
			end
		end
	end
	return nil
end

function Senna:EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Senna:UseRCheck(RPercent)
	local Heros = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
	for I,Hero in pairs(Heros) do
		if Hero.IsTargetable == true and Hero.Index ~= myHero.Index and Hero.Team == myHero.Team then			
			local PlayerPos = myHero.Position
			local HeroPos = Hero.Position
			if self:GetDistance(PlayerPos, HeroPos) < self.RRange.Value then
				local Count = self:EnemiesInRange(HeroPos, 500)
				if Count > 0 then
					local HPPercent = Hero.Health / Hero.MaxHealth 
					if HPPercent < RPercent/100 then
						Engine:CastSpellMap("HK_SPELL4", Hero.Position, 1)
					end				
				end
			end
		end
	end
end

function Senna:Combo()
	local QHealTarget 			= SupportLib:GetHealTarget(self.QRange + myHero.CharData.BoundingRadius, 0.7)
	local QTarget 				= Orbwalker:GetTarget("Combo", self.QRange + myHero.CharData.BoundingRadius)
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") and QTarget == nil then
		self:UseRCheck(self.RPercent.Value)
	end
	
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		if QTarget ~= nil then
			if Orbwalker.ResetReady == 1 then					
				Engine:CastSpell("HK_SPELL1", QTarget.Position ,1)
				return
			end
		end
	end

	if self.ComboUseQHeal.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		if QHealTarget ~= nil then
			Engine:CastSpell("HK_SPELL1", QHealTarget.Position ,1)
			return
		end
	end

	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos = myHero.Position
		local CastPos, Target = Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.WRange then
				if self.ComboSlowW.Value == 1 then
					local Slow 			= Target.BuffData:HasBuffOfType(BuffType.Slow)
					local Stun 			= Target.BuffData:HasBuffOfType(BuffType.Stun)
					local Suppress 		= Target.BuffData:HasBuffOfType(BuffType.Suppression)
					local Taunt 		= Target.BuffData:HasBuffOfType(BuffType.Taunt)
					if Slow or Stun or Suppress or Taunt then
						if QTarget == nil then
							Engine:CastSpell("HK_SPELL2", CastPos ,1)
							return
						else
							if Orbwalker.ResetReady == 1 then					
								Engine:CastSpell("HK_SPELL2", CastPos ,1)
								return
							end
						end						
					end
				else
					if QTarget == nil then
						Engine:CastSpell("HK_SPELL2", CastPos ,1)
						return
					else
						if Orbwalker.ResetReady == 1 then					
							Engine:CastSpell("HK_SPELL2", CastPos ,1)
							return
						end
					end			
				end
			end
		end
	end

	if self.ComboUseLongQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		if QHealTarget == nil and Orbwalker.Attack == 0 then
			local LongQTarget = self:GetLongQTarget(nil)
			if LongQTarget ~= nil and QTarget == nil then
				Engine:CastSpell("HK_SPELL1", LongQTarget.Position ,0)
				return
			end
		end
	end

end

function Senna:Harass()
	local QTarget = Orbwalker:GetTarget("Combo", self.QRange + myHero.CharData.BoundingRadius)

	if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		if QTarget ~= nil then
			Engine:CastSpell("HK_SPELL1", QTarget.Position ,1)
			return
		end
	end

	if self.HarassUseLongQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = self:GetLongQTarget(nil)
		if Target ~= nil and QTarget == nil and Orbwalker.Attack == 0 then
			Engine:CastSpell("HK_SPELL1", Target.Position ,0)
			return
		end
	end
end

function Senna:OnTick()
	self.QRange = myHero.AttackRange
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:KSandStun()
		if Engine:IsKeyDown("HK_COMBO") then
			Senna:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Senna:Harass()
			return
		end
	end
end

function Senna:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QMaxRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end

	Senna:DrawDmg()
end



function Senna:OnLoad()
    if(myHero.ChampionName ~= "Senna") then return end
	AddEvent("OnSettingsSave" , function() Senna:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Senna:LoadSettings() end)


	Senna:__init()
	AddEvent("OnTick", function() Senna:OnTick() end)	
	AddEvent("OnDraw", function() Senna:OnDraw() end)	
end

AddEvent("OnLoad", function() Senna:OnLoad() end)	
