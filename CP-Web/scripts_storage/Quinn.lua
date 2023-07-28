--Credits to Critic, Scortch, Christoph, KKat, Uaremylight
Quinn = {} -- is the champion Quinn? yes okay proceed
function Quinn:__init() -- initialize Quinn script
    self.QRange = 1050
    self.WRange = 2100
    self.ERange = 700
    self.RRange = 700
    self.QSpeed = 1550
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    
    self.QWidth = 120

    self.QDelay = 0.25
    self.WDelay = 0
    self.EDelay = 0

    self.QHitChance = 0.2

    self.ScriptVersion = "         Quinn Ver: 1.1 CREDITS Derang3d"
    self.ChampionMenu = Menu:CreateMenu("Quinn")
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    self.ComboR = self.ComboMenu:AddCheckbox("Use R in Combo", 1) 
    --------------------------------------------
    ---Now we need to add a Harass menu-----
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    ---Now we need to add a lane clear menu---
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear")
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
 --   self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1) 
    self.ClearE = self.LClearMenu:AddCheckbox("Use E in LaneClear", 1) 
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Quinn:LoadSettings() 
end
function Quinn:SaveSettings()

    SettingsManager:CreateSettings("Quinn")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboR.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------

    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use E in LaneClear", self.ClearE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end
function Quinn:LoadSettings()
    SettingsManager:GetSettingsFile("Quinn")
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    --------------------------------------------
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearE.Value = SettingsManager:GetSettingsInt("LaneClear","Use E in LaneClear")
    --------------------------------------------
     --------------------------------Draw load----------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
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
function Quinn:IsWithValor()
    return myHero:GetSpellSlot(3).Info.Name == "QuinnRFinale"
end
function Quinn:GetAssassinTarget()
    -- Copied out of orbwalker, was throwing an error against 'TargetMode' for some reason when calling GetTargetSelectorList directly
    if Orbwalker.ForceTarget and Orbwalker.ForceTarget.IsHero then
        if Orbwalker.AssassinMode.Value == 1 then
            if Orbwalker.ForceTarget.IsDead == false then
                if Orbwalker:GetDistance(Orbwalker.ForceTarget.Position, myHero.Position) < Quinn.ERange + Orbwalker.ForceTarget.CharData.BoundingRadius then
                    return {Orbwalker.ForceTarget}
                else
                    return {}
                end
            end
        else
            if Orbwalker.ForceTarget.IsTargetable and Orbwalker:GetDistance(Orbwalker.ForceTarget.Position, myHero.Position) < Quinn.ERange + Orbwalker.ForceTarget.CharData.BoundingRadius then
                return {Orbwalker.ForceTarget}
            end
        end
    end

end
-----combo-----
function Quinn:Combo()
    if Quinn:IsWithValor() == true then
        self.QRange = getAttackRange() - 20
    else
        self.QRange = 1025
    end
    if Engine:SpellReady("HK_SPELL3") then
		if self.ComboE.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.ERange)
            if Target then
                local InsideTargetAttackRange = GetDist(myHero.Position, Target.Position) <= Target.AttackRange + Target.CharData.BoundingRadius + 50
                local useValorE = Quinn:IsWithValor() == true
                if InsideTargetAttackRange or useValorE then
                    if Orbwalker.Windup == 0 and Orbwalker.Attack == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                        return
                    end  
                end             
			end
		end
    end
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Quinn:IsWithValor() == false then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PassiveW = Target.BuffData:GetBuff("QuinnW")
            if PassiveW.Count_Alt == 0 then
                if GetDist(myHero.Position, Target.Position) <= getAttackRange() then
                    local PredPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                    if Orbwalker.ResetReady == 1 then
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", PredPos, 1)
                            return
                        end
                    end
                else
                    local PredPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                end
            end
          end
    end
	
end
function Quinn:Harass()
    if myHero:GetSpellSlot(3).Info.Name == "QuinnRFinale" then
        self.QRange = getAttackRange() - 20
    else
        self.QRange = 1025
    end
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Quinn:IsWithValor() == false then
        local Target = Orbwalker:GetTarget("Harass", self.QRange)
        local StartPos = myHero.Position
        if Target ~= nil then
            local PassiveW = Target.BuffData:GetBuff("QuinnW")
            if PassiveW.Count_Alt == 0 then
                if GetDist(myHero.Position, Target.Position) <= getAttackRange() then
                    local PredPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                    if Orbwalker.ResetReady == 1 then
                        if PredPos ~= nil then
                            Engine:CastSpell("HK_SPELL1", PredPos, 1)
                            return
                        end
                    end
                else
                    local PredPos = Prediction:GetCastPos(StartPos, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 1, true, self.QHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                end
            end
          end
    end
	if Engine:SpellReady("HK_SPELL3") then
		if self.HarassE.Value == 1 then
			local Target = Orbwalker:GetTarget("Harass", self.ERange)
            if Target then
                if GetDist(myHero.Position, Target.Position) <= Target.AttackRange + Target.CharData.BoundingRadius + 50 then
                    if Orbwalker.Windup == 0 and Orbwalker.Attack == 0 then  
                        Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                        return
                    end  
                end             
			end
		end
    end
end
function Quinn:Laneclear()
    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                    return
                end
            end
        end
    end
    if Engine:SpellReady("HK_SPELL3") then
		if self.ClearE.Value == 1 then
			local Target = Orbwalker:GetTarget("Laneclear", self.ERange)
			if Target then
				Engine:CastSpell("HK_SPELL3", Target.Position, 0)
				return
			end
		end
    end
end
--end---
function Quinn:OnTick()
    local isInValorMode = self:IsWithValor()
    local isValorWithForcedTarget = isInValorMode and Orbwalker.ForceTarget ~= nil and Quinn:GetAssassinTarget() == nil
    
    Orbwalker.DontAA = 0
    if isValorWithForcedTarget == true then
        Orbwalker.DontAA = 1
    end

    if GameHud.Minimized == false and GameHud.ChatOpen == false and not isValorWithForcedTarget then
        if Engine:IsKeyDown("HK_COMBO") then
            Quinn:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Quinn:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Quinn:Laneclear()
		end
	end
end
function Quinn:OnDraw()
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
end
function Quinn:OnLoad()
    if(myHero.ChampionName ~= "Quinn") then return end
	AddEvent("OnSettingsSave" , function() Quinn:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Quinn:LoadSettings() end)
	Quinn:__init()
	AddEvent("OnTick", function() Quinn:OnTick() end)	
    AddEvent("OnDraw", function() Quinn:OnDraw() end)
    print(self.ScriptVersion)	
end
AddEvent("OnLoad", function() Quinn:OnLoad() end)	
