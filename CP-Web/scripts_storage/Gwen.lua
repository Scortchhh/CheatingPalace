require("DamageLib")

Gwen = {}
function Gwen:__init()	
	self.QRange = 450
	self.WRange = 420
	self.ERange = 350
	self.RRange = 1200

	self.QSpeed = math.huge
	self.WSpeed = 2000
	self.ESpeed = math.huge
	self.RSpeed = 1800

    self.QWidth = 100
    self.WWidth = 480
    self.EWidth = 100
    self.RWidth = 240

	self.QDelay = 0.25 
	self.WDelay = 0
	self.EDelay = 0 
	self.RDelay = 0.25

    self.QHitChance = 0.2
    self.WHitChance = 0.2
    self.EHitChance = 0.2
    self.RHitChance = 0.2

    self.ChampionMenu = Menu:CreateMenu("Gwen")
	-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
	self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
	self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
	
    self.HarassMenu     = self.ChampionMenu:AddSubMenu("Harass") 
	self.HarassQ        = self.HarassMenu:AddCheckbox("UseQ", 1) 

	self.LClearMenu     = self.ChampionMenu:AddSubMenu("LaneClear") 
	self.ClearQ         = self.LClearMenu:AddCheckbox("ClearQ", 1) 
	self.ClearHarassQ   = self.LClearMenu:AddCheckbox("HarassQ", 1) 

	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.DrawMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)
    self.DrawDamage = self.DrawMenu:AddCheckbox("Draw Damage", 1)
	
	Gwen:LoadSettings()
end

function Gwen:SaveSettings()
	SettingsManager:CreateSettings("Gwen")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)

	SettingsManager:AddSettingsGroup("Harass")
	SettingsManager:AddSettingsInt("UseQ", self.HarassQ.Value)
    
    SettingsManager:AddSettingsGroup("LaneClear")
	SettingsManager:AddSettingsInt("ClearQ", self.ClearQ.Value)
	SettingsManager:AddSettingsInt("HarassQ", self.ClearHarassQ.Value)
	
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
	SettingsManager:AddSettingsInt("DrawDamage", self.DrawDamage.Value)
end

function Gwen:LoadSettings()
	SettingsManager:GetSettingsFile("Gwen")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")

    self.ClearQ.Value = SettingsManager:GetSettingsInt("Harass","UseQ")

	self.ClearQ.Value = SettingsManager:GetSettingsInt("LaneClear","ClearQ")
	self.ClearHarassQ.Value = SettingsManager:GetSettingsInt("LaneClear","HarassQ")
	
	-------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
	self.DrawDamage.Value = SettingsManager:GetSettingsInt("Drawings","DrawDamage")
end

function Gwen:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2 + (from.z - to.z) ^ 2)
end

function Gwen:Combo()
    local StartPos 	= myHero.Position

    local RBuff = myHero.BuffData:GetBuff("GwenRRecast")
    local Count = RBuff.Count_Int
    if Count == 0 then
        self.RDelay = 0.25
    else
        self.RDelay = 0.50
    end

    if self.ComboUseQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos then
            if self:GetDistance(StartPos, PredPos) < self.QRange then
                Engine:CastSpell("HK_SPELL1", PredPos ,1)
                return
            end
        end
    end
    if self.ComboUseR.Value == 1 and Engine:SpellReady("HK_SPELL4") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.RHitChance, 1)
        if PredPos and Target then
            local QDamage = DamageLib.Gwen:GetQDmg(Target)
            local EDamage = DamageLib.Gwen:GetEDmg(Target)
            local RDamage = DamageLib.Gwen:GetRDmg(Target)
            local ComboDamage = QDamage + EDamage + RDamage 
            if self:GetDistance(StartPos, PredPos) < self.RRange and Target.Health < RDamage then
                Engine:CastSpell("HK_SPELL4", PredPos ,1)
                return
            end

            if self:GetDistance(StartPos, PredPos) < self.QRange and Target.Health < ComboDamage*3 then
                Engine:CastSpell("HK_SPELL4", PredPos ,1)
                return
            end
        end
    end
	if self.ComboUseE.Value == 1 and Engine:SpellReady("HK_SPELL3") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, true, self.EHitChance, 1)
        if PredPos ~= nil then
            if Orbwalker.MovePosition == nil and self:GetDistance(StartPos, PredPos) > self.QRange and self:GetDistance(StartPos, PredPos) < self.QRange + self.ERange then
                Engine:CastSpell("HK_SPELL3", PredPos ,1)
                return
            end
            if self:GetDistance(StartPos, PredPos) < self.QRange then
                Engine:CastSpell("HK_SPELL3", Orbwalker.MovePosition ,1)
                return
            end
        end
    end
	if self.ComboUseW.Value == 1 and Engine:SpellReady("HK_SPELL2") then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.WRange, self.WSpeed, self.WWidth, self.WDelay, 0, true, self.WHitChance, 1)
        if PredPos ~= nil then
            if self:GetDistance(StartPos, PredPos) < self.QRange then
                Engine:CastSpell("HK_SPELL2", PredPos ,1)
                return
            end
        end
    end
end

function Gwen:Harass()
    local StartPos 	= myHero.Position
    if self.HarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos then
            Engine:CastSpell("HK_SPELL1", PredPos ,1)
            return       
        end
    end
end

function Gwen:Laneclear()
    local StartPos 	= myHero.Position
    if self.ClearQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and myHero.Ammo > 3 then
        local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, true, self.QHitChance, 1)
        if PredPos == nil then
            local Target = Orbwalker:GetTarget("Laneclear", self.QRange)
            if Target and Target.IsMinion then
                local PredPos = Prediction:GetPredPos(StartPos, Target, self.QSpeed, self.QDelay)
                if PredPos and self:GetDistance(StartPos, PredPos) < self.QRange then
                    Engine:CastSpell("HK_SPELL1", PredPos ,1)
                    return       
                end
            end
        end
    end
    if self.ClearHarassQ.Value == 1 and Engine:SpellReady("HK_SPELL1") and myHero.Ammo > 3 then
        local PredPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, self.QWidth, self.QDelay, 0, true, self.QHitChance, 1)
        if PredPos then
            Engine:CastSpell("HK_SPELL1", PredPos ,1)
            return       
        end
    end
end

function Gwen:DrawDmg()
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			local Damages = {}
			table.insert( Damages, {
				Damage = DamageLib.Gwen:GetAADmg(Hero, 0, true),
				Color = Colors.Pink,
			})

			if Engine:SpellReady(SpellKey.Q) then
				table.insert( Damages, {
					Damage = DamageLib.Gwen:GetQDmg(Hero),
					Color = Colors.Blue,
				})
			end

			if Engine:SpellReady(SpellKey.E) then
				table.insert( Damages, {
					Damage = DamageLib.Gwen:GetEDmg(Hero),
					Color = Colors.Pink,
				})
			end

            if Engine:SpellReady(SpellKey.R) then
				table.insert(Damages, {
					Damage = DamageLib.Gwen:GetRDmg(Hero),
					Color = Colors.PurpleDarker
				})
			end

            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
end

function Gwen:OnTick()
    if GameHud.Minimized == false and GameHud.ChatOpen == false and Orbwalker.Attack == 0 then
		if Engine:IsKeyDown("HK_COMBO") then
			Gwen:Combo()
		end
		if Engine:IsKeyDown("HK_HARASS") then
			Gwen:Harass()
		end
		if Engine:IsKeyDown("HK_LANECLEAR") then
            Gwen:Laneclear()
		end
	end
end

function Gwen:OnDraw()
    if self.DrawDamage.Value == 1 then
        self:DrawDmg()
    end
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
        Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
    end
	if Engine:SpellReady("HK_SPELL2") and self.DrawW.Value == 1 then
        Render:DrawCircle(myHero.Position, self.WRange ,255,200,55,255)
    end
    if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,0,255,0,255)
    end
    if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,255,0,0,255) 
    end
end



function Gwen:OnLoad()
    if(myHero.ChampionName ~= "Gwen") then return end
	AddEvent("OnSettingsSave" , function() Gwen:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Gwen:LoadSettings() end)


	Gwen:__init()
	AddEvent("OnTick", function() Gwen:OnTick() end)	
	AddEvent("OnDraw", function() Gwen:OnDraw() end)	
end

AddEvent("OnLoad", function() Gwen:OnLoad() end)	
