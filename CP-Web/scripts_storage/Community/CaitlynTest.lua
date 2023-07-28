Caitlyn = {}
function Caitlyn:__init()

	self.QRange = 1300
	self.WRange = 800
	self.ERange = 750
	self.RRange = 3500

	self.QSpeed = 2200
	self.WSpeed = 0.25
	self.ESpeed = 0.15
	self.RSpeed = 3200

	self.QDelay = 0.625 
	self.WDelay = 0.025
	self.EDelay = 0.15
	self.RDelay = 0.4
	
	self.ScriptVersion = "          --CaitlynTest Version: 1.0-- ///Credits to UAreMyLight and Critic///"
	
	self.CaitlynMenu = Menu:CreateMenu("Caitlyn")
	self.CaitlynCombo = self.CaitlynMenu:AddSubMenu("Combo")
	self.CaitlynCombo:AddLabel("Check Spells for Combo")
	self.UseQCombo = self.CaitlynCombo:AddCheckbox("Use Q in Combo", 1)
	self.UseWCombo = self.CaitlynCombo:AddCheckbox("Use W in Combo", 1)
	self.UseECombo = self.CaitlynCombo:AddCheckbox("Use E in Combo", 1)
	self.UseRCombo = self.CaitlynCombo:AddCheckbox("Use R in Combo", 1)
	self.CaitlynHarass = self.CaitlynMenu:AddSubMenu("Harass")
	self.CaitlynHarass:AddLabel("Check Spells For Harass")
	self.UseQHarass = self.CaitlynHarass:AddCheckbox("Use Q in Harass", 1)
	self.UseWHarass = self.CaitlynHarass:AddCheckbox("Use W in Harass", 1)
	self.UseEHarass = self.CaitlynHarass:AddCheckbox("Use E in Harass", 1)
	self.ComboMenu = self.CaitlynMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
	self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
	self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)
    --Caitlyn:LoadSettings()
    
    self.Spells 			={}

    self.Spells['CaitlynEntrapment'] = { Type = 0, Range = 750, Radius = 70, Speed = 1600, Delay = 0.15, CC = 1}
end

function Caitlyn:SaveSettings()
	
	SettingsManager:CreateSettings("Caitlyn")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("Use E in cobo", self.UseECombo.Value)
	SettingsManager:AddSettingsInt("Use R in Combo", self.UseRCombo.Value)
	----------------------------------------------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use Q in Harass", self.UseQHarass.Value)
	SettingsManager:AddSettingsInt("Use W in Harass", self.UseWHarass.Value)
	SettingsManager:AddSettingsInt("Use E in Harass", self.UseEHarass.Value)
	----------------------------------------------------------------------------------------------------------
	self.CaitlynKillSteal = self.CaitlynMenu:AddSubMenu("Killsteal")
    self.UseRKillsteal = self.CaitlynKillSteal:AddCheckbox("UseR in killsteal", 1)
	----------------------------------------------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
	SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
end

function Caitlyn:LoadSettings()
	-- body
	SettingsManager:GetSettingsFile("Caitlyn")
	self.UsageQCombo.Value = SettingsManager:GetSettingsFile("Combo", "Use Q in combo")
	self.UsageWCombo.Value = SettingsManager:GetSettingsFile("Combo", "Use W in combo")
	self.UsageECombo.Value = SettingsManager:GetSettingsFile("Combo", "Use E in combo")
	self.UsageRCombo.Value = SettingsManager:GetSettingsFile("Combo", "Use R in combo")
	self.UsageRCombo.Value = SettingsManager:GetSettingsFile("Combo", "Use R if more then x enemies")
	----------------------------------------------------------------------------------------------------------
	self.UseRKillsteal.Value = SettingsManager:GetSettingsFile("Killsteal", "UseR in Killsteal")
	----------------------------------------------------------------------------------------------------------
	self.UseQHarass.Value = SettingsManager:GetSettingsFile("Harass", "Use Q in Harass")
	self.UseWHarass.Value = SettingsManager:GetSettingsFile("Harass", "Use W in Harass")
	self.UseEHarass.Value = SettingsManager:GetSettingsFile("Harass", "Use E in Harass")
	----------------------------------------------------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsFile("Drawings", "DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsFile("Drawings", "DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsFile("Drawings", "DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsFile("Drawings", "DrawR")
	----------------------------------------------------------------------------------------------------------
	end

    
local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
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

function Caitlyn:HeadShot()
    local target = Orbwalker:GetTarget("Combo", 1300) print(1)
    if target ~= nil then print(2)
        if Orbwalker:CanAttack() == true then
            local LongShotBuff = myHero.BuffData:GetBuff("caitlynheadshotrangecheck")
            local HeadShotBuff1 = target.BuffData:GetBuff("caitlynyordletrapinternal")
            local HeadShotBuff2 = target.BuffData:GetBuff("caitlynyordletrapdebuff")
            if LongShotBuff.Valid then print(3)
                if HeadShotBuff1.Valid or HeadShotBuff2.Valid then print(4)
                    Engine:AttackClick(target.Position, 1) print(5)
                end
            end
        end
    end
end

function Caitlyn:Combo()
	if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
    	local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then 
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 and GetDist(myHero.Position, target.Position) < getAttackRange() then         
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 150, self.EDelay, 1)
        	    if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
        	end
		end
	end
	if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            local wBuff = target.BuffData:GetBuff("caitlynyordletrapsight")
            if not wBuff.Valid then
			    if target.AIData.IsDashing == true or target.BuffData:HasBuffOfType(BuffType.Stun) == true or target.BuffData:HasBuffOfType(BuffType.Slow) == true or target.BuffData:HasBuffOfType(BuffType.Snare) == true then
				    Engine:CastSpell("HK_SPELL2",target.Position, 1)											 
                end
                local ActiveSpell = myHero.ActiveSpell
                local Info = self.Spells[ActiveSpell.Info.Name]
                if Info ~= nil and Info.Type == 0 then
                    Engine:CastSpell("HK_SPELL2",target.Position, 1)
                end
            end
		end	
	end		
	if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
		local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target ~= nil then
            local wBuff = target.BuffData:GetBuff("caitlynyordletrapdebuff")
            if wBuff.Valid then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 150, self.QDelay, 0)
			    if PredPos ~= nil then
				    Engine:CastSpell("HK_SPELL1", PredPos, 1)
                end
            end
		end
	end
end


function Caitlyn:Harass() 
	if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
		local target = Orbwalker:GetTarget("Harass", self.QRange)
		if target ~= nil then           
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 150, self.QDelay, 0)
			if PredPos ~= nil then
				Engine:CastSpell("HK_SPELL1", PredPos, 1)
			end
		end
	end

	if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.ERange)
		if target ~= nil then           
			local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 150, self.EDelay, 1)
			if PredPos ~= nil then
				Engine:CastSpell("HK_SPELL3", PredPos, 1)
			end
		end
	end
end



function Caitlyn:OnDraw()
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange, 77, 255, 228, 255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, 925, 255, 249, 77, 255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255, 77, 210, 255)
    end
end

function Caitlyn:OnTick()
  if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsDead == false then
		if myHero:GetSpellSlot(1).Level > 1 then
			Orbwalker.ExtraDamage = 20 + 0.1 * myHero.AbilityPower
		end

		if Engine:IsKeyDown("HK_COMBO") then
            self:Combo()
            self:HeadShot()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
            self:Harass()
            self:HeadShot()
			return
		end
	end    
end

function Caitlyn:OnLoad()
   if(myHero.ChampionName ~= "Caitlyn") then return end
    AddEvent("OnSettingsSave" , function() Caitlyn:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Caitlyn:LoadSettings() end)
    

    Caitlyn:__init()
    AddEvent("OnDraw", function() Caitlyn:OnDraw() end)
    AddEvent("OnTick", function() Caitlyn:OnTick() end)
    print(self.ScriptVersion)	
    end

AddEvent("OnLoad", function() Caitlyn:OnLoad() end)