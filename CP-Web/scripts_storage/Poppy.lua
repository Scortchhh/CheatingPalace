Poppy = {}

function Poppy:__init()

    self.QRange = 460
    self.QSpeed = math.huge
    self.QWidth = 160
    self.QDelay = 0.25

    self.QHitChance = 0.2

    self.PoppyMenu = Menu:CreateMenu("Poppy")
    self.PoppyCombo = self.PoppyMenu:AddSubMenu("Combo")
    self.PoppyCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.PoppyCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.PoppyCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.PoppyCombo:AddCheckbox("Use E in combo", 1)
    self.PoppyHarass = self.PoppyMenu:AddSubMenu("Harass")
    self.PoppyHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.PoppyHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.PoppyHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.PoppyHarass:AddCheckbox("Use E in harass", 1)
    self.PoppyDrawings = self.PoppyMenu:AddSubMenu("Drawings")
    self.DrawQ = self.PoppyDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.PoppyDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.PoppyDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.PoppyDrawings:AddCheckbox("Draw R", 1)
    Poppy:LoadSettings()
end

function Poppy:SaveSettings()
	SettingsManager:CreateSettings("Poppy")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Poppy:LoadSettings()
    SettingsManager:GetSettingsFile("Poppy")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Poppy:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Poppy:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Poppy:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Poppy:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Poppy:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Poppy:CheckCollision(startPos, endPos, r)
    local target = Orbwalker:GetTarget("Combo", 1000)
    if target then
        local distanceP1_P2 = Poppy:GetDistance(startPos,endPos)
        local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
        local unitPos = myHero.Position
        local distanceP1_Unit = Poppy:GetDistance(startPos,unitPos)
        if distanceP1_Unit <= distanceP1_P2 then
            local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
            if Poppy:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                return true
            end
        end
        return false
    else
        return false
    end
end

function Poppy:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Poppy:StunCheck(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	for i = 25, 425 , 25 do
		local EndPos = Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
		if Engine:IsNotWall(EndPos) == false then
			return true
		end
	end
	return false
end

function Poppy:Combo() 
    local target = Orbwalker:GetTarget("Combo", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
            if Poppy:GetDistance(myHero.Position, target.Position) <= 330 then
                if self:StunCheck(target) == true then
                    Engine:CastSpell("HK_SPELL3", target.Position ,1)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            if Poppy:GetDistance(myHero.Position, target.Position) <= 330 then
                local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", castPos ,1)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            for i,Hero in pairs(ObjectManager.HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                    if Poppy:GetDistance(myHero.Position, Hero.Position) <= 400 then
                        if Hero.AIData.Dashing == true then
                            Engine:CastSpell("HK_SPELL2", Hero.AIData.CurrentPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Poppy:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        if Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
            if Poppy:GetDistance(myHero.Position, target.Position) <= 330 then
                if self:StunCheck(target) == true then
                    Engine:CastSpell("HK_SPELL3", target.Position ,1)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Poppy:GetDistance(myHero.Position, target.Position) <= 330 then
                local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", castPos ,1)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            for i,Hero in pairs(ObjectManager.HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                    if Poppy:GetDistance(myHero.Position, Hero.Position) <= 400 then
                        if Hero.AIData.Dashing == true then
                            Engine:CastSpell("HK_SPELL2", Hero.AIData.CurrentPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Poppy:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        -- Poppy:CastingR()
        if Engine:IsKeyDown("HK_COMBO") then
            Poppy:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Poppy:Harass()
        end
    end
end

function Poppy:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 420,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 400,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 530,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 1170,255,0,255,255)
        end
    end
end

function Poppy:OnLoad()
    if myHero.ChampionName ~= "Poppy" then return end
    AddEvent("OnSettingsSave" , function() Poppy:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Poppy:LoadSettings() end)
    Poppy:__init()
    AddEvent("OnTick", function() Poppy:OnTick() end)
    AddEvent("OnDraw", function() Poppy:OnDraw() end)
end

AddEvent("OnLoad", function() Poppy:OnLoad() end)