Irelia = {
    EMode = {
        "myHero",
        "Target",
        "Manual",
    }
}

function Irelia:__init()

    self.ERange = 775
    self.ESpeed = 2000
    self.EWidth = 80
    self.EDelay = 0

    self.RRange = 1000
    self.RSpeed = 2000
    self.RWidth = 320
    self.RDelay = 0.4

    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.IsEvadeLoaded          = false
    self.IreliaMenu             = Menu:CreateMenu("Irelia")
    self.IreliaCombo            = self.IreliaMenu:AddSubMenu("Combo")
    self.IreliaCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo              = self.IreliaCombo:AddCheckbox("Use Q in combo", 1)
    self.UseQMinionCombo        = self.IreliaCombo:AddCheckbox("Use Q as gapclose (marks/minions) in combo", 1)
    self.UseWCombo              = self.IreliaCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo              = self.IreliaCombo:AddCheckbox("Use E in combo", 1)
    self.UseRCombo              = self.IreliaCombo:AddCheckbox("Use R in combo", 1)
    self.RHeroHP                = self.IreliaCombo:AddSlider("Min % HP for myHero to use R", 40,1,100,1)
    self.RHeroHP2               = self.IreliaCombo:AddSlider("Min % HP for target to use R", 40,1,100,1)
    --self.IreliaCombo:AddLabel("Amount of %HP that Irelia needs to have more then the enemy to R")
    --self.RIreliaHP            = self.IreliaCombo:AddSlider("Select a value, recommended 10-20", 20,1,30,1)
    self.IreliaCombo:AddLabel("Amount of enemies to R if overkill prevents it")
    self.EnemyCount             = self.IreliaCombo:AddSlider("Amount of enemies:", 3,1,5,1)
    self.RPrediction            = self.IreliaCombo:AddCheckbox("Use Different R Pred [BETA]", 0)
    ----------------------------------------------------------------------------------------------------------
    self.IreliaHarass           = self.IreliaMenu:AddSubMenu("Harass")
    self.IreliaHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass             = self.IreliaHarass:AddCheckbox("Use Q in harass", 1)
    self.UseQMinionHarass       = self.IreliaHarass:AddCheckbox("Use Q as gapclose (marks/minions) in harass", 1)
    self.UseEHarass             = self.IreliaHarass:AddCheckbox("Use E in harass", 1)
    -----------------------------------------------------------------------------------------------------------
    self.IreliaClear            = self.IreliaMenu:AddSubMenu("Clear")
    self.QDmgAdjust             = self.IreliaClear:AddSlider("% Q dmg adjustment (100 = none)", 100,1,100,1)
    self.QLastHit               = self.IreliaClear:AddCheckbox("Use Q in lasthit", 1)
    self.QStack                 = self.IreliaClear:AddCheckbox("Use Q to stack in laneclear", 1)
    self.QStackMana             = self.IreliaClear:AddSlider("X % mana to use Q in clearing", 30,1,100,1)
    self.WaitQStack             = self.IreliaClear:AddCheckbox("At max stacks wait before Q", 1)
    self.IreliaClear:AddLabel("Need to buy bork first, or manually tick on")
    self.ItemDmgCheck           = self.IreliaClear:AddCheckbox("Check BORTK Passive dmg with Q (BETA)", 0)
    self.WaitQStackSec          = self.IreliaClear:AddSlider("^X seconds passive left (recommend 3s)", 3,1,4,1)
    -----------------------------------------------------------------------------------------------------------
    self.IreliaMisc             = self.IreliaMenu:AddSubMenu("Misc")
    self.IreliaMisc:AddLabel("Manage 1E Usage:")
    self.EModes                 = self.IreliaMisc:AddCombobox("Select Mode:", Irelia.EMode)
    self.UseWBlockOnSpells      = self.IreliaMisc:AddCheckbox("Use W on Spells", 1)
    self.MaintainPassiveW       = self.IreliaMisc:AddCheckbox("Use W MaintainPassive", 1)
    self.UseDoubleQ             = self.IreliaMisc:AddCheckbox("Use Double Q in combo/harras", 1)
    self.DoubleQDist            = self.IreliaMisc:AddCheckbox("Dont use Double Q in melee range", 0)
    self.IreliaMisc:AddLabel("Last hitting minions over marked/ks enemy")
    self.StyleQ                 = self.IreliaMisc:AddCheckbox("^ Use Q with more style", 1)
    ------------------------------------------------------------------------------------------------------------
    self.IreliaDrawings         = self.IreliaMenu:AddSubMenu("Drawings")
    self.DrawQ                  = self.IreliaDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW                  = self.IreliaDrawings:AddCheckbox("Draw W", 1)
    self.DrawE                  = self.IreliaDrawings:AddCheckbox("Draw E", 1)
    self.DrawR                  = self.IreliaDrawings:AddCheckbox("Draw R", 1)
    self.DrawDmg                = self.IreliaDrawings:AddCheckbox("Draw Dmg", 1)
    self.DrawMinion             = self.IreliaDrawings:AddCheckbox("Draw Minion Q dmg", 1)
    Irelia:LoadSettings()
end

function Irelia:SaveSettings()
	SettingsManager:CreateSettings("Irelia")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use Q as gapclose with minions in combo", self.UseQMinionCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Min % HP for myHero to use R", self.RHeroHP.Value)
    SettingsManager:AddSettingsInt("Min % HP for target to use R", self.RHeroHP2.Value)
    --SettingsManager:AddSettingsInt("Select a value, recommended 10-20", self.RIreliaHP.Value)
    SettingsManager:AddSettingsInt("EnemyValue", self.EnemyCount.Value)
    SettingsManager:AddSettingsInt("Predict", self.RPrediction.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use Q as gapclose with minions in harass", self.UseQMinionHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Clear")
    SettingsManager:AddSettingsInt("DMG adjust", self.QDmgAdjust.Value)
    SettingsManager:AddSettingsInt("Use Q in lasthit", self.QLastHit.Value)
    SettingsManager:AddSettingsInt("Use Q to stack in laneclear", self.QStack.Value)
    SettingsManager:AddSettingsInt("X % mana to use Q in clearing", self.QStackMana.Value)
    SettingsManager:AddSettingsInt("WaitQ", self.WaitQStack.Value)
    SettingsManager:AddSettingsInt("WaitQSec", self.WaitQStackSec.Value)
    SettingsManager:AddSettingsInt("Items Passive dmg", self.ItemDmgCheck.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("EModes to use", self.EModes.Selected)
    SettingsManager:AddSettingsInt("Use W on Spells", self.UseWBlockOnSpells.Value)
    SettingsManager:AddSettingsInt("Use W MaintainPassive", self.MaintainPassiveW.Value)
    SettingsManager:AddSettingsInt("Use Double Q in combo/harras", self.UseDoubleQ.Value)
    SettingsManager:AddSettingsInt("Dont use Double Q in melee range", self.DoubleQDist.Value)
    SettingsManager:AddSettingsInt("Q with more style", self.StyleQ.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    SettingsManager:AddSettingsInt("Draw Dmg", self.DrawDmg.Value)
    SettingsManager:AddSettingsInt("Draw Minion Q dmg", self.DrawMinion.Value)
end

function Irelia:LoadSettings()
    SettingsManager:GetSettingsFile("Irelia")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseQMinionCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q as gapclose with minions in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    self.RHeroHP.Value = SettingsManager:GetSettingsInt("Combo", "Min % HP for myHero to use R")
    self.RHeroHP2.Value = SettingsManager:GetSettingsInt("Combo", "Min % HP for target to use R")
    --self.RIreliaHP.Value = SettingsManager:GetSettingsInt("Combo", "Select a value, recommended 10-20")
    self.EnemyCount.Value = SettingsManager:GetSettingsInt("Combo", "EnemyValue")
    self.RPrediction.Value = SettingsManager:GetSettingsInt("Combo", "Predict")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseQMinionHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q as gapclose with minions in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.QDmgAdjust.Value = SettingsManager:GetSettingsInt("Clear", "DMG adjust")
    self.QLastHit.Value = SettingsManager:GetSettingsInt("Clear", "Use Q in lasthit")
    self.QStack.Value = SettingsManager:GetSettingsInt("Clear", "Use Q to stack in laneclear")
    self.QStackMana.Value = SettingsManager:GetSettingsInt("Clear", "X % mana to use Q in clearing")
    self.WaitQStack.Value = SettingsManager:GetSettingsInt("Clear", "WaitQ")
    self.WaitQStackSec.Value = SettingsManager:GetSettingsInt("Clear", "WaitQSec")
    self.ItemDmgCheck.Value = SettingsManager:GetSettingsInt("Clear", "Items Passive dmg")
    -------------------------------------------
    self.EModes.Selected = SettingsManager:GetSettingsInt("Misc", "EModes to use")
    self.UseWBlockOnSpells.Value = SettingsManager:GetSettingsInt("Misc", "Use W on Spells")
    self.MaintainPassiveW.Value = SettingsManager:GetSettingsInt("Misc", "Use W MaintainPassive")
    self.UseDoubleQ.Value = SettingsManager:GetSettingsInt("Misc", "Use Double Q in combo/harras")
    self.DoubleQDist.Value = SettingsManager:GetSettingsInt("Misc", "Dont use Double Q in melee range")
    self.StyleQ.Value = SettingsManager:GetSettingsInt("Misc", "Q with more style")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Draw R")
    self.DrawDmg.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Dmg")
    self.DrawMinion.Value = SettingsManager:GetSettingsInt("Drawings", "Draw Minion Q dmg")

    if Evade ~= nil then
        self.IsEvadeLoaded = true
    else
        print('enable evade for W usage')
    end
end

function Irelia:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Irelia:GetECastPos(CastPos)
	local PlayerPos 	= self:GetFirstE()
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 300
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Irelia:GetMinionsAround()
    local Count = 0 --FeelsBadMan
	local MinionList = ObjectManager.MinionList
	for i, Minion in pairs(MinionList) do	
		if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if Irelia:GetDistance(myHero.Position , Minion.Position) < 600 then
				return Minion
			end
		end
    end
    return false
end

function Irelia:EnemiesInRange(Position, Range)
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

function Irelia:MinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i,Minion in pairs(MinionList) do
        if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if self:GetDistance(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Irelia:AllyMinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i,Minion in pairs(MinionList) do
        if Minion.Team == myHero.Team and Minion.IsTargetable then
			if self:GetDistance(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function Irelia:CheckCollision(startPos, endPos, r)
    local distanceP1_P2 = Irelia:GetDistance(startPos,endPos)
    local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
    local unitPos = myHero.Position
    local distanceP1_Unit = Irelia:GetDistance(startPos,unitPos)
    if distanceP1_Unit <= distanceP1_P2 then
        local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
        if Irelia:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
            return true
        end
    end
    return false
end

function Irelia:CheckCollisionEnemy(startPos, endPos, r)
    local herolist = ObjectManager.HeroList
    for i, Hero in pairs(herolist) do
        if self:GetDistance(myHero.Position, Hero.Position) <= 1200 then
            local distanceP1_P2 = Irelia:GetDistance(startPos,endPos)
            local vec = Vector3.new((endPos.x - startPos.x)/distanceP1_P2,0,(endPos.z - startPos.z)/distanceP1_P2)
            local unitPos = Hero.Position
            local distanceP1_Unit = Irelia:GetDistance(startPos,unitPos)
            if distanceP1_Unit <= distanceP1_P2 then
                local checkPos = Vector3.new(startPos.x + vec.x*distanceP1_Unit,0,startPos.z + vec.z*distanceP1_Unit)
                if Irelia:GetDistance(unitPos,checkPos) < r + myHero.CharData.BoundingRadius then
                    return true
                end
            end
        end
    end
    return false
end

local function GetMyLevel()
    local totalLevel = myHero:GetSpellSlot(0).Level + myHero:GetSpellSlot(1).Level + myHero:GetSpellSlot(2).Level + myHero:GetSpellSlot(3).Level
    return totalLevel
end

function Irelia:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Irelia:MaxStacks()
    local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
    if passiveStacks.Count_Int == 4 then
        return true
    end
    return false
end

function Irelia:AttackSpeedlvl()
    local lvl = GetMyLevel()
    local Speed = {0, 0.018, 0.0369, 0.0566, 0.0773, 0.0988, 0.1211, 0.1444, 0.1685, 0.1935, 0.2194, 0.2461, 0.2738, 0.3023, 0.3316, 0.3619, 0.393, 0.425}
    local CurrentSpeed = Speed[lvl]
    local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks").Count_Int
    local PassiveLevel = {0.08, 0.08, 0.08, 0.08, 0.08, 0.08, 0.12, 0.12, 0.12 ,0.12, 0.12, 0.12, 0.16, 0.16, 0.16, 0.16, 0.16, 0.16}
    local PassiveSpeed = (PassiveLevel[lvl]) * passiveStacks
    local totalSpeed = CurrentSpeed + PassiveSpeed
    if lvl == 0 then
        totalSpeed = 0
    end
    if lvl > 18 then --urf
        totalSpeed = 0.5
    end
    return totalSpeed
end

function Irelia:ItemDmg(Target)
    local CampNames = {
        "SRU_Dragon_Fire6.2.1",
    }
    local ItemDmg = 0
    local AASpeed = myHero.AttackSpeedMod - self:AttackSpeedlvl() - 0.1
    local AADmg = myHero.BonusAttack
    if self.ItemDmgCheck.Value == 1 then
        if AASpeed > 1.24 and AADmg > 45 then
            local Bork = Target.Health * 0.09 - 5
            if Bork >= 60 then
                ItemDmg = ItemDmg + 60
            end
            if Bork < 60 then
                ItemDmg = ItemDmg + Bork
            end
            --[[if Target.Name == "SRU_Dragon_Fire6.2.1" or Target.Name == "SRU_Dragon_Air6.1.1" or Target.Name == "SRU_Dragon_Water6.3.1" or Target.Name == "SRU_Dragon_Earth6.4.1" or Target.Name == "SRU_Dragon_Elder6.5.1" or Target.Name == "SRU_Baron12.1.1" or Target.Name == "SRU_RiftHerald17.1.1" then
                ItemDmg = 0
            end]]
            --print("Bork Found!")
        end
    end
    --print(AADmg)
    return ItemDmg
end



function Irelia:AAdmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local AttackSpeed = myHero.AttackSpeedMod * 0.656
    local PassiveDmg = Irelia:GetDamage(12 + 3 * GetMyLevel() + myHero.BonusAttack * 0.25, false, Target) * 4 * AttackSpeed
    local AADmg = Irelia:GetDamage(TotalAD, true, Target) * 4 * AttackSpeed
    local FinalFullDmg = AADmg
    if self:MaxStacks() then
        FinalFullDmg = FinalFullDmg + PassiveDmg
    end
    return FinalFullDmg
end

function Irelia:Qdmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local PassiveDmg = Irelia:GetDamage(12 + 3 * GetMyLevel() + myHero.BonusAttack * 0.25, false, Target)
    local QDmg = Irelia:GetDamage(-15 + 20 * myHero:GetSpellSlot(0).Level + 0.6 * TotalAD + Irelia:ItemDmg(Target), true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + QDmg
    end
    if self:MaxStacks() then
        FinalFullDmg = FinalFullDmg + PassiveDmg
    end
    return FinalFullDmg
end

function Irelia:Wdmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local WDmg = Irelia:GetDamage(-5 + 15 * myHero:GetSpellSlot(1).Level + 0.5 * TotalAD, true, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL2") then
        FinalFullDmg = FinalFullDmg + WDmg
    end
    return FinalFullDmg
end

function Irelia:Edmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local EDmg = Irelia:GetDamage(35 + 40 * myHero:GetSpellSlot(2).Level + 0.7 * myHero.AbilityPower, false, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL3") then
        FinalFullDmg = FinalFullDmg + EDmg
    end
    if Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + self:Qdmg(Target)
    end
    return FinalFullDmg
end

function Irelia:Rdmg(Target)
    local TotalAD = myHero.BonusAttack + myHero.BaseAttack
    local RDmg = Irelia:GetDamage(0 + 125 * myHero:GetSpellSlot(3).Level + 0.7 * myHero.AbilityPower, false, Target)
    local FinalFullDmg = 0
    if Engine:SpellReady("HK_SPELL4") then
        FinalFullDmg = FinalFullDmg + RDmg
    end
    if Engine:SpellReady("HK_SPELL1") then
        FinalFullDmg = FinalFullDmg + self:Qdmg(Target)
    end
    return FinalFullDmg
end

function Irelia:FullComboDMG(Target)
    return self:Qdmg(Target) + self:Wdmg(Target) + self:Edmg(Target) + self:Rdmg(Target) + self:AAdmg(Target)
end

function Irelia:DrawDmg()
    local Heros = ObjectManager.HeroList
    for _, enemy in ipairs(Heros) do
        if enemy.Team ~= myHero.team then
            local FullDmg = self:FullComboDMG(enemy)
            self:DrawDmgHealthBar(enemy, FullDmg)
        end
    end
end

--[[function Irelia:DrawDmgHealthBar(target, damage)
    local drawHelper = {xOffset = -45, yOffset = -24, barLength = 104}
    
    local barPos = target.Position
    local barPosOffset = Vector3.new(barPos.x + drawHelper.xOffset, barPos.y + drawHelper.yOffset)
    local fullBar = drawHelper.barLength * (target.Health / target.MaxHealth)
    local damageBar = drawHelper.barLength*math.min(1.0, (damage / target.MaxHealth))
    
    local barEndPos = Vector3.new(barPosOffset.x + ((damageBar > fullBar) and fullBar or damageBar), barPosOffset.y)

    local ExtremOffset = Vector3.new(barPosOffset.x + fullBar, barPosOffset.y)
    local EndPosition = Vector3.new(ExtremOffset.x - damageBar, barPosOffset.y)
    
    local size = math.abs(EndPosition.x - ExtremOffset.x)
    if Render:World2Screen(target.Position, Vector3.new()) then
        if damageBar < fullBar then
            local finalRect = Vector4.new(EndPosition.x, EndPosition.y, size , 10)
            Render:DrawFilledBox(finalRect, 255,0,255,200)
        else
            local barEndPos = D3DXVector3(barPosOffset.x +  fullBar , barPosOffset.y)
            local finalRect = Vector4.new(barPosOffset.x, barPosOffset.y, barEndPos.x - barPosOffset.x, 10)
            Render:DrawFilledBox(finalRect, 255,0,255,200)
        end
    end
   
end]]

function Irelia:DrawMinion2(target)
    if myHero.IsDead == true then return end
    if self.DrawMinion.Value == 1 and self:GetDistance(target.Position, myHero.Position) <= 1600 then
        local outvec = Vector3.new()
        if Render:World2Screen(myHero.Position, outvec) then
            Render:DrawCircle(target.Position, 40,255,0,255,255)
        end
    end
end

function Irelia:BlockW()
    if self.IsEvadeLoaded then
        if Evade:CantEvade() == true then
            local HeroList = ObjectManager.HeroList
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and self:GetDistance(myHero.Position, Hero.Position) <= 1400 then
                    if self.UseWBlockOnSpells.Value == 1 then
                        local Missiles = ObjectManager.MissileList
                        for I, Missile in pairs(Missiles) do
                            if Missile.Team ~= myHero.Team then 
                                local Info = Evade.Spells[Missile.Name]
                                if Info ~= nil and Info.Type == 0 then
                                    if Info.CC == 1 or Info.Dmg == 0 then
                                        if Irelia:CheckCollision(Missile.MissileStartPos, Missile.MissileEndPos, Info.Radius + 70) then
                                            --if info.Speed * Irelia:GetDistance(Missile.MissilveStartPos, myHero.Position)
                                            if Engine:SpellReady("HK_SPELL2") then
                                                Engine:CastSpell("HK_SPELL2",  Hero.Position)
                                            end
                                            if Engine:SpellReady("HK_SPELL2") then
                                                if myHero.BuffData:HasBuffOfType(BuffType.Stun) == false or myHero.BuffData:HasBuffOfType(BuffType.Snare) == false then
                                                    Engine:CastSpell("HK_SPELL2",  Hero.Position)
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
        end
    end
end

function Irelia:ChaseQ()
    if Engine:SpellReady("HK_SPELL1")  then
        local HeroList = ObjectManager.HeroList
        local target = Orbwalker:GetTarget("Combo", 1100)
        if target then
            for i, Hero in pairs(HeroList) do
                if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable and self:GetDistance(myHero.Position, Hero.Position) <= 600 then
                    local hasMark = Hero.BuffData:GetBuff("ireliamark")
                    if self:GetDistance(myHero.Position, Hero.Position) >= 100 and Hero ~= target then
                        if hasMark.Count_Alt > 0 and self:GetDistance(myHero.Position, target.Position) <= 1100 then
                            if Irelia:GetDistance(myHero.Position, target.Position) >= Irelia:GetDistance(Hero.Position, target.Position) or Irelia:GetDistance(Hero.Position, target.Position) <= 500 then
                                Engine:CastSpell("HK_SPELL1", Hero.Position, 1)
                                return
                            end 
                        end
                    end
                    if Hero.Health < self:Qdmg(Hero) then
                        Engine:CastSpell("HK_SPELL1", Hero.Position, 1)
                        return
                    end
                end
            end
        end
    end
end

function Irelia:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Irelia:MaintainPassiveM(minion)
    local target = Orbwalker:GetTarget("Combo", 1600)
    if minion then
        if Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, minion.Position) <= 600 then
            local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
            if passiveStacks.Valid then
                if GameClock.Time + self.WaitQStackSec.Value >= passiveStacks.EndTime and myHero.AIData.Dashing == false then
                    Engine:CastSpell("HK_SPELL1", minion.Position, 0)
                    return
                end
            end
        end
    end
    if target then
        if self.MaintainPassiveW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self:GetDistance(myHero.Position, target.Position) <= 800 and self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
            local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
            if passiveStacks.Valid then
                if GameClock.Time + 2 >= passiveStacks.EndTime then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end
end

function Irelia:MaintainPassive(target)
    if target then
        local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
        --[[if Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and  self:GetDistance(myHero.Position, target.Position) <= 600 and self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
            if passiveStacks.Valid then
                if GameClock.Time + 1 >= passiveStacks.EndTime then
                    Engine:CastSpell("HK_SPELL1", target.Position)
                end
            end
        end]]
        if self.MaintainPassiveW.Value == 1 and Engine:SpellReady("HK_SPELL2") and self:GetDistance(myHero.Position, target.Position) <= 800 and self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
            if passiveStacks.Valid  then
                if GameClock.Time + 2 >= passiveStacks.EndTime then
                    Engine:CastSpell("HK_SPELL2", target.Position, 1)
                    return
                end
            end
        end
    end
end


function Irelia:LastHitQ()
    if Engine:SpellReady("HK_SPELL1") and myHero.AIData.Dashing == false then
        local MinionList = ObjectManager.MinionList
        local TowerList = ObjectManager.TurretList
        local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
        if myHero.Mana <= myHero.MaxMana * self.QStackMana.Value / 100 then return end
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.IsTargetable and Minion.MaxHealth > 100 then
                if Irelia:GetDistance(myHero.Position, Minion.Position) <= 600 and Irelia:MinionsInRange(Minion.Position, Minion.CharData.BoundingRadius * 1.5) == 1 and Irelia:EnemiesInRange(Minion.Position, myHero.CharData.BoundingRadius * 1.5) == 0 then
                    
                    for i, tower in pairs(TowerList) do
                        if tower.Team ~= myHero.Team and tower.IsDead == false and tower.Health > 100 then
                            if Irelia:GetDistance(myHero.Position, tower.Position) <= 1500 then
                                if Irelia:GetDistance(Minion.Position, tower.Position) <= 900 and Irelia:AllyMinionsInRange(tower.Position, 800) == 0 then
                                    return
                                end 
                            end
                        end
                    end

                    local QDmg = self:Qdmg(Minion)
                    if Minion.Team == 100 or Minion.Team == 200 then
                        QDmg = (QDmg + 35 + 20 * myHero:GetSpellSlot(0).Level - 1) * (self.QDmgAdjust.Value / 100)
                    end
                    if Minion.Name == "SRU_Dragon_Fire6.2.1" or Minion.Name == "SRU_Dragon_Air6.1.1" or Minion.Name == "SRU_Dragon_Water6.3.1" or Minion.Name == "SRU_Dragon_Earth6.4.1" or Minion.Name == "SRU_Dragon_Elder6.5.1" or Minion.Name == "SRU_Baron12.1.1" or Minion.Name == "SRU_RiftHerald17.1.1" then
                        QDmg = QDmg * 0.5
                    end
                    --print(Minion.BuffData:ShowAllBuffs())
                    if self.WaitQStack.Value == 1 then
                        if Minion.Health <= QDmg and target ~= nil or Minion.Health <= QDmg and passiveStacks.Count_Int <= 4 then
                            Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                            return
                            --print(QDmg)
                        else
                            if Minion.Health <= QDmg then
                                self:MaintainPassiveM(Minion)
                                return
                            end
                        end
                    else
                        if Minion.Health <= QDmg and target ~= nil or Minion.Health <= QDmg and passiveStacks.Count_Int <= 4 then
                            Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                            return
                            --print(QDmg)
                        else
                            if Minion.Health <= QDmg then
                                self:MaintainPassiveM(Minion)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

function Irelia:LastHitQCombo()
    local target = Orbwalker:GetTarget("Combo", 2000)
    if Engine:SpellReady("HK_SPELL1") and myHero.AIData.Dashing == false and target then
        local MinionList = ObjectManager.MinionList
        local passiveStacks = myHero.BuffData:GetBuff("ireliapassivestacks")
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.IsTargetable and Minion.MaxHealth > 100 then
                if Irelia:MinionsInRange(Minion.Position, Minion.CharData.BoundingRadius * 1.5) == 1 and Irelia:EnemiesInRange(Minion.Position, myHero.CharData.BoundingRadius * 1.5) == 0 then
                    if Irelia:GetDistance(myHero.Position, target.Position) >= Irelia:GetDistance(Minion.Position, target.Position) or Irelia:GetDistance(Minion.Position, target.Position) <= 470 then
                        if Irelia:GetDistance(myHero.Position, Minion.Position) <= 600 then

                            local QDmg = self:Qdmg(Minion)
                            if Minion.Team == 100 or Minion.Team == 200 then
                                QDmg = (QDmg + 35 + 20 * myHero:GetSpellSlot(0).Level - 1) * (self.QDmgAdjust.Value / 100)
                            end
                            if Minion.Name == "SRU_Dragon_Fire6.2.1" or Minion.Name == "SRU_Dragon_Air6.1.1" or Minion.Name == "SRU_Dragon_Water6.3.1" or Minion.Name == "SRU_Dragon_Earth6.4.1" or Minion.Name == "SRU_Dragon_Elder6.5.1" or Minion.Name == "SRU_Baron12.1.1" or Minion.Name == "SRU_RiftHerald17.1.1" then
                                QDmg = QDmg * 0.5
                            end

                            if self.WaitQStack.Value == 1 then
                                if Minion.Health <= QDmg and target ~= nil or Minion.Health <= QDmg and passiveStacks.Count_Int <= 3 then
                                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                                    return
                                    --print(QDmg)
                                else
                                    if Minion.Health <= QDmg then
                                        self:MaintainPassiveM(Minion)
                                        return
                                    end
                                end
                            else
                                if Minion.Health <= QDmg and target ~= nil or Minion.Health <= QDmg and passiveStacks.Count_Int <= 4 then
                                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                                    return
                                    --print(QDmg)
                                else
                                    if Minion.Health <= QDmg then
                                        self:MaintainPassiveM(Minion)
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

function Irelia:GetFirstE()
    local MinionList = ObjectManager.MinionList
    for i, minion in pairs(MinionList) do
        if self:GetDistance(myHero.Position, minion.Position) <= 3000 then
            if minion.Name == "Blade" then
                return minion.Position
            end
        end
    end
    return false
end

function Irelia:GetE2CastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= 40
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Irelia:GetE1CastPos(CastPos)
	local PlayerPos 	= myHero.Position
	local TargetPos 	= CastPos
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -120
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Irelia:RUsage(target)
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local hasMark = target.BuffData:GetBuff("ireliamark")
        local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:Edmg(target) + self:Rdmg(target) + self:AAdmg(target)
        local OverCombo = (self:Qdmg(target) + self:Edmg(target) + self:AAdmg(target)) * 0.75
        local hp = target.Health
        if self:GetDistance(myHero.Position, target.Position) <= 700 then
            if  myHero.Health >= myHero.MaxHealth / 100 * self.RHeroHP.Value and hasMark.Count_Alt == 0 then
                if target.Health >= target.MaxHealth / 100 * self.RHeroHP2.Value then
                    if self.RPrediction.Value == 0 then
                        if ComboDmg > hp and OverCombo < hp then
                            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                            if PredPos ~= nil then
                                Engine:CastSpell("HK_SPELL4", PredPos, 1)
                                return
                            end
                        else
                            if ComboDmg > hp then
                                if self:EnemiesInRange(target.Position, 450) >= self.EnemyCount.Value then
                                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
                                    if PredPos ~= nil then
                                        Engine:CastSpell("HK_SPELL4", PredPos, 1)
                                        return
                                    end
                                end
                            end
                        end
                    else
                        local CastPos = target.Position
                        if ComboDmg > hp and OverCombo < hp then
                            Engine:CastSpell("HK_SPELL4", CastPos, 1)
                            return
                        else
                            if ComboDmg > hp then
                                if self:EnemiesInRange(target.Position, 450) >= self.EnemyCount.Value then
                                    Engine:CastSpell("HK_SPELL4", CastPos, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Irelia:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end

function Irelia:Combo()
    local target = Orbwalker:GetTarget("Combo", 900)
    if target then

        if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
            self:RUsage(target)
        else
            if Orbwalker.ResetReady == 1 then
                self:RUsage(target)
            end
        end

        self:MaintainPassive(target)

        if self.UseQMinionCombo.Value == 1 then
            if self.StyleQ.Value == 1 then
                self:LastHitQCombo()
                self:ChaseQ()
            else 
                self:ChaseQ()
                self:LastHitQCombo()
            end
        end

        local hasMark = target.BuffData:GetBuff("ireliamark")
        if self.UseQCombo.Value == 1 and myHero.AIData.Dashing == false and hasMark.Count_Alt > 0 and self:GetDistance(myHero.Position, target.Position) <= 600 then
            if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
                if Engine:SpellReady("HK_SPELL1") then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            else
                if Orbwalker.ResetReady == 1 then
                    if Engine:SpellReady("HK_SPELL1") then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                end
            end
        end

        --[[if self:GetDistance(myHero.Position, target.Position) > 100 then
            if Engine:SpellReady("HK_SPELL1") then
                Engine:CastSpell("HK_SPELL1", target.Position, 1)
                return
            end
        else
            if GameClock.Time + 1 >= hasMark.EndTime then
                if Engine:SpellReady("HK_SPELL1") then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            end
        end ]]
        if self.DoubleQDist.Value == 0 then
            if self.UseQCombo.Value == 1 and self.UseDoubleQ.Value == 1 and myHero.AIData.Dashing == false  and  Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and self:GetDistance(myHero.Position, target.Position) <= 600 then
                if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
                    local hp = target.Health
                    local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                    if ComboDmg > hp then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                else
                    if Orbwalker.ResetReady == 1 then
                        local hp = target.Health
                        local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                        if ComboDmg > hp then
                            Engine:CastSpell("HK_SPELL1", target.Position, 1)
                            return
                        end
                    end
                end
            end
        else
            if self.UseQCombo.Value == 1 and self.UseDoubleQ.Value == 1 and myHero.AIData.Dashing == false  and  Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and self:GetDistance(myHero.Position, target.Position) <= 600 then
                if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() + 50 then
                    local hp = target.Health
                    local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                    if ComboDmg > hp then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                end
            end
        end

        if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            if Irelia:MaxStacks() ~= true and myHero.AIData.Dashing == false and Orbwalker.ResetReady == 1 and self:GetDistance(myHero.Position, target.Position) <= Irelia:GetAttackRange() then
                Engine:CastSpell("HK_SPELL2", target.Position, 1)
                return
            end
        end        

        if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if self:GetDistance(myHero.Position, target.Position) <= 750 then
                if myHero.BuffData:GetBuff("IreliaE").Valid and hasMark.Count_Alt == 0 then
                    local firstE = self:GetFirstE()
                    if firstE ~= false then
                        local StartPos 		= self:GetFirstE()
                        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                        if PredPos ~= nil then
                            PredPos = self:GetECastPos(PredPos)
                            if Irelia:CheckCollisionEnemy(firstE, PredPos, 70) then
                                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                                return
                            end
                        end
                    end
                end
            end
            if self:GetDistance(myHero.Position, target.Position) <= 700 then
                if  hasMark.Count_Alt == 0 then
                    local castPos = self:GetE1CastPos(target.Position)
                    if castPos ~= nil and myHero.BuffData:GetBuff("IreliaE").Valid == false and self.EModes.Selected == 0 then
                        Engine:CastSpell("HK_SPELL3", myHero.Position, 1)
                        return
                    end
                    if castPos ~= nil and myHero.BuffData:GetBuff("IreliaE").Valid == false and self.EModes.Selected == 1 then
                        Engine:CastSpell("HK_SPELL3", target.Position, 1)
                        return
                    end
                end
            end
        end
        --print(myHero.AttackSpeedMod)
        --print(Irelia:ItemDmg())
    end
end

function Irelia:Harass() 
    local target = Orbwalker:GetTarget("Harass", 900)
    if target then
        self:MaintainPassive(target)

        if self.UseQMinionHarass.Value == 1 then
            if self.StyleQ.Value == 1 then
                self:LastHitQCombo()
                self:ChaseQ()
            else 
                self:ChaseQ()
                self:LastHitQCombo()
            end
        end

        local hasMark = target.BuffData:GetBuff("ireliamark")
        if self.UseQHarass.Value == 1 and myHero.AIData.Dashing == false and hasMark.Count_Alt > 0 and self:GetDistance(myHero.Position, target.Position) <= 600 then
            if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
                if Engine:SpellReady("HK_SPELL1") then
                    Engine:CastSpell("HK_SPELL1", target.Position, 1)
                    return
                end
            else
                if Orbwalker.ResetReady == 1 then
                    if Engine:SpellReady("HK_SPELL1") then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                end
            end
        end

        if self.DoubleQDist.Value == 0 then
            if self.UseQHarass.Value == 1 and self.UseDoubleQ.Value == 1 and myHero.AIData.Dashing == false  and  Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and self:GetDistance(myHero.Position, target.Position) <= 600 then
                if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() then
                    local hp = target.Health
                    local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                    if ComboDmg > hp then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                else
                    if Orbwalker.ResetReady == 1 then
                        local hp = target.Health
                        local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                        if ComboDmg > hp then
                            Engine:CastSpell("HK_SPELL1", target.Position, 1)
                            return
                        end
                    end
                end
            end
        else
            if self.UseQHarass.Value == 1 and self.UseDoubleQ.Value == 1 and myHero.AIData.Dashing == false  and  Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL3") and not Engine:SpellReady("HK_SPELL4") and self:GetDistance(myHero.Position, target.Position) <= 600 then
                if self:GetDistance(myHero.Position, target.Position) > Irelia:GetAttackRange() + 50 then
                    local hp = target.Health
                    local ComboDmg = self:Qdmg(target) + self:Wdmg(target) + self:AAdmg(target)
                    if ComboDmg > hp then
                        Engine:CastSpell("HK_SPELL1", target.Position, 1)
                        return
                    end
                end
            end
        end

        if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            if self:GetDistance(myHero.Position, target.Position) <= 750 then
                if myHero.BuffData:GetBuff("IreliaE").Valid and hasMark.Count_Alt == 0 then
                    local firstE = self:GetFirstE()
                    if firstE ~= false then
                        local StartPos 		= self:GetFirstE()
                        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                        if PredPos ~= nil then
                            PredPos = self:GetECastPos(PredPos)
                            if Irelia:CheckCollisionEnemy(firstE, PredPos, 70) then
                                Engine:CastSpell("HK_SPELL3", PredPos, 1)
                                return
                            end
                        end
                    end
                end
            end
            if self:GetDistance(myHero.Position, target.Position) <= 700 then
                if  hasMark.Count_Alt == 0 then
                    local castPos = self:GetE1CastPos(target.Position)
                    if castPos ~= nil and myHero.BuffData:GetBuff("IreliaE").Valid == false and self.EModes.Selected == 0 then
                        Engine:CastSpell("HK_SPELL3", myHero.Position, 1)
                        return
                    end
                    if castPos ~= nil and myHero.BuffData:GetBuff("IreliaE").Valid == false and self.EModes.Selected == 1 then
                        Engine:CastSpell("HK_SPELL3", target.Position, 1)
                        return
                    end
                end
            end
        end
    end
end

function Irelia:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        --myHero.BuffData:ShowAllBuffs()
        Irelia:BlockW()
        if Engine:IsKeyDown("HK_COMBO") then
            Irelia:Combo()
            --Irelia:GetAllItemNames()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Irelia:Harass()
        end
        if Engine:IsKeyDown("HK_LASTHIT") then
            if self.QLastHit.Value == 1 then
            Irelia:LastHitQ()
            end
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            if self.QStack.Value == 1 then
                Irelia:LastHitQ()
            end
        end
    end
end

function Irelia:DrawKill(target)
    if self:FullComboDMG(target) > target.Health then
        local KillCombo = "KILLABLE"
        local vecOut = Vector3.new()
        if Render:World2Screen(target.Position, vecOut) then
            Render:DrawString(KillCombo, vecOut.x - 40 , vecOut.y - 175 , 92, 255, 5, 255)
        end
    end
end

function Irelia:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 600,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 825,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 850,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL4') and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, 1000,255,0,255,255)
        end
        --[[if self.DrawDmgHealth.Value == 1 then
            self:DrawDmg()
        end]]
        local Heros = ObjectManager.HeroList
        for I, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team then
                if self.DrawDmg.Value == 1 then
                    if Hero.IsTargetable then
                        self:DrawKill(Hero)
                    end
                end
            end
        end
        if self.DrawMinion.Value == 1 then
            local MinionList = ObjectManager.MinionList
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.IsDead == false and Minion.MaxHealth > 100 then
                    if Irelia:GetDistance(myHero.Position, Minion.Position) <= 1600 then
                        local QDmg = self:Qdmg(Minion)
                        if Minion.Team == 200 then
                            QDmg = (QDmg + 35 + 20 * myHero:GetSpellSlot(0).Level - 1) * (self.QDmgAdjust.Value / 100)
                        end
                        if Minion.Name == "SRU_Dragon_Fire6.2.1" or Minion.Name == "SRU_Dragon_Air6.1.1" or Minion.Name == "SRU_Dragon_Water6.3.1" or Minion.Name == "SRU_Dragon_Earth6.4.1" or Minion.Name == "SRU_Dragon_Elder6.5.1" or Minion.Name == "SRU_Baron12.1.1" or Minion.Name == "SRU_RiftHerald17.1.1" then
                            QDmg = QDmg * 0.5
                        end
                        if Minion.Health < QDmg then
                            self:DrawMinion2(Minion)
                        end
                    end
                end
            end
        end
    end
end

function Irelia:OnLoad()
    if myHero.ChampionName ~= "Irelia" then return end
    AddEvent("OnSettingsSave" , function() Irelia:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Irelia:LoadSettings() end)
    Irelia:__init()
    AddEvent("OnTick", function() Irelia:OnTick() end)
    AddEvent("OnDraw", function() Irelia:OnDraw() end)
end

AddEvent("OnLoad", function() Irelia:OnLoad() end)