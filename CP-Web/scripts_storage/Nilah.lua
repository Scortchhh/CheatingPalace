require("SupportLib")
Nilah = {}

function Nilah:__init()

    self.QRange = 600
    self.Q2Range = 400
    self.WRange = 400
    self.ERange = 550
    self.RRange = 450
	
    self.QSpeed = math.huge
    self.Q2Speed = math.huge
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

    self.QWidth = 150
    self.Q2Width = 150

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0
	self.RDelay = 0

    self.QHitChance = 0.15

    self.ChampionMenu       = Menu:CreateMenu("Nilah")
    self.QSettings          = self.ChampionMenu:AddSubMenu("Q  Settings")
    self.UseQCombo          = self.QSettings:AddCheckbox("UseQ on Combo", 1)
    self.UseQHarass         = self.QSettings:AddCheckbox("UseQ on Harass", 1)
    self.LClearSlider       = self.QSettings:AddSlider("Use abilities if mana above %", 20,1,100,1)
    self.UseQLaneclear      = self.QSettings:AddCheckbox("UseQ on Laneclear", 1)
    self.UseQLasthit        = self.QSettings:AddCheckbox("UseQ on Lasthit", 1)
    -------------------------------------------
    self.WSettings          = self.ChampionMenu:AddSubMenu("W Settings")
    self.UseWCombo          = self.WSettings:AddCheckbox("UseW", 1)
    self.UseWOnlyCC         = self.WSettings:AddCheckbox("Only CC", 1)
    -------------------------------------------
    self.ESettings          = self.ChampionMenu:AddSubMenu("E  Settings")
    self.UseECombo          = self.ESettings:AddCheckbox("UseE on Combo", 1)
    -------------------------------------------
    self.RSettings          = self.ChampionMenu:AddSubMenu("R  Settings")
    self.UseRCombo          = self.RSettings:AddCheckbox("UseR on Combo", 1)
    self.UseRSlider         = self.RSettings:AddSlider("R on min X enemies" , 1, 1, 5, 1)

    self.NilahDrawings     = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.NilahDrawings:AddCheckbox("Draw Q", 1)
    self.DrawW = self.NilahDrawings:AddCheckbox("Draw W", 1)
    self.DrawE = self.NilahDrawings:AddCheckbox("Draw E", 1)
    self.DrawR = self.NilahDrawings:AddCheckbox("Draw R", 1)
    Nilah:LoadSettings()
end

function Nilah:SaveSettings()
	SettingsManager:CreateSettings("Nilah")
    SettingsManager:AddSettingsGroup("QSettings")
    SettingsManager:AddSettingsInt("ComboQ", self.UseQCombo.Value)
    SettingsManager:AddSettingsInt("HarassQ", self.UseQHarass.Value)
    SettingsManager:AddSettingsInt("Use abilities if mana above %", self.LClearSlider.Value)
    SettingsManager:AddSettingsInt("LaneclearQ", self.UseQLaneclear.Value)
    SettingsManager:AddSettingsInt("LasthitQ", self.UseQLasthit.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("WSettings")
    SettingsManager:AddSettingsInt("UseW", self.UseWCombo.Value)
    SettingsManager:AddSettingsInt("OnlyCC", self.UseWOnlyCC.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("ESettings")
    SettingsManager:AddSettingsInt("ComboE", self.UseECombo.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("RSettings")
    SettingsManager:AddSettingsInt("ComboR", self.UseRCombo.Value)
    SettingsManager:AddSettingsInt("RSlider", self.UseRSlider.Value)
    -------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
    SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
    SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Nilah:LoadSettings()
    SettingsManager:GetSettingsFile("Nilah")
    self.UseQCombo.Value    = SettingsManager:GetSettingsInt("QSettings", "ComboQ")
    self.UseQHarass.Value   = SettingsManager:GetSettingsInt("QSettings", "HarassQ")
    self.LClearSlider.Value = SettingsManager:GetSettingsInt("QSettings","Use abilities if mana above %")
    self.UseQLaneclear.Value = SettingsManager:GetSettingsInt("QSettings", "LaneclearQ")
    self.UseQLasthit.Value   = SettingsManager:GetSettingsInt("QSettings", "LasthitQ")
    -------------------------------------------
    self.UseWCombo.Value    = SettingsManager:GetSettingsInt("WSettings", "UseW")
    self.UseWOnlyCC.Value   = SettingsManager:GetSettingsInt("WSettings", "OnlyCC")
    -------------------------------------------
    self.UseECombo.Value    = SettingsManager:GetSettingsInt("ESettings", "ComboE")
    -------------------------------------------
    self.UseRCombo.Value    = SettingsManager:GetSettingsInt("RSettings", "ComboR")  
    self.UseRSlider.Value   = SettingsManager:GetSettingsInt("RSettings", "RSlider")
    -------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings", "DrawQ")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings", "DrawW")
    self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings", "DrawE")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings", "DrawR")
end

function Nilah:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Nilah:Q(Mode)
    --print(myHero.BuffData:ShowAllBuffs()) --NilahQAttack
    local QUp = myHero.BuffData:GetBuff("NilahQAttack")
    if Engine:SpellReady("HK_SPELL1") and QUp.Count_Alt == 0 then
        local Target = Orbwalker:GetTarget(Mode, self.QRange)
        if Target then
            local RangePos = Prediction:GetPredictionPosition(Target, myHero.Position, self.QSpeed, self.QDelay, self.QWidth, 0, 1, 0.001, 1)
            if RangePos and Orbwalker:GetDistance(RangePos, myHero.Position) <= self.QRange then
                return Engine:ReleaseSpell("HK_SPELL1", RangePos)
            end
        end
    end
end

function Nilah:W()
    if Engine:SpellReady("HK_SPELL2") then
        local ShieldTarget, Missile = SupportLib:GetShieldTarget(self.ERange, 100)
        if ShieldTarget and Missile and Missile.Team ~= 300 then
            if self.UseWOnlyCC.Value == 0 or (Evade and Evade.Spells[Missile.Name] and Evade.Spells[Missile.Name].CC == 1) then
                return Engine:ReleaseSpell("HK_SPELL2", nil)
            end
        end
    end
end

function Nilah:EMinion()
    local MinionList = ObjectManager.MinionList
    for _, Minion in pairs(MinionList) do
        if Minion.IsTargetable and Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 then
            local Enemies = SupportLib:GetEnemiesInRange(Minion.Position, self.RRange)
            if #Enemies >= self.UseRSlider.Value then
                for _, Enemy in pairs(Enemies) do
                    if self:GetDistance(Enemy.Position, myHero.Position) > self.ERange/2 then
                        return Minion
                    end
                end
            end
        end
    end
    return nil
end

function Nilah:E()
    local ECharges = myHero:GetSpellSlot(2).Charges
    --print(ECharges)
    if Engine:SpellReady("HK_SPELL3") and ECharges > 0 then
        local Target = Orbwalker:GetTarget("Combo", self.ERange)
        local RCD = myHero:GetSpellSlot(3).Cooldown - GameClock.Time
        local RBuff = myHero.BuffData:GetBuff("NilahR")
        if Target then
            local AA = myHero.BaseAttack + myHero.BonusAttack
            local qDmg = -5 + (5 * myHero:GetSpellSlot(0).Level) + ((myHero.BaseAttack + myHero.BonusAttack) * (0.7 + (0.1 * myHero:GetSpellSlot(0).Level)))
            local eDmg = 40 + (10 * myHero:GetSpellSlot(2).Level) + (1.2 * AA)
            local totalDmg = AA + qDmg + eDmg
            if Target.Health <= totalDmg then
                if self:GetDistance(myHero.Position, Target.Position) <= self.ERange then
                    return Engine:ReleaseSpell("HK_SPELL3", Target.Position)
                end
            end
        end
        if myHero.Ammo > 3 and (RCD <= 0 or RBuff.Count_Alt > 0) then
            if Target and self:GetDistance(Target.Position, myHero.Position) > self.ERange/2 then
                return Engine:ReleaseSpell("HK_SPELL3", Target.Position)
            end
            local Minion = self:EMinion()
            if Minion and Orbwalker:GetDistance(Minion.Position, myHero.Position) <= self.ERange then 
                return Engine:ReleaseSpell("HK_SPELL3", Minion.Position)
            end
        end
    end
end

function Nilah:R()
    if self.UseRCombo.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local Enemies = SupportLib:GetEnemiesInRange(myHero.Position, self.RRange)
        if #Enemies >= self.UseRSlider.Value then
            return Engine:ReleaseSpell("HK_SPELL4", nil)
        end
    end
end

function Nilah:QLastHit()
    if Engine:SpellReady("HK_SPELL1") then
        local qDmg = -5 + (5 * myHero:GetSpellSlot(0).Level) + ((myHero.BaseAttack + myHero.BonusAttack) + (0.75 + (0.1 * myHero:GetSpellSlot(0).Level)))
        local target = Orbwalker:GetTarget("Laneclear", self.QRange)
        if target then
            local AARange = myHero.AttackRange + myHero.CharData.BoundingRadius
            if self:GetDistance(myHero.Position, target.Position) > AARange then
                if target.Health <= qDmg then
                    return Engine:CastSpell("HK_SPELL1", target.Position, 0)
                end
            end
        end
    end
end


function Nilah:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if self.UseWCombo.Value == 1 then
            self:W()
        end
        if Orbwalker.Attack == 0 then
            if Engine:IsKeyDown("HK_COMBO") then
                self:R()
                if self.UseQCombo.Value == 1 then
                    self:Q("Combo")
                end
                if self.UseECombo.Value == 1 then
                    self:E()
                end
            end
            if Engine:IsKeyDown("HK_HARASS") then
                if self.UseQHarass.Value == 1 then
                    self:Q("Combo")
                end
            end
            if Engine:IsKeyDown("HK_LASTHIT") or Engine:IsKeyDown("HK_HARASS") then
                if self.UseQLasthit.Value == 1 then
                    self:QLastHit()
                end
            end
            if Engine:IsKeyDown("HK_LANECLEAR") then
                if self.UseQLaneclear.Value == 1 then
                    local sliderValue = self.LClearSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana >= condition then
                        self:Q("Laneclear")
                    end
                end
            end
        end
    end
end

function Nilah:OnDraw()
	if myHero.IsDead then return end
    if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255)
    end
end

function Nilah:OnLoad()
    if myHero.ChampionName ~= "Nilah" then return end
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)
    self:__init()
    AddEvent("OnTick", function() self:OnTick() end)
    AddEvent("OnDraw", function() self:OnDraw() end)
end

AddEvent("OnLoad", function() Nilah:OnLoad() end)