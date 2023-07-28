EasyScriptLib = {
    ChampionName = nil,
    QRange      = 0,
    WRange      = 0,
    ERange      = 0,
    RRange      = 0,
    QDelay      = 0,
    WDelay      = 0,
    EDelay      = 0,
    RDelay      = 0,
    QSpeed      = math.huge,
    WSpeed      = math.huge,
    ESpeed      = math.huge,
    RSpeed      = math.huge,
    QCollide    = 0,
    WCollide    = 0,
    ECollide    = 0,
    RCollide    = 0,
    ComboRotations       = {"QWE","QEW","EWQ","EQW","WQE","WEQ"},
    HarassRotations      = {"QWE","QEW","EWQ","EQW","WQE","WEQ"},
    ClearRotations       = {"QWE","QEW","EWQ","EQW","WQE","WEQ"},
    UltimateConditions   = {"Damage", "Execute", "Defence"},
    CreateChampionScript = function(self, CurrentScript)
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
        self.ChampionName   = CurrentScript
        self.ChampionMenu   = Menu:CreateMenu(self.ChampionName)
        -------------------------------------------------------------
        self.ComboMenu      = self.ChampionMenu:AddSubMenu("Combo")
        self.ComboQ         = self.ComboMenu:AddCheckbox("UseQ", 1)
        self.ComboW         = self.ComboMenu:AddCheckbox("UseW", 1)
        self.ComboE         = self.ComboMenu:AddCheckbox("UseE", 1)
        self.ComboLabel     = self.ComboMenu:AddLabel("Rotation:")
        self.ComboRotation  = self.ComboMenu:AddCombobox("Rotation", self.ComboRotations)
        self.ComboR         = self.ComboMenu:AddCheckbox("UseR", 1)
        self.ComboRLabel    = self.ComboMenu:AddLabel("Condition:")
        self.ComboRCondition= self.ComboMenu:AddCombobox("Condition", self.UltimateConditions)
        -------------------------------------------------------------
        self.HarassMenu     = self.ChampionMenu:AddSubMenu("Harass")
        self.HarassQ        = self.HarassMenu:AddCheckbox("UseQ", 1)
        self.HarassW        = self.HarassMenu:AddCheckbox("UseW", 1)
        self.HarassE        = self.HarassMenu:AddCheckbox("UseE", 1)
        self.HarassLabel    = self.HarassMenu:AddLabel("Rotation:")
        self.HarassRotation = self.HarassMenu:AddCombobox("Rotation", self.HarassRotations)
        -------------------------------------------------------------
        self.ClearMenu      = self.ChampionMenu:AddSubMenu("Clear") 
        self.ClearQ         = self.ClearMenu:AddCheckbox("UseQ", 1) 
        self.ClearW         = self.ClearMenu:AddCheckbox("UseW", 1) 
        self.ClearE         = self.ClearMenu:AddCheckbox("UseE", 1) 
        self.ClearLabel     = self.ClearMenu:AddLabel("Rotation:")
        self.ClearRotation  = self.ClearMenu:AddCombobox("Rotation", self.ClearRotations)
        -------------------------------------------------------------
        self.DrawMenu       = self.ChampionMenu:AddSubMenu("Drawings")
        self.DrawQ          = self.DrawMenu:AddCheckbox("DrawQ", 1)
        self.DrawW          = self.DrawMenu:AddCheckbox("DrawW", 1)
        self.DrawE          = self.DrawMenu:AddCheckbox("DrawE", 1)
        self.DrawR          = self.DrawMenu:AddCheckbox("DrawE", 1)
        self:LoadSettings()    
        return self
    end,
    SaveSettings = function(self)
        SettingsManager:CreateSettings(self.ChampionName)
        SettingsManager:AddSettingsGroup("Combo")
        SettingsManager:AddSettingsInt("UseQ", self.ComboQ.Value)
        SettingsManager:AddSettingsInt("UseW", self.ComboW.Value)
        SettingsManager:AddSettingsInt("UseE", self.ComboE.Value)
        SettingsManager:AddSettingsInt("UseR", self.ComboR.Value)
        SettingsManager:AddSettingsInt("Rotation", self.ComboRotation.Selected)
        SettingsManager:AddSettingsInt("RCondition", self.ComboRCondition.Selected)
        -------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Harass")
        SettingsManager:AddSettingsInt("UseQ", self.HarassQ.Value)
        SettingsManager:AddSettingsInt("UseW", self.HarassW.Value)
        SettingsManager:AddSettingsInt("UseE", self.HarassE.Value)
        SettingsManager:AddSettingsInt("Rotation", self.HarassRotation.Selected)
        -------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Clear")
        SettingsManager:AddSettingsInt("UseQ", self.ClearQ.Value)
        SettingsManager:AddSettingsInt("UseW", self.ClearW.Value)
        SettingsManager:AddSettingsInt("UseE", self.ClearE.Value)       
        SettingsManager:AddSettingsInt("Rotation", self.ClearRotation.Selected)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Drawings")
        SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
        SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
        SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
        SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
    end,
    LoadSettings = function(self)
        SettingsManager:GetSettingsFile(self.ChampionName)
        self.ComboQ.Value             = SettingsManager:GetSettingsInt("Combo","UseQ")
        self.ComboW.Value             = SettingsManager:GetSettingsInt("Combo","UseW")
        self.ComboE.Value             = SettingsManager:GetSettingsInt("Combo","UseE")
        self.ComboR.Value             = SettingsManager:GetSettingsInt("Combo","UseR")
        self.ComboRotation.Selected   = SettingsManager:GetSettingsInt("Combo","Rotation")
        self.ComboRCondition.Selected = SettingsManager:GetSettingsInt("Combo","RCondition")
        -------------------------------------------------------------
        self.HarassQ.Value            = SettingsManager:GetSettingsInt("Harass","UseQ")
        self.HarassW.Value            = SettingsManager:GetSettingsInt("Harass","UseW")
        self.HarassE.Value            = SettingsManager:GetSettingsInt("Harass","UseE")
        self.HarassRotation.Selected  = SettingsManager:GetSettingsInt("Harass","Rotation")
        -------------------------------------------------------------
        self.ClearQ.Value             = SettingsManager:GetSettingsInt("Clear","UseQ")
        self.ClearW.Value             = SettingsManager:GetSettingsInt("Clear","UseW")
        self.ClearE.Value             = SettingsManager:GetSettingsInt("Clear","UseE") 
        self.ClearRotation.Selected   = SettingsManager:GetSettingsInt("Clear","Rotation")
        -------------------------------------------------------------
        self.DrawQ.Value    = SettingsManager:GetSettingsInt("Drawings","DrawQ")
        self.DrawW.Value    = SettingsManager:GetSettingsInt("Drawings","DrawW")
        self.DrawE.Value    = SettingsManager:GetSettingsInt("Drawings","DrawE")
        self.DrawR.Value    = SettingsManager:GetSettingsInt("Drawings","DrawR")
    end,
    GetClearTarget = function(self, Range)
		local Minions = Orbwalker:SortToLowestHealth(ObjectManager.MinionList)
		for I, Minion in pairs(Minions) do
			if Minion.Team ~= myHero.Team then
				if Orbwalker:GetDistance(myHero.Position, Minion.Position) < (Range + Minion.CharData.BoundingRadius) then
					if Minion.IsTargetable and Orbwalker:IsValidMinion(Minion) and Minion.MaxHealth > 10 then
						return Minion
					end
				end
			end	
		end
        return nil
    end,
    UseQ = function(self, Mode)
        if Engine:SpellReady("HK_SPELL1") then
            if (Mode == "Combo" and self.ComboQ.Value == 1) or (Mode == "Harass" and self.HarassQ.Value == 1) then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 80, self.QDelay, self.QCollide)
                if CastPos and Target then 
                    return Engine:CastSpell("HK_SPELL1", CastPos,0)
                end
            end
            if Mode == "Clear" and self.ClearQ.Value == 1 then
                local Target = self:GetClearTarget(self.QRange)
                if Target then
                    local CastPos = Prediction:GetPredPos(myHero.Position, Target, self.QSpeed, self.QDelay)
                    if CastPos then
                        return Engine:CastSpell("HK_SPELL1", CastPos,0)
                    end
                end
            end    
        end
    end,
    UseW = function(self, Mode)
        if Engine:SpellReady("HK_SPELL2") then
            if (Mode == "Combo" and self.ComboW.Value == 1) or (Mode == "Harass" and self.HarassW.Value == 1) then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, 80, self.WDelay, self.WCollide)
                if CastPos and Target then 
                    return Engine:CastSpell("HK_SPELL2", CastPos,0)
                end
            end
            if Mode == "Clear" and self.ClearW.Value == 1 then
                local Target = self:GetClearTarget(self.WRange)
                if Target then
                    local CastPos = Prediction:GetPredPos(myHero.Position, Target, self.WSpeed, self.WDelay)
                    if CastPos then
                        return Engine:CastSpell("HK_SPELL2", CastPos,0)
                    end
                end
            end    
        end    
    end,
    UseE = function(self, Mode)
        if Engine:SpellReady("HK_SPELL3") then
            if (Mode == "Combo" and self.ComboE.Value == 1) or (Mode == "Harass" and self.HarassE.Value == 1) then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 80, self.EDelay, self.ECollide)
                if CastPos and Target then 
                    return Engine:CastSpell("HK_SPELL3", CastPos,0)
                end
            end
            if Mode == "Clear" and self.ClearE.Value == 1 then
                local Target = self:GetClearTarget(self.ERange)
                if Target then
                    local CastPos = Prediction:GetPredPos(myHero.Position, Target, self.ESpeed, self.EDelay)
                    if CastPos then
                        return Engine:CastSpell("HK_SPELL3", CastPos,0)
                    end
                end
            end    
        end      
    end,
    UseR = function(self, Condition)
        if Condition == 1 then
            if Engine:SpellReady("HK_SPELL4") then
                local CastPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 80, self.RDelay, self.RCollide)
                if CastPos and Target then 
                    Engine:CastSpell("HK_SPELL4", CastPos,0)
                end
            end         
        end
        if Condition == 2 then

        end
        if Condition == 3 then

        end
    end,
    DoRotation = function(self, Mode)
        local Rotation = -1
        if Mode == "Combo" then
            Rotation = self.ComboRotation.Selected + 1
        end
        if Mode == "Harass" then
            Rotation = self.HarassRotation.Selected + 1
        end 
        if Mode == "Clear" then
            Rotation = self.ClearRotation.Selected + 1
        end
        if Rotation == 1 then
            self:UseQ(Mode)
            self:UseW(Mode)
            self:UseE(Mode)
            return
        end
        if Rotation == 2 then
            self:UseQ(Mode)
            self:UseE(Mode)
            self:UseW(Mode)
            return
        end
        if Rotation == 3 then
            self:UseE(Mode)
            self:UseW(Mode)
            self:UseQ(Mode)
            return
        end
        if Rotation == 4 then
            self:UseE(Mode)
            self:UseQ(Mode)
            self:UseW(Mode)
            return
        end
        if Rotation == 5 then
            self:UseW(Mode)
            self:UseQ(Mode)
            self:UseE(Mode)
            return
        end
        if Rotation == 6 then
            self:UseW(Mode)
            self:UseE(Mode)
            self:UseQ(Mode)
            return
        end

    end,
    Combo = function(self)
        self:UseR(self.ComboRCondition.Selected + 1)
        self:DoRotation("Combo") 
    end,
    Harass = function(self)
        self:DoRotation("Harass") 
    end,
    Clear = function(self)
        self:DoRotation("Clear") 
    end,
    OnTick = function(self)
        if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
            if Engine:IsKeyDown("HK_COMBO") then
                self:Combo()
            end    
            if Engine:IsKeyDown("HK_HARASS") then
                self:Harass()
            end    
            if Engine:IsKeyDown("HK_LANECLEAR") then
                self:Clear()
            end    
        end
    end,
    OnDraw = function(self)
        if self.DrawQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
            Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
        end
        if self.DrawW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
            Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)            
        end
        if self.DrawE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
            Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)            
        end
        if self.DrawR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
            Render:DrawCircle(myHero.Position, self.RRange ,255,150,255,255)           
        end
    end,
    Run = function(self)
        AddEvent("OnDraw", function() self:OnDraw() end)
        AddEvent("OnTick", function() self:OnTick() end)    
    end
}