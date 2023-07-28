BelVeth = {} 

function BelVeth:__init() 

    self.ETimer = 0
    
    self.QRange = 450
    self.WRange = 725
    self.ERange = 530
    self.RRange = 250
    self.R2Range = 500

    self.QSpeed = 750 + (50 * myHero:GetSpellSlot(0).Level) + myHero.MovementSpeed
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QWidth = 100
    self.WWidth = 200

    self.QDelay = 0
    self.WDelay = 0.5
    self.EDelay = 0
    self.RDelay = 1

    self.EActive = false

    self.QHitChance = 0.35
    self.WHitChance = 0.35

    self.ChampionMenu = Menu:CreateMenu("BelVeth") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    self.HarassR = self.HarassMenu:AddCheckbox("Use R in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1)
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    self.ClearR = self.LClearMenu:AddCheckbox("Use R in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    BelVeth:LoadSettings()  
end 

function BelVeth:SaveSettings() 

    SettingsManager:CreateSettings("BelVeth")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    SettingsManager:AddSettingsInt("Use R in Harass", self.HarassR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    SettingsManager:AddSettingsInt("Use R in LaneClear", self.ClearR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function BelVeth:LoadSettings()
    SettingsManager:GetSettingsFile("BelVeth")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    self.HarassR.Value = SettingsManager:GetSettingsInt("Harass","Use R in Harass")  
    --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    self.ClearR.Value = SettingsManager:GetSettingsInt("LaneClear","Use R in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

function BelVeth:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end
local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function BelVeth:EnemiesInRange(Position, Range)
	local Count = 0 
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

function BelVeth:GetAttackRange()
    return myHero.AttackRange + myHero.CharData.BoundingRadius
end


local function GetHeroLevel(Target)
    local totalLevel = Target:GetSpellSlot(0).Level + Target:GetSpellSlot(1).Level + Target:GetSpellSlot(2).Level + Target:GetSpellSlot(3).Level
    return totalLevel
end

function BelVeth:ResetE()
    local target = Orbwalker:GetTarget("Combo", 700)
    if self.EActive then
        if not Engine:SpellReady("HK_SPELL3") then
            self.EActive = false
        end
        if target then
            if self:GetDistance(myHero.Position, target.Position) >= 350 then
                self.EActive = false
            end
        end
        local EActive = myHero.BuffData:GetBuff("BelvethE").Valid
        if not EActive then
            self.EActive = false
        end
    end
end

function BelVeth:GetLavenderPosition()
    local MinionList = ObjectManager.MinionList
    for i, Minion in pairs(MinionList) do
        if self:GetDistance(myHero.Position, Minion.Position) <= 600 then
            if Minion.Name == "BelvethSpore" then
                return Minion.Position
            end
        end
    end
    return nil
end

function BelVeth:QTroy()
    local list = ObjectManager.TroyList
    for i, troy in pairs(list) do 
        if troy.Name == "Belveth_Base_Q_Direction_BVOnly" then
            return true
        end
    end
    return false
end

function BelVeth:Combo()
    -- use Q if 1 <= mana or as gapclose if W is on cooldown
    -- use W if mana 1 <= mana or if out of range if q is on cd
    -- use E if multiple enemies around you or if Q and W on cd
    -- use R whenever possible and there is a stack object
    if self.ComboR.Value == 1 then
        if Engine:SpellReady("HK_SPELL4") then
            local Lavender = self:GetLavenderPosition()
            if Lavender then
                Engine:CastSpell("HK_SPELL4", Lavender, 0)
                return
            end
        end
    end
    local target = Orbwalker:GetTarget("Combo", 700)
    if target then
        local CanUseQ = self:QTroy()
        if self.ComboQ.Value == 1 then
            if Engine:SpellReady("HK_SPELL1") and CanUseQ then
                local gapCloseQ = myHero.AttackRange + myHero.CharData.BoundingRadius + 150
                if myHero.Mana <= 1 or not Engine:SpellReady("HK_SPELL2") and self:GetDistance(myHero.Position, target.Position) > gapCloseQ and self:GetDistance(myHero.Position, target.Position) <= self.QRange then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            end
        end
        if self.ComboW.Value == 1 then
            if Engine:SpellReady("HK_SPELL2") then
                if myHero.Mana <= 1 or not Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, target.Position) > self:GetAttackRange() then
                    local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end
                end
            end
        end
        if self.ComboE.Value == 1 then
            local EActive = myHero.BuffData:GetBuff("BelvethE").Valid
            if Engine:SpellReady("HK_SPELL3") and not EActive then
                local EnemiesAround = BelVeth:EnemiesInRange(myHero.Position, self.ERange)
                if EnemiesAround >= 3 then
                    self.EActive = true
                    Engine:CastSpell("HK_SPELL3", nil, 1)
                    return
                end
                if EnemiesAround > 0 and EnemiesAround <= 2 then
                    if self:GetDistance(myHero.Position, target.Position) <= self:GetAttackRange() then
                        self.EActive = true
                        Engine:CastSpell("HK_SPELL3", nil, 1)
                        return
                    end
                end
            end
        end
    end

end

function BelVeth:Harass()
    if self.HarassR.Value == 1 then
        if Engine:SpellReady("HK_SPELL4") then
            local Lavender = self:GetLavenderPosition()
            if Lavender then
                Engine:CastSpell("HK_SPELL4", Lavender, 0)
                return
            end
        end
    end
    local target = Orbwalker:GetTarget("Harass", 700)
    if target then
        if self.HarassQ.Value == 1 then
            if Engine:SpellReady("HK_SPELL1") then
                local gapCloseQ = myHero.AttackRange + myHero.CharData.BoundingRadius + 150
                if myHero.Mana <= 1 or not Engine:SpellReady("HK_SPELL2") and self:GetDistance(myHero.Position, target.Position) > gapCloseQ and self:GetDistance(myHero.Position, target.Position) <= self.QRange then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            end
        end
        if self.HarassW.Value == 1 then
            if Engine:SpellReady("HK_SPELL2") then
                if myHero.Mana <= 1 or not Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, target.Position) > self:GetAttackRange() then
                    local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                        return
                    end
                end
            end
        end
        if self.HarassE.Value == 1 then
            local EActive = myHero.BuffData:GetBuff("BelvethE").Valid
            if Engine:SpellReady("HK_SPELL3") and not EActive then
                local EnemiesAround = BelVeth:EnemiesInRange(myHero.Position, self.ERange)
                if EnemiesAround >= 3 then
                    self.EActive = true
                    Engine:CastSpell("HK_SPELL3", nil, 1)
                    return
                end
                if EnemiesAround > 0 and EnemiesAround <= 2 then
                    if self:GetDistance(myHero.Position, target.Position) <= self:GetAttackRange() then
                        self.EActive = true
                        Engine:CastSpell("HK_SPELL3", nil, 1)
                        return
                    end
                end
            end
        end
    end
end

function BelVeth:Laneclear()
    if self.ClearR.Value == 1 then
        if Engine:SpellReady("HK_SPELL4") then
            local Lavender = self:GetLavenderPosition()
            if Lavender then
                Engine:CastSpell("HK_SPELL4", Lavender, 0)
                return
            end
        end
    end
    if self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Engine:SpellReady("HK_SPELL1") then
            if target then
                if myHero.Mana <= 1 then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                    return
                end
            end
        end
    end
    if self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if Engine:SpellReady("HK_SPELL2") then
            if target then
                Engine:CastSpell("HK_SPELL2", target.Position, 0)
                return
            end
        end
    end
end

--end---


function BelVeth:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        BelVeth:QTroy()
        self:ResetE()
        if Engine:IsKeyDown("HK_COMBO") and not self.EActive then
            BelVeth:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            BelVeth:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            BelVeth:Laneclear()
		end
	end
end

function BelVeth:OnDraw()
    -- local TroyList = ObjectManager.TroyList
    -- for _ , Troy in pairs(TroyList) do
    --     local vecOut = Vector3.new()
    --     if Render:World2Screen(Troy.Position, vecOut) then
    --         print(Troy.Name)
    --         Render:DrawString(Troy.Name, vecOut.x , vecOut.y , 255, 0, 0, 255)
    --         Render:DrawString(Troy.Index, vecOut.x , vecOut.y+20 , 0, 255, 0, 255)
    --         Render:DrawCircle(Troy.Position, 20, 0,255,0,255)
    --     end
    -- end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange + myHero.AttackRange - 125 ,100,150,255,255)
    end
end

function BelVeth:OnLoad()
    if(myHero.ChampionName ~= "Belveth") then return end
	AddEvent("OnSettingsSave" , function() BelVeth:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() BelVeth:LoadSettings() end)


	BelVeth:__init()
	AddEvent("OnTick", function() BelVeth:OnTick() end)	
    AddEvent("OnDraw", function() BelVeth:OnDraw() end)
end

AddEvent("OnLoad", function() BelVeth:OnLoad() end)	
