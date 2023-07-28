local Galio = {
}

function Galio:__init()

    self.QRange = 825
    self.QSpeed = 1400
    self.QWidth = 120
    self.QDelay = 0.25

    self.ERange = 650
    self.ESpeed = 2300
    self.EWidth = 320
    self.EDelay = 0.4

    self.WMaxRange = 350
    self.WRange = 175

    self.QHitChance = 0.4
    self.EHitChance = 0.5

    self.GalioMenu = Menu:CreateMenu("Galio")
    self.GalioCombo = self.GalioMenu:AddSubMenu("Combo")
    self.GalioCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.GalioCombo:AddCheckbox("Use Q in combo", 1)
    self.UseWCombo = self.GalioCombo:AddCheckbox("Use W in combo", 1)
    self.UseECombo = self.GalioCombo:AddCheckbox("Use E in combo", 1)
    self.GalioHarass = self.GalioMenu:AddSubMenu("Harass")
    self.GalioHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.GalioHarass:AddCheckbox("Use Q in harass", 1)
    self.UseEHarass = self.GalioHarass:AddCheckbox("Use E in harass", 1)
    self.GalioR = self.GalioMenu:AddSubMenu("R-Settings")
    self.GalioR:AddLabel("Check Spells for Harass:")
    self.UseRCombo = self.GalioR:AddCheckbox("Use R in combo", 1)
    self.UseRComboSlider = self.GalioR:AddSlider("Use R if more then x enemies around ally", 3,1,5,1)
    self.GalioDrawings = self.GalioMenu:AddSubMenu("Drawings")
    self.DrawQ = self.GalioDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawW = self.GalioDrawings:AddCheckbox("Use W in drawings", 1)
    self.DrawE = self.GalioDrawings:AddCheckbox("Use E in drawings", 1)
    Galio:LoadSettings()
end

function Galio:SaveSettings()
	SettingsManager:CreateSettings("Galio")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("R-Settings")
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies around ally", self.UseRComboSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
end

function Galio:LoadSettings()
    SettingsManager:GetSettingsFile("Galio")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
    -------------------------------------------
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("R-Settings", "Use R in combo")
    self.UseRComboSlider.Value = SettingsManager:GetSettingsInt("R-Settings", "Use R if more then x enemies around ally")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
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

function Galio:Wallcheck(Position)
	local PlayerPos = myHero.Position
	local ToTargetVec = Vector3.new(Position.x - PlayerPos.x, Position.y - PlayerPos.y, Position.z - PlayerPos.z)

	local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
	local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
	
	for Range = 25 , Distance, 25 do
		local CurrentPos = Vector3.new(PlayerPos.x + (VectorNorm.x*Range), PlayerPos.y + (VectorNorm.y*Range), PlayerPos.z + (VectorNorm.z*Range))
		if Engine:IsNotWall(CurrentPos) == false then
			return false
		end
	end
	
	return true	
end

local function EnemiesInRange(Position, Range)
	local Count = 0 --FeelsBadMan
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

function Galio:CastingW()
    local WStartTime = myHero:GetSpellSlot(1).StartTime
    local WChargeTime = GameClock.Time - WStartTime
    local WCharge = myHero.ActiveSpell.Info.Name
    if WCharge == "GalioW" then
        self.WRange = 175 + (87.5*WChargeTime)
        if self.WRange <= 175 then self.WRange = 175 end
        if self.WRange >= 350 then self.WRange = 350 end
    else
        self.WRange = 175
        self.WCast = false
    end
    if Engine:IsKeyDown("HK_SPELL2") == true and Engine:SpellReady("HK_SPELL2") == false then
        self.WCast = false
        return Engine:ReleaseSpell("HK_SPELL2", nil)
    end
end


function Galio:UseR()
    local rRange = 3250 + (750 * myHero:GetSpellSlot(3).Level)
    for k, Ally in pairs(ObjectManager.HeroList) do
        if Ally.Team == myHero.Team then
            if EnemiesInRange(Ally.Position, 700) >= self.UseRComboSlider.Value and GetDist(myHero.Position, Ally.Position) <= rRange then
                if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                    Engine:CastSpell('HK_SPELL4', Ally.Position)
                end
            end
        end
    end
end

function Galio:Combo()
    Galio:UseR()

    if self.UseECombo.Value == 1 and Engine:SpellReady("HK_SPELL3") then 
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange - 100, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= 650 and Galio:Wallcheck(PredPos) then
            Engine:CastSpell('HK_SPELL3', PredPos, 1)
            return
        end
    end

    if self.UseQCombo.Value == 1 and Engine:SpellReady("HK_SPELL1") then 
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= 825 then
            Engine:CastSpell('HK_SPELL1', PredPos, 1)
            return
        end
    end

    if self.UseWCombo.Value == 1 and Engine:SpellReady("HK_SPELL2")then
        local target = Orbwalker:GetTarget("Combo", self.WMaxRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) < self.WRange then
                Engine:ReleaseSpell("HK_SPELL2", nil)
                return
            end
            if self.WCast == false then
                Engine:ChargeSpell("HK_SPELL2")
                self.WCast = true
                return
            end
        end
    end

end

function Galio:Harass()
    if self.UseEHarass.Value == 1 and Engine:SpellReady("HK_SPELL3") then 
        local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange - 100, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= 650 and Galio:Wallcheck(PredPos)  then
            Engine:CastSpell('HK_SPELL3', PredPos, 1)
            return
        end
    end

    if self.UseQHarass.Value == 1 and Engine:SpellReady("HK_SPELL1") then 
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= 825 then
            Engine:CastSpell('HK_SPELL1', PredPos, 1)
            return
        end
    end
end

function Galio:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Galio:CastingW()
        if Engine:IsKeyDown("HK_COMBO") then
            Galio:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Galio:Harass()
        end
    end
end

function Galio:OnDraw()
    if myHero.IsDead == true then return end
    local outvec = Vector3.new()
    if Render:World2Screen(myHero.Position, outvec) then
        if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
            Render:DrawCircle(myHero.Position, 825,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL2') and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, 450,255,0,255,255)
        end
        if Engine:SpellReady('HK_SPELL3') and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, 650,255,0,255,255)
        end
    end
end

function Galio:OnLoad()
    if myHero.ChampionName ~= "Galio" then return end
    AddEvent("OnSettingsSave" , function() Galio:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Galio:LoadSettings() end)
    Galio:__init()
    AddEvent("OnDraw", function() Galio:OnDraw() end)
    AddEvent("OnTick", function() Galio:OnTick() end)
end

AddEvent("OnLoad", function() Galio:OnLoad() end)	