local cando = true
local key = "vehicle_fire"
local waitseconds = 10
local enabled = false

function renderRocketFX()
	for index, object in pairs(getElementsByType("object")) do 
		if(getElementData(object, "rocket.state") == true) then
			local x1, y1, z1 = getElementPosition(object)
			for i = 1, 5, 1 do
				fxAddTyreBurst(x1, y1, z1, 0, 0, 0)
				fxAddPunchImpact(x1, y1, z1, 0, 0, 0)
			end
		end
	end
end
--addEventHandler("onClientRender", getRootElement(), renderRocketFX)
--addEventHandler("onClientPreRender", getRootElement(), renderRocketFX)
addEventHandler("onClientRender", getRootElement(), function()
	if(enabled == true) then
			if not(isPedInVehicle(gMe)) then return end
			local veh = getPedOccupiedVehicle(gMe)
			if(getElementData(veh, "rocketterror") ~= true) then return end
			local col2 = getElementData(veh, "tr.col2")
			local col1 = getElementData(veh, "tr.col1")
			if not(col2) or not(col1) then return end
			local x, y, z = getElementPosition(col2)
			local x1, y1, z1 = getElementPosition(col1)
			z1 = z1+getElementDistanceFromCentreOfMassToBaseOfModel(veh)*2
			local hit, x2, y2, z2 = processLineOfSight(x, y, z, x1, y1, z1)
			if not(x2) or not(y2) or not(z2) then x2, y2, z2 = x, y, z end
			local sx, sy = getScreenFromWorldPosition(x2, y2, z2)
			if not(sx) or not(sy) then return end	
			local distanz = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
			dxDrawLine(sx, sy-12.9, sx, sy+12.9, tocolor(0, 255, 0), 2)
			dxDrawLine(sx-12.9, sy, sx+12.9, sy, tocolor(0, 255, 0), 2)
	end
end)
addEvent("onClientRocketFire_Terror", true)
addEventHandler("onClientRocketFire_Terror", getRootElement(), function(theRocket)
	local x, y, z = getElementPosition(theRocket)
	local sound = playSound3D("sounds/rocket.mp3", x, y, z, false)
	setSoundMaxDistance(sound, 100)
	attachElements(sound, theRocket)
end)

function fireVehicleRocket_terror()
	if(cando == false) then return end
	if(enabled == false) then return end
	local veh = getPedOccupiedVehicle(gMe)
	if(veh) then else unbindKey(key, "up", fireVehicleRocket_terror) return end
	local col1 = getElementData(veh, "tr.col1")
	local col2 = getElementData(veh, "tr.col2")
	local x1, y1, z1 = getElementPosition(col1)
	local x2, y2, z2 = getElementPosition(col2)
	z1 = z1+getElementDistanceFromCentreOfMassToBaseOfModel(veh)*2
	local hit, hx, hy, hz = processLineOfSight(x1, y1, z1, x2, y2, z2)
	if not(hx) or not(hy) or not(hz) then hx, hy, hz = x2, y2, z2 end
	local distanz = getDistanceBetweenPoints3D(x1, y1, z1, hx, hy, hz)
	local time = distanz*10
	cando = false
	setTimer(function() cando = true end, waitseconds*1000, 1)
	triggerServerEvent("onRocketCreation_Terror", gMe, x1, y1, z1, hx, hy, hz, time)
end

addEventHandler("onClientPlayerWasted", gMe, function()
	unbindKey(key, "up", fireVehicleRocket_terror)
end)

addEventHandler("onClientVehicleExit", getRootElement(), function(thePlayer)
	if(thePlayer ~= gMe) then return end
	unbindKey(key, "up", fireVehicleRocket_terror)
end)

addEvent("onClientRocketEnter_Terror", true)
addEventHandler("onClientRocketEnter_Terror", getRootElement(), function()
	bindKey(key, "up", fireVehicleRocket_terror)
	enabled = true
end)

function checkVehicleCol()
	for index, car in pairs(getElementsByType("vehicle")) do
		if not(getElementData(car, "tr.col1")) then
			local col1 = createColSphere(0, 0, 0, 2)
			local col2 = createColSphere(0, 0, 0, 2)
			setElementData(car, "tr.col1", col1, false)
			setElementData(car, "tr.col2", col2, false)
			attachElements(col1, car)
			attachElements(col2, car, 0, 250, 0)
		end
	end
end
setTimer(checkVehicleCol, 5000, 0)
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), function()
	for index, car in pairs(getElementsByType("vehicle")) do
		setElementData(car, "tr.col1", nil, false)
		setElementData(car, "tr.col2", nil, false)
	end
end)