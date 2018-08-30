local literpreis = 0

local Tankstellen = {
	[1] = "1383.6839599609, 461.44299316406, 20.116508483887", -- Montgomery
	[2] = "658.62017822266, -564.91180419922, 16.3359375", -- Dillimore
	[3] = "1002.059753418, -934.00030517578, 42.1796875" -- Mulholland
}



function recheck_vehicle_fuel(vehicle)
	if(getElementType(vehicle) == "vehicle") then
		local data = tonumber(getElementData(vehicle, "fuel"))
		if(data < 0.5) then 
			setVehicleEngineState(vehicle, false) 
			setElementData(vehicle, "motor", false)
			setElementData(vehicle, "fuel", 0)
			if(getVehicleOccupant(vehicle)) then outputChatBox("Dir ist der Treibstoff ausgegangen! Fahre zur einer Tankstelle, oder kaufe ein Kanister!", getVehicleOccupant(vehicle), 200, 0, 0, false)end return end
		if(getVehicleSpeed(vehicle) > 50) then
			setElementData(vehicle, "fuel", data-1)
		else
			setElementData(vehicle, "fuel", data-0.5)
		end
	end
end


setTimer(
function()
	for index, car in pairs(getElementsByType("vehicle")) do
		if(getElementData(car, "motor") == true) and (getElementData(car, "fuelable") == true) and (getElementData(car, "fuel")) then
			recheck_vehicle_fuel(car)
		end
	end
end, 15000, 0)

function getVehicleSpeed(theVehicle)
        local vx, vy, vz = getElementVelocity(theVehicle)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161 * 1.35
end

addEvent("onTankstelleFill", true)
addEventHandler("onTankstelleFill", getRootElement(),
function(veh, liter, preis)
	local playa = source
	setTimer(
		function()
			local geld = tonumber(getElementData(playa, "pHGeld"))
			setElementData(playa, "pHGeld", geld-preis)
			local vorhanden = tonumber(getElementData(veh, "fuel"))
			setElementData(veh, "fuel", vorhanden+liter)
			fadeCamera(playa, true, 1.5, 255, 255, 255)
			setCameraTarget(playa, playa)
			setElementFrozen(veh, false)
			toggleAllControls(playa, true)
			outputChatBox("In deinem Fahrzeug wurde "..liter.." Liter Kraftstoff fuer "..preis.."$ eingefuellt.", playa, 0, 200, 100)
		end, 2500, 1)
end)


function createTankstellen()
	literpreis = math.random(1, 7)
	for i = 1, #Tankstellen, 1 do
		local x, y, z = gettok(Tankstellen[i], 1, ","), gettok(Tankstellen[i], 2, ","), gettok(Tankstellen[i], 3, ",")
		local Marker = createMarker(x, y, z, "corona", 1.5, 0, 255, 255, 200)
		createBlip(x, y, z, 19, 2, 255, 0, 0, 255, 0, 300)
		addEventHandler("onMarkerHit", Marker,
		function(hitElement)
			if(getElementType(hitElement) ~= "player") then return end
			if(isPedInVehicle(hitElement) == false) then return end
			local veh = getPedOccupiedVehicle(hitElement)
			if(getElementData(veh, "Besitzer") == getPlayerName(hitElement)) then
				triggerClientEvent(hitElement, "onTankeEinfahr", hitElement, literpreis)
			else
				local frak = getPlayerFraktion(hitElement)
				if not(frak) or (frak == 0) then return end
				local frakname = fraktionNamen[frak]
				if(frakname == getElementData(veh, "Besitzer")) then
					triggerClientEvent(hitElement, "onTankeEinfahr", hitElement, literpreis)
					setElementData(veh, "motor", false)
					setVehicleEngineState(veh, false)
				end
			end
		end)
	end
	outputDebugString(#Tankstellen.." Tankstellen wurden erstellt.")
end

createTankstellen()