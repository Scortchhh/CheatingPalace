--Credits to Critic, Scortch, Christoph

TwistedFate = {
    CModes = {
        "None",
        "Gold",
        "Blue",
        "Red",
        "Smart",
    }
} 

function TwistedFate:__init() 
    self.QRange = 1450
    self.WRange = 590
    self.RRange = 5500

    self.QSpeed = 1000
    self.RSpeed = 750

    self.QWidth = 80

    self.QDelay = 0.25
    self.RDelay = 0.25

    self.QHitChance = 0.2

    self.ScriptVersion = "         TwistedFate Ver: 1.1" 

    

    self.ChampionMenu   = Menu:CreateMenu("TwistedFate") 
    --------------------------------------------
    self.ComboMenu      = self.ChampionMenu:AddSubMenu("Combo") 
    self.ComboQ         = self.ComboMenu:AddCheckbox("Use Q in Combo", 1)
    self.ComboQS         = self.ComboMenu:AddCheckbox("Use Q on Stun Only", 1)
    self.ComboBW        = self.ComboMenu:AddCheckbox("Use Blue Card in Combo", 1) 
    self.BlueSlider     = self.ComboMenu:AddSlider("Use Blue Card if mana below %", 20,1,100,1)
    self.ComboRW        = self.ComboMenu:AddCheckbox("Use Red Card in Combo", 1) 
    self.RedSlider      = self.ComboMenu:AddSlider("Min. amount of enemies to Red Card", 3,1,5,1)
    self.ComboGW        = self.ComboMenu:AddCheckbox("Use Gold Card in Combo", 1) 
    self.CardTimer      = self.ComboMenu:AddCombobox("Card if timer about to end:", TwistedFate.CModes)
    --------------------------------------------
    self.HarassMenu     = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ        = self.HarassMenu:AddCheckbox("Use Q in Harass", 1)
    self.HarassBW       = self.HarassMenu:AddCheckbox("Use Blue Card in Harass", 1) 
    self.BlueHSlider    = self.HarassMenu:AddSlider("Use Blue Card if mana below %", 20,1,100,1)
    self.HarassRW       = self.HarassMenu:AddCheckbox("Use Red Card in Harass", 1) 
    self.RedHSlider     = self.HarassMenu:AddSlider("Min. amount of enemies to Red Card", 3,1,5,1)
    self.HarassGW       = self.HarassMenu:AddCheckbox("Use Gold Card in Harass", 1) 
    --------------------------------------------
    self.LClearMenu     = self.ChampionMenu:AddSubMenu("Laneclear") 
    self.ClearQ         = self.LClearMenu:AddCheckbox("Use Q in Laneclear", 1) 
    self.ClearBW        = self.LClearMenu:AddCheckbox("Use Blue Card in Laneclear", 1) 
    self.BlueLSlider    = self.LClearMenu:AddSlider("Use Blue Card if mana below %", 20,1,100,1)
    self.ClearRW        = self.LClearMenu:AddCheckbox("Use Red Card in Laneclear", 1)
    self.RedHCSlider     = self.LClearMenu:AddSlider("Min. amount of enemies to Red Card", 3,1,5,1)
    --------------------------------------------
	self.DrawMenu       = self.ChampionMenu:AddSubMenu("Drawings") 
    self.DrawQ          = self.DrawMenu:AddCheckbox("Draw Q", 1) 
    self.DrawW          = self.DrawMenu:AddCheckbox("Draw W", 1) 
    self.DrawE          = self.DrawMenu:AddCheckbox("Draw E", 1) 
    self.DrawR          = self.DrawMenu:AddCheckbox("Draw R", 1) 
    --------------------------------------------
    TwistedFate:LoadSettings()  
end 

function TwistedFate:SaveSettings() 

    SettingsManager:CreateSettings("TwistedFate")
	SettingsManager:AddSettingsGroup("Combo")
    
	SettingsManager:AddSettingsInt("Use Q in Combo", self.ComboQ.Value)
    SettingsManager:AddSettingsInt("Use Q on Stun Only", self.ComboQS.Value)
    SettingsManager:AddSettingsInt("Use Blue Card in Combo", self.ComboBW.Value)
    SettingsManager:AddSettingsInt("Use Blue Card if mana below %", self.BlueSlider.Value)
    SettingsManager:AddSettingsInt("Use Red Card in Combo", self.ComboRW.Value)
    SettingsManager:AddSettingsInt("Min. amount of enemies to Red Card", self.RedHSlider.Value)
    SettingsManager:AddSettingsInt("Use Gold Card in Combo", self.ComboGW.Value)
    SettingsManager:AddSettingsInt("TimerEnd", self.CardTimer.Selected)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use Blue Card in Harass", self.HarassBW.Value)
    SettingsManager:AddSettingsInt("Use Blue Card if mana below %", self.BlueHSlider.Value)
    SettingsManager:AddSettingsInt("Use Red Card in Harass", self.HarassRW.Value)
    SettingsManager:AddSettingsInt("Min. amount of enemies to Red Card", self.RedHSlider.Value)
    SettingsManager:AddSettingsInt("Use Gold Card in Harass", self.HarassGW.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Laneclear")
    SettingsManager:AddSettingsInt("Use Q in Laneclear", self.ClearQ.Value)
    SettingsManager:AddSettingsInt("Use Blue Card in Laneclear", self.ClearBW.Value)
    SettingsManager:AddSettingsInt("Use Blue Card if mana below %", self.BlueLSlider.Value)
    SettingsManager:AddSettingsInt("Use Red Card in Laneclear", self.ClearRW.Value)
    SettingsManager:AddSettingsInt("Min. amount of enemies to Red Card", self.RedHCSlider.Value)
    --------------------------------------------
    SettingsManager:AddSettingsGroup("Drawings")
    SettingsManager:AddSettingsInt("Draw Q", self.DrawQ.Value)
    SettingsManager:AddSettingsInt("Draw W", self.DrawW.Value)
    SettingsManager:AddSettingsInt("Draw R", self.DrawR.Value)
    --------------------------------------------
end

function TwistedFate:LoadSettings()
    SettingsManager:GetSettingsFile("TwistedFate")
     --------------------------------Combo load----------------------
    self.ComboQ.Value = SettingsManager:GetSettingsInt("Combo","Use Q in Combo")
    self.ComboQS.Value = SettingsManager:GetSettingsInt("Combo","Use Q on Stun Only")
    self.ComboBW.Value = SettingsManager:GetSettingsInt("Combo","Use Blue Card in Combo")
    self.BlueSlider.Value = SettingsManager:GetSettingsInt("Combo","Use Blue Card if mana below %")
    self.ComboRW.Value = SettingsManager:GetSettingsInt("Combo","Use Red Card in Combo")
    self.RedSlider.Value = SettingsManager:GetSettingsInt("Combo","Min. amount of enemies to Red Card")
    self.ComboGW.Value = SettingsManager:GetSettingsInt("Combo","Use Gold Card in Combo")
    self.CardTimer.Selected = SettingsManager:GetSettingsInt("Combo","TimerEnd")
    --------------------------------------------
	self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassBW.Value = SettingsManager:GetSettingsInt("Harass","Use Blue Card in Harass")
    self.BlueHSlider.Value = SettingsManager:GetSettingsInt("Harass","Use Blue Card if mana below %")
    self.HarassRW.Value = SettingsManager:GetSettingsInt("Harass","Use Red Card in Harass")
    self.RedHSlider.Value = SettingsManager:GetSettingsInt("Harass","Min. amount of enemies to Red Card")
    self.HarassGW.Value = SettingsManager:GetSettingsInt("Harass","Use Gold Card in Harass")
        --------------------------------------------
    self.ClearQ.Value = SettingsManager:GetSettingsInt("Laneclear","Use Q in Laneclear")
    self.ClearBW.Value = SettingsManager:GetSettingsInt("Laneclear","Use Blue Card in Laneclear")
    self.BlueLSlider.Value = SettingsManager:GetSettingsInt("Laneclear","Use Blue Card if mana below %")
    self.ClearRW.Value = SettingsManager:GetSettingsInt("Laneclear","Use Red Card in Laneclear")
    self.RedHCSlider.Value = SettingsManager:GetSettingsInt("Laneclear","Min. amount of enemies to Red Card")
    --------------------------------------------
    self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","Draw Q")
    self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","Draw W")
    self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","Draw R")
    --------------------------------------------
end

local function getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end
local function GetDamage(rawDmg, isPhys, target)
    if isPhys then return (100 / (100 + target.Armor)) * rawDmg end
    if not isPhys then return (100 / (100 + target.MagicResist)) * rawDmg end
    return 0
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function EnemiesInRange(Position, Range)
	local Count = 0 
	local HeroList = ObjectManager.HeroList
	for i, Hero in pairs(HeroList) do	
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if GetDist(Hero.Position , Position) < Range then
				Count = Count + 1
			end
		end
	end
	return Count
end

--destiny_marker

function TwistedFate:GetEDamage()
    local qDmg = 40 + 25 * myHero:GetSpellSlot(2).Level + myHero.AbilityPower * 0.5
    return qDmg
end

function TwistedFate:Ultimate()

    local buff1 = myHero.BuffData:GetBuff("destiny_marker")

    if buff1.Valid and Engine:SpellReady("HK_SPELL2") then
        if Engine:SpellReady("HK_SPELL2") then
            if myHero:GetSpellSlot(1).Info.Name == ("PickACard") then
                Engine:ReleaseSpell("HK_SPELL2", nil)
                return
            end
        end

        if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
            Engine:CastSpell("HK_SPELL2", nil, 1)
            return
        end
    end

end

--pickacard_tracker
function TwistedFate:CardTimerEnd()
    local CardBuff = myHero.BuffData:GetBuff("pickacard_tracker")
    if CardBuff.Count_Alt > 0 then
        if GameClock.Time + 2 >= CardBuff.EndTime then
            if self.CardTimer.Selected == 1 then
                if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
            if self.CardTimer.Selected == 2 then
                if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
            if self.CardTimer.Selected == 3 then
                if myHero:GetSpellSlot(1).Info.Name == ("RedCardLock") then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
            if self.CardTimer.Selected == 4 then
                local sliderValue = self.BlueSlider.Value
                local condition = myHero.MaxMana / 100 * 40
                if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
                    if myHero.Mana >= condition then
                        Engine:CastSpell("HK_SPELL2", nil, 1)
                        return
                    end
                end
                if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
                    if myHero.Mana <= condition then
                        Engine:CastSpell("HK_SPELL2", nil, 1)
                        return
                    end
                end
            end
        end
    end
end

function TwistedFate:Combo()
    
    if self.ComboGW.Value == 1 or self.ComboBW.Value == 1 or self.ComboRW.Value == 1 then
        if Engine:SpellReady("HK_SPELL2") then
            if myHero:GetSpellSlot(1).Info.Name == ("PickACard") then
                local target = Orbwalker:GetTarget("Combo", self.QRange)
                if target ~= nil then
                    Engine:ReleaseSpell("HK_SPELL2", nil)
                    return
                end
            end
        end
    end

    if self.ComboGW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
            local target = Orbwalker:GetTarget("Combo", self.QRange)
            local sliderValue = self.BlueSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana >= condition then
                if target ~= nil then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.ComboBW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
            local target = Orbwalker:GetTarget("Combo", self.QRange)
            local sliderValue = self.BlueSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana <= condition then
                if target ~= nil then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.ComboRW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("RedCardLock") then
            local target = Orbwalker:GetTarget("Combo", self.QRange)
            if target ~= nil then
                if EnemiesInRange(target.Position, 300) >= self.RedSlider.Value then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.ComboQ.Value == 1 and self.ComboQS.Value == 0 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.QRange then
            Engine:CastSpell("HK_SPELL1", PredPos, 1)
            return
        end
    end

    if self.ComboQS.Value == 1  and Engine:SpellReady("HK_SPELL1") then
        local Target = Orbwalker:GetTarget("Combo", self.QRange)
        if Target ~= nil then
            local TargetStunned = Target.BuffData:HasBuffOfType(BuffType.Stun) or Target.BuffData:HasBuffOfType(BuffType.Snare) or Target.BuffData:HasBuffOfType(BuffType.Asleep) or Target.BuffData:HasBuffOfType(BuffType.Suppression) or Target.BuffData:HasBuffOfType(BuffType.Taunt) or Target.BuffData:HasBuffOfType(BuffType.Knockup)
            local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
            if PredPos ~= nil and GetDist(myHero.Position, PredPos) <= self.QRange and TargetStunned then
                Engine:CastSpell("HK_SPELL1", PredPos, 1)
                return
            end
        end
    end
end


function TwistedFate:Harass()

    if self.HarassGW.Value == 1 or self.HarassBW.Value == 1 or self.HarassRW.Value == 1 then
        if Engine:SpellReady("HK_SPELL2") then
            if myHero:GetSpellSlot(1).Info.Name == ("PickACard") then
                local target = Orbwalker:GetTarget("Harass", self.WRange)
                if target ~= nil then
                    Engine:ReleaseSpell("HK_SPELL2", nil)
                    return
                end
            end
        end
    end

    if self.HarassGW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
            local target = Orbwalker:GetTarget("Harass", self.WRange)
            if target ~= nil then
                Engine:CastSpell("HK_SPELL2", nil, 1)
                return
            end
        end
    end

    if self.HarassBW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
            local target = Orbwalker:GetTarget("Harass", self.WRange)
            local sliderValue = self.BlueHSlider.Value
            local condition = myHero.MaxMana / 100 * sliderValue
            if myHero.Mana <= condition then
                if target ~= nil then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.HarassRW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("RedCardLock") then
            local target = Orbwalker:GetTarget("Harass", self.WRange)
            if target ~= nil then
                if EnemiesInRange(target.Position, 300) >= self.RedHSlider.Value then
                    Engine:CastSpell("HK_SPELL2", nil, 1)
                    return
                end
            end
        end
    end

    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and not Engine:SpellReady("HK_SPELL2") then
        local target = Orbwalker:GetTarget("Harass", self.QRange)
        if target ~= nil then
            if GetDist(myHero.Position, target.Position) <= self.QRange then
                local sliderValue = self.BlueHSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if myHero.Mana >= condition then
                    local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
                    if PredPos ~= nil then
                        Engine:CastSpell("HK_SPELL1", PredPos, 1)
                        return
                    end
                end
            end
        end
    end
end

function TwistedFate:MinionsInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local MinionList = ObjectManager.MinionList
    for i,Minion in pairs(MinionList) do
        if Minion.Team ~= myHero.Team and Minion.IsTargetable then
			if GetDist(Minion.Position , Position) < Range then
				Count = Count + 1
			end
		end
    end
    return Count
end

function TwistedFate:Laneclear()

    if self.ClearBW.Value == 1 or self.ClearRW.Value == 1 then
        if Engine:SpellReady("HK_SPELL2") then
            if myHero:GetSpellSlot(1).Info.Name == ("PickACard") then
                local target = Orbwalker:GetTarget("Laneclear", self.WRange)
                if target ~= nil then
                    Engine:CastSpell("HK_SPELL2", nil)
                    return
                end
            end
        end
    end

    if self.ClearBW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
            local MinionList = ObjectManager.MinionList
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.IsTargetable then
                    local sliderValue = self.BlueHSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana <= condition or self:MinionsInRange(Minion.Position, 400) < self.RedHSlider.Value and GetDist(myHero.Position, Minion.Position) <= self.WRange then
                        Engine:CastSpell("HK_SPELL2", nil, 1)
                        return
                    end
                end
            end
        end
    end

    if self.ClearRW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        if myHero:GetSpellSlot(1).Info.Name == ("RedCardLock") then
            local MinionList = ObjectManager.MinionList
            for i, Minion in pairs(MinionList) do
                if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.IsTargetable then
                    local sliderValue = self.BlueHSlider.Value
                    local condition = myHero.MaxMana / 100 * sliderValue
                    if myHero.Mana <= condition or self:MinionsInRange(Minion.Position, 400) >= self.RedHSlider.Value and GetDist(myHero.Position, Minion.Position) <= self.WRange then
                        Engine:CastSpell("HK_SPELL2", nil, 1)
                        return
                    end
                end
            end
        end
    end

    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1")  then
        local MinionList = ObjectManager.MinionList
        for i, Minion in pairs(MinionList) do
            if Minion.Team ~= myHero.Team and Minion.MaxHealth > 10 and Minion.IsTargetable then
                local sliderValue = self.BlueHSlider.Value
                local condition = myHero.MaxMana / 100 * sliderValue
                if GetDist(myHero.Position, Minion.Position) <= self.QRange and myHero.Mana >= condition then
                    Engine:CastSpell("HK_SPELL1", Minion.Position, 0)
                    return
                end
            end
        end
    end

end

function TwistedFate:OnTick()
    TwistedFate:Ultimate()
    TwistedFate:CardTimerEnd()
    local CardBuff = myHero.BuffData:GetBuff("cardmasterstackparticle")
    local CardBuff2 = myHero.BuffData:GetBuff("pickacard_tracker")
    local ExtraDmg = 0
    if CardBuff.Count_Alt == 1 then
        ExtraDmg = ExtraDmg + self:GetEDamage()
    end
    if CardBuff2.Count_Alt == 0 then
        if myHero:GetSpellSlot(1).Info.Name == ("BlueCardLock") then
            ExtraDmg = ExtraDmg + 20 + 20 * myHero:GetSpellSlot(1).Level + myHero.AbilityPower * 0.9
        end
        if myHero:GetSpellSlot(1).Info.Name == ("RedCardLock") then
            ExtraDmg = ExtraDmg + 15 + 15 * myHero:GetSpellSlot(1).Level + myHero.AbilityPower * 0.6
        end
        if myHero:GetSpellSlot(1).Info.Name == ("GoldCardLock") then
            ExtraDmg = ExtraDmg + 7.5 + 7.5 * myHero:GetSpellSlot(1).Level + myHero.AbilityPower * 0.5
        end
    end
    Orbwalker.ExtraDamage = ExtraDmg
    if GameHud.Minimized == false and GameHud.ChatOpen == false then
        if Engine:IsKeyDown("HK_COMBO") then
            TwistedFate:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            TwistedFate:Harass()
        end
        if Engine:IsKeyDown("HK_LANECLEAR") then
            TwistedFate:Laneclear()
		end
	end
end

function TwistedFate:OnDraw()

	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,0,255,0,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
      Render:DrawCircle(myHero.Position, self.WRange ,100,150,255,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) -- values Red, Green, Blue, Alpha(opacity)      
    end
end

function TwistedFate:OnLoad()
    if(myHero.ChampionName ~= "TwistedFate") then return end
	AddEvent("OnSettingsSave" , function() TwistedFate:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() TwistedFate:LoadSettings() end)


	TwistedFate:__init()
	AddEvent("OnTick", function() TwistedFate:OnTick() end)	
    AddEvent("OnDraw", function() TwistedFate:OnDraw() end)
    print(self.ScriptVersion)	
end

AddEvent("OnLoad", function() TwistedFate:OnLoad() end)	
