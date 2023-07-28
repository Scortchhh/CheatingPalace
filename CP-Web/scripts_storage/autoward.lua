AutoWard = {}

function AutoWard:OnTick()
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

function AutoWard:OnLoad()
	AddEvent("OnTick", function() AutoWard:OnTick() end)	
end

AddEvent("OnLoad", function() AutoWard:OnLoad() end)	
