local Sylas = {}

function Sylas:__init()

    self.QRange = 775
    self.WRange = 400
    self.E1Range = 400
    self.E2Range = 800
    self.RRange = 0

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 1600
    self.RSpeed = math.huge

    self.QDelay = 0.4
    self.WDelay = math.huge
    self.EDelay = 0.25
    self.RDelay = 0

    self.QRadius = 180
    self.WRadius = 0
    self.ERadius = 100
    self.RRadius = 0

    self.ScriptVersion = "        **CCSylas Version: 0.1 (Beta Release)**"

    self.SylasMenu = Menu:CreateMenu("Sylas")
	-------------------------------------------
    self.Combomenu = self.SylasMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("Use R in combo", 1)
    --self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    -------------------------------------------
	self.Harassmenu = self.SylasMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.HarassW = self.Harassmenu:AddCheckbox("Use W in harass", 1)
    self.HarassWMana = self.Harassmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
    self.Clearmenu = self.SylasMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearW = self.Clearmenu:AddCheckbox("Use W in clear", 1)
    self.ClearWMana = self.Clearmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
    self.Miscmenu = self.SylasMenu:AddSubMenu("Misc")
    self.WHealth = self.Miscmenu:AddSlider("% Health to use W", 40, 0, 100, 1)
    --self.WEnemies = self.Miscmenu:AddSlider("X enemies force W", 3, 1, 5, 1)
    -------------------------------------------
	self.Drawings = self.SylasMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
	
	Sylas:LoadSettings()
end

function Sylas:SaveSettings()
	SettingsManager:CreateSettings("Sylas")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    --SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HW", self.HarassW.Value)
    SettingsManager:AddSettingsInt("HWM", self.HarassWMana.Value)
    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    SettingsManager:AddSettingsInt("CW", self.ClearW.Value)
    SettingsManager:AddSettingsInt("CWM", self.ClearWMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("WH", self.WHealth.Value)
    --SettingsManager:AddSettingsInt("WE", self.WEnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Sylas:LoadSettings()
	SettingsManager:GetSettingsFile("Sylas")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    --self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","HW")
    self.HarassWMana.Value = SettingsManager:GetSettingsInt("Harass","HWM")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","HE")
    self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass","HEM")
    -------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    self.ClearW.Value = SettingsManager:GetSettingsInt("Clear", "CW")
    self.ClearWMana.Value = SettingsManager:GetSettingsInt("Clear", "CWM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")
    -------------------------------------------
    self.WHealth.Value = SettingsManager:GetSettingsInt("Misc", "WH")
    --self.WEnemies.Value = SettingsManager:GetSettingsInt("Misc", "WE")
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Sylas:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Sylas:Combo()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")

    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.QRange - 70)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0)
                if CastPos then
                    Engine:CastSpell("HK_SPELL1", CastPos, 1)
                end
            else
                if Passive.Valid == false then
                    local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                    end
                end
            end    
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.ComboW.Value == 1 then
        local target1 = Orbwalker:GetTarget("Combo", self.E1Range + 600)
        local target2 = Orbwalker:GetTarget("Combo", self.E2Range - 100)
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if target1 then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == false then
                        Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    end
                end
            end
        end
        if target2 then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() then
                if EBuff.Valid == true then
                    local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                    end
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == true then
                        local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1)
                        if CastPos then
                            Engine:CastSpell("HK_SPELL3", CastPos, 1)
                        end
                    end
                end
            end
        end          
    end

    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) > self:getAttackRange() then
                if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            else
                if Passive.Valid == false then
                    if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    end
                end
                if myHero.Health <= myHero.MaxHealth / 100 * (self.WHealth.Value * 0.5) then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end

 
end

function Sylas:Harass()
    local Passive = myHero.BuffData:GetBuff("SylasPassiveAttack")

    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Harass", self.QRange - 70)
        if target then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0)
                if CastPos then
                    Engine:CastSpell("HK_SPELL1", CastPos, 1)
                end
            else
                if Passive.Valid == false then
                    local CastPos, target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QRadius, self.QDelay, 0)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                    end
                end
            end    
        end
    end

    if Engine:SpellReady("HK_SPELL3") and self.HarassE.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassEMana.Value / 100 then return end
        local target1 = Orbwalker:GetTarget("Harass", self.E1Range + 600)
        local target2 = Orbwalker:GetTarget("Harass", self.E2Range - 100)
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if target1 then
            if GetDist(myHero.Position, target1.Position) > self:getAttackRange() then
                if EBuff.Valid == false then
                    Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == false then
                        Engine:CastSpell("HK_SPELL3", target1.Position, 1)
                    end
                end
            end
        end
        if target2 then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() then
                if EBuff.Valid == true then
                    local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1)
                    if CastPos then
                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                    end
                end
            else
                if Passive.Valid == false then
                    if EBuff.Valid == true then
                        local CastPos, target2 = Prediction:GetCastPos(myHero.Position, self.E2Range, self.ESpeed, self.ERadius, self.EDelay, 1)
                        if CastPos then
                            Engine:CastSpell("HK_SPELL3", CastPos, 1)
                        end
                    end
                end
            end
        end          
    end

    if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
        if myHero.Mana <= myHero.MaxMana * self.HarassWMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            if GetDist(myHero.Position, target2.Position) > self:getAttackRange() then
                if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            else
                if Passive.Valid == false then
                    if myHero.Health <= myHero.MaxHealth / 100 * self.WHealth.Value then
                        Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    end
                end
                if myHero.Health <= myHero.MaxHealth / 100 * (self.WHealth.Value * 0.5) then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                end
            end
        end
    end
end

function Sylas:Laneclear()

end

function Sylas:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Sylas:Combo()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sylas:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Sylas:Laneclear()
            return
        end
    end
end

function Sylas:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        local EBuff = myHero.BuffData:GetBuff("sylasemanager")
        if EBuff.Valid == false then
            Render:DrawCircle(myHero.Position, self.E1Range, 225, 0, 225, 225)
        end
        if EBuff.Valid == true then
            Render:DrawCircle(myHero.Position, self.E2Range, 228, 185, 10, 225)
        end
    end
    --if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        --Render:DrawCircle(myHero.Position, 1000, 255, 0, 255, 255)
    --end
end

function Sylas:OnLoad()
    if(myHero.ChampionName ~= "Sylas") then return end
    AddEvent("OnSettingsSave" , function() Sylas:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sylas:LoadSettings() end)

	Sylas:__init()
	AddEvent("OnTick", function() Sylas:OnTick() end)
    AddEvent("OnDraw", function() Sylas:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Sylas:OnLoad() end)