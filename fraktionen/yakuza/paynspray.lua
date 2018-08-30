-- 1013.9634399414, -321.48678588867, 73.9921875
local PNSMarker = createMarker(-1.0813270807266, -375.42263793945, 5.4296875, "corona", 2.0, 0, 255, 0, 255)

addEventHandler("onMarkerHit", PNSMarker,
function(hitElement)
	if not(getElementType(hitElement) == "vehicle") then return end
	local player = getVehicleOccupant ( hitElement )
	if not(player) then return end
	local veh = getPedOccupiedVehicle(player)
	if(getElementData(veh, "Besitzer") ~= "Yakuza") then outputChatBox("Du kannst nur Fraktionsautos der RB hier Reparieren!", player, 200, 0, 0) return end
	setElementFrozen(hitElement, true)
	toggleAllControls(player, false)
	setTimer(
		function()
		local x, y, z = getElementPosition(hitElement)		
		setCameraMatrix(player, -5.3012294769287, -368.49584960938, 6.296875, x, y, z)
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