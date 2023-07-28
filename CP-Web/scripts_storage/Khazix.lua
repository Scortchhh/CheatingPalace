--Credits to Critic, Scortch, Christoph

Khazix = {} 

function Khazix:__init() 

    self.KeyNames = {}

	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"

	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
	self.KeyNames[11]		= "HK_ITEM6"

    
    self.QRange = 325 

    
    self.WRange = 1025 
    self.WSpeed = 1700
    self.WWidth = 140
    self.WDelay = 0.25

    self.ERange = 700
    self.ESpeed = 2000
    self.EWidth = 200
    self.EDelay = 0

    self.WHitChance = 0.2
    self.EHitChance = 0.2


    self.ScriptVersion = "         dKhazix Ver: 1.03 CREDITS Derang3d" 



    self.ChampionMenu = Menu:CreateMenu("Khazix") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1)
    self.EComboAdjust = self.ComboMenu:AddSlider("Adjust full combo dmg % (for Eing)", 130,50,250,1)
    self.RComboHP = self.ComboMenu:AddCheckbox("Use R based on your HP % in combo", 1)
    self.RComboHPSlider = self.ComboMenu:AddSlider("Use R if HP below %", 20,1,100,1)

    --------------------------------------------

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
--    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    
    --------------------------------------------
    
    Khazix:LoadSettings()
end

function Khazix:SaveSettings() 
  
    SettingsManager:CreateSettings("Khazix")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R based on %HP in combo", self.RComboHP.Value)
    SettingsManager:AddSettingsInt("Use R if HP below %", self.RComboHPSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
--    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Khazix:LoadSettings()
    SettingsManager:GetSettingsFile("Khazix")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.RComboHP.Value = SettingsManager:GetSettingsInt("Combo", "Use R based on %HP in combo")
    self.RComboHPSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if HP below %")
    
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------

     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
--    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
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

local function MinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i,Minion in pairs(MinionList) do
        if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Khazix:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end

function Khazix:GetItemKey(ItemName)
	for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Khazix:Prowler_Check()
	local Prowler 					= {}
			Prowler.Key				= self:GetItemKey("6693Active")	
	if Prowler.Key ~= nil then
		if Engine:SpellReady(Prowler.Key) then
			return 400
		end
	end
	return 0
end

function Khazix:Isolated(Target)
    if EnemiesInRange(Target.Position, 400) == 1 and MinionsInRange(Target.Position, 400) == 0 then
        return true
    end
    return false
end

function Khazix:GetECastPos(CastPos, target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
    local ERange        = 700

    if myHero.BuffData:GetBuff("KhazixEEvo").Count_Alt > 0 then
        ERange = 900
    else
        ERange = 700
    end

    local Adjustment    = ERange - GetDist(PlayerPos, target.Position)
	local i 			= Adjustment
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Khazix:Stealth()
	local Stealth = myHero.BuffData:GetBuff("khazixrstealth")
	
	if Stealth.Count_Alt > 0 then
		self.RActive = true
		Orbwalker.BlockAA = true
	end
	if Stealth.Count_Alt == 0 then
		self.RActive = false
		Orbwalker.BlockAA = false
	end
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Khazix:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * GetMyLevel() / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        if FinalArmor <= 0 then
            FinalArmor = 0
        end
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Khazix:QDmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Khazix:GetDamage(36 + 25 * myHero:GetSpellSlot(0).Level + 1.3 * myHero.BonusAttack, true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self:Isolated(Target) then
        FinalFullDmg = FinalFullDmg * 2.1
    end
    return FinalFullDmg
end

function Khazix:AAandPassive(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local AADmg = Khazix:GetDamage(TotalAD * 2, true, Target)
    local Passive = Khazix:GetDamage(8 + 6 * GetMyLevel() + 0.4 * myHero.BonusAttack, false, Target)
    local FinalFullDmg = AADmg
    if Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + Passive
    end
    return FinalFullDmg
end

function Khazix:WDmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local WDmg = Khazix:GetDamage(55 + 30 * myHero:GetSpellSlot(1).Level + myHero.BonusAttack, true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    return FinalFullDmg
end

function Khazix:EDmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local EDmg = Khazix:GetDamage(30 + 35 * myHero:GetSpellSlot(2).Level + 0.2 * myHero.BonusAttack, true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL3") then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    return FinalFullDmg
end

function Khazix:FullComboDMG(Target)
    return self:QDmg(Target) + self:WDmg(Target) + self:EDmg(Target) + self:AAandPassive(Target)
end

-----combo-----

function Khazix:QKS()
    if Engine:SpellReady("HK_SPELL1") then
        if myHero.BuffData:GetBuff("KhazixQEvo").Count_Alt > 0 then
            local Target = Orbwalker:GetTarget("Combo", self.QRange + 50)
            if Target and self:QDmg(Target) > Target.Health and GetDist(Target.Position, myHero.Position) < self.QRange then     
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            end
        else
            local Target = Orbwalker:GetTarget("Combo", self.QRange)
            if Target and self:QDmg(Target) > Target.Health and GetDist(Target.Position, myHero.Position) < self.QRange then 
                Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                return
            end
        end
    end
end

function Khazix:Combo()

    local Stealth = myHero.BuffData:GetBuff("khazixrstealth").Count_Alt == 0
    local QRange = 325
    if myHero.BuffData:GetBuff("KhazixQEvo").Count_Alt > 0 then
        QRange = 375
    else
        QRange = 325
    end

    if Engine:SpellReady("HK_SPELL3") then
        if self.ComboE.Value == 1 and Stealth then
            if myHero.BuffData:GetBuff("KhazixEEvo").Count_Alt > 0 then
			    local Target = Orbwalker:GetTarget("Combo", self.ERange + 200 + getAttackRange() - 100 + Khazix:Prowler_Check())
                if Target then
                    local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange + 200 + getAttackRange() - 100 + Khazix:Prowler_Check(), self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                    if PredPos then 
                        if GetDist(Target.Position, myHero.Position) >= 450 then
                            if (self:FullComboDMG(Target) * (self.EComboAdjust.Value / 100)) > Target.Health then
                                local CastPos = self:GetECastPos(PredPos, Target)
                                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                                return
                            end
                        else
                            if GetDist(Target.Position, myHero.Position) >= QRange then
                                if self:QDmg(Target) > Target.Health then
                                    local CastPos = self:GetECastPos(PredPos, Target)
                                    Engine:CastSpell("HK_SPELL3", CastPos, 1)
                                    return
                                end
                            else
                                local HeroList = ObjectManager.HeroList
	                            for i, Hero in pairs(HeroList) do	
                                    if Hero.Team ~= myHero.Team and Hero.IsTargetable and Hero.IsDead == false and Hero ~= Target then
                                        if Hero then
                                            if self:QDmg(Target) > Target.Health then
                                                if GetDist(myHero.Position, Hero.Position) > self.ERange + 200 + getAttackRange() - 100 + Khazix:Prowler_Check() then
                                                    if self:QDmg(Hero) > Hero.Health then
                                                        local CastPos = self:GetECastPos(Hero.Position, Hero)
                                                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
                                                        return
                                                    end
                                                    if (self:FullComboDMG(Target) * (self.EComboAdjust.Value / 100)) > Target.Health and self:Isolated(Hero) then
                                                        local CastPos = self:GetECastPos(Hero.Position, Hero)
                                                        Engine:CastSpell("HK_SPELL3", CastPos, 1)
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
                end
            else
                local Target = Orbwalker:GetTarget("Combo", self.ERange + getAttackRange() - 100 + Khazix:Prowler_Check())
                if Target then
                    local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange + getAttackRange() - 100 + Khazix:Prowler_Check(), self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                    if PredPos then
                        if GetDist(Target.Position, myHero.Position) >= 350 then
                            if (self:FullComboDMG(Target) * (self.EComboAdjust.Value / 100)) > Target.Health then
                                local CastPos = self:GetECastPos(PredPos, Target)
                                Engine:CastSpell("HK_SPELL3", CastPos, 1)
                                return
                            end
                        end
                    end
			    end
            end
		end
    end


	if Engine:SpellReady("HK_SPELL1") then
        if self.ComboQ.Value == 1 and Stealth then
            if myHero.AIData.Dashing == true then
                if myHero.BuffData:GetBuff("KhazixQEvo").Count_Alt > 0 then
                    local Target = Orbwalker:GetTarget("Combo", self.QRange + 50)
                    if Target then 
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                else
                    local Target = Orbwalker:GetTarget("Combo", self.QRange)
                    if Target then
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
            else
                if myHero.BuffData:GetBuff("KhazixQEvo").Count_Alt > 0 then
                    local Target = Orbwalker:GetTarget("Combo", self.QRange + 50)
                    if Target then
                        if Orbwalker.ResetReady == 1 then   
                            Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                            return
                        end
                    end
                else
                    local Target = Orbwalker:GetTarget("Combo", self.QRange)
                    if Target then
                        if Orbwalker.ResetReady == 1 then   
                            Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                            return
                        end
                    end
                end
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and Stealth then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= getAttackRange() or myHero.AIData.Dashing == false then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
            else
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

    if self.RComboHP.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local Rcondition = myHero.MaxHealth / 100 * self.RComboHPSlider.Value
        if myHero.Health <= Rcondition then
            local target = Orbwalker:GetTarget("Combo", 1000)
            if target ~= nil then
                if GetDist(myHero.Position, target.Position) <= getAttackRange() + 150 then
                    if Orbwalker.ResetReady == 1 and not Engine:SpellReady("HK_SPELL1")  then 
                        Engine:CastSpell("HK_SPELL4", nil)
                        return
                    end
                else
                    if not Engine:SpellReady("HK_SPELL3") then
                        Engine:CastSpell("HK_SPELL4", nil)
                        return
                    end
                end
            end
        end
    end

end


function Khazix:Harass()

    if Engine:SpellReady("HK_SPELL3") then
        if self.HarassE.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixEEvo").Valid then
			    local Target = Orbwalker:GetTarget("Harass", self.ERange + 200)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                        return
                    end
                end
            end
		end
    end

	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
			if Target then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
			end
		end
    end

	if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
            if myHero.BuffData:GetBuff("KhazixQEvo").Valid then
			    local Target = Orbwalker:GetTarget("Harass", self.QRange + 50)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
            end
        end
    end
    
    if Engine:SpellReady("HK_SPELL1") then
        if self.HarassQ.Value == 1 then
			    local Target = Orbwalker:GetTarget("Harass", self.QRange)
			    if Target then
                    if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then  
                        Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                        return
                    end
                end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL2", PredPos, 1)
                    return
                end
            end
        end
    end

end

function Khazix:Laneclear()

    if Engine:SpellReady("HK_SPELL3") then
		if self.ClearE.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
            local sliderValue = self.LClearSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
			if myHero.Mana >= condition then
			    if Target then
				    Engine:CastSpell("HK_SPELL3", Target.Position, 0)
                    return
                end
			end
		end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", 300)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if Orbwalker.ResetReady == 1 then
                        Engine:CastSpell("HK_SPELL2", Target.Position, 0)
                        return
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target then
            if GetDist(myHero.Position, Target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    if Orbwalker.ResetReady == 1 then
                        Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                        return
                    end
                end
            end
        end
    end
end

--end---


function Khazix:OnTick()
    --myHero.BuffData:ShowAllBuffs()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        --[[local Target = Orbwalker:GetTarget("Laneclear", 3000)
        if Target ~= nil then
            print("Qdmg: ", self:QDmg(Target))
            print("FullCombo: ", self:FullComboDMG(Target))
        end]]
        Khazix:Stealth()
        Khazix:QKS()
        if Engine:IsKeyDown("HK_COMBO") then
            Khazix:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Khazix:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Khazix:Laneclear()
		end
	end
end

function Khazix:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        if myHero.BuffData:GetBuff("KhazixQEvo").Count_Alt > 0 then
            Render:DrawCircle(myHero.Position, self.QRange +50 ,255,20,147,255)
        else    
            Render:DrawCircle(myHero.Position, self.QRange ,255,20,147,255)
        end
    end

	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        if myHero.BuffData:GetBuff("KhazixEEvo").Count_Alt > 0 then
            Render:DrawCircle(myHero.Position, self.ERange +200 ,255,20,147,255)
        else    
            Render:DrawCircle(myHero.Position, self.ERange ,255,20,147,255)
        end
    end
end

function Khazix:OnLoad()
    if(myHero.ChampionName ~= "Khazix") then return end
	AddEvent("OnSettingsSave" , function() Khazix:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Khazix:LoadSettings() end)


	Khazix:__init()
	AddEvent("OnTick", function() Khazix:OnTick() end)	
    AddEvent("OnDraw", function() Khazix:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Khazix:OnLoad() end)	
