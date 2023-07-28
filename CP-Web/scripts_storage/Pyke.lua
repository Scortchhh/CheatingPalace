Pyke = {
    Init = function(self)
        self.QRange_Min 	= 400
        self.QRange_Max 	= 1050
		self.QRange_Charged = 0

		self.QDelay = 0.2
		self.QSpeed = 2000
        self.QWidth = 140

        self.ERange = 550
        self.EDelay = 0

        self.RRange = 750
        self.RDelay = 0.5
        self.RWidth = 300

        self.UltTimer = 0

        self.Menu       = Menu:CreateMenu("Pyke") 
        --------------------------------------------
        self.QSettings  = self.Menu:AddSubMenu("Q Settings")
        self.ComboUseQ  = self.QSettings:AddCheckbox("Use Q on Combo")
        self.HarassUseQ  = self.QSettings:AddCheckbox("Use Q on Harass")
        self.QHitChance = self.QSettings:AddSlider("HitChance for Q: ", 50, 0, 99, 1)
        --------------------------------------------
        self.ESettings  = self.Menu:AddSubMenu("E Settings")
        self.ComboUseE  = self.ESettings:AddCheckbox("Use E on Combo")
        --------------------------------------------
        self.RSettings  = self.Menu:AddSubMenu("R Settings")
        self.AutoUseR   = self.RSettings:AddCheckbox("Use R automatic")
        self.ComboUseR  = self.RSettings:AddCheckbox("Use R on Combo")
        self.RHitChance = self.RSettings:AddSlider("HitChance for R: ", 50, 0, 99, 1)
        self.RDelaySlider = self.RSettings:AddSlider("RDelay in case of double R", 5, 0, 10, 1)	
        --------------------------------------------
        self.DrawSettings  = self.Menu:AddSubMenu("Drawings")
        self.QDrawings     = self.DrawSettings:AddCheckbox("Draw Q Range")
        self.EDrawings     = self.DrawSettings:AddCheckbox("Draw E Range")
        self.RDrawings     = self.DrawSettings:AddCheckbox("Draw R Range")
        --------------------------------------------
        self:LoadSettings()  
    end,
    SaveSettings = function(self)
        SettingsManager:CreateSettings("Pyke")
        SettingsManager:AddSettingsGroup("QSettings")
        SettingsManager:AddSettingsInt("UseQCombo", self.ComboUseQ.Value)
        SettingsManager:AddSettingsInt("UseQHarass", self.HarassUseQ.Value)
        SettingsManager:AddSettingsInt("QHitChance", self.QHitChance.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("ESettings")
        SettingsManager:AddSettingsInt("UseECombo", self.ComboUseE.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("RSettings")
        SettingsManager:AddSettingsInt("UseRAuto", self.AutoUseR.Value)
        SettingsManager:AddSettingsInt("UseRCombo", self.ComboUseR.Value)
        SettingsManager:AddSettingsInt("RHitChance", self.RHitChance.Value)
        SettingsManager:AddSettingsInt("RDelaySlider", self.RDelaySlider.Value)
        ------------------------------------------------------------
        SettingsManager:AddSettingsGroup("Drawings")
        SettingsManager:AddSettingsInt("DrawQ", self.QDrawings.Value)
        SettingsManager:AddSettingsInt("DrawE", self.EDrawings.Value)
        SettingsManager:AddSettingsInt("DrawR", self.RDrawings.Value)
    end,
    LoadSettings = function(self)
        SettingsManager:GetSettingsFile("Pyke")
        self.ComboUseQ.Value 		= SettingsManager:GetSettingsInt("QSettings","UseQCombo")
        self.HarassUseQ.Value		= SettingsManager:GetSettingsInt("QSettings","UseQHarass")
        self.QHitChance.Value		= SettingsManager:GetSettingsInt("QSettings","QHitChance")
        -------------------------------------------------------------
        self.ComboUseE.Value		= SettingsManager:GetSettingsInt("ESettings","UseECombo")
        -------------------------------------------------------------
        self.AutoUseR.Value		    = SettingsManager:GetSettingsInt("RSettings","UseRAuto")
        self.ComboUseR.Value		= SettingsManager:GetSettingsInt("RSettings","UseRCombo")
        self.RHitChance.Value		= SettingsManager:GetSettingsInt("RSettings","RHitChance")
        self.RDelaySlider.Value     = SettingsManager:GetSettingsInt("RSettings", "RDelaySlider")

        -------------------------------------------------------------
        self.QDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
        self.EDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
        self.RDrawings.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
    end,
    GetLevel = function(self)
        local levelQ = myHero:GetSpellSlot(0).Level
        local levelW = myHero:GetSpellSlot(1).Level
        local levelE = myHero:GetSpellSlot(2).Level
        local levelR = myHero:GetSpellSlot(3).Level
        return levelQ + levelW + levelE + levelR
    end,
    GetDistance = function(self, from, to)
        return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
    end,
    IsImmune = function(self, Target)
        local ImmuneBuffs = {
            "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage", "FioraW", "PantheonE", "ChronoShift", "WillRevive", "sionpassivezombie", "rebirthready", "willrevive", "ZileanR", "gwenw_gweninsidew"
        }
        for _, BuffName in pairs(ImmuneBuffs) do
            local Buff = Target.BuffData:GetBuff(BuffName)
            if Buff.Count_Alt > 0 and Buff.Valid == true then
                return true
            end
        end
        return Target.IsInvincible
    end,
    QOnWayCheck = function(self)
        local QMissileName = "PykeQRange"
        local MissileList = ObjectManager.MissileList
        for _, Missile in pairs(MissileList) do 
           if Missile.Name == QMissileName and Missile.Team == myHero.Team and Missile.IsDead == false then
               return true
           end
        end
        return false
    end,       
    GetRDamage = function(self) 
        local Level             = math.min(18, math.max(1 , self:GetLevel()))
        local RDamagePerLevel   = {0,0,0,0,0,250,290,330,370,400,430,450,470,490,510,530,540,550}
        local RDamageRaw        = RDamagePerLevel[Level]
        return RDamageRaw + (myHero.BonusAttack * 0.8) + (myHero.ArmorPenFlat * 1.5)
    end,
	GetRCastPos = function(self)
        local CurrentSpellName = myHero.ActiveSpell.Info.Name
        local RActived = GameClock.Time - myHero:GetSpellSlot(3).StartTime
        local QActived = GameClock.Time - myHero:GetSpellSlot(0).StartTime

        if CurrentSpellName == "PykeR" or CurrentSpellName == "PykeQRange" then
            self.UltTimer = os.clock()
        end
        local Timer = os.clock() - self.UltTimer
    
        if Timer < (self.RDelaySlider.Value/10.0) or self:QOnWayCheck() or RActived < 0 or QActived < 0 then return nil end

        local RDamage = math.ceil(self:GetRDamage())
		local Targets = Prediction:GetTargetSelectorList(myHero.Position, self.RRange + 200)
		for _, Hero in pairs(Targets) do
            Render:DrawCircle(Hero.Position, 350/2, 255,0,0,255)
            if self:IsImmune(Hero) == false and --[[Prediction:SpellDodgeCheck(Hero, 0.5, 300) == false and]] Hero.Health <= RDamage then
                --Hero.BuffData:ShowAllBuffs()
                --Render:DrawCircle(Hero.Position, 140, 255,0,0,255)
                local Position = Prediction:GetPredictionPosition(Hero, myHero.Position, math.huge, self.RDelay, self.RWidth, 0, nil, self.RHitChance.Value, 0)
                local Position2 = Prediction:GetPredictionPosition(Hero, myHero.Position, math.huge, self.RDelay, 30, 0, nil, self.RHitChance.Value, 0)
                if Position then
                    local Distance = self:GetDistance(myHero.Position, Position)
                    if Distance < self.RRange then
                        return Position
                    elseif Position2 then
                        local Distance2 = self:GetDistance(myHero.Position, Position2)
                        if Distance2 < self.RRange + 200 then
                            local UR = Vector3.new(Position2.x + 200, Position2.y, Position2.z + 200)
                            local UL = Vector3.new(Position2.x + 200, Position2.y, Position2.z - 200)
                            local DR = Vector3.new(Position2.x - 200, Position2.y, Position2.z + 200)
                            local DL = Vector3.new(Position2.x - 200, Position2.y, Position2.z - 200)
                            
                            local DIFF = (Distance - self.RRange) + 20
                            local UR_N = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Position2, UR))
                            local UL_N = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Position2, UL))
                            local DR_N = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Position2, DR))
                            local DL_N = Prediction:GetVectorNormalized(Prediction:GetVectorDirection(Position2, DL))
                            
                            local UR_DIFF = Vector3.new(Position2.x + (UR_N.x*DIFF), Position2.y, Position2.z + (UR_N.z*DIFF))
                            local UL_DIFF = Vector3.new(Position2.x + (UL_N.x*DIFF), Position2.y, Position2.z + (UL_N.z*DIFF))
                            local DR_DIFF = Vector3.new(Position2.x + (DR_N.x*DIFF), Position2.y, Position2.z + (DR_N.z*DIFF))
                            local DL_DIFF = Vector3.new(Position2.x + (DL_N.x*DIFF), Position2.y, Position2.z + (DL_N.z*DIFF))

                            if self:GetDistance(myHero.Position, UR_DIFF) < self.RRange then
                                return UR_DIFF
                            end
                            if self:GetDistance(myHero.Position, UL_DIFF) < self.RRange then
                                return UL_DIFF
                            end
                            if self:GetDistance(myHero.Position, DR_DIFF) < self.RRange then
                                return DR_DIFF
                            end
                            if self:GetDistance(myHero.Position, DL_DIFF) < self.RRange then
                                return DL_DIFF
                            end                        
                        end
                    end
                end
            end
		end
		return nil
	end,
    Combo = function(self)
        local QHitChanceValue = self.QHitChance.Value / 100
        if self.QRange_Charged == 0 then
            if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange/2, math.huge, 200, self.QDelay, 0, 1, QHitChanceValue, 1)
                if PredPos then	
                    return Engine:ReleaseSpell("HK_SPELL1", PredPos)
                end    
            end
            if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") and self.AutoUseR.Value == 0 then
                local CastPos = self:GetRCastPos()
                if CastPos then
                    return Engine:ReleaseSpell("HK_SPELL4", CastPos)
                end
            end
            if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
                local PredPos = Prediction:GetCastPos(myHero.Position, self.ERange - 50, 3000, 110, self.EDelay, 0, 1, nil, 1)
                if PredPos then
                    return Engine:CastSpell("HK_SPELL3", PredPos, 0)
                end
            end
        end
        if self.ComboUseQ.Value == 1 then
			local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange_Max, self.QSpeed , self.QWidth, self.QDelay, 1, 1, QHitChanceValue, 1)
			if PredPos then	
				if self:GetDistance(myHero.Position, PredPos) < self.QRange_Charged and self.QRange_Charged > self.QRange_Min then
					return Engine:ReleaseSpell("HK_SPELL1", PredPos)
				end
				if self.QRange_Charged == 0 and Engine:SpellReady("HK_SPELL1")  then
                    self.QCast = true
                    return Engine:ChargeSpell("HK_SPELL1")	
				end	
            end
		end
	end,
    Harass = function(self)
		if self.HarassUseQ.Value == 1 then
			local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange_Max, self.QSpeed , self.QWidth, self.QDelay, 1, 1, self.QHitChance.Value, 1)
			if PredPos then	
				if self.QRange_Charged > 0 and self:GetDistance(myHero.Position, PredPos) < self.QRange_Charged then
					return Engine:ReleaseSpell("HK_SPELL1", PredPos)
				end
				if self.QRange_Charged == 0 and Engine:SpellReady("HK_SPELL1") then
                    self.QCast = true
					return Engine:ChargeSpell("HK_SPELL1")	
				end	
			end
		end
    end,
    SetRanges = function(self)
		local QStartTime =  myHero:GetSpellSlot(0).StartTime
		if QStartTime > 0 then
			self.QRange_Charged = math.min(self.QRange_Max + 200, self.QRange_Min + (math.max(0, (GameClock.Time - QStartTime) - 0.4) * 666)) - 200
		else
            self.QCast          = false
            self.QRange_Charged = 0
		end
		if Engine:IsKeyDown("HK_SPELL1") == true and Engine:SpellReady("HK_SPELL1") == false and QStartTime == 0 then
            self.QCast = false
			return Engine:ReleaseSpell("HK_SPELL1", nil)
		end	
    end,
    OnTick = function(self)
        --myHero.BuffData:ShowAllBuffs()
        --print(myHero.ActiveSpell.Info.Name)PykeQRange
        if GameHud.Minimized == false and GameHud.ChatOpen == false then
            self:SetRanges()
            if self.AutoUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
                local CastPos = self:GetRCastPos()
                if CastPos then
                    return Engine:ReleaseSpell("HK_SPELL4", CastPos)
                end    
            end

            if Engine:IsKeyDown("HK_COMBO") then
                return self:Combo()	
            end
            if Engine:IsKeyDown("HK_HARASS") then
                return self:Harass()	
            end
        end
    end,
    OnDraw = function(self)
        if Engine:SpellReady("HK_SPELL1") and self.QDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.QRange_Max ,100,150,255,255)
        end
        if Engine:SpellReady("HK_SPELL2") then
            Render:DrawCircle(myHero.Position, 1500 ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL3") and self.EDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.ERange ,255,150,0,255)
        end
        if Engine:SpellReady("HK_SPELL4") and self.RDrawings.Value == 1 then
            Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
        end
    end,
    OnLoad = function(self)
        if(myHero.ChampionName ~= "Pyke") then return end
        AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
        AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

        self:Init()
        AddEvent("OnTick", function() self:OnTick() end)	
        AddEvent("OnDraw", function() self:OnDraw() end)
    end
}

AddEvent("OnLoad", function() Pyke:OnLoad() end)	