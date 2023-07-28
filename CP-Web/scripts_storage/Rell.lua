Rell = {}
function Rell:__init()	
	self.QRange = 750
	self.WRange = 1000
	self.ERange = 1700
	self.RRange = 400

	self.QSpeed = 500
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QDelay = 0.4
	self.WDelaySmash = 0.5
	self.EDelayMount = 0.15    
	self.RDelay = 0.2

    self.ChampionMenu = Menu:CreateMenu("Rell")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("Use Q to break Shield", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("Use W(Dismount) in Combo", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("Use E in Combo", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("Use R in Combo", 1)
    self.enemiesForUlt = self.ComboMenu:AddSlider("Minimum enemies to use Ult", 3,1,5,1)
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1)
    self.HarassUseW = self.HarassMenu:AddCheckbox("Use W(MountUp) in Harass", 1)
    ---------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Rell Q", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("Draw Rell W", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("Draw Rell E", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("Draw Rell R", 1)
	
	self:LoadSettings()
end

function Rell:SaveSettings()
	SettingsManager:CreateSettings("Rell")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q to break Shield", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("Use W(Dismount) in Combo", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("Use R in Combo", self.ComboUseR.Value)
    SettingsManager:AddSettingsInt("Minimum enemies to use Ult", self.enemiesForUlt.Value)
	------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassUseQ.Value)
	SettingsManager:AddSettingsInt("Use W(MountUp) in Harass", self.HarassUseW.Value)
    ------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("Draw Rell Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw Rell W", self.DrawE.Value)
	SettingsManager:AddSettingsInt("Draw Rell E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw Rell R", self.DrawR.Value)
end

function Rell:LoadSettings()
	SettingsManager:GetSettingsFile("Rell")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q to break Sheild")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","Use W(Dismount) in Combo")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","Use R in Combo")
    self.enemiesForUlt.Value = SettingsManager:GetSettingsInt("Combo","Minimum enemies to use Ult")
	-------------------------------------------------------------
    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
	self.HarassUseW.Value = SettingsManager:GetSettingsInt("Harass","Use W(MountUp) in Harass")
    -------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Rell Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw Rell W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw Rell E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw Rell R")
end

local function GetDist(source, target)
    return math.sqrt(((target.x - source.x) ^ 2) + ((target.z - source.z) ^ 2))
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end
-------- Check for Stun -----
function CheckStun()
    local target = Orbwalker:GetTarget("Combo", 1700)
    if target then
        TargetStun   = target.BuffData:HasBuffOfType(BuffType.Stun)
        TargetTaunt  = target.BuffData:HasBuffOfType(BuffType.Taunt)
        TargetAsleep = target.BuffData:HasBuffOfType(BuffType.Asleep)
        TargetCharm  = target.BuffData:HasBuffOfType(BuffType.Charm)
        TargetFear   = target.BuffData:HasBuffOfType(BuffType.Fear)
        TargetPoly   = target.BuffData:HasBuffOfType(BuffType.Polymorph)
        TargetSupres = target.BuffData:HasBuffOfType(BuffType.Suppression)
        TargetSnare  = target.BuffData:HasBuffOfType(BuffType.Snare)
        TargetSpellS = target.BuffData:HasBuffOfType(BuffType.SpellShield)
        TargetImmune = target.BuffData:HasBuffOfType(BuffType.Immunity)
    end


    if target then
        if TargetSpellS  == false and TargetImmune == false then
            if TargetStun == true or TargetTaunt == true or TargetAsleep == true or TargetCharm == true 
            or TargetFear == true or TargetPoly == true or TargetSupres == true
            or TargetSnare == true then
                TargetIsStunned = true
        else
                TargetIsStunned = false
            end
        end
    end
end

-------- Check W Form ----------
function RellIsMounted()
RellForm = myHero:GetSpellSlot(1).Info.Name
    if RellForm == "RellW_Dismount" then
        RellMounted = true
        RellDismounted = false
    end
    if RellForm == "RellW_MountUp" then
        RellMounted = false
        RellDismounted = true
    end
end
-----------   Ultimate -------------
function Rell:countEnemiesUlt()
    local HeroList = ObjectManager.HeroList
    local count = 0
    for k,v in HeroList:pairs() do
        if v.Team ~= myHero.Team then
            if GetDist(myHero.Position, v.Position) <= 400 then
                count = count + 1
            end
        end
    end
    return count
end
-------------------------------------
function Rell:CastQ()
    if Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            local TargetShield = target.BuffData:HasBuffOfType(BuffType.Shield)
            if GetDist(myHero.Position, target.Position) <= self.QRange and TargetShield == true then
                Engine:CastSpell("HK_SPELL1", target.Position)
            end
        end
    end
end

function Rell:HarassQ()
    if Engine:SpellReady("HK_SPELL1") then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", target.Position)
            end
        end
    end
end

function Rell:ComboW()
    if Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= 900 and RellMounted == true then
                Engine:CastSpell("HK_SPELL2", target.Position)   
            end
        end
    end
end

function Rell:HarassW()
    if Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange and RellDismounted == true then
                Engine:CastSpell("HK_SPELL2", target.Position)
            end
        end    
   end
end

function Rell:StunE()
    if Engine:SpellReady("HK_SPELL3") then
        for i, Ally in pairs(ObjectManager.HeroList) do
            if Ally.Team == myHero.Team and Ally.ChampionName ~= myHero.ChampionName then
                if  Ally.IsDead == false then
                local Marked = Ally.BuffData:GetBuff('relle_target')
                local target = Orbwalker:GetTarget("Combo", self.ERange)
                    if target then
                        if Prediction:PointOnLineSegment(myHero.Position, Ally.Position, target.Position, 135) == true and TargetIsStunned == false  then
                            Engine:CastSpell("HK_SPELL3", target.Position)
                        end
                    end
                end
            end
        end
    end
end

                                
        
function Rell:CastR()
    if Engine:SpellReady('HK_SPELL4') then
        local target = Orbwalker:GetTarget("Combo", 500)
        if target then 
            local enemies = Rell:countEnemiesUlt()
            if GetDist(myHero.Position, target.Position) <= 400 and enemies >= self.enemiesForUlt.Value then
                Engine:CastSpell("HK_SPELL4", nil)
            end
        end
    end
end
      


function Rell:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        RellIsMounted()
        CheckStun()
		if Engine:IsKeyDown("HK_COMBO") then
            if self.ComboUseE.Value == 1 then
                Rell:StunE()
            end
            if self.ComboUseW.Value == 1 then
			Rell:ComboW()
            end
            if self.ComboUseQ.Value == 1 then
            Rell:CastQ()
            end
            if self.ComboUseR.Value == 1 then
            Rell:CastR()
            end
        end
        if Engine:IsKeyDown("HK_HARASS") then
            if self.HarassUseQ.Value == 1 then
            Rell:HarassQ()
            end
            if self.HarassUseW.Value == 1 then
            Rell:HarassW()
			end
		end
	end
end

function Rell:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,255,255,0,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,179,179,0,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
		Render:DrawCircle(myHero.Position, self.ERange ,0,107,0,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange, 255,255,255,255)
    end
end

function Rell:OnLoad()
    if(myHero.ChampionName ~= "Rell") then return end
    AddEvent("OnSettingsSave" , function() Rell:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Rell:LoadSettings() end)

	Rell:__init()
	AddEvent("OnTick", function() Rell:OnTick() end)
	AddEvent("OnDraw", function() Rell:OnDraw() end)
end

AddEvent("OnLoad", function() Rell:OnLoad() end)	