
-- COLOR --
local CMarker = createMarker(666.89782714844, -544.27288818359, 16.3359375, "arrow", 2.0, 0, 255, 0, 255)
local CMarker2 = createMarker(-32.597904205322, -43.2734375, 3.117187, "corona", 3.5, 0, 255, 0, 255) -- Heli

addEventHandler("onMarkerHit", CMarker2,
function(hitElement)
	if(getElementType(hitElement) == "player") then return end
	local data = getElementData(hitElement, "Besitzer")
	local playa = getVehicleOccupant(hitElement)
	if not(playa) then return end
	if not(data == getPlayerName(playa)) then return end
	if(getVehicleType(hitElement) == "Plane") or (getVehicleType(hitElement) == "Helicopter") then
		triggerClientEvent(playa, "onPrivatcarColor", playa)
		setElementFrozen(hitElement, true)
	else
		outputChatBox("Du kannst hier nur Helikopter und Flugzeuge Lackieren!", playa, 200, 0, 0)
	end
end)
addEventHandler("onMarkerHit", CMarker,
function(hitElement)
	if(getElementType(hitElement) == "player") then return end
	local data = getElementData(hitElement, "Besitzer")
	local playa = getVehicleOccupant(hitElement)
	if not(playa) then return end
	if not(data == getPlayerName(playa)) then return end
	triggerClientEvent(playa, "onPrivatcarColor", playa)
	setElementFrozen(hitElement, true)
end)
addEvent("onPrivatAutoFarbeReset", true)
addEventHandler("onPrivatAutoFarbeReset", getRootElement(),
function()
	local veh = getPedOccupiedVehicle(source)
	local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12 = getVehicleColor(veh, true)
	local lf1, lf2, lf3 = getVehicleHeadLightColor(veh)
	local paintjob = getVehiclePaintjob(veh)
	setVehicleColor(veh, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12)
	setVehicleHeadLightColor(veh, lf1, lf2, lf3)
	setVehiclePaintjob(veh, paintjob)
	setElementFrozen(getPedOccupiedVehicle(source), false)
end)

addEvent("onPrivatAutoFarbeKauf", true)
addEventHandler("onPrivatAutoFarbeKauf", getRootElement(),
function(f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, lf1, lf2, lf3, paintjob)
if not(source) then return end
	local veh = getPedOccupiedVehicle(source)
	local color = f1.."|"..f2.."|"..f3.."|"..f4.."|"..f5.."|"..f6.."|"..f7.."|"..f8.."|"..f9.."|"..f10.."|"..f11.."|"..f12.."|"..paintjob
	local hcolor = lf1.."|"..lf2.."|"..lf3
	local data = getElementData(veh, "Besitzer")
	if(data ~= getPlayerName(source)) then return end
	local slot = tonumber(getElementData(veh, "Carslot"))
	if not(slot) then return end
	--outputChatBox(color)
	local result = mysql_query(handler,"UPDATE vehicles SET LICHTFARBE = '"..hcolor.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	local result2 = mysql_query(handler,"UPDATE vehicles SET FARBE = '"..color.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	if(result) and(result2) then
		outputChatBox("Farbe erfolgreich gespeichert!", source, 0, 200, 0, false)
		setElementData(source, "pHGeld", getElementData(source, "pHGeld")-50)
		setVehicleColor(veh, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12)
		setVehicleHeadLightColor(veh, lf1, lf2, lf3)
		setVehiclePaintjob(veh, paintjob)
	else
		outputChatBox("Fehler beim Speichern der Autofarbe!", source, 255, 0, 0,false)
	end
	setElementFrozen(veh, false)

end)

function save_vehicle_data(vehicle)
outputDebugString("Data fuer Fahrzeug "..getVehicleName(vehicle).." werden Gespeichert.")
addEventHandler("onElementDataChange", vehicle, function(data)
	if(data == "fTunings") then
		local newdata = getElementData(source, "fTunings")
		local besitzer, slot = getElementData(source, "Besitzer"), getElementData(source, "Carslot")
		mysql_query(handler,"UPDATE vehicles SET TUNINGS = '"..newdata.."' WHERE BESITZER = '"..besitzer.."' AND CARSLOT = '"..slot.."'")
	elseif(data == "fTuningsspec") then
		local newdata = getElementData(source, "fTuningsspec")
		local besitzer, slot = getElementData(source, "Besitzer"), getElementData(source, "Carslot")
		mysql_query(handler,"UPDATE vehicles SET SPECIAL = '"..newdata.."' WHERE BESITZER = '"..besitzer.."' AND CARSLOT = '"..slot.."'")
	elseif(data == "Schrott") then
		local newdata = getElementData(source, "Schrott")
		local besitzer, slot = getElementData(source, "Besitzer"), getElementData(source, "Carslot")
		mysql_query(handler,"UPDATE vehicles SET SCHROTT = '"..newdata.."' WHERE BESITZER = '"..besitzer.."' AND CARSLOT = '"..slot.."'")
	elseif(data == "fuel") then
		local newdata = getElementData(source, "fuel")
		local besitzer, slot = getElementData(source, "Besitzer"), getElementData(source, "Carslot")
		mysql_query(handler,"UPDATE vehicles SET FUEL = '"..newdata.."' WHERE BESITZER = '"..besitzer.."' AND CARSLOT = '"..slot.."'")
		end
	end)

	addEventHandler("onVehicleDamage", vehicle, function(loss)
	local damage = (getElementHealth(source)-loss)
		if(damage < 250) then
			setVehicleDamageProof(source, true)
			setElementData(source, "Schrott", 1)
			setElementHealth(source, 250)
			setVehicleEngineState(source, false)
			setElementData(source, "motor", false)
			if(getVehicleOccupant(source)) then
				outputChatBox("Dein Fahrzeug hat einen Totalschaden!", getVehicleOccupant(source), 255, 0, 0)
			end
		end
	end)
	
	addEventHandler("onVehicleExplode", vehicle,
	function()
		local besitzer = getElementData(source, "Besitzer")
		if(getPlayerFromName(besitzer)) then
			local playa = getPlayerFromName(besitzer)
			outputChatBox("Dein Fahrzeug in Slot Nummer "..getElementData(source, "Carslot").." ist Explodiert! Dir wurden 2500$ von deinem Konto Abgezogen.", playa, 255, 0, 0)
			removePlayerItem(playa, "pBGeld", 2500)
			local veh = source
			setTimer(function()
				local x, y, z = getElementPosition(veh)
				local rotx, roty, rotz = getElementRotation(veh)
				respawnVehicle(veh)
				setElementPosition(veh, x, y, z)
				setElementRotation(veh, rotx, roty, rotz)
				setVehicleDamageProof(veh, true)
				setElementHealth(veh, 250)
				setVehicleLocked(veh, true)
				setElementData(veh, "Schrott", 1)
			end, 10000, 1)
		else
			local veh = source
			setTimer(function()
				local x, y, z = getElementPosition(veh)
				local rotx, roty, rotz = getElementRotation(veh)
				respawnVehicle(veh)
				setElementPosition(veh, x, y, z)
				setElementRotation(veh, rotx, roty, rotz)
				setVehicleDamageProof(veh, true)
				setElementHealth(veh, 250)
				setVehicleLocked(veh, true)
				setElementData(veh, "Schrott", 1)
			end, 10000, 1)
		end
	end)
	
	addEventHandler("onElementDestroy", vehicle,
	function()
		local besitzer = getElementData(source, "Besitzer")
		if(getPlayerFromName(besitzer)) then
			local playa = getPlayerFromName(besitzer)
			--outputChatBox("Dein Fahrzeug in Slot Nummer "..getElementData(source, "Carslot").." wurde geloescht.", playa, 255, 0, 0)
			givePlayerItem(playa, "pBGeld", 2000)
		else
			
		end
	end)
end

-- MYSQL --
addEvent("onAutoKauf1", true)
addEventHandler("onAutoKauf1", getRootElement(),
function(id, carslot)
	local query
	if(getVehicleType(id) == "Plane") or (getVehicleType(id) == "Helicopter") then
		query = "INSERT INTO vehicles ( BESITZER, NAME, SPAWNX, SPAWNY, SPAWNZ, ROTX, ROTY, ROTZ, CARSLOT, FARBE, LICHTFARBE ) VALUES ( '"..getPlayerName(source).."', '"..getVehicleNameFromModel(id).."', '-40', '-179', '3', '8', '0', '347', '"..carslot.."', '255|255|255|0|0|0|0|0|0|0|0|0|0' , '255|255|255')"
	else
		query = "INSERT INTO vehicles ( BESITZER, NAME, SPAWNX, SPAWNY, SPAWNZ, ROTX, ROTY, ROTZ, CARSLOT, FARBE, LICHTFARBE ) VALUES ( '"..getPlayerName(source).."', '"..getVehicleNameFromModel(id).."', '1206', '212', '19', '0', '0', '0', '"..carslot.."', '255|255|255|0|0|0|0|0|0|0|0|0|0' , '255|255|255')"
	end
	local result = mysql_query( handler, query )
	if(result) then
			outputChatBox("Du hast dir das Auto erfolgreich gekauft!", source, 0, 200, 0, false)
			outputChatBox("Bitte parke dein Auto in eine Parkstelle um. Andererseits kann es von einem Admin geloescht werden.", source, 0, 200, 0, false)
			outputChatBox("Dies geht, indem du auf dein Auto klickst und auf 'Parken' drueckst.", source, 0, 200, 0, false)
			local veh
			if(getVehicleType(id) == "Plane") or (getVehicleType(id) == "Helicopter") then
				veh = createVehicle( id, -40.9150390625, -179.4248046875, 3.6101303100586, 8.26171875, 359.08264160156, 347.46459960938, getPlayerName(source) )
				
			else
				veh = createVehicle( id, 1206, 212, 19, 0, 0, 0, getPlayerName(source) )
			end
			setElementData ( veh, "Privatcar", true )

			setElementData(veh, "Besitzer", getPlayerName(source))
			setElementData(veh, "Name", getVehicleNameFromModel(id))
			setElementData(veh, "Carslot", carslot)
				
			setElementData(source, "Carslot"..carslot, tonumber(getElementData(veh, "Carslot")))
			setElementData(source, "Car"..carslot, veh)
			
			setElementData ( veh, "Privatcar", true )
			setElementData ( veh, "fTunings", "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|" )
			setElementData ( veh, "fuel", 100)
			setElementData ( veh, "fuelable", true)
			setElementData ( veh, "fTuningsspec", "|0|0|0|0|0|")
			save_vehicle_data(veh)
	else
		outputChatBox("Fehler beim Kaufen des Autos! Frage ein Admin, ob du dein Geld wiederbekommst.", source, 0, 200, 0, false)
	end
end)
local vehicles = {}
local vehicleVar = 0
function createCars ( )

	local result = mysql_query ( handler, "SELECT * FROM vehicles;" )
		
	if result then
	
		dsatz = mysql_fetch_assoc( result )
		
		while dsatz do
			vehicleVar = vehicleVar+1
		
			local veh = createVehicle( getVehicleModelFromName(dsatz['NAME']), dsatz['SPAWNX'], dsatz['SPAWNY'], dsatz['SPAWNZ'], dsatz['ROTX'], dsatz['ROTY'], dsatz['ROTZ'], dsatz['BESITZER'] )
			vehicles[veh] = {}
			vehicles[veh]["Besitzer"] = dsatz['BESITZER']
			vehicles[veh]["Name"] = dsatz['NAME']
			vehicles[veh]["Carslot"] = dsatz['CARSLOT']
			vehicles[veh]["SpawnX"] = dsatz['SPAWNX']
			vehicles[veh]["SpawnY"] = dsatz['SPAWNY']
			vehicles[veh]["SpawnZ"] = dsatz['SPAWNZ']
			vehicles[veh]["RotX"] = dsatz['ROTX']
			vehicles[veh]["RotY"] = dsatz['ROTY']
			vehicles[veh]["RotZ"] = dsatz['ROTZ']
			vehicles[veh]["fTunings"] = dsatz['TUNINGS']
			vehicles[veh]["fuel"] = dsatz['FUEL']
			vehicles[veh]["Schrott"] = dsatz['SCHROTT']
			vehicles[veh]["fTuningsspec"] = dsatz['SPECIAL']
			setVehicleRespawnPosition ( veh, dsatz['SPAWNX'], dsatz['SPAWNY'], dsatz['SPAWNZ'], dsatz['ROTX'], dsatz['ROTY'], dsatz['ROTZ'] )
			local color = dsatz['FARBE']
			local color2 = dsatz['LICHTFARBE']
			-- Color --
			if not(tonumber(color == 0)) then		
			local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, paintjob = gettok(color, 1, "|"), gettok(color, 2, "|"), gettok(color, 3, "|"), gettok(color, 4, "|"), gettok(color, 5, "|"), gettok(color, 6, "|"), gettok(color, 7, "|"), gettok(color, 8, "|"), gettok(color, 9, "|"), gettok(color, 10, "|"), gettok(color, 11, "|"), gettok(color, 12, "|"), gettok(color, 13, "|") 
				if not(f1) or not(f2) or not(f3) or not(f4) or not(f5) or not(f6) or not(f7) or not(f8) or not(f9) or not(f10) or not(f11) or not(f12) then else
				setVehicleColor(veh, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12)
				if(paintjob) then
					setVehiclePaintjob(veh, paintjob)
				end
				if not(tonumber(color2) == 0) then
					local lf1, lf2, lf3 = gettok(color2, 1, "|"), gettok(color2, 2, "|"), gettok(color2, 3, "|") 
					setVehicleHeadLightColor(veh, lf1, lf2, lf3)
				end
			end
			end
			for key, wert in pairs ( vehicles[veh] ) do
				setElementData ( veh, key, wert )
			end
			-- Tunings --
			local tuns = getElementData(veh, "fTunings")
			for i=0, 16, 1 do
	
				local id = tonumber(gettok(tuns, i+1, "|"))
				if(id) then
					if(id > 999) and (id < 1194) then
						addVehicleUpgrade(veh, id)
					end
				end
			end
			-- Special Tunings --
			local special = getElementData(veh, "fTuningsspec")
			local spec1 = gettok(special, 1, "|")
			local spec2 = gettok(special, 2, "|")
			local spec3 = gettok(special, 3, "|")
			if(special == "|0|0|0|") then setElementData(veh, "fTuningsspec", "|0|0|0|0|0|") end
			if(special == "|0|1|0|") then setElementData(veh, "fTuningsspec", "|0|1|0|0|0|") end
			if(special == "|1|0|0|") then setElementData(veh, "fTuningsspec", "|1|0|0|0|0|") end
			if(special == "|1|1|0|") then setElementData(veh, "fTuningsspec", "|1|1|0|0|0|") end
			-- Motor --
			if(spec1) then 
				if(tonumber(spec1) == 1) then
					setVehicleHandling(veh, "engineAcceleration", (getVehicleHandling(veh)['engineAcceleration']+5))
					setVehicleHandling(veh, "maxVelocity", (getVehicleHandling(veh)['maxVelocity']+15))
				end 
			end
			-- Panzerung --
			if(spec2) then 
				if(tonumber(spec2) == 1) then
					if(tonumber(getVehicleHandling(veh)['collisionDamageMultiplier']) < 0.3) then setVehicleHandling(veh, "collisionDamageMultiplier", 0) else
						setVehicleHandling(veh, "collisionDamageMultiplier", (getVehicleHandling(veh)['collisionDamageMultiplier']-0.3))
					end
				end 
			end
			-- GPS --
			if(spec3) then 
				if(tonumber(spec3) == 1) then
					setElementData(veh, "fGPS", true)
				else
					setElementData(veh, "fGPS", false)
				end
				else
					setElementData(veh, "fGPS", false)
			end
			-- Schrott --
			local schrott = tonumber(getElementData(veh, "Schrott"))
			if(schrott == 1) then
				setVehicleDamageProof(veh, true)
				setElementHealth(veh, 250)
			end
			setVehicleLocked(veh, true)
			setElementData ( veh, "Privatcar", true )
			setElementData ( veh, "fuelable", true)
			save_vehicle_data(veh)
			
			dsatz = mysql_fetch_assoc ( result )
		
		end
				
	end
	
	mysql_free_result ( result )
	outputDebugString(vehicleVar.." Privatautos geladen.")
end

createCars ( )

function getVehicleData ( veh, key )

	return vehicles[veh][key]

end
addEvent("onVehActionAbschlepp", true)
addEventHandler("onVehActionAbschlepp", getRootElement(), function(veh)
	if not(getPedOccupiedVehicle(source)) then return end
	if(getElementModel(getPedOccupiedVehicle(source)) ~= 525) then outputChatBox("Du musst in einem Abschlepper sitzen, um das Auto hier zu Parken.", source, 200, 0, 0) return end
	local slot = tonumber(getElementData(veh, "Carslot"))
	if not(slot) then return end
	local x, y, z = getElementPosition(veh)
	local x1, y1, z1 = getElementRotation(veh)
	local data = getElementData(veh, "Besitzer")
	--outputChatBox(data..", "..slot..", "..x..", "..y..", "..z..", : "..x1..", "..y1..", "..z1)
	--mysql_query(handler,"UPDATE vehicles SET SPAWNX = '"..x.."', SPAWNY = '"..y.."', SPAWNZ = '"..z..", ROTX = '"..x1..", ROTY = '"..y1..", ROTZ = '"..z1.." WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNX = '"..x.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNY = '"..y.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNZ = '"..z.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET ROTX = '"..x1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET ROTY = '"..y1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	local result = mysql_query(handler,"UPDATE vehicles SET ROTZ = '"..z1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	setVehicleRespawnPosition ( veh, x, y, z, x1, y1, z1 )
	setElementData(veh, "SpawnX", x)
	setElementData(veh, "SpawnY", y)
	setElementData(veh, "SpawnZ", z)
	setElementData(veh, "RotX", x1)
	setElementData(veh, "RotY", y1)
	setElementData(veh, "RotZ", z1)
	if(result) then
		outputChatBox("Du hast das Fahrzeug erfolgreich hier Geparkt!", source, 230, 50, 0, false)
		mysql_free_result(result)
		setOfflineNachricht(getElementData(veh, "Besitzer"), "Servernachricht: Dein Auto in Slot Nr. "..slot.." wurde von "..getPlayerName(source).." Abgeschleppt.")
	else
		outputChatBox("Fehler beim Abschleppen!", source, 200, 0, 0, false)
	end
end)


function park_func_a ( thePlayer, cmd )
	if(isPedInVehicle(thePlayer) == false) then return end
	local veh = getPedOccupiedVehicle(thePlayer)
	local data = getElementData(veh, "Besitzer")
	if(data ~= getPlayerName(thePlayer)) then return end
	local slot = tonumber(getElementData(veh, "Carslot"))
	if not(slot) then return end
	local x, y, z = getElementPosition(veh)
	local x1, y1, z1 = getElementRotation(veh)
	--outputChatBox(data..", "..slot..", "..x..", "..y..", "..z..", : "..x1..", "..y1..", "..z1)
	--mysql_query(handler,"UPDATE vehicles SET SPAWNX = '"..x.."', SPAWNY = '"..y.."', SPAWNZ = '"..z..", ROTX = '"..x1..", ROTY = '"..y1..", ROTZ = '"..z1.." WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNX = '"..x.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNY = '"..y.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET SPAWNZ = '"..z.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET ROTX = '"..x1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	mysql_query(handler,"UPDATE vehicles SET ROTY = '"..y1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	local result = mysql_query(handler,"UPDATE vehicles SET ROTZ = '"..z1.."' WHERE BESITZER = '"..data.."' AND CARSLOT = '"..slot.."'")
	setVehicleRespawnPosition ( veh, x, y, z, x1, y1, z1 )
	setElementData(veh, "SpawnX", x)
	setElementData(veh, "SpawnY", y)
	setElementData(veh, "SpawnZ", z)
	setElementData(veh, "RotX", x1)
	setElementData(veh, "RotY", y1)
	setElementData(veh, "RotZ", z1)
	if(result) then
		outputChatBox("Du hast dein Fahrzeug erfolgreich hier Geparkt!", thePlayer, 230, 50, 0, false)
		mysql_free_result(result)
	else
		outputChatBox("Fehler beim Umparken!", thePlayer, 200, 0, 0, false)
	end
end
addCommandHandler ( "park", park_func_a )

function givecar_func_a ( player, cmd, target, slot )
	if not (target) or not(slot) then outputChatBox("Benutze: /givecar [An Spieler] [Dein Slot]", player, 0, 200, 0) return end
	local slot = tonumber(slot)
	if (tonumber(getElementData ( player, "Carslot"..slot )) < 1) then outputChatBox("Du hast kein Fahrzeug mit diesem Slot!", player, 200, 0, 0, false) return end
	local veh = getElementData(player, "Car"..slot)
	if not(veh) then outputChatBox("Fehler, Auto nicht gefunden!", player, 0, 200, 0) return end
	if not(getPlayerFromName(target)) then outputChatBox("Angegebener Spieler exestiert nicht, oder ist nicht Online!", player, 200, 0, 0) return end
	local slots = {}
	local newslot = 0
	target = getPlayerFromName(target)
	slots[1] = tonumber(getElementData(target, "Carslot1"))
	slots[2] = tonumber(getElementData(target, "Carslot2"))
	slots[3] = tonumber(getElementData(target, "Carslot3"))
	slots[4] = tonumber(getElementData(target, "Carslot4"))
	slots[5] = tonumber(getElementData(target, "Carslot5"))
	if not(slots[1]) then newslot = 1 end
	if not(slots[2]) then newslot = 1 end
	if not(slots[3]) then newslot = 1 end
	if not(slots[4]) then newslot = 1 end
	if not(slots[5]) then newslot = 1 end
	if(newslot == 0) then outputChatBox("Der Spieler hat kein Freien Autoslot mehr!", player, 200, 0, 0) return end
	local result1 = mysql_query(handler,"UPDATE vehicles SET BESITZER = '"..getPlayerName(target).."' WHERE BESITZER = '"..getPlayerName(player).."' AND CARSLOT = '"..slot.."'")
	local result2 = mysql_query(handler,"UPDATE vehicles SET CARSLOT = '"..newslot.."' WHERE BESITZER = '"..getPlayerName(target).."' AND CARSLOT = '"..slot.."'")
	if(result1) then
		setElementData(veh, "Besitzer", getPlayerName(target))
		setElementData(veh, "Carslot", newslot)
		
		setElementData(player, "Carslot"..slot, 0)		
		removeElementData(player, "Car"..slot)
		
		setElementData(target, "Carslot"..newslot, 1)
		setElementData(target, "Car"..newslot, veh)
		outputChatBox("Du hast dein Fahrzeug im Slot "..slot.." an "..getPlayerName(target).." gegeben!", player, 0, 200, 0)
		outputChatBox(getPlayerName(player).." hat dir ein Fahrzeug in Slot Nummer "..newslot.." ueberreicht!", target, 0, 200, 200)
		mysql_free_result(result1)
		mysql_free_result(result2)
	else
		outputChatBox("Fehler beim Geben des Autos!", player, 255, 0, 0)
	end
end
addCommandHandler ( "givecar", givecar_func_a )

function sellcar_func_a ( player, cmd, slot )
	if not(slot) then return end
	local slot = tonumber(slot)
	if (tonumber(getElementData ( player, "Carslot"..slot )) < 1) then outputChatBox("Du hast kein Fahrzeug mit diesem Slot!", player, 200, 0, 0, false) return end

	local veh = getElementData(player, "Car"..slot)
		if not(veh) then return end
		local query = "DELETE FROM vehicles WHERE BESITZER = \'"..getPlayerName(player).."\' AND CARSLOT = \'"..slot.."\';"
		local result = mysql_query( handler, query )
		if(result) then	
			
			local preis = a_preisTable[getVehicleName(veh)]
			if not(preis) then preis = 0 end
			givePlayerItem(player, "pHGeld", preis)
			destroyElement(veh)	
			setElementData(player, "Carslot"..slot, nil)
			setElementData(player, "Car"..slot, nil)
			outputChatBox("Du hast dein Fahrzeug erfolgreich verkaufst, und erhaelst "..preis.." $!", player, 0, 200, 0, false)
		else
			outputChatBox("Fehler beim Verkaufen des Autos! Frage ein Admin!", player, 0, 200, 0, false)
		end
	
end
addCommandHandler ( "sellcar", sellcar_func_a )

--[[
function createCars ( i )

		local query = "SELECT * FROM vehicles;"
		local result = mysql_query( handler, query )
		
	if ( result and mysql_num_rows( result ) > 0 ) then

		local query2 = "SELECT * FROM vehicles;"
		local result2 = mysql_query( handler, query2 )
		local row = mysql_fetch_assoc(result2)
		local besitzer = row['BESITZER']
		local name = row['NAME']
		local x, y, z = row['SPAWNX'], row['SPAWNY'], row['SPAWNZ']
		local rotx, roty, rotz = row['ROTX'], row['ROTY'], row['ROTZ']
		local carslot = row['CARSLOT']
		local farbe = row['FARBE']
		local tunings = row['TUNINGS']
		local lichtfarbe = row['LICHTFARBE']
		_G["vehicle"..i] = createVehicle(getVehicleModelFromName(name), x, y, z, rotx, roty, rotz, besitzer)
		
		local veh = _G["vehicle"..i]
		
		setElementData ( veh, "Besitzer", besitzer )
		setElementData ( veh, "Name", name )
		setElementData ( veh, "Carslot", carslot )
		setElementData ( veh, "Privatcar", true)
		
		i = i + 1
		createCars( i )
	else
		totalCars = i - 1
		outputDebugString ( ( i - 1 ).." Autos den Besitzern zugeordnet!" )
	end
end
setTimer ( createCars, 5000, 1, 1 )--]]

-- CAR HANDLER --
local fahrzeug = {}
local Marker1 = createMarker(1223.7978515625, 173.25305175781, 26.028469085693, "corona", 1.0, 0, 255, 0, 255) -- 1

local Marker2 = createMarker(-106.87139129639, -121.37887573242, 2.6171875, "cylinder", 1.0, 0, 255, 0, 200) -- 2

fahrzeug[1] = createVehicle(411, 1205.3447265625, 157.775390625, 25.755550384521, 0, 359.99450683594, 49.905395507813) -- Infernus
fahrzeug[2] = createVehicle(402, 1207.2470703125, 162.326171875, 25.859943389893, 359.96154785156, 359.99450683594, 45.3515625) -- Buffalo
fahrzeug[3] = createVehicle(506, 1203.6142578125, 166.97265625, 25.733011245728, 359.95056152344, 359.99450683594, 96.1083984375) -- Super GT
fahrzeug[4] = createVehicle(415, 1196.6787109375, 162.162109375, 25.80011177063, 0.3240966796875, 0, 272.21374511719) -- Cheetah
fahrzeug[5] = createVehicle(541, 1198.2294921875, 168.62109375, 25.653123855591, 359.51110839844, 0.0054931640625, 16.550903320313) -- Bullet
fahrzeug[6] = createVehicle(549, 1218.615234375, 154.861328125, 25.725732803345, 359.96704101563, 359.9560546875, 284.66125488281) -- Tampa
fahrzeug[7] = createVehicle(542, 1222.0693359375, 160.52734375, 25.771656036377, 0.0384521484375, 359.99450683594, 223.86840820313) -- Clover
fahrzeug[8] = createVehicle(547, 1225.8544921875, 154.9462890625, 25.764209747314, 0.1593017578125, 0, 300.65185546875) -- Primo
fahrzeug[9] = createVehicle(550, 1229.3544921875, 151.9111328125, 25.835395812988, 359.52209472656, 359.99450683594, 5.20751953125) -- Sunrise
fahrzeug[10] = createVehicle(522, 1225.2275390625, 145.9169921875, 25.597518920898, 359.54956054688, 359.99450683594, 91.983032226563) -- NRG-500
fahrzeug[11] = createVehicle(581, 1220.4287109375, 148.1376953125, 25.62357711792, 359.92309570313, 0, 137.92236328125) -- BF-400
fahrzeug[12] = createVehicle(462, 1217.1728515625, 149.4140625, 25.626029968262, 359.86267089844, 0, 170.09033203125) -- Faggio
fahrzeug[13] = createVehicle(463, 1213.4736328125, 147.8046875, 25.566680908203, 0.5108642578125, 0, 193.83178710938) -- Freeway
fahrzeug[14] = createVehicle(468, 1226.29296875, 141.9267578125, 25.696935653687, 0.3570556640625, 359.98901367188, 112.99438476563) -- Sanchez
fahrzeug[15] = createVehicle(471, 1211.8251953125, 141.9453125, 25.508562088013, 359.18701171875, 0, 272.63122558594) -- Quadbike
fahrzeug[16] = createVehicle(539, 1218.3193359375, 140.4619140625, 25.386688232422, 0.010986328125, 0.17578125, 25.889282226563) -- Vortex
fahrzeug[17] = createVehicle(559, 1223.4453125, 137.44921875, 25.685464859009, 359.98901367188, 359.99450683594, 119.6630859375) -- Jester
fahrzeug[18] = createVehicle(560, 1215.4443359375, 135.9228515625, 25.723970413208, 359.8681640625, 359.99450683594, 43.610229492188) -- Sultan
fahrzeug[19] = createVehicle(562, 1199.8564453125, 142.30078125, 25.680974960327, 359.6484375, 359.83520507813, 17.440795898438) -- Elegy
fahrzeug[20] = createVehicle(558, 1201.48046875, 146.2041015625, 25.658979415894, 359.61547851563, 359.99450683594, 24.334716796875) -- Uranus
fahrzeug[21] = createVehicle(565, 1202.9267578125, 149.3642578125, 25.653774261475, 359.58801269531, 359.96154785156, 22.999877929688) -- Flash
fahrzeug[22] = createVehicle(589, 1203.615234375, 153.5986328125, 25.686508178711, 0, 359.98352050781, 107.58911132813) -- Club
fahrzeug[23] = createVehicle(579, 1198.0849609375, 155.6162109375, 25.998880386353, 359.31884765625, 359.82421875, 105.50720214844) -- Huntley
fahrzeug[24] = createVehicle(603, 1193.5556640625, 156.8466796875, 25.866544723511, 0.0714111328125, 359.99450683594, 174.86938476563) -- Phoenix
fahrzeug[25] = createVehicle(545, 1196.43359375, 144.3505859375, 25.833906173706, 0.208740234375, 359.99450683594, 356.31408691406) -- Hustler
fahrzeug[26] = createVehicle(567, 1192.5693359375, 145.8134765625, 25.893529891968, 0.6317138671875, 359.99450683594, 359.63745117188) -- Savanna
fahrzeug[27] = createVehicle(535, 1188.76953125, 147.6513671875, 25.788217544556, 359.97802734375, 359.98352050781, 325.89294433594) -- Slamvan
fahrzeug[28] = createVehicle(561, 1197.669921875, 150.4365234375, 25.842485427856, 0.10986328125, 0.032958984375, 263.05114746094) -- Stratum
 -- Autohaus 2 --
fahrzeug[28] = createVehicle(487, -87.2734375, -118.9697265625, 3.2918763160706, 0.263671875, 359.41223144531, 277.58605957031) -- Maverick
fahrzeug[29] = createVehicle(469, -73.0263671875, -123.0380859375, 3.1287906169891, 0.2911376953125, 359.67041015625, 64.940185546875) -- Sparrow
fahrzeug[30] = createVehicle(593, -103.0712890625, -141.236328125, 3.576233625412, 359.46716308594, 359.99450683594, 231.33361816406) -- Dodo
fahrzeug[31] = createVehicle(511, -103.509765625, -169.943359375, 3.7589013576508, 1.1590576171875, 2.076416015625, 296.09252929688) -- Beagle
fahrzeug[32] = createVehicle(513, -89.1748046875, -181.2626953125, 2.5814414024353, 10.958862304688, 0.9832763671875, 328.03527832031) -- Stuntplane
fahrzeug[33] = createVehicle(519, -67.01953125, -173.30859375, 3.4398272037506, 2.779541015625, 357.13806152344, 21.516723632813) -- Shamal
fahrzeug[34] = createVehicle(563, -79.0234375, -148.5810546875, 3.8225944042206, 3.328857421875, 359.87915039063, 74.844360351563) -- Raindance

for i = 1, #fahrzeug, 1 do
	setVehicleLocked(fahrzeug[i], true)
	setElementData(fahrzeug[i], "Typ", "Autohauswagen")
	setElementData(fahrzeug[i], "Besitzer", "Autohaus/Staat")
	setElementFrozen(fahrzeug[i], true)
	setVehicleColor(fahrzeug[i], 255, 255, 255, 0, 0, 0)
	setElementHealth(fahrzeug[i], 100000)
	setVehicleDamageProof(fahrzeug[i], true)
	setElementData(fahrzeug[i], "fuel", 0)
	setElementData(fahrzeug[i], "fuelable", false)
	addEventHandler("onVehicleStartEnter", fahrzeug[i],
	function(thePlayer)
		cancelEvent()
		local preis = a_preisTable[getVehicleName(source)]
		if not(preis) then preis = "Unbekannt" else preis = preis.."$" end
		outputChatBox("Fahrzeugname: "..getVehicleName(source)..", Preis: "..preis, thePlayer, 255, 255, 0)
	end)
end
addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	triggerClientEvent(hitElement, "onAutohausGuiStart1", hitElement)
end)
addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	triggerClientEvent(hitElement, "onAutohausGuiStart1", hitElement)
end)