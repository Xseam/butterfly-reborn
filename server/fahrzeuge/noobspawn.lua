-- Faggios 
local faggio = {}
faggio[1] = createVehicle(462, 247.80078125, -37.822265625, 1.1758930683136, 359.93408203125, 359.99450683594, 86.923828125)
faggio[2] = createVehicle(462, 247.794921875, -35.6982421875, 1.1763855218887, 0.59326171875, 359.97253417969, 91.323852539063)
faggio[3] = createVehicle(462, 247.8916015625, -32.966796875, 1.1759427785873, 1.0491943359375, 0.0164794921875, 89.132080078125)
faggio[4] = createVehicle(462, 247.787109375, -31.28125, 1.1767129898071, 359.81323242188, 0.0054931640625, 91.576538085938)
faggio[5] = createVehicle(462, 247.80859375, -28.998046875, 1.1766347885132, 359.80224609375, 359.93957519531, 87.451171875)
faggio[6] = createVehicle(462, 247.810546875, -27.4853515625, 1.176632642746, 359.83520507813, 359.97802734375, 88.236694335938)
faggio[7] = createVehicle(462, 250.90625, -18.5185546875, 1.4299104213715, 358.11584472656, 357.17102050781, 79.546508789063)
faggio[8] = createVehicle(462, 251.0224609375, -20.26953125, 1.3465481996536, 359.296875, 357.09411621094, 86.396484375)
faggio[9] = createVehicle(462, 251.068359375, -21.951171875, 1.2565245628357, 359.32983398438, 356.42944, 74.299)
faggio[10] = createVehicle(462, 253.5830078125, -12.7705078125, 1.7661248445511, 357.451171875, 356.42944335938, 74.229125976563)


for v = 1, #faggio, 1 do
	setVehicleColor(faggio[v], 255, 255, 255)
	setElementData(faggio[v], "Typ", "Anfaengerauto")
	toggleVehicleRespawn ( faggio[v], true )
	setVehicleRespawnDelay ( faggio[v], 5000 )
	setVehicleIdleRespawnDelay ( faggio[v], 30*1000*60 )
	--local x, y, z, rx, ry, rz = getElementPosition(faggio[v]), getElementRotation(faggio[v])
	--setVehicleRespawnPosition(faggio[v], x, y, z, rx, ry, rz)
end
-- MUAHHA ICH KANNS :D --

addEvent("onNoobspawnCarsRespawn", true)
addEventHandler("onNoobspawnCarsRespawn", getRootElement(),
function()
	if(client ~= source) then return end
	for v = 1, #faggio, 1 do
		respawnVehicle(faggio[v])
	end
	outputChatBox(#faggio.." Noobspawn Faggios wurden respawnt.", source, 0, 200, 0)
end)
