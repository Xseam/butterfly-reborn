 -- Fuer Helis eigentlich --
 
-- Objects --
createObject(4642,349.01998901,-85.33999634,2.06999993,0.00000000,0.00000000,0.00000000) --object(paypark_lan) (1)
createObject(14826,373.30999756,-78.27999878,1.14999998,0.00000000,0.00000000,0.00000000) --object(int_kbsgarage2) (1)
createObject(11393,353.42999268,-78.83000183,1.90999997,0.00000000,0.00000000,90.00000000) --object(hubprops1_sfs) (1)
createObject(11392,361.27999878,-91.63999939,0.38000000,0.00000000,0.00000000,290.00000000) --object(hubfloorstains_sfse) (1)
createObject(11392,360.39001465,-94.23999786,0.38000000,0.00000000,0.00000000,89.99511719) --object(hubfloorstains_sfse) (2)

local PNSMarker = createMarker(361.72189331055, -90.354804992676, 1.3828125, "corona", 3.0, 0, 255, 0, 255)
local repairpreis = 50


addEventHandler("onMarkerHit", PNSMarker,
function(hitElement)
	if not(getElementType(hitElement) == "vehicle") then return end
	local player = getVehicleOccupant ( hitElement )
	if not(player) then return end
	if(getVehicleType(hitElement) == "Helicopter") or (getVehicleType(hitElement) == "Plane") then
	
	else
		outputChatBox("Dieses Paynspray ist nur fuer Helikopter und Flugzeuge!", player, 200, 0, 0)
		return
	end
	local money = getPlayerMoney(player)
	if(money < repairpreis+1) then outputChatBox("Du benoetigst "..repairpreis.." $, um dein Auto zu Reparieren!", player, 255, 0, 0, false) return end
	setElementFrozen(hitElement, true)
	toggleAllControls(player, false)
	setTimer(
		function()
		local x, y, z = getElementPosition(hitElement)		
		setCameraMatrix(player, 383.72964477539, -78.721618652344, 5.2942771911621, x, y, z)
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
			setElementData(hitElement, "Schrott", 0)
			end, 4000, 1)
		
		end, 1000, 1)
end
)
