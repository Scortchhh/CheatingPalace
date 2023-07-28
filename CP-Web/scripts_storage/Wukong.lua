-- made by MrWong, credits to scortch
Wukong = {
    rRange = 450,
    eRange = 625
}

function Wukong:Init() 

    self.ScriptVersion = "           -- Wukong: Version 0.2 -- "

    self.ChampionMenu = Menu:CreateMenu("Wukong")
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ Combo", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW Combo", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE Combo", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR Combo", 1)
    self.ComboUseR2 = self.ComboMenu:AddCheckbox("UseR2 Combo", 1)
    self.ComboRSettings = self.ComboMenu:AddSubMenu("R Settings")
    self.ComboUseREnemiesSlider = self.ComboRSettings:AddSlider("Use R if more then x enemies", 3,1,5,1)
    self.ComboUseR2EnemiesSlider = self.ComboRSettings:AddSlider("Use R2 if more then x enemies", 3,1,5,1)
    
    self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
    self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ Harass", 1)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE Harass", 1)
    
            
    self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)    
    Wukong:LoadSettings()
end

function Wukong:SaveSettings()
    SettingsManager:CreateSettings("Wukong")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ Combo", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW Combo", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE Combo", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("UseR Combo", self.ComboUseR.Value)
    SettingsManager:AddSettingsInt("UseR2 Combo", self.ComboUseR2.Value)
    SettingsManager:AddSettingsInt("Use R if more then x enemies", self.ComboUseREnemiesSlider.Value)
    SettingsManager:AddSettingsInt("Use R2 if more then x enemies", self.ComboUseR2EnemiesSlider.Value)
    
    SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("UseQ Harass", self.HarassUseQ.Value)
    SettingsManager:AddSettingsInt("UseE Harass", self.HarassUseE.Value)
    
    
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Wukong:LoadSettings()
    SettingsManager:GetSettingsFile("Wukong")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo", "UseQ Combo")
    self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo", "UseW Combo")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo", "UseE Combo")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo", "UseR Combo")
    self.ComboUseR2.Value = SettingsManager:GetSettingsInt("Combo", "UseR2 Combo")
    self.ComboUseREnemiesSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R if more then x enemies")
    self.ComboUseR2EnemiesSlider.Value = SettingsManager:GetSettingsInt("Combo", "Use R2 if more then x enemies")
    
    
    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass", "UseQ Harass")
    self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass", "UseQ Harass")
    
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Draw", "DrawQ")
    self.DrawW.Value =  SettingsManager:GetSettingsInt("Draw", "DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Draw", "DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Draw", "DrawR")
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius
    return attRange
end

function GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end


local function EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do   
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Wukong:IsWActive()
    for index, Minion in pairs(ObjectManager.MinionList) do
        if Minion.ChampionName == "MonkeyKing" then
            return true
        end
    end
    return false
end

function Wukong:Clone()
    for index, Minion in pairs(ObjectManager.MinionList) do
        if Minion.ChampionName == "MonkeyKing" then
            return Minion
        end
    end
end


function Wukong:EnemyInCloneRangeR(Range)
    local MinionList = ObjectManager.MinionList
	for I,Minion in pairs(MinionList) do	
		if Minion.Team == myHero.Team and Minion.Name == "MonkeyKing" then
			local EnemyCount = EnemiesInRange(Minion.Position, self.rRange)
			if EnemyCount > 0 then
				return Minion
			end
		end
    end
    return nil
end

function Wukong:Combo()
    local target = Orbwalker:GetTarget("Combo", 700)
    if target then
        if self.ComboUseR.Value == 1 then
        local SliderR1 = self.ComboUseREnemiesSlider.Value
            if EnemiesInRange(target.Position, self.rRange) >= SliderR1 then
                local Passive = myHero.BuffData:GetBuff("MonkeyKingSpinToWin")
                if Engine:SpellReady("HK_SPELL4") and not Passive.Valid then
                    if self.ComboUseE.Value == 1 then
                        if Engine:SpellReady("HK_SPELL3") and GetDistance(myHero.Position, target.Position) <= self.eRange then
                            Engine:CastSpell("HK_SPELL3", target.Position, 1)
                        end
                    end   
                    if self.ComboUseW.Value == 1 then
                        if Engine:SpellReady("HK_SPELL2") and GetDistance(myHero.Position, target.Position) <= self.rRange then
                            Engine:CastSpell("HK_SPELL2", nil)
                        end
                    end
                    local Passive = myHero.BuffData:GetBuff("MonkeyKingSpinToWin")
                    if self.ComboUseQ.Value == 1 and not Passive.Valid then
                        if Engine:SpellReady("HK_SPELL1") and Wukong:IsWActive() then
                            local qRange = getAttackRange() + 75 + (25 * myHero:GetSpellSlot(0).Level)
                            if GetDistance(myHero.Position, target.Position) <= qRange then
                                Engine:CastSpell("HK_SPELL1", nil)
                            end
                        end
                    end
                    if self.ComboUseR.Value == 1 then
                        if GetDistance(myHero.Position, target.Position) <= self.rRange then
                            Engine:CastSpell("HK_SPELL4", nil)
                        end
                    end
                else
                    if self.ComboUseE.Value == 1 then
                        if Engine:SpellReady("HK_SPELL3") and GetDistance(myHero.Position, target.Position) <= self.eRange then
                            Engine:CastSpell("HK_SPELL3", target.Position, 1)
                        end
                    end
                    
                    local Passive = myHero.BuffData:GetBuff("MonkeyKingSpinToWin")
                    if self.ComboUseQ.Value == 1 and not Passive.Valid then
                        if Engine:SpellReady("HK_SPELL1") then 
                            local qRange = getAttackRange() + 75 + (25 * myHero:GetSpellSlot(0).Level)
                            if GetDistance(myHero.Position, target.Position) <= qRange then
                                Engine:CastSpell("HK_SPELL1", nil)
                                      
                            end
                        end
                    end         
                end          
                
            else
            
                if self.ComboUseE.Value == 1 then
                    if Engine:SpellReady("HK_SPELL3") and GetDistance(myHero.Position, target.Position) <= self.eRange then
                        Engine:CastSpell("HK_SPELL3", target.Position, 1)
                    end
                end
                
                if self.ComboUseQ.Value == 1 then
                    if Engine:SpellReady("HK_SPELL1") then 
                        local qRange = getAttackRange() + 75 + (25 * myHero:GetSpellSlot(0).Level)
                        if GetDistance(myHero.Position, target.Position) <= qRange then
                            Engine:CastSpell("HK_SPELL1", nil)
                        end
                    end         
                end
            
                if self.ComboUseR2.Value == 1 then
                    local SliderR2 = self.ComboUseR2EnemiesSlider.Value
                    local Passive = myHero.BuffData:GetBuff("monkeykingspinrecast")
                    local Passive1 = myHero.BuffData:GetBuff("MonkeyKingSpinToWin")
                    if Passive.Valid then 
                        if EnemiesInRange(myHero.Position, self.rRange) >= SliderR2 and not Passive1.Valid then
                            Engine:CastSpell("HK_SPELL4", nil)
                        end   
                    end
                end
            end
        end
    end
end

function Wukong:Harass()
    local target = Orbwalker:GetTarget("Harass", 700)
    if target then
        if self.HarassUseE.Value == 1 then
            if Engine:SpellReady("HK_SPELL3") and GetDistance(myHero.Position, target.Position) <= self.eRange then
                Engine:CastSpell("HK_SPELL3", target.Position, 1)
            end
        end
        if self.HarassUseQ.Value == 1 then
            if Engine:SpellReady("HK_SPELL1") then 
                local qRange = getAttackRange() + 75 + (25 * myHero:GetSpellSlot(0).Level)
                if GetDistance(myHero.Position, target.Postion) <= qRange then
                    Engine:CastSpell("HK_SPELL1", nil)
                end
            end
        end
    end
end

function Wukong:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Wukong:Combo()
        end
        if Engine:IsKeyDown("HK_Harass") then
            Wukong:Harass()
        end
        --myHero.BuffData:ShowAllBuffs()
        --myHero.BuffData:GetBuff("buffnamehere")
    end
end

function Wukong:OnDraw()
    if myHero.IsDead == true then return end
    local outVec = Vector3.new()
    if Render:World2Screen(myHero.Position, outVec) then
        local qRange = getAttackRange() + 75 + (25 * myHero:GetSpellSlot(0).Level)
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then 
            Render:DrawCircle(myHero.Position, qRange, 100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.eRange, 100,150,255,255)
        end
                if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.eRange, 100,150,255,255)
        end        if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
            Render:DrawCircle(myHero.Position, self.eRange, 100,150,255,255)
        end
        if Wukong:IsWActive() and self.DrawQ.Value == 1 then
            local clone = Wukong:Clone()
            
            Render:DrawCircle(clone.Position, qRange , 100,150,255,255)

        end

        if Wukong:IsWActive() and self.DrawR.Value == 1 then
            local clone = Wukong:Clone()

            Render:DrawCircle(clone.Position, self.rRange , 100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
            Render:DrawCircle(myHero.Position, self.rRange , 100,150,255,255)
        end
    end
end

function Wukong:OnLoad()
if myHero.ChampionName ~= "MonkeyKing" then return end
    AddEvent("OnSettingsSave" , function() Wukong:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Wukong:LoadSettings() end)
    Wukong:Init()
    AddEvent("OnTick", function() Wukong:OnTick() end)
    AddEvent("OnDraw", function() Wukong:OnDraw() end)
    print(self.ScriptVersion)

end

AddEvent("OnLoad", function() Wukong:OnLoad() end)