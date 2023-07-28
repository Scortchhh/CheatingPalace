local Hecarim = {}

function Hecarim:__init()

    self.ScriptVersion = "        **CocainePony Version: 1.0 (Full Release)**"

    self.ChampionMenu = Menu:CreateMenu("Hecarim")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    --self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)
    self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)
    self.Combomenu:AddLabel("Use R insec to force key targeted enemies")
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.HarassW = self.Harassmenu:AddCheckbox("Use W in harass", 1)
    self.HarassWMana = self.Harassmenu:AddSlider("Minimum % mana to use W", 30, 0, 100, 1)
    -------------------------------------------
    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    -------------------------------------------
    self.Miscmenu = self.ChampionMenu:AddSubMenu("Misc")
    self.QaaReset = self.Miscmenu:AddCheckbox("Use Q as AA reset", 0)
    self.WHealth = self.Miscmenu:AddSlider("% Health to use W", 45, 0, 100, 1)
    self.WEnemies = self.Miscmenu:AddSlider("X enemies force W", 3, 1, 5, 1)
    -------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
	
	Hecarim:LoadSettings()
end

function Hecarim:SaveSettings()
	SettingsManager:CreateSettings("Hecarim")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    --SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    SettingsManager:AddSettingsInt("HW", self.HarassW.Value)
    SettingsManager:AddSettingsInt("HWM", self.HarassWMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("QAAR", self.QaaReset.Value)
    SettingsManager:AddSettingsInt("WH", self.WHealth.Value)
    SettingsManager:AddSettingsInt("WE", self.WEnemies.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Hecarim:LoadSettings()
	SettingsManager:GetSettingsFile("Hecarim")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    self.QaaReset.Value = SettingsManager:GetSettingsInt("Combo", "QAAR")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    --self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass","HQM")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","HW")
    self.HarassWMana.Value = SettingsManager:GetSettingsInt("Harass","HWM")
    -------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    -------------------------------------------
    self.WHealth.Value = SettingsManager:GetSettingsInt("Misc", "WH")
    self.WEnemies.Value = SettingsManager:GetSettingsInt("Misc", "WE")
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Hecarim:getAttackRange()
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

function Hecarim:GetRCastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 200
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Hecarim:InsecR()
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        if myHero.BuffData:GetBuff("hecarimrampspeed").Valid then
            local Target = Orbwalker:GetTarget("Combo", 1000)
            local StartPos = myHero.Position
            if Target ~= nil then
                if Engine:GetForceTarget(Target) then
                    local CastPos = Prediction:GetCastPos(StartPos, 1000, 1100, 0, 0, 0)
                    if CastPos ~= nil then
                        CastPos = self:GetRCastPos(CastPos)
                        if GetDist(myHero.Position, Target.Position) > 400 then
                            Engine:CastSpell("HK_SPELL4", CastPos, 1)
                        end
                    end
                end
            end
        end
    end
end

function Hecarim:Combo()
    if Engine:SpellReady("HK_SPELL4") and  self.ComboR.Value == 1 then
        local Target = Orbwalker:GetTarget("Combo", 1000)
        if Target ~= nil then
            --local PredPos = Prediction:GetCastPos(myHero.Position, 1000, 1100, 0, 0, 0) --1650 rage? delay 0.2? radius 280?
            --if PredPos ~= nil then
            local XEnemies = EnemiesInRange(Target.Position, 280)
            if  XEnemies >= self.REnemies.Value then
                Engine:CastSpell("HK_SPELL4", Target.Position ,1)
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", 350)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 350 then
                if self.QaaReset.Value == 1 and Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                    return
                end
                if self.QaaReset.Value == 0 then
                    Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                    return
                end
            end
        end
    end
    
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", 350)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 350 then
                local LowHP = myHero.MaxHealth / 100 * self.WHealth.Value
                local XEnemies = EnemiesInRange(myHero.Position, 600)
                if myHero.Health <= LowHP then
                    Engine:CastSpell("HK_SPELL2", Vector3.new() ,1)
                    return
                end
                if XEnemies >= self.WEnemies.Value then
                    Engine:CastSpell("HK_SPELL2", Vector3.new() ,1)
                    return
                end
            end
        end
    end
end

function Hecarim:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Harass", 350)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 350 then
                if self.QaaReset.Value == 1 and Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                    return
                end
                if self.QaaReset.Value == 0 then
                    Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                    return
                end
            end
        end
    end
    
    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero.Mana <= myHero.MaxMana * self.HarassWMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Harass", 350)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= 350 then
                local LowHP = myHero.MaxHealth / 100 * self.WHealth.Value
                local XEnemies = EnemiesInRange(myHero.Position, 600)
                if myHero.Health <= LowHP then
                    Engine:CastSpell("HK_SPELL2", Vector3.new() ,1)
                    return
                end
                if XEnemies >= self.WEnemies.Value then
                    Engine:CastSpell("HK_SPELL2", Vector3.new() ,1)
                    return
                end
            end
        end
    end
end

function Hecarim:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.ClearQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", 350)
        if target == nil then return end
        if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= 350 then
            if self.QaaReset.Value == 1 and Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                return
            end
            if self.QaaReset.Value == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new() ,1)
                return
            end
        end
    end
end

function Hecarim:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Hecarim:Combo()
            Hecarim:InsecR()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Hecarim:Harass()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Hecarim:Laneclear()
            return
        end
    end
end

function Hecarim:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 350, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 575, 225, 0, 225, 225)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 1000, 255, 0, 255, 255)
    end
    --if self:PredCheckPos() == true and self.PredCheck.Value == 1 then
      --  Render:DrawCircle(self:PredCheckPos(), 100, 255, 0, 255, 255)
    --end
end

function Hecarim:OnLoad()
    if(myHero.ChampionName ~= "Hecarim") then return end
    AddEvent("OnSettingsSave" , function() Hecarim:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Hecarim:LoadSettings() end)

	Hecarim:__init()
	AddEvent("OnTick", function() Hecarim:OnTick() end)
    AddEvent("OnDraw", function() Hecarim:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Hecarim:OnLoad() end)