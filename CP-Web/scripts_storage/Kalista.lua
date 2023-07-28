local Kalista = {
}

function Kalista:__init()

    self.QRange = 1200
    self.QSpeed = 2400
    self.QWidth = 80
    self.QDelay = 0.25

    self.QHitChance = 0.2

    self.KalistaMenu = Menu:CreateMenu("Kalista")

    self.KalistaCombo = self.KalistaMenu:AddSubMenu("Combo")
    self.KalistaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KalistaCombo:AddCheckbox("UseQ in combo", 1)


    self.KalistaHarass = self.KalistaMenu:AddSubMenu("Harass")
    self.KalistaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KalistaHarass:AddCheckbox("UseQ in harass", 1)

    self.KalistaLaneclear = self.KalistaMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear = self.KalistaLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.UseELaneclear = self.KalistaLaneclear:AddCheckbox("UseE in laneclear", 1)


    self.KalistaKillsteal = self.KalistaMenu:AddSubMenu("Killsteal")
    self.KalistaKillsteal:AddLabel("Check Spells for Combo:")
    self.UseEKS = self.KalistaKillsteal:AddCheckbox("UseE if killable", 1)


    self.KalistaMisc = self.KalistaMenu:AddSubMenu("Misc")
    self.UseRSupportive = self.KalistaMisc:AddCheckbox("UseR to save ally", 1)
    self.GapClose = self.KalistaMisc:AddCheckbox("GapClose on minions with AA", 1)
    self.AllyRHP = self.KalistaMisc:AddSlider("Minimum % HP to use R", 20,1,100,1)


    self.KalistaDrawings = self.KalistaMenu:AddSubMenu("Drawings")
    self.DrawKillable = self.KalistaDrawings:AddCheckbox("Draw if killable", 1)
    self.DrawQ = self.KalistaDrawings:AddCheckbox("UseQ in drawings", 1)

    Kalista:LoadSettings()
end

function Kalista:SaveSettings()
	SettingsManager:CreateSettings("Kalista")
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
    SettingsManager:AddSettingsInt("GapClose", self.GapClose.Value)
    SettingsManager:AddSettingsInt("UseR on % ally HP", self.AllyRHP.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw if killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
end

function Kalista:LoadSettings()
	SettingsManager:GetSettingsFile("Kalista")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    -------------------------------------------
    self.UseEKS.Value = SettingsManager:GetSettingsInt("Killsteal", "UseE in killsteal")
    -------------------------------------------
    self.UseRSupportive.Value = SettingsManager:GetSettingsInt("Misc", "UseR Supportive")
    self.GapClose.Value = SettingsManager:GetSettingsInt("Misc", "GapClose")
    self.AllyRHP.Value = SettingsManager:GetSettingsInt("Misc", "UseR on % ally HP")
	-------------------------------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
end

function Kalista:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Kalista:GetDist(source, target)
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

function Kalista:UseGapClose()
    local target = Orbwalker:GetTarget("Combo", self:GetAttackRange() * 3)
    if target then
        if self:GetDist(myHero.Position, target.Position) > self:GetAttackRange() - 100 then
            local MinionList = ObjectManager.MinionList
            local closestMinionToTarget = nil
            for i, Minion in pairs(MinionList) do
                if not Minion.IsDead and Minion.IsTargetable and Minion.MaxHealth > 12 then
                    if self:GetDist(myHero.Position, Minion.Position) <= self:GetAttackRange() then
                        if closestMinionToTarget == nil then
                            closestMinionToTarget = Minion
                        end
                        if closestMinionToTarget ~= nil then
                            if self:GetDist(Minion.Position, target.Position) < self:GetDist(closestMinionToTarget.Position, target.Position) then
                                closestMinionToTarget = Minion
                            end
                        end
                    end
                end
            end
            if Orbwalker:CanMove() and closestMinionToTarget ~= nil then
                Orbwalker:IssueAttack(closestMinionToTarget.Position, closestMinionToTarget)
            end
        end
    end
end

function Kalista:CastQ(mode)
    if Engine:SpellReady('HK_SPELL1') then
        if mode == "Combo" then
            local target = Orbwalker:GetTarget("Combo", 1300)
            if target then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
        end
        if mode == "Laneclear" then
            local target = Orbwalker:GetTarget("Laneclear", 1300)
            if target then
                local dmg = (-45 + (65 * myHero:GetSpellSlot(0).Level) + 1 * getTotalAD())
                local totalDmg = GetDamage(dmg, true, target) - 10
                if target.Health <= totalDmg then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                end
            end
        end
    end
end

function Kalista:CastE(mode)
    if Engine:SpellReady('HK_SPELL3') then
        if mode == "Combo" then
            local target = Orbwalker:GetTarget("Combo", 1200)
            if target then
                local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
                if kalistaE then
                    local baseDmg = 10 + (10 * myHero:GetSpellSlot(2).Level) + 0.6 * getTotalAD()
                    local stackDmg
                    if myHero:GetSpellSlot(2).Level == 1 then
                        stackDmg = (10 + (0.19 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 2 then
                        stackDmg = (14 + (0.23 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 3 then
                        stackDmg = (19 + (0.27 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 4 then
                        stackDmg = (25 + (0.31 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 5 then
                        stackDmg = (32 + (0.34 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    end
                    local totalDmg = GetDamage(baseDmg + stackDmg, true, target)
                    if target.Health <= totalDmg then
                        Engine:CastSpell('HK_SPELL3', nil)
                    end
                end
            end
        end

        if mode == "Laneclear" then
            local target = Orbwalker:GetTarget("Laneclear", 1200)
            if target then
                local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
                if kalistaE then
                    local baseDmg = 10 + (10 * myHero:GetSpellSlot(2).Level) + 0.6 * getTotalAD()
                    local stackDmg
                    if myHero:GetSpellSlot(2).Level == 1 then
                        stackDmg = (10 + (0.19 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 2 then
                        stackDmg = (14 + (0.23 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 3 then
                        stackDmg = (19 + (0.27 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 4 then
                        stackDmg = (25 + (0.31 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    elseif myHero:GetSpellSlot(2).Level == 5 then
                        stackDmg = (32 + (0.34 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                    end
                    local CampNames = {
                        "SRU_Dragon_Air",
                        "SRU_Dragon_Fire",
                        "SRU_Dragon_Water",
                        "SRU_Dragon_Earth",
                        "SRU_Dragon_Ruined",
                        "SRU_Baron12.1.1",
                        "SRU_RiftHerald17.1.1",
                    }
                    if target ~= nil and target.IsMinion == true and target.IsTargetable == true then
                        for I, Name in pairs(CampNames) do
                            if Name == target.Name then
                                stackDmg = stackDmg/2
                            end
                        end
                    end
                    local totalDmg = GetDamage(baseDmg + stackDmg, true, target)
                    if target.Health <= totalDmg then
                        Engine:CastSpell('HK_SPELL3', nil)
                    end
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
                if self:GetDist(myHero.Position, ally.Position) <= 1000 then
                    local isOatSworn = ally.BuffData:GetBuff("nevershade")
                    if isOatSworn then
                        local allyRHP = self.AllyRHP.Value
                        local Rcondition = ally.MaxHealth / 100 * allyRHP
                        if ally.Health <= Rcondition then
                            Engine:CastSpell('HK_SPELL4', nil)
                        end
                    end
                end
            end
        end
    end
end

function Kalista:Damage(Target)

    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {20, 85, 150, 215, 280}
        Qbonus = (getTotalAD() * 1)
        QQdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
    end


        local totalDmg = 0
        local baseDmg = 0
        local stackDmg = 0
        local ELevel = myHero:GetSpellSlot(2).Level
        local target = Orbwalker:GetTarget("Combo", 1200)
        if ELevel ~= 0 and target ~= nil then
            local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
            if kalistaE then
                    baseDmg = 10 + (10 * myHero:GetSpellSlot(2).Level) + 0.6 * getTotalAD()
                if myHero:GetSpellSlot(2).Level == 1 then
                    stackDmg = (10 + (0.19 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                elseif myHero:GetSpellSlot(2).Level == 2 then
                    stackDmg = (14 + (0.23 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                elseif myHero:GetSpellSlot(2).Level == 3 then
                    stackDmg = (19 + (0.27 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                elseif myHero:GetSpellSlot(2).Level == 4 then
                    stackDmg = (25 + (0.31 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                elseif myHero:GetSpellSlot(2).Level == 5 then
                    stackDmg = (32 + (0.34 * getTotalAD())) * (kalistaE.Count_Alt - 1)
                end
                totalDmg = GetDamage(baseDmg + stackDmg, true, target)
            end
        end


    local FinalFullDmg = 0

    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        FinalFullDmg = (FinalFullDmg + QQdmg)
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseEKS.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", 1200)
        if ELevel ~= 0 and target ~= nil then
            local kalistaE = target.BuffData:GetBuff('kalistaexpungemarker')
            if kalistaE then
                FinalFullDmg = (FinalFullDmg + totalDmg)
            end
        end
    end

    return FinalFullDmg
end

function Kalista:KillHealthBox()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team then
            if Hero.IsTargetable then

                local CurrentDmg = self:Damage(Hero) --Switch this part of the code from where dmg calcs comes from!
                local KillCombo = "KILLABLE"
                local CurrentHP = Hero.Health
                local MaxHP = Hero.MaxHealth
                local KillDraw = string.format("%.0f", CurrentDmg) .. " / " .. string.format("%.0f", CurrentHP)
                local fullHpDrawWidth = 104
                local damageDrawWidth = 0
                local damageStartingX = 0
                local damageEndingPos = 0
                local hpDrawWidth = 104 * (Hero.Health / Hero.MaxHealth)
                local lostHP = 104 - (Hero.MaxHealth - Hero.Health) / Hero.MaxHealth

                damageDrawWidth = (hpDrawWidth - hpDrawWidth * ((Hero.Health - CurrentDmg) / Hero.Health))
                damageEndingPos = damageDrawWidth
                if CurrentDmg >= Hero.Health then
                    damageEndingPos =  hpDrawWidth
                end

                damageStartingX = hpDrawWidth - damageDrawWidth
                if damageStartingX <= 0 then
                    damageStartingX = 0
                end
    
                local vecOut = Vector3.new()

                if Render:World2Screen(Hero.Position, vecOut) then 
                    if CurrentDmg < CurrentHP then
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 248, 252, 3, 255)
                    end
                    if CurrentDmg > CurrentHP then
                        Render:DrawString(KillCombo, vecOut.x - 50 , vecOut.y - 220, 92, 255, 5, 255)
                        Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 200, 92, 255, 5, 255)
                    end
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180 , fullHpDrawWidth,  6, 0, 0, 0, 200)
                    Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 180, hpDrawWidth,  6, 92, 255, 5, 200)
                    Render:DrawFilledBox(vecOut.x - 49 + damageStartingX , vecOut.y - 180 , damageEndingPos,  6,153, 0, 0, 240)
                end
            end
        end
    end
end

function Kalista:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.UseEKS.Value == 1 then
            Kalista:CastE("Combo")
        end
        if Engine:IsKeyDown("HK_COMBO") then
            if self.GapClose.Value == 1 then
                self:UseGapClose()
            end
            if self.UseQCombo.Value == 1 then
                Kalista:CastQ("Combo")
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseQHarass.Value == 1 then
                Kalista:CastQ("Combo")
            end
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                Kalista:CastQ("Laneclear")
            end
            if self.UseELaneclear.Value == 1 then
                Kalista:CastE("Laneclear")
            end
        end
        if self.UseRSupportive.Value == 1 then
            Kalista:CastRSupportive()
        end
    end
end

function Kalista:OnDraw()
    if myHero.IsDead == nil then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if self.DrawQ.Value == 1 and Engine:SpellReady('HK_SPELL1') then
            Render:DrawCircle(myHero.Position, 1300,255,0,255,255)
        end
        if self.DrawKillable.Value == 1 then
            self:KillHealthBox()
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