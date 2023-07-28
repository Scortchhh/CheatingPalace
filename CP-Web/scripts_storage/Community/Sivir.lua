Sivir = {}

function Sivir:__init()
    self.SivirMenu = Menu:CreateMenu("Sivir")
    self.SivirCombo = self.SivirMenu:AddSubMenu("Combo")
    self.SivirCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.SivirCombo:AddCheckbox("Use Q in combo", 1)
    self.SivirHarass = self.SivirMenu:AddSubMenu("Harass")
    self.SivirHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.SivirHarass:AddCheckbox("Use Q in harass", 1)
    self.SivirWaveClear = self.SivirMenu:AddSubMenu("WaveClear")
    self.SivirWaveClear:AddLabel("Check Spells for WaveClear:")
    self.UseWWaveClear = self.SivirWaveClear:AddCheckbox("Use W in waveclear if target close to minions", 1)
    self.SivirMisc = self.SivirMenu:AddSubMenu("Misc")
    self.SivirMisc:AddLabel("Check Spells for Misc:")
    self.UseEDodgeOnSpells = self.SivirMisc:AddCheckbox("Use E on spells", 1)
    self.SivirDrawings = self.SivirMenu:AddSubMenu("Drawings")
    self.DrawQ = self.SivirDrawings:AddCheckbox("Draw Q", 1)
    self.DrawR = self.SivirDrawings:AddCheckbox("Draw R", 1)
    Sivir:LoadSettings()
end

function Sivir:SaveSettings()
	SettingsManager:CreateSettings("Sivir")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Use E on spells", self.UseEDodgeOnSpells.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("WaveClear")
    SettingsManager:AddSettingsInt("Use W in waveclear if target close to minions", self.UseWWaveClear.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Sivir:LoadSettings()
    SettingsManager:GetSettingsFile("Sivir")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    -------------------------------------------
    self.UseEDodgeOnSpells.Value = SettingsManager:GetSettingsInt("Misc", "Use E on spells")
    -------------------------------------------
    self.UseWWaveClear.Value = SettingsManager:GetSettingsInt("WaveClear", "Use W in waveclear if target close to minions")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Sivir:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Sivir:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Sivir:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Sivir:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Sivir:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Sivir:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = Sivir:GetDistance(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = Sivir:GetDistance(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if Sivir:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

function Sivir:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end


function Sivir:Combo() 
    local target = Orbwalker:GetTarget("Combo", 1200)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            if Sivir:GetDistance(myHero.Position, target.Position) <= 1100 then
                local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1200, 140, 0.25, 0)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", castPos, 1)
                end
            end
        end
    end
end

function Sivir:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Sivir:GetDistance(myHero.Position, target.Position) <= 1100 then
                local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1200, 140, 0.25, 0)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", castPos, 1)
                end
            end
        end
    end
end

function Sivir:UseW()
    if Engine:SpellReady("HK_SPELL2") and self.UseWWaveClear.Value == 1 then
        for i, Minion in pairs(ObjectManager.MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.IsTargetable then
                if Sivir:EnemiesInRange(Minion.Position, 400) >= 1 and Sivir:GetDistance(myHero.Position, Minion.Position) <= Sivir:GetAttackRange() then
                    Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
                end
            end
        end
    end
end

function Sivir:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        local Missiles = ObjectManager.MissileList
        for I, Missile in pairs(Missiles) do
            if Missile.Team ~= myHero.Team then 
                local Info = Awareness.Spells[Missile.Name]
                if Info ~= nil and Info.Type == 0 then
                    if Sivir:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius) then
                        if Engine:SpellReady("HK_SPELL3") and self.UseEDodgeOnSpells.Value == 1 then
                            Engine:CastSpell("HK_SPELL3",  Vector3.new())
                        end
                    end
                end
            end
        end
        if Engine:IsKeyDown("HK_COMBO") then
            Sivir:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sivir:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sivir:UseW()
        end
    end
end

function Sivir:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 1200,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 1000,255,0,255,255)
        end
    end
end

function Sivir:OnLoad()
    if myHero.ChampionName ~= "Sivir" then return end
    AddEvent("OnSettingsSave" , function() Sivir:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sivir:LoadSettings() end)
    Sivir:__init()
    AddEvent("OnTick", function() Sivir:OnTick() end)
    AddEvent("OnDraw", function() Sivir:OnDraw() end)
end

AddEvent("OnLoad", function() Sivir:OnLoad() end)