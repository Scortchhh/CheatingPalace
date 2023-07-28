require("SupportLib")
RenataGlasc = {}
function RenataGlasc:__init()
	self.QRange = 900
    self.Q2Range = 275
	self.WRange = 800
	self.ERange = 800
	self.RRange = 2000

    self.QWidth = 140
	self.EWidth = 220
	self.EShieldWidth = 325
	self.RWidth = 500

	self.QSpeed = 1450
	self.WSpeed = math.huge
	self.ESpeed = 1450
	self.RSpeed = 800

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0.25
	self.RDelay = 0.75

	self.QHitChance = 0.2
	self.EHitChance = 0.2
	self.RHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("RenataGlasc")
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
	
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)
	
	RenataGlasc:LoadSettings()
end

function RenataGlasc:SaveSettings()
	SettingsManager:CreateSettings("RenataGlasc")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawW.Value)
end

function RenataGlasc:LoadSettings()
	SettingsManager:GetSettingsFile("RenataGlasc")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
end

function RenataGlasc:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function RenataGlasc:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function RenataGlasc:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do    
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end


function RenataGlasc:MinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do    
        if Minion.Team ~= myHero.Team and Minion.IsTargetable then
            if self:GetDistance(Minion.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

local q1Casted = false

function RenataGlasc:Combo()
    local Qtarget = Orbwalker:GetTarget("Combo", self.QRange)
	if Qtarget and Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 then
		local qBuff = Qtarget.BuffData:GetBuff("RenataQ").Valid
		-- might rework this entire block to only cast Q if it knows it can hit the Q2
		-- q1
		if not qBuff and not q1Casted then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL1", CastPos, 1)
				q1Casted = true
				return
			end
		else
			--q2
			local HeroList = ObjectManager.HeroList
			for i, Hero in pairs(HeroList) do    
				if Hero.Team ~= myHero.Team and Hero.IsTargetable then
					if self:GetDistance(Hero.Position , Qtarget.Position) <= self.Q2Range + Qtarget.CharData.BoundingRadius then
						if Hero.ChampionName ~= Qtarget.ChampionName then
							Engine:CastSpell("HK_SPELL1", Hero.Position, 0)
							q1Casted = false
							return
						end
					end
					-- if this doesn't work then just add the logic to Q1 calculate if paths may intersect and then do full combo
					if self:GetDistance(Hero.AIData.TargetPos , Qtarget.Position) <= self.Q2Range + Qtarget.CharData.BoundingRadius + 100 then
						if Hero.ChampionName ~= Qtarget.ChampionName then
							Engine:CastSpell("HK_SPELL1", Hero.Position, 0)
							q1Casted = false
							return
						end
					end
				end
			end
			if qBuff then
				Engine:CastSpell("HK_SPELL1", myHero.Position, 0)
				q1Casted = false
				return
			end
		end
	end
	-- generic combo usage for e
    local Etarget = Orbwalker:GetTarget("Combo", self.ERange)
	if Etarget and Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL1") and not q1Casted and self.ComboUseE.Value == 1 then
		local enemiesAround = self:EnemiesInRange(Etarget.Position, self.EWidth * 0.9)
		if enemiesAround >= 2 then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL3", CastPos, 1)
				return
			end
		end
	end
	-- use if enemy running away
	if Etarget and Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 then
		if self:GetDistance(myHero.Position, Etarget.Position) < self:GetDistance(myHero.Position, Etarget.AIData.TargetPos) then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL3", CastPos, 1)
				return
			end
		end
	end
	-- ally shield
	if Etarget and Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 then
		local HeroList = ObjectManager.HeroList
		for i, Hero in pairs(HeroList) do    
			if Hero.Team == myHero.Team and Hero.IsTargetable and Hero.ChampionName ~= myHero.ChampionName then
				if self:GetDistance(Hero.Position , myHero.Position) < self.EWidth then
					local percentHealthThreshold = Hero.MaxHealth / 100 * 100
					if Hero.Health <= percentHealthThreshold then
						Engine:CastSpell("HK_SPELL3", Etarget.Position, 1)
						return
					end
				end
			end
		end
	end
	if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
		local HeroList = ObjectManager.HeroList
		for i, Hero in pairs(HeroList) do    
			if Hero.Team == myHero.Team and Hero.IsTargetable then
				if self:GetDistance(Hero.Position , myHero.Position) < self.WRange then
					local percentHealthThreshold = Hero.MaxHealth / 100 * 7.5
					if Hero.Health <= percentHealthThreshold then
						Engine:CastSpell("HK_SPELL2", Hero.Position, 1)
						return
					end
				end
			end
		end
	end

	if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
		local Target = SupportLib:GetBuffTarget(self.WRange)
		if Target then
			return Engine:CastSpell("HK_SPELL2", Target.Position, 1)
		end
	end

	if Engine:SpellReady("HK_SPELL4") and not Engine:SpellReady("HK_SPELL1") and not q1Casted and self.ComboUseR.Value == 1 then
		local Rtarget = Orbwalker:GetTarget("Combo", self.RRange)
		if Rtarget then
			local count = self:EnemiesInRange(Rtarget.Position, self.RWidth)
			if count >= 2 then
				local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL4", CastPos, 1)
					return
				end
			end
		end
	end
	
end

function RenataGlasc:Harass()
    local Qtarget = Orbwalker:GetTarget("Combo", self.QRange)
	if Qtarget and Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 then
		local qBuff = Qtarget.BuffData:GetBuff("RenataQ").Valid
		-- might rework this entire block to only cast Q if it knows it can hit the Q2
		-- q1
		if not qBuff and not q1Casted then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL1", CastPos, 1)
				q1Casted = true
				return
			end
		else
			--q2
			local HeroList = ObjectManager.HeroList
			for i, Hero in pairs(HeroList) do    
				if Hero.Team ~= myHero.Team and Hero.IsTargetable then
					if self:GetDistance(Hero.Position , Qtarget.Position) <= self.Q2Range + Qtarget.CharData.BoundingRadius then
						if Hero.ChampionName ~= Qtarget.ChampionName then
							Engine:CastSpell("HK_SPELL1", Hero.Position, 0)
							q1Casted = false
							return
						end
					end
					if self:GetDistance(Hero.AIData.TargetPos , Qtarget.Position) <= self.Q2Range + Qtarget.CharData.BoundingRadius + 100 then
						if Hero.ChampionName ~= Qtarget.ChampionName then
							Engine:CastSpell("HK_SPELL1", Hero.Position, 0)
							q1Casted = false
							return
						end
					end
				end
			end
			if qBuff then
				Engine:CastSpell("HK_SPELL1", myHero.Position, 0)
				q1Casted = false
				return
			end
		end
	end
	-- generic combo usage for e
    local Etarget = Orbwalker:GetTarget("Combo", self.ERange)
	if Etarget and Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL1") and not q1Casted and self.HarassUseE.Value == 1 then
		local enemiesAround = self:EnemiesInRange(Etarget.Position, self.EWidth * 0.9)
		if enemiesAround >= 2 then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL3", CastPos, 1)
				return
			end
		end
	end
	-- use if enemy running away
	if Etarget and Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 then
		if self:GetDistance(myHero.Position, Etarget.Position) < self:GetDistance(myHero.Position, Etarget.AIData.TargetPos) then
			local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 1, true, self.EHitChance, 1)
			if CastPos ~= nil then
				Engine:CastSpell("HK_SPELL3", CastPos, 1)
				return
			end
		end
	end
	-- ally shield
	if Etarget and Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 then
		local HeroList = ObjectManager.HeroList
		for i, Hero in pairs(HeroList) do    
			if Hero.Team == myHero.Team and Hero.IsTargetable and Hero.ChampionName ~= myHero.ChampionName then
				if self:GetDistance(Hero.Position , myHero.Position) < self.EWidth then
					local percentHealthThreshold = Hero.MaxHealth / 100 * 100
					if Hero.Health <= percentHealthThreshold then
						Engine:CastSpell("HK_SPELL3", Etarget.Position, 1)
						return
					end
				end
			end
		end
	end
	if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
		local HeroList = ObjectManager.HeroList
		for i, Hero in pairs(HeroList) do    
			if Hero.Team == myHero.Team and Hero.IsTargetable then
				if self:GetDistance(Hero.Position , myHero.Position) < self.WRange then
					local percentHealthThreshold = Hero.MaxHealth / 100 * 7.5
					if Hero.Health <= percentHealthThreshold then
						Engine:CastSpell("HK_SPELL2", Hero.Position, 1)
						return
					end
				end
			end
		end
	end

	if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
		local Target = SupportLib:GetBuffTarget(self.WRange)
		if Target then
			return Engine:CastSpell("HK_SPELL2", Target.Position, 1)
		end
	end
end

function RenataGlasc:Laneclear()

end

function RenataGlasc:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		-- myHero.BuffData:ShowAllBuffs()
		-- local Qtarget = Orbwalker:GetTarget("Combo", self.QRange)
		-- if Qtarget then
		-- 	Qtarget.BuffData:ShowAllBuffs()
		-- 	local qBuff = Qtarget.BuffData:GetBuff("RenataQ").Valid
		-- 	print(qBuff)
		-- end
		if Engine:IsKeyDown("HK_COMBO") and Orbwalker.Attack == 0 then
			RenataGlasc:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") and Orbwalker.Attack == 0 then
			RenataGlasc:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") and Orbwalker.Attack == 0 then
			RenataGlasc:Laneclear()
			return
		end
	end
end

function RenataGlasc:OnDraw()
	if  Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
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



function RenataGlasc:OnLoad()
    if(myHero.ChampionName ~= "Renata") then return end
	AddEvent("OnSettingsSave" , function() RenataGlasc:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() RenataGlasc:LoadSettings() end)


	RenataGlasc:__init()
	AddEvent("OnTick", function() RenataGlasc:OnTick() end)	
	AddEvent("OnDraw", function() RenataGlasc:OnDraw() end)	
end

AddEvent("OnLoad", function() RenataGlasc:OnLoad() end)	
