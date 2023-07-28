--Credits to Critic, Scortch, Christoph, KKat, Uaremylight

Vi = {} 

function Vi:__init() 

    self.QCast = false
    self.QRange = 250
    self.QMaxRange = 725 
    --self.WRange = myHero.AttackRange
    self.ERange = myHero.AttackRange
    self.RRange = 800 

    self.QSpeed = 0 
    self.WSpeed = 0
    self.ESpeed = 0

    self.QDelay = 0.25

    self.ScriptVersion = "         dVi Ver: 1.03 CREDITS Derang3d" 

  

    self.ChampionMenu = Menu:CreateMenu("Vi") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    --self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    --self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    --self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") -- adds a drawings box under Vi named "Drawings"
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    --self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    --self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    -------------------------------------------
    
    Vi:LoadSettings()  -- this loads the settings for Vi!
end -- ends the loading function for default settings above

function Vi:SaveSettings() -- this is the save settings for Vi.
    --save settings from menu--

    --combo save settings--
    SettingsManager:CreateSettings("Vi")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	--SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    --SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    --SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    --SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	--SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Vi:LoadSettings()
    SettingsManager:GetSettingsFile("Vi")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	--self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    --self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")    
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    --self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    --self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    --self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    --self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	--self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
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

function Vi:GetDistance(source, target)
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

-----combo-----

function Vi:CastingQ()
	local QStartTime = myHero:GetSpellSlot(0).StartTime
	local QChargeTime = GameClock.Time - QStartTime
	local QCharge = myHero.ActiveSpell.Info.Name	
	if QCharge == "ViQ" then
		self.QRange = 250 + (250*QChargeTime)
		if self.QRange < 250 then self.QRange = 250 end
		if self.QRange > 725 then self.QRange = 725 end
	else
		self.QRange = 250
		self.QCast = false
	end
	if Engine:IsKeyDown("HK_SPELL1") == true and Engine:SpellReady("HK_SPELL1") == false then
		Engine:ReleaseSpell("HK_SPELL1")
		self.QCast = false
	end
end



function Vi:ultimate()

    if self.ComboR.Value == 1 and Engine:SpellReady('HK_SPELL4') then
        local HeroList = ObjectManager.HeroList
        for i, target in pairs(HeroList) do
            if target.Team ~= myHero.Team and target.IsDead == false then
                if GetDist(myHero.Position, target.Position) <= 400 then
                    local RDamage = {150, 325, 500}
                    local RLevel = myHero:GetSpellSlot(3).Level
                    local Rdmg = RDamage[RLevel]
                    local ViR = GetDamage(Rdmg + (myHero.BonusAttack * 1.1), true, target)
                    if ViR >= target.Health then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                    end
                end
            end
        end
    end
end

function Vi:Combo()

    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , math.huge, 0, self.QDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QRange then
				Engine:CastSpell("HK_SPELL1", CastPos ,1)
				return
			end
			if self.QCast == false then
				Engine:ChargeSpell("HK_SPELL1")
				self.QCast = true
			end
		end
    end	
    
    if Engine:SpellReady("HK_SPELL3") then
		if self.ComboE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange)
			if Target and Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
				Engine:CastSpell("HK_SPELL3", Vector3.new() , 1)
				return
			end
		end
    end


end



function Vi:Harass()

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
		local StartPos 	= myHero.Position
		local CastPos 	= Prediction:GetCastPos(StartPos, self.QMaxRange , math.huge, 0, self.QDelay, 0)
		if CastPos ~= nil then
			if self:GetDistance(StartPos, CastPos) < self.QRange then
				Engine:CastSpell("HK_SPELL1", CastPos , 1)
				return
			end
			if self.QCast == false then
				Engine:ChargeSpell("HK_SPELL1")
				self.QCast = true
			end
		end
    end	
    
    if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
			if Target and Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
				Engine:CastSpell("HK_SPELL3", Vector3.new() , 1)
				return
			end
		end
    end

end

function Vi:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") and self.ClearE.Value == 1 then
		if self.ClearE.Value == 1 then
            local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
            local sliderValue = self.LClearSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
			if myHero.Mana >= condition then
			    if Target then
				    Engine:CastSpell("HK_SPELL3", Vector3.new() , 0)
                    return
                end
			end
		end
    end


end

--end---


function Vi:OnTick()
    Vi:CastingQ()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
            Vi:ultimate()
        if Engine:IsKeyDown("HK_COMBO") then        
            Vi:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Vi:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Vi:Laneclear()
		end
	end
end

function Vi:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QMaxRange ,100,150,255,255)
    end
	--if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
    --  Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    --end
    --if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
    --    Render:DrawCircle(myHero.Position, self.ERange ,255,20,147,255)
    --end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function Vi:OnLoad()
    if(myHero.ChampionName ~= "Vi") then return end
	AddEvent("OnSettingsSave" , function() Vi:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Vi:LoadSettings() end)


	Vi:__init()
	AddEvent("OnTick", function() Vi:OnTick() end)	
    AddEvent("OnDraw", function() Vi:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Vi:OnLoad() end)	
