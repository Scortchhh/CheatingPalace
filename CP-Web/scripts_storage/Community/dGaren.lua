--Credits to Critic, Scortch, Christoph, KKat, Uaremylight


Garen = {} -- is the champion garen? yes okay proceed

function Garen:__init() -- initialize garen script


    -- range indicators below

    -- no Q range since the spell is instant and has no range 
    self.WRange = myHero.AttackRange + 50
    self.ERange = 300 -- E range is 325(but want to be safe and do 300 so you dont activate right on edge)
    self.RRange = 400 -- R range is 400(activate since using target.position it will be used perfectly)
    self.QCRange = 900
    -- delay indicators 

    -- self.RDelay = 0.50 -- cast time is .5 secs(winds up the R ability)(@critic all abilities have cast time this is used for pred and since using r for target.position it's not needed.)

    -- script version--

    self.ScriptVersion = "         dGaren Ver: 1.01 CREDITS Derang3d" -- tells what version of the script it is.

    -- whats the first thing needed on building a script! the Menu!!!

    self.ChampionMenu = Menu:CreateMenu("Garen") -- creates a menu box called "Garen"
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") -- adds a combo box under garen named "combo"
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1) -- adds a check box under combo for Q ability w/ the default value 1(being on)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) -- adds a check box under combo for W ability w/ the default value 1(being on)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) -- adds a check box under combo for E ability w/ the default value 1(being on)
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) -- adds a check box under combo for R ability w/ the default value 1(being on)
    --------------------------------------------
    ---Now we need to add a Harass menu-----

    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") -- adds a harass box under garen below "combo" since its located below the combo section of menu
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) -- adds a check box under Harass for Q ability w/ the default value 1(being on)
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) -- adds a check box under Harass for W ability w/ the default value 1(being on)
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) -- adds a check box under Harass for E ability w/ the default value 1(being on)
    --------------------------------------------

    ---Now we need to add a lane clear menu---
    
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") -- adds a LaneClear box under garen below "Harass" since its located below the Combo/Harass section of menu
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) -- adds a check box under LaneClear for Q ability w/ the default value 1(being on)
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) -- adds a check box under LaneClear for W ability w/ the default value 1(being on)
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) -- adds a check box under LaneClear for E ability w/ the default value 1(being on)
    --------------------------------------------

    ---Now we need to add a draw menu---

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") -- adds a drawings box under garen named "Drawings"
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) -- adds a check box under Drawings for E range drawing w/ the default value 1(being on)
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) -- adds a check box under Drawings for E range drawing w/ the default value 1(being on)
    
    --------------------------------------------
    
    Garen:LoadSettings()  -- this loads the settings for garen!
end -- ends the loading function for default settings above

function Garen:SaveSettings() -- this is the save settings for garen.
    --save settings from menu--

    --combo save settings--
    SettingsManager:CreateSettings("Garen")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------

    --harass save settings--
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    
    --laneclear save settings--
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------

	--drawings save settings--
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Garen:LoadSettings()
    SettingsManager:GetSettingsFile("Garen")
     --------------------------------Combo load----------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    --------------------------------------------

       --------------------------------Harass load----------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------

    --------------------------------LC load----------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------

	 --------------------------------Draw load----------------------
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end


local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function ValidTarget(target, distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end
----------combo---

-- r math calculations go to Critic, thanks for the help bro --
function Garen:DemacianJ()
    local UltLvl = myHero:GetSpellSlot(3).Level
    local HeroList = ObjectManager.HeroList
    for i, target in pairs(HeroList) do
        if target.Team ~= myHero.Team then
            if GetDist(myHero.Position, target.Position) <= 400 then
                local Demacia = UltLvl * 150 + (target.MaxHealth - target.Health) * (0.15 + 0.05 * UltLvl)
                if target.Health < Demacia then
                    if Engine:SpellReady('HK_SPELL4') then
                        Engine:CastSpell('HK_SPELL4', target.Position, 1)
                        return
                    end
                end
            end
        end
    end
end
---- R CALCULATIONS CREDIT GOES TO CRITIC ---------------

function Garen:Combo()

    local buff1 = myHero.BuffData:GetBuff("GarenE")
    local buff2 = myHero.BuffData:GetBuff("GarenQ")        

    local target = Orbwalker:GetTarget("Combo", 1000)
    if target == nil then return end
    if not ValidTarget(target) then return end
    if GetDist(myHero.Position, target.Position) <=1000 then
        if Engine:SpellReady('HK_SPELL1') and self.ComboQ.Value == 1 then
            Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
        end
    end

	if Engine:SpellReady("HK_SPELL2") then
		if self.ComboW.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
				return
			end
		end
	end
	if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Combo", self.ERange)
		if buff1.Valid == false and buff2.Valid == false and Target ~= nil then
			Engine:CastSpell("HK_SPELL3", Vector3.new(), 1)
			return
        end
    end
end

function Garen:Harass()

    local buff1 = myHero.BuffData:GetBuff("GarenE")
    local buff2 = myHero.BuffData:GetBuff("GarenQ")        

    if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
        local target = Orbwalker:GetTarget("Harass", getAttackRange() - 20)
        if target ~= nil then
            if Orbwalker:CanAttack() == false and Orbwalker.WindingUp == 0 then
                Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
            end
        end
    end

	if Engine:SpellReady("HK_SPELL2") then
		if self.HarassW.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
				return
			end
		end
	end
	if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
		local Target = Orbwalker:GetTarget("Harass", self.ERange)
		if buff1.Valid == false and buff2.Valid == false and Target ~= nil then
			Engine:CastSpell("HK_SPELL3", Vector3.new(), 1)
			return
        end
    end
end

function Garen:Laneclear()

    local buff1 = myHero.BuffData:GetBuff("GarenE")
    local buff2 = myHero.BuffData:GetBuff("GarenQ")        

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Laneclear", getAttackRange() - 20)
        if Target then
            if Target.IsTargetable then
                if buff1.Valid == false and Orbwalker.Attack == 1 then
                    Engine:CastSpell("HK_SPELL1", Vector3.new(), 1)
                    return
                end
            end
        end
    end

	if Engine:SpellReady("HK_SPELL2") then
		if self.ClearW.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.WRange)
            if Target then
                if Target.IsTargetable then
				    Engine:CastSpell("HK_SPELL2", Vector3.new(), 1)
                    return
                end
			end
		end
    end
    
    if self.ClearE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
        if Target then
            if Target.IsTargetable then
		        if buff1.Valid == false and buff2.Valid == false and Orbwalker.Attack == 1 then
			        Engine:CastSpell("HK_SPELL3", myHero.Position, 1)
                    return
                end
            end
		end
	end
end


--end---


function Garen:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
		if Engine:IsKeyDown("HK_COMBO") then
            Garen:DemacianJ()
            Garen:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Garen:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Garen:Laneclear()
		end
	end
end

function Garen:OnDraw()
--	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
--        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
--    end
--	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
--      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
--    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255) -- values Red, Green, Blue, Alpha(opacity)
        
    end
end

function Garen:OnLoad()
    if(myHero.ChampionName ~= "Garen") then return end
	AddEvent("OnSettingsSave" , function() Garen:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Garen:LoadSettings() end)


	Garen:__init()
	AddEvent("OnTick", function() Garen:OnTick() end)	
    AddEvent("OnDraw", function() Garen:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Garen:OnLoad() end)	
