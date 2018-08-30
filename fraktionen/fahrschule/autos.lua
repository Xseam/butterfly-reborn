local fahrCar = {}

fahrCar[1] = createVehicle(591, 1408.6999511719, 376.5, 20.10000, 0, 0, 246, "FAHRSCOOL")  -- TAILER
fahrCar[2] = createVehicle(515, 1412.8505859375, 378.6025390625, 20.416929244995, 357.74230957031, 359.91760253906, 247.47802734375, "FAHRSCOOL") -- Roadtrain
fahrCar[3] = createVehicle(402, 1386.5947265625, 372.27734375, 19.589405059814, 359.96154785156, 0, 246.708984375, "FAHRSCOOL") -- Buffalo
fahrCar[4] = createVehicle(402, 1388.0439453125, 375.5791015625, 19.589487075806, 359.96154785156, 0, 247.85705566406, "FAHRSCOOL") -- Buffalo
fahrCar[5] = createVehicle(402, 1389.3525390625, 378.9228515625, 19.589418411255, 359.96154785156, 0, 246.50024414063, "FAHRSCOOL") -- Buffalo
fahrCar[6] = createVehicle(445, 1392.2841796875, 385.45703125, 19.632816314697, 359.98901367188, 0, 246.47277832031, "FAHRSCOOL") -- Admiral
fahrCar[7] = createVehicle(445, 1393.724609375, 388.974609375, 19.632808685303, 359.98901367188, 0, 247.15942382813, "FAHRSCOOL") -- Admiral
fahrCar[8] = createVehicle(445, 1395.400390625, 392.0673828125, 19.632822036743, 359.98901367188, 0, 246.25854492188, "FAHRSCOOL") -- Admiral
fahrCar[9] = createVehicle(560, 1397.87109375, 398.92578125, 19.46240234375, 359.8681640625, 359.99450683594, 247.7197265625, "FAHRSCOOL") -- Sultan
fahrCar[10] = createVehicle(560, 1399.1474609375, 402.14453125, 19.462776184082, 359.86267089844, 0, 246.29699707031, "FAHRSCOOL") -- Sultan
fahrCar[11] = createVehicle(560, 1400.9375, 405.61328125, 19.462905883789, 359.8681640625, 0, 248.09326171875, "FAHRSCOOL") -- Sultan
fahrCar[12] = createVehicle(446, 1415.01953125, 533.7880859375, -0.57090485095978, 1.834716796875, 0, 350.13977050781, "FAHRSCOOL") -- Squalo
fahrCar[13] = createVehicle(446, 1405.2294921875, 540.189453125, -0.57047337293625, 1.8292236328125, 359.99450683594, 80.205688476563, "FAHRSCOOL") -- Squalo
fahrCar[14] = createVehicle(446, 1434.9599609375, 547.431640625, -0.57125759124756, 1.8292236328125, 0, 261.23840332031, "FAHRSCOOL") -- Squalo
fahrCar[15] = createVehicle(493, 1432.4453125, 536.5791015625, -0.15011984109879, 3.076171875, 359.97802734375, 258.89831542969, "FAHRSCOOL") -- Jetmax
fahrCar[16] = createVehicle(473, 1426.1376953125, 558.9013671875, -0.26659607887268, 5.11962890625, 359.74731445313, 349.9365234375, "FAHRSCOOL") -- Dinghy
fahrCar[17] = createVehicle(563, 1377.9970703125, 389.1455078125, 29.460943222046, 3.328857421875, 359.97802734375, 64.951171875, "FAHRSCOOL") -- Raindance
fahrCar[18] = createVehicle(487, 1385.755859375, 417.908203125, 28.932189941406, 0.263671875, 359.70336914063, 247.1484375, "FAHRSCOOL") -- Maverick
fahrCar[19] = createVehicle(593, 1331.958984375, 143.83984375, 21.77041053772, 3.8616943359375, 3.80126953125, 203.84033203125, "FAHRSCOOL") -- Dodo
fahrCar[20] = createVehicle(593, 1345.978515625, 165.205078125, 21.379302978516, 2.9937744140625, 357.35229492188, 201.91223144531, "FAHRSCOOL") -- Dodo
fahrCar[21] = createVehicle(521, 1390.6513671875, 370.302734375, 19.327711105347, 359.63195800781, 0, 335.51147460938, "FAHRSCOOL") -- FCR-900
fahrCar[22] = createVehicle(521, 1391.3857421875, 369.74609375, 19.326959609985, 359.58801269531, 359.98901367188, 338.53820800781, "FAHRSCOOL") -- FCR-900
fahrCar[23] = createVehicle(521, 1392.3330078125, 369.361328125, 19.327924728394, 359.61547851563, 0.0054931640625, 337.60986328125, "FAHRSCOOL") -- FCR-900
fahrCar[24] = createVehicle(521, 1393.47265625, 368.8310546875, 19.326519012451, 359.58251953125, 0.0384521484375, 336.97265625, "FAHRSCOOL") -- FCR-900
	
function FahrschulFahrzeugEnter ( player, seat )

	local veh = source
	source = player
	if getPedOccupiedVehicleSeat ( source ) == 0 then
	if isFahrschulMitglied(player) == false then
			if isInPruefung(player) == false then
				outputChatBox("INFO: Du hast kein Schluessel fuer dieses Fahrzeug.", source, 200, 0, 0, false)
				o_removePedFromVehicle(source)
			end
		end
	end
end

function isFahrschulMitglied(thePlayer)
	if(tonumber(getElementData(thePlayer, "pFraktion")) == 3) then return true else return false end
end
function isInPruefung(thePlayer)
	if(getElementData(thePlayer, "fahrpruefung") == true) then return true else return false end
end

function canEnterFahrschule(element)
	if(tonumber(getElementData(element, "pFraktion")) == 3) then return true;
	elseif(getElementData(player, "fahrpruefung") == true) then return true;
	else return false; end
end

for v = 1, #fahrCar, 1 do
	setVehicleColor(fahrCar[v], 200, 200, 0, 0, 0, 0)
	setElementData(fahrCar[v], "Typ", "Fraktionsauto")
	setElementData(fahrCar[v], "Besitzer", "Fahrschule")
	setVehicleEngineState(fahrCar[v], false)
	toggleVehicleRespawn ( fahrCar[v], true )
	setVehicleRespawnDelay ( fahrCar[v], 5000 )
	setVehicleIdleRespawnDelay ( fahrCar[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", fahrCar[v], FahrschulFahrzeugEnter )
end

outputDebugString(#fahrCar.." Fahrschul-Fraktionsautos geladen.")

local Respawn = {}
local Respawntime = 10
addEvent("onFahrschulCarRespawnAD", true)
addEventHandler("onFahrschulCarRespawnAD", getRootElement(),
function()
	if(client ~= source) then return end
	for v = 1, #fahrCar, 1 do
		respawnVehicle(fahrCar[v])
	end
	outputChatBox(#fahrCar.." Fahrschul-Autos wurden respawnt.", source, 0, 200, 0)
end)

addEvent("onFahrschulCarRespawn", true)
addEventHandler("onFahrschulCarRespawn", getRootElement(),
function()
	if(Respawn[source] == true) then outputChatBox("Du kannst nur jede "..Respawntime.." Minuten Respawnen!", source, 200, 0, 0, false) return end
	for v = 1, #fahrCar, 1 do
		respawnVehicle(fahrCar[v])
	end
	Respawn[source] = true
	local playa = source
	setTimer(function() Respawn[playa] = false end, Respawntime*60*1000, 1)
end)