VectorCalculations = {}

function VectorCalculations:IsInRange(pos1, pos2, range)
    if self:GetDistance(pos1,pos2) < range then
        return true
    end
    return false
end

function VectorCalculations:ClosestPointOnCircle(Position, CircleCenterPos, CircleRadius)
    local vX = Position.x - CircleCenterPos.x
    local vY = Position.z - CircleCenterPos.z 
    local magV = math.sqrt( vX^2 + vY^2 )
    local closestX = CircleCenterPos.x + vX / magV * CircleRadius
    local closestY = CircleCenterPos.z + vY / magV * CircleRadius

    return Vector3.new(closestX, 0, closestY)
end

function VectorCalculations:GetDistance(from, to)
    return math.sqrt((from.x - to.x) ^ 2 + (from.z - to.z) ^ 2)
end

function VectorCalculations:GetPointAtDistanceOnPath(source, target, distance)
    local totalDistance = self:GetDistance(source, target)
    local ratio = distance/totalDistance

    return 	Vector3.new(((1-ratio)*source.x + ratio * target.x), 0, ((1-ratio)*source.z + ratio*target.z))
end

function VectorCalculations:GetPointPathOnOppositeDirection(p1, p2, distance)
	local point = Vector3.new(p1.x*2 - p2.x, p1.y*2 - p2.y, p1.z*2 - p2.z)

	return self:GetPointAtDistanceOnPath(p1, point, distance)
end

function VectorCalculations:GetPointOnCircleAtDegrees(degrees, centerPoint, p1)
    if degrees < 0 then 
        degrees = degrees + 360
    end
    local radian     = degrees * math.pi / 180

    local newX = centerPoint.x + (p1.x - centerPoint.x) * math.cos(radian) - (p1.z - centerPoint.z) * math.sin(radian)
    local newZ = centerPoint.z + (p1.x - centerPoint.x) * math.sin(radian) + (p1.z - centerPoint.z) * math.cos(radian)

    return Vector3.new(newX, 0, newZ)
end