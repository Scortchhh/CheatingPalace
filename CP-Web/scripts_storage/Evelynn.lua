local Evelynn = {}

function Evelynn:__init()
    self.KeyNames = {}
	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"
	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
	self.KeyNames[11]		= "HK_ITEM6"
    --ItemSoFBoltSpellBase

    self.QCast = false

    self.QRange = 600

    self.WRange = 1100 + (100 * myHero:GetSpellSlot(1).Level)

    self.ERange = 210 + myHero.CharData.BoundingRadius + 20

    self.RRange = 450

    self.BoltRange = 550

    self.QSpeed = 2400

    --self.WSpeed = math.huge

    --self.ESpeed = math.huge

    self.RSpeed = math.huge

    self.QDelay = 0.25

    --self.WDelay = math.huge

    --self.EDelay = math.huge

    self.RDelay = 0.35

    self.QRadius = 70

    --self.WRadius = 0

    --self.ERadius = 0

    self.RRadius = 180

    self.QRange = 800 
    self.QSpeed = 2400
    self.QWidth = 80
    self.QDelay = 0.3

    self.QHitChance = 0.4

    self.ScriptVersion = "        **CCEvelynn Version: 0.6 (BETA)**"



    self.ChampionMenu = Menu:CreateMenu("Evelynn")

	-------------------------------------------

    self.Combomenu = self.ChampionMenu:AddSubMenu("Combo")

    self.ComboQ = self.Combomenu:AddCheckbox("Use Q in combo", 1)

    self.ComboE = self.Combomenu:AddCheckbox("Use E in combo", 1)

    self.UseBolt = self.Combomenu:AddCheckbox("Use Bolt Item", 1)

    self.ComboR = self.Combomenu:AddCheckbox("(BETA) Use R in combo", 1)

    self.SingleR = self.Combomenu:AddCheckbox("(BETA) Single R if enemy Killable", 1)

    self.SingleRHP = self.Combomenu:AddSlider("Single R if you are under % hp", 40, 1, 100, 1)

    self.REnemies = self.Combomenu:AddSlider("Use if X enemies in R", 3, 1, 5, 1)

    -------------------------------------------

	self.Harassmenu = self.ChampionMenu:AddSubMenu("Harass")

    self.HarassQ = self.Harassmenu:AddCheckbox("Use Q in harass", 1)

    self.HarassQMana = self.Harassmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)

    self.HarassE = self.Harassmenu:AddCheckbox("Use E in harass", 1)

    self.HarassEMana = self.Harassmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)

    -------------------------------------------

    self.Clearmenu = self.ChampionMenu:AddSubMenu("Clear")

    self.ClearQ = self.Clearmenu:AddCheckbox("Use Q in clear", 1)

    self.ClearQMana = self.Clearmenu:AddSlider("Minimum % mana to use Q", 30, 0, 100, 1)

    self.ClearE = self.Clearmenu:AddCheckbox("Use E in clear", 1)

    self.ClearEMana = self.Clearmenu:AddSlider("Minimum % mana to use E", 30, 0, 100, 1)

    -------------------------------------------

	self.Drawings = self.ChampionMenu:AddSubMenu("Drawings")

    self.DrawQRange = self.Drawings:AddCheckbox("Draw Q Range", 1)

    self.DrawWRange = self.Drawings:AddCheckbox("Draw W Range", 1)

    self.DrawERange = self.Drawings:AddCheckbox("Draw E Range", 1)

    self.DrawRRange = self.Drawings:AddCheckbox("Draw R Range", 1)

    --self.PredCheck = self.Drawings:AddCheckbox("PredCheck", 0)
	Evelynn:LoadSettings()
end

function Evelynn:SaveSettings()

	SettingsManager:CreateSettings("CCEvelynn")

	SettingsManager:AddSettingsGroup("Combo")

    SettingsManager:AddSettingsInt("CQ", self.ComboQ.Value)

    SettingsManager:AddSettingsInt("CE", self.ComboE.Value)

    SettingsManager:AddSettingsInt("CR", self.ComboR.Value)

    SettingsManager:AddSettingsInt("SR", self.SingleR.Value)

    SettingsManager:AddSettingsInt("SRHP", self.SingleRHP.Value)

    SettingsManager:AddSettingsInt("ER", self.REnemies.Value)

    -------------------------------------------

	SettingsManager:AddSettingsGroup("Harass")

    SettingsManager:AddSettingsInt("HQ", self.HarassQ.Value)

    SettingsManager:AddSettingsInt("HQM", self.HarassQMana.Value)

    SettingsManager:AddSettingsInt("HE", self.HarassE.Value)

    SettingsManager:AddSettingsInt("HEM", self.HarassEMana.Value)

    -------------------------------------------

    SettingsManager:AddSettingsGroup("Clear")

    SettingsManager:AddSettingsInt("CQ", self.ClearQ.Value)

    SettingsManager:AddSettingsInt("CQM", self.ClearQMana.Value)

    SettingsManager:AddSettingsInt("CE", self.ClearE.Value)

    SettingsManager:AddSettingsInt("CEM", self.ClearEMana.Value)

    -------------------------------------------

	SettingsManager:AddSettingsGroup("Drawings")

    SettingsManager:AddSettingsInt("DQ", self.DrawQRange.Value)

    SettingsManager:AddSettingsInt("DW", self.DrawWRange.Value)

    SettingsManager:AddSettingsInt("DE", self.DrawERange.Value)

    SettingsManager:AddSettingsInt("DR", self.DrawRRange.Value)

end



function Evelynn:LoadSettings()

	SettingsManager:GetSettingsFile("CCEvelynn")

    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo", "CQ")

    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo", "CE")

    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "CR")

    self.SingleR.Value = SettingsManager:GetSettingsInt("Combo", "SR")

    self.SingleRHP.Value = SettingsManager:GetSettingsInt("Combo", "SRHP")

    self.REnemies.Value = SettingsManager:GetSettingsInt("Combo", "ER")

    -------------------------------------------

    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass", "HQ")

    self.HarassQMana.Value = SettingsManager:GetSettingsInt("Harass", "HQM")

    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass", "HE")

    self.HarassEMana.Value = SettingsManager:GetSettingsInt("Harass", "HEM")

    -------------------------------------------

    self.ClearQ.Value = SettingsManager:GetSettingsInt("Clear", "CQ")

    self.ClearQMana.Value = SettingsManager:GetSettingsInt("Clear", "CQM")

    self.ClearE.Value = SettingsManager:GetSettingsInt("Clear", "CE")

    self.ClearEMana.Value = SettingsManager:GetSettingsInt("Clear", "CEM")

    -------------------------------------------

    self.DrawQRange.Value = SettingsManager:GetSettingsInt("Drawings", "DQ")

    self.DrawWRange.Value = SettingsManager:GetSettingsInt("Drawings", "DW")

    self.DrawERange.Value = SettingsManager:GetSettingsInt("Drawings", "DE")

    self.DrawRRange.Value = SettingsManager:GetSettingsInt("Drawings", "DR")

end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Evelynn:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Evelynn:getAttackRange()
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

function Evelynn:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end

function Evelynn:GetItemKey(ItemName)
	for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Evelynn:Bolt_Check()
	local Bolt			= {}
    Bolt.Key				= self:GetItemKey("ItemSoFBoltSpellBase")	
	if Bolt.Key ~= nil then
		if Engine:SpellReady(Bolt.Key) then
			return Bolt
		end
	end
	return false
end



function Evelynn:RDmg(Target)
    local RDmg = Evelynn:GetDamage(125 * myHero:GetSpellSlot(3).Level + myHero.AbilityPower * 0.75, false, Target)
    if Target.Health < (Target.MaxHealth * 0.3) then
        RDmg = RDmg * 2.4
    end
    if RDmg > Target.Health then
        return true
    end
    return false
end



function Evelynn:EnemiesRKillable(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:RDmg(Hero) then
                if GetDist(Hero.Position , Position) < Range then
                    Count = Count + 1
                end
            end
        end
    end
    return Count
end



function Evelynn:Killsteal()
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            if self:EnemiesRKillable(myHero.Position, self.RRange) >= self.REnemies.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end
end

function Evelynn:BoltCapClose()
    local target = Orbwalker:GetTarget("Combo", self.BoltRange)
    if target then
        local Bolt = self:Bolt_Check()
        if self.UseBolt.Value == 1 and Bolt ~= false then
            Engine:CastSpell(Bolt.Key, target.Position, 1)
        end
    end
end

function Evelynn:SingleTargetR()
    if self.ComboR.Value == 1 and self.SingleR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target then
            if myHero.Health <= myHero.MaxHealth / 100 * self.SingleRHP.Value then
                if self:RDmg(target) then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
            if Engine:GetForceTarget(target) then
                if self:RDmg(target) then
                    Engine:CastSpell("HK_SPELL4", target.Position, 1)
                end
            end
        end
    end
end



function Evelynn:Combo()
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if not myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                if GetDist(myHero.Position, target.Position) < self.QRange then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                    if PredPos then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    end
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                else
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                    if PredPos then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    end
                end
            end

            if myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                if GetDist(myHero.Position, target.Position) < self.QRange then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
end



function Evelynn:Harass()
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.HarassQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if not myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end

            if myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                if GetDist(myHero.Position, target.Position) < self.QRange then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                end
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if myHero.Mana <= myHero.MaxMana * self.HarassEMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
end



function Evelynn:Laneclear()
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        if myHero.Mana <= myHero.MaxMana * self.ClearQMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then print()
            if not myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
            end

            if myHero.BuffData:GetBuff("EvelynnQ2").Valid then
                if GetDist(myHero.Position, target.Position) < self.QRange then
                    Engine:CastSpell("HK_SPELL1", nil, 1)
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        if myHero.Mana <= myHero.MaxMana * self.ClearEMana.Value / 100 then return end
        local target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if target then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
end



function Evelynn:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Evelynn:Combo()
            Evelynn:BoltCapClose()
            Evelynn:SingleTargetR()
            Evelynn:Killsteal()
            return

        end

        if Engine:IsKeyDown("HK_HARASS") then
            Evelynn:Harass()
            return

        end

        if Engine:IsKeyDown("HK_LANECLEAR") then
            Evelynn:Laneclear()
            return

        end

    end

end



function Evelynn:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQRange.Value == 1 then
        Render:DrawCircle(myHero.Position, 800, 255, 0, 255, 255)
    end

    if Engine:SpellReady("HK_SPELL2") and self.DrawWRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 255, 0, 255, 255)
    end

    if Engine:SpellReady("HK_SPELL3") and self.DrawERange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 225, 0, 225, 225)
    end

    if Engine:SpellReady("HK_SPELL4") and self.DrawRRange.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 0, 255, 255)
    end

end



function Evelynn:OnLoad()

    if(myHero.ChampionName ~= "Evelynn") then return end

    AddEvent("OnSettingsSave" , function() Evelynn:SaveSettings() end)

	AddEvent("OnSettingsLoad" , function() Evelynn:LoadSettings() end)



	Evelynn:__init()

	AddEvent("OnTick", function() Evelynn:OnTick() end)

    AddEvent("OnDraw", function() Evelynn:OnDraw() end)

    print(self.ScriptVersion)

end



AddEvent("OnLoad", function() Evelynn:OnLoad() end)