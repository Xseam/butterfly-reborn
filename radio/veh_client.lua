
--[[
addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(),
function(station)
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		
		if(veh) then

			if(getVehicleOccupant(veh) == gMe) then

				setElementData(veh, "radiochannel", station)
				for index, player in pairs(getVehicleOccupants(veh)) do
					triggerServerEvent("onVehicleRadioSwitch", player, station)

				end
			else
				cancelEvent(true)

			end
		end
	end
end)
--]]
addEventHandler("onClientPlayerVehicleEnter", gMe,
function(vehicle, seat)
	if(getElementData(vehicle, "radiochannel")) then
		setRadioChannel(getElementData(vehicle, "radiochannel"))
	end
end)

addEvent("onVehicleRadioSwitchBack", true)
addEventHandler("onVehicleRadioSwitchBack", getRootElement(),
function(station)
	if(isPedInVehicle(gMe) == true) and (getVehicleOccupant(getPedOccupiedVehicle(gMe)) ~= gMe) then 
		setRadioChannel(station)
	end
end)
--]]