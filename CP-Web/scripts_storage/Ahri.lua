local Ahri = {}

function Ahri:__init()

    self.QRange = 900
    self.WRange = 550
    self.ERange = 900
    self.RRange = 500

    self.QSpeed = 1550
    self.WSpeed = math.huge
    self.ESpeed = 1550
    self.RSpeed = math.huge
    
    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0.25
    self.RDelay = 0

    self.QWidth = 200
    self.EWidth = 120

    self.QHitChance = 0.4
    self.EHitChance = 0.5

    self.AhriMenu = Menu:CreateMenu("Ahri")
    self.AhriCombo = self.AhriMenu:AddSubMenu("Combo")
    self.AhriCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.AhriCombo:AddCheckbox("UseQ in combo", 1)
    self.UseWCombo = self.AhriCombo:AddCheckbox("UseW in combo", 1)
    self.UseECombo = self.AhriCombo:AddCheckbox("UseE in combo", 1)
    self.UseRCombo = self.AhriCombo:AddCheckbox("UseR in combo", 1)
    self.AhriHarass = self.AhriMenu:AddSubMenu("Harass")
    self.AhriHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.AhriHarass:AddCheckbox("UseQ in harass", 1)
    self.UseWHarass = self.AhriHarass:AddCheckbox("UseW in harass", 1)
    self.UseEHarass = self.AhriHarass:AddCheckbox("UseE in harass", 1)
    self.AhriLaneclear = self.AhriMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear = self.AhriLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.QLaneclearSettings = self.AhriLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.AhriDrawings = self.AhriMenu:AddSubMenu("Drawings")
    self.DrawQ = self.AhriDrawings:AddCheckbox("UseQ in drawings", 1)
    self.DrawE = self.AhriDrawings:AddCheckbox("UseE in drawings", 1)
    self.DrawR = self.AhriDrawings:AddCheckbox("UseR in drawings", 1)

    Ahri:LoadSettings()
end

function Ahri:SaveSettings()
	SettingsManager:CreateSettings("Ahri")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("UseE in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseQ in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("UseE in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("UseR in drawings", self.DrawR.Value)
end

function Ahri:LoadSettings()
	SettingsManager:GetSettingsFile("Ahri")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseE in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseQ in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "UseE in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "UseR in drawings")
end

function Ahri:EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Ahri:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Ahri:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function myDot(a, b)
    return (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
end

function Ahri:GetRPos(target)
    local testFactor = 1000
    local d = Vector3.new(((myHero.Direction.x * testFactor) - myHero.Position.x) / self:GetDistance(target.Direction, myHero.Position), ((myHero.Direction.y * testFactor) - myHero.Position.y) / self:GetDistance(target.Direction, myHero.Position), ((myHero.Direction.z * testFactor) - myHero.Position.z) / self:GetDistance(target.Direction, myHero.Position)) 
    local v = Vector3.new(target.Position.x - myHero.Position.x, target.Position.y - myHero.Position.y, target.Position.z - myHero.Position.z)
    local t = myDot(v,d)
    local P = Vector3.new(myHero.Position.x + t * d.x, myHero.Position.y + t * d.y, myHero.Position.z + t * d.z)
    if self:GetDistance(myHero.Position, P) > 300 and self:GetDistance(target.Position, P) > 300 and self:GetDistance(target.Position, P) <= self.RRange * 1.3 then
        return P
    end
    return nil
end

function Ahri:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Ahri:LaneclearQ()
    if Engine:SpellReady('HK_SPELL1') then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target and Target.IsMinion and Target.MaxHealth > 8 then
            local sliderValue = self.LaneclearQMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell('HK_SPELL1', Target.Position) 
            end
        end
    end
end

function Ahri:Combo()
    local target = Orbwalker:GetTarget("Combo", self.RRange * 2.5)
    if target and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local qDmg = self:GetDamage(30 + (50 * myHero:GetSpellSlot(0).Level) + (0.7 * myHero.AbilityPower), false, target)
        local wDmg = self:GetDamage(40 + (40 * myHero:GetSpellSlot(1).Level) + (0.48 * myHero.AbilityPower), false, target)
        local eDmg = self:GetDamage(50 + (30 * myHero:GetSpellSlot(2).Level) + (0.6 * myHero.AbilityPower), false, target)
        local rDmg = self:GetDamage(30 + (30 * myHero:GetSpellSlot(3).Level) + (0.35 * myHero.AbilityPower), false, target)
        local totalDmg = qDmg + wDmg + eDmg + rDmg + rDmg
        if target.Health <= totalDmg then
            local RPos = self:GetRPos(target)
            if Ahri:EnemiesInRange(target.Position, 400) >= 3 then return end
            if myHero.BuffData:GetBuff("AhriTumble").Count_Int == 0 and not myHero.BuffData:GetBuff("AhriTumble").Valid and self:GetDistance(myHero.Position, target.Position) >= self.RRange and self:GetDistance(myHero.Position, target.Position) <= self.RRange * 2 then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                return
            end
            if RPos ~= nil and myHero.BuffData:GetBuff("AhriTumble").Count_Int == 0 and not myHero.BuffData:GetBuff("AhriTumble").Valid then
                Engine:CastSpell("HK_SPELL4", RPos, 1)
                return
            end
            if RPos ~= nil and myHero.BuffData:GetBuff("AhriTumble").Count_Int >= 1 and myHero.BuffData:GetBuff("AhriTumble").Valid then
                Engine:CastSpell("HK_SPELL4", RPos, 1)
                return
            end
            if myHero.BuffData:GetBuff("AhriTumble").Count_Int >= 1 and myHero.BuffData:GetBuff("AhriTumble").Valid and target.Health <= rDmg then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                return
            end
            -- if RPos == nil and myHero.BuffData:GetBuff("AhriTumble").Count_Int == 1 and myHero.BuffData:GetBuff("AhriTumble").Valid then
            --     Engine:CastSpell("HK_SPELL4", target.Position, 1)
            --     return
            -- end
            if RPos == nil and myHero.BuffData:GetBuff("AhriTumble").Count_Int ~= 0 and myHero.BuffData:GetBuff("AhriTumble").Valid then
                if self:GetDistance(myHero.Position, target.Position) >= self.RRange and self:GetDistance(myHero.Position, target.Position) <= self.RRange * 2 then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
    end
    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, 1, self.EHitChance, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
    end
    if target then
        if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            if target.BuffData:GetBuff("AhriSeduce").Valid or self:GetDistance(myHero.Position, target.Position) <= self.WRange then
                Engine:CastSpell("HK_SPELL2", nil, 0)
                return
            end
        end
    end
    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end 
end

function Ahri:Harass()
    if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, 1, self.EHitChance - 0.1, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL3", PredPos, 1)
        end
    end
    if self.UseWHarass.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 0, self.WDelay, 0)
        if PredPos then
            return Engine:CastSpell("HK_SPELL2", nil, 0)
        end
    end
    if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, 0, self.QHitChance - 0.1, 1)
        if PredPos then
            return Engine:CastSpell("HK_SPELL1", PredPos, 1)
        end
    end 
end

function Ahri:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        if Engine:IsKeyDown("HK_COMBO") then
            return self:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            return self:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                return self:LaneclearQ()
            end
        end
    end
end

function Ahri:OnDraw()
    if myHero.IsDead then return end
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        
        -- local testFactor = 1000
        -- local testFactorx = 1000

        -- local d = Vector3.new(((myHero.Direction.x * testFactor) - myHero.Position.x) / self:GetDistance(target.Direction, myHero.Position), ((myHero.Direction.y * testFactor) - myHero.Position.y) / self:GetDistance(target.Direction, myHero.Position), ((myHero.Direction.z * testFactor) - myHero.Position.z) / self:GetDistance(target.Direction, myHero.Position)) 
        -- local v = Vector3.new(target.Position.x - myHero.Position.x, target.Position.y - myHero.Position.y, target.Position.z - myHero.Position.z)
        -- local t = myDot(v,d)
        -- local P = Vector3.new(myHero.Position.x + t * d.x, myHero.Position.y + t * d.y, myHero.Position.z + t * d.z)
        -- -- vec3 d = (C - B) / C.distance(B);
        -- -- vec3 v = A - B;
        -- -- double t = v.dot(d);
        -- -- vec3 P = B + t * d;
        -- -- return P.distance(A);
        -- -- local perpendicularVector = Vector3.new(perpendicularX, perpendicularY, perpendicularZ)
        -- local test = Vector3.new(myHero.Position.x + (myHero.Direction.x * testFactorx), myHero.Position.y, myHero.Position.z + (myHero.Direction.z * testFactorx))
        -- Render:DrawCircle(P, 100,100,255,255,255)
        -- -- Render:DrawCircle(test, 100,255,255,255,255)
        -- local HeroScreenPos 	= Vector3.new()
		-- local TargetScreenPos 	= Vector3.new()
        -- Render:World2Screen(myHero.Position, HeroScreenPos)
        -- Render:World2Screen(test, TargetScreenPos)
        -- Render:DrawLine(HeroScreenPos, TargetScreenPos, 200,0,0,255)
    end

    if self.DrawE.Value == 1 and Engine:SpellReady('HK_SPELL3') then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then 
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if self.DrawR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Ahri:OnLoad()
    if myHero.ChampionName ~= "Ahri" then return end
    AddEvent("OnSettingsSave" , function() Ahri:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Ahri:LoadSettings() end)
    Ahri:__init()
    AddEvent("OnDraw", function() Ahri:OnDraw() end)
    AddEvent("OnTick", function() Ahri:OnTick() end)
end
AddEvent("OnLoad", function() Ahri:OnLoad() end)