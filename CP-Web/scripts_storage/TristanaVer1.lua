local Tristana = {
    champs = {},
}

function Tristana:__init()
    self.TristanaMenu = Menu:CreateMenu("Tristana")
    self.TristanaCombo = self.TristanaMenu:AddSubMenu("Combo")
    self.TristanaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.TristanaCombo:AddCheckbox("UseQ in combo", 1)
    self.UseECombo = self.TristanaCombo:AddCheckbox("UseE in combo", 1)
    self.ComboFocusETarget = self.TristanaCombo:AddCheckbox("Force AA E target in combo", 1)
    self.UseRCombo = self.TristanaCombo:AddCheckbox("UseR in combo", 1)
    self.ETargetsCombo = self.TristanaCombo:AddSubMenu("E Whitelisting in combo")
    self.TristanaHarass = self.TristanaMenu:AddSubMenu("Harass")
    self.TristanaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.TristanaHarass:AddCheckbox("UseQ in harass", 1)
    self.UseEHarass = self.TristanaHarass:AddCheckbox("UseE in harass", 0)
    self.TristanaLaneclear = self.TristanaMenu:AddSubMenu("Laneclear")
    self.TristanaLaneclear:AddLabel("Check Spells for Laneclear:")
    self.UseQLaneclear = self.TristanaLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.QLaneclearSettings = self.TristanaLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.UseELaneclear = self.TristanaLaneclear:AddCheckbox("UseE in laneclear", 1)
    self.ELaneclearSettings = self.TristanaLaneclear:AddSubMenu("E Laneclear Settings")
    self.LaneclearEMana = self.ELaneclearSettings:AddSlider("Minimum % mana to use E", 30,1,100,1)
    self.TristanaKillSteal = self.TristanaMenu:AddSubMenu("Killsteal")
    self.TristanaKillSteal:AddLabel("Killsteal with R + E logics:")
    self.UseRKillsteal = self.TristanaKillSteal:AddCheckbox("UseR in killsteal", 1)

    Tristana:LoadSettings()
end

function Tristana:SaveSettings()
	SettingsManager:CreateSettings("Tristana")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Force AA E target in combo", self.ComboFocusETarget.Value)

    SettingsManager:AddSettingsGroup("E Whitelisting in combo")
    -- local heroList = ObjectManager.HeroList
    -- for i = 1, #heroList do
    --     if heroList[i].Team ~= myHero.Team then
    --         SettingsManager:AddSettingsInt("UseE" .. heroList[i].Index, self.champs.Value)
    --     end
    -- end
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseE in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseQ in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("UseE in laneclear", self.UseELaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneclearEMana.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Killsteal")
    SettingsManager:AddSettingsInt("UseR in killsteal", self.UseRKillsteal.Value)
end

function Tristana:LoadSettings()
	SettingsManager:GetSettingsFile("Tristana")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseR in combo")
    self.ComboFocusETarget.Value = SettingsManager:GetSettingsInt("Combo", "Force AA E target in combo")
    self.champs.Value = SettingsManager:GetSettingsInt("E Whitelisting in combo", "Force AA E target in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseE in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseQ in laneclear")
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseE in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneclearEMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
	-------------------------------------------
    self.UseRKillsteal.Value = SettingsManager:GetSettingsInt("Killsteal", "UseR in killsteal")
end


local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

local function GetDist(source, target)
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

function Tristana:TargetIsImmune(Target)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "WillRevive", "SionPassiveZombie", "rebirthready", "willrevive", "ZileanR", "gwenw_gweninsidew"
    }
    for _, BuffName in pairs(ImmuneBuffs) do
        local Buff = Target.BuffData:GetBuff(BuffName)
		if Buff.Count_Alt > 0 and Buff.Valid == true then
			return true
		end
    end
	return false
end

function Tristana:getHeroLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

local function MinionsInRange(Position, Range)
	local Count = 0 
    local Minions = ObjectManager.MinionList
    for _, Minion in pairs(Minions) do
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end


function Tristana:ComboQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Combo", getAttackRange())
        if target ~= nil and Engine:SpellReady('HK_SPELL1') then
            if ValidTarget(target) then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                    Engine:CastSpell('HK_SPELL1', nil, 0) 
                    return
                end
            end
        end 
    end
end

function Tristana:ComboE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", getAttackRange())
        if target ~= nil then
            if ValidTarget(target) then
                if GetDist(myHero.Position, target.Position) <= 1000 then
                    if self.champs["UseE" .. target.Index].Value == 1 then
                        Engine:CastSpell('HK_SPELL3', target.Position, 1) 
                        return
                    end
                end
            end 
        end  
    end
end

function Tristana:ComboR()
    if Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() then 
                    if ValidTarget(target) and self:TargetIsImmune(target) == false then 
                        local tristE = target.BuffData:GetBuff('tristanaecharge')
                        local PressTheAttackBuff = target.BuffData:GetBuff('assets/perks/styles/precision/presstheattack/presstheattackdamageamp.lua')
                        local rDmg = GetDamage(200 + (100 * myHero:GetSpellSlot(3).Level) + 1 * myHero.AbilityPower, false, target)
                        if tristE.Valid and PressTheAttackBuff.Valid then
                            local baseEDmg = GetDamage(60 + (10 * myHero:GetSpellSlot(2).Level) + (0.3 + 0.2) * myHero.BonusAttack + 0.15 * myHero.AbilityPower, true, target)
                            local bonusStackEDmg = tristE.Count_Alt * (baseEDmg + (9 + 6 * myHero:GetSpellSlot(2).Level) + 0.39 * myHero.BonusAttack + 0.15 * myHero.AbilityPower)
                            local eStackDmg = 0.3 * tristE.Count_Alt + bonusStackEDmg
                            local totalDmg = baseEDmg + eStackDmg + rDmg
                            local presstheattackFormula = 100 + (7.765 + 0.235 * Tristana:getHeroLevel() * 0)
                            local presstheattackDmg = totalDmg / 100 * presstheattackFormula
                            if target.Health <= presstheattackDmg then
                                Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                return
                            end
                        else
                            if tristE.Valid then
                                local baseEDmg = GetDamage(60 + (10 * myHero:GetSpellSlot(2).Level) + (0.3 + 0.2) * myHero.BonusAttack + 0.15 * myHero.AbilityPower, true, target)
                                local bonusStackEDmg = tristE.Count_Alt * (baseEDmg + (9 + 6 * myHero:GetSpellSlot(2).Level) + 0.39 * myHero.BonusAttack + 0.15 * myHero.AbilityPower)
                                local eStackDmg = 0.3 * tristE.Count_Alt + bonusStackEDmg
                                local totalDmg = baseEDmg + eStackDmg + rDmg
                                if target.Health <= totalDmg then
                                    Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                    return
                                end
                            else
                                if target.Health <= rDmg then
                                    Engine:CastSpell('HK_SPELL4', target.Position, 1) 
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Tristana:LaneclearQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Laneclear", getAttackRange())
        if target then 
            local sliderValue = self.LaneclearQMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if GetDist(myHero.Position, target.Position) <= getAttackRange() + 30 and myHero.Mana >= condition then
                Engine:CastSpell('HK_SPELL1', nil, 0)
                return
            end
        end
    end
end

function Tristana:LaneclearE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Laneclear", getAttackRange())
        if target then
            local sliderValue = self.LaneclearEMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
           if GetDist(myHero.Position, target.Position) <= 650 and myHero.Mana >= condition and target.Health >= 800 then
                Engine:CastSpell('HK_SPELL3', target.Position, 0) 
                return
            end
        end
    end
end

function Tristana:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        local heroList = ObjectManager.HeroList
        for i, target in pairs(heroList) do
            if target.Team ~= myHero.Team and string.len(target.ChampionName) > 1 then
                if self.champs["UseE" .. target.Index] == nil then
                    self.champs["UseE" .. target.Index] = self.ETargetsCombo:AddCheckbox("UseE on " .. target.ChampionName, 1)
                end
            end
        end
        if self.UseRKillsteal.Value == 1 then
            Tristana:ComboR()
        end
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseQCombo.Value == 1 then 
                Tristana:ComboQ()
            end
            if self.UseECombo.Value == 1 then 
                Tristana:ComboE()
            end
            if self.UseRCombo.Value == 1 then 
                Tristana:ComboR()
            end
        end
        
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then 
                Tristana:ComboQ()
            end
            if self.UseQHarass.Value == 1 then 
                Tristana:ComboE()
            end
        end
    
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                Tristana:LaneclearQ()
            end
            if self.UseELaneclear.Value == 1 then
                Tristana:LaneclearE()
            end
        end
    end
end

function Tristana:OnDraw()
    if myHero.IsDead == true then return end
end

function Tristana:OnLoad()
    if myHero.ChampionName ~= "Tristana" then return end
    AddEvent("OnSettingsSave" , function() Tristana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Tristana:LoadSettings() end)
    Tristana:__init()

    AddEvent("OnTick",function() Tristana:OnTick() end)
    AddEvent("OnDraw",function() Tristana:OnDraw() end)
end

AddEvent("OnLoad", function() Tristana:OnLoad() end)	