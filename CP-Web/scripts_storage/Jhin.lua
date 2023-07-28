Jhin = {
    Init = function(self)
		self.QRange = 600
		self.QDelay = 0.40

        self.WRange = 2500
        self.WDelay = 0.75
        self.WWidth = 90
        self.WSpeed = math.huge

        self.ERange = 750
        self.ESpeed = math.huge
        self.EDelay = 1.25
        self.EWidth = 160

        self.RRange = 3500
        self.RWidth = 160
        self.RDelay = 1
        self.RSpeed = 5000

        self.WHitChance = 0.2
        self.EHitChance = 0.2
        self.RHitChance = 0.2

        self.Menu       = Menu:CreateMenu("Jhin") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.ClearUseQ  = self.QSettings:AddCheckbox("Use Q on Clear")
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
        SettingsManager:CreateSettings("Jhin")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQClear", self.ClearUseQ.Value)
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
        SettingsManager:GetSettingsFile("Jhin")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.ClearUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQClear")
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
	--[[GetRCastPos = function(self)
		local Targets = Orbwalker:GetTargetSelectorList(GameHud.MousePos, 500)
		for _, Hero in pairs(Targets) do
            local PredPos = Prediction:GetPredictionPosition(Hero, myHero.Position, math.huge, self.RDelay, 0, 0)
            if PredPos and self:GetDistance(PredPos, myHero.Position) < self.RRange then
                return PredPos
            end
        end
		return nil
	end,
    --jhinespotteddebuff
    GetWCastPos = function(self)
        local Targets = Orbwalker:GetTargetSelectorList(myHero.Position, self.WRange)
		for _, Hero in pairs(Targets) do
            if Hero.BuffData:GetBuff("jhinespotteddebuff").Count_Alt > 0 then
                local PredPos = Prediction:GetPredictionPosition(Hero, myHero.Position, math.huge, self.WDelay, 0, 0)
                if PredPos and self:GetDistance(PredPos, myHero.Position) < self.WRange then
                    return PredPos
                end
            end
		end
		return nil   
    end,]]
    Combo = function(self)
        local RStartTime =  myHero:GetSpellSlot(3).StartTime
        if RStartTime > 0 then
            local CastPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
            if CastPos and self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
                return Engine:ReleaseSpell("HK_SPELL4", CastPos)
            end		
            return
        end
        if myHero.Ammo == 0 or (Orbwalker.Attack == 0 and string.len(myHero.ActiveSpell.Info.Name) == 0) then
            if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
                -- local CastPos = self:GetWCastPos()
                -- local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, 0.35, 1)
                -- if CastPos and (Orbwalker:GetTarget("COMBO", self.ERange + 50) == nil or myHero.Ammo == 0) then
                --     return Engine:CastSpell("HK_SPELL2", CastPos, 0)
                -- end
                local target = Orbwalker:GetTarget("Combo", self.WRange)
                if target then
                    local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                    if CastPos and target.BuffData:GetBuff("jhinespotteddebuff").Valid then
                        return Engine:CastSpell("HK_SPELL2", CastPos, 1)
                    end
                end
            end
            if Orbwalker:CanAttack() == false then
                if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
                    local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 0)
                    if PredPos then
                        return Engine:CastSpell("HK_SPELL3", PredPos, 0)
                    end
                end    
                if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                    local Target = Orbwalker:GetTarget("COMBO", self.QRange)
                    if Target then
                        return Engine:CastSpell("HK_SPELL1", Target.Position, 1)
                    end
                end
            end
        end
	end,
    Harass = function(self)
        if (Orbwalker.ResetReady == 1 or myHero.Ammo == 0) or (Orbwalker.Attack == 0 and string.len(myHero.ActiveSpell.Info.Name) == 0) then
            if self.ClearUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and myHero.Ammo == 0 then
                local Target = self:GetQClearTarget()
                if Target then
                    return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                end
            end
            if self.HarassUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") and Orbwalker:CanAttack() == false then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange, math.huge, 0, self.EDelay, 0, true, self.EHitChance, 0)
                if PredPos then
                    return Engine:CastSpell("HK_SPELL3", PredPos, 0)
                end
            end
            if self.HarassUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
                if CastPos then
                    return Engine:CastSpell("HK_SPELL2", CastPos, 0)
                end
            end
        end
	end,
    GetQClearTarget = function(self)
        local QLevel = math.min(5, math.max(1, myHero:GetSpellSlot(0).Level))
        local QADRatio = {0.35, 0.425, 0.50, 0.575, 0.65}
        local QDamagePerLevel = {45, 70, 95, 120, 145}

        local AP = myHero.AbilityPower
        local AD = myHero.BaseAttack + myHero.BonusAttack
        local QDamage = QDamagePerLevel[QLevel] + (AD * QADRatio[QLevel]) + (AP * 0.6)

        local Minions = Orbwalker:SortList(Orbwalker:GetEnemyMinionsInRange(myHero.Position, self.QRange), "LOWHP")
        for _, Minion in pairs(Minions) do
            if Minion.MaxHealth > 10 and Orbwalker:IsValidMinion(Minion) then
                if Minion.Team == 300 then
                    return Minion
                else
                    local DamageOnMinion = (QDamage * (100/(100+Minion.Armor)))
                    if DamageOnMinion > Minion.Health then
                        return Minion
                    end
                end    
            end
        end
        return nil
    end,
    Laneclear = function(self)
        if (Orbwalker.ResetReady == 1 or myHero.Ammo == 0) or (Orbwalker.Attack == 0 and string.len(myHero.ActiveSpell.Info.Name) == 0) then
            if self.ClearUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker:CanAttack() == false then
                local Target = self:GetQClearTarget()
                if Target then
                    return Engine:CastSpell("HK_SPELL1", Target.Position, 0)
                end
            end
        end
    end,
    OnTick = function(self)
        if GameHud.Minimized == false and GameHud.ChatOpen == false then
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
        if Engine:SpellReady("HK_SPELL4") then
            if self.RDrawings.Value == 1  then
                Render:DrawCircleMap(myHero.Position, self.RRange ,255,0,0,255)
                Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
            end
        end

		local RStartTime = myHero:GetSpellSlot(3).StartTime
		if RStartTime > 0 then
			Orbwalker:Disable()
			local MousePos = GameHud.MousePos
			Render:DrawCircle(MousePos,500,255,255,255,255)
			return
		end
		Orbwalker:Enable()	
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Jhin") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Jhin:OnLoad() end)	