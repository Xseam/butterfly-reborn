-- 1013.9634399414, -321.48678588867, 73.9921875
local PNSMarker = createMarker(1013.9634399414, -321.48678588867, 73.9921875, "corona", 2.0, 0, 255, 0, 255)

addEventHandler("onMarkerHit", PNSMarker,
function(hitElement)
	if not(getElementType(hitElement) == "vehicle") then return end
	local player = getVehicleOccupant ( hitElement )
	if not(player) then return end
	local veh = getPedOccupiedVehicle(player)
	if(getElementData(veh, "Besitzer") ~= "Red Brothers") then outputChatBox("Du kannst nur Fraktionsautos der RB hier Reparieren!", player, 200, 0, 0) return end
	setElementFrozen(hitElement, true)
	toggleAllControls(player, false)
	setTimer(
		function()
		local x, y, z = getElementPosition(hitElement)		
		setCameraMatrix(player, 1018.2877197266, -329.83715820313, 74.9921875, x, y, z)
		local smoker = createObject(2780, x, y, z)
		setElementCollisionsEnabled(smoker, false)
		setTimer(destroyElement, 4000, 1, smoker)
		setTimer(
			function()
			setElementHealth(hitElement, 1000)
			toggleAllControls(player, true)
			setElementFrozen(hitElement, false)
			setCameraTarget(player, player)
			fixVehicle(hitElement)
			setElementData(hitElement, "Schrott", 0)
			end, 4000, 1)
		
		end, 1000, 1)
end)