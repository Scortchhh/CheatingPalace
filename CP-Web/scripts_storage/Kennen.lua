Kennen = {}
function Kennen:__init()	
	self.QRange = 1050
    self.QSpeed = 1650
    self.QWidth = 80
    self.QDelay = 0.175

    self.WRange = 790
    self.WSpeed = math.huge
	self.WDelay = 0.25

    self.RRange = 550
	self.RSpeed = math.huge
	self.RDelay = 0.25

    self.QHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Kennen")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	self.EnemiesToStun = self.ComboMenu:AddSlider("Enemies for R", 2, 1, 5, 1)

	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ", 1)
    self.HarassUseW2 = self.HarassMenu:AddCheckbox("UseW", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE", 1)
	
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
	
	Kennen:LoadSettings()
end

function Kennen:SaveSettings()
	SettingsManager:CreateSettings("Kennen")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
	SettingsManager:AddSettingsInt("Enemies to stun", self.EnemiesToStun.Value)
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Kennen:LoadSettings()
	SettingsManager:GetSettingsFile("Kennen")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
	self.EnemiesToStun.Value = SettingsManager:GetSettingsInt("Combo","Enemies to stun")
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Kennen:GetDamage(rawDmg, isPhys, target)
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

function Kennen:EnemiesInRange(Position, Range)
    local Enemies = {} 
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if Orbwalker:GetDistance(Hero.Position , Position) < Range then
	            Enemies[#Enemies + 1] = Hero			
			end
		end
    end
    return Enemies
end

function Kennen:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Kennen:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function Kennen:Combo()
	local target = Orbwalker:GetTarget("Combo", 1000)
	if target then
        if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 then
            local enemiesInRange = self:EnemiesInRange(myHero.Position, self.RRange)
            if #enemiesInRange >= self.EnemiesToStun.Value then
                Engine:CastSpell("HK_SPELL4", GameHud.MousePos, 0)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 then
            local WDmg = self:GetDamage(35 + (25 * myHero:GetSpellSlot(2).Level) + (myHero.AbilityPower * 0.8), false, target)
            if target.Health <= WDmg then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
                return
            end
        end
        local stunBuff = target.BuffData:GetBuff("kennenmarkofstorm")
        if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 and stunBuff.Count_Alt >= 2 then
            Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            return
        end
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 then
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL3", GameHud.MousePos, 0)
                return
            end
        end
	end
end

function Kennen:Harass()
	local target = Orbwalker:GetTarget("Harass", 1200)
	if target then
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 then
            local WDmg = self:GetDamage(35 + (25 * myHero:GetSpellSlot(2).Level) + (myHero.AbilityPower * 0.8), false, target)
            if target.Health <= WDmg then
                Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
                return
            end
        end
        local stunBuff = target.BuffData:GetBuff("kennenmarkofstorm")
        if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 then
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
        if Engine:SpellReady("HK_SPELL2") and self.HarassUseW.Value == 1 and stunBuff.Count_Alt >= 2 then
            Engine:CastSpell("HK_SPELL2", GameHud.MousePos, 0)
            return
        end
        if Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 then
            if not Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") then
                Engine:CastSpell("HK_SPELL3", GameHud.MousePos, 0)
                return
            end
        end
	end
end

function Kennen:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
        -- print(myHero:GetSpellSlot(1).Cooldown)
		if Engine:IsKeyDown("HK_COMBO") then
			Kennen:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Kennen:Harass()
		end
	end
end

function Kennen:OnDraw()
	if myHero.ChampionName == "Kennen" then
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
        end
    end
end

function Kennen:OnLoad()
    if(myHero.ChampionName ~= "Kennen") then return end
	AddEvent("OnSettingsSave" , function() Kennen:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kennen:LoadSettings() end)


	Kennen:__init()
	AddEvent("OnTick", function() Kennen:OnTick() end)	
	AddEvent("OnDraw", function() Kennen:OnDraw() end)	
end

AddEvent("OnLoad", function() Kennen:OnLoad() end)	
