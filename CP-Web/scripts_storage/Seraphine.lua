Seraphine = {}
function Seraphine:__init()
	self.QRange = 900
	self.WRange = 800
	self.ERange = 1300
	self.RRange = 1200

	self.QSpeed = 1200
	self.WSpeed = math.huge
	self.ESpeed = 1200
	self.RSpeed = 1600

    self.QWidth = 350
    self.EWidth = 140
    self.RWidth = 320

	self.QDelay = 0.25 
	self.WDelay = 0.25
	self.EDelay = 0.25
	self.RDelay = 0.5

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

	
    self.ChampionMenu = Menu:CreateMenu("Seraphine")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW 		= self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE 		= self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR		= self.ComboMenu:AddCheckbox("UseR", 1)
    -------------------------------------------
    self.HarassMenu 	= self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ 	= self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseW 	= self.HarassMenu:AddCheckbox("UseW", 1)
    self.HarassUseE 	= self.HarassMenu:AddCheckbox("UseE", 1)
    -------------------------------------------
	--[[self.MiscMenu 		= self.ChampionMenu:AddSubMenu("Misc")
	self.MiscW 			= self.MiscMenu:AddCheckbox("Use W out of Combo", 1)
	self.MiscE 			= self.MiscMenu:AddCheckbox("Use E out of Combo", 1)
	self.MiscR 			= self.MiscMenu:AddCheckbox("Use R out of Combo", 1)
	self.MiscSelfE 		= self.MiscMenu:AddCheckbox("Use E on Self", 1)
	self.MiscSelfR 		= self.MiscMenu:AddCheckbox("Use R on Self", 1)]]
    self.MiscMenu 		= self.ChampionMenu:AddSubMenu("Misc")
	self.KSR 			= self.MiscMenu:AddCheckbox("Auto KS R", 1)
    self.EnemiesRSlider = self.MiscMenu:AddSlider("Amount of Enemies for R", 2, 1, 5, 1)
	-------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Seraphine:LoadSettings()
end

function Seraphine:SaveSettings()
	SettingsManager:CreateSettings("Seraphine")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("UseWHarass", self.HarassUseW.Value)
	SettingsManager:AddSettingsInt("UseEHarass", self.HarassUseE.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("KSR", self.KSR.Value)
    SettingsManager:AddSettingsInt("EnemiesRSlider", self.EnemiesRSlider.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Seraphine:LoadSettings()
	SettingsManager:GetSettingsFile("Seraphine")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
    -------------------------------------------------------------
    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","UseQHarass")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","UseWHarass")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","UseEHarass")
    -------------------------------------------------------------
    self.KSR.Value = SettingsManager:GetSettingsInt("Misc","KSR")
	self.EnemiesRSlider.Value = SettingsManager:GetSettingsInt("Misc","EnemiesRSlider")
    -------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")

end

function Seraphine:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Seraphine:EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end


function Seraphine:GetETarget(Range, HealthPercent)
	local LowestFriend = nil
    local HeroList = ObjectManager.HeroList
	for I, Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.IsTargetable then
			if self:GetDistance(myHero.Position,Hero.Position) < Range then
				local CurrentPercentage =  Hero.Health / Hero.MaxHealth
				if CurrentPercentage < HealthPercent then
					LowestFriend = Hero
					goto continue
				end
			end		
		end
	end	
	::continue::
	if LowestFriend ~= nil then
        local HeroList = ObjectManager.HeroList
		local MissileList = ObjectManager.MissileList
		for I, Missile in pairs(MissileList) do
			local SourceIndex 	= Missile.SourceIndex
			local Source 		= HeroList[SourceIndex]
			if Source ~= nil then
				if Source.Team ~= myHero.Team then
					local Distance = self:GetDistance(Missile.Position, LowestFriend.Position)
					if Distance < 300 then
						return LowestFriend
					end
				end
			end
		end
	end
	return nil
end

function Seraphine:FriendInRange(Range)
	local FriendCount = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.IsTargetable then
			if Seraphine:GetDistance(Hero.Position , myHero.Position) < Range then
				FriendCount = FriendCount + 1
			end
		end
	end
	return FriendCount
end

function Seraphine:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Seraphine:CheckCollisionEnemy(startPos, endPos, r)
    local herolist = ObjectManager.HeroList
    for i, Hero in pairs(herolist) do
        if self:GetDistance(myHero.Position, Hero.Position) <= 1000 then
            local distanceP1_P2 = self:GetDistance(startPos, endPos)
            local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
            local unitPos = Hero.Position
            local distanceP1_Unit = Seraphine:GetDistance(startPos,unitPos)
            if Hero.IsDead == false and Hero.IsTargetable then
                if distanceP1_Unit <= distanceP1_P2 then
                    local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
                    if Seraphine:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                        local ExtraRangeR = self:GetDistance(myHero.Position, Hero.Position)
                        return 1000 + ExtraRangeR
                    end
                end
            end
        end
    end
    return 1000
end

function Seraphine:CheckCollisionCount(startPos, endPos, r)
    local Count = 0
    local herolist = ObjectManager.HeroList
    for i, Hero in pairs(herolist) do
        if self:GetDistance(myHero.Position, Hero.Position) <= 2200 then
            local distanceP1_P2 = self:GetDistance(startPos, endPos)
            local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
            local unitPos = Hero.Position
            local distanceP1_Unit = Seraphine:GetDistance(startPos,unitPos)
            if Hero.IsDead == false and Hero.IsTargetable then
                if distanceP1_Unit <= distanceP1_P2 then
                    local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
                    if Seraphine:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                        local ExtraRangeR = self:GetDistance(myHero.Position, Hero.Position)
                        if Hero.Team ~= myHero.Team then
                            Count = Count + 1
                        end
                    end
                end
            end
        end
    end
    return Count
end

function Seraphine:UseKSR()
    if self.KSR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            local dmg = 100 + (50 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.6)
            if target.Health <= dmg then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Seraphine:RCountChecker()
    if self:FriendInRange(2000) >= 4 then 
        return 3
    else
        if self:FriendInRange(1500) == 2 or self:FriendInRange(2000) == 3 then
            return 2
        end
    end
    return 5
end

function Seraphine:Combo()
    --[[print("RCountCheker", Seraphine:RCountChecker())
    print("friendinrange", self:FriendInRange(1500))]]
    if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
        if PredPos ~= nil then
            local EnemiesCount = self:EnemiesInRange(PredPos, self.RRange)
            if self.EnemiesRSlider.Value >= EnemiesCount then
                Engine:CastSpell("HK_SPELL4", PredPos, 1)
                return
            end
        end
        local herolist = ObjectManager.HeroList
        for i, Hero in pairs(herolist) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
                local ExtendedRRange = Seraphine:CheckCollisionEnemy(myHero.Position, Hero.Position, 200)
                if self:GetDistance(Hero.Position, myHero.Position) <= ExtendedRRange then
                    if Seraphine:CheckCollisionCount(myHero.Position, Hero.Position, 250) >= Seraphine:RCountChecker() then
                        Orbwalker.ForceTarget = Hero
                        local PredPos, Target = Prediction:GetCastPos(myHero.Position, ExtendedRRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    else
                        if Hero.Health <= Hero.MaxHealth / 100 * 40 then
                            local PredPos, Target = Prediction:GetCastPos(myHero.Position, ExtendedRRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                            if PredPos ~= nil then
                                Engine:CastSpell("HK_SPELL4", PredPos, 1)
                                return
                            end
                        end
                    end
                end
            end
        end
	end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos ~= nil then
                if self:GetDistance(myHero.Position, target.Position) <= self:getAttackRange() then
                    if Orbwalker.ResetReady == 1 then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                else
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        local CCRange = 900
        if target ~= nil then
            if target.AIData.Dashing == true or target.BuffData:HasBuffOfType(BuffType.Stun) == true or target.BuffData:HasBuffOfType(BuffType.Slow) == true or target.BuffData:HasBuffOfType(BuffType.Snare) == true then
                CCRange = 1275
            else
                CCRange = 900
            end
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if PredPos ~= nil then
                if self:GetDistance(myHero.Position, target.Position) <= CCRange then
                    if self:GetDistance(myHero.Position, target.Position) <= self:getAttackRange() then
                        if Orbwalker.ResetReady == 1 then
                            Engine:CastSpell("HK_SPELL3", PredPos, 1)
                            return
                        end
                    else
                        Engine:CastSpell("HK_SPELL3", PredPos, 1)
                        return
                    end
                end
            end
        end
	end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local AllyETarget = Seraphine:GetETarget(self.ERange, 0.70)
		if AllyETarget then
			Engine:CastSpell("HK_SPELL2", nil)
		end		
	end
end

function Seraphine:Harass()
    if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target ~= nil then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos ~= nil then
                if self:GetDistance(myHero.Position, target.Position) <= self:getAttackRange() then
                    if Orbwalker.ResetReady == 1 then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                else
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
	end
	if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        local CCRange = 900
        if target ~= nil then
            if target.AIData.Dashing == true or target.BuffData:HasBuffOfType(BuffType.Stun) == true or target.BuffData:HasBuffOfType(BuffType.Slow) == true or target.BuffData:HasBuffOfType(BuffType.Snare) == true then
                CCRange = 1275
            else
                CCRange = 900
            end
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if PredPos ~= nil then
                if self:GetDistance(myHero.Position, target.Position) <= CCRange then
                    if self:GetDistance(myHero.Position, target.Position) <= self:getAttackRange() then
                        if Orbwalker.ResetReady == 1 then
                            Engine:CastSpell("HK_SPELL3", PredPos, 1)
                            return
                        end
                    else
                        Engine:CastSpell("HK_SPELL3", PredPos, 1)
                        return
                    end
                end
            end
        end
	end
	if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		local AllyETarget = Seraphine:GetETarget(self.ERange, 0.70)
		if AllyETarget then
			Engine:CastSpell("HK_SPELL2", nil)
		end		
    end
end

function Seraphine:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:UseKSR()
		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			self:Harass()
			return
		end
	end
end

function Seraphine:OnDraw()
if myHero.IsDead then return end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
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


function Seraphine:OnLoad()
    if(myHero.ChampionName ~= "Seraphine") then return end
	AddEvent("OnSettingsSave" , function() Seraphine:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Seraphine:LoadSettings() end)


	Seraphine:__init()
	AddEvent("OnTick", function() Seraphine:OnTick() end)	
	AddEvent("OnDraw", function() Seraphine:OnDraw() end)	
end

AddEvent("OnLoad", function() Seraphine:OnLoad() end)