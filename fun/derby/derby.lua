local Marker = createMarker(2781.0346679688, -1812.7277832031, 11, "cylinder", 1.0, 0, 255, 0)
-- Draussen: 2782.6638183594, -1814.6776123047, 11.84375
local Marker2 = createMarker(-1367.3145751953, 930.47473144531, 1035.4980957031, "cylinder", 1.0, 0, 255, 0)
setElementInterior(Marker2, 15)
-- Drinnen: 1365.4462890625, 930.54504394531, 1036.3006591797

addEventHandler("onMarkerHit", Marker2, function(hitElement)
	if(getElementType(hitElement) == "player") then
		setInPosition(hitElement, 2782.6638183594, -1814.6776123047, 11.84375, 0)
		setElementData(hitElement, "derby", false)
	end
end)

addEventHandler("onMarkerHit", Marker, function(hitElement)
	if(getElementType(hitElement) == "player") then
		fadeCamera(hitElement, false)
		toggleAllControls(hitElement, false)
		setTimer( function()
			setElementInterior(hitElement, 15)
			setElementPosition(hitElement, -1365.4462890625, 930.54504394531, 1036.3006591797)
			fadeCamera(hitElement, true)
			toggleAllControls(hitElement, true)
			triggerClientEvent(hitElement, "onClientDerbyEnter", hitElement)
			setElementData(hitElement, "derby", true)
			outputChatBox("Du bist nun in der Derby-Arena. Viel Spass!", hitElement, 0, 255, 255)
		end, 1000, 1)
	end
end)

local vehs = {}

vehs[1] = createVehicle(504, -1302.1455078125, 956.1015625, 1036.4190673828, 0.8349609375, 359.51110839844, 34.266357421875) -- Bloodring Banger
vehs[2] = createVehicle(504, -1298.138671875, 956.8134765625, 1036.4235839844, 0.76904296875, 359.40124511719, 47.796020507813) -- Bloodring Banger
vehs[3] = createVehicle(504, -1293.875, 959.77734375, 1036.4638671875, 0.7855224609375, 359.37377929688, 42.171020507813) -- Bloodring Banger
vehs[4] = createVehicle(504, -1289.98828125, 963.5390625, 1036.5189208984, 0.703125, 359.15954589844, 50.674438476563) -- Bloodring Banger
vehs[5] = createVehicle(504, -1286.5869140625, 967.564453125, 1036.5842285156, 0.703125, 359.14306640625, 51.756591796875) -- Bloodring Banger
vehs[6] = createVehicle(504, -1283.322265625, 970.1953125, 1036.6232910156, 0.72509765625, 359.18701171875, 55.409545898438) -- Bloodring Banger
vehs[7] = createVehicle(504, -1281.248046875, 973.330078125, 1036.6734619141, 0.5987548828125, 358.91784667969, 63.21533203125) -- Bloodring Banger
vehs[8] = createVehicle(504, -1280.0927734375, 976.2177734375, 1036.7155761719, 0.52734375, 358.96179199219, 67.219848632813) -- Bloodring Banger
vehs[9] = createVehicle(504, -1277.4599609375, 981.8798828125, 1036.8092041016, 0.3240966796875, 359.03869628906, 72.163696289063) -- Bloodring Banger
vehs[10] = createVehicle(504, -1276.8095703125, 985.439453125, 1036.8676757813, 0.384521484375, 358.9892578125, 76.810913085938) -- Bloodring Banger
vehs[11] = createVehicle(504, -1276.1640625, 988.7734375, 1036.9224853516, 0.28564453125, 359.05517578125, 80.315551757813) -- Bloodring Banger
vehs[12] = createVehicle(504, -1275.21484375, 992.5576171875, 1036.9812011719, 0.10986328125, 359.00573730469, 84.08935546875) -- Bloodring Banger
vehs[13] = createVehicle(504, -1274.673828125, 997.8037109375, 1037.0688476563, 0.1593017578125, 359.15954589844, 89.967041015625) -- Bloodring Banger
vehs[14] = createVehicle(504, -1275.0888671875, 1001.5556640625, 1037.1307373047, 0.0274658203125, 358.81896972656, 92.30712890625) -- Bloodring Banger
vehs[15] = createVehicle(504, -1275.5439453125, 1004.9814453125, 1037.1888427734, 359.85717773438, 359.033203125, 94.443969726563) -- Bloodring Banger
vehs[16] = createVehicle(504, -1276.2578125, 1007.9619140625, 1037.2399902344, 359.81872558594, 358.90686035156, 104.02954101563) -- Bloodring Banger
local var = 1

for i = 1, #vehs, 1 do
	local veh = vehs[i]
	setElementInterior(veh, 15)
	if(var > 0) and (var < 5) then
		setVehicleColor(veh, 255, 0, 0, 0, 0, 0) -- Rot
	end
	if(var > 4) and (var < 9) then
		setVehicleColor(veh, 0, 255, 0, 0, 0, 0) -- Gruen
	end
	if(var > 8) and (var < 13) then
		setVehicleColor(veh, 0, 0, 255, 0, 0, 0) --  Blau
	end
	if(var > 12) and (var < 17) then
		setVehicleColor(veh, 255, 255, 0, 0, 0, 0) -- Gelb
	end
	var = var+1
	setElementData(veh, "Typ", "Freecar")
	setVehicleEngineState(veh, false)
	toggleVehicleRespawn ( veh, true )
	setVehicleRespawnDelay ( veh, 10000 )
	setElementData(veh, "fuelable", false)
	setElementData(veh, "fuel", math.random(10, 90))
end

addCommandHandler("respawnderby", function(thePlayer)
	if(getPlayerAdminlevel(thePlayer) > 0) then
		for i = 1, #vehs, 1 do
			respawnVehicle(vehs[i])
		end
		outputChatBox(#vehs.." Derby-Autos wurden Respawnt.", thePlayer, 0, 255, 255)
	end
end)
