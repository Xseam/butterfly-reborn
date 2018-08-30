local yakuzaCar = {}

yakuzaCar[1] = createVehicle(560, 14.1689453125, -261.4384765625, 5.1353120803833, 359.8681640625, 359.99450683594, 88.74755859375, "Yakuza") -- Sultan
yakuzaCar[2] = createVehicle(560, 13.4306640625, -265.59765625, 5.1351890563965, 359.8681640625, 359.99450683594, 90.510864257813, "Yakuza") -- Sultan
yakuzaCar[3] = createVehicle(560, 13.0869140625, -257.177734375, 5.1349987983704, 359.8681640625, 359.99450683594, 89.972534179688, "Yakuza") -- Sultan
yakuzaCar[4] = createVehicle(560, 13.890625, -252.9794921875, 5.1350259780884, 359.87365722656, 359.99450683594, 89.467163085938, "Yakuza") -- Sultan
yakuzaCar[5] = createVehicle(560, 13.8779296875, -249.001953125, 5.1345071792603, 359.8681640625, 359.99450683594, 90.604248046875, "Yakuza") -- Sultan
yakuzaCar[6] = createVehicle(560, 13.541015625, -244.9072265625, 5.1357936859131, 359.8681640625, 359.99450683594, 90.538330078125, "Yakuza") -- Sultan
yakuzaCar[7] = createVehicle(560, 13.3681640625, -240.634765625, 5.1344923973083, 359.8681640625, 359.99450683594, 89.324340820313, "Yakuza") -- Sultan
yakuzaCar[8] = createVehicle(482, 12.634765625, -220.2509765625, 5.5506548881531, 359.13208007813, 0, 91.203002929688, "Yakuza") -- Burrito
yakuzaCar[9] = createVehicle(482, 13.30078125, -224.1103515625, 5.550639629364, 359.13757324219, 0.0054931640625, 89.785766601563, "Yakuza") -- Burrito
yakuzaCar[10] = createVehicle(409, -7.6044921875, -251.4873046875, 5.2296743392944, 0, 359.99450683594, 179.57702636719, "Yakuza") -- Stretch
yakuzaCar[11] = createVehicle(492, -31.8251953125, -280.298828125, 5.2079620361328, 0.1263427734375, 0, 270.34057617188, "Yakuza") -- Greenwood
yakuzaCar[12] = createVehicle(492, -31.51953125, -283.5654296875, 5.208083152771, 0.1263427734375, 0, 269.82421875, "Yakuza") -- Greenwood
yakuzaCar[13] = createVehicle(461, -32.1708984375, -287.21484375, 5.0120143890381, 359.39575195313, 0, 271.84020996094, "Yakuza") -- PCJ-600
yakuzaCar[14] = createVehicle(461, -32.099609375, -290.4130859375, 5.0139832496643, 359.26391601563, 0, 270.15930175781, "Yakuza") -- PCJ-600
yakuzaCar[15] = createVehicle(461, -31.294921875, -293.666015625, 5.0162434577942, 359.23095703125, 359.98901367188, 269.99450683594, "Yakuza") -- PCJ-600
yakuzaCar[16] = createVehicle(461, -31.931640625, -297.10546875, 5.0165829658508, 359.11010742188, 0, 271.21398925781, "Yakuza") -- PCJ-600
yakuzaCar[17] = createVehicle(487, -47.48046875, -251.580078125, 33.301696777344, 0.2691650390625, 0.4888916015625, 270.90087890625, "Yakuza") -- Maverick
yakuzaCar[18] = createVehicle(455, -70.28125, -372.201171875, 5.8660306930542, 0, 359.87365722656, 270.95581054688, "Yakuza") -- Flatbed
yakuzaCar[19] = createVehicle(428, -28.5830078125, -217.70703125, 5.553683757782, 0.2197265625, 0, 264.64416503906, "BANKLOL") -- Securicar

function YakuzaFahrzeugEnter ( player, seat )

	local veh = source
	source = player
	if getPedOccupiedVehicleSeat ( source ) == 0 then
	if not(getPlayerFraktion(source) == 1) then
		outputChatBox("INFO: Du hast kein Schluessel fuer dieses Fahrzeug.", source, 200, 0, 0, false)
		o_removePedFromVehicle(source)
		else
			if(getElementModel(veh) == 455) then
				outputChatBox("Nutze /waffentruck um den Waffentruck zu starten.", source, 0, 200, 0, false)
			elseif(getElementModel(veh) == 428) then
				outputChatBox("Nutze /bankrob, um einen Bankraub durchzufuehren.", source, 0, 200, 0, false)
			end
	end
	end
end

for v = 1, #yakuzaCar, 1 do
	setVehicleColor(yakuzaCar[v], 0, 0, 0, 0, 0, 0)
	setElementData(yakuzaCar[v], "Typ", "Fraktionsauto")
	setElementData(yakuzaCar[v], "Besitzer", "Yakuza")
	setVehicleEngineState(yakuzaCar[v], false)
	toggleVehicleRespawn ( yakuzaCar[v], true )
	setVehicleRespawnDelay ( yakuzaCar[v], 5000 )
	setVehicleIdleRespawnDelay ( yakuzaCar[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", yakuzaCar[v], YakuzaFahrzeugEnter )
	if(getElementModel(yakuzaCar[v]) == 482) then -- burrito
		giveVehicleBetterEngine(yakuzaCar[v])
		giveVehiclePanzerung(yakuzaCar[v])
	end
	if(getElementModel(yakuzaCar[v]) == 455) then -- Flatbed
		giveVehicleBetterEngine(yakuzaCar[v])
		giveVehiclePanzerung(yakuzaCar[v])
	end
	if(getElementModel(yakuzaCar[v]) == 428) then -- Securicar
		giveVehiclePanzerung(yakuzaCar[v])
	end
	if(getElementModel(yakuzaCar[v]) == 560) then -- Sultan
		giveVehicleBetterEngine(yakuzaCar[v])
	end
end

outputDebugString(#yakuzaCar.." Yakuza-Fraktionsautos geladen.")

local Respawn = {}
local Respawntime = 10
addEvent("onYakuzaCarRespawnAD", true)
addEventHandler("onYakuzaCarRespawnAD", getRootElement(),
function()
	if(client ~= source) then return end
	for v = 1, #yakuzaCar, 1 do
		respawnVehicle(yakuzaCar[v])
	end
	outputChatBox(#yakuzaCar.." Yakuza Fahrzeuge wurden respawnt.", source, 0, 200, 0)
end)

addEvent("onYakuzaCarRespawn", true)
addEventHandler("onYakuzaCarRespawn", getRootElement(),
function()
	if(Respawn[source] == true) then outputChatBox("Du kannst nur jede "..Respawntime.." Minuten Respawnen!", source, 200, 0, 0, false) return end
	for v = 1, #yakuzaCar, 1 do
		respawnVehicle(yakuzaCar[v])
	end
	Respawn[source] = true
	local playa = source
	setTimer(function() Respawn[playa] = false end, Respawntime*60*1000, 1)
end)