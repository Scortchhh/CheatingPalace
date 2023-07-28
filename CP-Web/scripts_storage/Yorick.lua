Yorick = {
    Init = function(self)
        self.QRange = 290

        self.WRange = 600
        self.WSpeed = math.huge
        self.WDelay = 0.75
        self.WWidth = 200

        self.ERange = 700
        self.ESpeed = math.huge
        self.EWidth = 80
        self.EDelay = 0.33

        self.RRange = 600

        self.WHitChance = 0.2
        self.EHitChance = 0.2

        self.Menu       = Menu:CreateMenu("Yorick") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.HarassUseQ = self.QSettings:AddCheckbox("Use Q on Harass")
        self.ClearUseQ  = self.QSettings:AddCheckbox("Use Q on Clear")
        --------------------------------------------
        self.WSettings  = self.Menu:AddSubMenu("W Settings")
        self.ComboUseW  = self.WSettings:AddCheckbox("Use W on Combo")
        --------------------------------------------
        self.ESettings  = self.Menu:AddSubMenu("E Settings")
        self.ComboUseE  = self.ESettings:AddCheckbox("Use E on Combo")
        self.HarassUseE = self.ESettings:AddCheckbox("Use E on Harass")
        self.CHarassUseE = self.ESettings:AddCheckbox("Use E on Clear to Harass")
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
        SettingsManager:CreateSettings("Yorick")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
        SettingsManager:AddSettingsInt("UseQClear", self.ClearUseQ.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("WSettings")
        SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
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
        SettingsManager:GetSettingsFile("Yorick")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.HarassUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQHarass")
        self.ClearUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQClear")
        -------------------------------------------------------------
        self.ComboUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWCombo")
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
    Combo = function(self)
        if Engine:SpellReady("HK_SPELL1") and self.ComboUseQ.Value == 1 and Orbwalker.ResetReady == 1 then
            if Orbwalker:GetTarget("COMBO", self.QRange) then
                return Engine:CastSpell("HK_SPELL1", nil, 0)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.ComboUseE.Value == 1 and Orbwalker.Attack == 0  then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position , self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if CastPos then
                return Engine:CastSpell("HK_SPELL3", CastPos, 0)        
            end
        end
         if Engine:SpellReady("HK_SPELL2") and self.ComboUseW.Value == 1 and Orbwalker.Attack == 0 then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position , self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 0)
            if CastPos then
                return Engine:CastSpell("HK_SPELL2", CastPos, 0)        
            end
        end
        if Engine:SpellReady("HK_SPELL4") and self.ComboUseR.Value == 1 and Orbwalker.Attack == 0 then
            local Target = Orbwalker:GetTarget("COMBO", self.RRange)
            if Target and (Target.Health/Target.MaxHealth) < 0.5 then
                return Engine:CastSpell("HK_SPELL4", Target.Position, 0)        
            end
        end
    end,
    Harass = function(self)
        if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 and Orbwalker.ResetReady == 1 then
            if Orbwalker:GetTarget("COMBO", self.QRange) then
                return Engine:CastSpell("HK_SPELL1", nil, 0)
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.HarassUseE.Value == 1 and Orbwalker.Attack == 0 then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position , self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if CastPos then
                return Engine:CastSpell("HK_SPELL3", CastPos, 0)        
            end
        end
    end,
    Laneclear = function(self)
        if Engine:SpellReady("HK_SPELL1") and self.HarassUseQ.Value == 1 and (Orbwalker.ResetReady == 1 or (Orbwalker:CanAttack() == false and Orbwalker.Attack == 0)) then
            local Target = Orbwalker:GetTarget("LANECLEAR", self.QRange)
            if Target then
                if Target.IsMinion and Target.MaxHealth > 10 then
                    if Target.Team == 300 then
                        return Engine:CastSpell("HK_SPELL1", nil, 0)          
                    else
                        local QDamagePerLevel = {30, 55, 80, 105, 130}
                        local QDamageRaw = QDamagePerLevel[math.max(1, math.min(5, myHero:GetSpellSlot(0).Level))]
                        local QDamage = (QDamageRaw + (0.4 * (myHero.BaseAttack + myHero.BonusAttack))) * (100 / (100+Target.Armor))
                        if QDamage > Target.Health then
                            return Engine:CastSpell("HK_SPELL1", nil, 0)
                        end
                    end
                else         
                    return Engine:CastSpell("HK_SPELL1", nil, 0)
                end
            end
        end
        if Engine:SpellReady("HK_SPELL3") and self.CHarassUseE.Value == 1 and Orbwalker.Attack == 0 then
            local CastPos, Target = Prediction:GetCastPos(myHero.Position , self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
            if CastPos then
                return Engine:CastSpell("HK_SPELL3", CastPos, 0)        
            end
        end
    end,
    SetRanges = function(self)
        self.QRange = Orbwalker.OrbRange + 50
    end,
    OnTick = function(self)
        --myHero.BuffData:ShowAllBuffs()
        --print(myHero.Position.x,",",myHero.Position.y,",",myHero.Position.z)
        --print(myHero.ActiveSpell.Info.Name)
        if GameHud.Minimized == false and GameHud.ChatOpen == false then
            self:SetRanges()
            if Engine:IsKeyDown("HK_COMBO") then
                return self:Combo()	
            end
            if Engine:IsKeyDown("HK_HARASS") then
                return self:Harass()	
            end
            if Engine:IsKeyDown("HK_LANECLEAR") then
                return self:Laneclear()	
            end
        end
    end,
    OnDraw = function(self)
        if Engine:SpellReady("HK_SPELL1") and self.QDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.WDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange+10 ,150,255,100,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL4") then
            if self.RDrawings.Value == 1  then
                Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
            end
        end
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Yorick") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Yorick:OnLoad() end)	
