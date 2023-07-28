Zeri = {
    Init = function(self)
        self.QRange = 825
        self.QSpeed = 2600
        self.QWidth = 80
		self.QDelay = 0

        self.WRange = 1500
        self.WSpeed = 2200
        self.WWidth = 80
        --wdelay odd
        self.WDelay = 0.50

        self.ERange = 1000
        self.EDelay = 0.25
        self.ESpeed = 1400

        self.RRange = 800
        self.RDelay = 0.60
        self.UltTimer = 0

        self.QHitChance = 0.2
        self.WHitChance = 0.2

        self.Menu       = Menu:CreateMenu("Zeri") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.HarassUseQ = self.QSettings:AddCheckbox("Use Q on Harass")
        --------------------------------------------
        self.WSettings  = self.Menu:AddSubMenu("W Settings")
        self.ComboUseW  = self.WSettings:AddCheckbox("Use W on Combo")
        self.HarassUseW  = self.WSettings:AddCheckbox("Use W on Harass")
        --------------------------------------------
        self.ESettings  = self.Menu:AddSubMenu("E Settings")
        self.ComboUseE  = self.ESettings:AddCheckbox("Use E on Combo")
        --------------------------------------------
        self.RSettings  = self.Menu:AddSubMenu("R Settings")
        self.ComboUseR  = self.RSettings:AddCheckbox("Use R on Combo")
        self.RTargetsSlider = self.RSettings:AddSlider("RTargets",2, 1, 5, 1)	
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
        SettingsManager:CreateSettings("Zeri")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("WSettings")
        SettingsManager:AddSettingsInt("UseWCombo", self.ComboUseW.Value)
        SettingsManager:AddSettingsInt("UseWHarass", self.HarassUseW.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("ESettings")
        SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("RSettings")
        SettingsManager:AddSettingsInt("UseRCombo", self.ComboUseR.Value)
        SettingsManager:AddSettingsInt("RTargetsSlider", self.RTargetsSlider.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Drawings")
        SettingsManager:AddSettingsInt("DrawQ", self.QDrawings.Value)
        SettingsManager:AddSettingsInt("DrawW", self.WDrawings.Value)
        SettingsManager:AddSettingsInt("DrawE", self.EDrawings.Value)
        SettingsManager:AddSettingsInt("DrawR", self.RDrawings.Value)
    end,
    LoadSettings = function(self)
        SettingsManager:GetSettingsFile("Zeri")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.HarassUseQ.Value		= SettingsManager:GetSettingsInt("QSettings","UseQHarass")
        -------------------------------------------------------------
        self.ComboUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWCombo")
        self.HarassUseW.Value		= SettingsManager:GetSettingsInt("WSettings","UseWHarass")
        -------------------------------------------------------------
        self.ComboUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseECombo")
        -------------------------------------------------------------
        self.ComboUseR.Value		= SettingsManager:GetSettingsInt("RSettings","UseRCombo")
        self.RTargetsSlider.Value     = SettingsManager:GetSettingsInt("RSettings", "RTargetsSlider")
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
        local R = myHero.BuffData:GetBuff("ZeriR")
        if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") and R.Count_Alt == 0 then
            local Targets = Orbwalker:GetEnemyHerosInRange(myHero.Position, self.RRange)
            if #Targets >= self.RTargetsSlider.Value then
                return Engine:CastSpell("HK_SPELL4", nil, 0)
            end
        end
        if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker.ResetReady == 1 then
            local Target = Orbwalker:GetTarget("Combo", self.QRange)
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL3", Orbwalker.MovePosition ,0)
                return
            end
        end
        if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local passive = myHero.BuffData:GetBuff("zeriqpassiveready")
            if not passive.Valid then
                local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                if PredPos then
                    return Engine:CastSpell("HK_SPELL1", PredPos, 0)
                end
            end
        end
        if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
            if PredPos then
                return Engine:CastSpell("HK_SPELL2", PredPos, 0)
            end
        end
    end,
    Harass = function(self)
        if self.HarassUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos then
                return Engine:CastSpell("HK_SPELL1", PredPos, 0)
            end
        end
        if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
            if PredPos then
                return Engine:CastSpell("HK_SPELL2", PredPos, 0)
            end
        end
	end,
    OnTick = function(self)
        if GameHud.Minimized == false and GameHud.ChatOpen == false  and (Orbwalker.ResetReady == 1 or Orbwalker.Attack == 0)  then
            if Engine:IsKeyDown("HK_COMBO") then
                return self:Combo()	
            end
            if Engine:IsKeyDown("HK_HARASS") then
                return self:Harass()	
            end
        end
    end,
    OnDraw = function(self)
        --Render:DrawCircle(myHero.Position, self.QRange_Charged ,100,150,255,255)
        if Engine:SpellReady("HK_SPELL1") and self.QDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") and self.WDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.WRange ,150,255,100,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.RDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
        end
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Zeri") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Zeri:OnLoad() end)	