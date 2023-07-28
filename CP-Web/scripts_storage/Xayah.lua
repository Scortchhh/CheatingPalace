Xayah = {}

function Xayah:__init()
    self.QRange = 1100
    self.WRange = 600
    self.ERange = 1100
    self.RRange = 1100
    
    self.QSpeed = 2075
    self.ESpeed = 4000

    self.QWidth = 100

    self.QDelay = 0.25
    
	self.KeyNames = {}
	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"
	
	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
	self.KeyNames[11]		= "HK_ITEM6"

	self.GaleforceRange = 750

    self.Feathers = {}
    self.HeroesAndFeathers = {}

    self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Xayah")
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.UseQCombo = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.UseWCombo = self.ComboMenu:AddCheckbox("UseW", 1)

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.UseQHarass = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.UseQHarassMana = self.HarassMenu:AddSlider("Use Q % Mana", 30, 0, 100, 1)

    self.KSMenu = self.ChampionMenu:AddSubMenu("KS")
    self.UseKSQ = self.KSMenu:AddCheckbox("UseQ", 1)
    self.UseKSR = self.KSMenu:AddCheckbox("UseR", 1)
    self.UseKSE = self.KSMenu:AddCheckbox("UseE", 1)
    self.UseGaleforce = self.KSMenu:AddCheckbox("Use Galeforce", 1)
    self.UseGaleforceMaxEnemies = self.KSMenu:AddSlider("Galeforce x Enemies", 3, 1, 5, 1)

    self.MiscMenu = self.ChampionMenu:AddSubMenu("Misc")
    self.UseAutoStun = self.MiscMenu:AddCheckbox("Use Auto Stun when enemy is near you", 1)
    self.UseEAtXFeathers = self.MiscMenu:AddSlider("Use E when x Feathers would hit", 3, 1, 15, 1)
    self.UseENoFeatherAmmo = self.MiscMenu:AddCheckbox("Use E when no Feather ammo", 0)

    self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1)
    self.DrawEspFeathers = self.DrawMenu:AddCheckbox("Draw ESP Feathers", 1)
    self.FeatherAbleDrawingXAxis = self.DrawMenu:AddSlider("X Axis Feather Info", 500,100,1000,1)
	self.FeatherAbleDrawingYAxis = self.DrawMenu:AddSlider("Y Axis Feather Info", 100,100,1000,1)
    self.DrawKillableInfo = self.DrawMenu:AddCheckbox("Draw Killable info", 1)
    self.DrawKillBoxes = self.DrawMenu:AddCheckbox("Draw KillHealthbars", 1)

    self:LoadSettings()
end

function Xayah:SaveSettings() 

    SettingsManager:CreateSettings("XayahZamo")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("UseQHarassMana", self.UseQHarassMana.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("KS")
    SettingsManager:AddSettingsInt("UseQ", self.UseKSQ.Value)
    SettingsManager:AddSettingsInt("UseE", self.UseKSE.Value)
    SettingsManager:AddSettingsInt("UseR", self.UseKSR.Value)
    SettingsManager:AddSettingsInt("UseGaleforce", self.UseGaleforce.Value)
    SettingsManager:AddSettingsInt("UseGaleforceMaxEnemies", self.UseGaleforceMaxEnemies.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("UseAutoStun", self.UseAutoStun.Value)
    SettingsManager:AddSettingsInt("UseEAtXFeathers", self.UseEAtXFeathers.Value)
    SettingsManager:AddSettingsInt("UseENoFeatherAmmo", self.UseENoFeatherAmmo.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    SettingsManager:AddSettingsInt("DrawEspFeathers", self.DrawEspFeathers.Value)
    SettingsManager:AddSettingsInt("XAxisFeatherInfo", self.FeatherAbleDrawingXAxis.Value)
    SettingsManager:AddSettingsInt("YAxisFeatherInfo", self.FeatherAbleDrawingYAxis.Value)
    SettingsManager:AddSettingsInt("DrawKillableInfo", self.DrawKillableInfo.Value)
    SettingsManager:AddSettingsInt("DrawKillBoxes", self.DrawKillBoxes.Value)
    --------------------------------------------
end

function Xayah:LoadSettings()

    SettingsManager:GetSettingsFile("XayahZamo")
    --------------------------------------------
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseQ")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "UseW")
    --------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "UseQ")
    self.UseQHarassMana.Value = SettingsManager:GetSettingsInt("Harass","UseQHarassMana")

    if self.UseQHarassMana.Value == 0 then
        self.UseQHarassMana.Value = 30
    end

    --------------------------------------------
    self.UseKSQ.Value = SettingsManager:GetSettingsInt("KS", "UseQ")
    self.UseKSE.Value = SettingsManager:GetSettingsInt("KS", "UseE")
    self.UseKSR.Value = SettingsManager:GetSettingsInt("KS", "UseR")
    self.UseGaleforce.Value = SettingsManager:GetSettingsInt("KS", "UseGaleforce")
    self.UseGaleforceMaxEnemies.Value = SettingsManager:GetSettingsInt("KS", "UseGaleforceMaxEnemies")

    if self.UseGaleforceMaxEnemies.Value == 0 then
        self.UseGaleforceMaxEnemies.Value = 3
    end

    --------------------------------------------
    self.UseAutoStun.Value = SettingsManager:GetSettingsInt("Misc", "UseAutoStun")
    self.UseEAtXFeathers.Value = SettingsManager:GetSettingsInt("Misc", "UseEAtXFeathers")
    self.UseENoFeatherAmmo.Value = SettingsManager:GetSettingsInt("Misc", "UseENoFeatherAmmo")
    
    if self.UseEAtXFeathers.Value == 0 then
        self.UseEAtXFeathers.Value = 3
    end
    --------------------------------------------

    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    self.DrawEspFeathers.Value = SettingsManager:GetSettingsInt("Drawings", "DrawEspFeathers")
    self.FeatherAbleDrawingXAxis.Value = SettingsManager:GetSettingsInt("Drawings", "XAxisFeatherInfo")
    self.FeatherAbleDrawingYAxis.Value = SettingsManager:GetSettingsInt("Drawings", "YAxisFeatherInfo")
    self.DrawKillableInfo.Value = SettingsManager:GetSettingsInt("Drawings", "DrawKillableInfo")
    self.DrawKillBoxes.Value = SettingsManager:GetSettingsInt("Drawings", "DrawKillBoxes")

    if self.FeatherAbleDrawingYAxis.Value == 0 then
        self.FeatherAbleDrawingYAxis.Value = 100
    end
    if self.FeatherAbleDrawingXAxis.Value == 0 then
        self.FeatherAbleDrawingXAxis.Value = 400
    end
    --------------------------------------------
end

function Xayah:GetGaleForceDamage(Target)
	local level = self:GetHeroLevel()
	local dmg = {180, 195, 210, 225, 240, 255, 270, 285, 300, 315}
	local healthMultiplier = 1 + (((1 - (Target.Health / Target.MaxHealth))/7) * 5)
	local totalDmg = 0

	if healthMultiplier > 1.5 then
		healthMultiplier = 1.5
	end

	if level < 10 then
		totalDmg = dmg[1]
	else
		totalDmg = dmg[level-9]
	end

	return (totalDmg + (0.45 * myHero.BonusAttack)) * healthMultiplier
end

function Xayah:GetHeroLevel()
	local levelQ = myHero:GetSpellSlot(0).Level
	local levelW = myHero:GetSpellSlot(1).Level
	local levelE = myHero:GetSpellSlot(2).Level
	local levelR = myHero:GetSpellSlot(3).Level
	return levelQ + levelW + levelE + levelR
end

function Xayah:GetItemKey(ItemName)
	for i = 6 , 11 do
		if myHero:GetSpellSlot(i).Info.Name == ItemName then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Xayah:GaleforceCheck()
	local Galeforce 					= {}
			Galeforce.Key				= self:GetItemKey("6671Cast")	
	if Galeforce.Key ~= nil then
		if Engine:SpellReady(Galeforce.Key) then
			return Galeforce
		end
	end
	return false
end

function Xayah:GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
		if FinalArmor < 0 then
			FinalArmor = 0
		end

        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = (target.MagicResist - myHero.MagicPenFlat) * myHero.MagicPenMod

		if realMR < 0 then
			realMR = 0
		end

        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

function Xayah:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Xayah:GetQDmg()
    local qDmg      = {90, 130, 170, 210, 250}
    local qLevel    = myHero:GetSpellSlot(0).Level

    if qLevel == 0 then
        return 0
    end
    
    return qDmg[qLevel] + myHero.BonusAttack
end

function Xayah:GetEDmg(amountOfFeathers)
    local eDmg          = {55, 65, 75, 85, 95}
    local eLevel        = myHero:GetSpellSlot(2).Level
    local totalDamage   = 0

    if eLevel == 0 then
        return 0
    end

    for i=0, amountOfFeathers - 1 do
        local modifier = (1 - (i * 0.05))
        
        if modifier < 0.10 then
            modifier = 0.10
        end

        totalDamage = totalDamage + ((eDmg[eLevel] + myHero.BonusAttack * 0.60) * (1 - (i * 0.05)))
    end

    return totalDamage
end

function Xayah:GetRDmg()
    local rDmg          = {125, 250, 375}
    local rLevel        = myHero:GetSpellSlot(3).Level
    local totalDamage   = 0

    if rLevel == 0 then
        return 0
    end

    return rDmg[rLevel] + myHero.BonusAttack
end

function Xayah:HasPassive()
    local buff = myHero.BuffData:GetBuff("XayahPassiveActive")

    return buff and buff.Count_Alt > 0
end

--[[ function Xayah:MinionLogic()
    local Minions 					= ObjectManager.MinionList
    local HeroesInRange             = self:GetEnemiesInRange(900)

    if self:HasPassive() then
        for _, Minion in pairs(Minions) do
            if Minion.Team ~= myHero.Team and Minion.IsTargetable then
                for _, Hero in pairs(HeroesInRange) do
                    local PlayerPos = myHero.Position
				    local TargetPos = Hero.Position
                    local i 			= 900
					local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
					local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
					local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
					local EndPos 		= Vector3.new(PlayerPos.x + (TargetNorm.x * i),PlayerPos.y + (TargetNorm.y * i),PlayerPos.z + (TargetNorm.z * i))

                    if Prediction:PointOnLineSegment(myHero.Position, EndPos, Hero.Position, 30) ~= false and Orbwalker.ResetReady == 1 then
                        print("Hit HIM!!")
                        Engine:AttackClick(Minion.Position, 0)
                    end
                end
            end
        end
    end
end ]]

function Xayah:GatherFeathers()
    self.Feathers = {}
    local Minions 					= ObjectManager.MinionList

    for _, Minion in pairs(Minions) do
        if Minion.Team == myHero.Team and Minion.Name == "Feather" and self:GetDistance(Minion.Position, myHero.Position) < 4000 and Minion.IsDead == false then
            table.insert(self.Feathers, Minion)
        end
    end
end

function Xayah:GetEnemiesInRange(Range)
    local HeroesInRange = {}
    local Heroes = ObjectManager.HeroList
    for _,Hero in pairs(Heroes) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and self:GetDistance(myHero.Position, Hero.Position) < Range then
            table.insert(HeroesInRange, Hero)
        end
    end
    return HeroesInRange
end

function Xayah:DrawEspFeatherableEnemies(HitableHeroes)
    local drawedHittables = 0
    for _,HitableHero in pairs(HitableHeroes) do
        local Point         = HitableHero.Hero.Position
		local PointScreen 	= Vector3.new()
        Render:World2Screen(Point, PointScreen)

        Render:DrawCircle(HitableHero.Hero.Position, HitableHero.Hero.CharData.BoundingRadius, 204, 0, 0, 200)
        Render:DrawString('Feathers: ' .. tostring(#HitableHero.Feathers), PointScreen.x + 50, PointScreen.y -30, 255, 255, 255, 255)

        if self.DrawKillableInfo.Value == 1 then
            local EDmg = 0
            local IsKillable = false
            local vecOut = Vector3.new()
            local fullHpDrawWidth = 105
            local damageDrawWidth = 0
            local hpDrawWidth = 105 * (HitableHero.Hero.Health / HitableHero.Hero.MaxHealth)
            local damageStartingX = 0

            EDmg = self:GetDamage(self:GetEDmg(#HitableHero.Feathers), true, HitableHero.Hero)
            damageDrawWidth = (hpDrawWidth - hpDrawWidth * ((HitableHero.Hero.Health - EDmg) / HitableHero.Hero.Health))
            damageStartingX = hpDrawWidth - damageDrawWidth

            if damageStartingX <= 0 then
                damageStartingX = hpDrawWidth
            end

            IsKillable = HitableHero.Hero.Health < EDmg
            local KillDraw = string.format("%.0f", EDmg) .. " / " .. string.format("%.0f", HitableHero.Hero.Health)
            
            if Render:World2Screen(HitableHero.Hero.Position, vecOut) and self.DrawKillBoxes.Value == 1 then
                Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 190 , fullHpDrawWidth,  6, 0, 0, 0, 200)
                Render:DrawFilledBox(vecOut.x - 49 , vecOut.y - 190 , hpDrawWidth,  6, 92, 255, 5, 200)
                Render:DrawFilledBox(vecOut.x - 49 + damageStartingX , vecOut.y - 190 , damageDrawWidth,  6,153, 0, 0, 240)

                if IsKillable then
                    Render:DrawString(HitableHero.Hero.ChampionName .. " | Feathers " .. #HitableHero.Feathers, vecOut.x - 50 , vecOut.y - 235 , 255, 255, 255, 255)
                    Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 215 , 255, 255, 255, 255)
                else
                    Render:DrawString(HitableHero.Hero.ChampionName .. " | Feathers " .. #HitableHero.Feathers, vecOut.x - 50 , vecOut.y - 235 , 93, 255, 0, 255)
                    Render:DrawString(KillDraw, vecOut.x - 50 , vecOut.y - 215 , 93, 255, 0, 255)
                end  
            end
    
            if IsKillable then
                Render:DrawString(HitableHero.Hero.Name .. ' Feathers:  ' .. tostring(#HitableHero.Feathers) .. ' KILLABLE', self.FeatherAbleDrawingXAxis.Value, self.FeatherAbleDrawingYAxis.Value + (drawedHittables * 20), 153, 0, 0, 255)
            else
                Render:DrawString(HitableHero.Hero.Name .. ' Feathers:  ' .. tostring(#HitableHero.Feathers), self.FeatherAbleDrawingXAxis.Value, self.FeatherAbleDrawingYAxis.Value + (drawedHittables * 20), 255, 255, 255, 255)
            end
        end
    end
end

function Xayah:DrawFeatherEsp()
    local HeroesInRange     = self:GetEnemiesInRange(self.ERange)
    local HittableHeroes    = {}
    self.HeroesAndFeathers  = {}

    for _,Feather in pairs(self.Feathers) do
        local HittableByFeather = {}
        local Start         = myHero.Position
        local End           = Feather.Position
      
        local StartScreen   = Vector3.new()
        local EndScreen     = Vector3.new()

        for _,Hero in pairs(HeroesInRange) do
            local HeroAndFeather = {}
            HeroAndFeather.Hero = Hero
            HeroAndFeather.Feathers = {}

            if Prediction:PointOnLineSegment(myHero.Position, Feather.Position, Hero.Position, Hero.CharData.BoundingRadius) ~= false then
                HeroAndFeather.Hero = Hero
                HeroAndFeather.Feathers = {Feather}

                table.insert(HittableByFeather, Hero)
            end

            if self.HeroesAndFeathers[Hero] ~= nil then
                self.HeroesAndFeathers[Hero].Feathers = union(self.HeroesAndFeathers[Hero].Feathers, HeroAndFeather.Feathers)
            else
                self.HeroesAndFeathers[Hero] = HeroAndFeather
            end
        end

        if self.DrawEspFeathers.Value == 1 then 
            Render:World2Screen(Start, StartScreen)
            Render:World2Screen(End, EndScreen)

            if #HittableByFeather > 0 then
                Render:DrawLine(StartScreen, EndScreen, 204, 0, 0, 200)
            else
                Render:DrawLine(StartScreen, EndScreen, 0, 204, 0, 150)
            end
        end
        
        HittableHeroes = union(HittableHeroes, HittableByFeather)
    end

    if self.DrawEspFeathers.Value == 1 then
        self:DrawEspFeatherableEnemies(self.HeroesAndFeathers)
    end
end

function Xayah:GetObjectsOnMouseposition()
    local Missiles 					= ObjectManager.MissileList
    local Minions 					= ObjectManager.MinionList

    for _, Missile in pairs(Missiles) do
        if Missile.Team == myHero.Team and self:GetDistance(Missile.Position, GameHud.MousePos) < 500 then
            print(Missile.Name)
        end
    end

    for _, Missile in pairs(Minions) do
        if Missile.Team == myHero.Team and self:GetDistance(Missile.Position, GameHud.MousePos) < 500 then
            print(Missile.Name)
        end
    end
end

function Xayah:UseQ()
    if Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 then
        local target = Orbwalker:GetTarget("Combo", self.QRange)

        if target then
            if self:GetDistance(myHero.Position, target.Position) <= self.QRange - 50 then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                if PredPos then
                    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                    return
                end
            end
        end
    end
end

function Xayah:UseW()
    if Engine:SpellReady("HK_SPELL2") and Orbwalker.Attack == 0 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if self:GetDistance(myHero.Position, target.Position) <= self.WRange then
                Engine:CastSpell("HK_SPELL2", nil , 0)
                return
            end
        end
    end
end

function Xayah:KSAndAutoStun()
    local HeroesInRange = self.HeroesAndFeathers
    local Galeforce = self:GaleforceCheck()

    for _, HeroAndFeather in pairs(HeroesInRange) do
        local Hero = HeroAndFeather.Hero

        if Engine:SpellReady("HK_SPELL3") 
        and 
            (
                (self.UseKSE.Value == 1 and self:GetDamage(self:GetEDmg(#HeroAndFeather.Feathers), true, Hero) > Hero.Health)
                or (self.UseENoFeatherAmmo.Value == 1 and not(self:HasPassive()) and #HeroAndFeather.Feathers >= self.UseEAtXFeathers.Value)
                or (self.UseENoFeatherAmmo.Value == 0 and #HeroAndFeather.Feathers >= self.UseEAtXFeathers.Value)
                or (self.UseAutoStun.Value == 1 and #HeroAndFeather.Feathers >= 3 and self:GetDistance(myHero.Position, Hero.Position) <= 100)
                or ( self.UseKSE.Value == 1 and Hero.Health < self:GetDamage(self:GetEDmg(#HeroAndFeather.Feathers), true, Hero) + self:GetDamage(self:GetQDmg(), true, Hero) 
                    and Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QRange - 50
                    )
                or ( self.UseKSE.Value == 1 and Hero.Health < self:GetDamage(self:GetEDmg(#HeroAndFeather.Feathers), true, Hero) + self:GetDamage(self:GetQDmg(), true, Hero) + self:GetDamage(self:GetRDmg(),true,Hero)
                    and Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QRange - 50
                    and Engine:SpellReady("HK_SPELL4")
                    )
            )
        and Orbwalker.ResetReady ~= 1 and Orbwalker.Attack == 0 then
            Engine:CastSpell("HK_SPELL3", myHero.Position, 1)
        end

        if self.UseKSQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and self:GetDistance(myHero.Position, Hero.Position) <= self.QRange - 50 
        and Hero.Health < self:GetDamage(self:GetQDmg(), true, Hero) then
            local PredPos, HitChance = Prediction:GetPredPos(myHero.Position, Hero, self.QSpeed, self.QDelay)
            --print("KS by Q")
            if PredPos and Orbwalker.ResetReady ~= 1 and Orbwalker.Attack == 0 then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
            end
        end

        if self.UseKSR.Value == 1 and Engine:SpellReady("HK_SPELL4") and self:GetDistance(myHero.Position, Hero.Position) <= self.RRange - 50
        and Hero.Health < self:GetDamage(self:GetRDmg(), true, Hero) then
            local PredPos, HitChance = Prediction:GetPredPos(myHero.Position, Hero, self.QSpeed, self.QDelay)
            --print("KS by R")
            if PredPos and Orbwalker.ResetReady ~= 1 and Orbwalker.Attack == 0 then
                Engine:CastSpell("HK_SPELL4", PredPos, 1)
            end
        end

        if self.UseGaleforce.Value == 1 and Galeforce ~= false then
            if #self:GetEnemiesInRange(self.QRange + 100) <= self.UseGaleforceMaxEnemies.Value then
                local HeroDistance = self:GetDistance(myHero.Position, Hero.Position)
                if HeroDistance < self.GaleforceRange - 100
                and Hero.Health < self:GetDamage(self:GetGaleForceDamage(Hero), false, Hero)
                then
                    --print("KS by Galeforce")
                    Engine:CastSpell(Galeforce.Key, Hero.Position, 1)
                end

                if HeroDistance < self.GaleforceRange - 100
                and self.UseKSQ.Value == 1
                and Engine:SpellReady("HK_SPELL1")
                and Hero.Health < self:GetDamage(self:GetGaleForceDamage(Hero), false, Hero) + self:GetDamage(self:GetQDmg(), true, Hero)
                then
                    --print("KS by Galeforce Q")
                    Engine:CastSpell(Galeforce.Key, Hero.Position, 1)
                end

                if HeroDistance < self.GaleforceRange - 100
                and self.UseKSQ.Value == 1
                and self.UseKSR.Value == 1
                and Engine:SpellReady("HK_SPELL1")
                and Engine:SpellReady("HK_SPELL4")
                and Hero.Health < self:GetDamage(self:GetGaleForceDamage(Hero), false, Hero) + self:GetDamage(self:GetQDmg(), true, Hero) 
                + self:GetDamage(self:GetRDmg(),true,Hero) and #self:EnemiesInRange(self.QRange + 100) <= 1
                then
                    --print("KS by Galeforce QR")
                    Engine:CastSpell(Galeforce.Key, Hero.Position, 1)
                end
            end
        end
    end
end

function Xayah:Combo()
    if self.UseQCombo.Value == 1 then
        self:UseQ()
    end

    if self.UseWCombo.Value == 1 then
        self:UseW()
    end
end

function Xayah:Harass()
    if self.UseQHarass.Value == 1 and  (self.UseQHarassMana.Value == 0 or myHero.Mana / myHero.MaxMana > (self.UseQHarassMana.Value / 100)) then
        self:UseQ()
    end
end

function Xayah:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:GatherFeathers()
        self:KSAndAutoStun()
	end
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			self:Harass()
			return
		end
	end
end

function Xayah:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
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

    self:DrawFeatherEsp()
end

function Xayah:OnLoad()
    if myHero.ChampionName ~= "Xayah" then return end
	AddEvent("OnSettingsSave" , function() Xayah:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Xayah:LoadSettings() end)

    Xayah:__init()

    AddEvent("OnTick", function() Xayah:OnTick() end)
    AddEvent("OnDraw", function() Xayah:OnDraw() end)
end

AddEvent("OnLoad", function() Xayah:OnLoad() end)





function union ( a, b )
    local result = {}
    for k,v in pairs ( a ) do
        table.insert( result, v )
    end
    for k,v in pairs ( b ) do
        table.insert( result, v )
    end

    local hash = {}
    local res = {}

    for _,v in ipairs(result) do
        if (not hash[v]) then
            res[#res+1] = v -- you could print here instead of saving to result table if you wanted
            hash[v] = true
        end
    end

    return res
end