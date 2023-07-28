--Credits to Critic, Scortch, Christoph

Camille = {} 

function Camille:__init() 

    
    self.QRange = 325
    self.WRange = 650
    self.WRange2 = 300
    self.ERange = 800
    self.RRange = 475

    self.WSpeed = math.huge
    self.ESpeed = math.huge

    self.WWidth = 100
    self.EWidth = 100

    self.WDelay = 0
    self.EDelay = 0

    self.WHitChance = 0.3


    self.ScriptVersion = "                          Camille Ver: 1.5" 

    

    self.ChampionMenu = Menu:CreateMenu("Camille") 
    --------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboW = self.ComboMenu:AddCheckbox("Use W in Combo", 1) 
    self.ComboE = self.ComboMenu:AddCheckbox("Use E in Combo", 1) 
    --------------------------------------------
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassSlider = self.HarassMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
    --------------------------------------------
    self.LClearMenu = self.ChampionMenu:AddSubMenu("LaneClear") 
    self.LClearSlider = self.LClearMenu:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.ClearQ = self.LClearMenu:AddCheckbox("Use Q in LaneClear", 1) 
    self.ClearW = self.LClearMenu:AddCheckbox("Use W in LaneClear", 1)   
    --------------------------------------------
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    Camille:LoadSettings()  
end 

function Camille:SaveSettings() 

    SettingsManager:CreateSettings("Camille")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
	SettingsManager:AddSettingsInt("Use W in Combo", self.ComboW.Value)
    SettingsManager:AddSettingsInt("Use E in Combo", self.ComboE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.HarassSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("LaneClear")
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("Use Q in LaneClear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use W in LaneClear", self.ClearW.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
	SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function Camille:LoadSettings()
    SettingsManager:GetSettingsFile("Camille")
     --------------------------------------------
	self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
	self.ComboW.Value = SettingsManager:GetSettingsInt("Combo","Use W in Combo")
    self.ComboE.Value = SettingsManager:GetSettingsInt("Combo","Use E in Combo")
    --------------------------------------------
    self.HarassSlider.Value = SettingsManager:GetSettingsInt("Harass","Use abilities if mana above %")
    self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
    --------------------------------------------
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("LaneClear","Use abilities if mana above %")
    self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","Use Q in LaneClear")
    self.ClearW.Value = SettingsManager:GetSettingsInt("LaneClear","Use W in LaneClear")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","Draw E")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
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

function Camille:StunCheckR(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local right = PlayerPos
    for i = 25, 750 , 25 do
        right.x = right.x + i
        if Engine:IsNotWall(right) == false then
            if GetDist(right, TargetPos) <= 700 then
                return right
            end
		end
    end
    return nil
end

function Camille:StunCheckL(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local left = PlayerPos
    for i = 25, 750 , 25 do
        left.x = left.x - i
        if Engine:IsNotWall(left) == false then
            if GetDist(left, TargetPos) <= 700 then
                return left
            end
		end
    end
    return nil
end

function Camille:StunCheckT(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local top = PlayerPos
    for i = 25, 750 , 25 do
        top.z = top.z + i
        if Engine:IsNotWall(top) == false then
            if GetDist(top, TargetPos) <= 700 then
                return top
            end
		end
    end
    return nil
end

function Camille:StunCheckD(Target)
    local PlayerPos 	= myHero.Position
    local TargetPos 	= Target.Position
    local down = PlayerPos
    for i = 25, 750 , 25 do
        down.z = down.z - i
        if Engine:IsNotWall(down) == false then
            if GetDist(down, TargetPos) <= 800 then
                return down
            end
		end
	end
    return nil
end

function Camille:Combo()

    local qbuff = myHero.BuffData:GetBuff("camilleqprimingstart")
    if self.ComboQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.ResetReady == 1 and qbuff.Count_Alt == 0 then
        local target = Orbwalker:GetTarget("Combo", self.QRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", nil, 1)
                return
            end
        end
    end

    if self.ComboW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
        if target ~= nil and GetDist(myHero.Position, target.Position) >= self.WRange2 and GetDist(myHero.Position, target.Position) <= self.WRange then
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local onwall = myHero.BuffData:GetBuff("camilleedashtoggle")
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil and onwall.Count_Alt == 0 then 
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL3", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL3", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL3", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL3", wallD, 0)
            end
        end
    end

    if self.ComboE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local onwall = myHero.BuffData:GetBuff("camilleedashtoggle")
        local target = Orbwalker:GetTarget("Combo", self.ERange)
        if target ~= nil and onwall.Count_Alt > 0 then
            if myHero.AIData.Dashing then
                Engine:AttackClick(target.Position, 0)
            end
        end
    end

end


function Camille:Harass()

    local qbuff = myHero.BuffData:GetBuff("camilleqprimingstart")
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and qbuff.Count_Alt == 0 then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target ~= nil and Orbwalker.ResetReady == 1 then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                Engine:CastSpell("HK_SPELL1", nil, 1)
                return
            end
        end
    end

    if self.HarassW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Combo", self.WRange)
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 1, true, self.WHitChance, 1)
        if target ~= nil and GetDist(myHero.Position, target.Position) >= self.WRange2 and GetDist(myHero.Position, target.Position) <= self.WRange then
            if PredPos ~= nil then
                Engine:CastSpell("HK_SPELL2", PredPos, 1)
                return
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local onwall = myHero.BuffData:GetBuff("camilleedashtoggle")
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil and onwall.Count_Alt == 0 then 
            local wallT = self:StunCheckT(target)
            local wallL = self:StunCheckL(target)
            local wallR = self:StunCheckR(target)
            local wallD = self:StunCheckD(target) 
            if wallT ~= nil then
                Engine:CastSpell("HK_SPELL3", wallT, 0)
            end
            if wallL ~= nil then
                Engine:CastSpell("HK_SPELL3", wallL, 0)
            end
            if wallR ~= nil then
                Engine:CastSpell("HK_SPELL3", wallR, 0)
            end
            if wallD ~= nil then
                Engine:CastSpell("HK_SPELL3", wallD, 0)
            end
        end
    end

    if self.HarassE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local onwall = myHero.BuffData:GetBuff("camilleedashtoggle")
        local target = Orbwalker:GetTarget("Harass", self.ERange)
        if target ~= nil and onwall.Count_Alt > 0 then
            if myHero.AIData.Dashing then
                Engine:AttackClick(target.Position, 0)
            end
        end
    end

end

function Camille:Laneclear()

    if Engine:SpellReady("HK_SPELL1") and self.ClearQ.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target and Orbwalker.ResetReady == 1 then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.ClearW.Value == 1 then
        local target = Orbwalker:GetTarget("Laneclear", self.WRange)
        if target then
            if GetDist(myHero.Position, target.Position) <= self.WRange then
                local sliderValue = self.LClearSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL2", target.Position, 0)
                end
            end
        end
    end

end

function Camille:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Camille:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Camille:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            Camille:Laneclear()
		end
	end
end

function Camille:OnDraw()
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

function Camille:OnLoad()
    if(myHero.ChampionName ~= "Camille") then return end
	AddEvent("OnSettingsSave" , function() Camille:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Camille:LoadSettings() end)


	Camille:__init()
	AddEvent("OnTick", function() Camille:OnTick() end)	
    AddEvent("OnDraw", function() Camille:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() Camille:OnLoad() end)	
