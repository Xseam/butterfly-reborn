local newsCar = {}

newsCar[1] = createVehicle(582, 2263.1201171875, 78.5068359375, 26.471607208252, 359.58801269531, 0, 272.31262207031, "NEWS") -- Newsvan
newsCar[2] = createVehicle(582, 2263.1826171875, 81.982421875, 26.507013320923, 359.58251953125, 2.7301025390625, 269.45068359375, "NEWS") -- Newsvan
newsCar[3] = createVehicle(582, 2263.02734375, 85.6923828125, 26.533962249756, 359.52209472656, 0, 270.05493164063, "NEWS") -- Newsvan
newsCar[4] = createVehicle(582, 2263.0517578125, 92.4326171875, 26.389352798462, 359.54406738281, 359.99450683594, 267.83569335938, "NEWS") -- Newsvan
newsCar[5] = createVehicle(582, 2263.263671875, 95.837890625, 26.476127624512, 359.62097167969, 5.2569580078125, 269.85717773438, "NEWS") -- Newsvan
newsCar[6] = createVehicle(582, 2263.029296875, 99.1181640625, 26.536849975586, 359.53857421875, 359.98352050781, 269.85717773438, "NEWS") -- Newsvan
newsCar[7] = createVehicle(582, 2263.0302734375, 103.091796875, 26.460718154907, 359.53857421875, 0.076904296875, 269.99450683594, "NEWS") -- Newsvan
newsCar[8] = createVehicle(582, 2263.0625, 106.248046875, 26.466798782349, 359.560546875, 359.97253417969, 270.37353515625, "NEWS") -- Newsvan
newsCar[9] = createVehicle(582, 2263.046875, 109.0908203125, 26.464916229248, 359.560546875, 359.97802734375, 269.91760253906, "NEWS") -- Newsvan
newsCar[10] = createVehicle(582, 2274.1982421875, 103.240234375, 26.462770462036, 359.54956054688, 359.97802734375, 90.192260742188, "NEWS") -- Newsvan
newsCar[11] = createVehicle(582, 2274.0078125, 100.341796875, 26.534599304199, 359.52758789063, 359.99450683594, 89.263916015625, "NEWS") -- Newsvan
newsCar[12] = createVehicle(586, 2254.4140625, 53.642578125, 25.926763534546, 0.59326171875, 0, 348.29956054688, "NEWS") -- Wayfarer
newsCar[13] = createVehicle(586, 2252.17578125, 53.8681640625, 25.926202774048, 0.6097412109375, 0, 349.63439941406, "NEWS") -- Wayfarer
newsCar[14] = createVehicle(586, 2250.4072265625, 53.833984375, 25.924493789673, 1.0821533203125, 0, 347.96997070313, "NEWS") -- Wayfarer
newsCar[15] = createVehicle(586, 2248.982421875, 53.6982421875, 25.925157546997, 1.0931396484375, 0, 346.36047363281, "NEWS") -- Wayfarer
newsCar[16] = createVehicle(586, 2246.7861328125, 54.134765625, 25.925586700439, 0.911865234375, 0, 344.10827636719, "NEWS") -- Wayfarer
newsCar[17] = createVehicle(586, 2244.974609375, 53.201171875, 25.924362182617, 0.703125, 359.97802734375, 341.68579101563, "NEWS") -- Wayfarer
newsCar[18] = createVehicle(409, 2281.8955078125, 113.8134765625, 26.20777130127, 0, 0.032958984375, 359.18151855469, "NEWS") -- Stretch
newsCar[19] = createVehicle(488, 2248.6884765625, 92.0888671875, 35.787631988525, 359.98901367188, 359.70886230469, 358.74755859375, "NEWS") -- News Chopper
newsCar[20] = createVehicle(488, 2248.3583984375, 119.384765625, 35.787593841553, 359.98901367188, 359.70336914063, 176.96228027344, "NEWS") -- News Chopper

function RCNRFahrzeugEnter ( player, seat )

	local veh = source
	source = player
	if getPedOccupiedVehicleSeat ( source ) == 0 then
	if not(getPlayerFraktion(source) == 5) then
		outputChatBox("INFO: Du hast kein Schluessel fuer dieses Fahrzeug.", source, 200, 0, 0, false)
		o_removePedFromVehicle(source)
	end
	end
end


for v = 1, #newsCar, 1 do
	setVehicleColor(newsCar[v], 0, 77, 50, 0, 255, 255)
	setElementData(newsCar[v], "Typ", "Fraktionsauto")
	setElementData(newsCar[v], "Besitzer", "RCNR")
	setVehicleEngineState(newsCar[v], false)
	toggleVehicleRespawn ( newsCar[v], true )
	setVehicleRespawnDelay ( newsCar[v], 5000 )
	setVehicleIdleRespawnDelay ( newsCar[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", newsCar[v], RCNRFahrzeugEnter )
	if(getElementModel(newsCar[v]) == 582) then
		setVehicleHandling(newsCar[v], "engineAcceleration", 15)
		setVehicleHandling(newsCar[v], "maxVelocity", 250)
		
	end
end

outputDebugString(#newsCar.." RCNR-Fraktionsautos geladen.")

local Respawn = {}
local Respawntime = 10
addEvent("onrcnrCarRespawnAD", true)
addEventHandler("onrcnrCarRespawnAD", getRootElement(),
function()
	if(client ~= source) then return end
	for v = 1, #newsCar, 1 do
		respawnVehicle(newsCar[v])
	end
	outputChatBox(#newsCar.." News-Fahrzeuge wurden respawnt.", source, 0, 200, 0)
end)
addEvent("onrcnrCarRespawn", true)
addEventHandler("onrcnrCarRespawn", getRootElement(),
function()
	if(Respawn[source] == true) then outputChatBox("Du kannst nur jede "..Respawntime.." Minuten Respawnen!", source, 200, 0, 0, false) return end
	for v = 1, #newsCar, 1 do
		respawnVehicle(newsCar[v])
	end
	Respawn[source] = true
	local playa = source
	setTimer(function() Respawn[playa] = false end, Respawntime*60*1000, 1)
end)




