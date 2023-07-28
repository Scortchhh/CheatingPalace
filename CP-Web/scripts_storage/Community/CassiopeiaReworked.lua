Cassiopeia = {}
function Cassiopeia:__init()
    self.QRange = 850
    self.WRange = 700
    self.ERange = 700
    self.RRange = 780

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QDelay = 0.5
    self.WDelay = 0.25
    self.EDelay = 0
    self.RDelay = 0.25

    self.KeyNames = {}
    self.KeyNames[4] = "HK_SUMMONER1"
    self.KeyNames[5] = "HK_SUMMONER2"

    self.KeyNames[6] = "HK_ITEM1"
    self.KeyNames[7] = "HK_ITEM2"
    self.KeyNames[8] = "HK_ITEM3"
    self.KeyNames[9] = "HK_ITEM4"
    self.KeyNames[10] = "HK_ITEM5"
    self.KeyNames[11] = "HK_ITEM6"

    --local monsterdata = {"name", "monster", "x", 64, "y", 128, "hp", 4}

    self.ChampionMenu = Menu:CreateMenu("Cassiopeia - Reworked")
    -------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    -------------------------------------------
    self.ComboEMenu = self.ComboMenu:AddSubMenu("E Settings")
    self.UseENonPoised = self.ComboEMenu:AddCheckbox("Use E if no poison?", 1)
    -------------------------------------------
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
    self.RSlider = self.ComboMenu:AddSlider("Min. Enemy to R", 3, 1, 5, 1)
    -------------------------------------------
    self.HarassOptions = self.ChampionMenu:AddSubMenu("Harass")
    self.UseQHarass = self.HarassOptions:AddCheckbox("UseQ", 0)
    self.UseEHarassLastHit = self.HarassOptions:AddCheckbox("UseE Lasthit", 1)
    -------------------------------------------
    self.LaneClearOptions = self.ChampionMenu:AddSubMenu("Laneclear")
    self.UseELaneclear = self.LaneClearOptions:AddCheckbox("UseE Lasthit", 1)
    -------------------------------------------
    self.JungleClearOptions = self.ChampionMenu:AddSubMenu("JungleClear (WIP)")
    self.UseQJungleClear = self.JungleClearOptions:AddCheckbox("UseQ", 0)
    self.UseEJungleClear = self.JungleClearOptions:AddCheckbox("UseE", 0)
    -------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 0)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 0)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 0)
    self.DrawELastHit = self.ComboMenu:AddCheckbox("Draw Minion Lasthitable with E", 1)
    self.DrawAAToggleTest = self.ComboMenu:AddCheckbox("Draw AA Toggle String", 0)
    --self.LabelTest = self.ChampionMenu:AddLabel("Testlabel")
    --self.testme = self.ChampionMenu:AddCombobox("Testlabel2", monsterdata)S


    Cassiopeia:LoadSettings()
end

function Cassiopeia:SaveSettings()
    SettingsManager:CreateSettings("Cassiopeia - Reworked")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
    SettingsManager:AddSettingsInt("RCount", self.RSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("E Settings")
    SettingsManager:AddSettingsInt("Use E if no poison?", self.UseENonPoised.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseE Lasthit", self.UseEHarassLastHit.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseE Lasthit", self.UseELaneclear.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("JungleClear")
    SettingsManager:AddSettingsInt("UseQ", self.UseQJungleClear.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseEJungleClear.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Draw Minion Lasthitable with E", self.DrawELastHit.Value)
    SettingsManager:AddSettingsInt("Draw AA Toggle String", self.DrawAAToggleTest.Value)

end

function Cassiopeia:LoadSettings()
    SettingsManager:GetSettingsFile("Cassiopeia - Reworked")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo", "UseQ")
    self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo", "UseE")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo", "UseR")
    self.RSlider.Value = SettingsManager:GetSettingsInt("Combo", "RCount")
    ------------------------------------------------------------
    self.UseENonPoised.Value = SettingsManager:GetSettingsInt("E Settings", "Use E if no poison?")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ")
    self.UseEHarassLastHit.Value = SettingsManager:GetSettingsInt("Harass", "UseE Lasthit")
    -------------------------------------------
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseE Lasthit")
    ------------------------------------------------------------
    self.UseQJungleClear.Value = SettingsManager:GetSettingsInt("JungleClear", "UseQ")
    self.UseEJungleClear.Value = SettingsManager:GetSettingsInt("JungleClear", "UseE")
    ------------------------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "DrawR")
    self.DrawELastHit.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Minion Lasthitable with E")
    self.DrawAAToggleTest.Value = SettingsManager:GetSettingsInt("Drawings", "Draw AA Toggle String")
end

function Cassiopeia:GetAllItemNames()
    for i = 6, 11 do
        print(myHero:GetSpellSlot(i).Info.Name)
    end
end

function Cassiopeia:GetItemKey(ItemName)
    for i = 6, 11 do
        if myHero:GetSpellSlot(i).Info.Name == ItemName then
            return self.KeyNames[i]
        end
    end
    return nil
end

function Cassiopeia:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Cassiopeia:RCheck(Target)
    local RCount = 0
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Target.Position, Hero.Position) < 550 then
                if self:GetDistance(myHero.Position, Hero.Position) < self.RRange then
                    RCount = RCount + 1
                end
            end
        end
    end

    if RCount >= self.RSlider.Value then
        return true
    end
    return false
end

function Cassiopeia:GetRTarget()
    local Heros = ObjectManager.HeroList
    for I, Hero in pairs(Heros) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(myHero.Position, Hero.Position) < self.RRange then
                if self:RCheck(Hero) == true then
                    return Hero
                end
            end
        end
    end
    return nil
end

function Cassiopeia:CastQ()
    local StartPos = myHero.Position
    local CastPos, Target = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, 0, self.QDelay, 0)
    if CastPos ~= nil and Target ~= nil then
        if self:GetDistance(StartPos, CastPos) < self.QRange then
            --local PoisonBuff = Target.BuffData:HasBuffOfType(BuffType.Poison)
            Engine:CastSpell("HK_SPELL1", CastPos, 1)
            return
        end
    end
end

--TODO Killseal & Prio E if target killable with 1 Spell
function Cassiopeia:Combo()
    if Engine:SpellReady("HK_SPELL4") then
        if self.ComboUseR.Value == 1 then
            local Target = self:GetRTarget()
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL4", Target.Position, 1)
                return
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") then
        if self.ComboUseQ.Value == 1 then
            self:CastQ()
        end
    end
    if Engine:SpellReady("HK_SPELL3") then
        if self.ComboUseE.Value == 1 then
            local Target = Orbwalker:GetTarget("Combo", self.ERange)
            if Target ~= nil then
                if self.UseENonPoised.Value == 1 then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
                local PoisonBuff = Target.BuffData:HasBuffOfType(BuffType.Poison)
                if PoisonBuff == true then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL2") then
        if self.ComboUseW.Value == 1 then
            local Target = Orbwalker:GetTarget("Combo", self.WRange)
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                return
            end
        end
    end
end

-- TODO can we check if we target cannon minion??
function Cassiopeia:LastHitE()
    if Engine:SpellReady('HK_SPELL3') then
        local Minions = ObjectManager.MinionList
        for I, Minion in ipairs(Minions) do
            if Minion.Team ~= myHero.Team then
                if self:GetDistance(myHero.Position, Minion.Position) < (self.ERange + Minion.CharData.BoundingRadius) then
                    if Minion.IsTargetable and Orbwalker:IsValidMinion(Minion) and self:isKillableWithE(Minion) then
                        Engine:CastSpell("HK_SPELL3", Minion.Position)
                    end
                end
            end
        end
    end
end

--TODO magic resist calculations
function Cassiopeia:isKillableWithE(target)
    --Champion has Rabadon Item (40% AMP)
    local baseAP = myHero.AbilityPower
    if self:GetItemKey("ZhonyasRing") ~= nil then
        baseAP = baseAP + baseAP * 40 / 100
    end

    --Calculate Non Poisoned DMG
    local eLevelAmplifier = 0
    if myHero.Level > 1 then
        eLevelAmplifier = (myHero.Level - 1) * 4
    end
    magicDmgAmpflifier = baseAP * 10 / 100
    local eDmg = 52 + eLevelAmplifier + magicDmgAmpflifier

    --POISONED MINIONSSS
    local PoisonBuff = target.BuffData:HasBuffOfType(BuffType.Poison)
    if PoisonBuff == true then
        local additionalLevelDamage = myHero:GetSpellSlot(2).Level * 20 - 10
        local extraMagicDmg = baseAP * 60 / 100
        local ergebnis = additionalLevelDamage + extraMagicDmg
        eDmg = eDmg + additionalLevelDamage + extraMagicDmg
    end

    if target.Health <= eDmg then
        return true
    end
    return false
end

function Cassiopeia:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Cassiopeia:Combo()
            return
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseELaneclear.Value == 1 then
                Cassiopeia:LastHitE()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseEHarassLastHit.Value == 1 then
                Cassiopeia:LastHitE()
            end
            if self.UseQHarass.Value == 1 then
                Cassiopeia:CastQ()
            end
        end
    end
end

function Cassiopeia:OnDraw()
    if myHero.IsDead then
        return
    end
    if self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange, 100, 150, 255, 255)
    end
    if self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 100, 150, 255, 255)
    end
    if self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange, 100, 150, 255, 255)
    end
    if self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 100, 150, 255, 255)
    end
    if self.DrawAAToggleTest.Value == 1 then
        local vector = Vector3.new()
        if Render:World2Screen(myHero.Position, vector) then
            Render:DrawString("AA Enabled", vector.x - 40, vector.y + 60, 255, 255, 255, 255)
        end
    end
    if self.DrawELastHit.Value == 1 then
        local Minions = ObjectManager.MinionList
        for I, Minion in ipairs(Minions) do
            if Minion.Team ~= myHero.Team then
                if Minion.IsTargetable and Orbwalker:IsValidMinion(Minion) and self:isKillableWithE(Minion) then
                    local outVec = Vector3.new()
                    local MinionPos = Minion.Position
                    local MinionName = Minion.ChampionName
                    if Render:World2Screen(MinionPos, outVec) == true and MinionName ~= "SRU_ChaosMinionSiege" then
                        Render:DrawCircle(MinionPos, Minion.CharData.BoundingRadius, 0, 255, 255, 255)
                    end
                    if Render:World2Screen(MinionPos, outVec) == true and MinionName == "SRU_ChaosMinionSiege" then
                        Render:DrawCircle(MinionPos, Minion.CharData.BoundingRadius, 255, 255, 0, 255)
                    end
                end
            end
        end
    end

    if Engine:IsKeyDown("HK_LANECLEAR") then
        --Cassiopeia:GetAllItemNames()
        --Cassiopeia:TestDrawings()
        --Render:DrawString("LANECLEAR DOWN", 825,100 ,100,150,255,255)
    end
end

function Cassiopeia:TestDrawings()
    baseAP = myHero.AbilityPower
    if self:GetItemKey("ZhonyasRing") ~= nil then
        baseAP = baseAP + baseAP * 40 / 100
    end

    local eLevelAmplifier = 0
    if myHero.Level > 1 then
        eLevelAmplifier = (myHero.Level - 1) * 4
    end
    local magicDmgAmpflifier = baseAP * 10 / 100
    local eDmg = 52 + eLevelAmplifier + magicDmgAmpflifier

    local additionalLevelDamage = myHero:GetSpellSlot(2).Level * 20 - 10
    local newMagicDmgAmp = baseAP * 60 / 100
    local poisonAdditional = additionalLevelDamage + newMagicDmgAmp
    newDmg = eDmg + additionalLevelDamage + newMagicDmgAmp

    Render:DrawString(baseAP .. " myhero ability power", 825, 150, 100, 150, 255, 255)
    Render:DrawString(eDmg .. " edmg", 825, 250, 100, 150, 255, 255)
    Render:DrawString(magicDmgAmpflifier .. " magic dmg amp for basic E", 825, 200, 100, 150, 255, 255)
    Render:DrawString(poisonAdditional .. " poison additional damage", 825, 300, 100, 150, 255, 255)
    --Render:DrawString(eLevelAmplifier .. " level dmg", 825,400 ,100,150,255,255)
    --Render:DrawString(myHero:GetSpellSlot(2).Level .. " level slot E", 825,500 ,100,150,255,255)
    Render:DrawString(newDmg .. " total damage poisoned", 825, 350, 100, 150, 255, 255)
    --rabadons = self:GetItemKey("Item2420")
    --print(rabadons)

    if self:GetItemKey("Item2420") ~= nil then
        --Render:DrawString("Item2420" .. " Item2420", 825,700 ,100,150,255,255)
    end
end

function Cassiopeia:OnLoad()
    if (myHero.ChampionName ~= "Cassiopeia") then
        return
    end
    AddEvent("OnSettingsSave", function()
        Cassiopeia:SaveSettings()
    end)
    AddEvent("OnSettingsLoad", function()
        Cassiopeia:LoadSettings()
    end)

    Cassiopeia:__init()
    AddEvent("OnTick", function()
        Cassiopeia:OnTick()
    end)
    AddEvent("OnDraw", function()
        Cassiopeia:OnDraw()
    end)
end

AddEvent("OnLoad", function()
    Cassiopeia:OnLoad()
end)
