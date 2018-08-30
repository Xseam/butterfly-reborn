local vehs =  {}
vehs[1] = createVehicle(560, 1056.20703125, -289.5380859375, 73.697814941406, 359.8681640625, 0, 267.451171875, "REDBROTHER") -- Sultan
vehs[2] = createVehicle(560, 1056.619140625, -292.919921875, 73.695358276367, 359.79675292969, 0.1153564453125, 258.06884765625, "REDBROTHER") -- Sultan
vehs[3] = createVehicle(560, 1056.01171875, -298.82421875, 73.697372436523, 359.86267089844, 359.99450683594, 266.33056640625, "REDBROTHER") -- Sultan
vehs[4] = createVehicle(560, 1056.22265625, -301.6220703125, 73.697532653809, 359.85717773438, 359.96704101563, 268.25317382813, "REDBROTHER") -- Sultan
vehs[5] = createVehicle(560, 1056.72265625, -304.1904296875, 73.697463989258, 359.8681640625, 359.99450683594, 268.39050292969, "REDBROTHER") -- Sultan
vehs[6] = createVehicle(560, 1056.33203125, -307.5703125, 73.697357177734, 359.8681640625, 359.99450683594, 269.28039550781, "REDBROTHER") -- Sultan
vehs[7] = createVehicle(405, 1090.830078125, -316.6015625, 73.867134094238, 0, 0, 179.53857421875, "REDBROTHER") -- Sentinel
vehs[8] = createVehicle(405, 1090.7490234375, -326.6728515625, 73.867164611816, 359.99450683594, 0, 179.53857421875, "REDBROTHER") -- Sentinel
vehs[9] = createVehicle(405, 1096.107421875, -331.58203125, 73.86547088623, 359.98352050781, 359.96704101563, 268.13781738281, "REDBROTHER") -- Sentinel
vehs[10] = createVehicle(405, 1106.0771484375, -331.61328125, 73.859794616699, 359.99450683594, 0.010986328125, 269.79125976563, "REDBROTHER") -- Sentinel
vehs[11] = createVehicle(405, 1117.1611328125, -331.7958984375, 73.861740112305, 0.087890625, 359.84619140625, 267.41271972656, "REDBROTHER") -- Sentinel
vehs[12] = createVehicle(455, 1105.8291015625, -351.005859375, 74.423973083496, 0.032958984375, 0.087890625, 117.82836914063, "REDBROTHER") -- Flatbed
vehs[13] = createVehicle(482, 1028.142578125, -297.552734375, 74.106750488281, 359.08813476563, 0.0054931640625, 177.14904785156, "REDBROTHER") -- Burrito
vehs[14] = createVehicle(482, 1028.1005859375, -307.482421875, 74.10693359375, 359.04418945313, 359.99450683594, 177.43469238281, "REDBROTHER") -- Burrito
vehs[15] = createVehicle(482, 1036.9326171875, -308.373046875, 74.111946105957, 359.12109375, 359.99450683594, 180.62072753906, "REDBROTHER") -- Burrito
vehs[16] = createVehicle(482, 1036.8349609375, -299.4423828125, 74.119850158691, 359.18151855469, 0, 180.62072753906, "REDBROTHER") -- Burrito
vehs[17] = createVehicle(487, 1040.720703125, -354.6875, 74.168899536133, 0.263671875, 359.65942382813, 181.52709960938, "REDBROTHER") -- Maverick
vehs[18] = createVehicle(428, 1010.650390625, -338.6025390625, 74.116897583008, 0.2252197265625, 0.10986328125, 173.60046386719, "REDBROTHER") -- Securicar
vehs[19] = createVehicle(521, 1096.9599609375, -357.9267578125, 73.561859130859, 359.63195800781, 359.94506835938, 1.03271484375, "REDBROTHER") -- FCR-900
vehs[20] = createVehicle(521, 1096.671875, -366.185546875, 73.54044342041, 1.439208984375, 359.90661621094, 4.2352294921875, "REDBROTHER") -- FCR-900
vehs[21] = createVehicle(521, 1098.6982421875, -366.8349609375, 73.522491455078, 2.384033203125, 0.1043701171875, 356.51733398438, "REDBROTHER") -- FCR-900
vehs[22] = createVehicle(521, 1099.9814453125, -366.818359375, 73.523811340332, 2.4169921875, 0.0933837890625, 357.50610351563, "REDBROTHER") -- FCR-900
vehs[23] = createVehicle(521, 1101.4755859375, -367.0068359375, 73.518928527832, 2.3675537109375, 359.84619140625, 3.603515625, "REDBROTHER") -- FCR-900
vehs[24] = createVehicle(521, 1102.9716796875, -367.0244140625, 73.520545959473, 1.9775390625, 359.93957519531, 357.48413085938, "REDBROTHER") -- FCR-900

function RedBrotherFahrzeugEnter ( player, seat )

	local veh = source
	source = player
	if getPedOccupiedVehicleSeat ( source ) == 0 then
	if not(getPlayerFraktion(source) == 6) then
		outputChatBox("INFO: Du hast kein Schluessel fuer dieses Fahrzeug.", source, 200, 0, 0, false)
		o_removePedFromVehicle(source)
		else
			if(getElementModel(veh) == 455) then
			outputChatBox("Nutze /waffentruck um den Waffentruck zu starten.", source, 0, 200, 0, false)
			end
	end
	end
end


for v = 1, #vehs, 1 do
	setVehicleColor(vehs[v], 200, 0, 0, 200, 0, 0)
	setElementData(vehs[v], "Typ", "Fraktionsauto")
	setElementData(vehs[v], "Besitzer", "Red Brothers")
	setVehicleEngineState(vehs[v], false)
	toggleVehicleRespawn ( vehs[v], true )
	setVehicleRespawnDelay ( vehs[v], 5000 )
	setVehicleIdleRespawnDelay ( vehs[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", vehs[v], RedBrotherFahrzeugEnter )
	if(getElementModel(vehs[v]) == 482) then -- Burrito
		giveVehicleBetterEngine(vehs[v])
		giveVehiclePanzerung(vehs[v])
	end
	if(getElementModel(vehs[v]) == 455) then -- Flatbed
		giveVehicleBetterEngine(vehs[v])
		giveVehiclePanzerung(vehs[v])
	end
	if(getElementModel(vehs[v]) == 428) then -- Securicar
		giveVehiclePanzerung(vehs[v])
	end
	if(getElementModel(vehs[v]) == 560) then -- Sultan
		giveVehicleBetterEngine(vehs[v])
	end
end

outputDebugString(#vehs.." Red Brother-Fraktionsautos geladen.")

local Respawn = {}
local Respawntime = 10

addEvent("onRedBrothersCarRespawnAD", true)
addEventHandler("onRedBrothersCarRespawnAD", getRootElement(),
function()
	if(client ~= gMe) then return end
	for v = 1, #vehs, 1 do
		respawnVehicle(vehs[v])
	end
	outputChatBox(#vehs.." Red-Brother Autos wurden respawnt.", source, 0, 200, 0)
end)

addEvent("onRedBrothersCarRespawn", true)
addEventHandler("onRedBrothersCarRespawn", getRootElement(),
function()
	if(Respawn[source] == true) then outputChatBox("Du kannst nur jede "..Respawntime.." Minuten Respawnen!", source, 200, 0, 0, false) return end
	for v = 1, #vehs, 1 do
		respawnVehicle(vehs[v])
	end
	Respawn[source] = true
	local playa = source
	setTimer(function() Respawn[playa] = false end, Respawntime*60*1000, 1)
end)