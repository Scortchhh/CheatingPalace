MapPositions = {}

function MapPositions:OutOfTurrets(Position)
    local Turrets = ObjectManager.TurretList
    local range = 88.5 + 750 + myHero.CharData.BoundingRadius / 2

    for _, Turret in pairs(Turrets) do
        if Turret.Team ~= myHero.Team and Turret.IsDead == false then
            if VectorCalculations:IsInRange(Position, Turret.Position, range) then
                return false
            end
        end
    end

    if VectorCalculations:IsInRange(Position, self:EnemyBaseCenterPos(), 1400) then
        return false
    end

    return true
end

function MapPositions:MyBaseCenterPos()
    if myHero.Team == 100 then
        return Vector3.new(54, 183, 86)
	else
        return Vector3.new(14625, 171, 14713)
	end
end

function MapPositions:EnemyBaseCenterPos()
    if myHero.Team == 100 then
        return Vector3.new(14625, 171, 14713)
	else
        return Vector3.new(54, 183, 86)	
    end
end

function MapPositions:MyBaseSpawn()
    if myHero.Team == 100 then
        return Vector3.new(400, 200, 400)
	else
        return Vector3.new(14400, 200, 14400)
	end
end

function MapPositions:EnemyBaseSpawn()
    if myHero.Team == 100 then
        return Vector3.new(14400, 200, 14400)
	else
        return Vector3.new(400, 200, 400)
	end
end