local Teemo = {
    shroomSpots = {
        Vector3.new(2784.0, -39.547492980957, 11554.0),
        Vector3.new(3030.0, -50.338020324707, 11716.0),
        Vector3.new(3838.0, -57.755813598633, 11374.0),
        Vector3.new(4332.0, 51.248977661133, 11594.0),
        Vector3.new(4716.0,56.47679901123,12424.0),
        Vector3.new(5438.0,53.341243743896,12480.0),
        Vector3.new(6790.0,54.873878479004,13010.0),
        Vector3.new(7432.0,50.728813171387,11688.0),
        Vector3.new(7970.0,49.931171417236,10522.0),
        Vector3.new(8564.0,50.382843017578,10154.0),
        Vector3.new(8994.1630859375,54.597923278809,11245.641601563),
        Vector3.new(8322.0,56.47679901123,12174.0),
        Vector3.new(6418.0,55.811790466309,11394.0),
        Vector3.new(6194.0,54.319618225098,10006.0),
        Vector3.new(6986.0,54.627311706543,9594.0),
        Vector3.new(6236.0,-66.123466491699,9276.0),
        Vector3.new(4652.0,-70.882064819336,9990.0),
        Vector3.new(3608.0,4.1964836120605,9316.0),
        Vector3.new(3108.0,51.252777099609,9176.0),
        Vector3.new(2942.0,43.945320129395,10012.0),
        Vector3.new(1968.0,52.838104248047,9614.0),
        Vector3.new(2778.0,51.823837280273,8156.0),
        Vector3.new(2962.0,51.855072021484,7602.0),
        Vector3.new(3318.0,51.422348022461,6928.0),
        Vector3.new(2634.0,54.417369842529,6838.0),
        Vector3.new(2786.0,52.725555419922,5656.0),
        Vector3.new(4738.0,51.8293800354,6046.0),
        Vector3.new(4658.0,51.131988525391,6918.0),
        Vector3.new(3882.0,51.01294708252,7276.0),
        Vector3.new(4806.0,28.48353767395,8428.0),
        Vector3.new(5864.0,51.652542114258,7340.0),
        Vector3.new(5980.0,50.007904052734,5062.0),
        Vector3.new(5536.0,51.391525268555,3612.0),
        Vector3.new(6450.0,50.797950744629,2986.0),
        Vector3.new(7392.0,52.552040100098,3130.0),
        Vector3.new(7646.0,51.485660552979,2312.0),
        Vector3.new(9032.0,53.986797332764,3786.0),
        Vector3.new(8774.0,53.122386932373,4596.0),
        Vector3.new(8612.0,-54.879249572754,5590.0),
        Vector3.new(9944.0,-27.493659973145,6238.0),
        Vector3.new(11232.0,-15.635801315308,5540.0),
        Vector3.new(10600.0,34.280883789063,3326.0),
        Vector3.new(11650.0,51.352214813232,5690.0),
        Vector3.new(11860.0,51.71240234375,7154.0),
        Vector3.new(12214.0,52.305805206299,7842.0),
        Vector3.new(11586.0,52.50785446167,8004.0),
        Vector3.new(10692.0,51.87845993042,7584.0),
        Vector3.new(10064.0,50.480735778809,8846.0),
        Vector3.new(10132.0,57.284355163574,8346.0),
        Vector3.new(10154.0,-71.240600585938,4808.0),
        Vector3.new(12632.0,51.729400634766,5094.0),
        Vector3.new(11792.0,-71.240600585938,4182.0),
        Vector3.new(3306.0,-64.640800476074,10772.0),
    }
}

function Teemo:__init()
    self.TeemoMenu = Menu:CreateMenu("Teemo")
    self.TeemoCombo = self.TeemoMenu:AddSubMenu("Combo")
    self.TeemoCombo:AddLabel("Check Spells for Combo:")
    self.UseQCombo = self.TeemoCombo:AddCheckbox("Use Q in combo", 1)
    self.UseRCombo = self.TeemoCombo:AddCheckbox("Use R in combo", 1)
    self.TeemoHarass = self.TeemoMenu:AddSubMenu("Harass")
    self.TeemoHarass:AddLabel("Check Spells for Harass:")
    self.UseQHarass = self.TeemoHarass:AddCheckbox("Use Q in harass", 1)
    self.TeemoDrawings = self.TeemoMenu:AddSubMenu("Drawings")
    self.DrawQ = self.TeemoDrawings:AddCheckbox("Use Q in drawings", 1)
    self.DrawR = self.TeemoDrawings:AddCheckbox("Use R draws for shroom spots", 1)

    self.ShroomTimer = 0
    Teemo:LoadSettings()
end

function Teemo:SaveSettings()
	SettingsManager:CreateSettings("Teemo")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Use R draws for shroom spots", self.DrawR.Value)
end

function Teemo:LoadSettings()
    SettingsManager:GetSettingsFile("Teemo")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
    -------------------------------------------
    self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R draws for shroom spots")
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

function Teemo:Combo()
    local target = Orbwalker:GetTarget("Combo", 700)
    if target ~= nil then
        if GetDist(myHero.Position, target.Position) <= 680 then
            if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 and Orbwalker.Attack == 0 then
                local Predpos = Prediction:GetPredPos(myHero.Position, target, math.huge, 0.5)
                if Predpos then
                    if GetDist(myHero.Position, Predpos) <= 680 and (os.clock()-self.ShroomTimer) > 2.5 then
                        self.ShroomTimer = os.clock()
                        return Engine:CastSpell('HK_SPELL4', Predpos)
                    end
                end
            end
            if Engine:SpellReady('HK_SPELL1') and self.UseQCombo.Value == 1 and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
                return Engine:CastSpell('HK_SPELL1', target.Position)
            end
        end
    end
end

function Teemo:Harass()
    local target = Orbwalker:GetTarget("Combo", 700)
    if target ~= nil then
        if GetDist(myHero.Position, target.Position) <= 680 then
            if Engine:SpellReady('HK_SPELL1') and self.UseQHarass.Value == 1 and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0) then
                return Engine:CastSpell('HK_SPELL1', target.Position)
            end
        end
    end
end

function Teemo:ExtraDamageCheck()
    local ELevel = myHero:GetSpellSlot(2).Level
    if ELevel > 0 then
        local EDamagePerLevel = {10, 20, 30, 40, 50}
        Orbwalker.ExtraDamage = (EDamagePerLevel[ELevel] + (0.3 * myHero.AbilityPower))
    end
end

function Teemo:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        self:ExtraDamageCheck()
        if Engine:IsKeyDown("HK_COMBO") then
            Teemo:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Teemo:Harass()
        end
    end
    -- local target = Orbwalker:GetTarget("Combo", 1000)
    -- target.BuffData:ShowAllBuffs()
end

function Teemo:OnDraw()
    if myHero.IsDead == true then return end
    local isSpider = myHero.BuffData:GetBuff("TeemoR")
    if Engine:SpellReady('HK_SPELL1') and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, 680,100,150,255,255)
    end
    if self.DrawR.Value == 1 then
        for i, k in pairs(self.shroomSpots) do
            Render:DrawCircle(k, 80,100,150,100,255)
        end
    end
end

function Teemo:OnLoad()
    if myHero.ChampionName ~= "Teemo" then return end
    AddEvent("OnSettingsSave" , function() Teemo:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Teemo:LoadSettings() end)
    Teemo:__init()
    AddEvent("OnDraw", function() Teemo:OnDraw() end)
    AddEvent("OnTick", function() Teemo:OnTick() end)
end

AddEvent("OnLoad", function() Teemo:OnLoad() end)	