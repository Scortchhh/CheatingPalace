local Elise = {

}

function Elise:__init()

    self.WRange = 950
    self.WSpeed = 1200
    self.WWidth = 150
    self.WDelay = 0.125

    self.ERange = 1100
    self.ESpeed = 1600
    self.EWidth = 110
    self.EDelay = 0.25

    self.WHitChance = 0.35
    self.EHitChance = 0.4

    self.EliseMenu = Menu:CreateMenu("Elise")
    self.EliseCombo = self.EliseMenu:AddSubMenu("Combo")
    self.EliseCombo:AddLabel("Check Spells for Combo:")
    self.UseQHumanCombo = self.EliseCombo:AddCheckbox("Use Human Q in combo", 1)
    self.UseWHumanCombo = self.EliseCombo:AddCheckbox("Use Human W in combo", 1)
    self.UseEHumanCombo = self.EliseCombo:AddCheckbox("Use Human E in combo", 1)
    self.UseRCombo = self.EliseCombo:AddCheckbox("Use Smart R in combo", 1)
    self.UseQSpiderCombo = self.EliseCombo:AddCheckbox("Use Spider Q in combo", 1)
    self.UseQGapcloseSpiderCombo = self.EliseCombo:AddCheckbox("Use Spider Q as gapclose in combo", 1)
    self.QGapcloseSlider = self.EliseCombo:AddSlider("Minimum Range to use Q", 350,250,500,1)
    self.UseWSpiderCombo = self.EliseCombo:AddCheckbox("Use Spider W in combo", 1)
    self.UseESpiderCombo = self.EliseCombo:AddCheckbox("Use Spider E in combo", 1)
    self.EliseHarass = self.EliseMenu:AddSubMenu("Harass")
    self.EliseHarass:AddLabel("Check Spells for Harass:")
    self.UseQHumanHarass = self.EliseHarass:AddCheckbox("Use Human Q in Harass", 1)
    self.UseWHumanHarass = self.EliseHarass:AddCheckbox("Use Human W in Harass", 1)
    self.UseEHumanHarass = self.EliseHarass:AddCheckbox("Use Human E in Harass", 1)
    self.UseRHarass = self.EliseHarass:AddCheckbox("Use Smart R in Harass", 1)
    self.UseQSpiderHarass = self.EliseHarass:AddCheckbox("Use Spider Q in Harass", 1)
    self.UseQGapcloseSpiderHarass = self.EliseHarass:AddCheckbox("Use Spider Q as gapclose in Harass", 1)
    self.QGapcloseSlider = self.EliseHarass:AddSlider("Minimum Range to use Q", 350,250,500,1)
    self.UseWSpiderHarass = self.EliseHarass:AddCheckbox("Use Spider W in combo", 1)
    self.EliseClear = self.EliseMenu:AddSubMenu("Clear")
    self.EliseClear:AddLabel("Check Spells for Clear:")
    self.UseQHumanClear = self.EliseClear:AddCheckbox("Use Human Q in Clear", 1)
    self.UseWHumanClear = self.EliseClear:AddCheckbox("Use Human W in Clear", 1)
    self.UseEHumanClear = self.EliseClear:AddCheckbox("Use Human E in Clear", 1)
    self.UseRClear = self.EliseClear:AddCheckbox("Use Smart R in Clear", 1)
    self.UseQSpiderClear = self.EliseClear:AddCheckbox("Use Spider Q in Clear", 1)
    self.UseQGapcloseSpiderClear = self.EliseClear:AddCheckbox("Use Spider Q as gapclose in Clear", 1)
    self.QGapcloseSlider = self.EliseClear:AddSlider("Minimum Range to use Q", 350,250,500,1)
    self.UseWSpiderClear = self.EliseClear:AddCheckbox("Use Spider W in Clear", 1)
    self.EliseDrawings = self.EliseMenu:AddSubMenu("Drawings")
    self.DrawWHuman = self.EliseDrawings:AddCheckbox("Use Human W in drawings", 1)
    self.DrawEHuman = self.EliseDrawings:AddCheckbox("Use Human E in drawings", 1)
    self.DrawQSpider = self.EliseDrawings:AddCheckbox("Use Spider Q in drawings", 1)
    self.DrawESpider = self.EliseDrawings:AddCheckbox("Use Spider E in drawings", 1)
    Elise:LoadSettings()
end

function Elise:SaveSettings()
	SettingsManager:CreateSettings("Elise")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Human Q in combo", self.UseQHumanCombo.Value)
    SettingsManager:AddSettingsInt("Use Human W in combo", self.UseWHumanCombo.Value)
    SettingsManager:AddSettingsInt("Use Human E in combo", self.UseEHumanCombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use Spider Q in combo", self.UseQSpiderCombo.Value)
    SettingsManager:AddSettingsInt("Use Spider Q as gapclose in combo", self.UseQGapcloseSpiderCombo.Value)
    SettingsManager:AddSettingsInt("Minimum range to use Q", self.QGapcloseSlider.Value)
    SettingsManager:AddSettingsInt("Use Spider W in combo", self.UseWSpiderCombo.Value)
    SettingsManager:AddSettingsInt("Use Spider E in combo", self.UseESpiderCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Human Q in Harass", self.UseQHumanHarass.Value)
    SettingsManager:AddSettingsInt("Use Human W in Harass", self.UseWHumanHarass.Value)
    SettingsManager:AddSettingsInt("Use Human E in Harass", self.UseEHumanHarass.Value)
    SettingsManager:AddSettingsInt("Use R in Harass", self.UseRHarass.Value)
    SettingsManager:AddSettingsInt("Use Spider Q in Harass", self.UseQSpiderHarass.Value)
    SettingsManager:AddSettingsInt("Use Spider Q as gapclose in Harass", self.UseQGapcloseSpiderHarass.Value)
    SettingsManager:AddSettingsInt("Minimum range to use Q", self.QGapcloseSlider.Value)
    SettingsManager:AddSettingsInt("Use Spider W in Harass", self.UseWSpiderHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("Use Human Q in Clear", self.UseQHumanClear.Value)
    SettingsManager:AddSettingsInt("Use Human W in Clear", self.UseWHumanClear.Value)
    SettingsManager:AddSettingsInt("Use Human E in Clear", self.UseEHumanClear.Value)
    SettingsManager:AddSettingsInt("Use R in Clear", self.UseRClear.Value)
    SettingsManager:AddSettingsInt("Use Spider Q in Clear", self.UseQSpiderClear.Value)
    SettingsManager:AddSettingsInt("Use Spider Q as gapclose in Clear", self.UseQGapcloseSpiderClear.Value)
    SettingsManager:AddSettingsInt("Minimum range to use Q", self.QGapcloseSlider.Value)
    SettingsManager:AddSettingsInt("Use Spider W in Clear", self.UseWSpiderClear.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Human W in drawings", self.DrawWHuman.Value)
    SettingsManager:AddSettingsInt("Use Human E in drawings", self.DrawEHuman.Value)
    SettingsManager:AddSettingsInt("Use Spider Q in drawings", self.DrawQSpider.Value)
    SettingsManager:AddSettingsInt("Use Spider E in drawings", self.DrawESpider.Value)
end

function Elise:LoadSettings()
    SettingsManager:GetSettingsFile("Elise")
    self.UseQHumanCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Human Q in combo")
    self.UseWHumanCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Human W in combo")
    self.UseEHumanCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Human E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.UseQSpiderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Spider Q in combo")
    self.UseQGapcloseSpiderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Spider Q as gapclose in combo")
    self.QGapcloseSlider.Value = SettingsManager:GetSettingsInt("Combo", "Minimum range to use Q")
    self.UseWSpiderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Spider W in combo")
    self.UseESpiderCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Spider E in combo")
    -------------------------------------------
    self.UseQHumanHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Human Q in Harass")
    self.UseWHumanHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Human W in Harass")
    self.UseEHumanHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Human E in Harass")
    self.UseRHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use R in Harass")
    self.UseQSpiderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Spider Q in Harass")
    self.UseQGapcloseSpiderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Spider Q as gapclose in Harass")
    self.QGapcloseSlider.Value = SettingsManager:GetSettingsInt("Harass", "Minimum range to use Q")
    self.UseWSpiderHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Spider W in Harass")
    -------------------------------------------
    self.UseQHumanClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Human Q in Clear")
    self.UseWHumanClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Human W in Clear")
    self.UseEHumanClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Human E in Clear")
    self.UseRClear.Value = SettingsManager:GetSettingsInt("Clear", "Use R in Clear")
    self.UseQSpiderClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Spider Q in Clear")
    self.UseQGapcloseSpiderHarass.Value = SettingsManager:GetSettingsInt("Clear", "Use Spider Q as gapclose in Clear")
    self.QGapcloseSlider.Value = SettingsManager:GetSettingsInt("Clear", "Minimum range to use Q")
    self.UseWSpiderClear.Value = SettingsManager:GetSettingsInt("Clear", "Use Spider W in Clear")
    -------------------------------------------
    self.DrawWHuman.Value = SettingsManager:GetSettingsInt("Drawings", "Use Human W in drawings")
    self.DrawEHuman.Value = SettingsManager:GetSettingsInt("Drawings", "Use Human E in drawings")
    self.DrawQSpider.Value = SettingsManager:GetSettingsInt("Drawings", "Use Spider Q in drawings")
    self.DrawESpider.Value = SettingsManager:GetSettingsInt("Drawings", "Use Spider E in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MR)) * rawDmg end
    return 0
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for Index = 1, #HeroList do	
		local Hero = HeroList[Index]
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

function Elise:Combo()
    local isSpider = myHero.BuffData:GetBuff("EliseR")
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then
        if not isSpider.Valid then
            if Engine:SpellReady('HK_SPELL3') and self.UseEHumanCombo.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos,1)
                end
            end
            if Engine:SpellReady('HK_SPELL2') and self.UseWHumanCombo.Value == 1 then
                local targetStunned = target.BuffData:HasBuffOfType(BuffType.Stun) or target.BuffData:HasBuffOfType(BuffType.Snare) or target.BuffData:HasBuffOfType(BuffType.Asleep) or target.BuffData:HasBuffOfType(BuffType.Suppression) or target.BuffData:HasBuffOfType(BuffType.Taunt) or target.BuffData:HasBuffOfType(BuffType.Knockup)
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos ~= nil and targetStunned then
                    Engine:CastSpell("HK_SPELL2", PredPos,1)
                end
                if GetDist(myHero.Position, target.Position) <= self.ERange / 2 then
                    local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL2", PredPos,1)
                    end
                end
            end
            if Engine:SpellReady('HK_SPELL1') and self.UseQHumanCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
            if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL3') then
                    Engine:CastSpell("HK_SPELL4", nil, 0)
                end
            end
        else
            if Engine:SpellReady('HK_SPELL1') and self.UseQSpiderCombo.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL1') and self.UseQGapcloseSpiderCombo.Value == 1 then
                if GetDist(myHero.Position, target.Position) >= self.QGapcloseSlider.Value and GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end
            
            if Engine:SpellReady("HK_SPELL3") and self.UseESpiderCombo.Value == 1 then
                if GetDist(myHero.Position, target.Position) > 500 and GetDist(myHero.Position, target.Position) <= 820 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL2') and self.UseWSpiderCombo.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 then
                    Engine:CastSpell("HK_SPELL2", nil, 0)
                end
            end

            if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL2') and not Engine:SpellReady('HK_SPELL3')  then
                    Engine:CastSpell("HK_SPELL4", nil, 0)
                end
            end
            --spiderform here
        end
    end
end

function Elise:Harass()
    local isSpider = myHero.BuffData:GetBuff("EliseR")
    local target = Orbwalker:GetTarget("Harass", 900)
    if target then
        if not isSpider.Valid then
            if Engine:SpellReady('HK_SPELL3') and self.UseEHumanHarass.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos,1)
                end
            end
            if Engine:SpellReady('HK_SPELL2') and self.UseWHumanHarass.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos,1)
                end
            end
            if Engine:SpellReady('HK_SPELL1') and self.UseQHumanHarass.Value == 1 then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
            if Engine:SpellReady('HK_SPELL4') and self.UseRHarass.Value == 1 then
                if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL3') then
                    Engine:CastSpell("HK_SPELL4", nil, 0)
                end
            end
        else
            if Engine:SpellReady('HK_SPELL1') and self.UseQSpiderHarass.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL1') and self.UseQGapcloseSpiderHarass.Value == 1 then
                if GetDist(myHero.Position, target.Position) >= self.QGapcloseSlider.Value and GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL2') and self.UseWSpiderHarass.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 then
                    Engine:CastSpell("HK_SPELL2", nil, 0)
                end
            end

            if Engine:SpellReady('HK_SPELL4') and self.UseRHarass.Value == 1 then
                local WBuff = myHero.BuffData:GetBuff("EliseSpiderW")
                if not WBuff.Valid then
                    if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL2') and not Engine:SpellReady('HK_SPELL3')  then
                        Engine:CastSpell("HK_SPELL4", nil, 0)
                    end
                end
            end
            --spiderform here
        end
    end
end

function Elise:Clear()
    local isSpider = myHero.BuffData:GetBuff("EliseR")
    local target = Orbwalker:GetTarget("Laneclear", 900)
    if target then
        if not isSpider.Valid then
            if Engine:SpellReady('HK_SPELL3') and self.UseEHumanClear.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos,1)
                end
            end
            if Engine:SpellReady('HK_SPELL2') and self.UseWHumanClear.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", PredPos,1)
                end
            end
            if Engine:SpellReady('HK_SPELL1') and self.UseQHumanClear.Value == 1 then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end
            if Engine:SpellReady('HK_SPELL4') and self.UseRClear.Value == 1 then
                if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL3') then
                    Engine:CastSpell("HK_SPELL4", nil, 0)
                end
            end
        else
            if Engine:SpellReady('HK_SPELL1') and self.UseQSpiderClear.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL1') and self.UseQGapcloseSpiderClear.Value == 1 then
                if GetDist(myHero.Position, target.Position) >= self.QGapcloseSlider.Value and GetDist(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end

            if Engine:SpellReady('HK_SPELL2') and self.UseWSpiderClear.Value == 1 then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 then
                    Engine:CastSpell("HK_SPELL2", nil, 0)
                end
            end

            if Engine:SpellReady('HK_SPELL4') and self.UseRClear.Value == 1 then
                local WBuff = myHero.BuffData:GetBuff("EliseSpiderW")
                if not WBuff.Valid then
                    if not Engine:SpellReady('HK_SPELL1') and not Engine:SpellReady('HK_SPELL2') and not Engine:SpellReady('HK_SPELL3')  then
                        Engine:CastSpell("HK_SPELL4", nil, 0)
                    end
                end
            end
            --spiderform here
        end
    end
end

function Elise:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Elise:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Elise:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Elise:Clear()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- myHero.BuffData:ShowAllBuffs()
end

function Elise:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        local isSpider = myHero.BuffData:GetBuff("EliseR")
        if not isSpider.Valid then
            if Engine:SpellReady('HK_SPELL2') and self.DrawWHuman.Value == 1 then
                Render:DrawCircle(myHero.Position, 900,255,0,255,255)
            end
            if Engine:SpellReady('HK_SPELL3') and self.DrawEHuman.Value == 1 then
                Render:DrawCircle(myHero.Position, 1050,255,0,255,255)
            end
        else
            if Engine:SpellReady('HK_SPELL1') and self.DrawQSpider.Value == 1 then
                Render:DrawCircle(myHero.Position, 480,255,0,255,255)
            end
            if Engine:SpellReady('HK_SPELL3') and self.DrawESpider.Value == 1 then
                Render:DrawCircle(myHero.Position, 820,255,0,255,255)
            end
        end
    end
end

function Elise:OnLoad()
    if myHero.ChampionName ~= "Elise" then return end
    AddEvent("OnSettingsSave" , function() Elise:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Elise:LoadSettings() end)
    Elise:__init()
    AddEvent("OnDraw", function() Elise:OnDraw() end)
    AddEvent("OnTick", function() Elise:OnTick() end)
end

AddEvent("OnLoad", function() Elise:OnLoad() end)	