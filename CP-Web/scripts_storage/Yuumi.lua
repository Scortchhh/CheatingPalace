Yuumi = {}
function Yuumi:__init()
	self.QRange = 1150
	self.WRange = 710
	self.RRange = 400

	self.QSpeed = 1600

    self.ChampionMenu = Menu:CreateMenu("Yuumi")
    -------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
    self.RTargets  = self.ComboMenu:AddSlider("Minimum R Targets", 3, 1, 5, 1)
    -------------------------------------------
    self.MiscMenu   = self.ChampionMenu:AddSubMenu("Misc")
    self.AutoAttach = self.MiscMenu:AddCheckbox("AutoAttach to Ally", 1)
    -------------------------------------------      
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)

	Yuumi:LoadSettings()
end

function Yuumi:SaveSettings()
	SettingsManager:CreateSettings("Yuumi")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("RTargets", self.RTargets.Value)
    SettingsManager:AddSettingsGroup("Misc")
	SettingsManager:AddSettingsInt("AutoAttach", self.AutoAttach.Value)
-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Yuumi:LoadSettings()
	SettingsManager:GetSettingsFile("Yuumi")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.RTargets.Value = SettingsManager:GetSettingsInt("Combo","RTargets")
	self.AutoAttach.Value = SettingsManager:GetSettingsInt("Misc","AutoAttach")
	------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end


function Yuumi:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Yuumi:EnemiesInRangeForR(Position, Range)
	local Enemies = {} --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Prediction:PointOnLineSegment(myHero.Position, Position, Hero.Position, Range) then
				Enemies[#Enemies + 1] = Hero
			end
		end
	end
	return Enemies
end

function Yuumi:GetRTarget()
	local HeroList = ObjectManager.HeroList
    for I,Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , myHero.Position) < self.RRange then
				local Enemies = self:EnemiesInRangeForR(Hero.Position, 500)
                if #Enemies >= self.RTargets.Value then
                    return Hero
                end
			end
		end
	end
    return nil
end

function Yuumi:GetShieldTarget(Range, HealthPercent)
	local LowestFriend = nil
	local HeroList = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
	for I,Hero in pairs(HeroList) do	
		if Hero.Index ~= myHero.Index and Hero.Team == myHero.Team and Hero.IsTargetable then
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

		local HeroList 		= ObjectManager.HeroList
		local TurretList 	= ObjectManager.TurretList
		local MissileList 	= ObjectManager.MissileList

		for I,Missile in pairs(MissileList) do	
			local SourceIndex 	= Missile.SourceIndex
			local Source 		= HeroList[SourceIndex]
			if Source == nil then
				Source 			= TurretList[SourceIndex]
			end

			if Source ~= nil then
				if Source.Health >= 1 and Source.Team ~= myHero.Team then
					if self:GetDistance(Missile.Position, LowestFriend.Position) < 300 then
						return LowestFriend
					end
				end
			end
		end
	end

	return nil
end

function Yuumi:GetAttachedAlly()
    local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
        if Hero.Team == myHero.Team and Hero.Index ~= myHero.Index and Hero.IsTargetable then
            if Hero.BuffData:GetBuff("YuumiWAlly").Count_Alt > 0 then
                return Hero
            end
        end
    end
    return nil
end

function Yuumi:GetAllyForAttach()
    local HeroList = Orbwalker:SortList(ObjectManager.HeroList, "LOWHP")
	for I,Hero in pairs(HeroList) do	
        if Hero.Team == myHero.Team and Hero.Index ~= myHero.Index and Hero.IsTargetable then
            if Hero.BuffData:GetBuff("YuumiWAlly").Count_Alt == 0 and self:GetDistance(myHero.Position, Hero.Position) < self.WRange then
                return Hero
            end
        end
    end
    return nil
end

function Yuumi:UsePassive()
    local Passive = myHero.BuffData:GetBuff("YuumiPMat").Count_Alt
    local Target = Orbwalker:GetTarget("Combo", Orbwalker.OrbRange)
    if Passive > 0 and Target ~= nil then
        return Engine:ReleaseSpell("HK_SPELL2", Target.Position)
    end
end

function Yuumi:GetUseHeal(LowestFriend)
	if LowestFriend ~= nil and LowestFriend.IsTargetable then
		local HeroList 		= ObjectManager.HeroList
		local TurretList 	= ObjectManager.TurretList
		local MissileList 	= ObjectManager.MissileList

		for I,Missile in pairs(MissileList) do	
			local SourceIndex 	= Missile.SourceIndex
			local Source 		= HeroList[SourceIndex]
			if Source == nil then
				Source 			= TurretList[SourceIndex]
			end

			if Source ~= nil then
				if Source.Health >= 1 and Source.Team ~= myHero.Team then
					if self:GetDistance(Missile.Position, LowestFriend.Position) < 300 then
                        local HealthPercent = LowestFriend.Health / LowestFriend.MaxHealth
                        if HealthPercent < 0.7 then
                            return true
                        end
                    end
				end
			end
		end

        local HealthPercent = LowestFriend.Health / LowestFriend.MaxHealth
        if HealthPercent < 0.5 then
            return true
        end
	end
	return false
end

function Yuumi:Combo(AttachedAlly, ShieldTarget)
    if AttachedAlly then
        self:UsePassive()
    end

    if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if AttachedAlly == nil then
            AttachedAlly = self:GetAllyForAttach()
            if AttachedAlly ~= nil then
                return Engine:CastSpell("HK_SPELL2", AttachedAlly.Position, 1) 
            end
        end
    end

    if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local RTarget = self:GetRTarget()
        if RTarget then
            return Engine:ReleaseSpell("HK_SPELL4", RTarget.Position)
        end
    end
end

function Yuumi:OnTick()

    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        local AttachedAlly = self:GetAttachedAlly()
        if self.AutoAttach.Value == 1 and AttachedAlly == nil and Engine:SpellReady("HK_SPELL2") then
            local AttachedAlly = self:GetAllyForAttach()
            if AttachedAlly ~= nil then
                return Engine:CastSpell("HK_SPELL2", AttachedAlly.Position, 1) 
            end
        end
        if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if AttachedAlly then
                if self:GetUseHeal(AttachedAlly) then
                    return Engine:ReleaseSpell("HK_SPELL3", nil)
                end
            end
        end  

		if Engine:IsKeyDown("HK_COMBO") then	
			return self:Combo(AttachedAlly, ShieldTarget)
		end
	end
end

function Yuumi:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
end



function Yuumi:OnLoad()
    if(myHero.ChampionName ~= "Yuumi") then return end
	AddEvent("OnSettingsSave" , function() Yuumi:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Yuumi:LoadSettings() end)


	Yuumi:__init()
	AddEvent("OnTick", function() Yuumi:OnTick() end)	
	AddEvent("OnDraw", function() Yuumi:OnDraw() end)	
end

AddEvent("OnLoad", function() Yuumi:OnLoad() end)	
