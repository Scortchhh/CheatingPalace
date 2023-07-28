--Credits to Critic, Scortch, Christoph

Cassiopeia = {}

function Cassiopeia:__init()

    self.QRange = 850 --w 76 
    self.WRange = 700 --w 160
    self.ERange = 700
    self.RRange = 825 

    self.QSpeed = math.huge 
    self.WSpeed = math.huge
    self.ESpeed = 2500

    self.QWidth = 80
    self.WWidth = 200

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.EDelay = 0.125

    self.QHitChance = 0.2

    self.ScriptVersion = "         Cassiopeia Ver: 0.5" 

    self.ChampionMenu = Menu:CreateMenu("Cassiopeia")
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQWP = self.ComboMenu:AddCheckbox("Use Q/W when poisoned", 1)
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W", 1)
    self.ComboWSlider = self.ComboMenu:AddSlider("Use W on x enemies in W range 0 = disabled", 3, 0, 4, 1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E", 1)
    self.ComboEP = self.ComboMenu:AddCheckbox("Use E w/out Poison", 1)
    self.ComboR = self.ComboMenu:AddCheckbox("Use R", 1)
    self.ComboRSlider = self.ComboMenu:AddSlider("Use R if x enemies in R range 0 = disabled", 3, 0, 4, 1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQWP = self.HarassMenu:AddCheckbox("Use Q/W when poisoned", 1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1)
    self.HarassW = self.HarassMenu:AddCheckbox("Use W", 1)
    self.HarassWSlider = self.HarassMenu:AddSlider("Use W on x enemies in W range 0 = disabled", 3, 0, 4, 1)
    self.HarassE = self.HarassMenu:AddCheckbox("Use E", 1)
    self.HarassEP = self.HarassMenu:AddCheckbox("Use E w/out Poison", 1)
    --------------------------------------------
    self.LasthitMenu = self.ChampionMenu:AddSubMenu("Lasthit")
    self.LHE = self.LasthitMenu:AddCheckbox("Use E", 1)
    self.LastHitSlider = self.LasthitMenu:AddSlider("Use Lasthit if mana above %", 20, 1, 100, 1)
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear")
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q", 1)
    self.ClearW = self.LClearMenu:AddCheckbox("Use W", 1)
    self.LClearSlider = self.LClearMenu:AddSlider("Use W ability on x minions", 3,1,5,1)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E", 1)
    self.ClearEP = self.LClearMenu:AddCheckbox("Use E w/out Poison", 1)
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw Killable", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1)
    --------------------------------------------
    Cassiopeia:LoadSettings()
end

function Cassiopeia:SaveSettings()

    SettingsManager:CreateSettings("Cassiopeia")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q/W when poisoned", self.ComboQWP.Value)
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use W on x enemies in W range 0 = disabled", self.ComboWSlider.Value)
    SettingsManager:AddSettingsInt("Use E", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use E w/out Poison", self.ComboEP.Value)
    SettingsManager:AddSettingsInt("Use R", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range 0 = disabled", self.ComboRSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q/W when poisoned", self.HarassQWP.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use W on x enemies in W range 0 = disabled", self.HarassWSlider.Value)
    SettingsManager:AddSettingsInt("Use E", self.HarassE.Value)
    SettingsManager:AddSettingsInt("Use E w/out Poison", self.HarassEP.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Lasthit")
    SettingsManager:AddSettingsInt("Use E", self.LHE.Value)
    SettingsManager:AddSettingsInt("Use Lasthit if mana above %", self.LastHitSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use W ability on x minions", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use E", self.ClearE.Value)
    SettingsManager:AddSettingsInt("Use E w/out Poison", self.ClearEP.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Cassiopeia:LoadSettings()
    SettingsManager:GetSettingsFile("Cassiopeia")
     --------------------------------------------
    self.ComboQWP.Value = SettingsManager:GetSettingsInt("Combo","Use Q/W when poisoned")
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W")
    self.ComboWSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use W on x enemies in W range 0 = disabled")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E")
    self.ComboEP.Value = SettingsManager:GetSettingsInt("Combo","Use E w/out Poison")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range 0 = disabled")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQWP.Value = SettingsManager:GetSettingsInt("Harass","Use Q/W when poisoned")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W")
    self.HarassWSlider.Value = SettingsManager:GetSettingsInt("Harass", "Use W on x enemies in W range 0 = disabled")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E")
    self.HarassEP.Value = SettingsManager:GetSettingsInt("Harass","Use E w/out Poison")
    --------------------------------------------
    self.LHE.Value = SettingsManager:GetSettingsInt("Lasthit", "Use E")
    self.LastHitSlider.Value = SettingsManager:GetSettingsInt("Lasthit", "Use Lasthit if mana above %")
    --------------------------------------------   
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W")
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use E ability on x minions")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E")
    self.ClearEP.Value = SettingsManager:GetSettingsInt("LaneClear","Use E w/out Poison")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function EnemiesInRange(Position, Range)
	local Count = 0
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

local function Poisoned(Target)
    return Target.BuffData:HasBuffOfType(BuffType.Poison)
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

function Cassiopeia:Ultimate()

    if Engine:SpellReady('HK_SPELL4') and self.ComboR.Value == 1 then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) < 800 then
                    local CassR = GetDamage(50 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.5), false, target)
                    if CassR >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL4") and self.ComboRSlider.Value > 0 then
        local Target = Orbwalker:GetTarget("Combo", self.RRange)
        if Target ~= nil and Target.IsDead == false and GetDist(myHero.Position, Target.Position) < 800 then
            if EnemiesInRange(Target.Position, 200) >= self.ComboRSlider.Value then
                Engine:CastSpell("HK_SPELL4", Target.Position, 1)
                return
            end
        end
    end
end

function Cassiopeia:Combo()
    
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local Target = Orbwalker:GetTarget("Combo", self.WRange)
        if Target ~= nil then
            if GetDist(myHero.Position, Target.Position) < self.WRange and Poisoned(Target) == false then
                Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                return
            end
            if self.ComboQWP.Value == 1 and GetDist(myHero.Position, Target.Position) < self.WRange then
                Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                return
            end
            if self.ComboWSlider.Value > 0 then
                if GetDist(myHero.Position, Target.Position) < self.WRange then
                    if EnemiesInRange(Target.Position, 200) >= self.ComboWSlider.Value then
                        Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                        return
                    end
                end
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        if Target ~= nil and GetDist(myHero.Position, Target.Position) < self.ERange and Poisoned(Target) == true then
            Engine:CastSpell("HK_SPELL3", Target.Position, 1)
            return
        end
        if self.ComboEP.Value == 1 then
            if Orbwalker.Attack == 0 and Target ~= nil and GetDist(myHero.Position, Target.Position) < self.ERange then
                Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                return
            end
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
        if PredPos ~= nil and Target ~= nil then
            if GetDist(myHero.Position, Target.Position) < self.QRange and Poisoned(Target) == false then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
            if self.ComboQWP.Value == 1 then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end

end

function Cassiopeia:Harass()

    local sliderValue = self.HarassSlider.Value
    local condition = myHero.MaxMana / 100 * sliderValue
    if myHero.Mana >= condition then
        if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 0)
            if PredPos ~= nil and Target ~= nil then
                if GetDist(myHero.Position, Target.Position) < self.QRange and Poisoned(Target) == false then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
                if self.HarassQWP.Value == 1 then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end

        if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local Target = Orbwalker:GetTarget("Harass", self.WRange)
            if Target ~= nil then
                if GetDist(myHero.Position, Target.Position) < self.WRange and Poisoned(Target) == false then
                    Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                    return
                end
                if self.HarassQWP.Value == 1 and GetDist(myHero.Position, Target.Position) < self.WRange then
                    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                    return
                end
                if self.HarassWSlider.Value > 0 then
                    if GetDist(myHero.Position, Target.Position) < self.WRange then
                        if EnemiesInRange(Target.Position, 200) >= self.HarassWSlider.Value then
                            Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                            return
                        end
                    end
                end
            end
        end

        if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local Target = Orbwalker:GetTarget("Harass", self.ERange)
            if Target ~= nil and GetDist(myHero.Position, Target.Position) < self.ERange and Poisoned(Target) == false then
                Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                return
            end
            if self.HarassEP.Value == 1 then
                if Orbwalker.Attack == 0 and Target ~= nil and GetDist(myHero.Position, Target.Position) < self.ERange then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
            end
        end
    end

end

function Cassiopeia:Laneclear()
    local sliderValue = self.LClearSlider.Value
    local condition = myHero.MaxMana / 100 * sliderValue
    if myHero.Mana >= condition then
        if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
            if Target ~= nil and Target.IsMinion then
                if GetDist(myHero.Position, Target.Position) <= self.QRange then
                    if Target.MaxHealth > 100 then
                        Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                        return
                    end
                end
            end
        end

        if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.WRange)
            if Target ~= nil and Target.IsMinion then
                if GetDist(myHero.Position, Target.Position) <= self.WRange then
                    if Target.MaxHealth > 100 and MinionsInRange(Target.Position, 280) > self.LClearSlider.Value then
                        Engine:CastSpell("HK_SPELL2", Target.Position, 0)
                        return
                    end
                end
            end
        end

        if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
            local lastHitTarget = Orbwalker:GetTarget("Lasthit", self.ERange)
            if lastHitTarget ~= nil then
                if lastHitTarget.IsMinion then
                    if GetDist(myHero.Position, lastHitTarget.Position) <= self.ERange and Poisoned(lastHitTarget) then
                        if lastHitTarget.MaxHealth > 100 then
                            Engine:CastSpell("HK_SPELL3", lastHitTarget.Position, 0)
                            return
                        end
                    end
                    if self.ClearEP.Value == 1 then
                        if Orbwalker.Attack == 0 then
                            Engine:CastSpell("HK_SPELL3", lastHitTarget.Position, 0)
                            return
                        end
                    end
                end
            else
                if Target ~= nil and Target.IsMinion then
                    if GetDist(myHero.Position, Target.Position) <= self.ERange and Poisoned(Target) then
                        if Target.MaxHealth > 100 then
                            Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                            return
                        end
                    end
                    if self.ClearEP.Value == 1 then
                        if Orbwalker.Attack == 0 then
                            Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                            return
                        end
                    end
                end
            end
        end
    end
end

function Cassiopeia:Lasthit()
    local sliderValue = self.LastHitSlider.Value
    local condition = myHero.MaxMana / 100 * sliderValue
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    if myHero.Mana >= condition and Engine:SpellReady("HK_SPELL3") and self.LHE.Value == 1 then
        local Target = Orbwalker:GetTarget("Lasthit", self.ERange)
        if Target ~= nil and Target.IsMinion then
            local EPdmg = GetDamage(0 + (20 * myHero:GetSpellSlot(2).Level) + (myHero.AbilityPower * 0.6), false, Target)
            local EEdmg = GetDamage(48 + (4 * totalLevel) + (myHero.AbilityPower * 0.1), false, Target)
            local Pdmg = (EPdmg + EEdmg)
            if GetDist(myHero.Position, Target.Position) <= self.ERange then
                if Target.MaxHealth > 100 and Target.Health <= EEdmg then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                    return
                end
            end
            if GetDist(myHero.Position, Target.Position) <= self.ERange and Poisoned(Target) then
                if Target.MaxHealth > 100 and Target.Health <= Pdmg then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                    return
                end
            end
        end
    end
end

function Cassiopeia:Damage(Target)

    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {75, 110, 145, 180, 215}
        Qbonus = (myHero.AbilityPower * 0.90)
        QQdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
    end

    local WLevel = myHero:GetSpellSlot(1).Level
    local WDamage
    local WWdmg
    if WLevel ~= 0 then
        WDamage = {20, 25, 30, 35, 40}
        Wbonus = (myHero.AbilityPower * .70)
        WWdmg = GetDamage(WDamage[WLevel] + Wbonus, false, Target)
    end

    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {20, 40, 60, 80, 100}
        Ebonus = (myHero.AbilityPower * 0.60)
        EEdmg = GetDamage((EDamage[ELevel]+ Ebonus) * 2, false, Target)
    end

    local RLevel = myHero:GetSpellSlot(3).Level
    local RDamage
    local Rbonus
    local RRdmg
    if RLevel ~= 0 then
        RDamage = {150, 250, 350}
        Rbonus = (myHero.AbilityPower * .50)
        RRdmg = GetDamage(RDamage[RLevel] + Rbonus, false, Target)
    end
    local FinalFullDmg = 0

    if Engine:SpellReady("HK_SPELL1") and self.ComboQ.Value == 1 then
        FinalFullDmg = (FinalFullDmg + QQdmg)
    end
    if Engine:SpellReady("HK_SPELL2") and self.ComboW.Value == 1 then
        FinalFullDmg = (FinalFullDmg + WWdmg)
    end
    if Engine:SpellReady("HK_SPELL3") and self.ComboE.Value == 1 then
        FinalFullDmg = (FinalFullDmg + EEdmg)
    end
    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        FinalFullDmg = (FinalFullDmg + RRdmg) 
    end

    return FinalFullDmg
end

function Cassiopeia:KillHealthBox()
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


function Cassiopeia:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Cassiopeia:Combo()
            Cassiopeia:Ultimate()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Cassiopeia:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Cassiopeia:Laneclear()
		end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Cassiopeia:Lasthit()
		end
	end
end

function Cassiopeia:OnDraw()
    if self.DrawKillable.Value == 1 then
        Cassiopeia:KillHealthBox()
    end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, 850 ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, 755 ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Cassiopeia:OnLoad()
    if(myHero.ChampionName ~= "Cassiopeia") then return end
	AddEvent("OnSettingsSave" , function() Cassiopeia:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Cassiopeia:LoadSettings() end)


	Cassiopeia:__init()
	AddEvent("OnTick", function() Cassiopeia:OnTick() end)
    AddEvent("OnDraw", function() Cassiopeia:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Cassiopeia:OnLoad() end)
