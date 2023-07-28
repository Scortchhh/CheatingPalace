local Kalista = {
}

function Kalista:__init()
    self.KalistaMenu = Menu:CreateMenu("Kalista")
    self.KalistaCombo = self.KalistaMenu:AddSubMenu("Combo")
    self.KalistaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KalistaCombo:AddCheckbox("UseQ in combo", 1)
    self.KalistaHarass = self.KalistaMenu:AddSubMenu("Harass")
    self.KalistaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KalistaHarass:AddCheckbox("UseQ in harass", 1)
    self.KalistaKillsteal = self.KalistaMenu:AddSubMenu("Killsteal")
    self.KalistaKillsteal:AddLabel("Check Spells for Combo:")
    self.UseEKS = self.KalistaKillsteal:AddCheckbox("UseE if killable", 1)
    self.KalistaMisc = self.KalistaMenu:AddSubMenu("Misc")
    self.UseRSupportive = self.KalistaMisc:AddCheckbox("UseR to save ally", 1)
    self.AllyRHP = self.KalistaMisc:AddSlider("Minimum % HP to use R", 20,1,100,1)
    self.KalistaDrawings = self.KalistaMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KalistaDrawings:AddCheckbox("UseQ in drawings", 1)

    Kalista:LoadSettings()
end

function Kalista:SaveSettings()
	SettingsManager:CreateSettings("ReworkedKalista")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Killsteal")
    SettingsManager:AddSettingsInt("UseE in killsteal", self.UseEKS.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("UseR Supportive", self.UseRSupportive.Value)
    SettingsManager:AddSettingsInt("UseR on % ally HP", self.AllyRHP.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
end

function Kalista:LoadSettings()
	SettingsManager:GetSettingsFile("ReworkedKalista")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    -------------------------------------------
    self.UseEKS.Value = SettingsManager:GetSettingsInt("Killsteal", "UseE in killsteal")
    -------------------------------------------
    self.UseRSupportive.Value = SettingsManager:GetSettingsInt("Misc", "UseR Supportive")
    self.AllyRHP.Value = SettingsManager:GetSettingsInt("Misc", "UseR on % ally HP")
	-------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
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

local function ValidTarget(target)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function getTotalAD()
    return myHero.BaseAttack + myHero.BonusAttack
end

function Kalista:GetLevel()
    local levelQ = myHero:SpellSlot(0).Level
    local levelW = myHero:SpellSlot(1).Level
    local levelE = myHero:SpellSlot(2).Level
    local levelR = myHero:SpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Kalista:CastQCombo()
    if Engine:SpellReady('HK_SPELL1') then
        local Range = self.ERange + myHero.CharData.BoundingRadius
        local target = Orbwalker:GetTarget("Combo", 1300)
        if target then
            if Orbwalker:GetTarget("Combo", Range + 300) == target then
                if GetDist(myHero.Position, target.Position) <= Range then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                        local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1500, 110, 0.25, 1)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", castPos, 1)
                            return
                        end
                    end
                else
                    if GetDist(Vector3.new(), target.Position) <= GetDist(myHero.Position, target.Position) then
                        local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1500, 110, 0.25, 1)
                        if castPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", castPos, 1)
                            return
                        end
                    end
                end
            end
        end
        local QLevel = myHero:SpellSlot(0).Level
        local Damage = -45 + 65 * QLevel
        if target.Health <= GetDamage(Damage, true, target) then
            local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1500, 110, 0.25, 1)
            if castPos ~= nil then
                Engine:CastSpell("HK_SPELL1", castPos, 1)
                return
            end
        end
    end
end

function Kalista:CastQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Combo", 1300)
        if target then
            local castPos = Prediction:GetCastPos(myHero.Position, 1100, 1500, 110, 0.25, 1)
            if castPos ~= nil then
                Engine:CastSpell("HK_SPELL1", castPos, 1)
            end
        end
    end
end

function Kalista:CastE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
            if kalistaE then
                local baseDmg = 10 + (10 * myHero:GetSpellSlot(2).Level) + 0.6 * getTotalAD()
                local stackDmg
                if myHero:GetSpellSlot(2).Level == 1 then
                    stackDmg = (10 + (0.19 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 2 then
                    stackDmg = (14 + (0.23 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 3 then
                    stackDmg = (19 + (0.27 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 4 then
                    stackDmg = (25 + (0.31 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 5 then
                    stackDmg = (32 + (0.34 * getTotalAD())) * kalistaE.Count_Alt
                end
                local totalDmg = GetDamage(baseDmg + stackDmg, true, target)
                if target.Health <= totalDmg then
                    Engine:CastSpell('HK_SPELL3', GameHud.MousePos)
                end
            end
        end
    end
end
--exaltedwithbaronnashor
function Kalista:CastEClear()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if target then
            local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
            if kalistaE then
                local baseDmg = 10 + (10 * myHero:GetSpellSlot(2).Level) + 0.6 * getTotalAD()
                local stackDmg
                if myHero:GetSpellSlot(2).Level == 1 then
                    stackDmg = (10 + (0.19 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 2 then
                    stackDmg = (14 + (0.23 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 3 then
                    stackDmg = (19 + (0.27 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 4 then
                    stackDmg = (25 + (0.31 * getTotalAD())) * kalistaE.Count_Alt
                elseif myHero:GetSpellSlot(2).Level == 5 then
                    stackDmg = (32 + (0.34 * getTotalAD())) * kalistaE.Count_Alt
                end
                local totalDmg = GetDamage(baseDmg + stackDmg, true, target)
                if target.Health <= (totalDmg * 0.50) then
                    Engine:CastSpell('HK_SPELL3', GameHud.MousePos)
                end
            end
        end
    end
end

function Kalista:CastRSupportive()
    if Engine:SpellReady('HK_SPELL4')  then
        local HeroList = ObjectManager.HeroList
        for i, ally in pairs(HeroList) do
            if ally.Team == myHero.Team and ally.ChampionName ~= myHero.ChampionName then
                if GetDist(myHero.Position, ally.Position) <= 1000 then
                    local isOatSworn = ally.BuffData:GetBuff("nevershade")
                    if isOatSworn then
                        local allyRHP = self.AllyRHP.Value
                        local Rcondition = ally.MaxHealth / 100 * allyRHP
                        if ally.Health <= Rcondition then
                            Engine:CastSpell('HK_SPELL4', GameHud.MousePos)
                        end
                    end
                end
            end
        end
    end
end

function Kalista:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseQCombo.Value == 1 then
                Kalista:CastQ()
            end
            if self.UseEKS.Value == 1 then
                Kalista:CastE()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then
                Kalista:CastQ()
            end
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseEKS.Value == 1 then
                Kalista:CastEClear()
            end
        end
        if self.UseRSupportive.Value == 1 then
            Kalista:CastRSupportive()
        end
    end
    -- print(myHero:SpellSlot(1).SpellInfo.Name)
    -- for k,v in myHero.BuffManager.Buffs:pairs() do
    --     print(v.Name)
    -- end
end

function Kalista:OnDraw()
    if myHero.IsDead == nil then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then
            Render:DrawCircle(myHero.Position, 1300,255,0,255,255)
        end
    end
end

function Kalista:OnLoad()
    if myHero.ChampionName ~= "Kalista" then return end
    AddEvent("OnSettingsSave" , function() Kalista:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kalista:LoadSettings() end)
    Kalista:__init()
    AddEvent("OnDraw", function() Kalista:OnDraw() end)
    AddEvent("OnTick", function() Kalista:OnTick() end)
end
AddEvent("OnLoad", function() Kalista:OnLoad() end)