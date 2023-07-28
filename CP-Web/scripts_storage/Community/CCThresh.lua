Thresh = {}
function Thresh:__init()	
	self.QRange = 1050
	self.WRange = 950
	self.ERange = 500
	self.RRange = 400

	self.QSpeed = 2000
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QDelay = 0.45 
	self.WDelay = 0.25
	self.EDelay = 0.25
	self.RDelay = 0.25


    self.ChampionMenu = Menu:CreateMenu("Thresh")
		-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.EDash = self.ComboMenu:AddCheckbox("Use E only dashes", 1)
    self.HarassUseE = self.ComboMenu:AddCheckbox("EHarass", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
		-------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)

	Thresh:LoadSettings()
end

function Thresh:SaveSettings()
	SettingsManager:CreateSettings("Thresh")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("EDash", self.EDash.Value)
    SettingsManager:AddSettingsInt("EHarass", self.HarassUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
		-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Thresh:LoadSettings()
	SettingsManager:GetSettingsFile("Thresh")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
    self.EDash.Value = SettingsManager:GetSettingsInt("Combo","EDash")
    self.HarassUseE.Value = SettingsManager:GetSettingsInt("Combo","EHarass")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
		------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end


function Thresh:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Thresh:SortToHighestAD(Table)
	local SortedTable = {}
	for _, Object in pairs(Table) do
		SortedTable[#SortedTable + 1] = Object
	end
	if #SortedTable > 1 then
		table.sort(SortedTable, function (left, right)
			return left.BaseAttack + left.BonusAttack < right.BaseAttack + right.BonusAttack
		end)
	end
	return SortedTable
end

function Thresh:GetEPullPosition(Target)
	local PlayerPos = myHero.Position
	local TargetPos = Target.Position
	local PlayerToPos = Vector3.new(PlayerPos.x - TargetPos.x,PlayerPos.y - TargetPos.y ,PlayerPos.z - TargetPos.z)
	local ECastPos = Vector3.new(PlayerPos.x + PlayerToPos.x,PlayerPos.y + PlayerToPos.y ,PlayerPos.z + PlayerToPos.z)
	return ECastPos
end

function Thresh:GetShieldTarget(Range, HealthPercent)
	local LowestFriend = nil
	local HeroList = Orbwalker:SortToLowestHealth(ObjectManager.HeroList)
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
		local MissileList = ObjectManager.MissileList
		for I, Missile in pairs(MissileList) do
			local Source 		= nil
			local SourceIndex 	= Missile.SourceIndex
			if SourceIndex > 0 and SourceIndex < 10000 then
				Source 			= ObjectManager:GetObjectByID(SourceIndex)
			end
			if Source ~= nil then
				if Source.IsMinion == false and Source.Team ~= myHero.Team then
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

function Thresh:GetLanternTarget()
	local HeroList = self:SortToHighestAD(ObjectManager.HeroList)
	for I, Hero in pairs(HeroList) do
		if Hero.Team == myHero.Team then
			if Hero.Index ~= myHero.Index then
				if Thresh:GetDistance(myHero.Position, Hero.Position) < self.WRange then
					return Hero
				end	
			end			
		end
	end
	return nil
end

function Thresh:GetECastPosition(Target, HealthPercent)
	local ShieldTarget = nil
	local HeroList = Orbwalker:SortToLowestHealth(ObjectManager.HeroList)
	for I, Hero in pairs(HeroList) do
		if Hero.Team == myHero.Team then
			if Hero.Index ~= myHero.Index then
				if Thresh:GetDistance(myHero.Position, Hero.Position) < self.WRange then
					local CurrentPercentage =  Hero.Health / Hero.MaxHealth
					if CurrentPercentage < HealthPercent then
						ShieldTarget = Hero
						goto continue
					end
				end	
			end			
		end
	end
	
	::continue::
	
	if ShieldTarget then
		local PlayerPos = myHero.Position
		local TargetPos = Target.Position
		local FriendPos = ShieldTarget.Position
		local MeFriendDistance = Thresh:GetDistance(FriendPos, PlayerPos)
		local FriendEnemyDistance = Thresh:GetDistance(FriendPos, TargetPos)
		if MeFriendDistance ~= nil and FiendEnemyDistance ~= nil then
			if MeFriendDistance > FiendEnemyDistance then 
				--Pull to Me
				local PlayerToPos = Vector3.new(PlayerPos.x - TargetPos.x,PlayerPos.y - TargetPos.y ,PlayerPos.z - TargetPos.z)
				local ECastPos = Vector3.new(PlayerPos.x + PlayerToPos.x,PlayerPos.y + PlayerToPos.y ,PlayerPos.z + PlayerToPos.z)
				return ECastPos
			else
				--PushAway from Me
				return TargetPos
			end
		end
	end
	local PlayerPos = myHero.Position
	local TargetPos = Target.Position
	local PlayerToPos = Vector3.new(PlayerPos.x - TargetPos.x,PlayerPos.y - TargetPos.y ,PlayerPos.z - TargetPos.z)
	local ECastPos = Vector3.new(PlayerPos.x + PlayerToPos.x,PlayerPos.y + PlayerToPos.y ,PlayerPos.z + PlayerToPos.z)
	return ECastPos
end

function Thresh:HitcheckQ()
	local HeroList = ObjectManager.HeroList
	for I, Hero in pairs(HeroList) do
		if Hero.Team ~= myHero.Team then
			local QBuff = Hero.BuffData:GetBuff("threshq")
			if QBuff.Valid == true then
				return true
			end
		end
	end
	return false
end

function Thresh:Combo()
	if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
		local Target = Orbwalker:GetTarget("Combo", self.RRange - 50)
		if Target ~= nil then
			local CurrentPercent = Target.Health / Target.MaxHealth
			if CurrentPercent < 0.45 then
				Engine:CastSpell("HK_SPELL4", Vector3.new())
				return
			end
		end
	end
	
	local HittedQ = myHero:GetSpellSlot(0).Info.Name == "ThreshQLeap"
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and HittedQ == false then
		local StartPos = myHero.Position
		local CastPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 80, self.QDelay, 1)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QRange then
				Engine:CastSpell("HK_SPELL1", CastPos ,1)
				return
			end
		end
	end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
		if HittedQ == true and Thresh:HitcheckQ() == true then
			local Target = Thresh:GetLanternTarget()
			if Target ~= nil then
				Engine:CastSpell("HK_SPELL2", Target.Position)
				return
			end
		else
			local Target = Thresh:GetShieldTarget(self.WRange, 0.5)
			if Target ~= nil then
				Engine:CastSpell("HK_SPELL2", Target.Position)
				return
			end
		end
	end
	if Engine:SpellReady("HK_SPELL3") then
		if self.ComboUseE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange - 75)
			if Target ~= nil then
				local CastPos = Thresh:GetECastPosition(Target, 0.4)
                if CastPos ~= nil then
                    if self.EDash.Value == 0 then
					    Engine:CastSpell("HK_SPELL3", CastPos)
                        return
                    end
                    if self.EDash.Value == 1 then
                        if Target.AIData.IsDashing == true then
                            Engine:CastSpell("HK_SPELL3", CastPos)
                            return
                        end
                    end
				end
			end
		end
	end
end

function Thresh:Harass()
	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassUseE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange - 75)
			if Target ~= nil then
				local CastPos = Thresh:GetECastPosition(Target, 0.4)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL3", CastPos)
					return
				end
			end
		end
	end
end

function Thresh:AutoQ()
    local HittedQ = myHero:GetSpellSlot(0).Info.Name == "ThreshQLeap"
    local Target = Orbwalker:GetTarget("Combo", self.QRange)
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and HittedQ == false then
		local StartPos = myHero.Position
		local CastPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 80, self.QDelay, 1)
		if CastPos ~= nil then
            if self:GetDistance(StartPos, CastPos) < self.QRange then
                if Target.AIData.IsDashing == true then
				    Engine:CastSpell("HK_SPELL1", CastPos ,1)
                    return
                end
			end
		end
    end
end

function Thresh:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        self:AutoQ()
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

function Thresh:OnDraw()
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


function Thresh:OnLoad()
    if(myHero.ChampionName ~= "Thresh") then return end
	AddEvent("OnSettingsSave" , function() Thresh:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Thresh:LoadSettings() end)


	Thresh:__init()
	AddEvent("OnTick", function() Thresh:OnTick() end)	
	AddEvent("OnDraw", function() Thresh:OnDraw() end)	
end

AddEvent("OnLoad", function() Thresh:OnLoad() end)	