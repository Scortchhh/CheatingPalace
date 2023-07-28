--Credits to Critic, Scortch, Christoph

Yone = {} 

function Yone:__init() 

    
    self.Q1Range = 450
    self.q3Range = 1050
    self.WRange = 600 
    self.ERange = 300
    self.RRange = 1000
    self.QDelay = 0.4

    self.QSpeed = 1500

    self.QWidth = 80

    self.RSpeed = math.huge

    self.RDelay = 0.75

    self.RWidth = 225

    self.ScriptVersion = "         Yone Ver: 1.5 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("Yone") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.Comboq3 = self.ComboMenu:AddCheckbox("Use q3 in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)
    self.SingleR = self.ComboMenu:AddCheckbox("Use Single R when in E", 1)
    self.KillTime = self.ComboMenu:AddSlider("KillTime from CCKillable", 4, 1, 5, 1)
    self.SingleRHP = self.ComboMenu:AddSlider("Use Single R above X% hp", 40, 1, 100, 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)

    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
--  self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    --self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------

    self.Spells 			={}

    self.Spells['YoneE'] = { Type = 0, Range = 1000, Radius = 55, Speed = 1700, Delay = 0.25, CC = 0}
    
    Yone:LoadSettings()
end

function Yone:SaveSettings() 
  

    --combo save settings--
    SettingsManager:CreateSettings("Yone")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use q3 in Combo", self.Comboq3.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Single R", self.SingleR.Value)
    SettingsManager:AddSettingsInt("KillTime", self.KillTime.Value)
    SettingsManager:AddSettingsInt("Single R HP", self.SingleRHP.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)

    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	--SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Yone:LoadSettings()
    SettingsManager:GetSettingsFile("Yone")
     --------------------------------Combo load----------------------
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.Comboq3.Value = SettingsManager:GetSettingsInt("Combo","Use q3 in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo")
    self.SingleR.Value = SettingsManager:GetSettingsInt("Combo", "Single R")
    self.KillTime.Value = SettingsManager:GetSettingsInt("Combo", "KillTime")
    self.SingleRHP.Value = SettingsManager:GetSettingsInt("Combo", "Single R HP")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
 --   self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------

     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	--self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
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

function Yone:YoneQCD()
    QCD = 0.25
    Speed = myHero.AttackSpeedMod
    if Speed > 0 and Speed < 15 then
        QCD = 0.25
    end
    if Speed > 14 and Speed < 30 then
        QCD = 0.27
    end
    if Speed > 29 and Speed < 45 then
        QCD = 0.30
    end
    if Speed > 44 and Speed < 60 then
        QCD = 0.34
    end
    if Speed > 59 and Speed < 75 then
        QCD = 0.39
    end
    if Speed > 74 and Speed < 90 then
        QCD = 0.45
    end
    if Speed > 89 and Speed < 105 then
        QCD = 0.54
    end
    if Speed > 104 and Speed < 111 then
        QCD = 0.67
    end
    if Speed > 110 then
        QCD = 0.75
    end
    return QCD
end

function Yone:YoneKillable(Target, Time)
    local Crit = myHero.CritMod
    local QCrit = 1
    if Crit == 0 then
        QCrit = 1
    end
    if Crit > 0 and Crit < 1 then
        QCrit = Crit * 0.6 + 1
    end
    if Crit == 1 then
        QCrit = 1.8
    end
    local AACrit = 1
    if Crit == 0 then
        AACrit = 1
    end
    if Crit > 0 and Crit < 1 then
        AACrit = Crit * 0.8 + 1
    end
    if Crit == 1 then
        AACrit = 2.025
    end 
    --print("Autoattack Crit is:" .. AACrit)
    --print("Q Crit is:" .. QCrit)
    local AttackSpeed = myHero.AttackSpeedMod * 0.625 
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = GetDamage((20 * myHero:GetSpellSlot(0).Level + TotalAD) * QCrit , true, Target)
    local WDmgAD = GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), true, Target)
    local WDmgAP = GetDamage(5 * myHero:GetSpellSlot(1).Level + Target.MaxHealth * 0.05 + (0.005 * Target.MaxHealth * myHero:GetSpellSlot(1).Level), false, Target)
    local RDmgAD = GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, true, Target)
    local RDmgAP = GetDamage(100 * myHero:GetSpellSlot(3).Level + TotalAD * 0.4, false, Target)
    local AA = GetDamage( TotalAD * AACrit, true, Target)
    local AA2AD = GetDamage( TotalAD * AACrit * 0.5, true, Target)
    local AA2AP = GetDamage( TotalAD * AACrit * 0.5, false, Target)
    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 then
        FinalFullDmg = FinalFullDmg + (QDmg * self:YoneQCD() * Time)
    end
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WDmgAD + WDmgAP
    end
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + RDmgAD + RDmgAP
    end
    FinalFullDmg = FinalFullDmg + (AA * AttackSpeed * Time * 0.5)
    FinalFullDmg = FinalFullDmg + ((AA2AD + AA2AP) * AttackSpeed * Time * 0.5)
    if FinalFullDmg > Target.Health then
        return true
    end
    return false
end


-----combo-----
--yoneq3ready
--YonePassive
function Yone:Combo()
    --print(myHero.Mana)

    if Engine:SpellReady("HK_SPELL3") then
        if self.ComboE.Value == 1 then
            if myHero.Mana == 0 then
                if Engine:SpellReady("HK_SPELL4") or myHero.BuffData:GetBuff("yoneq3ready").Valid then
                    local Time = self.KillTime.Value
                    local target = Orbwalker:GetTarget("Combo", self.q3Range + 400)
                    if target then
                        if GetDist(myHero.Position, target.Position) > self.RRange + 10 then
                            if self:YoneKillable(target, Time) then
                                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                            end
                        end
                    end
                end
            end
		end
    end

    if Engine:SpellReady("HK_SPELL4") and self.SingleR.Value == 1 then
        local Time = myHero.Mana / 80
        local target = Orbwalker:GetTarget("Combo", self.RRange - 100)
        if target then
            local isCC = (target.BuffData:HasBuffOfType(BuffType.Stun) or target.BuffData:HasBuffOfType(BuffType.Taunt) or target.BuffData:HasBuffOfType(BuffType.Snare) or target.BuffData:HasBuffOfType(BuffType.Slow) or target.BuffData:HasBuffOfType(BuffType.Knockup) or target.BuffData:HasBuffOfType(BuffType.Asleep))
            if isCC then
                if myHero.Health >= myHero.MaxHealth / 100 * self.SingleRHP.Value then
                    if self:YoneKillable(target, Time) then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    end
                end
                if Engine:GetForceTarget(target) then
                    if self:YoneKillable(target, Time) then
                        Engine:CastSpell("HK_SPELL4", target.Position, 1)
                    end
                end
            else
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, 0.8, 1)
                if PredPos ~= nil and Target ~= nil then
                    if self:YoneKillable(target, Time) then
                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange - 100)
        if target then
            if EnemiesInRange(target.Position, 250) >= self.ComboRSlider.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end

    -- Yone q3
    if Engine:SpellReady("HK_SPELL1") then
		local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
		if QBuff.Count_Alt > 0 then
			if self.HarassQ.Value == 1 and self.Comboq3.Value == 1 then
				local StartPos 				= myHero.Position
                local bonusAts = (myHero.AttackSpeedMod - 1) * 100
                local calcWDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.q3Range, self.QSpeed, self.QWidth, calcWDelay, 0, true, 0.5, 1)
				if PredPos ~= nil and Target ~= nil then
					local Distance = GetDist(StartPos, Target.Position)
					if Distance < myHero.AttackRange + myHero.CharData.BoundingRadius then
						if Orbwalker.Attack == 0 then
							if GetDist(StartPos, PredPos) < self.q3Range then
								Engine:CastSpell("HK_SPELL1", PredPos ,1)
								return
							end
						end
					else
						if GetDist(StartPos, PredPos) < self.q3Range then
							Engine:CastSpell("HK_SPELL1", PredPos ,1)
							return
						end
					end
				end
			end
        end
    end

    --Yone Q1
    if Engine:SpellReady("HK_SPELL1") then
        if self.ComboQ.Value == 1 then
            local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
            if QBuff.Count_Alt == 0 then
                local bonusAts = (myHero.AttackSpeedMod - 1) * 100
                local calcWDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.Q1Range, self.QSpeed, self.QWidth, calcWDelay, 0, true, 0.35, 1)
                if PredPos and Target then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
		end
    end
    
	if Engine:SpellReady("HK_SPELL2") then
		if self.ComboW.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange -50 )
			if Target then
				Engine:CastSpell("HK_SPELL2", Target.Position, 1)
				return
			end
		end
    end

end


function Yone:Harass()

    -- Yone q3
    if Engine:SpellReady("HK_SPELL1") then
		local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
		if QBuff.Count_Alt > 0 then
			if self.Comboq3.Value == 1 then
				local StartPos 				= myHero.Position
                local bonusAts = (myHero.AttackSpeedMod - 1) * 100
                local calcWDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.q3Range, self.QSpeed, self.QWidth, calcWDelay, 0, true, 0.5, 1)
				if PredPos ~= nil and Target ~= nil then
					local Distance = GetDist(StartPos, Target.Position)
					if Distance < myHero.AttackRange + myHero.CharData.BoundingRadius then
						if Orbwalker.Attack == 0 then
							if GetDist(StartPos, PredPos) < self.q3Range then
								Engine:CastSpell("HK_SPELL1", PredPos, 1)
								return
							end
						end
					else
						if GetDist(StartPos, PredPos) < self.q3Range then
							Engine:CastSpell("HK_SPELL1", PredPos, 1)
							return
						end
					end
				end
			end
        end
    end
    
    if Engine:SpellReady("HK_SPELL3") then
        if self.HarassE.Value == 1 then
            if myHero.Mana == 0 then
                local Target = Orbwalker:GetTarget("Combo", 630)
                if Target then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
            end
		end
    end

    --Yone Q1
    if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
            local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
            if QBuff.Count_Alt == 0 then
                local bonusAts = (myHero.AttackSpeedMod - 1) * 100
                local calcWDelay = 0.4 * (1 -(0.01 * math.floor(bonusAts / 1.67))) --math.floor(bonusAts / 25)
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.Q1Range, self.QSpeed, self.QWidth, calcWDelay, 0, true, 0.35, 1)
                if PredPos and Target then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
		end
    end
    
	if Engine:SpellReady("HK_SPELL2") then
		if self.HarassW.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange -50 )
			if Target then
				Engine:CastSpell("HK_SPELL2", Target.Position, 1)
				return
			end
		end
    end
end

function Yone:Laneclear()

    if Engine:SpellReady("HK_SPELL1") then
        local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
        if QBuff.Count_Alt == 0 then
            if self.ClearQ.Value == 1 then
                local Target = Orbwalker:GetTarget("Laneclear", self.Q1Range - 20)
                if Target and Target.IsMinion then
                    Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                    return    
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") then
		if self.ClearW.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.WRange - 20)
			if Target and Target.IsMinion then
				Engine:CastSpell("HK_SPELL2", Target.Position, 0)
				return
			end
		end
    end


end


--end---

function Yone:LastHit()
    local target = Orbwalker:GetTarget("Lasthit", 450)
    if target then
        if Engine:SpellReady("HK_SPELL1") then
            local dmg = 0 + (20 * myHero:GetSpellSlot(0).Level) + (myHero.BaseAttack + myHero.BonusAttack)
            local totalDmg = GetDamage(dmg, true, target)
            if target.Health <= totalDmg then
                Engine:CastSpell("HK_SPELL1", target.Position, 0)
            end
        end
    end
end

function Yone:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Yone:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Yone:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Yone:Laneclear()
		end
        if Engine:IsKeyDown("HK_LASTHIT") then
            Yone:LastHit()
		end
	end
end

function Yone:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        local QBuff = myHero.BuffData:GetBuff("yoneq3ready")
        if QBuff.Count_Alt == 0 then
            Render:DrawCircle(myHero.Position, self.Q1Range ,100,150,255,255)
        else
             Render:DrawCircle(myHero.Position, self.q3Range ,100,150,255,255)
        end
    end

	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL3") then
        if Engine:SpellReady("HK_SPELL4") or myHero.BuffData:GetBuff("yoneq3ready").Valid then
            Render:DrawCircle(myHero.Position, self.q3Range + 400 ,255,0,0,255)
        end
    end

    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Yone:OnLoad()
    if(myHero.ChampionName ~= "Yone") then return end
	AddEvent("OnSettingsSave" , function() Yone:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Yone:LoadSettings() end)


	Yone:__init()
	AddEvent("OnTick", function() Yone:OnTick() end)	
    AddEvent("OnDraw", function() Yone:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Yone:OnLoad() end)	
