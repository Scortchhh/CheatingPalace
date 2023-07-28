Zyra = {}
function Zyra:__init()	
	self.QRange = 800
	self.WRange = 850
	self.ERange = 1100
    self.RRange = 700

	self.QSpeed = math.huge
    self.WSpeed = math.huge
	self.ESpeed = 1150
	self.RSpeed = math.huge

    self.QWidth = 100
    self.EWidth = 80

	self.QDelay = 0.25
	self.WDelay = 0.25
	self.EDelay = 0.25
	self.RDelay = 0.25

    self.QHitChance = 0.2
    self.EHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Zyra")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	self.EnemiesToStun = self.ComboMenu:AddSlider("Plants around enemy for R", 2, 1, 3, 1)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseW2 = self.HarassMenu:AddCheckbox("UseW", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE", 1)
	
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Zyra:LoadSettings()
end

function Zyra:SaveSettings()
	SettingsManager:CreateSettings("Zyra")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("Enemies to stun", self.EnemiesToStun.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Zyra:LoadSettings()
	SettingsManager:GetSettingsFile("Zyra")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.EnemiesToStun.Value = SettingsManager:GetSettingsInt("Combo","Enemies to stun")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Zyra:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Zyra:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function Zyra:CastWSpot(Target, EndPos)
	local PlayerPos 	= myHero.Position
    local TargetPos = Target.Position
	local EndPos 	= EndPos
	local TargetVec 	= Vector3.new(EndPos.x - PlayerPos.x, EndPos.y - PlayerPos.y, EndPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i = 500
    local EndPos = Vector3.new(EndPos.x - (TargetNorm.x * i),EndPos.y - (TargetNorm.y * i),EndPos.z - (TargetNorm.z * i))
    return EndPos
end

function Zyra:GetAllPlants(target)
	local minionList = ObjectManager.MinionList
	local counter = 0
	for i, Minion in pairs(minionList) do 
        if self:GetDistance(myHero.Position, Minion.Position) <= 1200 then
            if self:GetDistance(Minion.Position, target.Position) <= 400 then
                if Minion.ChampionName == "ZyraThornPlant" then
                    counter = counter + 1
                end
            end
        end
	end
    return counter
end

function Zyra:Combo()
	local target = Orbwalker:GetTarget("Combo", 1200)
	if target then
        if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
            if target.BuffData:HasBuffOfType(BuffType.Snare) then
                local plantCount = self:GetAllPlants(target)
                if plantCount >= self.EnemiesToStun.Value then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            local activeSpell = myHero.ActiveSpell
            local activeSpellName = activeSpell.Info.Name
            if activeSpellName == "ZyraE" then
                local castPos = self:CastWSpot(target, activeSpell.EndPos)
                if castPos ~= nil then
                    print('1')
                    Engine:CastSpell("HK_SPELL2", castPos, 0)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 then
            if self:GetDistance(myHero.Position, target.Position) <= self.ERange then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL3", CastPos, 1)
                    eUsed = true
					return
				end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            if target.BuffData:HasBuffOfType(BuffType.Snare) then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 then
            if target.BuffData:HasBuffOfType(BuffType.Snare) then
                if self:GetDistance(myHero.Position, target.Position) <= self.QRange then
					Engine:CastSpell("HK_SPELL1", target.Position, 1)
					return
                end
            end
        end
        if not Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if CastPos ~= nil then
                Engine:CastSpell("HK_SPELL1", CastPos, 1)
                return
            end
        end
	end
end

function Zyra:Harass()
	local target = Orbwalker:GetTarget("Harass", 1200)
	if target then
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
            local activeSpell = myHero.ActiveSpell
            local activeSpellName = activeSpell.Info.Name
            if activeSpellName == "ZyraE" then
                local castPos = self:CastWSpot(target, activeSpell.EndPos)
                if castPos ~= nil then
                    Engine:CastSpell("HK_SPELL2", castPos, 0)
                    return
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 then
            if self:GetDistance(myHero.Position, target.Position) <= self.ERange then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
				if CastPos ~= nil then
					Engine:CastSpell("HK_SPELL3", CastPos, 1)
					return
				end
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
            if target.BuffData:HasBuffOfType(BuffType.Snare) then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 then
            if target.BuffData:HasBuffOfType(BuffType.Snare) then
                if self:GetDistance(myHero.Position, target.Position) <= self.QRange then
					Engine:CastSpell("HK_SPELL1", target.Position, 1)
					return
                end
            end
        end
        if not Engine:SpellReady("HK_SPELL3") and Engine:SpellReady("HK_SPELL1") then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if CastPos ~= nil then
                Engine:CastSpell("HK_SPELL1", CastPos, 1)
                return
            end
        end
	end
end

function Zyra:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- print(myHero:GetSpellSlot(1).Cooldown)
		if Engine:IsKeyDown("HK_COMBO") then
			Zyra:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Zyra:Harass()
		end
	end
end

function Zyra:OnDraw()
	if myHero.ChampionName == "Zyra" then
        -- local target = Orbwalker:GetTarget("Combo", 1200)
        -- if target then
        --     local activeSpell = myHero.ActiveSpell
        --     local activeSpellName = activeSpell.Info.Name
        --     if activeSpellName == "ZyraE" then
        --         local castPos = self:CastWSpot(target, activeSpell.EndPos)
        --         if castPos ~= nil then
        --             Render:DrawCircle(castPos, 100 ,100,150,255,255)
        --             return
        --         end
        --     end
        -- end
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
end

function Zyra:OnLoad()
    if(myHero.ChampionName ~= "Zyra") then return end
	AddEvent("OnSettingsSave" , function() Zyra:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Zyra:LoadSettings() end)


	Zyra:__init()
	AddEvent("OnTick", function() Zyra:OnTick() end)	
	AddEvent("OnDraw", function() Zyra:OnDraw() end)	
end

AddEvent("OnLoad", function() Zyra:OnLoad() end)	
