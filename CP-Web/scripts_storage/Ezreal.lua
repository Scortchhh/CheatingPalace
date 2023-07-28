Ezreal = {}
function Ezreal:__init()

	if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end
	
	self.QRange = 1200
	self.WRange = 1200
	self.ERange = 475
	self.RRange = 25000

	self.QSpeed = 2000
	self.WSpeed = 1700
	self.ESpeed = math.huge
	self.RSpeed = 2000

	self.QWidth = 120
	self.WWidth = 160
	self.RWidth = 300

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 1

	self.QHitChance = 0.2
	self.WHitChance = 0.35
	self.RHitChance = 0.4

	self.ScriptVersion = "         Ezreal Ver: 1.3" 

    self.ChampionMenu = Menu:CreateMenu("Ezreal")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	self.ComboUseROnCC = self.ComboMenu:AddCheckbox("UseR on CC enemy", 1)
	self.RRange	   = self.ComboMenu:AddSlider("Range for R use", 5000, 2000, 25000, 1000)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
	
	self.BaseMenu  = self.ChampionMenu:AddSubMenu("BaseUlt")
    self.BaseUseR  = self.BaseMenu:AddCheckbox("Enabled", 1)

	self.MiscMenu  = self.ChampionMenu:AddSubMenu("Misc")
    self.UseEForEvade  = self.MiscMenu:AddCheckbox("Use E to evade undodgeable spells", 1)

	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	Ezreal:LoadSettings()
end

function Ezreal:SaveSettings()
	SettingsManager:CreateSettings("Ezreal")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("RSlider", self.RRange.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
	-------------------------------------------------------
	SettingsManager:AddSettingsGroup("BaseUlt")
	SettingsManager:AddSettingsInt("Enabled", self.BaseUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Misc")
	SettingsManager:AddSettingsInt("Use E to evade undodgeable spells", self.UseEForEvade.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Ezreal:LoadSettings()
	SettingsManager:GetSettingsFile("Ezreal")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.RRange.Value 	 = SettingsManager:GetSettingsInt("Combo","RSlider")
	-------------------------------------------------------------
	self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
	------------------------------------------------------
	self.BaseUseR.Value = SettingsManager:GetSettingsInt("BaseUlt","Enabled")
	-------------------------------------------------------------
	self.UseEForEvade.Value = SettingsManager:GetSettingsInt("Misc","Use E to evade undodgeable spells")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Ezreal:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Ezreal:CastRToEnemyBase()
	Engine:CastSpellMap("HK_SPELL4", self.EnemyBase ,1)
end

function Ezreal:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local MagicResistMod			= 100 / (100 + Target.MagicResist)
	local RLevel 					= myHero:GetSpellSlot(3).Level
	local DMG 						= 200 + (150 * RLevel) + myHero.BonusAttack + (myHero.AbilityPower * 0.9) 
	return DMG
end

function Ezreal:CheckBaseUlt()
	local Distance 					= self:GetDistance(self.EnemyBase, myHero.Position)
	local GameTime					= GameClock.Time
	local TravelTime 				= (Distance / self.RSpeed) + 1
	
	local Heros = ObjectManager.HeroList
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team then
			local Tracker = Awareness.Tracker[Hero.Index]
			if Tracker then
				local State = Tracker.Recall.State
				local Start = Tracker.Recall.StartTime
				local End 	= Tracker.Recall.EndTime
				if State == 6 and Start < End then
					local RDMG				= self:GetRDamage(Hero)
					local RecallTime 		= End - GameTime
					-- no regeneration HP so we add 30 as safeguard.
					local enemyHP = Hero.Health + 30
					if RecallTime > 0 and RDMG > enemyHP and TravelTime >= RecallTime and TravelTime < (RecallTime + 0.5) then
						return true
					end
				end
			end
		end
	end
	
	return false
end

function Ezreal:LastHitQ()

	local QDamage = {20, 45, 70, 95, 120}
	local QLevel = myHero:GetSpellSlot(0).Level
	local Qdmg = QDamage[QLevel]

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable and Minion.IsDead == false then
                if self:GetDistance(myHero.Position, Minion.Position) <= self.QRange and self:GetDistance(myHero.Position, Minion.Position) >= myHero.AttackRange + myHero.CharData.BoundingRadius then
                    local qDmg = GetDamage( Qdmg + (myHero.BonusAttack * 1.20) + (myHero.AbilityPower * 0.15), true, Minion) 
					if Minion.Health <= qDmg and Minion.IsDead == false then
						return Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
					end
                end
            end
        end
    end
end

function Ezreal:CantMiss(Hero, Delay, ReactTime, MissileSpeed, SpellRadius)
	-- This example is for Blitz Q
	local HeroSpeed = Hero.MovementSpeed
	local SpellDelay = Delay - ReactTime
	local MissileSpeed = MissileSpeed
	local SpellRadius = SpellRadius
	--Example With Enemy MS 335: M2Delay = (140 + 65) / 335 - (0.25 - 0.1) = 0.46194
	local Ms2Delay = SpellRadius / HeroSpeed - SpellDelay --checks how long it will take to fully dodge the spell while spelldelay is activated
	--Example: Range2Hit = 1800 * 0.46194 = 831
	local Range2Hit = MissileSpeed * Ms2Delay 
	return Range2Hit
end

function Ezreal:Combo()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local StartPos 			= myHero.Position
		local CastPos ,Target	= Prediction:GetCastPos(StartPos, self.RRange.Value, self.RSpeed, self.RWidth, self.RDelay, 0, 1, self.RHitChance, 1)
		if CastPos ~= nil and Target ~= nil then
			local Distance 		= self:GetDistance(StartPos, CastPos)
			if Distance < self.RRange.Value and Distance > self.WRange then
				local RDMG = self:GetRDamage(Target)
				if RDMG > Target.Health then
					Engine:CastSpellMap("HK_SPELL4", CastPos ,1)
					return
				end
			end
		end
	end

	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local wDmg = 25 + (55 * myHero:GetSpellSlot(1).Level) + (myHero.BonusAttack * 0.6) + (myHero.AbilityPower * (0.65 + (0.05 * myHero:GetSpellSlot(1).Level)))
		local eDmg = 30 + (50 * myHero:GetSpellSlot(2).Level) + (myHero.BonusAttack * 0.5) + (myHero.AbilityPower * 0.75)
		local target = Orbwalker:GetTarget("Combo", 1200)
		if target then
			if self:GetDistance(myHero.Position, target.Position) > myHero.AttackRange + myHero.CharData.BoundingRadius then
				if target.Health <= wDmg + eDmg then
					Engine:CastSpell("HK_SPELL3", target.Position ,1)
					return
				end
			end
		end
	end

	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos = myHero.Position
		local CastPosNoCollision = Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, self.WHitChance, 1)
		local CastPosWithCollision = Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, 0, self.WHitChance, 1)
		local qCdr = myHero:GetSpellSlot(0).Cooldown
		local wDmg = 25 + (55 * myHero:GetSpellSlot(1).Level) + (myHero.BonusAttack * 0.6) + (myHero.AbilityPower * (0.65 + (0.05 * myHero:GetSpellSlot(1).Level)))
		local Target = Orbwalker:GetTarget("Combo", 1200)
		if Target then
			if CastPosNoCollision ~= nil then
				if Target.Health <= wDmg then
					if self:GetDistance(StartPos, CastPosNoCollision) < self.WRange then
						Engine:CastSpell("HK_SPELL2", CastPosNoCollision ,1)
						return
					end
				end
			end
		end
		if CastPosWithCollision ~= nil and GameClock.Time >= qCdr - 1 then
			if self:GetDistance(StartPos, CastPosWithCollision) < self.WRange then
				Engine:CastSpell("HK_SPELL2", CastPosWithCollision, 1)
				return
			end
		end
		if CastPosNoCollision ~= nil and GameClock.Time >= qCdr - 1 then
			if self:GetDistance(StartPos, CastPosNoCollision) <= myHero.AttackRange + myHero.CharData.BoundingRadius + 200 then
				Engine:CastSpell("HK_SPELL2", CastPosNoCollision, 1)
				return
			end
		end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos = myHero.Position
		local Target = Orbwalker:GetTarget("Combo", 1500)
		local qHitChance = 0.2
		if Target then
			if self:GetDistance(myHero.Position, Target.Position) <= myHero.AttackRange + myHero.CharData.BoundingRadius then
				local CastPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, 0, self.QHitChance, 1)
				if CastPos ~= nil and Orbwalker.ResetReady == 1 then
					if self:GetDistance(StartPos, CastPos) < self.QRange then--and self:GetDistance(myHero.Position, Target.Position) < MaxRange then
						Engine:CastSpell("HK_SPELL1", CastPos ,1)
						return
					end
				end
			else
				local CastPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, 0, self.QHitChance, 1)
				if CastPos ~= nil then
					if self:GetDistance(StartPos, CastPos) < self.QRange then--and self:GetDistance(myHero.Position, Target.Position) < MaxRange then
						Engine:CastSpell("HK_SPELL1", CastPos ,1)
						return
					end
				end
			end
		end
	end
end

function Ezreal:Harass()

	if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local StartPos = myHero.Position
		local CastPos = Prediction:GetCastPos(StartPos, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, 0, self.WHitChance, 1)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.WRange then
				local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", CastPos ,1)
                    return
                end
			end
		end
	end

	if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos = myHero.Position
		local CastPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, 0, self.QHitChance, 1)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QRange then
                local sliderValue = self.HarassSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", CastPos, 1)
                    return
                end
			end
		end
	end
end

function Ezreal:Laneclear()
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
		local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target and target.IsMinion == true and target.MaxHealth > 10 then
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange then
				if target.IsHero or target.IsMinion then
					local sliderValue = self.LClearSlider.Value
					local condition = myHero.MaxMana / 100 * sliderValue
					if myHero.Mana >= condition then
						return Engine:CastSpell("HK_SPELL1", target.Position, 0)
					end
				end
            end
        end
	end	
end

function Ezreal:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		local target = Orbwalker:GetTarget("Combo", 1000)
		if self.ComboUseROnCC.Value == 1 then
			if target then
				local isCC = target.BuffData:HasBuffOfType(BuffType.Stun)
				if isCC then
					local rDmg = self:GetRDamage(target)
					if target.Health <= rDmg then
						Engine:CastSpellMap("HK_SPELL4", target.Position ,1)
						return
					end
				end
			end
		end
		if Evade.CanEvadeInTime == false and Evade.evadePos ~= nil and self.UseEForEvade.Value == 1 then
			if Engine:SpellReady("HK_SPELL3") then
				return Engine:CastSpell("HK_SPELL3", Evade.evadePos, 0)
			end
		end
		if Orbwalker.Attack == 0 then
			if self.BaseUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
				if self:CheckBaseUlt() == true then
					self:CastRToEnemyBase()
				end
			end
			if Engine:IsKeyDown("HK_COMBO") then
				Ezreal:Combo()
			end
			if Engine:IsKeyDown("HK_HARASS") then
				Ezreal:Harass()
			end
			if Engine:IsKeyDown("HK_LANECLEAR") then
				Ezreal:Laneclear()
			end
			if Engine:IsKeyDown("HK_LASTHIT") then
				Ezreal:LastHitQ()
			end
		end
	end
end

function Ezreal:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
end



function Ezreal:OnLoad()
    if(myHero.ChampionName ~= "Ezreal") then return end
	AddEvent("OnSettingsSave" , function() Ezreal:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ezreal:LoadSettings() end)


	Ezreal:__init()
	AddEvent("OnTick", function() Ezreal:OnTick() end)	
	AddEvent("OnDraw", function() Ezreal:OnDraw() end)	
	print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Ezreal:OnLoad() end)	
