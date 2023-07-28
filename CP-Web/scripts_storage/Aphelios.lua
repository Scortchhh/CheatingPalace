--Credits to Critic, Scortch, Christoph
--update 1.5
Aphelios = {} 

function Aphelios:__init() 
    self.QMoonshotRange = 1425 -- width is 120 (CALIBRUM MANAGER)
    self.QOnslaughtRange = 550 --(severum manager)
    self.QBindingRange = 1425 -- (gravitum manager)
    self.QDuskwaveRange = 650 -- 40 (infernum manager)
    self.QSentryRange = 475  -- (crescendum manager)
    self.RRange = 1300
    self.QMoonshotSpeed = 1850 -- width is 120 
    self.QOnslaughtSpeed =  math.huge
    self.QMoonshotWidth = 120
    self.QBindingSpeed = math.huge
    self.QDuskwaveSpeed = math.huge
    self.QDuskwaveWidth = 40
    self.RSpeed = math.huge
    self.QMoonshotDelay = 0.25
    self.QOnslaughtDelay = 0
    self.QBindingDelay = 0
    self.QDuskwaveDelay = 0.4
    self.QSentryDelay = 0.25
    self.RDelay = 0.6
    self.RWidth = 300

    self.QHitChance = 0.2
    self.RHitChance = 0.2

    self.ScriptVersion = "         Aphelios Ver: 1.5" 
    self.ChampionMenu = Menu:CreateMenu("Aphelios") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQMoonshot = self.ComboMenu:AddCheckbox("Use Moonshot in Combo", 1)
    self.ComboQOnslaught = self.ComboMenu:AddCheckbox("Use Onslaught in Combo", 1)
    self.ComboQBinding = self.ComboMenu:AddCheckbox("Use Binding in Combo", 1)
    self.ComboQDuskwave = self.ComboMenu:AddCheckbox("Use Duskwave in Combo", 1)
    self.ComboQSentry = self.ComboMenu:AddCheckbox("Use Sentry in Combo", 1)
    self.ComboR = self.ComboMenu:AddCheckbox("Use R to KS", 1) 
    self.HPSlider = self.ComboMenu:AddSlider("Use Pistol if HP below %", 20,1,100,1)
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R in Combo w/ Infernum on x enemies", 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R with Infernum on x amount of  enemies", 3,0,4,1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQMoonshot = self.HarassMenu:AddCheckbox("Use Moonshot in Harass", 1)
    self.HarassQOnslaught = self.HarassMenu:AddCheckbox("Use Onslaught in Harass", 1)
    self.HarassQBinding = self.HarassMenu:AddCheckbox("Use Binding in Harass", 1)
    self.HarassQDuskwave = self.HarassMenu:AddCheckbox("Use Duskwave in Harass", 1)
    self.HarassQSentry = self.HarassMenu:AddCheckbox("Use Sentry in Harass", 1)
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.AutoRootQ = self.MiscMenu:AddCheckbox("Auto Root/Switch", 1)
    Aphelios:LoadSettings()  
end 

function Aphelios:SaveSettings() 
    SettingsManager:CreateSettings("Aphelios")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Moonshot in Combo", self.ComboQMoonshot.Value)
    SettingsManager:AddSettingsInt("Use Onslaught in Combo", self.ComboQOnslaught.Value)
    SettingsManager:AddSettingsInt("Use Binding in Combo", self.ComboQBinding.Value)
    SettingsManager:AddSettingsInt("Use Duskwave in Combo", self.ComboQDuskwave.Value)
    SettingsManager:AddSettingsInt("Use Sentry in Combo", self.ComboQSentry.Value)
    SettingsManager:AddSettingsInt("Use R to KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use Pistol if HP below %", self.HPSlider.Value)
    SettingsManager:AddSettingsInt("Use R in Combo w/ Infernum on x enemies", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R with Infernum on x amount of  enemies", self.ComboRSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Moonshot in Harass", self.HarassQMoonshot.Value)
    SettingsManager:AddSettingsInt("Use Onslaught in Harass", self.HarassQOnslaught.Value)
    SettingsManager:AddSettingsInt("Use Binding in Harass", self.HarassQBinding.Value)
    SettingsManager:AddSettingsInt("Use Duskwave in Harass", self.HarassQDuskwave.Value)
    SettingsManager:AddSettingsInt("Use Sentry in Harass", self.HarassQSentry.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Auto Root/Switch", self.AutoRootQ.Value)
end

function Aphelios:LoadSettings()
    SettingsManager:GetSettingsFile("Aphelios")
    --------------------------------------------
    self.ComboQMoonshot.Value = SettingsManager:GetSettingsInt("Combo","Use Moonshot in Combo")
    self.ComboQOnslaught.Value = SettingsManager:GetSettingsInt("Combo","Use Onslaught in Combo")
    self.ComboQBinding.Value = SettingsManager:GetSettingsInt("Combo","Use Binding in Combo")
    self.ComboQDuskwave.Value = SettingsManager:GetSettingsInt("Combo","Use Duskwave in Combo")
    self.ComboQSentry.Value = SettingsManager:GetSettingsInt("Combo","Use Sentry in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R to KS") 
    self.HPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use Pistol if HP below %")  
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo w/ Infernum on x enemies")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R with Infernum on x amount of  enemies") 
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQMoonshot.Value = SettingsManager:GetSettingsInt("Harass","Use Moonshot in Harass")
    self.HarassQOnslaught.Value = SettingsManager:GetSettingsInt("Harass","Use Onslaught in Harass")
    self.HarassQBinding.Value = SettingsManager:GetSettingsInt("Harass","Use Binding in Harass")
    self.HarassQDuskwave.Value = SettingsManager:GetSettingsInt("Harass","Use Duskwave in Harass")
    self.HarassQSentry.Value = SettingsManager:GetSettingsInt("Harass","Use Sentry in Harass")
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
    self.AutoRootQ.Value = SettingsManager:GetSettingsInt("Misc","Auto Root/Switch")
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

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
	local Count = 0 
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

function Aphelios:GetSentry(Range)
    local MinionList = ObjectManager.MinionList
	for I,Minion in pairs(MinionList) do	
		if Minion.Team == myHero.Team and Minion.Name == "ApheliosTurret" then
			return Minion
		end
    end
end

function Aphelios:LongShot()
    local Target = Orbwalker:GetTarget("Combo", 1800)
    if Target then
       local TargetBuffs 		= Target.BuffData
       local Moonguide   		= TargetBuffs:GetBuff("aphelioscalibrumbonusrangedebuff")
       if  Moonguide.Count_Alt > 0 then
            if GetDist(myHero.Position, Target.Position) <= 1800 then
                Engine:AttackClick(Target.Position, 1)
                return
            end
       end
   end
end
----ultimate-----
function Aphelios:Ultimate()

    local Calibrum = myHero.BuffData:GetBuff("ApheliosOffHandBuffCalibrum")
    local Infernum = myHero.BuffData:GetBuff("ApheliosInfernumManager")
    local RDamage = {125, 175, 225}
    local RLevel = myHero:GetSpellSlot(3).Level
    local Rdmg = RDamage[RLevel]
    local IRDamage = {50, 100, 150}
    local IRLevel = myHero:GetSpellSlot(3).Level
    local IRdmg = IRDamage[IRLevel]

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') and Infernum.Valid == true then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false and not target.AIData.Dashing and target.IsTargetable then
                if GetDist(myHero.Position, target.Position) <= 1200 then
                    local ApheliosD = (Rdmg + (myHero.AbilityPower * 1) + (myHero.BonusAttack * .2))
                    local ApheliosI = (IRdmg + (myHero.BonusAttack * .25))
                    local ApheliosR = GetDamage(ApheliosD + ApheliosI,  true, target)
                    if ApheliosR >= target.Health then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 0)
                        if PredPos then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false and not target.AIData.Dashing and target.IsTargetable then
                if GetDist(myHero.Position, target.Position) <= 1200 then
                    local ApheliosR = GetDamage(Rdmg + (myHero.AbilityPower * 1) + (myHero.BonusAttack * .2), true, target)
                    if ApheliosR >= target.Health then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 0)
                        if PredPos then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1  and Infernum.Valid == true then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if EnemiesInRange(target.Position, 500) > self.ComboRSlider.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
                return
            end
        end
    end
end
----------
--ApheliosOffHandBuffCrescendum (next weapon crescendum - sentry)
--ApheliosOffHandBuffSeverum  (NEXT WEAPON severum-onslaught)
--ApheliosOffHandBuffCalibrum (next weapon calibrum-moonshot)
--ApheliosOffHandBuffGravitum (NEXT WEAPON - gravitum-binding)
--ApheliosOffHandBuffInfernum (next weapon infernum-duskwave)
-- ApheliosTurret missile name
-----combo-----
--ApheliosSeverumManager - pistol 
--ApheliosGravitumManager - binding  (ApheliosGravitumRoot) (ApheliosGravitumDebuff)
--ApheliosInfernumManager - duskwave
--ApheliosCrescendumManager -sentry
--ApheliosCalibrumManager  - MOONSHOT
function Aphelios:AutoRoot()

    local Gravitum = myHero.BuffData:GetBuff("ApheliosGravitumManager")
    local OffGravitum = myHero.BuffData:GetBuff("ApheliosOffHandBuffGravitum")
    local Severum = myHero.BuffData:GetBuff("ApheliosOffHandBuffSeverum")
    local Severum2 = myHero.BuffData:GetBuff("ApheliosSeverumManager")
    local Calibrum = myHero.BuffData:GetBuff("ApheliosOffHandBuffCalibrum")
    local Infernum = myHero.BuffData:GetBuff("ApheliosOffHandBuffInfernum")
    local Crescendum = myHero.BuffData:GetBuff("ApheliosOffHandBuffCrescendum")
    if self.AutoRootQ.Value == 1 and Engine:SpellReady("HK_SPELL2") and OffGravitum.Valid == true  then
        local Target = Orbwalker:GetTarget("Combo", self.QBindingRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumDebuff")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.ComboQMoonshot.Value == 1 and Calibrum.Valid == true  then
        local Target = Orbwalker:GetTarget("Combo", self.QMoonshotRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumRoot")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.ComboQOnslaught.Value == 1 and Severum.Valid == true then --heal
        local Target = Orbwalker:GetTarget("Combo", self.QOnslaughtRange)
         if Target then
            local HPcondition = myHero.MaxHealth / 100 * self.HPSlider.Value
            if myHero.Health <= HPcondition then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.ComboQOnslaught.Value == 1 and Severum2.Valid == true then --heal
        local Target = Orbwalker:GetTarget("Combo", self.QOnslaughtRange)
         if Target then
            local HPcondition = myHero.MaxHealth / 100 * self.HPSlider.Value
            if myHero.Health >= HPcondition then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    --[[if self.ComboQOnslaught.Value == 1 and Severum.Valid == true then
        local Target = Orbwalker:GetTarget("Combo", self.QOnslaughtRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumRoot")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
			end
        end
    end]]--

    if self.ComboQDuskwave.Value == 1 and Infernum.Valid == true  then
        local Target = Orbwalker:GetTarget("Combo", self.QDuskwaveRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumRoot")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.ComboQSentry.Value == 1 and Crescendum.Valid == true  then
        local Target = Orbwalker:GetTarget("Combo", self.QSentryRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumRoot")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end
end
--[[if ApheliosGravitumRoot is ==  false and ApheliosOffHandBuffGravitum == true then engine spell cast W if Root is true then engine spell W ]]--
function Aphelios:Combo()

    local Severum = myHero.BuffData:GetBuff("ApheliosSeverumManager") -- pistol
    local OffSeverum = myHero.BuffData:GetBuff("ApheliosOffHandBuffSeverum") -- pistol
    local Gravitum = myHero.BuffData:GetBuff("ApheliosGravitumManager") -- binding
    local OffGravitum = myHero.BuffData:GetBuff("ApheliosOffHandBuffGravitum") -- binding offhand 
    local Infernum = myHero.BuffData:GetBuff("ApheliosInfernumManager") -- duskwave 
    local Crescendum = myHero.BuffData:GetBuff("ApheliosCrescendumManager") -- sentry
    local Calibrum = myHero.BuffData:GetBuff("ApheliosCalibrumManager") -- moonshot sniper
    if self.ComboQBinding.Value == 1 and Engine:SpellReady("HK_SPELL2") and OffGravitum.Valid == true  then
        local Target = Orbwalker:GetTarget("Combo", self.QBindingRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumDebuff")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.ComboQBinding.Value == 1 and Engine:SpellReady("HK_SPELL1") and Gravitum.Valid == true then
        local Target = Orbwalker:GetTarget("Combo", self.QBindingRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumDebuff")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL1", nil , 1)
                return
			end
        end
    end

    if self.ComboQMoonshot.Value == 1 and Engine:SpellReady("HK_SPELL1") and Calibrum.Valid == true then
        local Target = Orbwalker:GetTarget("Combo", self.QMoonshotRange)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.QMoonshotRange then 
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QMoonshotRange, self.QMoonshotSpeed, self.QMoonshotWidth, self.QMoonshotDelay, 1, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.ComboQOnslaught.Value == 1 and Engine:SpellReady("HK_SPELL1") and Severum.Valid == true then
        local Target = Orbwalker:GetTarget("Combo", self.QOnslaughtRange)
        if Target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            end
        end
    end

    if self.ComboQDuskwave.Value == 1 and Engine:SpellReady("HK_SPELL1") and Infernum.Valid == true then
        local Target = Orbwalker:GetTarget("Combo", self.QDuskwaveRange)
        if Target then
            if EnemiesInRange(myHero.Position, 1000) >= 1 then -- changed to 1000
                if GetDist(myHero.Position, Target.Position) <= self.QDuskwaveRange then  
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.QDuskwaveRange, self.QDuskwaveSpeed, self.QDuskwaveWidth, self.QDuskwaveDelay, 0, true, self.QHitChance, 1)
                        if PredPos then
                            Engine:CastSpell("HK_SPELL1", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end

        if self.ComboQDuskwave.Value == 1 and Engine:SpellReady("HK_SPELL2") and Infernum.Valid == true and OffGravitum.Valid == false and OffSeverum.Valid == false then
            local Target = Orbwalker:GetTarget("Combo", 1000)
            if Target then
                local EnemyCount = EnemiesInRange(myHero.Position, 1000)
				if EnemyCount < 2 then
                    Engine:CastSpell("HK_SPELL2", nil , 1)
                    return
                end
            end
        end

    if self.ComboQSentry.Value == 1 and Engine:SpellReady("HK_SPELL1") and Crescendum.Valid == true then
            local Target = Orbwalker:GetTarget("Combo", self.QSentryRange)
        if Target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                local Sentry = Aphelios:GetSentry(1500)
                if not Sentry  then  
                    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                    return
                end
            end
        end
    end     
end
function Aphelios:Harass()

    local Severum = myHero.BuffData:GetBuff("ApheliosSeverumManager") -- pistol
    local OffSeverum = myHero.BuffData:GetBuff("ApheliosOffHandBuffSeverum") -- pistol
    local Gravitum = myHero.BuffData:GetBuff("ApheliosGravitumManager") -- binding
    local OffGravitum = myHero.BuffData:GetBuff("ApheliosOffHandBuffGravitum") -- binding offhand 
    local Infernum = myHero.BuffData:GetBuff("ApheliosInfernumManager") -- duskwave 
    local Crescendum = myHero.BuffData:GetBuff("ApheliosCrescendumManager") -- sentry
    local Calibrum = myHero.BuffData:GetBuff("ApheliosCalibrumManager") -- moonshot sniper
    if self.HarassQBinding.Value == 1 and Engine:SpellReady("HK_SPELL2") and OffGravitum.Valid == true  then
        local Target = Orbwalker:GetTarget("Harass", self.QBindingRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumDebuff")
			if  RootP.Valid == true then
                Engine:CastSpell("HK_SPELL2", nil , 1)
                return
			end
        end
    end

    if self.HarassQBinding.Value == 1 and Engine:SpellReady("HK_SPELL1") and Gravitum.Valid == true then
        local Target = Orbwalker:GetTarget("Harass", self.QBindingRange)
         if Target then
            local TargetBuffs 		= Target.BuffData
			local RootP 		= TargetBuffs:GetBuff("ApheliosGravitumDebuff")
			if  RootP.Valid == true then
				Engine:CastSpell("HK_SPELL1", nil , 1)
                return
			end
        end
    end

    if self.HarassQMoonshot.Value == 1 and Engine:SpellReady("HK_SPELL1") and Calibrum.Valid == true then
        local Target = Orbwalker:GetTarget("Harass", self.QMoonshotRange)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.QMoonshotRange then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    local PredPos = Prediction:GetCastPos(myHero.Position, self.QMoonshotRange, self.QMoonshotSpeed, self.QMoonshotWidth, self.QMoonshotDelay, 1, true, self.QHitChance, 1)
                    if PredPos then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                end
            end
        end
    end

    if self.HarassQOnslaught.Value == 1 and Engine:SpellReady("HK_SPELL1") and Severum.Valid == true then
        local Target = Orbwalker:GetTarget("Harass", self.QOnslaughtRange)
        if Target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            end
        end
    end

    if self.HarassQDuskwave.Value == 1 and Engine:SpellReady("HK_SPELL1") and Infernum.Valid == true then
        local Target = Orbwalker:GetTarget("Harass", self.QDuskwaveRange)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.QDuskwaveRange    then
                if EnemiesInRange(myHero.Position, 1000) >= 1 then -- changed to 1000
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                        local PredPos = Prediction:GetCastPos(myHero.Position, self.QDuskwaveRange, self.QDuskwaveSpeed, self.QDuskwaveWidth, self.QDuskwaveDelay, 0, true, self.QHitChance, 1)
                        if PredPos then
                            Engine:CastSpell("HK_SPELL1", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end

        if self.HarassQDuskwave.Value == 1 and Engine:SpellReady("HK_SPELL2") and Infernum.Valid == true and OffGravitum.Valid == false and OffSeverum.Valid == false then
            local Target = Orbwalker:GetTarget("Harass", 1000)
            if Target then
                local EnemyCount = EnemiesInRange(myHero.Position, 1000)
				if EnemyCount < 2 then
                    Engine:CastSpell("HK_SPELL2", nil , 1)
                    return
                end
            end
        end

    if self.HarassQSentry.Value == 1 and Engine:SpellReady("HK_SPELL1") and Crescendum.Valid == true then
            local Target = Orbwalker:GetTarget("Harass", self.QSentryRange)
        if Target then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                local Sentry = Aphelios:GetSentry(1500)
                if not Sentry  then  
                    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                    return
                end
            end
        end
    end     
end

function Aphelios:Laneclear()
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QSentryRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QSentryRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                    return
                end
            end
        end
    end
end
--end---

function Aphelios:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsDead == false then
        Aphelios:Ultimate()
        Aphelios:AutoRoot()
        Aphelios:LongShot()
        if Engine:IsKeyDown("HK_COMBO") then
            Aphelios:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Aphelios:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Aphelios:Laneclear()
		end
	end
end

function Aphelios:OnDraw()
	if myHero.BuffData:GetBuff("ApheliosSeverumManager").Valid and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QOnslaughtRange ,0,255,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosGravitumManager").Valid and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QBindingRange ,0,255,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosInfernumManager").Valid and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QDuskwaveRange ,0,255,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosCrescendumManager").Valid and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QSentryRange ,0,255,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosCalibrumManager").Valid and Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMoonshotRange ,0,255,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosOffHandBuffCrescendum").Valid and Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QOnslaughtRange ,255,0,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosOffHandBuffSeverum").Valid and Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QBindingRange ,255,0,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosOffHandBuffCalibrum").Valid and Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QDuskwaveRange ,255,0,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosOffHandBuffGravitum").Valid and Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QSentryRange ,255,0,0,255)
    end
    if myHero.BuffData:GetBuff("ApheliosOffHandBuffInfernum").Valid and Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMoonshotRange ,255,0,0,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,0,0,255,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Aphelios:OnLoad()
    if(myHero.ChampionName ~= "Aphelios") then return end
	AddEvent("OnSettingsSave" , function() Aphelios:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Aphelios:LoadSettings() end)
	Aphelios:__init()
	AddEvent("OnTick", function() Aphelios:OnTick() end)	
    AddEvent("OnDraw", function() Aphelios:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Aphelios:OnLoad() end)	