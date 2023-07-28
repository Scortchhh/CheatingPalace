require("SupportLib")
require("DamageLib")
Activator = {}
function Activator:__init()
	self.KeyNames = {}
	self.KeyNames[4] 		= "HK_SUMMONER1"
	self.KeyNames[5] 		= "HK_SUMMONER2"
	
	self.KeyNames[6] 		= "HK_ITEM1"
	self.KeyNames[7] 		= "HK_ITEM2"
	self.KeyNames[8] 		= "HK_ITEM3"
	self.KeyNames[9] 		= "HK_ITEM4"
	self.KeyNames[10] 		= "HK_ITEM5"
	self.KeyNames[11]		= "HK_ITEM6"


	self.SmiteTarget 		= nil
	self.CanBurstSmite 		= false
	self.AbilitiesToBurstSmite = {false,false,false,false}
	self.HasCastedAbility   = false
	self.qWaitTime			= nil
	self.wWaitTime			= nil
	self.eWaitTime			= nil

    self.ActivatorMenu = Menu:CreateMenu("Activator")
	-------------------------------------------
	self.ItemMenu           = self.ActivatorMenu:AddSubMenu("Items")
	self.UseRedemption		= self.ItemMenu:AddCheckbox("Redemption", 1)
	self.UseLocket			= self.ItemMenu:AddCheckbox("Locket", 1)
	self.UseShurelya		= self.ItemMenu:AddCheckbox("Shurelyas", 1)
	self.UseRanduin			= self.ItemMenu:AddCheckbox("Randuins", 1)
	self.UseGhostblade		= self.ItemMenu:AddCheckbox("Ghostblade", 1)
	self.UseProwler			= self.ItemMenu:AddCheckbox("Prowler", 1)
	self.UseChem			= self.ItemMenu:AddCheckbox("Chem Tank", 1)
	self.UseHextech			= self.ItemMenu:AddCheckbox("Hextech Rocketbelt", 1)
	self.UseStridebreaker	= self.ItemMenu:AddCheckbox("Stridebreaker", 1)
	self.UseGargoyle		= self.ItemMenu:AddCheckbox("Gargoyles", 1)
	self.UseGaleforce		= self.ItemMenu:AddCheckbox("Galeforce", 1)
	self.UseEverfrost		= self.ItemMenu:AddCheckbox("Everfrost", 1)
	self.UseGore			= self.ItemMenu:AddCheckbox("GoreDrinker", 1)
	self.UseQSS				= self.ItemMenu:AddCheckbox("QSS", 1)
	self.UseBlade			= self.ItemMenu:AddCheckbox("Blade", 1)
	self.UseSeraphs			= self.ItemMenu:AddCheckbox("Seraphs", 1)
	self.UseZhonyas			= self.ItemMenu:AddCheckbox("Zhonyas", 1)
	self.UseGunblade		= self.ItemMenu:AddCheckbox("Gunblade", 1)
	self.UseHydras			= self.ItemMenu:AddCheckbox("Hydras", 1)
    self.UsePotions			= self.ItemMenu:AddCheckbox("Potions", 1)
    self.PotInHarass        = self.ItemMenu:AddCheckbox("Potions in Harass", 1)
	self.AutoWard			= self.ItemMenu:AddCheckbox("AutoWard if enemy in FOW", 1)
	-------------------------------------------
	self.QSSMenu     		= self.ItemMenu:AddSubMenu("QSS Usage")
	self.QSS_Asleep			= self.QSSMenu:AddCheckbox("Asleep", 1)
	self.QSS_Blind			= self.QSSMenu:AddCheckbox("Blind", 1)
	self.QSS_Charm			= self.QSSMenu:AddCheckbox("Charm", 1)
	self.QSS_Fear			= self.QSSMenu:AddCheckbox("Fear", 1)
	self.QSS_Knockup		= self.QSSMenu:AddCheckbox("Knockup", 1)
	self.QSS_Stun			= self.QSSMenu:AddCheckbox("Stun", 1)
	self.QSS_Suppression	= self.QSSMenu:AddCheckbox("Suppression", 1)
	self.QSS_Taunt			= self.QSSMenu:AddCheckbox("Taunt", 1)
	self.QSS_Slow			= self.QSSMenu:AddCheckbox("Slow", 1)
	-------------------------------------------
	self.ItemSliderMenu     = self.ItemMenu:AddSubMenu("Item Percentages")
	self.RedemptionPercent	= self.ItemSliderMenu:AddSlider("Redemption at %", 100, 0, 100, 1)
	self.LocketPercent		= self.ItemSliderMenu:AddSlider("Locket at %", 100, 0, 100, 1)
	self.ShurelyaPercent	= self.ItemSliderMenu:AddSlider("Shurelyas at %", 100, 0, 100, 1)
	self.RanduinPercent		= self.ItemSliderMenu:AddSlider("Randuins at %", 100, 0, 100, 1)
	self.GhostbladePercent	= self.ItemSliderMenu:AddSlider("Ghostblade at %", 100, 0, 100, 1)
	self.ProwlerPercent		= self.ItemSliderMenu:AddSlider("Prowler at %", 100, 0, 100, 1)
	self.ChemPercent		= self.ItemSliderMenu:AddSlider("Turbo Chemtank at %", 100, 0, 100, 1)
	self.HextechPercent		= self.ItemSliderMenu:AddSlider("Hextech Rocketbelt at %", 100, 0, 100, 1)
	self.StridebreakerPercent	= self.ItemSliderMenu:AddSlider("Stridebreaker at %", 100, 0, 100, 1)
	self.GargoylePercent	= self.ItemSliderMenu:AddSlider("Gargoyles at %", 100, 0, 100, 1)
	self.GaleforcePercent	= self.ItemSliderMenu:AddSlider("Galeforce at %", 100, 0, 100, 1)
	self.EverfrostPercent	= self.ItemSliderMenu:AddSlider("Everfrost at %", 100, 0, 100, 1)
    self.BladePercent		= self.ItemSliderMenu:AddSlider("Blade at %", 50, 0, 100, 1)
    self.SeraphsPercent		= self.ItemSliderMenu:AddSlider("Seraphs at %", 35, 0, 100, 1)
	self.ZhonyasPercent		= self.ItemSliderMenu:AddSlider("Zhonyas at %", 20, 0, 100, 1)
	self.GunbladePercent	= self.ItemSliderMenu:AddSlider("Gunblade at %", 69, 0, 100, 1)
	self.HydrasPercent		= self.ItemSliderMenu:AddSlider("Hydras at %", 100, 0, 100, 1)
	-------------------------------------------
	self.PotionSliderMenu	= self.ItemMenu:AddSubMenu("Pot Precentages")
	self.HPotionPercent		= self.PotionSliderMenu:AddSlider("Health Potion at %", 35, 0, 100, 1)
	self.RePotionPercent	= self.PotionSliderMenu:AddSlider("Refill Potion at %", 20, 0, 100, 1)
	self.HCorruptPercent	= self.PotionSliderMenu:AddSlider("Corrupting at % Health", 35, 0, 100, 1)
	self.MCorruptPercent	= self.PotionSliderMenu:AddSlider("Corrupting at % Mana", 10, 0, 100, 1)
	self.BiscuitPercent		= self.PotionSliderMenu:AddSlider("Biscuit at % Mana or Health", 15, 0, 100, 1)
	-------------------------------------------
	self.SummonerMenu       = self.ActivatorMenu:AddSubMenu("Summoners")
    self.UseCleanse 		= self.SummonerMenu:AddCheckbox("Cleanse", 1)
	self.UseBarrier			= self.SummonerMenu:AddCheckbox("Barrier", 1)
	self.UseHeal 			= self.SummonerMenu:AddCheckbox("Heal", 1)
	self.UseIgnite 			= self.SummonerMenu:AddCheckbox("Ignite", 1)
	self.UseExhaust			= self.SummonerMenu:AddCheckbox("Exhaust", 1)
	self.UseSmite 			= self.SummonerMenu:AddCheckbox("Smite", 1)
	-------------------------------------------
	self.SmiteMenu     		= self.SummonerMenu:AddSubMenu("Smite Usage")
	self.AutomaticSmite		= self.SmiteMenu:AddCheckbox("Automatic Smite", 1)
	self.SmiteIfEnemy		= self.SmiteMenu:AddCheckbox("Only AutoSmite if enemy around camp", 0)
	self.AutomaticCamps    	= self.SmiteMenu:AddSubMenu("Camps to smite")
	self.AutomaticCampsToSmite = {}
	self.CampsToSmite = {
		"Blue",
		"Red",
		"Dragon",
		"Baron",
		"Rift",
		"Gromp",
		"Krug",
		"Murkwolf",
		"Razorbeak",
		"Crab"
		}
	for i, camp in pairs(self.CampsToSmite) do
		self.AutomaticCampsToSmite[camp]    	= self.AutomaticCamps:AddCheckbox("Smite: " .. camp, 1)
	end
	-------------------------------------------
	self.CleanseMenu     	= self.SummonerMenu:AddSubMenu("Cleanse Usage")
	self.Cleanse_Asleep		= self.CleanseMenu:AddCheckbox("Asleep", 1)
	self.Cleanse_Blind		= self.CleanseMenu:AddCheckbox("Blind", 1)
	self.Cleanse_Charm		= self.CleanseMenu:AddCheckbox("Charm", 1)
	self.Cleanse_Fear		= self.CleanseMenu:AddCheckbox("Fear", 1)
	self.Cleanse_Stun		= self.CleanseMenu:AddCheckbox("Stun", 1)
	self.Cleanse_Taunt		= self.CleanseMenu:AddCheckbox("Taunt", 1)
	self.Cleanse_Slow		= self.CleanseMenu:AddCheckbox("Slow", 1)
	self.Cleanse_Exhaust	= self.CleanseMenu:AddCheckbox("Exhaust", 1)
	-------------------------------------------
	self.SummonerSliderMenu = self.SummonerMenu:AddSubMenu("Summoner Percentages")
    self.BarrierPercent		= self.SummonerSliderMenu:AddSlider("Barrier at %", 35, 0, 100, 1)
    self.HealPercent		= self.SummonerSliderMenu:AddSlider("Heal at %", 30, 0, 100, 1)
    self.IgnitePercent		= self.SummonerSliderMenu:AddSlider("Ignite at %", 20, 0, 100, 1)
    self.ExhaustPercent		= self.SummonerSliderMenu:AddSlider("Exhaust at %", 60, 0, 100, 1)
	-------------------------------------------
	Activator:LoadSettings()
end

function Activator:SaveSettings()
	SettingsManager:CreateSettings("Activator")
	SettingsManager:AddSettingsGroup("Items")
	SettingsManager:AddSettingsInt("Redemption",	self.UseRedemption.Value)
	SettingsManager:AddSettingsInt("Locket",		self.UseLocket.Value)
	SettingsManager:AddSettingsInt("Shurelyas",		self.UseShurelya.Value)
	SettingsManager:AddSettingsInt("Randuins",		self.UseRanduin.Value)
	SettingsManager:AddSettingsInt("Ghostblade",	self.UseGhostblade.Value)
	SettingsManager:AddSettingsInt("Prowler",		self.UseProwler.Value)
	SettingsManager:AddSettingsInt("Chem Tank", 	self.UseChem.Value)
	SettingsManager:AddSettingsInt("Hextech Rocketbelt", self.UseHextech.Value)
	SettingsManager:AddSettingsInt("Stridebreaker", self.UseStridebreaker.Value)
	SettingsManager:AddSettingsInt("Gargoyles", 	self.UseGargoyle.Value)
	SettingsManager:AddSettingsInt("Galeforce", 	self.UseGaleforce.Value)
	SettingsManager:AddSettingsInt("Everfrost", 	self.UseEverfrost.Value)
	SettingsManager:AddSettingsInt("Gore", 			self.UseGore.Value)
	SettingsManager:AddSettingsInt("QSS", 			self.UseQSS.Value)
	SettingsManager:AddSettingsInt("Blade", 		self.UseBlade.Value)
	SettingsManager:AddSettingsInt("Seraphs", 		self.UseSeraphs.Value)
	SettingsManager:AddSettingsInt("Zhonyas", 		self.UseZhonyas.Value)
	SettingsManager:AddSettingsInt("Gunblade", 		self.UseGunblade.Value)
	SettingsManager:AddSettingsInt("Hydras", 		self.UseHydras.Value)
    SettingsManager:AddSettingsInt("Potions", 		self.UsePotions.Value)
    SettingsManager:AddSettingsInt("PotInHarras", 	self.PotInHarass.Value)
	SettingsManager:AddSettingsInt("AutoWard", 		self.AutoWard.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("QSS Usage")
	SettingsManager:AddSettingsInt("Asleep", 		self.QSS_Asleep.Value)
	SettingsManager:AddSettingsInt("Blind", 		self.QSS_Blind.Value)
	SettingsManager:AddSettingsInt("Charm", 		self.QSS_Charm.Value)
	SettingsManager:AddSettingsInt("Fear", 			self.QSS_Fear.Value)
	SettingsManager:AddSettingsInt("Knockup", 		self.QSS_Knockup.Value)
	SettingsManager:AddSettingsInt("Stun", 			self.QSS_Stun.Value)
	SettingsManager:AddSettingsInt("Suppression", 	self.QSS_Suppression.Value)
	SettingsManager:AddSettingsInt("Taunt", 		self.QSS_Taunt.Value)
	SettingsManager:AddSettingsInt("Slow", 			self.QSS_Slow.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Item Percentages")
	SettingsManager:AddSettingsInt("Redemption", 	self.RedemptionPercent.Value)
	SettingsManager:AddSettingsInt("Locket", 		self.LocketPercent.Value)
	SettingsManager:AddSettingsInt("Shurelyas", 	self.ShurelyaPercent.Value)
	SettingsManager:AddSettingsInt("Randuins", 		self.RanduinPercent.Value)
	SettingsManager:AddSettingsInt("Ghostblade", 	self.GhostbladePercent.Value)
	SettingsManager:AddSettingsInt("Prowler", 		self.ProwlerPercent.Value)
	SettingsManager:AddSettingsInt("Chem Tank", 	self.ChemPercent.Value)
	SettingsManager:AddSettingsInt("Hextech Rocketbelt", self.HextechPercent.Value)
	SettingsManager:AddSettingsInt("Stridebreaker", self.StridebreakerPercent.Value)
	SettingsManager:AddSettingsInt("Gargoyles", 	self.GargoylePercent.Value)
	SettingsManager:AddSettingsInt("Galeforce", 	self.GaleforcePercent.Value)
	SettingsManager:AddSettingsInt("Everfrost", 	self.EverfrostPercent.Value)
	SettingsManager:AddSettingsInt("BladeAt", 		self.BladePercent.Value)
	SettingsManager:AddSettingsInt("SeraphsAt", 	self.SeraphsPercent.Value)
	SettingsManager:AddSettingsInt("ZhonyasAt", 	self.ZhonyasPercent.Value)
	SettingsManager:AddSettingsInt("Gunblade", 		self.GunbladePercent.Value)
	SettingsManager:AddSettingsInt("Hydras", 		self.HydrasPercent.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Pot Precentages")
	SettingsManager:AddSettingsInt("HealthPotAt", 	self.HPotionPercent.Value)
	SettingsManager:AddSettingsInt("RefillAt", 		self.RePotionPercent.Value)
	SettingsManager:AddSettingsInt("HCorruptAt", 	self.HCorruptPercent.Value)
	SettingsManager:AddSettingsInt("MCorruptAt", 	self.MCorruptPercent.Value)
	SettingsManager:AddSettingsInt("BiscuitAt", 	self.BiscuitPercent.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Summoners")
	SettingsManager:AddSettingsInt("Cleanse", 		self.UseCleanse.Value)
	SettingsManager:AddSettingsInt("Barrier", 		self.UseBarrier.Value)
	SettingsManager:AddSettingsInt("Heal", 			self.UseHeal.Value)
	SettingsManager:AddSettingsInt("Ignite", 		self.UseIgnite.Value)
	SettingsManager:AddSettingsInt("Exhaust", 		self.UseExhaust.Value)
	SettingsManager:AddSettingsInt("Smite", 		self.UseSmite.Value)
	SettingsManager:AddSettingsInt("Automatic Smite",self.AutomaticSmite.Value)
	SettingsManager:AddSettingsInt("SmiteIfEnemy",self.SmiteIfEnemy.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Cleanse Usage")
	SettingsManager:AddSettingsInt("Asleep", 		self.Cleanse_Asleep.Value)
	SettingsManager:AddSettingsInt("Blind", 		self.Cleanse_Blind.Value)
	SettingsManager:AddSettingsInt("Charm", 		self.Cleanse_Charm.Value)
	SettingsManager:AddSettingsInt("Fear", 			self.Cleanse_Fear.Value)
	SettingsManager:AddSettingsInt("Stun", 			self.Cleanse_Stun.Value)
	SettingsManager:AddSettingsInt("Taunt", 		self.Cleanse_Taunt.Value)
	SettingsManager:AddSettingsInt("Slow", 			self.Cleanse_Slow.Value)
	-------------------------------------------
	SettingsManager:AddSettingsGroup("Summoner Percentages")
	SettingsManager:AddSettingsInt("BarrierAt", 	self.BarrierPercent.Value)
	SettingsManager:AddSettingsInt("HealAt", 		self.HealPercent.Value)
	SettingsManager:AddSettingsInt("IgniteAt", 		self.IgnitePercent.Value)
	SettingsManager:AddSettingsInt("ExhaustAt", 	self.ExhaustPercent.Value)
end

function Activator:LoadSettings()
	SettingsManager:GetSettingsFile("Activator")
	self.UseRedemption.Value 						= SettingsManager:GetSettingsInt("Items","Redemption")
	self.UseLocket.Value 							= SettingsManager:GetSettingsInt("Items","Locket")
	self.UseShurelya.Value 							= SettingsManager:GetSettingsInt("Items","Shurelyas")
	self.UseRanduin.Value 							= SettingsManager:GetSettingsInt("Items","Randuins")
	self.UseGhostblade.Value 						= SettingsManager:GetSettingsInt("Items","Ghostblade")
	self.UseProwler.Value 							= SettingsManager:GetSettingsInt("Items","Prowler")
	self.UseChem.Value 								= SettingsManager:GetSettingsInt("Items","Chem Tank")
	self.UseHextech.Value 							= SettingsManager:GetSettingsInt("Items","Hextech Rocketbelt")
	self.UseStridebreaker.Value 					= SettingsManager:GetSettingsInt("Items","Stridebreaker")
	self.UseGargoyle.Value 							= SettingsManager:GetSettingsInt("Items","Gargoyles")
	self.UseGaleforce.Value 						= SettingsManager:GetSettingsInt("Items","Galeforce")
	self.UseEverfrost.Value 						= SettingsManager:GetSettingsInt("Items","Everfrost")
	self.UseGore.Value 								= SettingsManager:GetSettingsInt("Items","Gore")
	self.UseQSS.Value 								= SettingsManager:GetSettingsInt("Items","QSS")
	self.UseBlade.Value 							= SettingsManager:GetSettingsInt("Items","Blade")
	self.UseSeraphs.Value 							= SettingsManager:GetSettingsInt("Items","Seraphs")
	self.UseZhonyas.Value 							= SettingsManager:GetSettingsInt("Items","Zhonyas")
	self.UseGunblade.Value 							= SettingsManager:GetSettingsInt("Items","Gunblade")
	self.UseHydras.Value 							= SettingsManager:GetSettingsInt("Items","Hydras")
    self.UsePotions.Value							= SettingsManager:GetSettingsInt("Items","Potions")
    self.PotInHarass.Value							= SettingsManager:GetSettingsInt("Items","PotInHarras")
	self.AutoWard.Value								= SettingsManager:GetSettingsInt("Items", "AutoWard")
	-------------------------------------------
	self.QSS_Asleep.Value							= SettingsManager:GetSettingsInt("QSS Usage","Asleep")
	self.QSS_Blind.Value							= SettingsManager:GetSettingsInt("QSS Usage","Blind")
	self.QSS_Charm.Value							= SettingsManager:GetSettingsInt("QSS Usage","Charm")
	self.QSS_Fear.Value								= SettingsManager:GetSettingsInt("QSS Usage","Fear")
	self.QSS_Knockup.Value							= SettingsManager:GetSettingsInt("QSS Usage","Knockup")
	self.QSS_Stun.Value								= SettingsManager:GetSettingsInt("QSS Usage","Stun")
	self.QSS_Suppression.Value						= SettingsManager:GetSettingsInt("QSS Usage","Suppression")
	self.QSS_Taunt.Value							= SettingsManager:GetSettingsInt("QSS Usage","Taunt")
	self.QSS_Slow.Value								= SettingsManager:GetSettingsInt("QSS Usage","Slow")
	-------------------------------------------
	self.RedemptionPercent.Value					= SettingsManager:GetSettingsInt("Item Percentages","Redemption")
	self.LocketPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Locket")
	self.ShurelyaPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Shurelyas")
	self.RanduinPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Randuins")
	self.GhostbladePercent.Value					= SettingsManager:GetSettingsInt("Item Percentages","Ghostblade")
	self.ProwlerPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Prowler")
	self.ChemPercent.Value							= SettingsManager:GetSettingsInt("Item Percentages","Chem Tank")
	self.HextechPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Hextech Rocketbelt")
	self.StridebreakerPercent.Value					= SettingsManager:GetSettingsInt("Item Percentages","Stridebreaker")
	self.GargoylePercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Gargoyles")
	self.GaleforcePercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Galeforce")
	self.EverfrostPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Everfrost")
    self.BladePercent.Value							= SettingsManager:GetSettingsInt("Item Percentages","BladeAt")
    self.SeraphsPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","SeraphsAt")
	self.ZhonyasPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","ZhonyasAt")
	self.GunbladePercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Gunblade")
	self.HydrasPercent.Value						= SettingsManager:GetSettingsInt("Item Percentages","Hydras")
	-------------------------------------------
	self.HPotionPercent.Value						= SettingsManager:GetSettingsInt("Pot Precentages","HealthPotAt")
    self.RePotionPercent.Value						= SettingsManager:GetSettingsInt("Pot Precentages","RefillAt")
	self.HCorruptPercent.Value						= SettingsManager:GetSettingsInt("Pot Precentages","HCorruptAt")
	self.MCorruptPercent.Value						= SettingsManager:GetSettingsInt("Pot Precentages","MCorruptAt")
	self.BiscuitPercent.Value						= SettingsManager:GetSettingsInt("Pot Precentages","BiscuitAt")
	-------------------------------------------
	self.UseHeal.Value 								= SettingsManager:GetSettingsInt("Summoners","Heal")
	self.UseBarrier.Value 							= SettingsManager:GetSettingsInt("Summoners","Barrier")
	self.UseIgnite.Value 							= SettingsManager:GetSettingsInt("Summoners","Ignite")
	self.UseExhaust.Value 							= SettingsManager:GetSettingsInt("Summoners","Exhaust")
	self.UseCleanse.Value 							= SettingsManager:GetSettingsInt("Summoners","Cleanse")
	self.UseSmite.Value 							= SettingsManager:GetSettingsInt("Summoners","Smite")
	self.AutomaticSmite.Value 						= SettingsManager:GetSettingsInt("Summoners","Automatic Smite")
	self.SmiteIfEnemy.Value 						= SettingsManager:GetSettingsInt("Summoners","SmiteIfEnemy")
	-------------------------------------------
	self.Cleanse_Asleep.Value						= SettingsManager:GetSettingsInt("Cleanse Usage","Asleep")
	self.Cleanse_Blind.Value						= SettingsManager:GetSettingsInt("Cleanse Usage","Blind")
	self.Cleanse_Charm.Value						= SettingsManager:GetSettingsInt("Cleanse Usage","Charm")
	self.Cleanse_Fear.Value							= SettingsManager:GetSettingsInt("Cleanse Usage","Fear")
	self.Cleanse_Stun.Value							= SettingsManager:GetSettingsInt("Cleanse Usage","Stun")
	self.Cleanse_Taunt.Value						= SettingsManager:GetSettingsInt("Cleanse Usage","Taunt")
	self.Cleanse_Slow.Value							= SettingsManager:GetSettingsInt("Cleanse Usage","Slow")
	-------------------------------------------
    self.BarrierPercent.Value						= SettingsManager:GetSettingsInt("Summoner Percentages","BarrierAt")
    self.HealPercent.Value							= SettingsManager:GetSettingsInt("Summoner Percentages","HealAt")
    self.IgnitePercent.Value						= SettingsManager:GetSettingsInt("Summoner Percentages","IgniteAt")
    self.ExhaustPercent.Value						= SettingsManager:GetSettingsInt("Summoner Percentages","ExhaustAt")
end

function Activator:GetDistance(from , to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function Activator:getAttackRange()
    local attRange = myHero.AttackRange + myHero.CharData.BoundingRadius + 20
    return attRange
end

function Activator:SortToLowestHealth(Table)
	local SortedTable = {}
	for _, Object in pairs(Table) do
		if Object.Health > 0 then
			SortedTable[#SortedTable + 1] = Object
		end
	end
	if #SortedTable > 1 then
		table.sort(SortedTable, function (left, right)
			return left.Health < right.Health
		end)
	end
	return SortedTable
end

function Activator:EnemiesInRange(Position, Range)
    local Count = 0 --FeelsBadMan
    local HeroList = ObjectManager.HeroList
    for i, Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and Hero.IsTargetable then
            if self:GetDistance(Hero.Position , Position) < Range then
                Count = Count + 1
            end
        end
    end
    return Count
end

function Activator:GetTarget(Range, HealthPercentage)
	local Heros = self:SortToLowestHealth(ObjectManager.HeroList)
	for I, Hero in pairs(Heros) do
		if Hero.Team ~= myHero.Team and Hero.IsTargetable then
			if self:GetDistance(Hero.Position, myHero.Position) < Range + myHero.CharData.BoundingRadius then
				local HPPercent = (Hero.Health / Hero.MaxHealth) * 100
				if HPPercent < HealthPercentage then
					return Hero
				end
			end
		end
	end	
	return nil
end
function Activator:GetExhaustTarget(Range, HealthPercentage)
	local Target = nil
	local Ally, Object = SupportLib:GetShieldTarget(Range, HealthPercentage/100)
	if Ally and Object then
		if Object.IsMissile then
			local Source = ObjectManager.HeroList[Object.SourceIndex]
			if Source and self:GetDistance(Source.Position, myHero.Position) < Range then
				return Source
			end
		end
		if Object.IsHero and self:GetDistance(Object.Position, myHero.Position) < Range  then
			return Object
		end
	end
	return Target
end
function Activator:GetAllItemNames()
	for i = 6 , 11 do
		print(myHero:GetSpellSlot(i).Info.Name)
	end
end

	-----------------ITEMS-----------------------
function Activator:GetItemKey(ItemName)
	for i = 6 , 11 do
		local Slot = myHero:GetSpellSlot(i)
		if Slot.Info.Name == ItemName then
			return self.KeyNames[i] , Slot.Charges 
		end
	end
	return nil
end
	
--ItemDarkCrystalFlask
--RegenerationPotion
--Item2010
--ItemCrystalFlask

function Activator:HPotions_Check()
	local Potions			= {}
			Potions.Key, Potions.Charges	= self:GetItemKey("Item2003") -- HealthPotion	
    if Potions.Key ~= nil then
        if not (myHero.BuffData:GetBuff("Item2003").Count_Alt > 0) then
            if Engine:SpellReady(Potions.Key) then
                local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
                if HPPercent < self.HPotionPercent.Value then
                    if self:EnemiesInRange(myHero.Position, 1000) >= 1 then
                        return Potions
                    end
                end
            end
        end
	end
	return false
end

function Activator:RePotions_Check()
	local Potions			= {}
			Potions.Key, Potions.Charges	= self:GetItemKey("ItemCrystalFlask") -- Refill Potion	
			--print(Potions.Charges)
    if Potions.Key ~= nil then
        if not (myHero.BuffData:GetBuff("ItemCrystalFlask").Count_Alt > 0) then
            if Engine:SpellReady(Potions.Key) then
                local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
                if HPPercent < self.RePotionPercent.Value then
                    if self:EnemiesInRange(myHero.Position, 1000) >= 1 then
                        return Potions
                    end
                end
            end
        end
	end
	return false
end

function Activator:CorrPotions_Check()
	local Potions			= {}
			Potions.Key, Potions.Charges	= self:GetItemKey("ItemDarkCrystalFlask") -- Corrupt Potion	
    if Potions.Key ~= nil then
        if not (myHero.BuffData:GetBuff("ItemDarkCrystalFlask").Count_Alt > 0) then
            if Engine:SpellReady(Potions.Key) then
                local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
                local ManaPercent = (myHero.Mana / myHero.MaxMana) * 100
                if HPPercent < self.HCorruptPercent.Value or ManaPercent < self.MCorruptPercent.Value then
                    if self:EnemiesInRange(myHero.Position, self:getAttackRange()) >= 1 then
                        return Potions
                    end
                end
            end
        end
	end
	return false
end

function Activator:Biscuit_Check()
	local Potions			= {}
			Potions.Key, Potions.Charges	= self:GetItemKey("Item2010") -- Biscuit	
    if Potions.Key ~= nil then
        if not (myHero.BuffData:GetBuff("Item2010").Count_Alt > 0) then
            if Engine:SpellReady(Potions.Key) then
                local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
                local ManaPercent = (myHero.Mana / myHero.MaxMana) * 100
                if HPPercent < self.BiscuitPercent.Value or ManaPercent < self.BiscuitPercent.Value then
                    if self:EnemiesInRange(myHero.Position, 1000) >= 1 then
                        return Potions
                    end
                end
            end
        end
	end
	return false
end

function Activator:Redemption_Check()
	local Redemption			= {}
			Redemption.Key				= self:GetItemKey("ItemRedemption")
	if Redemption.Key ~= nil then
		if Engine:SpellReady(Redemption.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.RedemptionPercent.Value then
				return Redemption
			end
		end
	end
	return false
end

function Activator:Locket_Check()
	local Locket			= {}
			Locket.Key				= self:GetItemKey("3190Active")
	if Locket.Key ~= nil then
		if Engine:SpellReady(Locket.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.LocketPercent.Value then
				return Locket
			end
		end
	end
	return false
end

function Activator:Shurelya_Check()
	local Shurelya 					= {}
			Shurelya.Key				= self:GetItemKey("2065Active")	
	if Shurelya.Key ~= nil then
		if Engine:SpellReady(Shurelya.Key) then
			Shurelya.Target 			= self:GetTarget(1000, self.ShurelyaPercent.Value)
			if Shurelya.Target ~= nil then
				return Shurelya
			end
		end
	end
	return false
end

function Activator:Randuin_Check()
	local Randuin 					= {}
			Randuin.Key				= self:GetItemKey("RanduinsOmen")	
	if Randuin.Key ~= nil then
		if Engine:SpellReady(Randuin.Key) then
			Randuin.Target 			= self:GetTarget(400, self.RanduinPercent.Value)
			if Randuin.Target ~= nil then
				return Randuin
			end
		end
	end
	return false
end

function Activator:Ghostblade_Check()
	local Ghostblade 					= {}
			Ghostblade.Key				= self:GetItemKey("YoumusBlade")	
	if Ghostblade.Key ~= nil then
		if Engine:SpellReady(Ghostblade.Key) then
			Ghostblade.Target 			= self:GetTarget(1000, self.GhostbladePercent.Value)
			if Ghostblade.Target ~= nil then
				return Ghostblade
			end
		end
	end
	return false
end

function Activator:Prowler_Check()
	local Prowler 					= {}
			Prowler.Key				= self:GetItemKey("6693Active")	
	if Prowler.Key ~= nil then
		if Engine:SpellReady(Prowler.Key) then
			Prowler.Target 			= self:GetTarget(500, self.ProwlerPercent.Value)
			if Prowler.Target ~= nil then
				return Prowler
			end
		end
	end
	return false
end

function Activator:Chem_Check()
	local Chem 					= {}
			Chem.Key				= self:GetItemKey("6664Active")	
	if Chem.Key ~= nil then
		if Engine:SpellReady(Chem.Key) then
			Chem.Target 			= self:GetTarget(800, self.ChemPercent.Value)
			if Chem.Target ~= nil then
				return Chem
			end
		end
	end
	return false
end

function Activator:Hextech_Check()
	local Hextech 					= {}
			Hextech.Key				= self:GetItemKey("3152Active")	
	if Hextech.Key ~= nil then
		if Engine:SpellReady(Hextech.Key) then
			Hextech.Target 			= self:GetTarget(800, self.HextechPercent.Value)
			if Hextech.Target ~= nil then
				return Hextech
			end
		end
	end
	return false
end

function Activator:Stridebreaker_Check()
	local Stridebreaker 					= {}
			Stridebreaker.Key				= self:GetItemKey("6029Active")	
	if Stridebreaker.Key == nil then
		Stridebreaker.Key 				= self:GetItemKey("6631Active")
	end
	if Stridebreaker.Key ~= nil then
		if Engine:SpellReady(Stridebreaker.Key) then
			Stridebreaker.Target 			= self:GetTarget(380, self.StridebreakerPercent.Value)
			if Stridebreaker.Target ~= nil then
				return Stridebreaker
			end
		end
	end
	return false
end

function Activator:Gargoyle_Check()
	local Gargoyle			= {}
			Gargoyle.Key				= self:GetItemKey("Item3193Active")
	if Gargoyle.Key ~= nil then
		if Engine:SpellReady(Gargoyle.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.GargoylePercent.Value then
				return Gargoyle
			end
		end
	end
	return false
end

function Activator:Galeforce_Check()
	local Galeforce 					= {}
			Galeforce.Key				= self:GetItemKey("6671Cast")	
	if Galeforce.Key ~= nil then
		if Engine:SpellReady(Galeforce.Key) then
			Galeforce.Target 			= self:GetTarget(425, self.GaleforcePercent.Value)
			if Galeforce.Target ~= nil then
				return Galeforce
			end
		end
	end
	return false
end

function Activator:Everfrost_Check()
	local Everfrost 					= {}
			Everfrost.Key				= self:GetItemKey("6656Cast")	
	if Everfrost.Key ~= nil then
		if Engine:SpellReady(Everfrost.Key) then
			Everfrost.Target 			= self:GetTarget(800, self.EverfrostPercent.Value)
			if Everfrost.Target ~= nil then
				return Everfrost
			end
		end
	end
	return false
end

function Activator:Gore_Check()
	local Gore 					= {}
			Gore.Key				= self:GetItemKey("6630Active")	
	if Gore.Key == nil then
		Gore.Key 				= self:GetItemKey("6029Active")
	end
	if Gore.Key ~= nil then
		if Engine:SpellReady(Gore.Key) then
			if self:EnemiesInRange(myHero.Position, 450) == 5 and myHero.Health <= myHero.MaxHealth / 100 * 60 then
				return Gore
			end
			if self:EnemiesInRange(myHero.Position, 450) == 4 and myHero.Health <= myHero.MaxHealth / 100 * 55 then
				return Gore
			end
			if self:EnemiesInRange(myHero.Position, 450) == 3 and myHero.Health <= myHero.MaxHealth / 100 * 45 then
				return Gore
			end
			if self:EnemiesInRange(myHero.Position, 450) == 2 and myHero.Health <= myHero.MaxHealth / 100 * 40 then
				return Gore
			end
			if self:EnemiesInRange(myHero.Position, 450) == 1 and myHero.Health <= myHero.MaxHealth / 100 * 35 then
				return Gore
			end
		end
	end
	return false
end

function Activator:QSS_Check()
	local QSS 					= {}
			QSS.Key				= self:GetItemKey("ItemMercurial")	
	if QSS.Key == nil then
			QSS.Key 			= self:GetItemKey("QuicksilverSash")
	end
	if QSS.Key == nil then
		QSS.Key 				= self:GetItemKey("6035_Spell")
	end
	if QSS.Key ~= nil then
		if Engine:SpellReady(QSS.Key) then
			local Mordeult 		= myHero.BuffData:GetBuff("mordekaiserr_statstealenemy")
			if Mordeult.Count_Alt > 0 then
				return QSS
			end
			if self.QSS_Asleep.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Asleep) == true then
					return QSS
				end
			end
			if self.QSS_Blind.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Blind) == true then
					return QSS
				end
			end
			if self.QSS_Charm.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Charm) == true then
					return QSS
				end
			end
			if self.QSS_Fear.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Fear) == true then
					return QSS
				end
			end
			if self.QSS_Knockup.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Knockup) == true then
					return QSS
				end
			end
			if self.QSS_Stun.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Stun) == true then
					return QSS
				end
			end
			if self.QSS_Suppression.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Suppression) == true then
					return QSS
				end
			end
			if self.QSS_Taunt.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Taunt) == true then
					return QSS
				end
			end
			if self.QSS_Slow.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Slow) == true then
					return QSS
				end
			end
		end
	end
	return false
end

function Activator:Blade_Check()
	local Blade 					= {}
			Blade.Key				= self:GetItemKey("ItemSwordOfFeastAndFamine")	
	if Blade.Key == nil then
			Blade.Key 				= self:GetItemKey("BilgewaterCutlass")
	end
	if Blade.Key ~= nil then
		if Engine:SpellReady(Blade.Key) then
			Blade.Target 			= self:GetTarget(500, self.BladePercent.Value)
			if Blade.Target ~= nil then
				return Blade
			end
		end
	end
	return false
end

function Activator:Seraphs_Check()
	local Seraphs			= {}
			Seraphs.Key				= self:GetItemKey("ItemSeraphsEmbrace")	
	if Seraphs.Key ~= nil then
		if Engine:SpellReady(Seraphs.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.SeraphsPercent.Value then
				return Seraphs
			end
		end
	end
	return false
end

function Activator:Zhonyas_Check()
	local Zhonyas			= {}
			Zhonyas.Key				= self:GetItemKey("Item2420") -- StopWatch	
	if Zhonyas.Key == nil then
			Zhonyas.Key 				= self:GetItemKey("ZhonyasHourglass")
	end
	if Zhonyas.Key ~= nil then
		if Engine:SpellReady(Zhonyas.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.ZhonyasPercent.Value then
				return Zhonyas
			end
		end
	end
	return false
end

function Activator:Gunblade_Check()
    local GBlade                     = {}
            GBlade.Key                = self:GetItemKey("HextechGunblade")
    if GBlade.Key ~= nil then
        if Engine:SpellReady(GBlade.Key) then
            GBlade.Target             = self:GetTarget(500, self.GunbladePercent.Value)
            if GBlade.Target ~= nil then
                return GBlade
            end
        end
    end
    return false
end
function Activator:Hydra_Check()
	local HA 					= {}
			HA.Key				= self:GetItemKey("ItemTiamatCleave")	
	if HA.Key == nil then
			HA.Key 				= self:GetItemKey("ItemTitanicHydraCleave")
	end
	if HA.Key ~= nil then
		if Engine:SpellReady(HA.Key) then
			HA.Target 			= self:GetTarget(425, self.HydrasPercent.Value)
			if HA.Target ~= nil then
				return HA
			end
		end
	end
	return false
end
	-----------------SUMMOMMER--------------------
function Activator:GetSummonerKey(SummonerName)
	for i = 4 , 5 do
		if string.find(myHero:GetSpellSlot(i).Info.Name, SummonerName) ~= nil  then
			return self.KeyNames[i]
		end
	end
	return nil
end

function Activator:Cleanse_Check()
	local Cleanse 					= {}
			Cleanse.Key				= self:GetSummonerKey("Boost")	
	if Cleanse.Key ~= nil then
		if Engine:SpellReady(Cleanse.Key) then
			if self.Cleanse_Exhaust.Value == 1 then
				if myHero.BuffData:GetBuff("SummonerExhaust").Valid then
					return Cleanse
				end
			end
			if self.Cleanse_Asleep.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Asleep) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Blind.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Blind) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Charm.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Charm) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Fear.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Fear) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Stun.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Stun) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Taunt.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Taunt) == true then
					return Cleanse
				end
			end
			if self.Cleanse_Slow.Value == 1 then
				if myHero.BuffData:HasBuffOfType(BuffType.Slow) == true then
					return Cleanse
				end
			end
		end
	end
	return false
end

function Activator:Barrier_Check()
	local Barrier			= {}
			Barrier.Key				= self:GetSummonerKey("Barrier")
	if Barrier.Key ~= nil then
		if Engine:SpellReady(Barrier.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.BarrierPercent.Value then
				return Barrier
			end
		end
	end
	return false
end

function Activator:Heal_Check()
	local Heal			= {}
			Heal.Key				= self:GetSummonerKey("Heal")
	if Heal.Key ~= nil then
		if Engine:SpellReady(Heal.Key) then
			local HPPercent = (myHero.Health / myHero.MaxHealth) * 100
			if HPPercent < self.HealPercent.Value then
				return Heal
			end
		end
	end
	return false
end
function Activator:Ignite_Check()
	local Ignite 					= {}
			Ignite.Key				= self:GetSummonerKey("Dot")	
	if Ignite.Key ~= nil then
		if Engine:SpellReady(Ignite.Key) then
			Ignite.Target 			= self:GetTarget(500, self.IgnitePercent.Value)
			if Ignite.Target ~= nil then
				return Ignite
			end
		end
	end
	return false
end

function Activator:Exhaust_Check()
	local Exhaust 					= {}
	Exhaust.Key				= self:GetSummonerKey("Exhaust")	
	if Exhaust.Key ~= nil then
		if Engine:SpellReady(Exhaust.Key) then
			Exhaust.Target 			= self:GetExhaustTarget(650, self.ExhaustPercent.Value)
			if Exhaust.Target ~= nil then
				return Exhaust
			end
		end
	end
	return false
end

function Activator:Combo()
	self:UseAutoWard()
	-----------------ITEMS-----------------------
	local Potions				= self:HPotions_Check() or self:RePotions_Check() or self:CorrPotions_Check() or self:Biscuit_Check()
	if self.UsePotions.Value == 1 and 	Potions 		~= false then
		Engine:ReleaseSpell(Potions.Key,nil)
		return
	end

	local Redemption					= self:Redemption_Check()
	if self.UseRedemption.Value 		== 1 and Redemption 			~= false then
		Engine:ReleaseSpell(Redemption.Key,myHero.Position)
		return
	end
	local Locket					= self:Locket_Check()
	if self.UseLocket.Value 		== 1 and Locket 			~= false then
		Engine:ReleaseSpell(Locket.Key,nil)
		return
	end
	local Gargoyle					= self:Gargoyle_Check()
	if self.UseGargoyle.Value 		== 1 and Gargoyle 			~= false then
		Engine:ReleaseSpell(Gargoyle.Key,nil)
		return
	end
	local Shurelya					= self:Shurelya_Check()
	if self.UseShurelya.Value 		== 1 and Shurelya 			~= false then
		Engine:ReleaseSpell(Shurelya.Key,nil)
		return
	end
	local Randuin					= self:Randuin_Check()
	if self.UseRanduin.Value 		== 1 and Randuin 			~= false then
		Engine:ReleaseSpell(Randuin.Key,nil)
		return
	end
	local Ghostblade					= self:Ghostblade_Check()
	if self.UseGhostblade.Value 		== 1 and Ghostblade 			~= false then
		Engine:ReleaseSpell(Ghostblade.Key,nil)
		return
	end
	local Prowler					= self:Prowler_Check()
	if self.UseProwler.Value 		== 1 and Prowler 			~= false then
		Engine:ReleaseSpell(Prowler.Key,Prowler.Target.Position)
		return
	end
	local Chem					= self:Chem_Check()
	if self.UseChem.Value 		== 1 and Chem 			~= false then
		Engine:ReleaseSpell(Chem.Key,nil)
		return
	end
	local Hextech					= self:Hextech_Check()
	if self.UseHextech.Value 		== 1 and Hextech 			~= false then
		Engine:ReleaseSpell(Hextech.Key,Hextech.Target.Position)
		return
	end
	local Stridebreaker					= self:Stridebreaker_Check()
	if self.UseStridebreaker.Value 		== 1 and Stridebreaker 			~= false then
		Engine:ReleaseSpell(Stridebreaker.Key,Stridebreaker.Target.Position)
		return
	end
	local Gargoyle					= self:Gargoyle_Check()
	if self.UseGargoyle.Value 		== 1 and Gargoyle 			~= false then
		Engine:ReleaseSpell(Gargoyle.Key,nil)
		return
	end
	
	local Galeforce					= self:Galeforce_Check()
	if self.UseGaleforce.Value 		== 1 and Galeforce 			~= false then
		Engine:ReleaseSpell(Galeforce.Key,Galeforce.Target.Position)
		return
	end
	local Everfrost					= self:Everfrost_Check()
	if self.UseEverfrost.Value 		== 1 and Everfrost 			~= false then
		Engine:ReleaseSpell(Everfrost.Key,Everfrost.Target.Position)
		return
	end
	local Gore 					= self:Gore_Check()
	if  self.UseGore.Value == 1 and		Gore 			~= false then
		Engine:ReleaseSpell(Gore.Key,nil)
		return
	end
	local QSS 					= self:QSS_Check()
	if self.UseQSS.Value 		== 1 and  QSS 			~= false then
		Engine:ReleaseSpell(QSS.Key,nil)
		return
	end
	local Blade					= self:Blade_Check()
	if self.UseBlade.Value 		== 1 and Blade 			~= false and Orbwalker.Attack == 0 then
		Engine:ReleaseSpell(Blade.Key,Blade.Target.Position)
		return
	end
	local Seraphs				= self:Seraphs_Check()
	if self.UseSeraphs.Value 	== 1 and Seraphs 		~= false then
		Engine:ReleaseSpell(Seraphs.Key,nil)
	end
	local Zhonyas				= self:Zhonyas_Check()
	if self.UseZhonyas.Value 	== 1 and Zhonyas 		~= false then
		Engine:ReleaseSpell(Zhonyas.Key,nil)
		return
	end	
	local GBlade                    = self:Gunblade_Check()
    if self.UseGunblade.Value         == 1 and GBlade             ~= false and Orbwalker.Attack == 0 then
        Engine:ReleaseSpell(GBlade.Key,GBlade.Target.Position)
        return
    end
	local HA					= self:Hydra_Check()
	if self.UseHydras.Value 		== 1 and HA 			~= false and Orbwalker.Attack == 0 then
		Engine:ReleaseSpell(HA.Key,HA.Target.Position)
		return
	end
	-----------------SUMMOMMER--------------------
	local Cleanse				= self:Cleanse_Check()
	if self.UseCleanse.Value 	== 1 and Cleanse 		~= false then
		Engine:ReleaseSpell(Cleanse.Key,nil)
		return
	end	
	local Barrier				= self:Barrier_Check()
	if self.UseBarrier.Value 	== 1 and Barrier 		~= false then
		Engine:ReleaseSpell(Barrier.Key,nil)
		return
	end
	local Heal					= self:Heal_Check()
	if self.UseHeal.Value 		== 1 and Heal 			~= false then
		Engine:ReleaseSpell(Heal.Key,nil)
		return
	end
	local Ignite				= self:Ignite_Check()
	if self.UseIgnite.Value 	== 1 and Ignite 		~= false and Orbwalker.Attack == 0 then
		Engine:ReleaseSpell(Ignite.Key,Ignite.Target.Position)
		return
	end	
	local Exhaust				= self:Exhaust_Check()
	if self.UseExhaust.Value 	== 1 and Exhaust 		~= false and Orbwalker.Attack == 0 then
		Engine:ReleaseSpell(Exhaust.Key,Exhaust.Target.Position)
		return
	end	
end

function Activator:UseAutoWard()
	if self.AutoWard.Value == 1 then
		local Heros = ObjectManager.HeroList
		for I, Hero in pairs(Heros) do
			if Hero.Team ~= myHero.Team then
				local Tracker = Awareness.Tracker[Hero.Index]
				if Tracker then
					local missingTime = GameClock.Time - Tracker.Map.LastSeen
					if missingTime >= 0.1 and missingTime <= 6 and not Hero.IsVisible then
						local Start     = Tracker.Map.LastPosition
						local End       = Hero.AIData.TargetPos
						local Vec       = Vector3.new(End.x - Start.x ,End.y - Start.y ,End.z - Start.z) 
						
						local Length    = Orbwalker:GetDistance(Start,End)
						local VecNorm   = Vector3.new(Vec.x / Length,Vec.y / Length,Vec.z / Length)
						local Mod         = Length / 2.3
						local Point
						local PointScreen             = Vector3.new()
						Point   = Vector3.new(Start.x + (VecNorm.x * Mod) , Start.y + (VecNorm.y * Mod) , Start.z + (VecNorm.z * Mod))    
						Render:World2Screen(Point, PointScreen)
						if Orbwalker:GetDistance(Point, myHero.Position) <= 600 and Orbwalker:GetDistance(Point, myHero.Position) > 0 then
							if Engine:SpellReady("HK_TRINKET") then
								Engine:CastSpell("HK_TRINKET", Point, nil)
							end
						end
					end
				end
			end
		end
	end
end

function Activator:Harass()
    local Potions				= self:HPotions_Check() or self:RePotions_Check() or self:CorrPotions_Check() or self:Biscuit_Check()
	if self.UsePotions.Value == 1 and 	Potions 		~= false and    self.PotInHarass.Value      == 1 then
		Engine:ReleaseSpell(Potions.Key,nil)
		return
	end
end

function Activator:GetSmiteTarget()
	local CampNames = {
	"SRU_Blue1.1.1",
	"SRU_Murkwolf2.1.1",
	"SRU_Razorbeak3.1.1",
	"SRU_Red4.1.1",
	"SRU_Krug5.1.1",
	"SRU_Dragon_Air",
	"SRU_Dragon_Fire",
	"SRU_Dragon_Water",
	"SRU_Dragon_Earth",
	"SRU_Dragon_Chemtech",
	"SRU_Dragon_Hextech",
	"SRU_Dragon_Ruined",
	"SRU_Dragon_Elder",
	"SRU_Blue7.1.1",
	"SRU_Murkwolf8.1.1",
	"SRU_Razorbeak9.1.1",
	"SRU_Red10.1.1",
	"SRU_Krug11.1.1",
	"SRU_Baron12.1.1",
	"SRU_Gromp13.1.1",
	"SRU_Gromp14.1.1",
	"Sru_Crab15.1.1",
	"Sru_Crab16.1.1",
	"SRU_RiftHerald17.1.1",
	}
	local MouseObject = Orbwalker.ForceTarget
	if MouseObject ~= nil and MouseObject.IsMinion == true and MouseObject.IsTargetable == true then
		for I, Name in pairs(CampNames) do
			if Name == MouseObject.Name then
				self.SmiteTarget = MouseObject
				return
			end
		end
	end
	local Smite 					= {}
	Smite.Key						= self:GetSummonerKey("Smite")	
	if self.AutomaticSmite.Value == 1 and Smite.Key ~= nil then
		local MinionList = ObjectManager.MinionList
		for I, Minion in pairs(MinionList) do
			for I, Name in pairs(CampNames) do
				if Name == Minion.Name then
					for i, campsToSmite in pairs(self.CampsToSmite) do
						if string.find(Minion.Name, campsToSmite) ~= nil then
							if self.AutomaticCampsToSmite[campsToSmite].Value == 1 then
								if self:GetDistance(myHero.Position, Minion.Position) <= 700 then
									self.SmiteTarget = Minion
									return
								end
							end
						end
					end
					-- if self:GetDistance(myHero.Position, Minion.Position) <= 500 then
					-- 	self.SmiteTarget = Minion
					-- 	return
					-- end
				end
			end
		end
	end
	if MouseObject == nil then
		self.SmiteTarget = nil
	end
end

function Activator:getHeroLevel()
    local levelQ = myHero:GetSpellSlot(0).Level
    local levelW = myHero:GetSpellSlot(1).Level
    local levelE = myHero:GetSpellSlot(2).Level
    local levelR = myHero:GetSpellSlot(3).Level
    return levelQ + levelW + levelE + levelR
end

function Activator:Smite_Check()
	local Smite 					= {}
	Smite.Key						= self:GetSummonerKey("Smite")	
	if Smite.Key ~= nil then
		if not Engine:SpellReady(Smite.Key) then
			self.CanBurstSmite = false
		end
		if Engine:SpellReady(Smite.Key) then
			if self.SmiteTarget ~= nil then
				--myHero.BuffData:ShowAllBuffs()
				if myHero.BuffData:GetBuff("SmiteDamageTracker").Count_Alt > 0 then
					Damage = 450
				else
					Damage = 900
				end
				if Damage ~= nil then
					local WaitDelay = 4
					local Health = self.SmiteTarget.Health
					local AA = myHero.BaseAttack + myHero.BonusAttack
					local qDmg = 0
					local wDmg = 0
					local eDmg = 0
					local totalDmg = 0
					if Engine:SpellReady("HK_SPELL1") or myHero:GetSpellSlot(0).Cooldown + WaitDelay >= GameClock.Time then
						if DamageLib[myHero.ChampionName] ~= nil then
							qDmg = DamageLib[myHero.ChampionName]:GetQDmg(self.SmiteTarget)
							local checkDmg = Damage + qDmg
							if Health <= checkDmg then
								self.AbilitiesToBurstSmite[1] = true
								if Engine:SpellReady("HK_SPELL1") then
									Damage = Damage + qDmg
								end
							end
						end
					else
						self.AbilitiesToBurstSmite[1] = false
					end
					if Engine:SpellReady("HK_SPELL2") or myHero:GetSpellSlot(1).Cooldown + WaitDelay >= GameClock.Time then
						if DamageLib[myHero.ChampionName] ~= nil then
							wDmg = DamageLib[myHero.ChampionName]:GetWDmg(self.SmiteTarget)
							local checkDmg = Damage + wDmg
							if Health <= checkDmg then
								self.AbilitiesToBurstSmite[2] = true
								if Engine:SpellReady("HK_SPELL2") then
									Damage = Damage + wDmg
								end
							end
						end
					else
						self.AbilitiesToBurstSmite[2] = false
					end
					if Engine:SpellReady("HK_SPELL3") or myHero:GetSpellSlot(2).Cooldown + WaitDelay >= GameClock.Time then
						if DamageLib[myHero.ChampionName] ~= nil then
							eDmg = DamageLib[myHero.ChampionName]:GetEDmg(self.SmiteTarget)
							local checkDmg = Damage + eDmg
							if Health <= checkDmg then
								self.AbilitiesToBurstSmite[3] = true
								if Engine:SpellReady("HK_SPELL3") then
									Damage = Damage + eDmg
								end
							end
						end
					else
						self.AbilitiesToBurstSmite[3] = false
					end
					-- print('qdmg', qDmg)
					-- print('wdmg', wDmg)
					-- print('edmg', eDmg)
					totalDmg = Damage + qDmg + wDmg + eDmg
					totalDmg = ((totalDmg - Damage) * 2) + Damage
					local ActivateBurstSmite = self.SmiteTarget.MaxHealth / 100 * 50
					if Health <= totalDmg or Health <= ActivateBurstSmite then
						self.CanBurstSmite = true
					end
					if Health <= Damage and self:GetDistance(self.SmiteTarget.Position, myHero.Position) <= 700 then
						Smite.Target = self.SmiteTarget
						return Smite
					end
				end
			end	
		end
	end
	return false
end

function Activator:AutoSmite()	
	local Smite 				= self:Smite_Check()
	if Engine:SpellReady(self:GetSummonerKey("Smite")) then
		if self.UseSmite.Value == 1 and Smite ~= false then
			if Smite.Target.Health <= 0 then return end
			local EnemiesAroundJungleCamp = Activator:EnemiesInRange(Smite.Target.Position, 800)
			local CampNames = {
				"SRU_Dragon_Air",
				"SRU_Dragon_Fire",
				"SRU_Dragon_Water",
				"SRU_Dragon_Earth",
				"SRU_Dragon_Chemtech",
				"SRU_Dragon_Hextech",
				"SRU_Dragon_Ruined",
				"SRU_Dragon_Elder",
				"SRU_Baron12.1.1",
				"SRU_RiftHerald17.1.1",
			}
			if self.SmiteIfEnemy.Value == 1 then
				if EnemiesAroundJungleCamp == 0 then return end
			end
			if self.AutomaticSmite.Value == 1 then
				if self.qWaitTime ~= nil then
					if GameClock.Time >= self.qWaitTime then
						Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
						self.qWaitTime = nil
					end
				end
				if self.wWaitTime ~= nil then
					if GameClock.Time >= self.wWaitTime then
						Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
						self.wWaitTime = nil
					end
				end
				if self.eWaitTime ~= nil then
					if GameClock.Time >= self.eWaitTime then
						Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
						self.eWaitTime = nil
					end
				end
				if self.AbilitiesToBurstSmite[1] == true and Engine:SpellReady("HK_SPELL1") then
					Engine:CastSpell("HK_SPELL1", Smite.Target.Position, 0)
					local delay = 0
					if Evade.Spells[myHero:GetSpellSlot(0).Info.Name] == nil then 
						delay = GameClock.Time + 0.25
					else
						delay = GameClock.Time + Evade.Spells[myHero:GetSpellSlot(0).Info.Name].Delay
					end
					self.qWaitTime = delay
				end
				if self.AbilitiesToBurstSmite[2] == true and Engine:SpellReady("HK_SPELL2") then
					Engine:CastSpell("HK_SPELL2", Smite.Target.Position, 0)
					local delay = 0
					if Evade.Spells[myHero:GetSpellSlot(1).Info.Name] == nil then 
						delay = GameClock.Time + 0.5
					else
						delay = GameClock.Time + Evade.Spells[myHero:GetSpellSlot(1).Info.Name].Delay
					end
					self.wWaitTime = delay
				end
				if self.AbilitiesToBurstSmite[3] == true and Engine:SpellReady("HK_SPELL3") then
					Engine:CastSpell("HK_SPELL3", Smite.Target.Position, 0)
					local delay = 0
					if Evade.Spells[myHero:GetSpellSlot(2).Info.Name] == nil then 
						delay = GameClock.Time + 0.25
					else
						delay = GameClock.Time + Evade.Spells[myHero:GetSpellSlot(2).Info.Name].Delay
					end
					self.eWaitTime = delay
				end
			else
				local Damage = 0
				if myHero.BuffData:GetBuff("SmiteDamageTracker").Count_Alt > 0 then
					Damage = 450
				else
					Damage = 900
				end
				if Smite.Target.Health <= Damage then
					Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
				end
			end
			-- if self.qWaitTime == nil and self.wWaitTime == nil and self.eWaitTime == nil then
			-- 	print('no')
			-- 	Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
			-- end
			if self.AutomaticSmite.Value == 1 then
				if Smite.Target.Health <= Damage then
					Engine:ReleaseSpell(Smite.Key,Smite.Target.Position)
				end
			end
		end
	end
end

function Activator:OnTick()
	self:GetSmiteTarget()
	if GameHud.Minimized == false and GameHud.ChatOpen == false and myHero.IsTargetable then
		self:AutoSmite()
		--Activator:GetAllItemNames()
		--myHero.BuffData:ShowAllBuffs()
		--print(myHero.BuffData:GetBuff("SmiteDamageTracker").Count_Alt)
		if Engine:IsKeyDown("HK_COMBO") then
			self:Combo()
        end
        if Engine:IsKeyDown("HK_HARASS") then
            self:Harass()
		end
	end
end

function Activator:OnDraw()
	if self.UseSmite.Value == 1 and self.SmiteTarget ~= nil then
		Render:DrawCircle(self.SmiteTarget.Position, 65, 255, 155 ,0 ,255)
		local vecOut = Vector3.new()
		if Render:World2Screen(self.SmiteTarget.Position, vecOut) == true then
			Render:DrawString("AutoSmite", vecOut.x - 40 , vecOut.y -5, 255, 155 ,0 ,255)
		end
	end
end



function Activator:OnLoad()
	AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)


	self:__init()
	AddEvent("OnTick", function() self:OnTick() end)	
	AddEvent("OnDraw", function() self:OnDraw() end)	
end

AddEvent("OnLoad", function() Activator:OnLoad() end)	
