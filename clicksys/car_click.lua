function car_click_func( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if (getElementType(source) == "vehicle") then
			if(getElementData(source, "vehbomb") == true) then return end
			if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
			local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
			triggerClientEvent(thePlayer, "onCarClicksys", thePlayer, source)
			setElementData(thePlayer, "Clicked", 1)
			
		end
	end
end	
		
addEventHandler( "onElementClicked", getRootElement(), car_click_func ) 

addEvent("set_vehicle_remove", true)
addEventHandler("set_vehicle_remove", getRootElement(),
function(vehicle, grund)
	local carslot = tonumber(getElementData(vehicle, "Carslot"))
	local besitzer = getElementData(vehicle, "Besitzer")
	local query = "DELETE FROM vehicles WHERE BESITZER = '"..besitzer.."' AND CARSLOT = '"..carslot.."'"
	local result = mysql_query( handler, query )
	local grund2 = "Servernachricht: Dein Auto in Carslot "..carslot.." wurde von Admin "..getPlayerName(source).." Geloscht. Grund : "..grund
	if(result) then
		setOfflineNachricht(besitzer, grund2)
		outputChatBox("Fahrzeug wurde mit dem Grund: "..grund.." geloescht.", source, 0, 255, 0, false)
		destroyElement(vehicle)
	else
		outputChatBox("Fahrzeug konnte nicht geloescht werden!", source, 200, 0, 0,false)
	end
end)

addEvent("set_vehicle_respawn", true)
addEventHandler("set_vehicle_respawn", getRootElement(),
function(vehicle)
	respawnVehicle(vehicle)
	outputChatBox("Fahrzeug wurde Respawnt.", source, 0, 255, 0, false)
	setElementData(vehicle, "Schrott", 0)
end)

addEvent("set_vehicle_fix", true)
addEventHandler("set_vehicle_fix", getRootElement(),
function(vehicle)
	local vx, vy, vz = getElementVelocity(vehicle)
	setElementVelocity(vehicle, 0, 0, 0)
	setTimer(function() fixVehicle(vehicle) setElementData(vehicle, "fSchrott", false) end, 500, 1)
	setTimer(function() setElementVelocity(vehicle, vx, vy, vz) end, 1000, 1)
	outputChatBox("Fahrzeug wurde Repariert.", source, 0, 255, 0, false)
end)