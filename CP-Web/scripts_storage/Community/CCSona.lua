local Sona = {}

function Sona:__init()

    self.QRange = 825
    self.WRange = 1000
    self.ERange = 430
    self.RRange = 900

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = 2400

    self.QDelay = math.huge
    self.WDelay = math.huge
    self.EDelay = math.huge
    self.RDelay = 0.2

    self.RRadius = 140 + myHero.CharData.BoundingRadius + 20

    self.ScriptVersion = "        **CCSona Version: 0.6 (BETA)**"

    self.ChampionMenu = Menu:CreateMenu("Sona")
	-------------------------------------------
    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)
    --self.QSettings = self.Combomenu:AddSubMenu("Q Settings")
    --self.ComboKSQ = self.QSettings:AddCheckbox("Use KS Q in combo", 1)
    --self.ComboW = self.QSettings:AddCheckbox("Use W active if Killable with KS", 1)
    self.ComboW = self.Combomenu:AddCheckbox("Use W in combo", 1)
    self.AllyHealthW = self.Combomenu:AddSlider("Heal Ally under X% health", 75, 1, 100, 1)
    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo (not working)", 1)
    --self.ESettings = self.Combomenu:AddSubMenu("E Settings")
    --self.ComboKSE = self.ESettings:AddCheckbox("Use KS E in combo", 1)
    self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)
    self.SingleR = self.Combomenu:AddCheckbox("Single R if you are low hp", 1)
    self.SingleRHP = self.Combomenu:AddSlider("^ under % hp", 25, 1, 100, 1)
    self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 2, 1, 5, 1)
    self.UsePlus1 = self.Combomenu:AddCheckbox("^ Use + 1 enemy", 1)
    self.Plus1LvL = self.Combomenu:AddSlider("^ When at level", 11, 1, 18, 1)
    -------------------------------------------
	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)
    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    --self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)
    --self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)
    -------------------------------------------
--[[    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")
    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)
    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)
    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)
    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)]]
    -------------------------------------------
	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)
    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)
    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)
    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)
    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
    
	Sona:LoadSettings()
end

function Sona:SaveSettings()
	SettingsManager:CreateSettings("CCSona")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)
    --[[SettingsManager:AddSettingsInt("KSQ", self.ComboKSQ.Value)
    SettingsManager:AddSettingsInt("CWStack", self.ComboWSlider.Value)
    SettingsManager:AddSettingsInt("KSW", self.ComboW.Value)]]
    SettingsManager:AddSettingsInt("CW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("AllyHealth", self.AllyHealthW.Value)
    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)
    --SettingsManager:AddSettingsInt("KSE", self.ComboKSE.Value)
    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)
    SettingsManager:AddSettingsInt("SR", self.SingleR.Value)
    SettingsManager:AddSettingsInt("SRHP", self.SingleRHP.Value)
    SettingsManager:AddSettingsInt("ER", self.REnemies.Value)
    SettingsManager:AddSettingsInt("UsePlus", self.UsePlus1.Value)
    SettingsManager:AddSettingsInt("SliderPlus", self.Plus1LvL.Value)
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)
    --SettingsManager:AddSettingsInt("HE", self.HarassE.Value)
    --SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)
    -------------------------------------------
 --[[   SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)
    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)
    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)]]
    -------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DW", self.DrawQRange.Value)
    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)
    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)
end

function Sona:LoadSettings()
	SettingsManager:GetSettingsFile("CCSona")
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")
    --self.ComboKSQ.Value = SettingsManager:GetSettingsInt("Combo", "KSQ")
    --self.ComboWSlider.Value = SettingsManager:GetSettingsInt("Combo", "CWStack")
    --self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "KSW")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo", "CW")
    self.AllyHealthW.Value = SettingsManager:GetSettingsInt("Combo", "AllyHealth")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")
    --self.ComboKSE.Value = SettingsManager:GetSettingsInt("Combo", "KSE")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")
    self.SingleR.Value = SettingsManager:GetSettingsInt("Combo", "SR")
    self.SingleRHP.Value = SettingsManager:GetSettingsInt("Combo", "SRHP")
    self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")
    self.UsePlus1.Value = SettingsManager:GetSettingsInt("Combo", "UsePlus")
    self.Plus1LvL.Value = SettingsManager:GetSettingsInt("Combo", "SliderPlus")
    -------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass", "HQ")
    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass", "HQM")
    --self.HarassE.Value = SettingsManager:GetSettingsInt("Harass", "HE")
    --self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass", "HEM")
    -------------------------------------------
--[[    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")
    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")
    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")
    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")]]
    -------------------------------------------
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")
    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")
    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")
    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")
end


local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Sona:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = target.MagicResist * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Sona:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
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

local function AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsTargetable then
            if GetDist(Hero.Position, Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Sona:GetLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Sona:SingleREnemy()
    if self.ComboR.Value == 1 and self.SingleR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange - 100)
        if target then
            if myHero.Health <= myHero.MaxHealth / 100 * self.SingleRHP.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end
end

function Sona:Combo()
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team == myHero.Team and Hero.IsTargetable then
                if GetDist(myHero.Position, Hero.Position) < self.WRange then
                    if Hero.Health <= Hero.MaxHealth / 100 * self.AllyHealthW.Value then
                        Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                    end
                end
            end
        end
    end
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) < self.QRange then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
            end
        end
    end
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange - 100)
        if target then
            local REnemies = self.REnemies.Value
            if self.UsePlus1.Value == 1 and self:GetLevel() >= self.Plus1LvL.Value then
                REnemies = REnemies + 1
            end
            if target.AIData.IsDashing == false or target.BuffData:HasBuffOfType(BuffType.Stun) == false then
                if EnemiesInRange(target.Position, 220) >= REnemies then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
        end
    end
end

function Sona:Harass()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) < self.QRange then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
            end
        end
    end
end

function Sona:Laneclear()
    --Just Do It URSELF!!
end

function Sona:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Sona:Combo()
            Sona:SingleREnemy()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sona:Harass()
            return
        end
        --[[if Engine:IsKeyDown("HK_LANECLEAR") then
            Sona:Laneclear()
            return
        end]]
    end
end

function Sona:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 13, 212, 242, 255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 28, 242, 13, 255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 242, 13, 154, 225)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 242, 208, 13, 255)
    end
end

function Sona:OnLoad()
    if(myHero.ChampionName ~= "Sona") then return end
    AddEvent("OnSettingsSave" , function() Sona:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sona:LoadSettings() end)

	Sona:__init()
	AddEvent("OnTick", function() Sona:OnTick() end)
    AddEvent("OnDraw", function() Sona:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Sona:OnLoad() end)