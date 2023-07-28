-- made by MrWong, credits to scortch and Christoph
Ivern = {
    rRange = 450,
    eRange = 750,
    qRange = 1100,
    wRange = 1000,

    qDelay = 0.25,
    qSpeed = 1300,
    qRadius = 380
}

function Ivern:Init() 
    self.ChampionMenu = Menu:CreateMenu("Ivern")
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ Combo", 1)
   -- self.ComboUseW = self.ComboMenu:AddCheckbox("UseW Combo", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE Combo", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR Combo", 1)
    
 --   self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass")
  --  self.HarassUseQ = self.HarassMenu:AddCheckbox("UseQ Harass", 1)
  --  self.HarassUseE = self.HarassMenu:AddCheckbox("UseE Harass", 1)
    
            
    self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    Ivern:LoadSettings()
end

 function Ivern:SaveSettings()
    SettingsManager:CreateSettings("Ivern")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ Combo", self.ComboUseQ.Value)
    --SettingsManager:AddSettingsInt("UseW Combo", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE Combo", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("UseR Combo", self.ComboUseR.Value)

    
    --SettingsManager:AddSettingsGroup("Harass")
    --SettingsManager:AddSettingsInt("UseQ Harass", self.HarassUseQ.Value)
    --SettingsManager:AddSettingsInt("UseE Harass", self.HarassUseE.Value)
    
    
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
end

function Ivern:LoadSettings()
    SettingsManager:GetSettingsFile("Ivern")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo", "UseQ Combo")
    --self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo", "UseW Combo")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo", "UseE Combo")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo", "UseR Combo")

    
    
--    self.HarassUseQ.Value = SettingsManager:GetSettingsInt("Harass", "UseQ Harass")
--    self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass", "UseQ Harass")
    
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Draw", "DrawQ")
    self.DrawW.Value =  SettingsManager:GetSettingsInt("Draw", "DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Draw", "DrawE")
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


function Ivern:GetEFriendTarget(Range)
    local HeroList = ObjectManager.HeroList
	for I,Hero in pairs(HeroList) do	
		if Hero.Team == myHero.Team and Hero.IsTargetable then
			if GetDistance(myHero.Position, Hero.Position) < self.eRange then
				local EnemyCount = EnemiesInRange(Hero.Position, 280)
				if EnemyCount > 0 then
					return Hero	
				end
			end
		end
    end
    return nil
end

function Ivern:GetDaisyE(Range)
    local MinionList = ObjectManager.MinionList
	for I,Minion in pairs(MinionList) do	
		if Minion.Team == myHero.Team and Minion.Name == "IvernMinion" then
			if GetDistance(myHero.Position, Minion.Position) < self.eRange then
				local EnemyCount = EnemiesInRange(Minion.Position, 280)
				if EnemyCount > 0 then
					return Minion
				end
			end
		end
    end
    return nil
end

function Daisy()
    for index, Minion in pairs(ObjectManager.MinionList) do
        if Minion == "IvernMinion" then
            return Minion
        end
    end
    return false
end

function Ivern:Combo()
    local target = Orbwalker:GetTarget("Combo", 1100)
    if target then
        if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            if GetDistance(myHero.Position, target.Position) <= self.rRange then
                Engine:CastSpell("HK_SPELL4", target.Position)
                return
            end
            
            if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
                local Daisy = Ivern:GetDaisyE(self.eRange)
                if Daisy and GetDistance(Daisy.Position, myHero.Position) <= self.eRange then  
                    Engine:CastSpell("HK_SPELL3", Daisy.Position)
                    return
                end
            end     
            if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                local StartPos = myHero.Position
                local CastPos = Prediction:GetCastPos(StartPos, self.qRange, self.qSpeed, 150, self.qDelay, 1)
                if CastPos ~= nil then
                    if GetDistance(StartPos, CastPos) <= self.qRange then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                        return
                    end
                end
            end       
                  
                
        else
            if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
                local EFriend = Ivern:GetEFriendTarget(self.eRange)
                if EFriend and GetDistance(EFriend.Position, myHero.Position) <= self.eRange then  
                    Engine:CastSpell("HK_SPELL3", EFriend.Position)
                    return
                end
            end   
            if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                local StartPos = myHero.Position
                local CastPos = Prediction:GetCastPos(StartPos, self.qRange, self.qSpeed, 150, self.qDelay, 1)
                if CastPos ~= nil then
                    if GetDistance(StartPos, CastPos) <= self.qRange then
                        Engine:CastSpell("HK_SPELL1", CastPos, 1)
                        return
                        
                    end
                end
            end
        end
    end
end




function Ivern:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            Ivern:Combo()
        end
      --  if Engine:IsKeyDown("HK_Harass") then
     --       Ivern:Harass()
    --    end
        --myHero.BuffData:ShowAllBuffs()
        --myHero.BuffData:GetBuff("buffnamehere")
    end
end

function Ivern:OnDraw()
    if myHero.IsDead == true then return end
    local outVec = Vector3.new()
    if Render:World2Screen(myHero.Position, outVec) then
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then 
           Render:DrawCircle(myHero.Position, self.qRange, 100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
           Render:DrawCircle(myHero.Position, self.eRange, 100,150,255,255)
        end      
        if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
            Render:DrawCircle(myHero.Position, self.wRange , 100,150,255,255)
        end
    end
end


function Ivern:OnLoad()
if myHero.ChampionName ~= "Ivern" then return end
    AddEvent("OnSettingsSave" , function() Ivern:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Ivern:LoadSettings() end)
    Ivern:Init()
    AddEvent("OnTick", function() Ivern:OnTick() end)
    AddEvent("OnDraw", function() Ivern:OnDraw() end)
    print(myHero.ChampionName)
    -- IvernMinion is Daisy's Name

end

AddEvent("OnLoad", function() Ivern:OnLoad() end)