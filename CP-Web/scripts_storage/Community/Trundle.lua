Trundle = {}

function Trundle:__init()
    self.TrundleMenu = Menu:CreateMenu("Trundle")
    self.TrundleCombo = self.TrundleMenu:AddSubMenu("Combo")
    self.TrundleCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.TrundleCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.TrundleCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.TrundleCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo = self.TrundleCombo:AddCheckbox("Use R in combo", 1)
    self.RTrundleConditionCombo = self.TrundleCombo:AddSlider("Use R below % HP and target in range", 60,1,100,1)
    self.REnemiesAround = self.TrundleCombo:AddSlider("Use R if more then x enemies around", 2,1,5,1)
    self.TrundleHarass = self.TrundleMenu:AddSubMenu("Harass")
    self.TrundleHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.TrundleHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.TrundleHarass:AddCheckbox("Use W in harass", 1)
    self.UseEHarass = self.TrundleHarass:AddCheckbox("Use E in harass", 1)
    self.TrundleMisc = self.TrundleMenu:AddSubMenu("Misc")
    self.TrundleMisc:AddLabel("Check Spells for Misc:")
    self.QLastHit = self.TrundleMisc:AddCheckbox("Use Q to lasthit", 1)
    self.TrundleDrawings = self.TrundleMenu:AddSubMenu("Drawings")
    self.DrawW = self.TrundleDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.TrundleDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.TrundleDrawings:AddCheckbox("Draw R", 1)
    Trundle:LoadSettings()
end

function Trundle:SaveSettings()
	SettingsManager:CreateSettings("Trundle")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R below % HP and target in range", self.RTrundleConditionCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies around", self.REnemiesAround.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Trundle:LoadSettings()
    SettingsManager:GetSettingsFile("Trundle")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.RTrundleConditionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R below % HP and target in range")
    self.REnemiesAround.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies around")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
end

function Trundle:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Trundle:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Trundle:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Trundle:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    for i,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Trundle:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Trundle:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Trundle:GetECastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 50
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Trundle:UseLastHitQ()
    if Engine:SpellReady("HK_SPELL1") and self.QLastHit.Value == 1 then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false then
                if Trundle:GetDistance(myHero.Position, Minion.Position) <= 400 then
                    local qDmg = 0 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.BaseAttack + myHero.BonusAttack)
                    if Minion.Health <= qDmg then
                        Engine:CastSpell("HK_SPELL1", GameHud.MousePos)
                    end
                end
            end
        end
    end
end

function Trundle:Combo() 
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then
        if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
            local trundleHPCondition = myHero.MaxHealth / 100 * self.RTrundleConditionCombo.Value
            if myHero.Health <= trundleHPCondition then
                if Trundle:GetDistance(myHero.Position, target.Position) <= Trundle:GetAttackRange() + 50 then
                    Engine:CastSpell("HK_SPELL4", target.Position)
                end
            end
            if Trundle:EnemiesInRange(myHero.Position, 500) >= self.REnemiesAround.Value then
                Engine:CastSpell("HK_SPELL4", target.Position)
            end
        end
        local CastPos = Prediction:GetCastPos(myHero.Position, 700, math.huge, 100, 0.25, 0)
		if CastPos ~= nil and self.UseECombo.Value == 1 then
            CastPos = self:GetECastPos(CastPos)
            if Trundle:GetDistance(myHero.Position, CastPos) < 700 and Engine:SpellReady("HK_SPELL3") then
                if Trundle:GetDistance(myHero.Position, target.Position) > Trundle:GetAttackRange() + 100 and Trundle:GetDistance(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL3", CastPos ,1)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
            if Trundle:GetDistance(myHero.Position, target.Position) <= Trundle:GetAttackRange() and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
            if Trundle:GetDistance(myHero.Position, target.Position) <= 500 then
                Engine:CastSpell("HK_SPELL2", myHero.Position)
                return
            end
        end
    end
end

function Trundle:Harass() 
    local target = Orbwalker:GetTarget("Harass", 1400)
    if target then
        local CastPos = Prediction:GetCastPos(myHero.Position, 700, math.huge, 100, 0.25, 0)
		if CastPos ~= nil and self.UseEHarass.Value == 1 then
            CastPos = self:GetECastPos(CastPos)
            if Trundle:GetDistance(myHero.Position, CastPos) < 700 and Engine:SpellReady("HK_SPELL3") then
                if Trundle:GetDistance(myHero.Position, target.Position) > Trundle:GetAttackRange() + 100 and Trundle:GetDistance(myHero.Position, target.Position) <= 500 then
                    Engine:CastSpell("HK_SPELL3", CastPos ,1)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.UseQHarass.Value == 1 then
            if Trundle:GetDistance(myHero.Position, target.Position) <= Trundle:GetAttackRange() and Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.UseWHarass.Value == 1 then
            if Trundle:GetDistance(myHero.Position, target.Position) <= 500 then
                Engine:CastSpell("HK_SPELL2", myHero.Position)
                return
            end
        end
    end
end

function Trundle:QDamage()
    local dmg = 0
    local qBuff = myHero.BuffData:GetBuff("TrundleTrollSmash")
    if qBuff.Valid then
        dmg = dmg + (0 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.BaseAttack + myHero.BonusAttack))
    else
        return 0
    end
    local passiveQBuff = myHero.BuffData:GetBuff("TrundleQ")
    if passiveQBuff.Valid then
        dmg = dmg + (15 + (5 * myHero:GetSpellSlot(0).Level))
    end
    return dmg
end

function Trundle:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- myHero.BuffData:ShowAllBuffs()
        Orbwalker.ExtraDamage = self:QDamage()
        if Engine:IsKeyDown("HK_COMBO") then
            Trundle:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Trundle:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Trundle:UseLastHitQ()
        end
    end
end

function Trundle:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 750,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 1000,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 650,255,0,255,255)
        end
    end
end

function Trundle:OnLoad()
    if myHero.ChampionName ~= "Trundle" then return end
    AddEvent("OnSettingsSave" , function() Trundle:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Trundle:LoadSettings() end)
    Trundle:__init()
    AddEvent("OnTick", function() Trundle:OnTick() end)
    AddEvent("OnDraw", function() Trundle:OnDraw() end)
end

AddEvent("OnLoad", function() Trundle:OnLoad() end)