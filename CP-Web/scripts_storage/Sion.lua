local Sion = {}

function Sion:__init()

    self.SavePredPos = nil
    
    self.ScriptVersion = "        **CCSion Version: 0.3 (BETA)**"

    self.ChampionMenu = Menu:CreateMenu("Sion")
	-------------------------------------------
    
	Sion:LoadSettings()
end

function Sion:SaveSettings()
	SettingsManager:CreateSettings("CCSion")

end

function Sion:LoadSettings()
	SettingsManager:GetSettingsFile("CCSion")

end

function Sion:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Sion:GetQFixedPos(CastPos)
	local PlayerPos 	= CastPos
	local TargetPos 	= myHero.Position
	local TargetVec 	= Vector3.new(TargetPos.x - PlayerPos.x, TargetPos.y - PlayerPos.y, TargetPos.z - PlayerPos.z)
	local Length		= math.sqrt((TargetVec.x) ^ 2 + (TargetVec.y) ^ 2 + (TargetVec.z) ^ 2)
	local TargetNorm 	= Vector3.new(TargetVec.x/Length , TargetVec.y/Length , TargetVec.z/Length) 
	
	local i 			= -850
	local EndPos 		= Vector3.new(TargetPos.x + (TargetNorm.x * i),TargetPos.y + (TargetNorm.y * i),TargetPos.z + (TargetNorm.z * i))
	return EndPos
end

function Sion:GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

function Sion:TowersInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local TowerList = ObjectManager.TurretList
    for i,Tower in pairs(TowerList) do
        if Tower.Team ~= myHero.Team and Tower.IsTargetable and Tower.MaxHealth > 1500 then
            if self:GetDistance(Tower.Position , myHero.Position) < 1500 then
                if self:GetDistance(Tower.Position , Position) < Range then
                    Count = Count + 1
                end
            end
		end
    end
    return Count
end

function Sion:RUsage()
    local SionR = myHero.BuffData:GetBuff("SionR")
    if SionR.Count_Alt > 0 then
        local TargetPos = myHero.Position
        local Time      = SionR.EndTime - GameClock.Time
        local Modifier  = myHero.MovementSpeed * math.max(0, math.min(1, Time))
        local Predict   = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier))

        local Modifier2  = 300
        local Predict2   = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier2),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier2))

        local Modifier3  = 525+300
        local Predict3   = Vector3.new(TargetPos.x + (myHero.Direction.x*Modifier3),TargetPos.y ,TargetPos.z + (myHero.Direction.z*Modifier3))
        
        if GameClock.Time - myHero:GetSpellSlot(1).Cooldown > 0 then
            if myHero:GetSpellSlot(1).Info.Name == "SionW" then
                if Time < 6 then
                    return Engine:CastSpell("HK_SPELL2", nil, 0)
                end
            else
                if GameClock.Time - myHero:GetSpellSlot(3).Cooldown < 0 then
                    local WTarget = Orbwalker:GetTarget("COMBO", 500)
                    if Target then
                        return Engine:CastSpell("HK_SPELL2", nil, 0)
                    end
                end
            end
        end

        if self:TowersInRange(Predict2, 520) > 1 then
            print("XD")
            return Engine:CastSpell("HK_SPELL4", nil, 0)
        end

        if Predict ~= nil then
            Render:DrawCircle(Predict, 50, 255, 255, 255, 225)
        end

        if Predict2 ~= nil then
            Render:DrawCircle(Predict2, 50, 255, 0, 0, 225)
        end

        local BestTarget = Orbwalker:GetTarget("COMBO", 525+300)

        if BestTarget then
            local DistanceMod = self:GetDistance(myHero.Position, BestTarget.Position) / Modifier
            if Prediction:PointOnLineSegment(myHero.Position, Predict3, BestTarget.Position, (myHero.CharData.BoundingRadius + BestTarget.CharData.BoundingRadius) * DistanceMod) == true then return nil end
        end
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, 525+300, math.huge, 525, 0.55, 0, 0, 0.001, 1)
        if PredPos then
            Render:DrawCircle(PredPos, 50, 0, 0, 255, 225)
            if self:GetDistance(PredPos, Predict2) < 525 - (Target.MovementSpeed * 0.55) or self:GetDistance(Target.Position, Predict2) < 525 - (Target.MovementSpeed * 0.55) then
                return Engine:CastSpell("HK_SPELL4", nil, 0)
            end
        end
    end
end

function Sion:Combo()
    if myHero.BuffData:GetBuff("sionpassivezombie").Count_Alt > 0 then return nil end --SionW
    local BuffW = myHero.BuffData:GetBuff("sionwshieldstacks")

    local WTarget = Orbwalker:GetTarget("COMBO", 600)
    if Engine:SpellReady("HK_SPELL2") and WTarget then
        if myHero:GetSpellSlot(1).Info.Name == "SionW" then
            if self:GetDistance(WTarget.Position, myHero.Position) < 450 + (myHero.MovementSpeed - WTarget.MovementSpeed) then
                return Engine:CastSpell("HK_SPELL2", nil, 0)
            end
        else
            if BuffW and self:GetDistance(WTarget.Position, myHero.Position) < 525 then
                local WLevel = myHero:GetSpellSlot(1).Level

                local WDmg = 15 + (25 * WLevel) + WTarget.MaxHealth * 0.09 + (0.01 * WLevel * WTarget.MaxHealth) + WTarget.AbilityPower * 0.4
                local WDmg2 = Sion:GetDamage(WDmg, false, WTarget)

                local WShield = BuffW.Count_Int
                local WShAD = Sion:GetDamage(WShield, true, myHero)
                local WShAP = Sion:GetDamage(WShield, false, myHero)
                local WShieldAmount = (WShAD + WShAP) / 2
                --print(WDmg2)
                if WShieldAmount < WDmg2 or WTarget.Health < WDmg2 then
                    return Engine:CastSpell("HK_SPELL2", nil, 0)
                end
            end
        end
    end

    local ETarget = Orbwalker:GetTarget("COMBO", 1350)
    if Engine:SpellReady("HK_SPELL3") and ETarget then
        local MissingHP = ((myHero.MaxHealth - myHero.Health) / myHero.MaxHealth) * 100
        if self:GetDistance(ETarget.Position, myHero.Position) > 200 or MissingHP > 75 or Engine:SpellReady("HK_SPELL1") then
            local PredPos, Time = Prediction:GetPredictionPosition(ETarget, myHero.Position, 1800, 0.25, 160, 0, true, 0.005, 1)
            if PredPos then
                --print(Time)
                if self:GetDistance(myHero.Position, PredPos) < 800 - (ETarget.MovementSpeed * Time) or self:GetDistance(myHero.Position, ETarget.Position) < 800 - (ETarget.MovementSpeed * Time) then
                    return Engine:ReleaseSpell("HK_SPELL3", PredPos)
                else
                    local Minions = ObjectManager.MinionList
                    for I,Minion in pairs(Minions) do
                        if Minion.Team ~= myHero.Team then
                            if self:GetDistance(Minion.Position, myHero.Position) < 700 then
                                if Prediction:PointOnLineSegment(myHero.Position, PredPos, Minion.Position, Minion.CharData.BoundingRadius + 1) == true then
                                    --print("KKK")
                                    if self:GetDistance(myHero.Position, PredPos) < 1350 - (ETarget.MovementSpeed * Time) or self:GetDistance(myHero.Position, ETarget.Position) < 1350 - (ETarget.MovementSpeed * Time) then
                                        return Engine:ReleaseSpell("HK_SPELL3", PredPos)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    --[[if Engine:SpellReady("HK_SPELL1") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, 850, 1800, 350, 2, 0, true, 0.1, 0)
        local PredPos2, Target2 = Prediction:GetCastPos(myHero.Position, 900, 1800, 5, 0.1, 0, true, 0.001, 1)
        local QStartTime =  myHero:GetSpellSlot(0).StartTime

        if self.SavePredPos ~= nil and QStartTime > 0 and Target then
            local QEdgePos = self:GetQFixedPos(self.SavePredPos)
            if Prediction:PointOnLineSegment(myHero.Position, QEdgePos, PredPos2, 350) == false then
                return Engine:ReleaseSpell("HK_SPELL1", nil)
            end
        end
        if QStartTime <= 0 and PredPos then
            self.SavePredPos = PredPos
            if Engine:ReleaseSpell("HK_SPELL1", PredPos) then
                return Engine:ChargeSpell("HK_SPELL1", PredPos)
            end
        end
    end]]
end


function Sion:OnTick()
    --myHero.BuffData:ShowAllBuffs()
    --print(GameClock.Time -myHero:GetSpellSlot(0).StartTime)
    --print(GameClock.Time - myHero:GetSpellSlot(1).Cooldown)
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        Sion:RUsage()
        if Engine:IsKeyDown("HK_COMBO") then
            Sion:Combo()
            return
        end
        if Engine:IsKeyDown("HK_HARASS") then
            Sion:Combo()
            return
        end
    end
end

function Sion:OnDraw()
    if Engine:SpellReady("HK_SPELL1") then
        Render:DrawCircle(myHero.Position, 850, 255, 0, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL2") then
        Render:DrawCircle(myHero.Position, 525, 0, 255, 255, 255)
    end
    if Engine:SpellReady("HK_SPELL3") then
        Render:DrawCircle(myHero.Position, 800, 255, 0, 0, 225)
    end
end

function Sion:OnLoad()
    if(myHero.ChampionName ~= "Sion") then return end
    AddEvent("OnSettingsSave" , function() Sion:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Sion:LoadSettings() end)

	Sion:__init()
	AddEvent("OnTick", function() Sion:OnTick() end)
    AddEvent("OnDraw", function() Sion:OnDraw() end)
    print(self.ScriptVersion)
end

AddEvent("OnLoad", function() Sion:OnLoad() end)