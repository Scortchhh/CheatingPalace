require("VectorCalculations")

local Roles =
{
    ["ADC"] =         {5,5,5,5,5},
    ["AP"] =          {5,5,5,4,4},
    ["MidAD"] =       {5,5,5,4,4},
    ["Support"] =     {5,5,4,3,3},
    ["Bruiser"] =     {5,4,4,3,2},
    ["Tank"] =        {5,4,3,2,1},
    ["FuckMeUpFam"] = {5,5,5,5,5},
}

local PriorityTable =
{
    ["Aatrox"] =       Roles.Bruiser,
    ["Ahri"] =         Roles.AP,
    ["Akali"] =        Roles.AP,
    ["Alistar"] =      Roles.Tank,
    ["Amumu"] =        Roles.Tank,
    ["Anivia"] =       Roles.AP,
    ["Annie"] =        Roles.AP,
    ["Aphelios"] =     Roles.ADC,
    ["Ashe"] =         Roles.ADC,
    ["AurelionSol"] =  Roles.AP,
    ["Azir"] =         Roles.AP,
    ["Bard"] =         Roles.Tank,
    ["Blitzcrank"] =   Roles.Tank,
    ["Brand"] =        Roles.AP,
    ["Braum"] =        Roles.Tank,
    ["Caitlyn"] =      Roles.ADC,
    ["Camille"] =      Roles.Tank,
    ["Cassiopeia"] =   Roles.AP,
    ["Chogath"] =      Roles.Tank,
    ["Corki"] =        Roles.ADC,
    ["Darius"] =       Roles.Tank,
    ["Diana"] =        Roles.AP,
    ["DrMundo"] =      Roles.Tank,
    ["Draven"] =       Roles.ADC,
    ["Ekko"] =         Roles.AP,
    ["Elise"] =        Roles.Bruiser,
    ["Evelynn"] =      Roles.AP,
    ["Ezreal"] =       Roles.ADC,
    ["FiddleSticks"] = Roles.AP,
    ["Fiora"] =        Roles.Bruiser,
    ["Fizz"] =         Roles.AP,
    ["Galio"] =        Roles.Tank,
    ["Gangplank"] =    Roles.Bruiser,
    ["Garen"] =        Roles.Tank,
    ["Gnar"] =         Roles.Tank,
    ["Gragas"] =       Roles.AP,
    ["Graves"] =       Roles.ADC,
    ["Hecarim"] =      Roles.Tank,
    ["Heimerdinger"] = Roles.AP,
    ["Illaoi"] =       Roles.Tank,
    ["Irelia"] =       Roles.Bruiser,
    ["Ivern"] =        Roles.Bruiser,
    ["Janna"] =        Roles.Support,
    ["JarvanIV"] =     Roles.Tank,
    ["Jax"] =          Roles.Bruiser,
    ["Jayce"] =        Roles.MidAD,
    ["Jhin"] =         Roles.ADC,
    ["Jinx"] =         Roles.ADC,
    ["Kaisa"] =        Roles.ADC,
    ["Kalista"] =      Roles.ADC,
    ["Karma"] =        Roles.Support,
    ["Karthus"] =      Roles.AP,
    ["Kassadin"] =     Roles.AP,
    ["Katarina"] =     Roles.AP,
    ["Kayle"] =        Roles.AP,
    ["Kayn"] =         Roles.Bruiser,
    ["Kindred"] =      Roles.ADC,
    ["Kennen"] =       Roles.AP,
    ["Khazix"] =       Roles.Bruiser,
    ["Kled"] =         Roles.Bruiser,
    ["KogMaw"] =       Roles.ADC,
    ["Leblanc"] =      Roles.AP,
    ["LeeSin"] =       Roles.Bruiser,
    ["Leona"] =        Roles.Tank,
    ["Lissandra"] =    Roles.AP,
    ["Lucian"] =       Roles.ADC,
    ["Lulu"] =         Roles.Support,
    ["Lux"] =          Roles.AP,
    ["Malphite"] =     Roles.Tank,
    ["Malzahar"] =     Roles.AP,
    ["Maokai"] =       Roles.Tank,
    ["MasterYi"] =     Roles.Bruiser,
    ["MissFortune"] =  Roles.ADC,
    ["MonkeyKing"] =   Roles.Bruiser,
    ["Mordekaiser"] =  Roles.AP,
    ["Morgana"] =      Roles.AP,
    ["Nami"] =         Roles.Support,
    ["Nasus"] =        Roles.Tank,
    ["Nautilus"] =     Roles.Tank,
    ["Neeko"] =        Roles.AP,
    ["Nidalee"] =      Roles.AP,
    ["Nocturne"] =     Roles.Bruiser,
    ["Nunu"] =         Roles.Tank,
    ["Olaf"] =         Roles.Bruiser,
    ["Orianna"] =      Roles.AP,
    ["Ornn"] =         Roles.Tank,
    ["Pantheon"] =     Roles.Bruiser,
    ["Poppy"] =        Roles.Bruiser,
    ["Pyke"] =         Roles.MidAD,
    ["Qiyana"] =       Roles.Bruiser,
    ["Quinn"] =        Roles.ADC,
    ["Rakan"]=         Roles.Tank,
    ["Rammus"] =       Roles.Tank,
    ["RekSai"] =       Roles.AP,
    ["Renekton"] =     Roles.Tank,
    ["Rengar"] =       Roles.Bruiser,
    ["Riven"] =        Roles.Bruiser,
    ["Rumble"] =       Roles.Bruiser,
    ["Ryze"] =         Roles.AP,
    ["Samira"] =       Roles.ADC,
    ["Sejuani"] =      Roles.Tank,
    ["Senna"] =        Roles.ADC,
    ["Seraphine"] =    Roles.AP,
    ["Sett"] =         Roles.Bruiser,
    ["Shaco"] =        Roles.AP,
    ["Shen"] =         Roles.Tank,
    ["Shyvana"] =      Roles.Tank,
    ["Singed"] =       Roles.Tank,
    ["Sion"] =         Roles.AP,
    ["Sivir"] =        Roles.ADC,
    ["Skarner"] =      Roles.Tank,
    ["Sona"] =         Roles.Support,
    ["Soraka"] =       Roles.FuckMeUpFam,
    ["Swain"] =        Roles.AP,
    ["Sylas"] =        Roles.AP,
    ["Syndra"] =       Roles.AP,
    ["TahmKench"] =    Roles.Tank,
    ["Taliyah"] =      Roles.AP,
    ["Talon"] =        Roles.MidAD,
    ["Taric"] =        Roles.Tank,
    ["Teemo"] =        Roles.AP,
    ["Thresh"] =       Roles.Tank,
    ["Tristana"] =     Roles.ADC,
    ["Trundle"] =      Roles.Tank,
    ["Tryndamere"] =   Roles.Bruiser,
    ["TwistedFate"] =  Roles.AP,
    ["Twitch"] =       Roles.ADC,
    ["Udyr"] =         Roles.Tank,
    ["Urgot"] =        Roles.ADC,
    ["Varus"] =        Roles.ADC,
    ["Vayne"] =        Roles.ADC,
    ["Veigar"] =       Roles.AP,
    ["Velkoz"] =       Roles.AP,
    ["Vi"] =           Roles.Bruiser,
    ["Viego"] =        Roles.MidAD,
    ["Viktor"] =       Roles.AP,
    ["Vladimir"] =     Roles.AP,
    ["Volibear"] =     Roles.Tank,
    ["Warwick"] =      Roles.Tank,
    ["Xerath"] =       Roles.AP,
    ["Xayah"] =        Roles.ADC,
    ["XinZhao"] =      Roles.Bruiser,
    ["Yasuo"] =        Roles.MidAD,
    ["Yorick"] =       Roles.Tank,
    ["Yuumi"] =        Roles.Support,
    ["Zac"] =          Roles.Tank,
    ["Zed"] =          Roles.MidAD,
    ["Ziggs"] =        Roles.AP,
    ["Zilean"] =       Roles.Support,
    ["Zoe"] =          Roles.AP,
    ["Zyra"] =         Roles.AP,
}

local function GetCountUniqueEnemies()
    local count = 0
    local existing = {}
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team then
            local name = Hero.ChampionName
            if not existing[name] then
                existing[name] = true
                count = count + 1
            end
        end
    end
    return count
end

AutoPriorities = {}

function AutoPriorities:OnTick()
    self:Load()
end

function AutoPriorities:GetPriority(ChampionName)
    local uniqueEnemyCount = GetCountUniqueEnemies()
    return PriorityTable[ChampionName] and PriorityTable[ChampionName][uniqueEnemyCount] or uniqueEnemyCount
end

function AutoPriorities:Load()
    if self.AutoPrioritiesLoaded == false then
        self.AutoPrioritiesLoaded = true
        for _, Hero in pairs(ObjectManager.HeroList) do
            if Hero.Team ~= myHero.Team and string.len(Hero.ChampionName) > 1 then
                local priority = self:GetPriority(Hero.ChampionName)
                Orbwalker.Prio[Hero.Index].Value = priority
                print("Priority Loaded: ", Hero.ChampionName, priority)
            end
        end
    end
end

function AutoPriorities:SortByClosestPossbileAttacking(Table)
    local Cache = {}
    for _, Object in pairs(Table) do
        Cache[#Cache + 1] = { 
			Comp = VectorCalculations:GetDistance(myHero.Position, Object.Position) - Object.AttackRange,
			Object = Object
		}
    end
    if #Cache > 1 then
        table.sort(Cache, function (left, right)
            return left.Comp < right.Comp
        end)
    end

	local SortedTable = {}

	for _, SortObject in pairs(Cache) do
        SortedTable[#SortedTable + 1] = SortObject.Object
    end

    return SortedTable
end

function AutoPriorities:DrawBestADPosition()
    local enemies = {}
    for _,Hero in pairs(ObjectManager.HeroList) do
        if Hero.Team ~= myHero.Team 
        and Hero.IsTargetable 
        and Hero.IsDead == false 
        and VectorCalculations:GetDistance(myHero.Position, Hero.Position) < (myHero.AttackRange + myHero.CharData.BoundingRadius) * 2 then
            table.insert(enemies, Hero)
        end
    end

    if #enemies > 0 then
        local closestThreat = self:SortByClosestPossbileAttacking(enemies)[1]
        local shouldBePosition = VectorCalculations:ClosestPointOnCircle(myHero.Position, closestThreat.Position, (myHero.AttackRange + myHero.CharData.BoundingRadius))
        Render:DrawCircle(shouldBePosition, 60,100,150,255,255)
        Render:DrawCircle(shouldBePosition, 50,100,150,255,255)
        Render:DrawCircle(shouldBePosition, 40,100,150,255,255)
    end

end

function AutoPriorities:__init()
    self.AutoPrioritiesLoaded = false

    self.AutoPrioritiesMenu = Menu:CreateMenu("AutoPriorities")
    self.DrawMenu = self.AutoPrioritiesMenu:AddSubMenu("Drawings")
    self.DrawSafePositionAD = self.DrawMenu:AddCheckbox("Draw Safe AD pos", 1)

    AutoPriorities:LoadSettings()
end

function AutoPriorities:SaveSettings()
    SettingsManager:CreateSettings("AutoPriorities")
	SettingsManager:AddSettingsGroup("Draw")
	SettingsManager:AddSettingsInt("DrawSafePositionAD", self.DrawSafePositionAD.Value)
end

function AutoPriorities:LoadSettings()
	SettingsManager:GetSettingsFile("AutoPriorities")
    self.DrawSafePositionAD.Value = SettingsManager:GetSettingsInt("Draw", "DrawSafePositionAD")
end

function AutoPriorities:OnDraw()
    if myHero.IsDead == true then return end
    if self.DrawSafePositionAD.Value == 1 then
        self:DrawBestADPosition()
    end
end

function AutoPriorities:OnLoad()
    AddEvent("OnSettingsSave" , function() self:SaveSettings() end)
	AddEvent("OnSettingsLoad" , function() self:LoadSettings() end)

    AutoPriorities:__init()
    AddEvent("OnTick", function() AutoPriorities:OnTick() end)
    AddEvent("OnDraw", function() self:OnDraw() end)	
end

AddEvent("OnLoad", function()
    AutoPriorities:OnLoad()
end)
