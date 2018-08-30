function check_schein_func ( player, seat, jacked ) --when a player enters a vehicle
	local ftype = getVehicleType(source)
	if(seat ~= 0) then return end
	if(ftype == "Automobile") or (ftype == "Train") or (ftype == "Monster Truck") or (ftype == "Quad") then
		if(tonumber(getElementData(player, "pFSchein")) == 0) then 
			if(getElementData(player, "fahrpruefung") == true) then else
			cancelEvent() outputChatBox("Du brauchst den Fuehrerschein! Melde dich bei einem Fahrlehrer.", player, 235, 0, 0, false) 
		return end end
	elseif(ftype == "Plane") then
		if(tonumber(getElementData(player, "pFLUGSchein")) == 0) then
			if(getElementData(player, "fahrpruefung") == true) then else
			cancelEvent() outputChatBox("Du brauchst den Flugzeugschein! Melde dich bei einem Fahrlehrer.", player, 235, 0, 0, false) 
		return end end
	elseif(ftype == "Helicopter") then
	if(tonumber(getElementData(player, "pHELISchein")) == 0) then
		if(getElementData(player, "fahrpruefung") == true) then else
		cancelEvent() outputChatBox("Du brauchst den Helikopterschein! Melde dich bei einem Fahrlehrer.", player, 235, 0, 0, false) 
		return end end
	elseif(ftype == "Bike") then
	if(getElementData(source, "Typ") == "Anfaengerauto") then else
	if(tonumber(getElementData(player, "pMOTORRADSchein")) == 0) then 
		if(getElementData(player, "fahrpruefung") == true) then else
	cancelEvent() outputChatBox("Du brauchst den Motorradschein! Melde dich bei einem Fahrlehrer.", player, 235, 0, 0, false) 
	return end end end
	elseif(ftype == "Boat") then
	if(tonumber(getElementData(player, "pBOOTSchein")) == 0) then
	if(getElementData(player, "fahrpruefung") == true) then else	
	cancelEvent() outputChatBox("Du brauchst den Bootsschein! Melde dich bei einem Fahrlehrer.", player, 235, 0, 0, false)
	return end end
	else
	
	end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), check_schein_func ) --add an event handler for onVehicleStartEnte
