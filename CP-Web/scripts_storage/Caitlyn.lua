Caitlyn = {}
function Caitlyn:__init()	
	self.QRange = 1240
    self.WRange = 800
	self.ERange = 740
	self.RRange = 850

	self.QSpeed = 2200
	self.WSpeed = math.huge
	self.ESpeed = 1600
	self.RSpeed = math.huge

	self.QWidth = 180
	self.WWidth = 15
	self.EWidth = 140

	self.QDelay = 0.625
	self.WDelay = 1.5
	self.EDelay = 0.15
	self.RDelay = 0

    self.ChampionMenu = Menu:CreateMenu("Caitlyn")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	---------------------------------------------------------
	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
	self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseW = self.HarassMenu:AddCheckbox("UseW", 1)
	self.HarassUseWS = self.HarassMenu:AddCheckbox("UseW on effects only", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE", 1)
		---------------------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	
	Caitlyn:LoadSettings()
end

function Caitlyn:SaveSettings()
	SettingsManager:CreateSettings("Caitlyn")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
	SettingsManager:AddSettingsInt("UseQ", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.HarassUseW.Value)
	SettingsManager:AddSettingsInt("UseW on effects only", self.HarassUseWS.Value)
	SettingsManager:AddSettingsInt("UseE", self.HarassUseE.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Caitlyn:LoadSettings()
	SettingsManager:GetSettingsFile("Caitlyn")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	-------------------------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
	self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQ")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseW")
	self.HarassUseWS.Value = SettingsManager:GetSettingsInt("Harass","UseW on effects only")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","UseE")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function Caitlyn:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Caitlyn:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetMyLevel() / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Caitlyn:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

local LastTrapPlaced = 0
function Caitlyn:Combo()
    local StartPos 	= myHero.Position
    if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, 0.5, 0)
		if PredPos and Target and self:GetDistance(PredPos, StartPos) < self.WRange-50 then
			local Slow 					= Target.BuffData:HasBuffOfType(BuffType.Slow)
			local Stun 					= Target.BuffData:HasBuffOfType(BuffType.Stun)
			local Suppress 				= Target.BuffData:HasBuffOfType(BuffType.Suppression)
			local Taunt 				= Target.BuffData:HasBuffOfType(BuffType.Taunt)
			local TrapDebuff        	= Target.BuffData:GetBuff("CaitlynWSnare") 
			local Trapped               = TrapDebuff and TrapDebuff.Count_Alt > 0
			local TrapTimer             = GameClock.Time - LastTrapPlaced
			if Trapped == false and TrapTimer > 2 and (Slow or Stun or Suppress or Taunt) then
				LastTrapPlaced = GameClock.Time
				return Engine:CastSpell("HK_SPELL2", PredPos, 1)
			else
				if Trapped == false and TrapTimer > 2 then
					return Engine:CastSpell("HK_SPELL2", PredPos, 1)
				end
			end
		end
    end
    if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.Attack == 0 then
		local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, 0.35, 1)
        if PredPos and Target then
            local SafeDistance = self:GetDistance(Target.Position, StartPos) < self.ERange/1.3
            if SafeDistance then
				self.LastETarget 	= Target
                self.LastECastTime 	= os.clock()
				return Engine:CastSpell("HK_SPELL3", PredPos, 1)
            end
        end   
    end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Engine:SpellReady("HK_SPELL3") == false then
		if self.LastETarget and self.LastETarget.IsTargetable and (os.clock() - self.LastECastTime) < 0.5 then
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, 0.35, 1)
			if PredPos then return Engine:ReleaseSpell("HK_SPELL1", PredPos) end
		end
	end	
end

function Caitlyn:Harass()
	local sliderValue = self.HarassSlider.Value
	local condition = myHero.MaxMana / 100 * sliderValue
	if myHero.Mana >= condition then
		local StartPos 	= myHero.Position
		if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, 0.5, 0)
			if PredPos and Target and self:GetDistance(PredPos, StartPos) < self.WRange-50 then
				local Slow 					= Target.BuffData:HasBuffOfType(BuffType.Slow)
				local Stun 					= Target.BuffData:HasBuffOfType(BuffType.Stun)
				local Suppress 				= Target.BuffData:HasBuffOfType(BuffType.Suppression)
				local Taunt 				= Target.BuffData:HasBuffOfType(BuffType.Taunt)
				local TrapDebuff        	= Target.BuffData:GetBuff("CaitlynWSnare") 
				local Trapped               = TrapDebuff and TrapDebuff.Count_Alt > 0
				local TrapTimer             = GameClock.Time - LastTrapPlaced
				if Trapped == false and TrapTimer > 2 and (Slow or Stun or Suppress or Taunt) and self.HarassUseWS.Value == 1 then
					LastTrapPlaced = GameClock.Time
					return Engine:CastSpell("HK_SPELL2", PredPos, 1)
				else
					if self.HarassUseWS.Value == 0 and Trapped == false then
						return Engine:CastSpell("HK_SPELL2", PredPos, 1)
					end
				end
			end   
		end

		if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, 0.35, 1)
			if PredPos and Target and self:GetDistance(PredPos, StartPos) < self.QRange then
				return Engine:CastSpell("HK_SPELL1", PredPos, 1)
			end   
		end

		if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, 0.35, 1)
			if PredPos and Target then
				local SafeDistance = self:GetDistance(Target.Position, StartPos) < self.ERange/1.3
				if SafeDistance then
					return Engine:CastSpell("HK_SPELL3", PredPos, 1)
				end
			end   
		end
	end
end

function Caitlyn:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
		if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
			local enemiesAround = self:EnemiesInRange(myHero.Position, 1000)
			if #enemiesAround <= 0 then
				local HeroList = ObjectManager.HeroList
				for I, Hero in pairs(HeroList) do
					if Hero.Team ~= myHero.Team and not Hero.IsDead and Hero.IsTargetable then
						if self:GetDistance(myHero.Position, Hero.Position) <= 3500 and self:GetDistance(myHero.Position, Hero.Position) >= 800 then
							local rDmg = self:GetDamage(75 + (225 * myHero:GetSpellSlot(3).Level) + (myHero.BonusAttack * 2), true, Hero)
							if Hero.Health <= rDmg then
								return Engine:CastSpellMap("HK_SPELL4", Hero.Position, 1)
							end
						end
					end
				end
			end
		end
		if Engine:IsKeyDown("HK_COMBO") then
			Caitlyn:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Caitlyn:Harass()
			return
		end
		if Engine:IsKeyDown("HK_FLEE") then
			return
		end
	end
end

function Caitlyn:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
	if Engine:IsKeyDown("HK_FLEE") then
		return
	end
end



function Caitlyn:OnLoad()
    if(myHero.ChampionName ~= "Caitlyn") then return end
	AddEvent("OnSettingsSave" , function() Caitlyn:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Caitlyn:LoadSettings() end)


	Caitlyn:__init()
	AddEvent("OnTick", function() Caitlyn:OnTick() end)	
	AddEvent("OnDraw", function() Caitlyn:OnDraw() end)	
end

AddEvent("OnLoad", function() Caitlyn:OnLoad() end)	