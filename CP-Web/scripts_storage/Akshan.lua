Akshan = {}
function Akshan:__init()	
	self.QRange = 850
	self.ERange = 800
    self.RRange = 2500

	self.QSpeed = 1500
	self.ESpeed = math.huge

	self.QWidth = 120

	self.QDelay = 0.3
	self.EDelay = 0.25

	self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Akshan")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
	
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Akshan:LoadSettings()
end

function Akshan:SaveSettings()
	SettingsManager:CreateSettings("Akshan")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Akshan:LoadSettings()
	SettingsManager:GetSettingsFile("Akshan")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Akshan:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Akshan:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function Akshan:CastWSpot(Target, EndPos)
	local PlayerPos 	= myHero.Position
    local TargetPos = Target.Position
	local EndPos 	= EndPos
	local TargetVec 	= Vector3.new(EndPos.x - PlayerPos.x, EndPos.y - PlayerPos.y, EndPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i = 500
    local EndPos = Vector3.new(EndPos.x - (TargetNorm.x * i),EndPos.y - (TargetNorm.y * i),EndPos.z - (TargetNorm.z * i))
    return EndPos
end

function Akshan:Ult()
    local target = Orbwalker:GetTarget("Combo", 2500)
    if target then
        local crit = myHero.CritChance
        local rDmg = 15 + (5 * myHero:GetSpellSlot(3).Level) + (0.1 * myHero.BaseAttack)
        local targetMissingHP = 100 - (target.Health / target.MaxHealth * 100)
        local bonusDmgModifier = 3 * targetMissingHP
        local totalDmg = (rDmg / 100 * (100 + bonusDmgModifier)) * 5
		if target.Health < totalDmg then
			Engine:CastSpell("HK_SPELL4", target.Position, 1)
			return
		end
    end
end

function Akshan:Combo()
	local rBuff = myHero.BuffData:GetBuff("AkshanR")
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") and not rBuff.Valid then
		self:Ult()
	end
	local target = Orbwalker:GetTarget("Combo", 1000)
	if target then
        local debuffPassive = target.BuffData:GetBuff("AkshanPassiveDebuff")
        if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 then
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange and debuffPassive.Count_Alt >= 2 then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
            end
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange and self:GetDistance(myHero.Position, target.Position) > self:getAttackRange() then
				local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
				if PredPos ~= nil then
					Engine:CastSpell("HK_SPELL1", PredPos, 1)
					return
				end
            end
        end
	end
end

function Akshan:Harass()
	local target = Orbwalker:GetTarget("Harass", 900)
	if target then

	end
end

function Akshan:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		local rBuff = myHero.BuffData:GetBuff("AkshanR")
		if not rBuff.Valid then
			Orbwalker.BlockAttack = 0
		else
			Orbwalker.BlockAttack = 1
		end
		if Engine:IsKeyDown("HK_COMBO") then
			Akshan:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Akshan:Harass()
		end
	end
end

function Akshan:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
    end
end

function Akshan:OnLoad()
    if(myHero.ChampionName ~= "Akshan") then return end
	AddEvent("OnSettingsSave" , function() Akshan:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Akshan:LoadSettings() end)


	Akshan:__init()
	AddEvent("OnTick", function() Akshan:OnTick() end)	
	AddEvent("OnDraw", function() Akshan:OnDraw() end)	
end

AddEvent("OnLoad", function() Akshan:OnLoad() end)	
