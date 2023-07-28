Vayne = {}

--Version 1.5
--Last updated by Derang3d
--updated E knockback for better accuracy, added Q tumble away from target, added Gank e knockback, added Q stealth with R
function Vayne:__init()

	if myHero.Team == 100 then
		self.EnemyBase = Vector3.new(14400, 200, 14400)
	else
		self.EnemyBase = Vector3.new(400, 200, 400)
	end
	
	self.QRange = 0
	self.WRange = 0
	self.ERange = 550
	self.RRange = 0

	self.QSpeed = math.huge
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0.25
    self.RDelay = 0
    
    self.IsEvadeLoaded = false

    self.ChampionMenu = Menu:CreateMenu("Vayne")
	---------------------------------------------------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.GapcloseQ = self.ComboMenu:AddSlider("Gapclose with Q if less than X enemies", 3,1,5,1)
    self.DodgeQ = self.ComboMenu:AddCheckbox("Dodge CC with Q", 1)
    self.forceW = self.ComboMenu:AddSlider("Force champion with X W (0 == off)", 2,0,2,1)
	self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboGankE = self.ComboMenu:AddCheckbox("Anti Gank E", 1)
    self.ComboEKs = self.ComboMenu:AddCheckbox("Smart E KS", 1)
    self.ComboUseStealth = self.ComboMenu:AddCheckbox("Dont attack when stealth on R", 1)
    ---------------------------------------------------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("Use Q backwards", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("Use E on max W stacks", 1)
    ---------------------------------------------------------------------------------------
    self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ Position", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    
	
	self.RActive = false
	Vayne:LoadSettings()
end

function Vayne:SaveSettings()
	SettingsManager:CreateSettings("Vayne")
	SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("Dodge CC with Q", self.DodgeQ.Value)
    SettingsManager:AddSettingsInt("UseQGap", self.GapcloseQ.Value)
    SettingsManager:AddSettingsInt("ForceW", self.forceW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("Anti Gank E", self.ComboGankE.Value)
    SettingsManager:AddSettingsInt("Smart E KS", self.ComboEKs.Value)
	SettingsManager:AddSettingsInt("Dont attack when stealth on R", self.ComboUseStealth.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("HarassQ", self.HarassUseQ.Value)
    SettingsManager:AddSettingsInt("HarassE", self.HarassUseE.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    
end

function Vayne:LoadSettings()
	SettingsManager:GetSettingsFile("Vayne")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
    self.DodgeQ.Value = SettingsManager:GetSettingsInt("Combo","Dodge CC with Q")
    self.GapcloseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQGap")
    self.forceW.Value = SettingsManager:GetSettingsInt("Combo","ForceW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
    self.ComboGankE.Value = SettingsManager:GetSettingsInt("Combo","Anti Gank E")
    self.ComboEKs.Value = SettingsManager:GetSettingsInt("Combo","Smart E KS")
	self.ComboUseStealth.Value = SettingsManager:GetSettingsInt("Combo","Dont attack when stealth on R")
    -------------------------------------------------------------
    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","HarassQ")
    self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","HarassE")
    -------------------------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
    
    if Evade ~= nil then
        self.IsEvadeLoaded = true
    else
        print('enable evade for Dodge Q')
    end

end

function Vayne:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Vayne:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Vayne:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end


function Vayne:QCastPos()
	local PlayerPos 	= GameHud.MousePos
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -300
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Vayne:QCastPos1(Target)
	local PlayerPos 	= Target.Position
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 300
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Vayne:StunCheck(Target)
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
--vaynetumblefade

function Vayne:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Vayne:Qdmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local QDmg = Vayne:GetDamage((1.55 + 0.05 * myHero:GetSpellSlot(0).Level) * TotalAD , true, Target)
    local WDmg = (0.015 + 0.025 * myHero:GetSpellSlot(0).Level) * Target.MaxHealth
    local FinalFullDmg = 0
    FinalFullDmg = FinalFullDmg + QDmg * (1 + myHero.CritMod)

    local Wbuff = Target.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt
    if Wbuff == 2 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    return FinalFullDmg
end

function Vayne:Edmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local AADmg = Vayne:GetDamage(TotalAD, true, Target)
    local EDmg = Vayne:GetDamage((15 + 35 * myHero:GetSpellSlot(0).Level) + 0.5 * myHero.BonusAttack , true, Target)
    local WDmg = (0.015 + 0.025 * myHero:GetSpellSlot(0).Level) * Target.MaxHealth
    local FinalFullDmg = 0
    FinalFullDmg = FinalFullDmg + EDmg + AADmg

    local Wbuff = Target.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt
    if Wbuff == 2 then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    return FinalFullDmg - 10
end

function Vayne:Stealth()
	local Stealth = myHero.BuffData:GetBuff("vaynetumblefade")
	
	if self.ComboUseStealth.Value == 1 then
		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                if Vayne:GetDistance(myHero.Position, Hero.Position) <= myHero.AttackRange then
                    if Hero.Health > Vayne:Qdmg(Hero) then
                        if Stealth.Count_Alt > 0 then
                            self.RActive = true
                            Orbwalker.BlockAA = true
                        end
                    end
                end
			end
		end
		if Stealth.Count_Alt == 0 then
			self.RActive = false
			Orbwalker.BlockAA = false
		end
	end
end

function Vayne:Gank()
	if Engine:SpellReady("HK_SPELL3") and self.ComboGankE.Value == 1 then
		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team and Hero.IsTargetable then
                if Vayne:GetDistance(Hero.Position, myHero.Position) < 750 then
                    local SpellName = Hero.ActiveSpell.Info.Name
                    --print(SpellName)
                    if SpellName == "Pounce" or Hero.AIData.Dashing then
                        if Engine:SpellReady("HK_SPELL3") then
                            Engine:CastSpell("HK_SPELL3",  Hero.Position, 1)
                            return
                        end
                    end
				end
			end
		end
    end		
end

function Vayne:EKs()
    if Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1 then
        local Range = self.ERange + myHero.CharData.BoundingRadius
        local Target = Orbwalker:GetTarget("Combo", Range)
        if Target then
            local Wbuff = Target.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt
            if Wbuff == 2 then
                if Target.Health < self:Edmg(Target) then
                    local TowerList = ObjectManager.TurretList

                    if Vayne:GetDistance(Target.Position, myHero.Position) > 450 then
                        for i, tower in pairs(TowerList) do
                            if tower.Team ~= myHero.Team and tower.IsDead == false and tower.Health > 100 then
                                if Vayne:GetDistance(Target.Position, tower.Position) <= 1000 then
                                    Engine:CastSpell("HK_SPELL3", Target.Position ,1)
                                    return  
                                end
                            end
                        end
                    end

                    if  myHero.Health <= myHero.MaxHealth / 100 * 35 then
                        Engine:CastSpell("HK_SPELL3", Target.Position ,1)
                        return
                    end
                end
            end
        end
    end
end

function Vayne:CheckCollision(startPos, endPos, r)
    local distanceP1_P2 = Vayne:GetDistance(startPos,endPos)
    local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
    local unitPos = myHero.Position
    local distanceP1_Unit = Vayne:GetDistance(startPos,unitPos)
    if distanceP1_Unit <= distanceP1_P2 then
        local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
        if Vayne:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
            return true
        end
    end
    return false
end

function Vayne:Qdodge()
    if Evade.CanEvadeInTime == false and Evade.evadePos ~= nil and self.DodgeQ.Value == 1 then
        if Engine:SpellReady("HK_SPELL1") then
            return Engine:CastSpell("HK_SPELL1", Evade.evadePos, 0)
        end
    end
end

function Vayne:TowerDmg()
    local TowerDmg = {152, 161, 170, 179, 188, 197, 206, 215, 224, 242, 233, 242, 251, 260, 269, 278}
    local GT = GameClock.Time / 60
    if GT < 0.5 then
        GT = 1
    end
    if GT > 0.5 and GT < 1 then
        GT = 2
    end
    if GT > 1 then
        GT = GT + 2
    end
    if GT > 16 then
        GT = 16
    end
    local Mins = GT - (GT % 1)
    --print("Mins: ", Mins)
    local CurrentDmg = TowerDmg[Mins]
    --print ("TowerDmg: ", CurrentDmg)
    return CurrentDmg
end




function Vayne:TowerDmgCheck(Target)
    local TowerDmg = Vayne:TowerDmg()
    local TowerSeconds = 0.833
    local MyHP = myHero.Health
    local seconds = 1
    seconds = (MyHP - TowerDmg) / (TowerDmg * TowerSeconds)
    if seconds < 1 then
        seconds = 1
    end
    --print("seconds before anything: ", seconds)
    --print(GameClock.Time / 60)
    local QDmg = self:Qdmg(Target)
    local QLevel = myHero:GetSpellSlot(0).Level
    local QSeconds = {4, 3.5, 3, 2.5, 2}
    local TotalQDmg = 0
    local TotalQs = 0
    local RoundTotalQs = 0
    if QLevel ~= 0 then
       TotalQs = (seconds / QSeconds[QLevel])
       --print("TotalQs: ", TotalQs)
       RoundTotalQs = TotalQs - (TotalQs % 1)
       --print("RoundTotalQs: ", RoundTotalQs)
       TotalQDmg = QDmg + (RoundTotalQs * QDmg)
    end
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack * (myHero.CritMod + 1)
    --print("seconds before Q's: ", seconds)
    local AttackSpeed2 = myHero.AttackSpeedMod * 0.658 
    seconds = seconds - (1 / AttackSpeed2) * RoundTotalQs
    --print("seconds after Q's: ", seconds)
    local AttackSpeed = myHero.AttackSpeedMod * 0.658 * seconds
    local RoundAttackSpeed = AttackSpeed - (AttackSpeed % 1)
    --print("RoundAttackSpeed: ", RoundAttackSpeed)
    local AADmg = Vayne:GetDamage(AttackSpeed * TotalAD, true, Target)
    local TotalDamage = TotalAD
    TotalDamage = TotalDamage + TotalQDmg + AADmg
    --print("TotalDamage: ", TotalDamage)
    if Target.Health < TotalDamage then
        return true
    end
    return false
end


function Vayne:Combo()
    if self.forceW.Value >= 1 then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                if self:GetDistance(myHero.Position, Hero.Position) <= self:GetAttackRange() then
                    if Hero.Health <= (self:Qdmg(Hero) * 1.3) then return end
                    local Wbuff = Hero.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt
                    if Wbuff >= self.forceW.Value then
                        Orbwalker.ForceTarget = Hero
                    end
                end
            end
        end
    end

	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Range = self.ERange + myHero.CharData.BoundingRadius
        local Target = Orbwalker:GetTarget("Combo", Range)
        if Target ~= nil then
				local isCC = Target.BuffData:HasBuffOfType(BuffType.Stun)
                if self:StunCheck(Target) == true and not isCC then
				    Engine:CastSpell("HK_SPELL3", Target.Position ,1)
				return
			end
		end
	end

	if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local Target = Orbwalker:GetTarget("Combo", 850)
        if Target and Orbwalker.ResetReady == 1 then
            local TowerList = ObjectManager.TurretList
            local HeroList = ObjectManager.HeroList	
            for i, tower in pairs(TowerList) do
                if tower.Team ~= myHero.Team and tower.IsDead == false and tower.Health > 100 then
                    if Vayne:GetDistance(self:QCastPos(), tower.Position) <= 750 then
                        if Vayne:TowerDmgCheck(Target) == false then
                            if Vayne:GetDistance(self:QCastPos(), tower.Position) > (Vayne:GetDistance(myHero.Position, tower.Position)) then
                                Engine:CastSpell("HK_SPELL1", nil ,1)
                                return
                            end
                            return
                        end
                    end
                end
            end
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                    if self:GetDistance(Hero.Position, self:QCastPos()) < 350 then
                        if Hero.AttackRange < 300 then
                            return
                        end
                    end
                end
            end
            if self:EnemiesInRange(self:QCastPos(), 800) > 1 then
                return
            end
            if self:GetDistance(Target.Position, self:QCastPos()) > self:GetAttackRange() then
                if ((myHero.Health / myHero.MaxHealth) * 2) > (Target.Health / Target.MaxHealth) then
                    return
                end
                if Target.Health <= Target.MaxHealth / 100 * 15 then
                    return
                end
            end
            if self:GetDistance(Target.Position, myHero.Position) > (self:GetAttackRange() + 75) then
                if self:EnemiesInRange(self:QCastPos(), 1000) >= self.GapcloseQ.Value then
                    return
                end
                if Engine:IsNotWall(self:QCastPos()) == false then
                    return
                end
                if self:GetDistance(Target.Position, self:QCastPos()) <= self:GetAttackRange() then
                    Engine:CastSpell("HK_SPELL1", nil ,1)
                    return
                end
            end
            if Orbwalker.ResetReady == 1 then
                Engine:CastSpell("HK_SPELL1", nil ,1)
                return	
            end
		end
    end
end

function Vayne:Harass()
    if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.ResetReady == 1 then
		local Target = Orbwalker:GetTarget("Combo", self:GetAttackRange())
        if Target then
            local Missiles = ObjectManager.MissileList
            for I, Missile in pairs(ObjectManager.MissileList) do
                if self:GetDistance(Missile.Position, myHero.Position) < 1000 then
                    
                    if Missile.Name == "VayneBasicAttack2" or Missile.Name == "VayneCritAttack" or Missile.Name == "VayneBasicAttack" or Missile.Name == "VayneTumbleAttack" then
                        if Missile.TargetIndex == Target.Index then
                            Engine:CastSpell("HK_SPELL1", Vayne:QCastPos1(Target) ,1)
                            return
                        end
                    end
                end
            end
        end
    end
    if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1 then
        local Range = self.ERange + myHero.CharData.BoundingRadius
        local Target = Orbwalker:GetTarget("Combo", Range)
        if Target then
            local Wbuff = Target.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt
            if Wbuff == 1 then
                Engine:CastSpell("HK_SPELL3", Target.Position ,1)
                return
            end
        end
    end
end

function Vayne:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") or Engine:IsKeyDown("HK_HARASS") or Engine:IsKeyDown("HK_LASTHIT") or Engine:IsKeyDown("HK_LANECLEAR") then
            Vayne:Qdodge()
        end
        local ExtraDmg = 0
        local CardBuff = myHero.BuffData:GetBuff("vaynetumblebonus")
        if CardBuff.Count_Alt == 1 then
            local TotalAD = myHero.BonusAttack + myHero.BaseAttack
            local QDmg = ((0.55 + 0.05 * myHero:GetSpellSlot(0).Level) * TotalAD) * 0.95
            ExtraDmg = ExtraDmg + QDmg
        end
        Orbwalker.ExtraDamage = ExtraDmg
        Vayne:Gank()
        Vayne:Stealth()
        --local Target = Orbwalker:GetTarget("Combo", 1200)
        --if Target then
            --Vayne:TowerDmgCheck(Target)
            --print("Can you dive?: ", Vayne:TowerDmgCheck(Target))
            --print(Target.BuffData:GetBuff("VayneSilveredDebuff").Count_Alt)
        --end
        if Orbwalker.Attack == 0 then
            if Engine:IsKeyDown("HK_COMBO") then
                Vayne:Combo()
                if self.ComboEKs.Value == 1 then
                    Vayne:EKs()
                end
            end
            if Engine:IsKeyDown("HK_HARASS") then
                Vayne:Harass()
            end
        end
    end
end

function Vayne:OnDraw()
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
		local ERange = self.ERange + myHero.CharData.BoundingRadius
		local ARange = myHero.AttackRange + myHero.CharData.BoundingRadius
		if ARange > ERange then
			Render:DrawCircle(myHero.Position, ERange ,100,150,255,255)
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(Vayne:QCastPos(), 40 ,100,150,255,255)
    end
end


function Vayne:OnLoad()
    if(myHero.ChampionName ~= "Vayne") then return end
	AddEvent("OnSettingsSave" , function() Vayne:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Vayne:LoadSettings() end)


	Vayne:__init()
	AddEvent("OnTick", function() Vayne:OnTick() end)	
	AddEvent("OnDraw", function() Vayne:OnDraw() end)	
end

AddEvent("OnLoad", function() Vayne:OnLoad() end)	
