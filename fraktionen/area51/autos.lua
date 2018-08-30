local car = {}

car[1] = createVehicle(470, 221.74609375, 1920.2841796875, 17.630628585815, 359.71984863281, 359.99450683594, 179.27490234375) -- Patriot
car[2] = createVehicle(470, 218.5849609375, 1920.33203125, 17.632598876953, 359.72534179688, 0.010986328125, 179.00573730469) -- Patriot
car[3] = createVehicle(470, 213.458984375, 1920.2744140625, 17.632144927979, 359.72534179688, 0.0054931640625, 179.0771484375) -- Patriot
car[4] = createVehicle(470, 209.646484375, 1920.31640625, 17.632131576538, 359.72534179688, 0.0164794921875, 179.62097167969) -- Patriot
car[5] = createVehicle(470, 204.6064453125, 1920.103515625, 17.63366317749, 359.73083496094, 359.98901367188, 187.3828125) -- Patriot
car[6] = createVehicle(470, 200.4658203125, 1920.4892578125, 17.633882522583, 359.72534179688, 359.96704101563, 171.67236328125) -- Patriot
car[7] = createVehicle(470, 193.2353515625, 1921.4833984375, 17.6331615448, 359.71984863281, 0.0054931640625, 89.945068359375) -- Patriot
car[8] = createVehicle(548, 362.74609375, 1923.431640625, 19.291080474854, 0.845947265625, 0.02197265625, 118.77868652344) -- Cargobob
car[9] = createVehicle(548, 350.015625, 1979.53515625, 19.29069519043, 0.845947265625, 359.40673828125, 45.3076171875) -- Cargobob
car[10] = createVehicle(593, 276.306640625, 1962.96484375, 18.098819732666, 359.37927246094, 359.99450683594, 246.67053222656) -- Dodo
car[11] = createVehicle(593, 277.4716796875, 1948.55859375, 18.098260879517, 359.40124511719, 359.99450683594, 280.39855957031) -- Dodo
car[12] = createVehicle(476, 273.1669921875, 1999.95703125, 18.347951889038, 13.518676757813, 0, 237.06848144531) -- Rustler
car[13] = createVehicle(476, 275.83203125, 1981.171875, 18.346586227417, 13.507690429688, 359.99450683594, 298.41613769531) -- Rustler
car[14] = createVehicle(520, 279.970703125, 2017.0458984375, 18.368541717529, 1.856689453125, 0, 293.52722167969) -- Hydra
car[15] = createVehicle(564, 268.90234375, 2036.2880859375, 16.809989929199, 359.99450683594, 0, 216.78771972656) -- RC Tiger
car[16] = createVehicle(564, 271.642578125, 2036.685546875, 16.810001373291, 0.0164794921875, 359.99450683594, 210.57495117188) -- RC Tiger
car[17] = createVehicle(564, 273.8955078125, 2037.181640625, 16.809995651245, 0.0604248046875, 0.0439453125, 211.2451171875) -- RC Tiger
car[18] = createVehicle(564, 275.91015625, 2037.23046875, 16.809991836548, 359.96704101563, 359.93957519531, 218.64440917969) -- RC Tiger
car[19] = createVehicle(592, 311.8310546875, 2041.7880859375, 18.835012435913, 0.2197265625, 0, 181.70288085938) -- Andromada
car[20] = createVehicle(433, 283.419921875, 1797.90625, 18.076601028442, 359.99450683594, 359.90661621094, 306.44165039063) -- Barracks
car[21] = createVehicle(433, 154.748046875, 1875.7724609375, 18.437297821045, 1.3348388671875, 0.0054931640625, 1.746826171875) -- Barracks
car[22] = createVehicle(433, 179.09375, 1928.0537109375, 18.459690093994, 357.81921386719, 0.0933837890625, 267.20947265625) -- Barracks
car[23] = createVehicle(470, 131.2333984375, 1912.8544921875, 18.827238082886, 359.6923828125, 358.07189941406, 90.763549804688) -- Patriot
car[24] = createVehicle(470, 140.373046875, 1912.9833984375, 18.83911895752, 359.68139648438, 358.03344726563, 90.955810546875) -- Patriot
car[25] = createVehicle(470, 148.306640625, 1913.1142578125, 18.841701507568, 359.77478027344, 358.18176269531, 90.642700195313) -- Patriot
car[26] = createVehicle(470, 157.685546875, 1907.740234375, 18.728050231934, 359.54406738281, 0.7086181640625, 179.24743652344) -- Patriot
car[27] = createVehicle(470, 157.8740234375, 1899.9326171875, 18.610200881958, 358.69262695313, 2.427978515625, 181.35681152344) -- Patriot
car[28] = createVehicle(470, 126.080078125, 1876.4013671875, 17.825000762939, 359.71435546875, 359.98901367188, 182.4609375) -- Patriot

function shootRCTigerRocket(x, y, z, time, sx, sy, sz)
	local car = getPedOccupiedVehicle(source)
	local rx, ry, rz = getElementRotation(car)
	local missle = createObject(3786, sx, sy, sz+0.5, rx, ry, rz-90)
	setElementCollisionsEnabled(missle, false)
	setObjectScale(missle, 0.3)
	moveObject(missle, time, x, y, z, 0, 0, 0, "InQuad")
	triggerClientEvent(getRootElement(), "onRCTigerShootSparks", source, sx, sy, sz)
	setTimer( function()
		destroyElement(missle)
		createExplosion(x, y, z, 12)
	
	end, time, 1)
end
addEvent("onArmyRCTigerShoot", true)
addEventHandler("onArmyRCTigerShoot", getRootElement(), shootRCTigerRocket)

function shootDodoRocket(cx, cy, cz, x, y, z, time)
	local car = getPedOccupiedVehicle(source)
	local rx, ry, rz = getElementRotation(car)
	destroyElement(getElementData(car, "object"))
	local missle = createObject(3786, cx, cy, cz-0.5, rx, ry, rz-90)
	local marker = createMarker(cx, cy, cz-0.5, "corona", 1.0, 255, 0, 0)
	attachElements(marker, missle)
	moveObject(missle, time, x, y, z, 0, 0, 0, "InQuad")
	setTimer( function()
		destroyElement(missle)
		destroyElement(marker)
		createExplosion(x, y, z, 7)
		setTimer(createExplosion, 75, 1, x, y, z+7, 7)
		setTimer(createExplosion, 125, 1, x, y, z+15, 7)
		local object = createObject(3786, 0, 0, 0)
		attachElements(object, car, 0, 0, -1)
		setElementAttachedOffsets(object, 0, 0, -1, 0, 0, 270)
		setElementData(car, "object", object)
		setElementCollisionsEnabled(object, false)
	end, time, 1)
end
addEvent("onArmyDodoRocketShoot", true)
addEventHandler("onArmyDodoRocketShoot", getRootElement(), shootDodoRocket)

addEvent("onArmyCarRespawn", true)
addEventHandler("onArmyCarRespawn", getRootElement(), function()
	for i = 1, #car, 1 do
		respawnVehicle(car[i])
	end
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerFraktion(player) == 4) or (getPlayerFraktion(player) == 7) then
			outputChatBox("(( Spieler "..getPlayerName(source).." hat die Army-Autos respawnt. ))", player, 0, 255, 255)
		end
	end
end)

for v = 1, #car, 1 do
	setVehicleColor(car[v], 0, math.random(20, 60), 0, 0, 0, 0)
	setElementData(car[v], "Typ", "Fraktionsauto")
	setElementData(car[v], "Besitzer", "FBI/RCPD")
	setVehicleEngineState(car[v], false)
	toggleVehicleRespawn ( car[v], true )
	setVehicleRespawnDelay ( car[v], 5000 )
	setVehicleIdleRespawnDelay ( car[v], FraktionsCarRespawn*1000*60 )
	addEventHandler ( "onVehicleEnter", car[v], function(player)
		local veh = source
		source = player
		if getPedOccupiedVehicleSeat ( source ) == 0 then
			if (getPlayerFraktion(source) == 4) or (getPlayerFraktion(source) == 7) then else
				outputChatBox("INFO: Du hast kein Schluessel fuer dieses Fahrzeug.", source, 200, 0, 0, false)
				o_removePedFromVehicle(source)
			end
		end
		if(getElementModel(veh) == 564) then
			setElementAlpha(source, 0)
		end
	end)
	
	if(getElementModel(car[v]) == 564) then -- RC
		addEventHandler ( "onVehicleEnter", car[v], function(player)
			triggerClientEvent(player, "onArmyRCTigerEnter", player)
		end)
		addEventHandler ( "onVehicleExit", car[v], function(player)
			setElementAlpha(player, 255)
			triggerClientEvent(player, "onArmyRCTigerExit", player)
		end)
	end
	if(getElementModel(car[v]) == 433) then -- Barracks
		addEventHandler ( "onVehicleEnter", car[v], function(player)
			if(isACop(player)) then
				outputChatBox("Nutze /arm um dich Auszuruesten.", player, 0, 200, 0)
			end
		end)
		setElementData(car[v], "armcar", true)
	end
	if(getElementModel(car[v]) == 593) then -- DODO
		local object = createObject(3786, 0, 0, 0)
		attachElements(object, car[v], 0, 0, -1)
		setElementAttachedOffsets(object, 0, 0, -1, 0, 0, 270)
		setElementData(car[v], "object", object)
		setElementCollisionsEnabled(object, false)
		addEventHandler ( "onVehicleEnter", car[v], function(player)
			if getPedOccupiedVehicleSeat ( player ) == 0 then else
				triggerClientEvent(player, "onArmyDodoEnter", player)
			end
		end)
		addEventHandler ( "onVehicleExit", car[v], function(player)
			if getPedOccupiedVehicleSeat ( player ) == 0 then else
				triggerClientEvent(player, "onArmyDodoExit", player)
			end
		end)
		addEventHandler ( "onVehicleExplode", car[v], function()
			if(getVehicleOccupant(source)) then
				for index, player in pairs(getVehicleOccupants(source)) do
					triggerClientEvent(player, "onArmyDodoExit", player)
				end
			end
		end)
	end
	
	if(getElementModel(car[v]) == 598) then
		setVehicleHandling(car[v], "engineAcceleration", 20)
		setVehicleHandling(car[v], "maxVelocity", 300)
	end
	if(getElementModel(car[v]) == 599) then
		setVehicleHandling(car[v], "engineAcceleration", 20)
		setVehicleHandling(car[v], "maxVelocity", 300)
	end
	if(getElementModel(car[v]) == 525) then
		local handling = getVehicleHandling ( car[v] )
		setVehicleHandling(car[v], "engineAcceleration", handling["engineAcceleration"]+4)
		setVehicleHandling(car[v], "maxVelocity", handling["maxVelocity"]+100)
	end
	if(getElementModel(car[v]) == 528) then
		local obj = createObject(3280, 0, 0, 0)
		attachElements(obj, car[v], 0, -1.04, 1.04)
		setElementCollisionsEnabled(obj, false)
		setElementData(car[v], "STEL", "0")
	end
	

end