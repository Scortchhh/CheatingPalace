require("SupportLib")
Fiora = {
    Init = function(self)
        self.QRange = 320
        self.QSearchRange = 800
        self.WRange = 700
        self.WDelay = 0.40

        self.ERange = 250

        self.RRange = 500

        self.Menu       = Menu:CreateMenu("Fiora") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.VitalsOnly  = self.QSettings:AddCheckbox("Use Q only on Vitals")
        self.HarassUseQ  = self.QSettings:AddCheckbox("Use Q on Harass")
        --------------------------------------------
        self.WSettings  = self.Menu:AddSubMenu("W Settings")
        self.AlwaysUseW  = self.WSettings:AddCheckbox("Use W Always")
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
        SettingsManager:CreateSettings("Fiora")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
        SettingsManager:AddSettingsInt("UseQVitalsOnly", self.VitalsOnly.Value)

        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("WSettings")
        SettingsManager:AddSettingsInt("UseWAlways", self.AlwaysUseW.Value)
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
        SettingsManager:GetSettingsFile("Fiora")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.HarassUseQ.Value		= SettingsManager:GetSettingsInt("QSettings","UseQHarass")
        self.VitalsOnly.Value		= SettingsManager:GetSettingsInt("QSettings","UseQVitalsOnly")

        -------------------------------------------------------------
        self.AlwaysUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWAlways")
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
    GetVitals = function(self)
        local target = Orbwalker:GetTarget("Combo", self.QSearchRange)

        if target ~= nil then
            local Vitals = {}
            local Minions = ObjectManager.MinionList
            for _, Minion in pairs(Minions) do
                local Pos = Minion.Position
                if self:GetDistance(myHero.Position, Pos) <= self.QSearchRange then
                    if string.find(Minion.Name, "Fiora_", 1) ~= nil and string.find(Minion.Name, "SW", 1) ~= nil then --DOWN
                        Vitals[#Vitals + 1] = {}
                        Vitals[#Vitals].Object      = Minion 
                        Vitals[#Vitals].Position    = Vector3.new(Pos.x, Pos.y, Pos.z - 150) 
                    end
                    if string.find(Minion.Name, "Fiora_", 1) ~= nil and string.find(Minion.Name, "NW", 1) ~= nil then --RIGHT
                        Vitals[#Vitals + 1] = {}
                        Vitals[#Vitals].Object      = Minion 
                        Vitals[#Vitals].Position    = Vector3.new(Pos.x + 150, Pos.y, Pos.z) 
                    end
                    if string.find(Minion.Name, "Fiora_", 1) ~= nil and string.find(Minion.Name, "SE", 1) ~= nil then --LEFT
                        Vitals[#Vitals + 1] = {}
                        Vitals[#Vitals].Object      = Minion 
                        Vitals[#Vitals].Position    = Vector3.new(Pos.x - 150, Pos.y, Pos.z) 
                    end
                    if string.find(Minion.Name, "Fiora_", 1) ~= nil and string.find(Minion.Name, "NE", 1) ~= nil then --TOP
                        Vitals[#Vitals + 1] = {}
                        Vitals[#Vitals].Object      = Minion 
                        Vitals[#Vitals].Position    = Vector3.new(Pos.x , Pos.y, Pos.z + 150) 
                    end
                end
            end
            return Vitals
        end
        return {}
    end,
    GetClosestVital = function(self)
        local Closest= nil 
        local Vitals = self:GetVitals()
        for _, Vital in pairs(Vitals) do
            if Closest then
                local Dist1 = self:GetDistance(Vital.Position, myHero.Position)
                local Dist2 = self:GetDistance(Closest.Position, myHero.Position)
                if Dist1 < Dist2 then
                    Closest = Vital
                end
            else
                Closest = Vital
            end
        end
        return Closest
    end,
    WCheck = function(self)
        local Heros     = ObjectManager.HeroList
        local Missiles  = ObjectManager.MissileList
        for _, Missile in pairs(Missiles) do
            local SourceID = Missile.SourceIndex
            local TargetID = Missile.TargetIndex
            local Source   = Heros[SourceID]
            if Source and Source.IsHero and Source.Team ~= myHero.Team and Source.Team ~= 300 then
                local Radius = 120
                local StartPos, EndPos = Missile.MissileStartPos, Missile.MissileEndPos
                if Evade then
                    local Spell = Evade.Spells[Missile.Name]
                    if Spell and Spell.CC == 1 then
                        Radius              = Spell.Radius + myHero.CharData.BoundingRadius/2
                        StartPos, EndPos    = Evade:CalcLinearMissileStartEndPos(Missile, StartPos, EndPos, Evade.Spells[Missile.Name])
                        if self:GetDistance(myHero.Position, Missile.Position) <= self.WRange and Prediction:PointOnLineSegment(StartPos, EndPos, myHero.Position, Radius) then
                            return Missile
                        end            
                    end
                end
            end
        end
        for _, Hero in pairs(Heros) do
            if Hero.Team ~= myHero.Team then
                local ActiveSpell = Hero.ActiveSpell
                local ActiveName = ActiveSpell.Info.Name
                local Radius = 120
                local StartPos, EndPos = ActiveSpell.StartPos, ActiveSpell.EndPos
                if Evade then
                    local Spell = Evade.Spells[ActiveName]
                    if Spell and Spell.CC == 1 then
                        Radius              = Spell.Radius + myHero.CharData.BoundingRadius/2
                        StartPos, EndPos    = Evade:CalcLinearSpellStartEndPos(StartPos, EndPos, Spell)
                        if self:GetDistance(myHero.Position, StartPos) <= self.WRange and Prediction:PointOnLineSegment(StartPos, EndPos, myHero.Position, Radius) then
                            return Hero
                        end    
                    end
                end
            end
        end
        return nil
    end,
    GetWCastPos = function(self)
        local Check = self:WCheck()
        if Check then
            local Target = Orbwalker:GetTarget("COMBO", self.WRange)
            if Target then
                return Prediction:GetPredictionPosition(Target, myHero.Position, math.huge, self.WDelay, 0,0)
            else
                if Check.IsMissile then
                    return Check.Position
                end
                if Check.IsHero then
                    return Prediction:GetPredictionPosition(Check, myHero.Position, math.huge, self.WDelay, 0,0)
                end
            end
        end
        return nil
    end,
    GetRDamage = function(self, Target)
        local QLevel = math.max(1, myHero:GetSpellSlot(0).Level)
        local QDamagePerLevel       = {70, 80, 90, 100, 110} 
        local QDamageAddPerLevel    = {0.95, 1.00, 1.05, 1.10, 1.15}
        local QDamage               = QDamagePerLevel[QLevel] + (myHero.BonusAttack*QDamageAddPerLevel[QLevel])
        local VitalDamage = Target.MaxHealth * (0.03 + 0.055 * math.floor(myHero.BonusAttack/100))

        local TargetRDamagePercent = ((QDamage + VitalDamage)*4) / Target.MaxHealth
        return TargetRDamagePercent
    end,
    Combo = function(self, Vital)
        if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            local Target = Orbwalker:GetTarget("COMBO", self.RRange)
            if Target then
                local RDamage = self:GetRDamage(Target)
                if RDamage > 0.5 then
                    return Engine:CastSpell("HK_SPELL4", Target.Position, 0) 
                end
            end
        end
        if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local WCastPos = self:GetWCastPos()
            if WCastPos then
                return Engine:CastSpell("HK_SPELL2", WCastPos, 0) 
            end
        end
        if Vital and string.find(Vital.Object.Name, "Warning", 1) == nil then
            local Distance = self:GetDistance(Vital.Position, myHero.Position)
            if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker:GetTarget("COMBO", self.ERange) and Orbwalker.ResetReady == 1 then
                if Engine:SpellReady("HK_SPELL1") == false and Distance < 65 then
                    return Engine:CastSpell("HK_SPELL3", nil, 0) 
                else
                    return Engine:CastSpell("HK_SPELL3", nil, 0) 
                end
            end
            if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                if Distance <= self.QRange * 1.40 then
                    return Engine:CastSpell("HK_SPELL1", Vital.Position, 0) 
                end
            end
        elseif self.VitalsOnly.Value == 0 then
            if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                local Target = Orbwalker:GetTarget("COMBO", self.RRange)
                if Target then
                    local Distance = self:GetDistance(Target.Position, myHero.Position)
                    if Distance <= self.QRange * 1.75 then
                        return Engine:CastSpell("HK_SPELL1", Target.Position, 0) 
                    end
                end
            end
        end
	end,
    Harass = function(self, Vital)
		if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") and Orbwalker.Attack == 0 then
            local WCastPos = self:GetWCastPos()
            if WCastPos then
                return Engine:CastSpell("HK_SPELL2", WCastPos, 0) 
            end
        end

        if Vital and string.find(Vital.Object.Name, "Warning", 1) == nil then
            local Distance = self:GetDistance(Vital.Position, myHero.Position)
            if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker:GetTarget("COMBO", self.ERange) and Orbwalker.ResetReady == 1 then
                if Engine:SpellReady("HK_SPELL1") == false and Distance < 65 then
                    return Engine:CastSpell("HK_SPELL3", nil, 0) 
                else
                    return Engine:CastSpell("HK_SPELL3", nil, 0) 
                end
            end
            if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 then
                if Distance < self.QRange * 1.40 then
                    return Engine:CastSpell("HK_SPELL1", Vital.Position, 0) 
                end
            end
        end
	end,
    OnTick = function(self)
        if GameHud.Minimized == false and GameHud.ChatOpen == false then
            local Vital = self:GetClosestVital()
            if self.AlwaysUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
                local WCastPos = self:GetWCastPos()
                if WCastPos then
                    return Engine:CastSpell("HK_SPELL2", WCastPos, 0) 
                end
            end
    
            if Engine:IsKeyDown("HK_COMBO") then
                return self:Combo(Vital)	
            end
            if Engine:IsKeyDown("HK_HARASS") then
                return self:Harass(Vital)	
            end
        end
    end,
    OnDraw = function(self)
        local Vitals = self:GetVitals()
        for _, Vital in pairs(Vitals) do
            Render:DrawCircle(Vital.Position, 65 ,255,150,100,255)  
        end
        if Engine:SpellReady("HK_SPELL1") and self.QDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.WDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,150,255,100,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
        end
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Fiora") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Fiora:OnLoad() end)	