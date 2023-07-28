--Credits to Critic, Scortch, Christoph


local Qiyana = {
    BottomRiver = {
        Vector3.new(8796.0,-71.240600585938,6022.0),
       -- Vector3.new(9868.0 ,-71.240600585938,5936.0),
        Vector3.new(9918.0 ,-70.777191162109,5504.0),
       -- Vector3.new(10290.0,-67.095893859863,4952.0),
        Vector3.new(9856.0,-71.240600585938,4444.0),
        Vector3.new(11102.0,-68.635971069336,5080.0),
      --  Vector3.new(10736.0,-63.389343261719,4818.0),
       -- Vector3.new(11042.0,-68.837188720703,5146.0),
      --  Vector3.new(11368.0,-71.240600585938,4486.0),
       -- Vector3.new(11100.0,-71.240600585938,3926.0),
        Vector3.new(11568.0,-69.175048828125,3500.0),
        Vector3.new(8058.0,-38.284664154053,6724.0), --bottom river bush
    },

    TopRiver = {
        Vector3.new(5896.0,-71.240600585938,8872.0),
        Vector3.new(4764.0,-68.25643157959,9158.0),
        Vector3.new(3452.0,-66.052558898926,10220.0),
        Vector3.new(5182.0,-71.240600585938,10704.0),
        Vector3.new(2922.0,-20.796552658081,11828.0),
        Vector3.new(6728.0,-62.309097290039,8106.0),--top riverbush
    }
}

function Qiyana:__init() 
    self.QRange = 525
    self.Q2Range = 865

    self.WRange = 1100
    self.ERange = 650
    self.RRange = 875

    self.QSpeed = math.huge
    self.Q2Speed = 1600
    self.RSpeed = 2000

    self.QWidth = 140
    self.Q2Width = 200
    self.RWidth = 120

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.RDelay = 0.25

    self.QHitChance = 0.2
    self.RHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Qiyana") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 0)
    self.ComboWQ = self.ComboMenu:AddCheckbox("Use W after Q/E reset Q", 1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("R KS", 1)
    self.ComboRR = self.ComboMenu:AddCheckbox("Use R in Combo w/ x enemies", 1)
	self.ComboRSlider = self.ComboMenu:AddSlider("Use R if more then x enemies in R range", 3, 0, 4, 1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 0) 
    self.HarassWQ = self.HarassMenu:AddCheckbox("Use W after Q/E reset Q", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1)  
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawKillable = self.DrawMenu:AddCheckbox("Draw if killable", 1)
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Qiyana:LoadSettings()  
end 
function Qiyana:SaveSettings() 
    --combo save settings--
    SettingsManager:CreateSettings("Qiyana")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use W after Q/E reset Q", self.ComboWQ.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("R KS", self.ComboR.Value)
    SettingsManager:AddSettingsInt("Use R in Combo w/ enemies", self.ComboRR.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.ComboRSlider.Value)
    --------------------------------------------
    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use W after Q/E reset Q", self.HarassWQ.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
	--drawings save settings--
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw if killable", self.DrawKillable.Value)
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end
function Qiyana:LoadSettings()
    SettingsManager:GetSettingsFile("Qiyana")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboWQ.Value = SettingsManager:GetSettingsInt("Combo","Use W after Q/E reset Q")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "R KS")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo", "Use R in Combo w/ enemies")
    self.ComboRSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
    --------------------------------------------
    --------------------------------Harass load----------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassWQ.Value = SettingsManager:GetSettingsInt("Harass","Use W after Q/E reset Q")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    --------------------------------LC load----------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
     --------------------------------Draw load----------------------
    self.DrawKillable.Value = SettingsManager:GetSettingsInt("Drawings","Draw if killable")
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
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

function GetTowersAround(Position, Range)
    local Count = 0 
	local TowerList = ObjectManager.TurretList
	for i, Tower in pairs(TowerList) do	
		if Tower.Team ~= myHero.Team and Tower.Health > 100 and Tower.MaxHealth > 1000 then
			if GetDist(Tower.Position, Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Qiyana:StunCheck(Target)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= Target.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	for i = 25, 450 , 25 do
		local EndPos = Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
		if Engine:IsNotWall(EndPos) == false then
			return true
		end
	end
	return false
end

function Qiyana:StunCheckR(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local right = PlayerPos
    for i = 25, 750 , 25 do
        right.x = right.x + i
        if Engine:IsNotWall(right) == false then
            if GetDist(right, TargetPos) <= 700 then
                return right
            end
		end
    end
    return nil
end

function Qiyana:StunCheckL(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local left = PlayerPos
    for i = 25, 750 , 25 do
        left.x = left.x - i
        if Engine:IsNotWall(left) == false then
            if GetDist(left, TargetPos) <= 700 then
                return left
            end
		end
    end
    return nil
end

function Qiyana:StunCheckT(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local top = PlayerPos
    for i = 25, 750 , 25 do
        top.z = top.z + i
        if Engine:IsNotWall(top) == false then
            if GetDist(top, TargetPos) <= 700 then
                return top
            end
		end
    end
    return nil
end

function Qiyana:StunCheckD(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local down = PlayerPos
    for i = 25, 750 , 25 do
        down.z = down.z - i
        if Engine:IsNotWall(down) == false then
            if GetDist(down, TargetPos) <= 800 then
                return down
            end
		end
	end
    return nil
end


function Qiyana:Damage(Target)
    local QLevel = myHero:GetSpellSlot(0).Level
    local QDamage
    local Qbonus
    local QQdmg
    if QLevel ~= 0 then
        QDamage = {60, 85, 110, 135, 160}
        Qbonus = (myHero.BonusAttack * 0.9)
        QQdmg = GetDamage(QDamage[QLevel] + Qbonus, false, Target)
    end
    local WLevel = myHero:GetSpellSlot(1).Level
    local WDamage
    local Wbonus
    local WWdmg
    if WLevel ~= 0 then
        WDamage = {8, 22, 36, 50, 64}
        Wbonus = (myHero.AbilityPower * 0.45) + (myHero.BonusAttack * 0.10)
        WWdmg = GetDamage(WDamage[WLevel] + Wbonus, false, Target)
    end

    local ELevel = myHero:GetSpellSlot(2).Level
    local EDamage
    local Ebonus
    local EEdmg
    if ELevel ~= 0 then
        EDamage = {50, 80, 110, 140, 170}
        Ebonus = (myHero.BonusAttack * 0.70)
        EEdmg = GetDamage(EDamage[ELevel] + Ebonus, false, Target)
    end


    local RLevel = myHero:GetSpellSlot(3).Level
    local RDamage
    local Rbonus
    local RRdmg
    if RLevel ~= 0 then
        RDamage = {100, 200, 300}
        Rbonus = (myHero.BonusAttack * 1.70)
        RHealth = (Target.MaxHealth * 0.1)
        RRdmg = GetDamage(RDamage[RLevel] + Rbonus + RHealth, false, Target)
    end
    local FinalFullDmg = 0
    if self.ComboQ.Value == 1 and  Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + QQdmg
    end
    if Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WWdmg
    end
    if self.ComboE.Value == 1 and  Engine:SpellReady("HK_SPELL3") then
        FinalFullDmg = FinalFullDmg + EEdmg
    end

    if Engine:SpellReady("HK_SPELL4") and self.ComboR.Value == 1 and self:StunCheck(Target) == true then
        FinalFullDmg = FinalFullDmg + RRdmg
    end
    return FinalFullDmg
end

function Qiyana:Ultimate()
    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 600 then
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local RDamage = {100, 200, 300}
                    local Rbonus = (myHero.BonusAttack * 1.70)
                    local RHealth = (target.MaxHealth * 0.1)
                    local RRdmg = GetDamage(RDamage[RLevel] + (Rbonus + RHealth), false, target)
                    if RRdmg >= target.Health and self:StunCheck(target) == true then
                        local PredPos, target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL4", PredPos, 1)
                            return
                        end
                    end
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL4") and self.ComboRR.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil and GetDist(myHero.Position, target.Position) <= 600 then
            if EnemiesInRange(target.Position, 250) > self.ComboRSlider.Value and self:StunCheck(target) == true then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end
end

function Qiyana:Combo()

    local Rock  = myHero.BuffData:GetBuff("QiyanaQ_Rock")
    local Water = myHero.BuffData:GetBuff("QiyanaQ_Water")
    local Grass =  myHero.BuffData:GetBuff("QiyanaQ_Grass")

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Rock.Count_Alt == 0 and Water.Count_Alt == 0 and Grass.Count_Alt == 0 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Rock.Count_Alt > 0 or Water.Count_Alt > 0 or Grass.Count_Alt > 0 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, self.Q2Width, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.Q2Range then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

   
    if self.ComboWQ.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then 
        local closestSpotToEnemy = nil
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil and target.Health >=  target.MaxHealth/ 100 * 30  then 
            for i, spot in pairs(self.TopRiver) do 
                if closestSpotToEnemy == nil then 
                    closestSpotToEnemy = spot 
                end
                if GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then 
                    closestSpotToEnemy = spot 
                end
            end
            if closestSpotToEnemy ~= nil and GetDist(myHero.Position, closestSpotToEnemy) <= 1100 then
                Engine:CastSpell("HK_SPELL2", closestSpotToEnemy, 0)
            end
        else
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL2", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL2", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL2", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL2", wallD, 0)
            end
        end
        if target ~= nil and target.Health >=  target.MaxHealth/ 100 * 30  then 
            for i, spot in pairs(self.BottomRiver) do 
                if closestSpotToEnemy == nil then 
                    closestSpotToEnemy = spot 
                end
                if GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then 
                    closestSpotToEnemy = spot 
                end
            end
            if closestSpotToEnemy ~= nil and GetDist(myHero.Position, closestSpotToEnemy) <= 1100 then
                Engine:CastSpell("HK_SPELL2", closestSpotToEnemy, 0)
            end
        else
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL2", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL2", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL2", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL2", wallD, 0)
            end
        end
        for i, spot in pairs(self.TopRiver) do
            if closestSpotToEnemy == nil then
                closestSpotToEnemy = spot
            end
            if target ~= nil and GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then
                closestSpotToEnemy = spot
            end
            if GetDist(myHero.Position, spot) >= 1100 then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        
        end
        for i, spot in pairs(self.BottomRiver) do
            if closestSpotToEnemy == nil then
                closestSpotToEnemy = spot
            end
            if target ~= nil and GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then
                closestSpotToEnemy = spot
            end
            if GetDist(myHero.Position, spot) >= 1100 then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        end
    end

  if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then 
        local closestSpotToEnemy = nil
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil and target.Health >=  target.MaxHealth/ 100 * 30  then 
            for i, spot in pairs(self.TopRiver) do 
                if closestSpotToEnemy == nil then 
                    closestSpotToEnemy = spot 
                end
                if GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then 
                    closestSpotToEnemy = spot 
                end
            end
            if closestSpotToEnemy ~= nil and GetDist(myHero.Position, closestSpotToEnemy) <= 1100 then
                Engine:CastSpell("HK_SPELL2", closestSpotToEnemy, 0)
            end
        else
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL2", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL2", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL2", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL2", wallD, 0)
            end
        end

        if target ~= nil and target.Health >=  target.MaxHealth/ 100 * 30  then 
            for i, spot in pairs(self.BottomRiver) do 
                if closestSpotToEnemy == nil then 
                    closestSpotToEnemy = spot 
                end
                if GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then 
                    closestSpotToEnemy = spot 
                end
            end
            if closestSpotToEnemy ~= nil and GetDist(myHero.Position, closestSpotToEnemy) <= 1100 then
                Engine:CastSpell("HK_SPELL2", closestSpotToEnemy, 0)
            end
        else
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL2", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL2", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL2", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL2", wallD, 0)
            end
        end 
        for i, spot in pairs(self.TopRiver) do
            if closestSpotToEnemy == nil then
                closestSpotToEnemy = spot
            end
            if target ~= nil and GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then
                closestSpotToEnemy = spot
            end
            if GetDist(myHero.Position, spot) >= 1100 then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        
        end
        for i, spot in pairs(self.BottomRiver) do
            if closestSpotToEnemy == nil then
                closestSpotToEnemy = spot
            end
            if target ~= nil and GetDist(spot, target.Position) < GetDist(closestSpotToEnemy, target.Position) then
                closestSpotToEnemy = spot
            end
            if GetDist(myHero.Position, spot) >= 1100 then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        
        end
    end
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil and GetDist(myHero.Position, target.Position) < self.ERange then
            Engine:CastSpell("HK_SPELL3", target.Position, 1)
        end
    end
end

function Qiyana:Harass()

    local Rock  = myHero.BuffData:GetBuff("QiyanaQ_Rock")
    local Water = myHero.BuffData:GetBuff("QiyanaQ_Water")
    local Grass =  myHero.BuffData:GetBuff("QiyanaQ_Grass")

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Rock.Count_Alt == 0 and Water.Count_Alt == 0 and Grass.Count_Alt == 0 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.QRange then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Rock.Count_Alt > 0 or Water.Count_Alt > 0 or Grass.Count_Alt > 0 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.Q2Range, self.Q2Speed, self.Q2Width, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.Q2Range then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil and GetDist(myHero.Position, target.Position) <= self.WRange then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        end
    end

    if self.HarassWQ.Value == 1 and Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.WRange)
        if target ~= nil and GetDist(myHero.Position, target.Position) <= self.WRange then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                local wallT = self:StunCheckT(target)
                local wallL = self:StunCheckL(target)
                local wallR = self:StunCheckR(target)
                local wallD = self:StunCheckD(target) 
                if wallT ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallT, 0)
                end
                if wallL ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallL, 0)
                end
                if wallR ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallR, 0)
                end
                if wallD ~= nil then
                    Engine:CastSpell("HK_SPELL2", wallD, 0)
                end
            end
        end
    end


    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil and GetDist(myHero.Position, target.Position) <= self.ERange and GetTowersAround(target.Position, 750) == 0 then
            local sliderValue = self.HarassSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
                return
            end
        end
    end
end
function Qiyana:Laneclear()

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.WRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL3", Minion.Position, 0)
                    return
                end
            end
        end
    end

end

function Qiyana:KillHealthBox()
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

function Qiyana:OnTick()
    local Pos = myHero.Position
    --print( Pos.x,",",Pos.y,",",Pos.z)
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Qiyana:Ultimate()
            Qiyana:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Qiyana:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Qiyana:Laneclear()
		end
        if Engine:IsKeyDown("HK_LASTHIT") then
        end
	end
end
function Qiyana:OnDraw()
    for i, k in pairs(self.BottomRiver) do
        Render:DrawCircle(k, 50,100,150,100,255)
    end
    for i, k in pairs(self.TopRiver) do
        Render:DrawCircle(k, 50,100,150,100,255)
    end
    
    if self.DrawKillable.Value == 1 then
        Qiyana:KillHealthBox()
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            if myHero.BuffData:GetBuff("QiyanaQ_Rock").Count_Alt > 0 then
                Render:DrawCircle(myHero.Position, self.Q2Range ,100,150,255,255)
             end
            if myHero.BuffData:GetBuff("QiyanaQ_Water").Count_Alt > 0 then
                    Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
            end
            if myHero.BuffData:GetBuff("QiyanaQ_Grass").Count_Alt > 0 then
                    Render:DrawCircle(myHero.Position, self.Q2Range ,100,150,255,255)
            end
    else
         Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)

    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
      end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end
function Qiyana:OnLoad()
    if(myHero.ChampionName ~= "Qiyana") then return end
	AddEvent("OnSettingsSave" , function() Qiyana:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Qiyana:LoadSettings() end)
	Qiyana:__init()
	AddEvent("OnTick", function() Qiyana:OnTick() end)	
    AddEvent("OnDraw", function() Qiyana:OnDraw() end)
end
AddEvent("OnLoad", function() Qiyana:OnLoad() end)	
