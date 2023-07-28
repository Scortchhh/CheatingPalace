Killable = {}
require("DamageLib")
local didPrintDebug = false

function Killable:__init()
    self.totalDamage = 0
    self.enemyTotalDamage = 0
    self.FightDuration = 10
end

function Killable:AADmg(Source, Target, HasInfinityEdge)
    local bonuscritDamage       = 0
    local krakenSlayerDmg       = 0
    local pressTheAttackDmg     = 0
    local sheenDmg              = 0

    local attackSpeed = Source.CharData.BaseAttackSpeed + (Source.AttackSpeedMod - 1)
    local AutoAttacksDuringTime = attackSpeed * self.FightDuration

    if BuffLib.Items:KrakenSlayer(Source) then
        krakenSlayerDmg = SpellDmg(ItemLib.KrakenSlayer, Target)
    end

    if HasInfinityEdge ~= nil and HasInfinityEdge then
        bonuscritDamage = bonuscritDamage + ItemLib.InfinityEdge:CritDmgMod()
    end

    if BuffLib.Items:Sheen(Source) then
        sheenDmg = SpellDmg(ItemLib.Sheen, Target)
    end
    local rawDmg = (Source.BaseAttack + Source.BonusAttack) * (1 + (Source.CritMod * (0.75 + bonuscritDamage))) + pressTheAttackDmg
    
    if Source.CritMod == 1.75 then -- main API broken
        rawDmg = (Source.BaseAttack + Source.BonusAttack) * (1 + (0* (0.75 + bonuscritDamage))) + pressTheAttackDmg
    end
    -- print('source', Source.ChampionName .. " Targets " .. Target.ChampionName .. " DMG " .. DamageLib:GetDamage(rawDmg, DamageType.PHYSICALDAMAGE, Target) + krakenSlayerDmg + sheenDmg)
    return (DamageLib:GetDamage(rawDmg, DamageType.PHYSICALDAMAGE, Target) * AutoAttacksDuringTime) + krakenSlayerDmg + sheenDmg
end 

function Killable:OnDraw()
    if myHero.IsDead then return end
    local HeroList = ObjectManager.HeroList
    for i,Hero in pairs(HeroList) do
        if Hero.Team ~= myHero.Team and DamageLib[Hero.ChampionName] == nil and not didPrintDebug then
            print("CHAMPION NOT YET SUPPORTED: ", Hero.ChampionName)
        end
        if Hero.Team ~= myHero.Team and Hero.IsTargetable and DamageLib[myHero.ChampionName] ~= nil and DamageLib[Hero.ChampionName] ~= nil then
            local Damages = {}
            local enemyDamages = {}
            -- my hero dmg

			table.insert( Damages, {
				Damage = self:AADmg(myHero, Hero, 0, true),
				Color = Colors.Pink,
			})

            table.insert( Damages, {
                Damage = DamageLib[myHero.ChampionName]:GetPassiveDmg(Hero),
                Color = Colors.Blue,
            })

			if Engine:SpellReady(SpellKey.Q) then
				table.insert( Damages, {
					Damage = DamageLib[myHero.ChampionName]:GetQDmg(myHero),
					Color = Colors.Blue,
				})
			end

            if Engine:SpellReady(SpellKey.W) then
				table.insert( Damages, {
					Damage = DamageLib[myHero.ChampionName]:GetWDmg(myHero),
					Color = Colors.Blue,
				})
			end

			if Engine:SpellReady(SpellKey.E) then
				table.insert( Damages, {
					Damage = DamageLib[myHero.ChampionName]:GetEDmg(myHero, 4),
					Color = Colors.Pink,
				})
			end

            if Engine:SpellReady(SpellKey.R) then
				table.insert(Damages, {
					Damage = DamageLib[myHero.ChampionName]:GetRDmg(myHero),
					Color = Colors.PurpleDarker
				})
			end

            -- enemy dmg
            table.insert( enemyDamages, {
                Kek = "AA",
				Damage = self:AADmg(Hero, myHero, 0, true),
				Color = Colors.Pink,
			})

            local Q = Awareness.Tracker[Hero.Index].Spells[0]
            local W = Awareness.Tracker[Hero.Index].Spells[1]
            local E = Awareness.Tracker[Hero.Index].Spells[2]
            local R = Awareness.Tracker[Hero.Index].Spells[3]

			if Q.Cooldown ~= nil and Q.Cooldown <= 0 then
				table.insert( enemyDamages, {
                    Kek = "Q",
					Damage = DamageLib[Hero.ChampionName]:GetQDmg(Hero),
					Color = Colors.Blue,
				})
			end
            if W.Cooldown ~= nil and W.Cooldown <= 0 then
				table.insert( enemyDamages, {
                    Kek = "W",
					Damage = DamageLib[Hero.ChampionName]:GetWDmg(Hero),
					Color = Colors.Pink,
				})
			end

			if E.Cooldown ~= nil and E.Cooldown <= 0 then
				table.insert( enemyDamages, {
                    Kek = "E",
					Damage = DamageLib[Hero.ChampionName]:GetEDmg(Hero),
					Color = Colors.Pink,
				})
			end

            if R.Cooldown ~= nil and R.Cooldown <= 0 then
				table.insert(enemyDamages, {
                    Kek = "R",
					Damage = DamageLib[Hero.ChampionName]:GetRDmg(Hero),
					Color = Colors.PurpleDarker
				})
			end


            local tempDmg = 0
            for _,DamageObject in pairs(Damages) do
                if DamageObject.Damage ~= nil and type(DamageObject.Damage) == "number" then
                    tempDmg = tempDmg + DamageObject.Damage
                end          
            end

            local tempEnemyDmg = 0
            for x,DamageObject in pairs(enemyDamages) do
                if DamageObject.Damage ~= nil and type(DamageObject.Damage) == "number" then
                    tempEnemyDmg = tempEnemyDmg + DamageObject.Damage
                    -- print(x, DamageObject.Damage .. " " .. DamageObject.Kek)
                end          
            end
            if tempDmg ~= self.totalDamage then
                self.totalDamage = tempDmg
            end
            -- print('2', tempEnemyDmg)
            -- print('1', enemyTotalDamage)
            if tempEnemyDmg ~= self.enemyTotalDamage then
                self.enemyTotalDamage = tempEnemyDmg
            end

            local finalDmg = math.floor(self.totalDamage)
            local finalEnemyDmg = math.floor(self.enemyTotalDamage)
            local DoIWinTrade = false
            local DoIKillEnemy = false
            local DoEnemyKillMe = false
            local myHeroHealthPercent = myHero.Health / myHero.MaxHealth
            local enemyHealthPercent = Hero.Health / Hero.MaxHealth
            if finalDmg > Hero.Health then
                DoIKillEnemy = true
            end
            if finalDmg > finalEnemyDmg then
                DoIWinTrade = true
            end
            if finalEnemyDmg > myHero.Health then
                DoEnemyKillMe = true
            end
            local vecOut = Vector3.new()
            if Render:World2Screen(Hero.Position, vecOut) then 
                if DoIKillEnemy then
                    if DoIWinTrade then
                        local differencePercentageHP = myHeroHealthPercent - enemyHealthPercent
                        if DoEnemyKillMe and differencePercentageHP >= 0.25 then -- 0.25 might need some tuning
                            Render:DrawString("YOU KILL THE ENEMY\nBUT ALSO DIE", vecOut.x - 50, vecOut.y - 235, Colors.GrayLight.R, Colors.GrayLight.G, 0, 255)
                        else
                            Render:DrawString("YOU KILL THE ENEMY", vecOut.x - 50, vecOut.y - 235, 0, Colors.GrayLight.G, 0, 255)
                        end
                    else
                        Render:DrawString("YOU LOSE THE TRADE\nBUT YOU KILL THE ENEMY", vecOut.x - 50, vecOut.y - 235, Colors.GrayLight.R, 0, 0, 255)
                    end
                else
                    if DoIWinTrade then
                        Render:DrawString("YOU WIN THE TRADE\nNOT ENOUGH DAMAGE TO KILL ENEMY", vecOut.x - 50, vecOut.y - 235, Colors.GrayLight.R, Colors.GrayLight.G, 0, 255)
                    else
                        if DoEnemyKillMe then
                            Render:DrawString("YOU LOSE THE TRADE\nYOU DIE:", vecOut.x - 50, vecOut.y - 235, Colors.GrayLight.R, 0, 0, 255)
                        else
                            Render:DrawString("YOU LOSE THE TRADE\nBUT SURVIVE", vecOut.x - 50, vecOut.y - 235, Colors.GrayLight.R, Colors.GrayLight.G, 0, 255)
                        end
                    end
                end
            end
            DamageLib:DrawDamageIndicator(Damages, Hero)
        end
    end
    if DamageLib[myHero.ChampionName] == nil and not didPrintDebug then
        print("THE CHARACTER YOU PLAY IS NOT YET SUPPORTED: ", myHero.ChampionName)
    end
    didPrintDebug = true
end

function Killable:OnLoad()
	AddEvent("OnDraw", function() Killable:OnDraw() end)	
    self:__init()
end

AddEvent("OnLoad", function() Killable:OnLoad() end)	
