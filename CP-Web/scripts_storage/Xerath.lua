local Xerath = {

    QDrawingMode = {
        "None",
        "Min and Max",
        "Max",
    },

    RDrawingMode = {
        "None",
        "Minimap",
        "Screen",
        "Both",
    },

    AutoTrinket = {
        "Off",
        "Only in Combat Mode",
        "Always",
    },

    WHarassMode = {
        "Off",
        "Only when Manaflow Band ready to stack",
        "On",
    },
}

function Xerath:__init()

    self.SavePredPos = {}

    self.QRangeMin 	= 735
    self.QRangeMax 	= 1450
    self.QWidth = 140   
    self.QDelay = 0.5

    self.WRange = 1000
    self.WDelayFull = 0.75 -- Cast + Time2DMG
    self.WDelayCast = 0.25
    self.WWidthMax = 275 -- Centered Full Range
    self.WWidthDMG = 125 -- Centered Full Damage

    self.ERange = 1125 -- Centered
    self.EDelay = 0.25
    self.ESpeed = 1400
    self.EWidth = 120

    self.RRange = 5000
    self.RWidth = 200
    self.RDelay = 0.6

    self.XerathMenu = Menu:CreateMenu("Xerath")

    self.XerathCombo = self.XerathMenu:AddSubMenu("Combo")
    self.UseQCombo   = self.XerathCombo:AddCheckbox("Use Q", 1)
    self.UseWCombo   = self.XerathCombo:AddCheckbox("Use W", 1)
    self.UseECombo   = self.XerathCombo:AddCheckbox("Use E", 1)
    self.UseRCombo   = self.XerathCombo:AddCheckbox("Use R", 1)

    self.HarassMenu = self.XerathMenu:AddSubMenu("Harass")
    self.Label3     = self.HarassMenu:AddLabel("W Harass Mode")
    self.HarassUseW = self.HarassMenu:AddCombobox("Harass1", Xerath.WHarassMode)
    self.HarassUseE = self.HarassMenu:AddCheckbox("UseE in harass", 1)

    self.MiscMenu    = self.XerathMenu:AddSubMenu("Misc")
    self.Label4      = self.MiscMenu:AddLabel("Auto Blue Trinket During Ultimate")
    self.MiscTrinket = self.MiscMenu:AddCombobox("Misc1", Xerath.AutoTrinket)
    self.MiscEDash   = self.MiscMenu:AddCheckbox("Auto E at Dashes", 1)
    self.MiscECC     = self.MiscMenu:AddCheckbox("Auto E at CC", 1)


    self.XerathDrawings = self.XerathMenu:AddSubMenu("Drawings")
    self.Label1         = self.XerathDrawings:AddLabel("Draw Q Mode")
    self.DrawQMode      = self.XerathDrawings:AddCombobox("Drawings1", Xerath.QDrawingMode)
    self.DrawW          = self.XerathDrawings:AddCheckbox("Draw W", 1)
    self.DrawE          = self.XerathDrawings:AddCheckbox("Draw E", 1)
    self.Label2         = self.XerathDrawings:AddLabel("Draw R Mode")
    self.DrawRMode      = self.XerathDrawings:AddCombobox("Drawings2", Xerath.RDrawingMode)
    self.DrawRAlert     = self.XerathDrawings:AddCheckbox("Draw R Alert", 1)
	self.DrawRAlert_X	= self.XerathDrawings:AddSlider("X for R alerter", 0,0,4000,1)
	self.DrawRAlert_Y	= self.XerathDrawings:AddSlider("Y for R alerter", 0,0,4000,1)

    Xerath:LoadSettings()
end

function Xerath:SaveSettings()
	SettingsManager:CreateSettings("Xerath")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("Use Q", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("Use W", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("Use E", self.UseECombo.Value)
    SettingsManager:AddSettingsInt("Use R", self.UseRCombo.Value)
	-------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseW in harass", self.HarassUseW.Selected)
	SettingsManager:AddSettingsInt("UseE in harass", self.HarassUseE.Value)
   	-------------------------------------------
    SettingsManager:AddSettingsGroup("Misc")
    SettingsManager:AddSettingsInt("Auto Trinket", self.MiscTrinket.Selected)
    SettingsManager:AddSettingsInt("Auto E at Dashes", self.MiscEDash.Value)
    SettingsManager:AddSettingsInt("Auto E at CC", self.MiscECC.Value)
   	-------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q Mode", self.DrawQMode.Selected)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw E", self.DrawE.Value)
    SettingsManager:AddSettingsInt("Draw R Mode", self.DrawRMode.Selected)
    SettingsManager:AddSettingsInt("Draw R Alert", self.DrawRAlert.Value)
	SettingsManager:AddSettingsInt("DrawRAlert_X", self.DrawRAlert_X.Value)
	SettingsManager:AddSettingsInt("DrawRAlert_Y", self.DrawRAlert_Y.Value)

end

function Xerath:LoadSettings()
	SettingsManager:GetSettingsFile("Xerath")
    self.UseQCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use Q")
    self.UseWCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use W")
    self.UseECombo.Value = SettingsManager:GetSettingsInt("Combo", "Use E")
    self.UseRCombo.Value = SettingsManager:GetSettingsInt("Combo", "Use R")
	-------------------------------------------
    self.HarassUseW.Selected = SettingsManager:GetSettingsInt("Harass","UseW in harass")
	self.HarassUseE.Value = SettingsManager:GetSettingsInt("Harass","UseE in harass")
    -------------------------------------------
    self.MiscTrinket.Selected = SettingsManager:GetSettingsInt("Misc", "Auto Trinket")
    self.MiscECC.Value = SettingsManager:GetSettingsInt("Misc", "Auto E at CC")
    self.MiscEDash.Value = SettingsManager:GetSettingsInt("Misc", "Auto E at Dashes")
    -------------------------------------------
    self.DrawQMode.Selected = SettingsManager:GetSettingsInt("Drawings", "Draw Q Mode")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "Draw W")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "Draw E")
    self.DrawRMode.Selected = SettingsManager:GetSettingsInt("Drawings", "Draw R Mode")
    self.DrawRAlert.Value = SettingsManager:GetSettingsInt("Drawings","Draw R Alert")
	self.DrawRAlert_X.Value = SettingsManager:GetSettingsInt("Drawings","DrawRAlert_X")
	self.DrawRAlert_Y.Value = SettingsManager:GetSettingsInt("Drawings","DrawRAlert_Y")
    
end
--[[
function Xerath:PredDelay(GameSpellDelay, MissileWidth)
    local hereshouldbetargetradius = 55
    return GameSpellDelay - ((MissileWidth + hereshouldbetargetradius) / 1000)
end
]]
function Xerath:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Xerath:GetDamage(rawDmg, target)
    local FinalMagicResist = (target.MagicResist * myHero.MagicPenMod) - myHero.MagicPenFlat
    if FinalMagicResist <= 0 then
        FinalMagicResist = 0
    end
    return (100 / (100 + FinalMagicResist)) * rawDmg
end

function Xerath:ChargingQ()
    local QStartTime =  myHero:GetSpellSlot(0).StartTime
    if QStartTime > 0 then
       -- return math.min(self.QRangeMax, self.QRangeMin + (((GameClock.Time - QStartTime)) * 500)) --real
        return math.min(self.QRangeMax + 200, self.QRangeMin + (((GameClock.Time - QStartTime)) * 500)) - 200 -- pred
    else
        return 0
    end
end

function Xerath:ChasingUs(target)
	local Time = 100 / target.MovementSpeed
	local PredPos = Prediction:GetPredictionPosition(target, myHero.Position, math.huge, Time, self.RWidth, 0, 0, 0.001, 1)
    --Render:DrawCircle(PredPos, 100 ,170,170,170,170)
	if PredPos and self:GetDistance(PredPos, myHero.Position) > self:GetDistance(target.Position, myHero.Position) then
		return false
	end

	if PredPos and self:GetDistance(PredPos, myHero.Position) + 50 < self:GetDistance(target.Position, myHero.Position) then
		return true
    end
    return false
end

function Xerath:R()
    local hasForceTarget = Orbwalker.ForceTarget and Orbwalker.ForceTarget.IsHero and not Orbwalker.ForceTarget.IsDead
    if hasForceTarget then
        local NotUsingForceTargetOnlySetting = Prediction.ForceTargetOnly.Value == 0
        if NotUsingForceTargetOnlySetting then Prediction.ForceTargetOnly.Value = 1 end
        local CastPosForceTarget = Prediction:GetCastPos(GameHud.MousePos, 1500, math.huge, self.RWidth, self.RDelay, 0, 0, 0.2, 0)
        if CastPosForceTarget ~= nil and Engine:SpellReady("HK_SPELL4") then
            return Engine:ReleaseSpell("HK_SPELL4", CastPosForceTarget)
        end
        if NotUsingForceTargetOnlySetting then Prediction.ForceTargetOnly.Value = 0 end
        return
    end

    local CastPos =  Prediction:GetCastPos(GameHud.MousePos, 500, math.huge, self.RWidth, self.RDelay, 0, 0, 0.2, 0)
    if CastPos and Engine:SpellReady("HK_SPELL4") then
        return Engine:ReleaseSpell("HK_SPELL4", CastPos)
    end		
end

function Xerath:E()
    local Heroes = ObjectManager.HeroList
    for I, Enemy in pairs(Heroes) do
        if Enemy.Team ~= myHero.Team and Enemy.IsDead == false and Enemy.IsTargetable == true then
            local CastEDashCC, _ = Prediction:GetPredictionPosition(Enemy, myHero.Position, self.ESpeed, self.EDelay - 0.120, self.EWidth, 1, 1, 0.8, 1)
            if self.MiscEDash.Value == 1 and Enemy.AIData.Dashing then
                if self:GetDistance(myHero.Position, Enemy.Position) > self.ERange then
                    local DashTime  = self:GetDistance(Enemy.Position, Enemy.AIData.TargetPos) / Enemy.AIData.DashSpeed
                    local AfterDashDistance = self:GetDistance(Enemy.AIData.TargetPos, myHero.Position)
                    local Time2HitEDash	= 0.15 + (AfterDashDistance / self.ESpeed)
                    if DashTime + 0.1 >= Time2HitEDash then
                        if CastEDashCC then
                            return Engine:ReleaseSpell("HK_SPELL3", CastEDashCC)
                        end
                    end
                end
            end
            
            if self.MiscECC.Value == 1 then
                local TargetCC = Prediction:IsImmobile(Enemy)
                if TargetCC ~= nil then
                    local Distance = self:GetDistance(myHero.Position, Enemy.Position)
                    local Time2HitECC = 0.15 + (Distance / self.ESpeed)
                    if TargetCC + 0.1 >= Time2HitECC then
                        if CastEDashCC then
                            return Engine:ReleaseSpell("HK_SPELL3", CastEDashCC)
                        end
                    end
                end
            end

            if (self.UseECombo.Value == 1 and Engine:IsKeyDown("HK_COMBO")) or (Engine:IsKeyDown("HK_HARASS") and self.HarassUseE.Value == 1) then
                local CastPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay - 0.120, 1, true, 0.5, 1)
                if CastPos ~= nil then
                    return Engine:ReleaseSpell("HK_SPELL3", CastPos)
                end
            end
        end
    end
end

function Xerath:W() 
    local CastW = false

    if self.UseWCombo.Value == 1 and Engine:IsKeyDown("HK_COMBO") then
        CastW = true
    end
    
    if self.HarassUseW.Selected > 0 and Engine:IsKeyDown("HK_HARASS") then
        if self.HarassUseW.Selected == 1 then    
            local ManaFlow   = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Sorcery/ManaflowBand/PerkManaflowBandBuff.lua")
            local ManaFlowCD = myHero.BuffData:GetBuff("ASSETS/Perks/Styles/Sorcery/PotentialEnergy/PerkSorceryOutOfCombatCooldownBuff.lua")
            
            if ManaFlow.Valid or (ManaFlowCD.Valid and ManaFlowCD.EndTime - GameClock.Time < 0.7) then
                CastW = true
            end
        else
            CastW = true
        end
    end
    
    if CastW == true then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.WRange, math.huge, self.WWidthDMG, self.WDelayCast, 0, 0, 0.4, 0)
        if PredPos then
            return Engine:ReleaseSpell("HK_SPELL2", PredPos)
        end
    end
end

function Xerath:Q()
    local PredPos, EnemyQ = Prediction:GetCastPos(myHero.Position, self.QRangeMax, math.huge , self.QWidth, self.QDelay, 0, 1, 1, 0)
    if PredPos then
        if self:ChargingQ() > 0 and self:GetDistance(myHero.Position, PredPos) < self:ChargingQ() then
            return Engine:ReleaseSpell("HK_SPELL1", PredPos)
        end
        if self:ChargingQ() == 0 then
            if Engine:SpellReady("HK_SPELL2") and self.UseWCombo.Value == 1 then
                if self:ChasingUs(EnemyQ) == false and self:GetDistance(myHero.Position, EnemyQ.Position) > self.WRange then
                    Engine:ChargeSpell("HK_SPELL1")
                end
            else
                Engine:ChargeSpell("HK_SPELL1")	
            end
        end
    end	
end

function Xerath:BlueTrinketR()
	if myHero:GetSpellSlot(12).Info.Name == "TrinketOrbLvl3" and Engine:SpellReady("HK_TRINKET") then
        local Enemies = ObjectManager.HeroList
        for I, Enemy in pairs(Enemies) do
            if Enemy.Team ~= myHero.Team and Enemy.IsDead == false then
                local HideTime = GameClock.Time - Awareness.Tracker[Enemy.Index].Map.LastSeen
                local LastPos = Awareness.Tracker[Enemy.Index].Map.LastPosition
                local PredPos = Prediction:GetPredictionPosition(Enemy, LastPos, math.huge, 3, 100, 0, 0, 0.001, 0)
                local RCastPos = Prediction:GetCastPos(GameHud.MousePos, 500, math.huge, self.RWidth, self.RDelay, 0, 0, 0.2, 0)
                
                if PredPos then
                    self.SavePredPos[Enemy.Index] = PredPos
                end

                if RCastPos == nil then
                    if self.SavePredPos[Enemy.Index] then
                        --Render:DrawCircle(self.SavePredPos[Enemy.Index], 100 ,100,150,255,255)
                        --if Enemy.IsVisible == false and Awareness:GetMapTimer(Enemy) > 0.5 and Awareness:GetMapTimer(Enemy) < 1.5 then
                        if Enemy.IsVisible == false and HideTime > 0.5 and HideTime < 5 then
                            if self:GetDistance(myHero.Position,  self.SavePredPos[Enemy.Index]) < 4000 then -- Blue Trinket Range
                                if self:GetDistance(GameHud.MousePos,  self.SavePredPos[Enemy.Index]) < 500 then -- hmmmmmmmmmmmmmmmmmmmmm
                                    return Engine:ReleaseSpell("HK_TRINKET",  self.SavePredPos[Enemy.Index])
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function Xerath:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self:ChargingQ() == 0 then
            if myHero:GetSpellSlot(3).StartTime > 0 then
                Orbwalker:Disable()
                if self.MiscTrinket.Selected == 2 or (self.MiscTrinket.Selected == 1 and Engine:IsKeyDown("HK_COMBO")) then
                    self:BlueTrinketR()
                end
                if Engine:IsKeyDown("HK_COMBO") and self.UseRCombo.Value == 1 then
                    self:R()
                end
                return
            end
            Orbwalker:Enable()

            if Engine:SpellReady("HK_SPELL3") then
                self:E()
            end

            if Engine:SpellReady("HK_SPELL2") then
                self:W()
            end
        end

        if Engine:SpellReady("HK_SPELL1") and self.UseQCombo.Value == 1 and Engine:IsKeyDown("HK_COMBO") then
            self:Q()
        end
    end
end

function Xerath:DrawRDamage()
	local DrawROrder = 0
	local Enemies = ObjectManager.HeroList
	for I, Enemy in pairs(Enemies) do
		if Enemy.Team ~= myHero.Team and Enemy.IsDead == false then
            local SingleR = self:GetDamage(100 + (100 * myHero:GetSpellSlot(3).Level) + (myHero.AbilityPower * 0.45), Enemy)
            local StacksR = 0

            if myHero:GetSpellSlot(3).StartTime > 0 then
                StacksR = myHero.BuffData:GetBuff("xerathrshots").Count_Int
            else
                StacksR = myHero:GetSpellSlot(3).Level + 2
            end

            local MaxDamage = SingleR * StacksR

			if MaxDamage > Enemy.Health then
                local Draw 				= Enemy.ChampionName .. " (" .. string.format(math.floor(Enemy.Health)) .. " HP) - " ..  string.format(math.floor(MaxDamage)) .. " Max R Damage"
				local Y, X = 100, 100

				X = X + self.DrawRAlert_X.Value
				Y = Y + self.DrawRAlert_Y.Value

                -- BackGround
				local R = 0
				local G = 0
				local B = 0
		
                -- Letters
				local RN = 255
				local GN = 255
				local BN = 255
                
                -- Frame
				local RG = 128
				local GG = 128
				local BG = 128

				Render:DrawFilledBox(Y -2, X-2+(32*DrawROrder), string.len(Draw) * 9.5 +8, 25+4, RG,GG,BG,128)
				Render:DrawFilledBox(Y+2, X+2+(32*DrawROrder), string.len(Draw) * 9.5, 21, R,G,B,200)
				Render:DrawString(Draw, Y+5, X+2+(32*DrawROrder), RN,GN,BN,225)
				DrawROrder = DrawROrder + 1
			end
		end
	end
end

function Xerath:OnDraw() 
    if myHero.IsDead then return end

    if self.DrawQMode.Selected > 0 then
        if Engine:SpellReady("HK_SPELL1") then
            Render:DrawCircle(myHero.Position, self.QRangeMax ,100,150,255,255)
            if self.DrawQMode.Selected == 1 then
                Render:DrawCircle(myHero.Position, self.QRangeMin ,100,150,255,255)
            end
        end
    end

    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end

    if Engine:SpellReady("HK_SPELL4") or myHero:GetSpellSlot(3).StartTime > 0 then
		if self.DrawRAlert.Value == 1 then
			Xerath:DrawRDamage()
		end
        if self.DrawRMode.Selected > 0 then
            if self.DrawRMode.Selected > 1 then
                Render:DrawCircle(myHero.Position, self.RRange ,255,0,255,170)
            end
            if self.DrawRMode.Selected ~= 2 then
                Render:DrawCircleMap(myHero.Position, self.RRange ,255,0,255,255)
            end
        end
    end

    if myHero:GetSpellSlot(3).StartTime > 0 then
        local hasForceTarget = Orbwalker.ForceTarget and Orbwalker.ForceTarget.IsHero and not Orbwalker.ForceTarget.IsDead
        if hasForceTarget then
            Render:DrawCircle(GameHud.MousePos,1500,170,170,170,170)
        else
            Render:DrawCircle(GameHud.MousePos,500,170,170,170,170)
        end
    end
end

function Xerath:OnLoad()
    if(myHero.ChampionName ~= "Xerath") then return end
    AddEvent("OnSettingsSave" , function() Xerath:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Xerath:LoadSettings() end)
    Xerath:__init()
    AddEvent("OnDraw", function() Xerath:OnDraw() end)
    AddEvent("OnTick", function() Xerath:OnTick() end)
end
AddEvent("OnLoad", function() Xerath:OnLoad() end)