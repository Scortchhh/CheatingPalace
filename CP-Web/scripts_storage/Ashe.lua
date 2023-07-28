local Ashe = {
}

function Ashe:__init()
    self.WRange = 1200
    self.WSpeed = 2000
    self.WDelay = 0.25
    self.WWidth = 100

    self.RRange = 3000
    self.RSpeed = 1500
    self.RWidth = 260
    self.RDelay = 0.25

    if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end
    self.RSpeed = 1835
    self.AsheMenu = Menu:CreateMenu("Ashe")
    self.AsheCombo = self.AsheMenu:AddSubMenu("Combo")
    self.AsheCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.AsheCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo = self.AsheCombo:AddCheckbox("Use W", 1)
    self.UseRCombo = self.AsheCombo:AddCheckbox("Use R", 1)
    self.UseRForceTargetOnly = self.AsheCombo:AddCheckbox("Use Targeted R Only", 1)
    self.UseWOutOfAARange = self.AsheCombo:AddCheckbox("UseW if out of AA range", 1)
    self.AsheHarass = self.AsheMenu:AddSubMenu("Harass")
    self.AsheHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.AsheHarass:AddCheckbox("UseQ in harass", 1)
    self.UseWHarass = self.AsheHarass:AddCheckbox("UseW in harass", 1)
    self.AsheDrawings = self.AsheMenu:AddSubMenu("Drawings")
    self.DrawW = self.AsheDrawings:AddCheckbox("UseW in drawings", 1)

    Ashe:LoadSettings()
end

function Ashe:SaveSettings()
	SettingsManager:CreateSettings("Ashe")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use R", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use Targeted R Only", self.UseRForceTargetOnly.Value)
    SettingsManager:AddSettingsInt("UseW if out of AA range", self.UseWOutOfAARange.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseW in drawings", self.DrawW.Value)
end

function Ashe:LoadSettings()
	SettingsManager:GetSettingsFile("Ashe")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R")
    self.UseRForceTargetOnly.Value = SettingsManager:GetSettingsInt("Combo", "Use Targeted R Only")
    self.UseWOutOfAARange.Value = SettingsManager:GetSettingsInt("Combo", "UseW if out of AA range")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
    -------------------------------------------
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "UseW in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Ashe:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function Ashe:GetRDamage(Target)
	local MissingHealth 			= Target.MaxHealth - Target.Health
	local MagicResistMod			= 100 / (100 + Target.MagicResist)
	local RLevel 					= myHero:GetSpellSlot(3).Level
	local DMG 						= GetDamage(0 + (200 * RLevel) + (myHero.AbilityPower * 1), false, Target)
	return DMG
end

function Ashe:CheckBaseUlt()
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

function Ashe:CastQ()
    local qbuff = myHero.BuffData:GetBuff("asheqcastready").Valid
    local qbuff2 = myHero.BuffData:GetBuff("AsheQAttack").Valid
    if qbuff and not qbuff2  then
        -- broken due to how ashe q is coded
        -- if Engine:SpellReady('HK_SPELL1') then
            local target = Orbwalker:GetTarget("Combo", 650)
            if target then
                if ValidTarget(target) and Orbwalker.ResetReady == 1 then
                    Engine:CastSpell('HK_SPELL1', target.Position, 1)
                    return
                end
            end
        -- end
    end
end

function Ashe:CastW()
    if Engine:SpellReady('HK_SPELL2') then
        local target = Orbwalker:GetTarget("Combo", 1250)
        if target then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, 0.35, 1)
            if GetDist(myHero.Position, target.Position) >= getAttackRange() then
                if self.UseWOutOfAARange.Value == 1 then
                    if PredPos ~= nil then
                        Engine:CastSpell('HK_SPELL2', PredPos, 1)
                    end
                end
            else
                if PredPos ~= nil and Orbwalker.ResetReady == 1 then
                    Engine:CastSpell('HK_SPELL2', PredPos, 1)
                end
            end
        end
    end
end

function Ashe:CastR()
    if Engine:SpellReady('HK_SPELL4') then
        if (self.UseRForceTargetOnly.Value == 1) then
            local hasForceTarget = Orbwalker.ForceTarget and Orbwalker.ForceTarget.IsHero and not Orbwalker.ForceTarget.IsDead
            if hasForceTarget then
                local NotUsingForceTargetOnlySetting = Prediction.ForceTargetOnly.Value == 0
                if NotUsingForceTargetOnlySetting then Prediction.ForceTargetOnly.Value = 1 end
                local PredPos = Prediction:GetCastPos(myHero.Position, 30000, self.RSpeed, self.RWidth, self.RDelay, false, true, 35, 1)
                if PredPos ~= nil then
                    Engine:CastSpell('HK_SPELL4', PredPos, 1)
                end
                if NotUsingForceTargetOnlySetting then Prediction.ForceTargetOnly.Value = 0 end
            end
            return
        end

        local target = Orbwalker:GetTarget("Combo", 2000)
        if target then
            local aaDmg = (myHero.BaseAttack + myHero.BonusAttack) * 5
            local wDmg = 5 + (15 * myHero:GetSpellSlot(1).Level) + (myHero.BaseAttack + myHero.BonusAttack) * 1
            local totalDmg = aaDmg + wDmg
            if target.Health <= totalDmg then
                if self:GetDistance(myHero.Position, target.Position) > getAttackRange() and self:GetDistance(myHero.Position, target.Position) <= 1500 then
                    if self:GetDistance(myHero.AIData.TargetPos, target.Position) < self:GetDistance(myHero.Position, target.Position) then
                        if self:GetDistance(target.AIData.TargetPos, myHero.Position) > self:GetDistance(target.Position, myHero.Position) then
                            local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, 0.4, 1)
                            if PredPos ~= nil then
                                Engine:CastSpell('HK_SPELL4', PredPos, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function Ashe:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:SpellReady("HK_SPELL4") then
            if self:CheckBaseUlt() then
                Engine:CastSpellMap('HK_SPELL4', self.EnemyBase, 1)
            end
        end
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseRCombo.Value == 1 then
                Ashe:CastR()
            end
            if self.UseQCombo.Value == 1 then
                Ashe:CastQ()
            end
            if self.UseWCombo.Value == 1 then
                Ashe:CastW()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then
                Ashe:CastQ()
            end
            if self.UseWHarass.Value == 1 then
                Ashe:CastW()
            end
        end
    end
end

function Ashe:OnDraw() 
if myHero.IsDead then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 1250,255,0,255,255)
        end
    end
end

function Ashe:OnLoad()
    if(myHero.ChampionName ~= "Ashe") then return end
    AddEvent("OnSettingsSave" , function() Ashe:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ashe:LoadSettings() end)
    Ashe:__init()
    AddEvent("OnDraw", function() Ashe:OnDraw() end)
    AddEvent("OnTick", function() Ashe:OnTick() end)
end
AddEvent("OnLoad", function() Ashe:OnLoad() end)