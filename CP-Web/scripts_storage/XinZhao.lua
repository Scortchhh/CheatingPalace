local XinZhao = {

}

function XinZhao:__init()

    self.WRange = 1000
    self.WSpeed = 6250
    self.WWidth = 80
    self.WDelay = 0.5

    self.WHitChance = 0.2

    self.XinZhaoMenu = Menu:CreateMenu("XinZhao")
    self.XinZhaoCombo = self.XinZhaoMenu:AddSubMenu("Combo")
    self.XinZhaoCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.XinZhaoCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.XinZhaoCombo:AddCheckbox("Use W in combo", 1)
    self.UseWSCombo = self.XinZhaoCombo:AddCheckbox("Use W w/ knock up only", 1)
    self.UseECombo = self.XinZhaoCombo:AddCheckbox("Use E in Combo", 1)
    self.rangeslider = self.XinZhaoCombo:AddSlider("Minimum distance to use E", 15,1,650,1)
    self.UseRCombo = self.XinZhaoCombo:AddCheckbox("Use R in Combo", 1)
    self.enemiesSlider = self.XinZhaoCombo:AddSlider("Minimum enemies to use R", 2,1,5,1)
    self.XinZhaoHarass = self.XinZhaoMenu:AddSubMenu("Harass")
    self.XinZhaoHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.XinZhaoHarass:AddCheckbox("Use Q in harass", 1)
    self.UseWHarass = self.XinZhaoHarass:AddCheckbox("Use W in harass", 0)
    self.UseEHarass = self.XinZhaoHarass:AddCheckbox("Use E in harass", 0)
    self.XinZhaoLaneclear = self.XinZhaoMenu:AddSubMenu("Laneclear")
    self.XinZhaoLaneclear:AddLabel("Check Spells for Laneclear:")
    self.UseQLaneclear = self.XinZhaoLaneclear:AddCheckbox("Use Q in laneclear", 1)
    self.QLaneclearSettings = self.XinZhaoLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.UseWLaneclear = self.XinZhaoLaneclear:AddCheckbox("Use W in laneclear", 0)
    self.WLaneclearSettings = self.XinZhaoLaneclear:AddSubMenu("W Laneclear Settings")
    self.LaneclearWMana = self.WLaneclearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)
    self.UseELaneclear = self.XinZhaoLaneclear:AddCheckbox("Use E in laneclear", 1)
    self.ELaneclearSettings = self.XinZhaoLaneclear:AddSubMenu("E Laneclear Settings")
    self.LaneclearEMana = self.ELaneclearSettings:AddSlider("Minimum % mana to use E", 30,1,100,1)
    self.XinZhaoDrawings = self.XinZhaoMenu:AddSubMenu("Drawings")
    self.DrawW = self.XinZhaoDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawE = self.XinZhaoDrawings:AddCheckbox("Use E in drawings", 1)
    self.DrawR = self.XinZhaoDrawings:AddCheckbox("Use R in drawings", 1)

    XinZhao:LoadSettings()
end

function XinZhao:SaveSettings()
	SettingsManager:CreateSettings("XinZhao")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use W w/ knock up only", self.UseWSCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Minimum distance to use E", self.rangeslider.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Minimum enemies to use R", self.enemiesSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("Use W in laneclear", self.UseWLaneclear.Value)
    SettingsManager:AddSettingsInt("Use E in laneclear", self.UseELaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.LaneclearWMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneclearEMana.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function XinZhao:LoadSettings()
	SettingsManager:GetSettingsFile("XinZhao")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseWSCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W w/ knock up only")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.rangeslider.Value = SettingsManager:GetSettingsInt("Combo", "Minimum distance to use E")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.enemiesSlider.Value = SettingsManager:GetSettingsInt("Combo", "Minimum enemies to use R")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use Q in laneclear")
    self.UseWLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use W in laneclear")
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "Use E in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneclearWMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use W")
    self.LaneclearEMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
	-------------------------------------------
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
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

function XinZhao:countEnemiesForR()
    local HeroList = ObjectManager.HeroList
    local count = 0
    for k,v in HeroList:pairs() do
        if v.Team ~= myHero.Team then
            if GetDist(myHero.Position, v.Position) <= 500 then
                count = count + 1
            end
        end
    end
    return count
end

function XinZhao:CastQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Combo", 1000)
        if target  ~= nil then
            local range = getAttackRange() + 30
            if GetDist(myHero.Position, target.Position) <= range and ValidTarget(target) then
                Engine:CastSpell("HK_SPELL1", nil)
            end
        end
    end
end

function XinZhao:CastW()
    if Engine:SpellReady('HK_SPELL2') then
        local castPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if castPos ~= nil then
            local knockUp = Target.BuffData:GetBuff('xinzhaoqknockup')
            if knockUp.Valid and self.UseWSCombo.Value == 1  then
                Engine:CastSpell("HK_SPELL2", castPos, 1)
            else
                if  self.UseWSCombo.Value == 0 then
                    Engine:CastSpell("HK_SPELL2", castPos, 1)
                end
            end
        end
    end
end

function XinZhao:LongWHarass()
    if Engine:SpellReady("HK_SPELL2") then
        local castPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if castPos ~= nil and GetDist(myHero.Position, castPos) < 950 then
            Engine:CastSpell("HK_SPELL2", castPos, 1)
            return

        end
    end
end

function XinZhao:LongeEGapCloser()
    if  Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 1100)
        if target  ~= nil then
            local range = self.rangeslider.Value
            local challenged = target.BuffData:GetBuff('slow')
            if GetDist(myHero.Position, target.Position) <= 1100 and GetDist(myHero.Position, target.Position) >= range and challenged.Count_Alt > 0 then
                Engine:CastSpell("HK_SPELL3", target.Position)
            end
        end
    end
end

function XinZhao:CastE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Combo", 650)
        if target ~= nil then
            local range = self.rangeslider.Value
            if GetDist(myHero.Position, target.Position) >= range and ValidTarget(target) then
                Engine:CastSpell("HK_SPELL3", target.Position)
            end
        end
    end
end

function XinZhao:CastR()
    if Engine:SpellReady('HK_SPELL4') then
        local target = Orbwalker:GetTarget("Combo", 500)
        if target  ~= nil then 
            local enemies = XinZhao:countEnemiesForR()
            if GetDist(myHero.Position, target.Position) <= 500 and enemies >= self.enemiesSlider.Value and ValidTarget(target) == true then
                Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    end
end

function XinZhao:LaneclearQ()
    if Engine:SpellReady('HK_SPELL1') then
        local target = Orbwalker:GetTarget("Laneclear", 1000)
        if target  ~= nil then
            if not Activator.CanBurstSmite then
                Engine:CastSpell("HK_SPELL1", target.Position, 0)
            end
        end
    end
end

function XinZhao:LaneclearW()
    if Engine:SpellReady('HK_SPELL2') then
        local target = Orbwalker:GetTarget("Laneclear", 800)
        if target ~= nil then
            if not Activator.CanBurstSmite then
                local sliderValue = self.LaneclearWMana.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if Orbwalker.Attack == 0 and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 0)
                    return
                end
            end
        end
    end
end

function XinZhao:LaneclearE()
    if Engine:SpellReady('HK_SPELL3') then
        local target = Orbwalker:GetTarget("Laneclear", 1000)
        if target ~= nil then
            if not Activator.CanBurstSmite then
                local sliderValue = self.LaneclearEMana.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, target.Position) <= 650 and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", target.Position, 0)
                    return
                end
            end
        end
    end
end

function XinZhao:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            if self.UseRCombo.Value == 1 then
                XinZhao:CastR()
            end
            if self.UseQCombo.Value == 1 then
                XinZhao:CastQ()
            end
            if self.UseECombo.Value == 1 then
                XinZhao:CastE()
                XinZhao:LongeEGapCloser()
            end
            if self.UseWCombo.Value == 1 then
                XinZhao:CastW()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.UseWHarass.Value == 1 then
                XinZhao:LongWHarass()
            end
            if self.UseEHarass.Value == 1 then
                XinZhao:LongeEGapCloser()
            end
            if self.UseWHarass.Value == 1 then
                XinZhao:CastQ()
            end
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.UseQLaneclear.Value == 1 then
                XinZhao:LaneclearQ()
            end
            if self.UseWLaneclear.Value == 1 then
                XinZhao:LaneclearW()
            end
            if self.UseELaneclear.Value == 1 then
                XinZhao:LaneclearE()
            end
        end
    end
end

function XinZhao:OnDraw()
    if myHero.IsDead then return end

    if self.DrawW.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 950,255,0,255,255)
        end
    end

    if self.DrawE.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 650,255,0,255,255)
        end
    end

    if self.DrawR.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, 500,255,0,255,255)
        end
    end
end

function XinZhao:OnLoad()
    if myHero.ChampionName ~= "XinZhao" then return end
    AddEvent("OnSettingsSave" , function() XinZhao:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() XinZhao:LoadSettings() end)
    XinZhao:__init()
    AddEvent("OnDraw", function() XinZhao:OnDraw() end)
    AddEvent("OnTick", function() XinZhao:OnTick() end)
end
AddEvent("OnLoad", function() XinZhao:OnLoad() end)