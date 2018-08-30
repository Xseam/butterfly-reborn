local PNSMarker = createMarker(319.03030395508, -21.335771560669, 1.6093755960464, "corona", 2.0, 0, 255, 0, 255)
local Gate = createObject(971, 318.75, -29.360000610352, -4, 0, 0, 0)
local Gatestatus = true

local repairpreis = 50


addEventHandler("onMarkerHit", PNSMarker,
function(hitElement)
	if(Gatestatus == false) then return end
	if not(getElementType(hitElement) == "vehicle") then return end
	local player = getVehicleOccupant ( hitElement )
	if not(player) then return end
	local money = getPlayerMoney(player)
	if(money < repairpreis+1) then outputChatBox("Du benoetigst "..repairpreis.." $, um dein Auto zu Reparieren!", player, 255, 0, 0, false) return end
	setElementFrozen(hitElement, true)
	toggleAllControls(player, false)
	Gatestatus = false
	local x, y, z = getElementPosition(Gate)
	moveObject(Gate,2000, x, y, z+6.5)
	setTimer(
		function()
		local x, y, z = getElementPosition(hitElement)		
		setCameraMatrix(player, 315.63619995117, -15.165273666382, 5.6073236465454, x, y, z)
		local smoker = createObject(2780, x, y, z)
		setElementCollisionsEnabled(smoker, false)
		setTimer(destroyElement, 4000, 1, smoker)
		setTimer(
			function()
			setElementHealth(hitElement, 1000)
			toggleAllControls(player, true)
			setElementFrozen(hitElement, false)
			setCameraTarget(player, player)
			triggerClientEvent(player,"aktualisiereMoney", player)
			givePlayerMoney(player, -repairpreis)
			fixVehicle(hitElement)
			setTimer(function() Gatestatus = true end, 2000, 1)
			local x, y, z = getElementPosition(Gate)
			moveObject(Gate, 2000, x, y, z-6.5)
			setElementData(hitElement, "Schrott", 0)
			end, 4000, 1)
		
		end, 1000, 1)
end)