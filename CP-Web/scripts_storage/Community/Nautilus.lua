local Nautilus = {}
function Nautilus:__init()	
	self.QRange = 1100
	self.WRange = myHero.AttackRange + 50
	self.ERange = 600
	self.RRange = 825

	self.QSpeed = 2000
	self.WSpeed = math.huge
	self.ESpeed = math.huge
	self.RSpeed = math.huge

	self.QDelay = 0.25 
	self.WDelay = 0.75
	self.EDelay = 0.35
	self.RDelay = 0.25


    self.ChampionMenu = Menu:CreateMenu("Nautilus")
		-------------------------------------------
    self.ComboMenu = self.ChampionMenu:AddSubMenu("Combo")
    self.ComboUseQ = self.ComboMenu:AddCheckbox("UseQ", 1)
    self.ComboUseW = self.ComboMenu:AddCheckbox("UseW", 1)
    self.ComboUseE = self.ComboMenu:AddCheckbox("UseE", 1)
    self.ComboUseR = self.ComboMenu:AddCheckbox("UseR", 1)
		-------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.ComboMenu:AddCheckbox("DrawQ", 1)
    self.DrawW = self.ComboMenu:AddCheckbox("DrawW", 1)
    self.DrawE = self.ComboMenu:AddCheckbox("DrawE", 1)
    self.DrawR = self.ComboMenu:AddCheckbox("DrawR", 1)

	Nautilus:LoadSettings()
end

function Nautilus:SaveSettings()
	SettingsManager:CreateSettings("Nautilus")
	SettingsManager:AddSettingsGroup("Combo")
	SettingsManager:AddSettingsInt("UseQ", self.ComboUseQ.Value)
	SettingsManager:AddSettingsInt("UseW", self.ComboUseW.Value)
	SettingsManager:AddSettingsInt("UseE", self.ComboUseE.Value)
	SettingsManager:AddSettingsInt("UseR", self.ComboUseR.Value)
		-------------------------------------------
	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawW", self.DrawW.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)

end

function Nautilus:LoadSettings()
	SettingsManager:GetSettingsFile("Nautilus")
	self.ComboUseQ.Value = SettingsManager:GetSettingsInt("Combo","UseQ")
	self.ComboUseW.Value = SettingsManager:GetSettingsInt("Combo","UseW")
	self.ComboUseE.Value = SettingsManager:GetSettingsInt("Combo","UseE")
	self.ComboUseR.Value = SettingsManager:GetSettingsInt("Combo","UseR")
		------------------------------------------------------------
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawW.Value = SettingsManager:GetSettingsInt("Drawings","DrawW")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end


function Nautilus:GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

function Nautilus:WallcheckForQ(Position)
	local PlayerPos = myHero.Position
	local ToTargetVec = Vector3.new(Position.x - PlayerPos.x, Position.y - PlayerPos.y, Position.z - PlayerPos.z)

	local Distance = math.sqrt((ToTargetVec.x * ToTargetVec.x) + (ToTargetVec.y * ToTargetVec.y) + (ToTargetVec.z * ToTargetVec.z))
	local VectorNorm = Vector3.new(ToTargetVec.x / Distance, ToTargetVec.y / Distance, ToTargetVec.z / Distance)
	
	for Range = 25 , Distance, 25 do
		local CurrentPos = Vector3.new(PlayerPos.x + (VectorNorm.x*Range), PlayerPos.y + (VectorNorm.y*Range), PlayerPos.z + (VectorNorm.z*Range))
		if Engine:IsNotWall(CurrentPos) == false then
			return false
		end
	end
	
	return true	
end

function Nautilus:Combo()
	if Engine:SpellReady('HK_SPELL4') then
		if self.ComboUseR.Value == 1 then
			local RTarget = nil
			local target = Orbwalker:GetTarget("Combo", self.RRange)
			local castPos = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, 0, self.RDelay, 0)
            if castPos ~= nil then
				if RTarget then
					if Nautilus:GetDist(myHero.Position, Target.Position) > Nautilus:GetDist(myHero.Position, RTarget.Position) then
						RTarget = target
					end
				else
					RTarget = target
				end
            end
			
			if RTarget then
				Engine:CastSpell("HK_SPELL4", RTarget.Position)
				return
			end
		end
	end
	if Engine:SpellReady('HK_SPELL1') then
		if self.ComboUseQ.Value == 1 then
			local MyPos = myHero.Position
			local target = Orbwalker:GetTarget("Combo", self.QRange)
			local castPos = Prediction:GetCastPos(myHero.Position, self.QRange, self.QSpeed, 120, self.QDelay, 1)
			if castPos ~= nil then
				if Nautilus:GetDist(MyPos, target.Position) < self.QRange then
					if Nautilus:WallcheckForQ(castPos) then
						Engine:CastSpell("HK_SPELL1", castPos)
						return
					end
				end
			end
		end
	end
	if Engine:SpellReady('HK_SPELL2') then
		if self.ComboUseW.Value == 1 then
			local Target = Orbwalker:GetTarget("Combo", self.WRange)
			if Target then
				Engine:CastSpell("HK_SPELL2", GameHud.MousePos)
				return
			end
		end
	end
	if Engine:SpellReady('HK_SPELL3') then
		if self.ComboUseE.Value == 1 then
			local target = Orbwalker:GetTarget("Combo", self.QRange)
			local castPos = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, 0, self.EDelay, 0)
			if castPos ~= nil then
				if Nautilus:GetDist(myHero.Position, castPos) < self.ERange-50 then
					Engine:CastSpell("HK_SPELL3", castPos)
					return
				end
			end
		end
	end
end

function Nautilus:OnTick()
	if	Engine:IsKeyDown("HK_COMBO") and Orbwalker.Attack == 0 then
		Nautilus:Combo()
	end
end

function Nautilus:OnDraw()
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
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
    end
end


function Nautilus:OnLoad()
    if(myHero.ChampionName ~= "Nautilus") then return end
	AddEvent("OnSettingsSave" , function() Nautilus:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Nautilus:LoadSettings() end)


	Nautilus:__init()
	AddEvent("OnTick", function() Nautilus:OnTick() end)	
	AddEvent("OnDraw", function() Nautilus:OnDraw() end)	
end
AddEvent("OnLoad", function() Nautilus:OnLoad() end)