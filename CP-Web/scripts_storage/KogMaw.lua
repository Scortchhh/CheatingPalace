require("BuffLib")
require("Enums")
require("DamageLib")
require("SpellLib")
require("ItemLib")
require("ObjectLib")
require("VectorCalculations")

local KogMaw = {
}

function KogMaw:__init()

    self.QHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.KogMawMenu = Menu:CreateMenu("KogMaw")
    self.KogMawCombo = self.KogMawMenu:AddSubMenu("Combo")
    self.KogMawCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.KogMawCombo:AddCheckbox("UseQ in combo", 1)
    self.UseWCombo = self.KogMawCombo:AddCheckbox("UseW in combo", 1)
    self.UseECombo = self.KogMawCombo:AddCheckbox("UseE in combo", 1)
    self.UseRCombo = self.KogMawCombo:AddCheckbox("UseR in combo", 1)
    self.CombodisableRinAA = self.KogMawCombo:AddCheckbox("Don't use R in AA", 0)
    self.KogMawR = self.KogMawCombo:AddSubMenu("Combo R Settings")
    self.ComboRsliderRStacks = self.KogMawR:AddSlider("Max R Stacks Combo", 4,1,8,1)
    self.ComboRmanaSlider = self.KogMawR:AddSlider("Minimum % of Mana to use R Combo", 30,1,100,1)
    self.ComboRenemySlider = self.KogMawR:AddSlider("Use R below % Enemy HP", 30,1,100,1)
    self.KogMawHarass = self.KogMawMenu:AddSubMenu("Harass")
    self.KogMawHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.KogMawHarass:AddCheckbox("UseQ in harass", 0)
    self.UseWHarass = self.KogMawHarass:AddCheckbox("UseW in harass", 1)
    self.UseEHarass = self.KogMawHarass:AddCheckbox("UseE in harass", 0)
    self.KogMawLaneclear = self.KogMawMenu:AddSubMenu("Laneclear")
    self.UseQLaneclear = self.KogMawLaneclear:AddCheckbox("UseQ in laneclear", 1)
    self.QLaneclearSettings = self.KogMawLaneclear:AddSubMenu("Q Laneclear Settings")
    self.LaneclearQMana = self.QLaneclearSettings:AddSlider("Minimum % mana to use Q", 30,1,100,1)
    self.UseWLaneclear = self.KogMawLaneclear:AddCheckbox("UseW in laneclear", 1)
    self.WLaneclearSettings = self.KogMawLaneclear:AddSubMenu("W Laneclear Settings")
    self.LaneclearWMana = self.WLaneclearSettings:AddSlider("Minimum % mana to use W", 30,1,100,1)
    self.UseELaneclear = self.KogMawLaneclear:AddCheckbox("UseE in laneclear", 1)
    self.ELaneclearSettings = self.KogMawLaneclear:AddSubMenu("E Laneclear Settings")
    self.LaneclearEMana = self.ELaneclearSettings:AddSlider("Minimum % mana to use E", 30,1,100,1)
    self.KogMawKillsteal = self.KogMawMenu:AddSubMenu("Killsteal")
    self.KogMawKillsteal:AddLabel("Killsteal Settings")
    self.UseQKillsteal = self.KogMawKillsteal:AddCheckbox("UseQ in killsteal", 0)
    self.UseEKillsteal = self.KogMawKillsteal:AddCheckbox("UseE in killsteal", 0)
    self.UseRKillsteal = self.KogMawKillsteal:AddCheckbox("UseR in killsteal", 1)
    self.KillstealKogMawR = self.KogMawKillsteal:AddSubMenu("Killsteal R Settings")
    self.KillstealsliderRStacks = self.KillstealKogMawR:AddSlider("Max R Stacks Killsteal", 2,1,8,1)
    self.KillstealmanaSlider = self.KillstealKogMawR:AddSlider("Minimum % of Mana to use R Killsteal", 30,1,100,1)
    self.KogMawDrawings = self.KogMawMenu:AddSubMenu("Drawings")
    self.DrawQ = self.KogMawDrawings:AddCheckbox("UseQ in drawings", 1)
    self.DrawW = self.KogMawDrawings:AddCheckbox("UseW in drawings", 1)
    self.DrawE = self.KogMawDrawings:AddCheckbox("UseE in drawings", 1)
    self.DrawR = self.KogMawDrawings:AddCheckbox("UseR in drawings", 1)

    KogMaw:LoadSettings()
end

function KogMaw:SaveSettings()
	SettingsManager:CreateSettings("KogMaw")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("UseW in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("UseE in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("UseR in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Don't use R in AA", self.CombodisableRinAA.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Combo R Settings")
    SettingsManager:AddSettingsInt("Max R Stacks Combo", self.ComboRsliderRStacks.Value)
    SettingsManager:AddSettingsInt("Minimum % of Mana to use R Combo", self.ComboRmanaSlider.Value)
    SettingsManager:AddSettingsInt("Use R below % Enemy HP", self.ComboRenemySlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseW in harass", self.UseWHarass.Value)
    SettingsManager:AddSettingsInt("UseE in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Killsteal")
    SettingsManager:AddSettingsInt("UseQ in killsteal", self.UseQKillsteal.Value)
    SettingsManager:AddSettingsInt("UseE in killsteal", self.UseEKillsteal.Value)
    SettingsManager:AddSettingsInt("UseR in killsteal", self.UseRKillsteal.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Killsteal R Settings")
    SettingsManager:AddSettingsInt("Max R Stacks Killsteal", self.KillstealsliderRStacks.Value)
    SettingsManager:AddSettingsInt("Minimum % of Mana to use R Killsteal", self.KillstealmanaSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("UseQ in laneclear", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("UseW in laneclear", self.UseWLaneclear.Value)
    SettingsManager:AddSettingsInt("UseE in laneclear", self.UseELaneclear.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use Q", self.LaneclearQMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use W", self.LaneclearWMana.Value)
    SettingsManager:AddSettingsInt("Minimum % mana to use E", self.LaneclearEMana.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("UseQ in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("UseW in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("UseE in drawings", self.DrawE.Value)
    SettingsManager:AddSettingsInt("UseR in drawings", self.DrawR.Value)
end

function KogMaw:LoadSettings()
	SettingsManager:GetSettingsFile("KogMaw")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "UseE in combo")
    self.CombodisableRinAA.Value = SettingsManager:GetSettingsInt("Combo", "Don't use R in AA")
    self.ComboRsliderRStacks.Value = SettingsManager:GetSettingsInt("Combo R Settings", "Max R Stacks Combo")
    self.ComboRmanaSlider.Value = SettingsManager:GetSettingsInt("Combo R Settings", "Minimum % of Mana to use R Combo")
    self.ComboRenemySlider.Value = SettingsManager:GetSettingsInt("Combo R Settings", "Use R below % Enemy HP")
    -------------------------------------------
    self.UseQKillsteal.Value = SettingsManager:GetSettingsInt("Killsteal", "UseQ in killsteal")
    self.UseEKillsteal.Value = SettingsManager:GetSettingsInt("Killsteal", "UseE in killsteal")
    self.UseRKillsteal.Value = SettingsManager:GetSettingsInt("Killsteal", "UseR in killsteal")
    self.KillstealsliderRStacks.Value = SettingsManager:GetSettingsInt("Killsteal R Settings", "Max R Stacks Killsteal")
    self.KillstealmanaSlider.Value = SettingsManager:GetSettingsInt("Killsteal R Settings", "Minimum % of Mana to use R Killsteal")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ in harass")
    self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseW in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseE in harass")
    -------------------------------------------
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseQ in laneclear")
    self.UseWLaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseW in laneclear")
    self.UseELaneclear.Value = SettingsManager:GetSettingsInt("Laneclear", "UseE in laneclear")
    self.LaneclearQMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use Q")
    self.LaneclearWMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use W")
    self.LaneclearEMana.Value = SettingsManager:GetSettingsInt("Laneclear", "Minimum % mana to use E")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "UseQ in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "UseW in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "UseE in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "UseR in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

function KogMaw:CastQ()
    if Engine:SpellReady(SpellKey.Q) then
        local target = Orbwalker:GetTarget("Combo", SpellLib.KogMaw.Q:Range()+100)
        if target and target.IsTargetable then
            local castPos = Prediction:GetCastPos(myHero.Position, SpellLib.KogMaw.Q:Range(), SpellLib.KogMaw.Q:Speed(), SpellLib.KogMaw.Q:Width(), SpellLib.KogMaw.Q:Delay(), 1, true, self.QHitChance, 1)
            if castPos ~= nil then
                Engine:CastSpell(SpellKey.Q, castPos, 1)
            end
        end
    end
end

function KogMaw:CastW()
    if Engine:SpellReady(SpellKey.W) then
        local range = SpellLib.KogMaw.W:Range()
        local target = Orbwalker:GetTarget("Combo", range)
        if target and target.IsTargetable then
            if VectorCalculations:GetDistance(myHero.Position, target.Position) <= range + 10 then
                if ValidTarget(target) then
                    Engine:CastSpell(SpellKey.W, nil)
                end
            end
        end
    end
end

function KogMaw:CastE()
    if Engine:SpellReady(SpellKey.E) then
        local target = Orbwalker:GetTarget("Combo", SpellLib.KogMaw.E:Range())
        if target and target.IsTargetable then
            local castPos = Prediction:GetCastPos(myHero.Position, SpellLib.KogMaw.E:Range(), SpellLib.KogMaw.E:Speed(), SpellLib.KogMaw.E:Width(), SpellLib.KogMaw.E:Delay(), 0, true, self.EHitChance, 1)
            if castPos ~= nil then
                Engine:CastSpell(SpellKey.E, castPos, 1)
            end
        end
    end
end

function KogMaw:CastR()
    if Engine:SpellReady(SpellKey.R) then
        local range = SpellLib.KogMaw.R:Range()
        local target = Orbwalker:GetTarget("Combo", range)
        if target then
            local manaMinimum = self.ComboRmanaSlider.Value
            local ManaCondition = myHero.MaxMana / 100 * manaMinimum
            local RBuff = BuffLib.KogMaw:Artillery(myHero)
            local RStacks = BuffLib.KogMaw:ArtilleryStacks(myHero)
            if ((RBuff and RStacks < self.ComboRsliderRStacks.Value) or not(RBuff)) and  myHero.Mana >= ManaCondition then
                local castPos = Prediction:GetCastPos(myHero.Position, range, SpellLib.KogMaw.R:Speed(), SpellLib.KogMaw.R:Width(), SpellLib.KogMaw.R:Delay(), 0, 0, 0.01, 0)
                if castPos ~= nil then
                    local enemyHP = self.ComboRenemySlider.Value
                    local EnemyHPCondition = target.MaxHealth / 100 * enemyHP
                    if ValidTarget(target) and target.Health <= EnemyHPCondition
                    and (self.CombodisableRinAA.Value == 0 
                        or (self.CombodisableRinAA.Value == 1 and VectorCalculations:GetDistance(myHero.Position, target.Position) >= getAttackRange())) 
                    then
                        return Engine:CastSpell(SpellKey.R, castPos, 1)
                    end
                end
            end
        end
    end
end

function KogMaw:KS()
    local HeroList = ObjectManager.HeroList
    for i, target in pairs(HeroList) do
        if target.Team ~= myHero.Team and target.IsTargetable then
            if self.UseQKillsteal.Value == 1 and Engine:SpellReady(SpellKey.Q) and VectorCalculations:GetDistance(myHero.Position, target.Position) <= SpellLib.KogMaw.Q:Range() then
                if target.Health <= DamageLib.KogMaw:GetQDmg(target) then
                    local castPos = Prediction:GetCastPos(myHero.Position, SpellLib.KogMaw.Q:Range(), SpellLib.KogMaw.Q:Speed(), SpellLib.KogMaw.Q:Width(), SpellLib.KogMaw.Q:Delay(), 1, true, self.QHitChance, 1)
                    if castPos ~= nil then
                        Engine:CastSpell(SpellKey.Q, castPos, 1)
                    end
                end
            end

            if self.UseEKillsteal.Value == 1 and Engine:SpellReady(SpellKey.E) and VectorCalculations:GetDistance(myHero.Position, target.Position) <= SpellLib.KogMaw.E:Range() then
                if target.Health <= DamageLib.KogMaw:GetEDmg(target) then
                    local castPos = Prediction:GetCastPos(myHero.Position, SpellLib.KogMaw.E:Range(), SpellLib.KogMaw.E:Speed(), SpellLib.KogMaw.E:Width(), SpellLib.KogMaw.E:Delay(), 0, true, self.EHitChance, 1)
                    if castPos ~= nil then
                        return Engine:CastSpell(SpellKey.E, castPos, 1)
                    end
                end
            end

            if self.UseRKillsteal.Value == 1 and Engine:SpellReady(SpellKey.R) and VectorCalculations:GetDistance(myHero.Position, target.Position) <= SpellLib.KogMaw.R:Range() then
                local range = SpellLib.KogMaw.R:Range()
                local manaMinimum = self.ComboRmanaSlider.Value
                local ManaCondition = myHero.MaxMana / 100 * manaMinimum
                local RBuff = BuffLib.KogMaw:Artillery(myHero)
                local RStacks = BuffLib.KogMaw:ArtilleryStacks(myHero)
                
                if ((RBuff and RStacks < self.KillstealsliderRStacks.Value) or not(RBuff)) and DamageLib.KogMaw:GetRDmg(target) > target.Health then
                    local castPos, _ = Prediction:GetPredictionPosition(target, myHero.Position, SpellLib.KogMaw.R:Speed(), SpellLib.KogMaw.R:Delay(), 240, 0, 0 , 0.01, 0)
                    if castPos ~= nil then
                        if ValidTarget(target) and VectorCalculations:GetDistance(myHero.Position, target.Position) >= getAttackRange() then
                            return Engine:CastSpell(SpellKey.R, castPos, 1)
                        end
                    end
                end
            end

        end
    end
end

function KogMaw:LaneclearQ()
    if Engine:SpellReady(SpellKey.Q) then
        local target = Orbwalker:GetTarget("Laneclear", SpellLib.KogMaw.Q:Range())
        if target then
            if target.IsHero or target.IsMinion then
                local sliderValue = self.LaneclearQMana.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                local range = getAttackRange() + 30
                if VectorCalculations:GetDistance(myHero.Position, target.Position) <= range and myHero.Mana >= condition then
                    Engine:CastSpell(SpellKey.Q, target.Position)
                end
            end
        end
    end
end

function KogMaw:LaneclearW()
    if Engine:SpellReady(SpellKey.W) then
        local range = SpellLib.KogMaw.W:Range()
        local target = Orbwalker:GetTarget("Laneclear", range + 300)
        if target then 
            local sliderValue = self.LaneclearWMana.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if VectorCalculations:GetDistance(myHero.Position, target.Position) <= range and myHero.Mana >= condition then
                Engine:CastSpell(SpellKey.W, nil)
            end
        end
    end
end

function KogMaw:LaneclearE()
    if Engine:SpellReady(SpellKey.E) then
        local target = Orbwalker:GetTarget("Laneclear", SpellLib.KogMaw.E:Range())
        if target then 
            if target.IsHero or target.IsMinion then
                local sliderValue = self.LaneclearEMana.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if VectorCalculations:GetDistance(myHero.Position, target.Position) <= 650 and myHero.Mana >= condition then
                    Engine:CastSpell(SpellKey.E, target.Position)
                end
            end
        end
    end
end

function KogMaw:GetObjectsOnMouseposition()
    local Missiles 					= ObjectManager.MissileList
    local Minions 					= ObjectManager.MinionList
    local Heroes                    = ObjectManager.HeroList

    --[[ for _, Missile in pairs(Missiles) do
        if Missile.Team == myHero.Team and VectorCalculations:GetDistance(Missile.Position, GameHud.MousePos) < 500 then
            print("Missile  ",Missile.Name)
        end
    end

    for _, Missile in pairs(Minions) do
        if Missile.Team == myHero.Team and VectorCalculations:GetDistance(Missile.Position, GameHud.MousePos) < 500 then
            print("Minion  ", Missile.Name)
        end
    end ]]

    for _, Hero in pairs(Heroes) do
        if VectorCalculations:GetDistance(Hero.Position, GameHud.MousePos) < 500 then
            print(Hero.BuffData:ShowAllBuffs())
        end
    end
end

function KogMaw:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        if self.UseRKillsteal.Value == 1 or self.UseQKillsteal.Value == 1 or self.UseEKillsteal.Value == 1 then
            KogMaw:KS()
        end
    
        if Engine:IsKeyDown(UIKeys.Combo) then
            --self:GetObjectsOnMouseposition()
            if self.UseQCombo.Value == 1 then
                KogMaw:CastQ()
            end
            if self.UseWCombo.Value == 1 then
                KogMaw:CastW()
            end
            if self.UseECombo.Value == 1 then
                KogMaw:CastE()
            end
            if self.UseRCombo.Value == 1 then
                KogMaw:CastR()
            end
        end
        if Engine:IsKeyDown(UIKeys.Harass) then
            if self.UseQHarass.Value == 1 then
                KogMaw:CastQ()
            end
            if self.UseWHarass.Value == 1 then
                KogMaw:CastW()
            end
            if self.UseEHarass.Value == 1 then
                KogMaw:CastE()
            end
        end
        if Engine:IsKeyDown(UIKeys.LaneClear) then
            if self.UseQLaneclear.Value == 1 then
                KogMaw:LaneclearQ()
            end
            if self.UseWLaneclear.Value == 1 then
                KogMaw:LaneclearW()
            end
            if self.UseELaneclear.Value == 1 then
                KogMaw:LaneclearE()
            end
        end
    end
end

function KogMaw:DrawDmg()
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team then
			local Damages = {}
			table.insert( Damages, {
				Damage = DamageLib.KogMaw:GetAADmg(Hero),
				Color = Colors.Pink,
			})

			if Engine:SpellReady(SpellKey.Q) then
				table.insert( Damages, {
					Damage = DamageLib.KogMaw:GetQDmg(Hero),
					Color = Colors.Blue,
				})
			end

            if Engine:SpellReady(SpellKey.E) then
				table.insert( Damages, {
					Damage = DamageLib.KogMaw:GetEDmg(Hero),
					Color = Colors.Blue,
				})
			end

			if Engine:SpellReady(SpellKey.R) then
				table.insert(Damages, {
					Damage = DamageLib.KogMaw:GetRDmg(Hero),
					Color = Colors.PurpleDarker
				})
			end

            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
end

function KogMaw:OnDraw()
if myHero.IsDead == true then return end
    if Engine:SpellReady(SpellKey.Q) and self.DrawQ.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, SpellLib.KogMaw.Q:Range(),255,0,255,255)
        end
    end
    if Engine:SpellReady(SpellKey.W) and self.DrawW.Value == 1 then
        local range = SpellLib.KogMaw.W:Range()
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, range,255,0,255,255)
        end
    end
    if Engine:SpellReady(SpellKey.E) and self.DrawE.Value == 1 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, SpellLib.KogMaw.E:Range(),255,0,255,255)
        end
    end
    if Engine:SpellReady(SpellKey.R) and self.DrawR.Value == 1 then
        local range = SpellLib.KogMaw.R:Range()
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(myHero.Position, range,255,0,255,255)
        end
    end

    self:DrawDmg()
end

function KogMaw:OnLoad()
    if(myHero.ChampionName ~= "KogMaw") then return end
    AddEvent("OnSettingsSave" , function() KogMaw:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() KogMaw:LoadSettings() end)
    KogMaw:__init()
    AddEvent("OnDraw", function() KogMaw:OnDraw() end)
    AddEvent("OnTick", function() KogMaw:OnTick() end)
end
AddEvent("OnLoad", function() KogMaw:OnLoad() end)	