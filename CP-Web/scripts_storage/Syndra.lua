Syndra = {
    Init = function(self)
        self.QRange = 800
		self.QSpeed = math.huge
		self.QDelay = 0.50

        self.WRange = 920
        self.WDelay = 0.35

        self.ERange = 650
        self.EDelay = 0.25
        self.ESpeed = 2000

        self.RRange = 750

        self.QHitChance = 0.2
        self.WHitChance = 0.2
        self.EHitChance = 0.2

        self.Menu       = Menu:CreateMenu("Syndra") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.ComboUseQLong  = self.QSettings:AddCheckbox("Use QLong on Combo(only with E)")
        self.HarassUseQ  = self.QSettings:AddCheckbox("Use Q on Harass")
        --------------------------------------------
        self.WSettings  = self.Menu:AddSubMenu("W Settings")
        self.ComboUseW  = self.WSettings:AddCheckbox("Use W on Combo")
        self.HarassUseW  = self.WSettings:AddCheckbox("Use W on Harass")
        --------------------------------------------
        self.ESettings  = self.Menu:AddSubMenu("E Settings")
        self.ComboUseE  = self.ESettings:AddCheckbox("Use E on Combo")
        self.HarassUseE = self.ESettings:AddCheckbox("Use E on Harass")
        --------------------------------------------
        self.RSettings  = self.Menu:AddSubMenu("R Settings")
        self.ComboUseR  = self.RSettings:AddCheckbox("Use R on Combo")
        --------------------------------------------
        self.DrawSettings  = self.Menu:AddSubMenu("Drawings")
        self.QDrawings     = self.DrawSettings:AddCheckbox("Draw Q Range")
        self.WDrawings     = self.DrawSettings:AddCheckbox("Draw W Range")
        self.EDrawings     = self.DrawSettings:AddCheckbox("Draw E Range")
        self.RDrawings     = self.DrawSettings:AddCheckbox("Draw R Range")
        --------------------------------------------
        self:LoadSettings()  
    end,
    SaveSettings = function(self)
        SettingsManager:CreateSettings("Syndra")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQComboLong", self.ComboUseQLong.Value)
        SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("WSettings")
        SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
        SettingsManager:AddSettingsInt("UseWHarass", self.HarassUseW.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("ESettings")
        SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
        SettingsManager:AddSettingsInt("UseEHarass", self.HarassUseE.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("RSettings")
        SettingsManager:AddSettingsInt("UseRCombo", self.ComboUseR.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Drawings")
        SettingsManager:AddSettingsInt("DrawQ", self.QDrawings.Value)
        SettingsManager:AddSettingsInt("DrawW", self.WDrawings.Value)
        SettingsManager:AddSettingsInt("DrawE", self.EDrawings.Value)
        SettingsManager:AddSettingsInt("DrawR", self.RDrawings.Value)
    end,
    LoadSettings = function(self)
        SettingsManager:GetSettingsFile("Syndra")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.ComboUseQLong.Value    = SettingsManager:GetSettingsInt("QSettings","UseQComboLong")
        self.HarassUseQ.Value		= SettingsManager:GetSettingsInt("QSettings","UseQHarass")
        -------------------------------------------------------------
        self.ComboUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWCombo")
        self.HarassUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWHarass")
        -------------------------------------------------------------
        self.ComboUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseECombo")
        self.HarassUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseEHarass")
        -------------------------------------------------------------
        self.ComboUseR.Value		= SettingsManager:GetSettingsInt("RSettings","UseRCombo")
        -------------------------------------------------------------
        self.QDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
        self.WDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
        self.EDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
        self.RDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
    end,
    GetDistance = function(self, from, to)
        return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
    end,
    GetBalls = function(self)
        local Balls = {}
        local Minions = ObjectManager.MinionList
        for _, Minion in pairs(Minions) do
            if Minion.CharacterState ~= 168567810 and Minion.Team == myHero.Team and (Minion.ChampionName == "SyndraSphere" or Minion.ChampionName == "TestCubeRender10Vision") and Minion.IsDead == false then   
                Balls[#Balls+1] = Minion
            end
        end
        return Balls
    end,
    GetECastPos = function(self)
        for _, Ball in pairs(self.Balls) do
            local Distance  = self:GetDistance(Ball.Position, myHero.Position)
            if Distance < self.QRange then
                local Range     = 1200 - Distance
                local PredPos   = Prediction:GetCastPos(Ball.Position, Range, self.ESpeed, 80, self.EDelay, 0, true, self.EHitChance, 1)
                if PredPos and Prediction:PointOnLineSegment(myHero.Position, PredPos, Ball.Position, 100) then
                    return Ball.Position
                end
            end
        end
        return nil
    end,
    GetWGrabTarget = function(self)
        for _, Ball in pairs(self.Balls) do
            local Distance  = self:GetDistance(Ball.Position, myHero.Position)
            if Distance < self.WRange then
                return Ball
            end
        end

        local Minions = ObjectManager.MinionList
        for _, Minion in pairs(Minions) do
            if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.MaxHealth < 3000 then
                local Distance  = self:GetDistance(Minion.Position, myHero.Position)
                if Distance < self.WRange then
                    return Minion
                end
            end
        end
        return nil
    end,
    GetLongQPosition = function(self)
        local PlayerPos = myHero.Position
        local PredPos   = Prediction:GetCastPos(PlayerPos, 1200, self.ESpeed, 100, self.EDelay, 0, true, self.QHitChance, 0)
        if PredPos then
            local Norm = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(PredPos, PlayerPos))
            return Vector3.new(PlayerPos.x +(Norm.x * self.QRange), PlayerPos.y, PlayerPos.z + (Norm.z * self.QRange))
        end
        return nil
    end,
    GetRDamage = function(self, Target)
        local RLevel                = math.max(1, myHero:GetSpellSlot(3).Level)
        local DmgPerBallPerLevel    = {90, 140, 190}
        local DmgPerBall            = DmgPerBallPerLevel[RLevel]
        local Balls                 = 3 + #self.Balls --minumum 3 spheres flying around syndra
        local RDamageRaw            = Balls * DmgPerBall

        local AP_Reduction = 100 / (100+Target.MagicResist)
        local AP = RDamageRaw * AP_Reduction
        local TotalDamage = math.max(0, math.max(0, AP - Target.MagicalShield) - Target.Shield) 
        return TotalDamage
    end,
    Ultimate = function(self)
        local Target = Orbwalker:GetTarget("COMBO", self.RRange)
        if Target then
            local RDamage = self:GetRDamage(Target)
            if RDamage > Target.Health and Engine:SpellReady("HK_SPELL4") then
                return Engine:CastSpell("HK_SPELL4", Target.Position, 1)
            end
        end
    end,
    Combo = function(self)
        if self.ComboUseR.Value == 1 then
            self:Ultimate()
        end
        if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local PredPos = self:GetECastPos()
            if PredPos then
                return Engine:CastSpell("HK_SPELL3", PredPos, 0)
            end
        end
        if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 100, self.QDelay, 1, true, self.QHitChance, 0)
            if PredPos then
                return Engine:CastSpell("HK_SPELL1", PredPos, 0)
            else
                if self.ComboUseQLong.Value == 1 and self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
                    local LongQPosition = self:GetLongQPosition()
                    if LongQPosition then
                        return Engine:CastSpell("HK_SPELL1", LongQPosition, 0)
                    end
                end
            end
        end
        if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, math.huge, 100, self.WDelay, 0, true, self.WHitChance, 0)
            if PredPos then
                local WSlot = myHero:GetSpellSlot(1)
                if WSlot.Info.Name == "SyndraWCast" then --something is grabed
                    return Engine:CastSpell("HK_SPELL2", PredPos, 0)
                else
                    local GrabTarget = self:GetWGrabTarget()
                    if GrabTarget then
                        return Engine:CastSpell("HK_SPELL2", GrabTarget.Position, 0)
                    end
                end
            end
        end
	end,
    Harass = function(self)
        if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 100, self.QDelay, 1, true, self.QHitChance, 0)
            if PredPos then
                return Engine:CastSpell("HK_SPELL1", PredPos, 0)
            end
        end
        if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, math.huge, 0, self.WDelay, 0, true, self.WHitChance, 0)
            if PredPos then
                local WSlot = myHero:GetSpellSlot(1)
                if WSlot.Info.Name == "SyndraWCast" then --something is grabed
                    return Engine:CastSpell("HK_SPELL2", PredPos, 0)
                else
                    local GrabTarget = self:GetWGrabTarget()
                    if GrabTarget then
                        return Engine:CastSpell("HK_SPELL2", GrabTarget.Position, 0)
                    end
                end
            end
        end
        if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            local PredPos = self:GetECastPos()
            if PredPos then
                return Engine:CastSpell("HK_SPELL3", PredPos, 0)
            end
        end
    end,
    OnTick = function(self)
        if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
            if Engine:IsKeyDown("HK_COMBO") then
                return self:Combo()	
            end
            if Engine:IsKeyDown("HK_HARASS") then
                return self:Harass()	
            end
        end
    end,
    OnDraw = function(self)
        self.Balls = self:GetBalls()
        for _,Ball in pairs(self.Balls) do
            Render:DrawCircle(Ball.Position, 50 ,100,150,255,255)         
        end
        --Render:DrawCircle(myHero.Position, self.QRange_Charged ,100,150,255,255)
        if Engine:SpellReady("HK_SPELL1") and self.QDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.WDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,150,255,100,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
            Render:DrawCircle(myHero.Position, 1200 ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.RDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
        end
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Syndra") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Syndra:OnLoad() end)	