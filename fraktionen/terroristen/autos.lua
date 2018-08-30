local terrorCar = {}

terrorCar[1] = createVehicle(500, -839.7626953125, -861.5576171875, 149.63662719727, 357.19848632813, 359.40124511719, 246.10473632813, "Terror")  -- Mesa
terrorCar[2] = createVehicle(500, -838.7060546875, -858.130859375, 149.60511779785, 357.06665039063, 359.53857421875, 251.88354492188, "Terror")  -- Mesa
terrorCar[3] = createVehicle(500, -836.96484375, -849.396484375, 149.57148742676, 357.81921386719, 358.8134765625, 209.10827636719, "Terror")  -- Mesa
terrorCar[4] = createVehicle(500, -846.9765625, -862.9130859375, 149.75294494629, 358.57177734375, 359.95056152344, 215.2880859375, "Terror")  -- Mesa
terrorCar[5] = createVehicle(500, -863.1416015625, -875.458984375, 149.75068664551, 358.56628417969, 0.1318359375, 231.44897460938, "Terror")  -- Mesa
terrorCar[6] = createVehicle(425, -823.6806640625, -902.71875, 149.70422363281, 7.6080322265625, 0.9942626953125, 36.40869140625, "Terror")  -- Hunter
terrorCar[7] = createVehicle(447, -803.90234375, -884.2060546875, 148.66400146484, 1.2799072265625, 0.9942626953125, 39.863891601563, "Terror")  -- Seasparrow
terrorCar[8] = createVehicle(455, -842.748046875, -894.228515625, 150.02903747559, 0.85693359375, 0.5712890625, 46.966552734375, "Terror")  -- Flatbed
terrorCar[9] = createVehicle(428, -779.5380859375, -847.328125, 149.09098815918, 355.95703125, 358.30261230469, 90.192260742188, "Terror")  -- Securicar
terrorCar[10] = createVehicle(571, -791.8251953125, -824.0361328125, 148.89428710938, 0, 359.99450683594, 180.19775390625, "Terror")  -- Rhino
terrorCar[11] = createVehicle(422, -786.69140625, -836.564453125, 148.87767028809, 359.21447753906, 0, 179.46166992188, "Terror")  -- Bobcat
terrorCar[12] = createVehicle(422, -769.2275390625, -837.2265625, 149.76849365234, 354.95727539063, 1.0711669921875, 103.51867675781, "Terror")  -- Bobcat
terrorCar[13] = createVehicle(422, -774.12890625, -841.861328125, 149.40252685547, 354.89685058594, 359.18151855469, 79.771728515625, "Terror")  -- Bobcat
setElementData(terrorCar[13], "rocketterror", true)
terrorCar[14] = createVehicle(487, -791.8603515625, -827.466796875, 155.13020324707, 0.263671875, 359.69787597656, 178.95080566406, "Terror")  -- Maverick

addEvent("onRocketCreation_Terror", true)
addEventHandler("onRocketCreation_Terror", getRootElement(), function(x, y, z, hx, hy, hz, time)
	local car = getPedOccupiedVehicle(source)
	if not(car) then return end
	local rx, ry, rz = getElementRotation(car)
	local object = createObject(3786, x, y, z+0.5, rx*1.01, ry*1.01, rz-90)
	local marker = createMarker(x, y, z+0.5, "corona", 1.0, 0, 255, 0)
	triggerClientEvent(getRootElement(), "onClientRocketFire_Terror", source, object)
	setElementData(object, "rocket.state", true)
	attachElements(marker, object)
	setElementCollisionsEnabled(object, false)
	setObjectScale(object, 1)
	moveObject(object, time, hx, hy, hz, 0, 0, 0, "InQuad")
	setTimer( function()
		destroyElement(object)
		destroyElement(marker)
		createExplosion(hx, hy, hz, 7)
		createExplosion(hx, hy, hz+4, 4)
	end, time, 1)
end)

function TerrorFahrzeugEnter ( player, seat )

	local veh = source
	source = player
	if getPedOccupiedVehicleSeat ( source ) == 0 then
	if not(getPlayerFraktion(source) == 2) then
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

for v = 1, #terrorCar, 1 do
	setVehicleColor(terrorCar[v], 200, 0, 0, 0, 0, 0)
	setElementData(terrorCar[v], "Typ", "Fraktionsauto")
	setElementData(terrorCar[v], "Besitzer", "Terroristen")
	setVehicleEngineState(terrorCar[v], false)
	toggleVehicleRespawn ( terrorCar[v], true )
	setVehicleRespawnDelay ( terrorCar[v], 5000 )
	setVehicleIdleRespawnDelay ( terrorCar[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", terrorCar[v], TerrorFahrzeugEnter )
	if(getElementData(terrorCar[v], "rocketterror") == true) then
		local ob = createObject(3884, 0, 0, 0)
		local veh = terrorCar[v]
		attachElements(ob, veh, 0, 0, 0.7)
		setObjectScale(ob, 0.3)
		setElementCollisionsEnabled(ob, false)
		addEventHandler("onVehicleEnter", veh, function(thePlayer)
			if(getPedOccupiedVehicleSeat(thePlayer) == 0) then
				triggerClientEvent(thePlayer, "onClientRocketEnter_Terror", thePlayer)
			end
		end)
	end
end

outputDebugString(#terrorCar.." Terroristen-Fraktionsautos geladen.")

local Respawn = {}
local Respawntime = 10

addEvent("onTerrorCarRespawnAD", true)
addEventHandler("onTerrorCarRespawnAD", getRootElement(),
function()
	for v = 1, #terrorCar, 1 do
		respawnVehicle(terrorCar[v])
	end
	outputChatBox(#terrorCar.." Terroristen-Autos wurden respawnt.", source, 0, 200, 0)
end)

addEvent("onTerrorCarRespawn", true)
addEventHandler("onTerrorCarRespawn", getRootElement(),
function()
	if(Respawn[source] == true) then outputChatBox("Du kannst nur jede "..Respawntime.." Minuten Respawnen!", source, 200, 0, 0, false) return end
	for v = 1, #terrorCar, 1 do
		respawnVehicle(terrorCar[v])
	end
	Respawn[source] = true
	local playa = source
	setTimer(function() Respawn[playa] = false end, Respawntime*60*1000, 1)
end)