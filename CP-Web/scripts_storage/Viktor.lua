Viktor = {} 
function Viktor:__init() 
    self.QRange     = 660
    self.WRange     = 800

    self.ERange_Laser   = 600
    self.ERange_Min     = 525 
    self.ERange_Max     = self.ERange_Min + self.ERange_Laser
    
    self.RRange     = 700

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = 1050
    self.RSpeed = math.huge

    self.WWidth = 200
    self.RWidth = 350
    self.EWidth = 90

    self.QDelay = 0.25
    self.WDelay = 0.25
    self.EDelay = 0.00
    self.RDelay = 0.25

    self.LastRCommand = 0

    self.WHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ChampionMenu   = Menu:CreateMenu("Viktor") 
    --------------------------------------------
    self.ComboMenu      = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ         = self.ComboMenu:AddCheckbox("Use Q", 1)
    self.ComboW         = self.ComboMenu:AddCheckbox("Use W", 1) 
    self.ComboE         = self.ComboMenu:AddCheckbox("Use E", 1) 
    self.ComboR         = self.ComboMenu:AddCheckbox("Use R", 1) 
    --------------------------------------------
    self.HarassMenu     = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider   = self.HarassMenu:AddSlider("Harass Mana Percentage", 20,1,100,1)
    self.HarassQ        = self.HarassMenu:AddCheckbox("Use Q", 1) 
    self.HarassE        = self.HarassMenu:AddCheckbox("Use E", 1) 
    self.HarassQLasthit = self.HarassMenu:AddCheckbox("Use Q for Lasthits", 1) 
    --------------------------------------------
    self.ClearMenu      = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.ClearSlider    = self.ClearMenu:AddSlider("Clear Mana Percentage", 20,1,100,1)
    self.ClearQ         = self.ClearMenu:AddCheckbox("Use Q", 1) 
    self.ClearE         = self.ClearMenu:AddCheckbox("Use E", 1)   
    --------------------------------------------
    self.LasthitMenu    = self.ChampionMenu:AddSubMenu("Lasthit") 
    self.LasthitQ       = self.LasthitMenu:AddCheckbox("Use Q", 1) 
    --------------------------------------------
	self.DrawMenu       = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ          = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW          = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE          = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR          = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Viktor:LoadSettings()  
end 

function Viktor:SaveSettings() 
    SettingsManager:CreateSettings("Viktor")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboW.Value)
    SettingsManager:AddSettingsInt("UseE", self.ComboE.Value)
    SettingsManager:AddSettingsInt("UseR", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("ManaPercentage", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("UseQ", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("UseE", self.HarassE.Value)
    SettingsManager:AddSettingsInt("UseQLasthit", self.HarassQLasthit.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("ManaPercentage", self.ClearSlider.Value)
    SettingsManager:AddSettingsInt("UseQ", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("UseE", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Lasthit")
    SettingsManager:AddSettingsInt("UseQ", self.LasthitQ.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
    --------------------------------------------
end

function Viktor:LoadSettings()
    SettingsManager:GetSettingsFile("Viktor")
     --------------------------------------------
	self.ComboQ.Value           = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboW.Value           = SettingsManager:GetSettingsInt("Combo","UseW")
    self.ComboE.Value           = SettingsManager:GetSettingsInt("Combo","UseE")
    self.ComboR.Value           = SettingsManager:GetSettingsInt("Combo","UseR")
    --------------------------------------------
    self.HarassSlider.Value     = SettingsManager:GetSettingsInt("Harass","ManaPercentage")
    self.HarassQ.Value          = SettingsManager:GetSettingsInt("Harass","UseQ")
    self.HarassE.Value          = SettingsManager:GetSettingsInt("Harass","UseE")  
    self.HarassQLasthit.Value   = SettingsManager:GetSettingsInt("Harass","UseQLasthit")
    --------------------------------------------
    self.ClearSlider.Value      = SettingsManager:GetSettingsInt("LaneClear","ManaPercentage")
    self.ClearQ.Value           = SettingsManager:GetSettingsInt("LaneClear","UseQ")
    self.ClearE.Value           = SettingsManager:GetSettingsInt("LaneClear","UseE")
    --------------------------------------------
    self.LasthitQ.Value         = SettingsManager:GetSettingsInt("Lasthit","UseQ")
    --------------------------------------------
    self.DrawQ.Value            = SettingsManager:GetSettingsInt("Drawings","DrawQ")
    self.DrawW.Value            = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value            = SettingsManager:GetSettingsInt("Drawings","DrawE")
    self.DrawR.Value            = SettingsManager:GetSettingsInt("Drawings","DrawR")
    --------------------------------------------
end

function Viktor:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
end

function Viktor:GetELaneclearCastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 125
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Viktor:GetSecondETargetCombo(FirstTarget)
	local Hero = Orbwalker.ForceTarget
	if Hero ~= nil and Hero.Team ~= myHero.Team and Hero.IsHero and Hero.IsTargetable then
        print('xd3',self:GetDistance(myHero.Position , Hero.Position) < self.ERange_Max)
		if self:GetDistance(myHero.Position , Hero.Position) < self.ERange_Max then
            return Hero, true
        end
	end
	
	if Hero ~= nil and Prediction.ForceTargetOnly.Value == 1 then
		return nil, true
	end

	local TargetSelector = Orbwalker:GetTargetSelectorList(myHero.Position, self.ERange_Max)
	for _, Hero in pairs(TargetSelector) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if FirstTarget then
                if Hero.Index ~= FirstTarget.Index  then
                    if Hero.Health < FirstTarget.Health then
                        if self:GetDistance(myHero.Position, Hero.Position) < self.ERange_Max then
                            return Hero, false
                        end    
                    else
                        if self:GetDistance(FirstTarget.Position, Hero.Position) < self.ERange_Laser then
                            return Hero, false
                        end        
                    end
                end
                return Hero, false
            else
                return Hero, false
            end
        end
    end
    return nil, false
end

function Viktor:GetECastPositionsCombo()
    local PlayerPos             = myHero.Position
    local FirstTarget           = Orbwalker:GetTarget("Combo", self.ERange_Min - 50)
    local SecondTarget, Force   = self:GetSecondETargetCombo(FirstTarget)
    
    local StartPos      = nil
    local MaxPredPos    = nil
    
    -- if FirstTarget and SecondTarget then
    --     StartPos        = FirstTarget.Position
    --     MaxPredPos      = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
    -- end

    -- if FirstTarget and SecondTarget == nil then
    --     print('2')
    --     StartPos        = FirstTarget.Position
    --     MaxPredPos      = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
    -- end
    if (StartPos == nil or Force == true)  and SecondTarget then
        -- if FirstTarget then
        --     local CheckPos = FirstTarget.Position
        --     PredPos      = Prediction:GetCastPos(CheckPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, 0.4, 1)
        --     if self:GetDistance(CheckPos, PredPos) < self.ERange_Laser then
        --         print('1')
        --         return CheckPos, PredPos
        --     end
        -- end

        local factor = 200

        local TargetPos     = SecondTarget.Position
        local TargetVec     = Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
        local Distance      = math.sqrt((TargetVec.x * TargetVec.x) + (TargetVec.y * TargetVec.y) + (TargetVec.z * TargetVec.z))
        local VectorNorm    = Vector3.new(TargetVec.x / Distance, TargetVec.y / Distance, TargetVec.z / Distance)
        if self:GetDistance(myHero.Position, TargetPos) <= myHero.AttackRange + myHero.CharData.BoundingRadius then
            factor = 550
            StartPos      = Vector3.new(PlayerPos.x + (VectorNorm.x*(self.ERange_Min - factor)),PlayerPos.y + (VectorNorm.y*(self.ERange_Min - factor)),PlayerPos.z + (VectorNorm.z*(self.ERange_Min - factor)) ) 
            MaxPredPos    = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        else
            StartPos      = Vector3.new(PlayerPos.x + (VectorNorm.x*(self.ERange_Min - factor)),PlayerPos.y + (VectorNorm.y*(self.ERange_Min - factor)),PlayerPos.z + (VectorNorm.z*(self.ERange_Min - factor)) ) 
            MaxPredPos    = Prediction:GetCastPos(StartPos, self.ERange_Max, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        end
    end
    return StartPos, MaxPredPos
end

function Viktor:GetSecondETargetLaneclear(FirstTarget)
    local List = ObjectManager.MinionList
    local Minions = Orbwalker:SortList(List, "LOWHP")
    for I, Minion in pairs(Minions) do
        if Minion.Team ~= myHero.Team and Minion.IsTargetable and self:GetDistance(myHero.Position, Minion.Position) < self.ERange_Max then
            if FirstTarget then
                if Minion.Index ~= FirstTarget.Index then
                    return Minion
                end
            else
                return Minion
            end
        end
    end
    return nil
end

function Viktor:GetECastPositionsClear()
    local PlayerPos     = myHero.Position
    local FirstTarget   = Orbwalker:GetTarget("Laneclear", self.ERange_Min - 50)
    if FirstTarget and FirstTarget.IsMinion then
        local SecondTarget  = self:GetSecondETargetLaneclear(FirstTarget)
    
        local MinPredPos    = FirstTarget.Position
        local MaxPredPos    = self:GetELaneclearCastPos(MinPredPos)
        if MinPredPos ~= nil and MaxPredPos ~= nil then
            return MinPredPos, MaxPredPos
        end    
    end
    return nil, nil
end

function Viktor:GetStormObject()
    local Minions = ObjectManager.MinionList
    for I, Object in pairs(Minions) do
        if Object.ChampionName == "ViktorSingularity" and Object.Team == myHero.Team and Object.Health > 0 then
            return Object
        end
    end
    return nil
end

function Viktor:Ultimate()
    local Timer = os.clock() - self.LastRCommand
    if Timer > 2.0 then
        local Storm = self:GetStormObject()
        if Storm then
            local PredPos, Target = Prediction:GetCastPos(Storm.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 0)
            if PredPos and Target then
                Engine:CastSpell("HK_SPELL4", PredPos, 1)     
            end
        end
        self.LastRCommand = os.clock()
    end
end

function Viktor:QDamageCheck()
    local QBuff = myHero.BuffData:GetBuff("ViktorPowerTransferReturn")
    if QBuff.Count_Alt > 0 then
        local QDamagePerLevel   = {20 , 45 , 70 , 95 , 120}
        local QLevel            = math.max(1, myHero:GetSpellSlot(0).Level)
        local QDamageRaw        = QDamagePerLevel[QLevel] + (myHero.AbilityPower * 0.5)
    
        Orbwalker.ExtraDamage   = QDamageRaw
    else
        Orbwalker.ExtraDamage = 0
    end
end

function Viktor:Combo()
    if self.ComboR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local QDamagePerLevel = {60 , 75 , 90 , 105 , 120}
        local EDamageperLevel = {70 , 110 , 150 , 190 , 230}
        local RDamagePerLevel = {100 , 175 , 250}
    
        local QLevel = math.max(1, myHero:GetSpellSlot(0).Level)
        local ELevel = math.max(1, myHero:GetSpellSlot(2).Level)
        local RLevel = math.max(1, myHero:GetSpellSlot(3).Level)
    
        local QDamageRaw = QDamagePerLevel[QLevel] + (myHero.AbilityPower * 0.5)
        local EDamageRaw = QDamagePerLevel[ELevel] + (myHero.AbilityPower * 0.5)
        local RDamageRaw = QDamagePerLevel[RLevel] + (myHero.AbilityPower * 0.5)
    
        local BurstDamageRaw = QDamageRaw + EDamageRaw + RDamageRaw
        
        local RName = myHero:GetSpellSlot(3).Info.Name
        local Target = Orbwalker:GetTarget("Combo", self.RRange-20)
        if Target and RName == "ViktorChaosStorm" and Target.Health < (BurstDamageRaw * 3) then
            return Engine:CastSpell("HK_SPELL4", Target.Position, 1)     
        end
    end
    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Point1, Point2 = self:GetECastPositionsCombo()
        if Point1 and Point2 and self:GetDistance(myHero.Position, Point2) < self.ERange_Max and self:GetDistance(Point1, Point2) < self.ERange_Laser then
            return Engine:CastSpell2Points("HK_SPELL3", Point1, Point2, 0)
        end
    end
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.QRange-20)
        if Target and (Orbwalker.Attack == 0 or Orbwalker.ResetReady == 1) then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 1)     
        end
        return
    end
    local QBuff = myHero.BuffData:GetBuff("ViktorPowerTransferReturn")
    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") and QBuff.Count_Alt == 0 then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
        if PredPos and Target and self:GetDistance(PredPos,myHero.Position) < self.WRange-20 and Orbwalker.Attack == 0 then
            return Engine:CastSpell("HK_SPELL2", PredPos, 1)
        end
    end
end

function Viktor:GetLasthitTarget()
    local List = ObjectManager.MinionList
    local Minions = Orbwalker:SortList(List, "LOWHP")
    for I, Minion in pairs(Minions) do
        if Minion.MaxHealth > 10 and Minion.Team ~= myHero.Team and Minion.IsTargetable and self:GetDistance(myHero.Position, Minion.Position) < Orbwalker.OrbRange then
            local QCastDamagePerLevel   = {60 , 75 , 90 , 105 , 120}
            local QAutoDamagePerLevel   = {20 , 45 , 70 , 95 , 120}
            local QLevel                = math.max(1, myHero:GetSpellSlot(0).Level)
            
            local QCastDamage           = QCastDamagePerLevel[QLevel] + (myHero.AbilityPower * 0.5)
            local QAutoDamage           = QAutoDamagePerLevel[QLevel] + (myHero.AbilityPower * 0.5) + (myHero.BaseAttack + myHero.BonusAttack)
            local QDamageRaw            = QCastDamage + QAutoDamage
            if Minion.Health < QDamageRaw then            
                return Minion
            end
        end
    end
    return nil
end

function Viktor:Harass()
    if (myHero.Mana / myHero.MaxMana) * 100 < self.HarassSlider.Value then return end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.Attack == 0 then
        local Point1, Point2 = self:GetECastPositionsCombo()
        if Point1 and Point2 and self:GetDistance(myHero.Position, Point2) < self.ERange_Max and self:GetDistance(Point1, Point2) < self.ERange_Laser then
            return Engine:CastSpell2Points("HK_SPELL3", Point1, Point2, 0)
        end
    end


    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 1)     
        end
    end
    if self.HarassQLasthit.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 and Orbwalker:CanAttack() then
        local Target = self:GetLasthitTarget()
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
        end
    end
end

function Viktor:Laneclear()
    if (myHero.Mana / myHero.MaxMana) * 100 < self.ClearSlider.Value then return end

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 then
        local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if Target and Target.IsMinion == true then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 0)     
        end
    end
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Point1, Point2 = self:GetECastPositionsClear()
        if Point1 and Point2 then
            return Engine:CastSpell2Points("HK_SPELL3", Point1, Point2, 0)
        end
    end
end

function Viktor:Lasthit()
    if self.LasthitQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 and Orbwalker:CanAttack() then
        local Target = self:GetLasthitTarget()
        if Target then
            return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
        end
    end
end

function Viktor:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
        self:Ultimate()
        self:QDamageCheck()

        if Engine:IsKeyDown("HK_COMBO") then
            return Viktor:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            return Viktor:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            return Viktor:Laneclear()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            return Viktor:Lasthit()
		end
	end
end

function Viktor:OnDraw()
    --[[local Point1, Point2 = self:GetECastPositions()
    if Point1 then
        Render:DrawCircle(Point1, 35 ,100,150,255,255)
    end
    if Point2 then
        Render:DrawCircle(Point2, 35 ,100,150,255,255)
    end]]

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange_Min ,255,200,55,255)
        Render:DrawCircle(myHero.Position, self.ERange_Max ,255,200,55,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        local Storm = self:GetStormObject()
        if Storm then
            Render:DrawCircle(Storm.Position, self.RRange ,255,0,0,255)    
        else
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)    
        end
    end
end

function Viktor:OnLoad()
    if(myHero.ChampionName ~= "Viktor") then return end
	AddEvent("OnSettingsSave" , function() Viktor:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Viktor:LoadSettings() end)


	Viktor:__init()
	AddEvent("OnTick", function() Viktor:OnTick() end)	
    AddEvent("OnDraw", function() Viktor:OnDraw() end)
end

AddEvent("OnLoad", function() Viktor:OnLoad() end)	
