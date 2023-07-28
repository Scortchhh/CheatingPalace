local Leona = {}

function Leona:__init()

    --self.QRange = 
    self.QRange = 175
    self.WRange = 275
    self.ERange = 850
    self.RRange = 1200

    self.ESpeed = 2000
    self.RDelay = 0.2
    self.EDelay = 0.25
    

    self.ScriptVersion = "          --KKLeona Version: 0.1-- ///Credits KKat///"

	self.LeonaMenu = Menu:CreateMenu("Leona")
	self.LeonaCombo = self.LeonaMenu:AddSubMenu("Combo")
	self.LeonaCombo:AddLabel("Check Spells for Combo:")
	self.UseQCombo = self.LeonaCombo:AddCheckbox("Use Q in combo", 1)
	self.UseWCombo = self.LeonaCombo:AddCheckbox("Use W in combo", 1)
	self.UseECombo = self.LeonaCombo:AddCheckbox("Use E in combo", 1)
	self.UseRCombo = self.LeonaCombo:AddCheckbox("Use R in combo", 1)
	self.UseRComboSlider = self.LeonaCombo:AddSlider("Use R if more then x enemies in R range", 3, 1, 4, 1)
	self.LeonaHarass = self.LeonaMenu:AddSubMenu("Harass")
	self.LeonaHarass:AddLabel("Check Spells for Harass")
	self.UseQHarass = self.LeonaHarass:AddCheckbox("Use Q in harass", 1)
	self.UseWHarass = self.LeonaHarass:AddCheckbox("Use W in harass", 1)
	self.UseEHarass = self.LeonaHarass:AddCheckbox("Use E in harass", 1)
    self.LeonaFarm = self.LeonaMenu:AddSubMenu("Farm")
    self.LeonaFarm:AddLabel("Check Spells for Farm")
    self.UseQFarm = self.LeonaFarm:AddCheckbox("Use Q in Farm", 1)
    self.UseWFarm = self.LeonaFarm:AddCheckbox("Use W in Farm", 1)
    self.UseEFarm = self.LeonaFarm:AddCheckbox("Use E in Farm", 1)
	self.LeonaDrawings = self.LeonaMenu:AddSubMenu("Drawings")
	self.DrawQ = self.LeonaDrawings:AddCheckbox("Use Q in drawings", 1)
	self.DrawE = self.LeonaDrawings:AddCheckbox("Use E in drawings", 1)
	self.DrawW = self.LeonaDrawings:AddCheckbox("Use W in drawings", 1)
	self.DrawR = self.LeonaDrawings:AddCheckbox("Use R in drawings", 1)
	Leona:LoadSettings()
end

function Leona:SaveSettings()
	SettingsManager:CreateSettings("Leona")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in combo", self.UseQCombo.Value)
	SettingsManager:AddSettingsInt("Use W in combo", self.UseWCombo.Value)
	SettingsManager:AddSettingsInt("Use E in combo", self.UseECombo.Value)
	SettingsManager:AddSettingsInt("Use R in combo", self.UseRCombo.Value)
	SettingsManager:AddSettingsInt("Use R if more then x enemies in R range", self.UseRComboSlider.Value)
	------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use Q in harass", self.UseQHarass.Value)
	SettingsManager:AddSettingsInt("Use W in harass", self.UseWHarass.Value)
	SettingsManager:AddSettingsInt("Use E in harass", self.UseEHarass.Value)
	------------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Farm")
    SettingsManager:AddSettingsInt("Use Q in Farm", self.UseQFarm.Value)
    SettingsManager:AddSettingsInt("Use W in Farm", self.UseWFarm.Value)
    SettingsManager:AddSettingsInt("Use E in Farm", self.UseEFarm.Value)
    ------------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Use Q in drawings", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("Use W in drawings", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Use E in drawings", self.DrawE.Value)
	SettingsManager:AddSettingsInt("Use R in drawings", self.DrawR.Value)
end

function Leona:LoadSettings()
	SettingsManager:GetSettingsFile("Leona")
	self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q in combo")
	self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W in combo")
	self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E in combo")
	self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R in combo")
	self.UseRComboSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies in R range")
	-------------------------------------------
	self.UseQHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use Q in harass")
	self.UseWHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use W in harass")
	self.UseEHarass.Value = SettingsManager:GetSettingsInt("Harass", "Use E in harass")
	-------------------------------------------
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use Q in Farm")
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use E in Farm")
    self.UseQFarm.Value = SettingsManager:GetSettingsInt("Farm", "Use W in Farm")
    -------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "Use Q in drawings")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Use W in drawings")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Use E in drawings")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "Use R in drawings")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
	return math.sqrt((target.x - source.x) ^2 + (target.z - source.z) ^2)
end

local function GetDamage(rawDmg, isPhys, target)
	if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
	if not isPhys then return (100 / (100 + target.MagicResist)) *rawDmg end
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

function Leona:Combo()
    if Engine:SpellReady("HK_SPELL4") and self.UseRCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.RRange)
        if target ~= nil then
            if EnemiesInRange(target.Position, 200) > self.UseRComboSlider.Value then
                Engine:CastSpell("HK_SPELL4", target.Position, 1)
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 35, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end
        end
    end
    if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local wBuff = myHero.BuffData:GetBuff("LeonaSolarBarrier")
                if not wBuff.Valid then
                    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
                end
            else
                local wBuff = myHero.BuffData:GetBuff("LeonaSolarBarrier")
                if wBuff.Valid then
                    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
            end
        end
    end
end

function Leona:Harass()
    if Engine:SpellReady("HK_SPELL3") and self.UseECombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) > getAttackRange() then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 60, self.EDelay, 0)
                if PredPos ~= nil then
                    Engine:CastSpell("HK_SPELL3", PredPos, 1)
                end
            end
            if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
            end
        end
    end
    if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local wBuff = myHero.BuffData:GetBuff("ë1^├ï Uïý Þ╠ä■ à└yh")
                if not wBuff.Valid then
                    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
                end
            else
                local wBuff = myHero.BuffData:GetBuff("ë1^├ï Uïý Þ╠ä■ à└yh")
                if wBuff.Valid then
                    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 then
        local target = Orbwalker:GetTarget("Combo", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new())
            end
        end
    end
end

function Leona:Laneclear()
    local QRange = getAttackRange() - 20
    local target = Orbwalker:GetTarget("Laneclear", QRange)
    if target == nil then return end
    if not ValidTarget(target) then return end
        if GetDist(myHero.Position, target.Position) <= QRange then
            if Engine:SpellReady("HK_SPELL1") and self.UseQFarm.Value == 1 and Orbwalker.WindingUp == 0 then
            Engine:CastSpell("HK_SPELL1", Vector3.new())
            end
        end
        if GetDist(myHero.Position, target.Position) <= getAttackRange() then
                if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                    Engine:CastSpell("HK_SPELL3", target.Position, 1)
                end
        end
        if GetDist(myHero.Position, target.Position) <= self.WRange then
                local wBuff = myHero.BuffData:GetBuff("ë1^├ï Uïý Þ╠ä■ à└yh")
                if not wBuff.Valid then
                    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
                end
        end











end


--[[function Leona:Combo()
	local target = Orbwalker:GetTarget("Combo", 1000)
	if target ~= nil then
	    if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
	        if EnemiesInRange(myHero.Postition, 850)  >= self.UseRComboSlider then
		        Engine:CastSpell('HK_SPELL4', GameHud.MousePos)
			end
			if GetDist(myHero.Position, target.Position) <= 980 and GetDist(myHero.Position, target.Position) >= getAttackRange() then
			    local qCastPos = Prediction:GetCastPos(myHero.Position, 980, 1500, 120, 0.25, 1)
                if qCastPos ~= nil then
				    if Engine:SpellReady('HK_SPELL4') and self.UseRCombo.Value == 1 then
                        Engine:CastSpell('HK_SPELL4', rCastPos, 1)
                    end
				end
			end
			if GetDist(myHero.Postition, target.Position) >= 300 then
		       local wBuff = myHero.BuffData:GetBuff("Burnout")
			   if not wBuff.Valid then
			        if Engine:SpellReady('HK_SPELL2')and self.UseWCombo.Value == 1 then
				        Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
					end
				end
			end
		end
		    local wBuff = myHero.BuffData:GetBuff("Burnout")
			if wBuff.Valid then
			    if Engine:SpellReady('HK_SPELL2') and self.UseWCombo.Value == 1 then
				    Engine:CastSpell('HK_SPELL2', GameHud.MousePos)
				end
            end
            if Engine:SpellReady('HK_SPELL3') and self.UseECombo.Value == 1 then
			    if GetDist(myHero.Position, target.Position) <= 925 and GetDist(myHero.Position, target.Position) >= getAttackRange() then
			        local eCastPos = Prediction:GetCastPos(myHero.Position, 980, 1500, 120, 0.25, 1)
				    if eCastPos ~=nil then
                        Engine:CastSpell('HK_SPELL3', eCastPos,1)
                    end
				end
			end
		end
	end
end
]]

		    

function Leona:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
			Leona:Combo()
			return
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Leona:Harass()
			return
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
			Leona:Laneclear()
			return
		end
	end
end

function Leona:OnDraw()
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

			
function Leona:OnLoad()
	if(myHero.ChampionName ~= "Leona") then return end
    AddEvent("OnSettingsSave" , function() Leona:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Leona:LoadSettings() end)
    

    Leona:__init()
    AddEvent("OnDraw", function() Leona:OnDraw() end)
    AddEvent("OnTick", function() Leona:OnTick() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Leona:OnLoad() end)