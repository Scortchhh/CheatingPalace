Vex = {}
function Vex:__init()	
	self.QRange = 500
    self.Q2Range = 1200
	self.WRange = 475
	self.ERange = 800
    self.RRange = 1500

	self.QSpeed = 600
    self.Q2Speed = 3200
    self.WSpeed = math.huge
	self.ESpeed = 1300
	self.RSpeed = math.huge

	self.QDelay = 0.15
    self.Q2Delay = 0.25
	self.WDelay = 0.25
	self.EDelay = 0.25
	self.RDelay = 0.25


    self.QWidth = 160
    self.Q2Width = 360
    self.RWidth = 260

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Vex")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseW = self.HarassMenu:AddCheckbox("UseW", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE", 1)
	
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Vex:LoadSettings()
end

function Vex:SaveSettings()
	SettingsManager:CreateSettings("Vex")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Vex:LoadSettings()
	SettingsManager:GetSettingsFile("Vex")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Vex:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Vex:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function Vex:GetDamage(rawDmg, isPhys, target)
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

function Vex:EnemiesAround(position, range)
	local EnemyList = ObjectManager.HeroList
	local counter = 0
	for i, Hero in pairs(EnemyList) do 
		if not Hero.IsDead and Hero.IsTargetable and Hero.Team ~= myHero.Team then
			if self:GetDistance(position, Hero.Position) <= range then
                counter = counter + 1
			end
		end
	end
    return counter
end

function Vex:Combo()
    local passiveDoom = myHero.BuffData:GetBuff("vexpdoom")
    local target = Orbwalker:GetTarget("Combo", self.Q2Range)
    local ultTarget = Orbwalker:GetTarget("Combo", self.RRange)
    if ultTarget and Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
        -- add r recheck here
        local hasRDebuff = ultTarget.BuffData:GetBuff("VexRTarget")
        local hasGloom = ultTarget.BuffData:GetBuff("vexpgloom")
        if hasRDebuff.Valid and Engine:SpellReady("HK_SPELL4") then
            Engine:CastSpell("HK_SPELL4", GameHud.MousePos, 1)
            return
        end
        local passiveDmg = self:GetDamage(30 + 150 / 17 * (myHero.Level - 1), false, ultTarget)
        local qDmg = 10 + (50 * myHero:GetSpellSlot(0).Level) + (myHero.AbilityPower * 0.6)
        local wDmg = 40 + (40 * myHero:GetSpellSlot(1).Level) + (myHero.AbilityPower * 0.3)
        local eDmg = 30 + (20 * myHero:GetSpellSlot(2).Level) + (myHero.AbilityPower * (0.35 + (0.05 * myHero:GetSpellSlot(2).Level)))
        local rDmg = 25 + (50 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.2)
        local r2Dmg = 50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.5)
        local totalDmg = 0
        if hasGloom.Valid or Engine:SpellReady("HK_SPELL3") then
            totalDmg = totalDmg + passiveDmg
        end
        if Engine:SpellReady("HK_SPELL1") then
            qDmg = self:GetDamage(qDmg, false, ultTarget)
            totalDmg = totalDmg + qDmg
        end
        if Engine:SpellReady("HK_SPELL2") then
            wDmg = self:GetDamage(wDmg, false, ultTarget)
            totalDmg = totalDmg + wDmg
        end
        if Engine:SpellReady("HK_SPELL3") then
            eDmg = self:GetDamage(eDmg, false, ultTarget)
            totalDmg = totalDmg + eDmg
        end
        totalDmg = totalDmg + self:GetDamage(rDmg, false, ultTarget) + self:GetDamage(r2Dmg, false, ultTarget)
        -- print(totalDmg)
        if ultTarget.Health <= totalDmg then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
            if CastPos ~= nil then
                Engine:CastSpell("HK_SPELL4", CastPos, 1)
                return
            end
        end
    end
    if target then
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            if self:EnemiesAround(myHero.Position, self.WRange) >= 2 and passiveDoom.Valid then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 and passiveDoom.Valid and self:GetDistance(myHero.Position, target.Position) <= self.ERange then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 then
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 180, self.QDelay, 0, true, self.QHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL1", CastPos, 1)
					return
				end
            end
            if self:GetDistance(myHero.Position, target.Position) > self.QRange and self:GetDistance(myHero.Position, target.Position) <= self.Q2Range then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, 180, self.Q2Delay, 0, true, self.QHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL1", CastPos, 1)
					return
				end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 and self:GetDistance(myHero.Position, target.Position) <= self.ERange then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 250, self.EDelay, 0, true, self.EHitChance, 0)
            if CastPos ~= nil then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                if self:GetDistance(myHero.Position, target.Position) <= self.WRange - 50 then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
                end
            end
        end
    end
end

function Vex:Harass()
    local passiveDoom = myHero.BuffData:GetBuff("vexpdoom")
    local target = Orbwalker:GetTarget("Harass", self.Q2Range)
    if target then
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
            if self:EnemiesAround(myHero.Position, self.WRange) >= 2 and passiveDoom.Valid then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 and passiveDoom.Valid and self:GetDistance(myHero.Position, target.Position) <= self.ERange then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
        if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 then
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 180, self.QDelay, 0, true, self.QHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL1", CastPos, 1)
					return
				end
            end
            if self:GetDistance(myHero.Position, target.Position) > self.QRange and self:GetDistance(myHero.Position, target.Position) <= self.Q2Range then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, 180, self.Q2Delay, 0, true, self.QHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL1", CastPos, 1)
					return
				end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 and self:GetDistance(myHero.Position, target.Position) <= self.ERange then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 250, self.EDelay, 0, true, self.EHitChance, 0)
            if CastPos ~= nil then
                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
                if self:GetDistance(myHero.Position, target.Position) <= self.WRange - 50 then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
                end
            end
        end
    end
end

function Vex:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- print(myHero:GetSpellSlot(1).Cooldown)
        self.RRange = 1500 + (500 * myHero:GetSpellSlot(3).Level)
		if Engine:IsKeyDown("HK_COMBO") then
			Vex:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Vex:Harass()
		end
	end
end

function Vex:OnDraw()
	if myHero.ChampionName == "Vex" then
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, self.Q2Range ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
        end
    end
end

function Vex:OnLoad()
    if(myHero.ChampionName ~= "Vex") then return end
	AddEvent("OnSettingsSave" , function() Vex:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Vex:LoadSettings() end)


	Vex:__init()
	AddEvent("OnTick", function() Vex:OnTick() end)	
	AddEvent("OnDraw", function() Vex:OnDraw() end)	
end

AddEvent("OnLoad", function() Vex:OnLoad() end)	
