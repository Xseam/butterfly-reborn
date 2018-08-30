local PNSMarker = createMarker(720.03558349609, -454.00378417969, 16.3359375, "corona", 2.0, 0, 255, 0, 255)
local repairpreis = 50
local garage = 47
setGarageOpen(garage, true)

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
	setGarageOpen(garage, false)
	setTimer(
		function()
		local x, y, z = getElementPosition(hitElement)		
		setCameraMatrix(player, 718.19635009766, -447.65710449219, 17.943704223633, x, y, z)
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
			setGarageOpen(garage, true)
			setElementData(hitElement, "Schrott", 0)
			end, 4000, 1)
		
		end, 1000, 1)
end)