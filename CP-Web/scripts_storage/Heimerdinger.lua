local Heimerdinger = {
}

function Heimerdinger:__init()

    self.WRange = 1325
    self.WSpeed = 2000
    self.WWidth = 100
    self.WDelay = 0.25

    self.ERange = 970
    self.ESpeed = 1200
    self.EWidth = 135
    self.EDelay = 0.25

    self.WHitChance = 0.2
    self.EHitChance = 0.2

    self.HeimerdingerMenu = Menu:CreateMenu("Heimerdinger")
    self.HeimerdingerCombo = self.HeimerdingerMenu:AddSubMenu("Combo")
    self.HeimerdingerCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.HeimerdingerCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.HeimerdingerCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.HeimerdingerCombo:AddCheckbox("Use E in combo", 1)
    self.HeimerdingerHarass = self.HeimerdingerMenu:AddSubMenu("Harass")
    self.HeimerdingerHarass:AddLabel("Check Spells for Harass:")
    self.UseWHarass = self.HeimerdingerHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.HeimerdingerHarass:AddCheckbox("Use E in harass", 1)
    self.HeimerdingerRSettings = self.HeimerdingerMenu:AddSubMenu("R-Settings")
    self.HeimerdingerRSettings:AddLabel("R Settings")
    self.UseRWCombo = self.HeimerdingerRSettings:AddCheckbox("Use W in R mode in combo", 1)
    self.UseRQCombo = self.HeimerdingerRSettings:AddCheckbox("Use Q in R mode in combo", 1)
    self.UseRQComboSlider = self.HeimerdingerRSettings:AddSlider("Use RQ if more then x enemies around ally", 3,1,5,1)
    self.HeimerdingerDrawings = self.HeimerdingerMenu:AddSubMenu("Drawings")
    self.DrawQ = self.HeimerdingerDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW = self.HeimerdingerDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawE = self.HeimerdingerDrawings:AddCheckbox("Use E in drawings", 1)

    self.Eposition = nil
    self.Wposition = nil
    Heimerdinger:LoadSettings()
end

function Heimerdinger:SaveSettings()
	SettingsManager:CreateSettings("Heimerdinger")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("R-Settings")
    SettingsManager:AddSettingsInt("Use W in R mode in combo", self.UseRWCombo.Value)
    SettingsManager:AddSettingsInt("Use Q in R mode in combo", self.UseRQCombo.Value)
    SettingsManager:AddSettingsInt("Use RQ if more then x enemies around ally", self.UseRQComboSlider.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
end

function Heimerdinger:LoadSettings()
    SettingsManager:GetSettingsFile("Heimerdinger")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    -------------------------------------------
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.UseRWCombo.Value = SettingsManager:GetSettingsInt("R-Settings", "Use W in R mode in combo")
    self.UseRQCombo.Value = SettingsManager:GetSettingsInt("R-Settings", "Use Q in R mode in combo")
    self.UseRQComboSlider.Value = SettingsManager:GetSettingsInt("R-Settings", "Use RQ if more then x enemies around ally")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
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
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
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
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

local function getQPosition(target)
    local castPos = nil
    local StartPos = myHero.Position
    for i=0, 250, 250 do 
        for x = 0, 15 do
            if x == 0 then            
                local possibleCastPos = Vector3.new(StartPos.x, StartPos.y, StartPos.z + i) --up
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 1 then              
                local possibleCastPos  = Vector3.new(StartPos.x, StartPos.y, StartPos.z - i) --down
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 2 then               
                local possibleCastPos  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z) --left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 3 then               
                local possibleCastPos  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z) --right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 4 then               
                local possibleCastPos  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z + i) --top right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 5 then              
                local possibleCastPos  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z - i) --bottom left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 6 then              
                local possibleCastPos  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z - i) --bottom right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 7 then              
                local possibleCastPos  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z + i) --top left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end

			if x == 8 then               
                local possibleCastPos  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z + (i / 2)) --top right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 9 then             
                local possibleCastPos  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z - (i / 2)) --bottom left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 10 then              
                local possibleCastPos  = Vector3.new(StartPos.x + i, StartPos.y, StartPos.z - (i / 2)) --bottom right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 11 then              
                local possibleCastPos  = Vector3.new(StartPos.x - i, StartPos.y, StartPos.z + (i / 2)) --top left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end

			if x == 12 then       
                local possibleCastPos  = Vector3.new(StartPos.x + (i / 2), StartPos.y, StartPos.z + i) --top right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 13 then      
                local possibleCastPos  = Vector3.new(StartPos.x - (i / 2), StartPos.y, StartPos.z - i) --bottom left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 14 then   
                local possibleCastPos  = Vector3.new(StartPos.x + (i / 2), StartPos.y, StartPos.z - i) --bottom right
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
            if x == 15 then
                local possibleCastPos  = Vector3.new(StartPos.x - (i / 2), StartPos.y, StartPos.z + i) --top left
                if GetDist(myHero.Position , possibleCastPos) < GetDist(target.Position , possibleCastPos) then
                    if castPos == nil then
                        castPos = possibleCastPos
                    else
                        local castPosDist = GetDist(target.Position , castPos)
                        local possibleCastPosDist = GetDist(target.Position , possibleCastPos)
                        if possibleCastPosDist < castPosDist then
                            castPos = possibleCastPos
                        end
                    end
                end
            end
		end
    end
    return castPos
end

local function getQMinionCount()
    local count = 0
    local minionList = ObjectManager.MinionList
    for i, Minion in pairs(minionList) do
        if GetDist(myHero.Position, Minion.Position) <= 1400 then
            if Minion.ChampionName == "HeimerTYellow" then
                count = count + 1
            end
        end
    end
    return count
end

function Heimerdinger:Combo()
    local target = Orbwalker:GetTarget("Combo", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            local Qcount = getQMinionCount()
            if Qcount == 0 then
                local castPos = getQPosition(target)
                if castPos ~= nil then
                    prevQPos = castPos
                    Engine:ReleaseSpell('HK_SPELL1', castPos, 0)
                end
            end
            if not Engine:SpellReady("HK_SPELL3") then
                if Qcount <= 2 then
                    local castPos = getQPosition(target)
                    if castPos ~= nil then
                        prevQPos = castPos
                        Engine:ReleaseSpell('HK_SPELL1', castPos, 0)
                    end
                end
            end
            local qCharges = myHero:GetSpellSlot(0).Charges
            local maxECooldown = 12
            local minECooldown = 7
            local eCDR = myHero:GetSpellSlot(2).Cooldown - GameClock.Time
            local prevQPos = nil
            if eCDR > minECooldown and eCDR <= maxECooldown and Qcount <= 2 then
                local castPos = getQPosition(target)
                if castPos ~= nil then
                    prevQPos = castPos
                    Engine:ReleaseSpell('HK_SPELL1', castPos, 0)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") then
            local Qcount = getQMinionCount()
            if Qcount > 1 then
                local isStunnedByE = target.BuffData:GetBuff("Stun").Valid
                if isStunnedByE then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                    if PredPos ~= nil then
                        if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
                            Engine:CastSpell('HK_SPELL2', PredPos,1)
                            return
                        end
                    end
                end
            end
        end
        local hasUltActive = myHero.BuffData:GetBuff("HeimerdingerR")
        if hasUltActive.Valid then
            if EnemiesInRange(myHero.Position, 600) >= self.UseRQComboSlider.Value then
                Engine:CastSpell('HK_SPELL1', myHero.Position, 0)
                return
            end
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
            if PredPos ~= nil then
                local rDmg = GetDamage(308.5 + (194.5 * myHero:GetSpellSlot(1).Level) + 1.83 * myHero.AbilityPower, false, target)
                if target.Health <= rDmg then
                    if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 and not Engine:SpellReady("HK_SPELL3") then
                        self.Wposition = PredPos
                        Engine:CastSpell('HK_SPELL2', PredPos,1)
                        return
                    end
                end
            end
        else
            if GetDist(myHero.Position, target.Position) <= 900 then
                local Qcount = getQMinionCount()
                if Qcount >= 1 then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
                    if PredPos ~= nil then
                        if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
                            self.Eposition = PredPos
                            Engine:CastSpell('HK_SPELL3', PredPos,1)
                            return
                        end
                    end
                end
            end
            if GetDist(myHero.Position, target.Position) <= 1200 then
                local Qcount = getQMinionCount()
                if Qcount > 1 then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                    if PredPos ~= nil then
                        if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
                            self.Wposition = PredPos
                            Engine:CastSpell('HK_SPELL2', PredPos,1)
                            return
                        end
                    end
                end
            end
        end
    end
end

function Heimerdinger:Harass()
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        if GetDist(myHero.Position, target.Position)  <= 900 then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if PredPos ~= nil then
                if Engine:SpellReady('HK_SPELL3') and self.UseEHarass.Value == 1 then
                    Engine:CastSpell('HK_SPELL3', PredPos,1)
                end
            end
        end
        if GetDist(myHero.Position, target.Position) <= 1200 then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
            if PredPos ~= nil then
                if Engine:SpellReady('HK_SPELL2') and self.UseWHarass.Value == 1 then
                    Engine:CastSpell('HK_SPELL2', PredPos,1)
                end
            end
        end
    end
end

function Heimerdinger:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Heimerdinger:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Heimerdinger:Harass()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- target.BuffData:ShowAllBuffs()
    -- myHero.BuffData:ShowAllBuffs()
end

function Heimerdinger:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 350,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 1300,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 970,255,0,255,255)
        end
    end
    -- if self.Eposition ~= nil then
    --     Render:DrawCircle(self.Eposition, 100,255,0,255,255)
    -- end
    -- if self.Wposition ~= nil then
    --     Render:DrawCircle(self.Eposition, 100,0,255,255,255)
    -- end
end

function Heimerdinger:OnLoad()
    if myHero.ChampionName ~= "Heimerdinger" then return end
    AddEvent("OnSettingsSave" , function() Heimerdinger:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Heimerdinger:LoadSettings() end)
    Heimerdinger:__init()
    AddEvent("OnDraw", function() Heimerdinger:OnDraw() end)
    AddEvent("OnTick", function() Heimerdinger:OnTick() end)
end

AddEvent("OnLoad", function() Heimerdinger:OnLoad() end)	