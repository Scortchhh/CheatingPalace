Anivia = {}

function Anivia:__init()
    self.QRange = 1050
    self.QWidth = 220
    self.QSpeed = 950
    self.QDelay = 0.25

    self.WRange = 1000

    self.ERange = 600

    self.RRange = 750

    self.QHitChance = 0.45

    self.AniviaMenu = Menu:CreateMenu("Anivia")
    self.AniviaCombo = self.AniviaMenu:AddSubMenu("Combo")
    self.AniviaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.AniviaCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.AniviaCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.AniviaCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.AniviaCombo:AddCheckbox("Use R in combo", 1)
    self.AniviaHarass = self.AniviaMenu:AddSubMenu("Harass")
    self.AniviaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.AniviaHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.AniviaHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.AniviaHarass:AddCheckbox("Use E in harass", 1)
    self.AniviaDrawings = self.AniviaMenu:AddSubMenu("Drawings")
    self.DrawQ = self.AniviaDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.AniviaDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.AniviaDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.AniviaDrawings:AddCheckbox("Draw R", 1)
    Anivia:LoadSettings()
end

function Anivia:SaveSettings()
	SettingsManager:CreateSettings("Anivia")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
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

function Anivia:LoadSettings()
    SettingsManager:GetSettingsFile("Anivia")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
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

function Anivia:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Anivia:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Anivia:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Anivia:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Anivia:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Anivia:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Anivia:GetWCastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

local RPosition = nil
function Anivia:Combo()
    local rBuff = myHero.BuffData:GetBuff("GlacialStorm")
    if rBuff.Valid and Engine:SpellReady("HK_SPELL4") then
        if RPosition ~= nil then
            if Anivia:EnemiesInRange(RPosition, 500) <= 0 then
                Engine:CastSpell("HK_SPELL4", nil, 0)
                RPosition = nil
                return
            end
        end
    end 
    local target = Orbwalker:GetTarget("Combo", 1100)
    if target then
        local isStunned = target.BuffData:GetBuff("aniviaiced")
        if isStunned.Valid then
            if Anivia:GetDistance(myHero.Position, target.Position) <= 650 and Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
        local CastPos = self:GetWCastPos(target.Position)
		if CastPos ~= nil and self.UseWCombo.Value == 1 then
            if Anivia:GetDistance(myHero.Position, CastPos) < 900 and Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL2", CastPos ,1)
                return
            end
        end
        local rBuff = myHero.BuffData:GetBuff("GlacialStorm")
        if not rBuff.Valid then
            if Anivia:GetDistance(myHero.Position, target.Position) <= 700 and Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                RPosition = target.Position
                return
            end
        end
        local qBuff = myHero.BuffData:GetBuff("FlashFrost")
        if not qBuff.Valid and self.UseQCombo.Value == 1 then
            if Engine:SpellReady("HK_SPELL1") then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
        if qBuff.Valid and self.UseQCombo.Value == 1 then
            if Engine:SpellReady("HK_SPELL1") then
                -- check for missile and current position if within enemy radius double cast to trigger stun
            end
        end
    end
end

function Anivia:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        local CastPos = self:GetWCastPos(target.Position)
		if CastPos ~= nil and self.UseWHarass.Value == 1 then
            if Anivia:GetDistance(myHero.Position, CastPos) < 900 and Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL2", CastPos ,1)
                return
            end
        end
        local qBuff = myHero.BuffData:GetBuff("FlashFrost")
        if not qBuff.Valid then
            if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance - 0.1, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
        local isStunned = target.BuffData:GetBuff("aniviaiced")
        if isStunned.Valid then
            if Anivia:GetDistance(myHero.Position, target.Position) <= 650 and Engine:SpellReady("HK_SPELL3") and self.UseEHarass.Value == 1 then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
    end
end

function Anivia:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        local target = Orbwalker:GetTarget("Combo", 1400)
        if target then
            for i, Missile in pairs(ObjectManager.MissileList) do
                if Anivia:GetDistance(myHero.Position, Missile.Position) <= 1000 then
                    if Missile.Name == "FlashFrostSpell" then
                        if Anivia:GetDistance(Missile.Position, target.Position) <= 175 then
                            Engine:CastSpell("HK_SPELL1", nil)
                        end
                    end
                end
            end
        end
        if Engine:IsKeyDown("HK_COMBO") then
            Anivia:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Anivia:Harass()
        end
    end
end

function Anivia:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange,255,0,255,255)
        end
    end
end

function Anivia:OnLoad()
    if myHero.ChampionName ~= "Anivia" then return end
    AddEvent("OnSettingsSave" , function() Anivia:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Anivia:LoadSettings() end)
    Anivia:__init()
    AddEvent("OnTick", function() Anivia:OnTick() end)
    AddEvent("OnDraw", function() Anivia:OnDraw() end)
end

AddEvent("OnLoad", function() Anivia:OnLoad() end)