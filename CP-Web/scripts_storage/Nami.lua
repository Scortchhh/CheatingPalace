Nami = {
	SelectedAlly = {team},
}
function Nami:__init()
	self.QRange = 875
	self.WRange = 725
	self.ERange = 800
	self.RRange = 2750

	self.QSpeed = math.huge
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = 850

    self.QWidth = 200

	self.QDelay = 0.95 
	self.WDelay = 0.25
	self.EDelay = 0
	self.RDelay = 0.5

    self.QHitChance = 0.2

	
    self.ChampionMenu = Menu:CreateMenu("Nami")
	-------------------------------------------
    self.ComboMenu 		= self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ 		= self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW 		= self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE 		= self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR		= self.ComboMenu:AddCheckbox("UseR", 1)
	-------------------------------------------
    self.HarassMenu 		= self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseW 		= self.HarassMenu:AddCheckbox("UseW", 1)
    self.HarassUseE 		= self.HarassMenu:AddCheckbox("UseE", 1)
    self.HarassUseR		    = self.HarassMenu:AddCheckbox("UseR", 1)
    -------------------------------------------
	self.MiscMenu 		= self.ChampionMenu:AddSubMenu("Misc")
	self.MiscQ 			= self.MiscMenu:AddCheckbox("Use Auto Q", 1)
    self.MS             = self.MiscMenu:AddSlider("Enemy MS to use Q", 250, 5, 400, 1)
    self.Delay          = self.MiscMenu:AddSlider("Spell Delay/100 to use Q", 30, 5, 300, 1)
    self.RRangeSlider    = self.MiscMenu:AddSlider("Range to use R", 2000, 100, 2750, 50)
	-------------------------------------------
	self.TargetSelector         = self.ChampionMenu:AddSubMenu("Force E selected allies")
	-------------------------------------------
	self.DrawMenu 		= self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ 			= self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW 			= self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE 			= self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR 			= self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Nami:LoadSettings()
end

function Nami:SaveSettings()
	SettingsManager:CreateSettings("Nami")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HUseW", self.HarassUseW.Value)
	SettingsManager:AddSettingsInt("HUseE", self.HarassUseE.Value)
	SettingsManager:AddSettingsInt("HUseR", self.HarassUseR.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("UseAutoQ", self.MiscQ.Value)
    SettingsManager:AddSettingsInt("MS", self.MS.Value)
    SettingsManager:AddSettingsInt("Delay", self.Delay.Value)
    SettingsManager:AddSettingsInt("RRangeSlider", self.RRangeSlider.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Nami:LoadSettings()
	SettingsManager:GetSettingsFile("Nami")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	-------------------------------------------------------------
    self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","HUseW")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","HUseE")
	self.HarassUseR.Value = SettingsManager:GetSettingsInt("Harass","HUseR")
    -------------------------------------------------------------
	self.MiscQ.Value 			    = SettingsManager:GetSettingsInt("Misc","UseAutoQ")
    self.MS.Value 		            = SettingsManager:GetSettingsInt("Misc","MS")
    self.Delay.Value 		        = SettingsManager:GetSettingsInt("Misc","Delay")
    self.RRangeSlider.Value 		= SettingsManager:GetSettingsInt("Misc","RRangeSlider")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")

end

function Nami:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Nami:EnemiesInRange(Position, Range)
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

function Nami:FriendInRange(Range)
	local FriendCount = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.IsTargetable then
			if Nami:GetDistance(Hero.Position , myHero.Position) < Range then
				FriendCount = FriendCount + 1
				if FriendCount > 1 then
					return true
				end
			end
		end
	end
	return false
end

function Nami:FriendInRange2(Range, Target)
	local FriendCount = 0 --FeelsBadMan
	local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , Target) < Range then
				FriendCount = FriendCount + 1
			end
		end
	end
	return FriendCount
end

function Nami:CheckCollisionCount(startPos, endPos, r)
    local Count = 0
    local herolist = ObjectManager.HeroList
    for i, Hero in pairs(herolist) do
        if self:GetDistance(myHero.Position, Hero.Position) <= 2200 then
            local distanceP1_P2 = self:GetDistance(startPos, endPos)
            local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
            local unitPos = Hero.Position
            local distanceP1_Unit = self:GetDistance(startPos,unitPos)
            if Hero.IsDead == false and Hero.IsTargetable then
                if distanceP1_Unit <= distanceP1_P2 then
                    local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
                    if self:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
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

function Nami:RCountChecker(Target)
    if self:FriendInRange2(2000, Target) >= 4 then 
        return 3
    else
        if self:FriendInRange2(1500, Target) == 2 or self:FriendInRange2(2000, Target) == 3 then
            return 2
        end
    end
    return 5
end

function Nami:ETarget(Range)
    --Ranged
    local HeroList 		= ObjectManager.HeroList
	local MissileList 	= ObjectManager.MissileList

	for I, Missile in pairs(MissileList) do	
		local SourceIndex = Missile.SourceIndex
		local TargetIndex = Missile.TargetIndex
		local Source = HeroList[SourceIndex]
		local Target = HeroList[TargetIndex]  

        if Source and Source.IsTargetable then
            if Nami:GetDistance(Source.Position, myHero.Position) < Range and Source.Team == myHero.Team then
                if Target and Target.Team ~= myHero.Team then
                    return Source
                end
            end
        end	
    end
    --Melee
	for I,Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.AttackRange < 350 and Hero.IsTargetable then
			if Nami:GetDistance(myHero.Position, Hero.Position) < Range then
				local EnemyCount = self:EnemiesInRange(Hero.Position,350)
				if EnemyCount > 0 then
					if Hero.ActiveSpell.IsAutoAttack then
						return Hero
					end	
				end
			end
		end
	end
    return nil
end
function Nami:EAllyCount(ExtraRange)
    local HeroList = ObjectManager.HeroList
    local FCount = 0
    for k, Ally in pairs(HeroList) do
        if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
            local TickOnAlly = self.SelectedAlly[Ally.Index].Value
            if TickOnAlly == 1 then
                if Nami:GetDistance(Ally.Position, myHero.Position) < self.ERange - 15 then
                    if self:EnemiesInRange(Ally.Position, (Ally.AttackRange + Ally.CharData.BoundingRadius + ExtraRange)) > 0 or Nami:ETarget(self.ERange) ~= nil then
                        if Ally.Index ~= myHero.Index then
                            FCount = FCount + 1
                        end
                    end
                end
            end
        end
    end
    return FCount
end
function Nami:AllyHealingW()
    local Healing = 35 + 25 * myHero:GetSpellSlot(1).Level + myHero.AbilityPower * 0.3
    return Healing
end

function Nami:Ultimate()
    if Engine:SpellReady("HK_SPELL4") then
        --print('Check1')
        local herolist = ObjectManager.HeroList
        for i, Hero in pairs(herolist) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
                if self:GetDistance(Hero.Position, myHero.Position) <= self.RRangeSlider.Value then
                    --print('Check2')
                    local PredPos, _ = Prediction:GetPredictionPosition(Hero, myHero.Position, self.RSpeed, self.RDelay, 0, 0)
                    if PredPos then
                        --print('Check3')
                        if Nami:CheckCollisionCount(PredPos, myHero.Position, 390) > Nami:RCountChecker(PredPos) then
                            print('Check4')
                            Engine:ReleaseSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
	end 
end

function Nami:Combo()
    if self.ComboUseR.Value == 1 then
        Nami:Ultimate()
    end
	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local StartPos 			= myHero.Position
        local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
        if CastPos ~= nil and Target ~= nil then
            if Target.AIData.Dashing == false or Target.BuffData:HasBuffOfType(BuffType.Stun) == false or Target.BuffData:HasBuffOfType(BuffType.Slow) == false or Target.BuffData:HasBuffOfType(BuffType.Snare) == false then
                if self:GetDistance(StartPos, CastPos) < self.QRange then
                    Engine:ReleaseSpell("HK_SPELL1", CastPos ,1)
                    return
                end
            end
        end
	end
    if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local WHeal = self:AllyHealingW()
		local HeroList = ObjectManager.HeroList
	    for I,Hero in pairs(HeroList) do	
            if Hero.Team == myHero.Team and Hero.IsTargetable and self:GetDistance(myHero.Position, Hero.Position) < self.WRange - 30 then
                if Hero.MaxHealth - Hero.Health > WHeal then
                    if self:EnemiesInRange(Hero.Position, self.WRange - 75) > 0 then
                        Engine:ReleaseSpell("HK_SPELL2", Hero.Position)
                        return
                    end
                else
                    if Hero.MaxHealth - Hero.Health > (WHeal * 0.6) then
                        if self:EnemiesInRange(Hero.Position, self.WRange - 75) > 1 then
                            Engine:ReleaseSpell("HK_SPELL2", Hero.Position)
                            return
                        end
                    end
                end
            end
        end
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if myHero.MaxHealth - myHero.Health > (WHeal * 0.85) then
            if Target then
                Engine:ReleaseSpell("HK_SPELL2", Target.Position, 1)
            end
        else
            if Target then
                if self:EnemiesInRange(myHero.Position, self.WRange - 75) > 1 then
                    Engine:ReleaseSpell("HK_SPELL2", Target.Position, 1)
                end
            end
        end
	end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local AttackingFriend = Nami:ETarget(self.ERange)
        local HeroList = ObjectManager.HeroList
        local FCount = Nami:EAllyCount(200)
        --print(FCount)
        for k, Ally in pairs(HeroList) do
            if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
                local TickOnAlly = self.SelectedAlly[Ally.Index].Value
                if TickOnAlly == 1 then
                    if Nami:GetDistance(Ally.Position, myHero.Position) < self.ERange -15 then
                        --if self:EnemiesInRange(Ally.Position, (Ally.AttackRange + Ally.CharData.BoundingRadius + 150)) > 0 then
                            
                            if FCount > 0 then
                                if AttackingFriend and AttackingFriend.Index ~= myHero.Index then
                                    if AttackingFriend == Ally then
                                        Engine:ReleaseSpell("HK_SPELL3", AttackingFriend.Position)
                                        return
                                    end
                                end
                            else
                                if AttackingFriend and AttackingFriend.Index == myHero.Index then
                                    if AttackingFriend == Ally then
                                        Engine:ReleaseSpell("HK_SPELL3", myHero.Position)
                                        return
                                    end
                                end
                            end
                        --end	
                    end
                end
            end
        end
	end
end

function Nami:Harass() 
    if self.HarassUseR.Value == 1 then
        Nami:Ultimate()
    end
    if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local WHeal = self:AllyHealingW()
		local HeroList = ObjectManager.HeroList
	    for I,Hero in pairs(HeroList) do	
            if Hero.Team == myHero.Team and Hero.IsTargetable and self:GetDistance(myHero.Position, Hero.Position) < self.WRange - 30 then
                if Hero.MaxHealth - Hero.Health > WHeal then
                    if self:EnemiesInRange(Hero.Position, self.WRange - 75) > 0 then
                        Engine:ReleaseSpell("HK_SPELL2", Hero.Position)
                        return
                    end
                else
                    if Hero.MaxHealth - Hero.Health > (WHeal * 0.6) then
                        if self:EnemiesInRange(Hero.Position, self.WRange - 75) > 1 then
                            Engine:ReleaseSpell("HK_SPELL2", Hero.Position)
                            return
                        end
                    end
                end
            end
        end
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if myHero.MaxHealth - myHero.Health > (WHeal * 0.85) then
            if Target then
                Engine:ReleaseSpell("HK_SPELL2", Target.Position, 1)
            end
        else
            if Target then
                if self:EnemiesInRange(myHero.Position, self.WRange - 75) > 1 then
                    Engine:ReleaseSpell("HK_SPELL2", Target.Position, 1)
                end
            end
        end
	end
	if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local AttackingFriend = Nami:ETarget(self.ERange)
        local HeroList = ObjectManager.HeroList
        local FCount = Nami:EAllyCount(200)
        --print(FCount)
        for k, Ally in pairs(HeroList) do
            if Ally.Team == myHero.Team and not Ally.IsDead and Ally.IsTargetable then
                local TickOnAlly = self.SelectedAlly[Ally.Index].Value
                if TickOnAlly == 1 then
                    if Nami:GetDistance(Ally.Position, myHero.Position) < self.ERange -15 then
                        --if self:EnemiesInRange(Ally.Position, (Ally.AttackRange + Ally.CharData.BoundingRadius + 150)) > 0 then
                            
                            if FCount > 0 then
                                if AttackingFriend and AttackingFriend.Index ~= myHero.Index then
                                    if AttackingFriend == Ally then
                                        Engine:ReleaseSpell("HK_SPELL3", AttackingFriend.Position)
                                        return
                                    end
                                end
                            else
                                if AttackingFriend and AttackingFriend.Index == myHero.Index then
                                    if AttackingFriend == Ally then
                                        Engine:ReleaseSpell("HK_SPELL3", myHero.Position)
                                        return
                                    end
                                end
                            end
                        --end	
                    end
                end
            end
        end
	end
end

--ASSETS/Perks/Styles/Precision/LethalTempo/LethalTempoEmpowered.lua
function Nami:Misc()
    local StartPos 			= myHero.Position
    --local CastPos, Target 	= Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 80, self.QDelay, 0)
    local HeroList = ObjectManager.HeroList
    for k, Target in pairs(HeroList) do
        if Target and Target.Team ~= myHero.Team and not Target.IsDead and Target.IsTargetable then
            --print('2')
            --print(Target.Name)
            if Target.MovementSpeed <= self.MS.Value and Target.ActiveSpell.Info.Name ~= "" then
                --print('Should Slow Q')
                --print(Target.MovementSpeed)
            end
            local CastPos, _ = Prediction:GetPredictionPosition(Target, StartPos, self.QSpeed, self.QDelay, 80, 0)
            if CastPos and Nami:GetDistance(myHero.Position, CastPos) < self.QRange then
                --print('3')
                if (Target.AIData.Dashing == true and Target.ChampionName ~= "Kalista") or Target.BuffData:HasBuffOfType(BuffType.Stun) == true or Target.BuffData:HasBuffOfType(BuffType.Snare) == true or Target.BuffData:HasBuffOfType(BuffType.Suppression) == true or Target.BuffData:HasBuffOfType(BuffType.Knockup) == true then
                    --print('CC')
                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                end
                if Target.MovementSpeed <= self.MS.Value and Target.ActiveSpell.Info.Name ~= "" then
                    --print('Slow')
                    return Engine:ReleaseSpell("HK_SPELL1", CastPos)
                end
                local Info = Evade.Spells[Target.ActiveSpell.Info.Name]
                if Info ~= nil and Info.Delay >= (self.Delay.Value / 100) then
                    if Info == "BrandW" then return nil end
                    --print('Delay')
                    return Engine:ReleaseSpell("HK_SPELL1", Target.Position)
                end
            end
        end
    end
end

function Nami:OnTick()
    --Nami:ETarget()
	for i,Ally in pairs(ObjectManager.HeroList) do 
		if Ally.Team == myHero.Team and string.len(Ally.ChampionName) > 1 then
			if self.SelectedAlly[Ally.Index] == nil then
				local Name = Ally.ChampionName
				self.SelectedAlly[Ally.Index] = self.TargetSelector:AddCheckbox(Name, 1)
			end
		end
	end
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.MiscQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            self:Misc()
        end
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

function Nami:OnDraw()
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


function Nami:OnLoad()
    if(myHero.ChampionName ~= "Nami") then return end
	AddEvent("OnSettingsSave" , function() Nami:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nami:LoadSettings() end)


	Nami:__init()
	AddEvent("OnTick", function() Nami:OnTick() end)	
	AddEvent("OnDraw", function() Nami:OnDraw() end)	
end

AddEvent("OnLoad", function() Nami:OnLoad() end)