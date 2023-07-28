Taric = {}
function Taric:__init()	
    self.KeyNames = {}
	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"
	
	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
    self.KeyNames[11]		= "HK_ITEM6"
    
    self.QRange = 325
    self.WRange = 800
    self.ERange = 525
    self.RRange = 400

    self.QSpeed = math.huge
    self.WSpeed = math.huge
    self.ESpeed = math.huge
    self.RSpeed = math.huge

    self.QDelay = 0.25 
    self.WDelay = 0.25
    self.EDelay = 0
    self.RDelay = 0.25

    self.KindredRPos = 0

    self.TimerStart = 0
    self.TimerStart2 = 0

    self.ChampionMenu = Menu:CreateMenu("Taric")
    -------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
    self.KindredM  = self.ChampionMenu:AddSubMenu("Kindred Settings")
    self.KindredR  = self.KindredM:AddCheckbox("Use Taric R in Kindred R", 1)
    self.RedempR   = self.KindredM:AddCheckbox("Use Redemption Kindred R", 1)
    
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)
    
    Taric:LoadSettings()
end

function Taric:SaveSettings()
    SettingsManager:CreateSettings("Taric")
    SettingsManager:AddSettingsGroup("Combo")
    SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
    SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
    SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
    SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
    SettingsManager:AddSettingsInt("KindredR", self.KindredR.Value)
    SettingsManager:AddSettingsInt("RedemptionR", self.RedempR.Value)
    ------------------------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end
function Taric:LoadSettings()
    SettingsManager:GetSettingsFile("Taric")
    self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
    self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
    self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
    self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
    self.KindredR.Value = SettingsManager:GetSettingsInt("Combo","KindredR")
    self.RedempR.Value = SettingsManager:GetSettingsInt("Combo","RedemptionR")
    -------------------------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Taric:GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Taric:GetDistance(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Taric:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsDead == false then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Taric:AlliesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Taric:ManaCheck(ManaSpells)
    local QMana = 60 + 10 * myHero:GetSpellSlot(0).Level
    local WMana = 60
    local EMana = 60
    local RMana = 100
    local TotalMana = 0
    if ManaSpells == 1 or ManaSpells == 2 then
        if Engine:SpellReady("HK_SPELL4") then
            TotalMana = TotalMana + RMana
        end
    end
    if ManaSpells == 1 or ManaSpells == 2 or ManaSpells == 3 then
        if Engine:SpellReady("HK_SPELL3") then
            TotalMana = TotalMana + EMana
        end
    end
    if ManaSpells == 1 or ManaSpells == 2 or ManaSpells == 3 then
        if Engine:SpellReady("HK_SPELL2") then
            TotalMana = TotalMana + WMana
        end
    end
    if ManaSpells == 1 then
        if Engine:SpellReady("HK_SPELL1") then
            TotalMana = TotalMana + QMana
        end
    end
    if ManaSpells == 1 then
        if myHero:GetSpellSlot(2).Level > 0 then
            TotalMana = TotalMana + EMana
        end
    end
    return TotalMana
end

function Taric:WTarget()
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false and Hero.ChampionName ~= myHero.ChampionName then
            if self:GetDistance(myHero.Position, Hero.Position) <= 1300 then
                if Hero.BuffData:GetBuff("taricwallybuff").Count_Alt > 0 then
                    return Hero
                end
            end
        end
    end
    return nil
end

function Taric:ETarget()
    local WAlly = self:WTarget()
    if WAlly ~= nil then
        local HeroList = ObjectManager.HeroList
        for i, Hero in pairs(HeroList) do
            if Hero.Team ~= myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
                if self:GetDistance(WAlly.Position, Hero.Position) < self.ERange then
                    return Hero
                end
            end
        end
    end
    return nil
end

function Taric:GetPartner()
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false then
            if self:GetDistance(myHero.Position, Hero.Position) <= 1300 then
                if Hero.ChampionName == "Kindred" then
                    return Hero
                end
            end
        end
    end
    return nil
end

function Taric:GetWTarget()
    local HeroList = ObjectManager.HeroList
    local Funnel = self:GetPartner()
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false and Hero.IsTargetable then
            if Funnel == nil then
                if self:ETarget() == nil then
                    if Hero.BuffData:GetBuff("taricwallybuff").Count_Alt == 0 and Hero.ChampionName ~= myHero.ChampionName then
                        if self:GetDistance(Hero.Position, myHero.Position) <= self.WRange and self:EnemiesInRange(Hero.Position, 1300) > 0 then
                            return Hero
                        end
                    end
                end
            else
                if Funnel.BuffData:GetBuff("taricwallybuff").Count_Alt == 0 then
                    if self:GetDistance(Funnel.Position, myHero.Position) <= self.WRange and self:EnemiesInRange(Hero.Position, 1300) > 0 then
                        return Funnel
                    end
                end
            end
        end
    end
    return nil
end

function Taric:UseRKindred(Hero)
    local KindredR = Hero.BuffData:GetBuff("KindredRNoDeathBuff")
    if KindredR.Count_Alt > 0 then

        local RTime = 4 - GameClock.Time + self.TimerStart
        if RTime <= 0 then
            self.TimerStart = GameClock.Time
        end
        if not Engine:SpellReady("HK_SPELL4") then
            self.TimerStart = 0
        end
        if RTime < 2.75 and RTime > 1 then
            if Engine:SpellReady("HK_SPELL4") then
                Engine:CastSpell("HK_SPELL4", nil, 1)
                return
            end
        end
    end
end

function Taric:RKindredR()
    local HeroList = ObjectManager.HeroList
    local WTarget = self:WTarget()
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false then
            if self:GetDistance(myHero.Position, Hero.Position) <= 1300 then
                if Hero.ChampionName == "Kindred" then
                    if WTarget == nil then
                        WTarget = Hero
                    end
                    if self:EnemiesInRange(Hero.Position, 1400) > 0 or self:EnemiesInRange(myHero.Position, 800) > 0 then
                        if Hero.BuffData:GetBuff("taricwallybuff").Count_Alt > 0 or self:GetDistance(myHero.Position, Hero.Position) <= 800 or self:GetDistance(WTarget.Position, Hero.Position) <= 800  then
                            self:UseRKindred(Hero)
                            return
                        end
                    end
                end
            end
        end
    end
end

function Taric:GetItemKey(ItemName)
	for i = 6 , 11 do
		local Slot = myHero:GetSpellSlot(i)
		if Slot.Info.Name == ItemName then
			return self.KeyNames[i] , Slot.Charges 
		end
	end
	return nil
end

function Taric:Redemption_Check()
	local Redemption			= {}
			Redemption.Key				= self:GetItemKey("ItemRedemption")
	if Redemption.Key ~= nil then
		if Engine:SpellReady(Redemption.Key) then
			return Redemption
		end
	end
	return false
end

function Taric:RedempKindredR()
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team == myHero.Team and Hero.IsDead == false then
            if self:GetDistance(myHero.Position, Hero.Position) <= 5500 then
                if Hero.ChampionName == "Kindred" then
                    local Redemption = self:Redemption_Check()
                    if Redemption ~= false then
                        local KindredR = Hero.BuffData:GetBuff("KindredRNoDeathBuff")
                        if KindredR.Count_Alt > 0 then
                    
                            local RTime = 4 - GameClock.Time + self.TimerStart2
                            if RTime <= 0 then
                                self.TimerStart2 = GameClock.Time
                                self.KindredRPos = Hero.Position
                            end

                           --[[ if RTime <= 0 or RTime >= 3.8 then
                                self.KindredRPos = Hero.Position
                            end]]
                            
                            
                            if RTime < 2.4 and RTime > 1 then
                                if self:GetDistance(myHero.Position, Hero.Position) > 1300 then
                                    Engine:CastSpellMap(Redemption.Key,self.KindredRPos, 1)
                                    return
                                else
                                    Engine:ReleaseSpell(Redemption.Key,self.KindredRPos)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


function Taric:Combo()
    local Passive = myHero.BuffData:GetBuff("TaricPassiveAttack")

    if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and Orbwalker.Attack == 0 and Orbwalker.ResetReady == 1  then
        local Target = Orbwalker:GetTarget("Combo", self:GetAttackRange())
        if Target and Passive.Count_Alt == 0 then
            if myHero.Mana > self:ManaCheck(1) then
                Engine:CastSpell("HK_SPELL1", nil ,1)
                return
            end
        end
    end

    if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local Target = self:GetWTarget()
        if myHero.Mana > self:ManaCheck(3) then
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL2", Target.Position, 1)
                return
            end
        end
    end


    if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local Target = self:ETarget()
        if myHero.Mana > self:ManaCheck(2) then
            if Target ~= nil then
                Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                return
            else
                Target = Orbwalker:GetTarget("Combo", self.ERange)
                if Target then
                    Engine:CastSpell("HK_SPELL3", Target.Position, 1)
                    return
                end
            end
        end
    end



end

function Taric:OnTick()
    --print(myHero.BuffData:GetBuff("buffname")
    --myHero.BuffData:ShowAllBuffs()
    --print(myHero.BuffData:GetBuff("TaricPassiveAttack").Count_Alt)
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.RedempR.Value == 1 then
            Taric:RedempKindredR()
        end
        if Engine:IsKeyDown("HK_COMBO") then
            if self.KindredR.Value == 1 then
                Taric:RKindredR()
            end
			Taric:Combo()
        end
    end
end

function Taric:OnDraw()
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,12, 0, 249,255) --Blue
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,249, 137, 0,255) --Orange
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange + 50 ,237, 249, 0,255) --Yellow
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange + 50 ,249, 12, 0,255) -- Red
    end
    local WTarget = self:WTarget()
    if WTarget ~= nil then
        if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
            Render:DrawCircle(WTarget.Position, self.QRange ,112, 249, 0,255) --Green
        end
        if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
            Render:DrawCircle(WTarget.Position, self.RRange + 50 ,137, 0, 249,255) --Purple
        end
    end
end

function Taric:OnLoad()
    if(myHero.ChampionName ~= "Taric") then return end
    AddEvent("OnSettingsSave" , function() Taric:SaveSettings() end)
    AddEvent("OnSettingsLoad" , function() Taric:LoadSettings() end)


    Taric:__init()
    AddEvent("OnTick", function() Taric:OnTick() end)	
    AddEvent("OnDraw", function() Taric:OnDraw() end)	
end

AddEvent("OnLoad", function() Taric:OnLoad() end)	