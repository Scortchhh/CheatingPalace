Kassadin = {}
function Kassadin:__init()	
	self.QRange = 650
	self.QSpeed = 1400
	self.QWidth = 80
	self.QDelay = 0.25


	self.WRange = myHero.AttackRange + 50
	self.WDelay = 0

	self.ERange = 600
	self.ESpeed = math.huge
	self.EWidth = 150
	self.EDelay = 0.25

	self.RRange = 550
	self.RSpeed = math.huge
	self.RWidth = 150
	self.RDelay = 0.25

	self.IRange = 600
	self.RBuff = 0

	self.EHitChance = 0.2
	self.RHitChance = 0.2

	self.KeyNames = {}

	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"

    self.ChampionMenu = Menu:CreateMenu("Kassadin")
	-------------------------------------------
	self.ComboMenu = self.ChampionMenu:AddSubMenu("Champsettings")
	self.KS = self.ComboMenu:AddCheckbox("KS outside Combo", 1)
	self.RKS = self.ComboMenu:AddCheckbox("Use long Ult for KS", 1)
	self.IgniteUsage = self.ComboMenu:AddCheckbox("Use Ignite in KS", 1)
	self.HarassMenu = self.ChampionMenu:AddSubMenu("Harass") 
    self.HarassQ = self.HarassMenu:AddCheckbox("Use Q in Harass", 1) 
    self.HarassW = self.HarassMenu:AddCheckbox("Use W in Harass", 1) 
    self.HarassE = self.HarassMenu:AddCheckbox("Use E in Harass", 1) 
	self.DrawMenu = self.ChampionMenu:AddSubMenu("Drawings")
    self.DrawQ = self.DrawMenu:AddCheckbox("DrawQ", 1)
    self.DrawE = self.DrawMenu:AddCheckbox("DrawE", 1)
	self.DrawR = self.DrawMenu:AddCheckbox("DrawR", 1)

	Kassadin:LoadSettings()
end

function Kassadin:SaveSettings()
	SettingsManager:CreateSettings("Kassadin")
	------------------------------------------------------------
	SettingsManager:AddSettingsGroup("Champsettings")
	SettingsManager:AddSettingsInt("KSontick", self.KS.Value)
	SettingsManager:AddSettingsInt("LongR", self.RKS.Value)
	SettingsManager:AddSettingsInt("ign", self.IgniteUsage.Value)

	SettingsManager:AddSettingsGroup("Harass")
    SettingsManager:AddSettingsInt("Use Q in Harass", self.HarassQ.Value)
    SettingsManager:AddSettingsInt("Use W in Harass", self.HarassW.Value)
    SettingsManager:AddSettingsInt("Use E in Harass", self.HarassE.Value)

	SettingsManager:AddSettingsGroup("Drawings")
	SettingsManager:AddSettingsInt("DrawQ", self.DrawQ.Value)
	SettingsManager:AddSettingsInt("DrawE", self.DrawE.Value)
	SettingsManager:AddSettingsInt("DrawR", self.DrawR.Value)
end

function Kassadin:LoadSettings()
	SettingsManager:GetSettingsFile("Kassadin")
	-------------------------------------------------------------
	self.KS.Value = SettingsManager:GetSettingsInt("Champsettings","KSontick")
	self.RKS.Value = SettingsManager:GetSettingsInt("Champsettings","LongR")
	self.IgniteUsage.Value = SettingsManager:GetSettingsInt("Champsettings","ign")

	self.HarassQ.Value = SettingsManager:GetSettingsInt("Harass","Use Q in Harass")
    self.HarassW.Value = SettingsManager:GetSettingsInt("Harass","Use W in Harass")
    self.HarassE.Value = SettingsManager:GetSettingsInt("Harass","Use E in Harass")  
	
	self.DrawQ.Value = SettingsManager:GetSettingsInt("Drawings","DrawQ")
	self.DrawE.Value = SettingsManager:GetSettingsInt("Drawings","DrawE")
	self.DrawR.Value = SettingsManager:GetSettingsInt("Drawings","DrawR")
end

function Kassadin:ManaCost(Spellslot)
	if Spellslot == 1 then
		return 65 + myHero:GetSpellSlot(0).Level * 5
	end
	if Spellslot == 3 then
		return 55 + myHero:GetSpellSlot(2).Level * 5
	end
	if Spellslot == 4 then
		if self.RBuff == 0 then
			return 50
		end
		if self.RBuff == 1 then
			return 100
		end
		if self.RBuff == 2 then
			return 200
		end
		if self.RBuff == 3 then
			return 400
		end
		if self.RBuff == 4 then
			return 800
		end
	end
end

function Kassadin:Damage(Spellslot)
	local AP = myHero.AbilityPower
	if Spellslot == 1 then
		return 35 + 0.7 * myHero.AbilityPower + 30 * myHero:GetSpellSlot(0).Level
	end
	if Spellslot == 2 then
		return 45 + 0.8 * myHero.AbilityPower + 25 * myHero:GetSpellSlot(1).Level
	end
	if Spellslot == 3 then
		return 55 + 0.8 * AP + 25 * myHero:GetSpellSlot(2).Level
	end
	if Spellslot == 4 then
		local lvl = myHero:GetSpellSlot(3).Level
		local Mana = myHero.MaxMana
		return 60 + 0.4 * AP + 0.02 * Mana + 20 * lvl + self.RBuff * (30 + 10 * lvl + 0.01 * Mana + 0.1 * AP)
	end
	if Spellslot == 5 then --Ignite full damage
		return 50 + 20 * self:GetLevel()
	end
end

function Kassadin:RStacks()
	if Engine:SpellReady("HK_SPELL4") then
		local myBuffs = myHero.BuffData
		local RStacks = myBuffs:GetBuff("Riftwalk") --KassaRBuff
		if RStacks.Valid then
			self.RBuff = RStacks.Count_Alt
		else
			self.RBuff = 0
		end
	end
end

local function GetDist(source, target)
    return math.sqrt((target.x - source.x) ^ 2 + (target.z - source.z) ^ 2)
end

local function GetDamage(rawDmg, isPhys, target)
    if isPhys then
        local Lethality = myHero.ArmorPenFlat * (0.6 + 0.4 * target.Level / 18)
        local realArmor = target.Armor * myHero.ArmorPenMod
        local FinalArmor = (realArmor - Lethality)
        return (100 / (100 + FinalArmor)) * rawDmg 
    end
    if not isPhys then
        local realMR = target.MagicResist * myHero.MagicPenMod
        return (100 / (100 + realMR)) * rawDmg
    end
    return 0
end

local function ValidTarget(target,distance)
    if(target.IsDead == true) then return false end
    if(target.IsTargetable ~= true) then return false end
    return true
end

local function GetAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 50
    return attRange
end

function Kassadin:TargetIsImmune(currentTarget)
    local ImmuneBuffs = {
        "KayleR", "TaricR", "KarthusDeathDefiedBuff", "KindredRNoDeathBuff", "UndyingRage"
    }
    for i = 1, #ImmuneBuffs do
        local Buff = ImmuneBuffs[i]
		if currentTarget.BuffData:GetBuff(Buff).Valid then
			return true
		end
	end
	return false
end

function Kassadin:GetSummonerKey(SummonerName)
	for i = 4 , 5 do
		if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Kassadin:GetLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Kassadin:CastQ(target)
	if GetDist(myHero.Position, target.Position) < self.QRange then
		Engine:CastSpell("HK_SPELL1", target.Position, 1)
	end
end

function Kassadin:CastE(target)
	local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, false, self.EHitChance, 0)
	if GetDist(myHero.Position, PredPos) < self.ERange then
		Engine:CastSpell("HK_SPELL3", PredPos, 0)
	end
end

function Kassadin:CastEI(target)
	-- add check for ignite
	local tg = target
	local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.ERange, self.ESpeed, self.EWidth, self.EDelay, 0, false, self.EHitChance, 0)
	if GetDist(myHero.Position, PredPos) < self.ERange then
		Engine:CastSpell("HK_SPELL3", PredPos, 0)
		self:UseIgnite(tg)
	end
end

function Kassadin:CastR(target, gapclose)
	if gapclose == false then
		local PredPos, Target = Prediction:GetCastPos(myHero.Position, self.RRange, self.RSpeed, self.RWidth, self.RDelay, 0, false, self.RHitChance, 0)
		if GetDist(myHero.Position, PredPos) < self.RRange then
			Engine:CastSpell("HK_SPELL4", PredPos, 0)
		end
	else
		Engine:CastSpell("HK_SPELL4", target.Position, 0)
	end
end

function Kassadin:UseIgnite(target)
	Engine:CastSpell(self.IgniteKey, target.Position, 1)
end

function Kassadin:Killsteal()
	Kassadin:RStacks()

	local qm = self:ManaCost(1)
	local em = self:ManaCost(3)
	local rm = self:ManaCost(4)
	local m = myHero.Mana
	local q = Engine:SpellReady("HK_SPELL1")
	local e = Engine:SpellReady("HK_SPELL3")
	local r = Engine:SpellReady("HK_SPELL4")
	local qr = self.QRange
	local er = self.ERange
	local rr = self.RRange
	if self.IgniteUsage.Value == 1 then
		self.IgniteKey					= self:GetSummonerKey("SummonerDot")	
		if self.IgniteKey	 ~= nil then
			self.IgniteUp = Engine:SpellReady(self.IgniteKey)
			self.IgniteDamage = self:Damage(5)
		else
			self.IgniteUp = false
			self.IgniteDamage = 0
		end
	else
		self.IgniteUp = false
		self.IgniteDamage = 0
	end

	local Enemies = ObjectManager.HeroList
	for i, target in pairs(Enemies) do
		if target.Team ~= myHero.Team then
			if ValidTarget(target) then
				if self:TargetIsImmune(target) == false then
					local hp = target.Health
					local d = GetDist(myHero.Position, target.Position)
					local qd = GetDamage(self:Damage(1), false, target)
					local ed = GetDamage(self:Damage(3), false, target)
					local rd = GetDamage(self:Damage(4), false, target)
					local iup = self.IgniteUp
					local id = self.IgniteDamage
					local ir = self.IRange

					if q and hp < qd and d < qr then
						self:CastQ(target)
						return
					end

					if e and hp < ed and d < er then
						self:CastE(target)
						return
					end

					if r and hp < rd and d < rr then
						self:CastR(target)
						return
					end

					if q and e and hp < qd + ed and m > qm + em and d < er and m > qm + em then
						self:CastE(target)
						return
					end

					if q and iup and not r and hp < qd + id and d < ir then
						self:CastQ(target)
						self:UseIgnite(target)
						return
					end

					if e and iup and not r and hp < ed + id and d < ir then
						self:CastEI(target)
						return
					end

					if e and iup and q and not r and hp < ed + id + qd and d < ir then
						self:CastE(target)
						return
					end

					if r and q and hp < qd + rd and d < rr then
						self:CastQ(target)
						return
					end

					if r and e and hp < ed + rd and d < rr then
						self:CastR(target)
						return
					end

					if r and q and e and hp < qd + ed + rd and d < er and m > qm + em + rm then
						self:CastQ(target)
						return
					end

					if r and q and e and iup and hp < qd + ed + rd + id and d < er and m > qm + em + rm then
						self:CastQ(target)
						return
					end

					if self.RKS.Value == 1 then
						if q and r and d > qr and d < qr + rr and hp < qd and m > rm + qm then
							self:CastR(target, true)
							return
						end
	
						if q and r and e and d > er and d < rr + er and hp < qd + ed and m > rm + qm + em then
							self:CastR(target, true)
							return
						end
					end
					if iup and hp < id and d < ir then
						self:UseIgnite(target)
						return
					end
				end
			end
		end
	end
end

function Kassadin:Combo()

	Kassadin:RStacks()

	local qm = self:ManaCost(1)
	local em = self:ManaCost(3)
	local rm = self:ManaCost(4)
	local m = myHero.Mana
	local q = Engine:SpellReady("HK_SPELL1")
    local w = Engine:SpellReady("HK_SPELL2")
	local e = Engine:SpellReady("HK_SPELL3")
	local r = Engine:SpellReady("HK_SPELL4")
	local qr = self.QRange
	local er = self.ERange
	local rr = self.RRange

	if self.IgniteUsage.Value == 1 then
		self.IgniteKey					= self:GetSummonerKey("SummonerDot")	
		if self.IgniteKey	 ~= nil then
			self.IgniteUp = Engine:SpellReady(self.IgniteKey)
			self.IgniteDamage = self:Damage(5)
		else
			self.IgniteUp = false
			self.IgniteDamage = 0
		end
	else
		self.IgniteUp = false
		self.IgniteDamage = 0
	end

	if w then
		local WTarget = Orbwalker:GetTarget("Combo", 600)
        if Orbwalker.ResetReady == 1 then
            Engine:CastSpell("HK_SPELL2", nil ,1)
            return
        end
		if not q and not e and not r and WTarget and GetDist(myHero.Position, WTarget.Position) <= myHero.AttackRange + 250 then
            Engine:CastSpell("HK_SPELL2", nil ,1)
            return
		end
    end

	local Enemies = ObjectManager.HeroList
	for i, target in pairs(Enemies) do
		if target.Team ~= myHero.Team then
			if ValidTarget(target) then
				if self:TargetIsImmune(target) == false then
					local hp = target.Health
					local d = GetDist(myHero.Position, target.Position)
					local qd = GetDamage(self:Damage(1), false, target)
					local wd = GetDamage(self:Damage(2), false, target)
					local ed = GetDamage(self:Damage(3), false, target)
					local rd = GetDamage(self:Damage(4), false, target)
					local iup = self.IgniteUp
					local id = self.IgniteDamage
					local ir = self.IRange
					local wr = self.WRange

					if q and hp < qd and d < qr then
						self:CastQ(target)
						return
					end

					if e and hp < ed and d < er then
						self:CastE(target)
						return
					end

					if r and hp < rd and d < rr then
						self:CastR(target)
						return
					end

					if r and w and hp < rd + wd and d < rr then
						self:CastR(target)
						return
					end

					if q and iup and not r and hp < qd + id and d < ir then
						self:CastQ(target)
						self:UseIgnite(target)
						return
					end

					if e and iup and not r and hp < ed + id and d < ir then
						self:CastEI(target)
						return
					end

					if e and iup and q and not r and hp < ed + id + qd and d < ir then
						self:CastE(target)
						return
					end

					if self.RKS.Value == 1 then
						if q and r and d > qr and d < qr + rr and hp < qd and m > rm + qm then
							self:CastR(target, true)
							return
						end
	
						if q and r and e and d > er and d < rr + er and hp < qd + ed and m > rm + qm + em then
							self:CastR(target, true)
							return
						end
					end
					if iup and not q and not r and hp < id and d < ir then
						if d < wr and w then
								self:UseIgnite(target)
								return
						else
							self:UseIgnite(target)
							return
						end
					end
				end
			end
		end
	end

	if q then
		local target = Orbwalker:GetTarget("Combo", self.QRange)
		if target ~= nil then
			self:CastQ(target)
			return
		end
	end

	if r then
		local target = Orbwalker:GetTarget("Combo", self.RRange)
		if target ~= nil then
			self:CastR(target)
			return
		end
	end

	if e then
		local target = Orbwalker:GetTarget("Combo", self.ERange)
		if target ~= nil then
			self:CastE(target)
			return
		end
	end
end

function Kassadin:Harass()
	if Engine:SpellReady("HK_SPELL2") and self.HarassW.Value == 1 then
		if Orbwalker.DrawTarget and Orbwalker.DrawTarget.IsHero and Orbwalker.ResetReady == 1 then
			Engine:CastSpell("HK_SPELL2", nil ,1)
			return
		end
	end

	if Engine:SpellReady("HK_SPELL1") and self.HarassQ.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.QRange)
		if target ~= nil then
			self:CastQ(target)
			return
		end
	end

	if Engine:SpellReady("HK_SPELL3") and self.HarassE.Value == 1 then
		local target = Orbwalker:GetTarget("Combo", self.ERange)
		if target ~= nil then
			self:CastE(target)
			return
		end
	end
end

function Kassadin:OnTick()
	if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsDead == false then
		if myHero:GetSpellSlot(1).Level > 1 then
			Orbwalker.ExtraDamage = 20 + 0.1 * myHero.AbilityPower
		end

		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
			return
		end

		if self.KS.Value == 1 then
			self:Killsteal()
		end

		if Engine:IsKeyDown("HK_HARASS") then
			self:Harass()
			return
		end
	end
end

function Kassadin:OnDraw()
	if Engine:SpellReady("HK_SPELL1") and self.DrawQ.Value == 1 then
		Render:DrawCircle(myHero.Position, self.QRange ,100,150,255,255)
	end
	
	if Engine:SpellReady("HK_SPELL3") and self.DrawE.Value == 1 then
        Render:DrawCircle(myHero.Position, self.ERange ,100,150,255,255)
	end
	
	if Engine:SpellReady("HK_SPELL4") and self.DrawR.Value == 1 then
        Render:DrawCircle(myHero.Position, self.RRange ,100,150,255,255)
    end
end



function Kassadin:OnLoad()
    if(myHero.ChampionName ~= "Kassadin") then return end
	AddEvent("OnSettingsSave" , function() Kassadin:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() Kassadin:LoadSettings() end)


	Kassadin:__init()
	AddEvent("OnTick", function() Kassadin:OnTick() end)	
	AddEvent("OnDraw", function() Kassadin:OnDraw() end)	
end
AddEvent("OnLoad", function() Kassadin:OnLoad() end)	
