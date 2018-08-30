local canshoot = true
local canshoot2 = true
local mouseFrameDelay = 0
local rotX, rotY = 0,0

function shootRCRocket()
	if(isPedInVehicle(gMe) == false) then unbindKey("mouse1", "up", shootRCRocket) return end
	if(canshoot2 == false) then return end
	local car = getPedOccupiedVehicle(gMe)
	local x, y, z = getElementPosition(car)
	local col1 = createColSphere(x, y, z+1, 1)
	local kacke, scheisse, ang = getElementRotation( car )
	local x, y, z = getElementPosition( car )
	local cx1, cy1, cz1 = getElementPosition(col1)
	local cx2, cy2, cz2 = x+math.sin(math.rad(-ang))*300, y+math.cos(math.rad(-ang))*300, z
	local startx, starty, startz = x+math.sin(math.rad(-ang))*2, y+math.cos(math.rad(-ang))*2, z
	local element, hitx, hity, hitz = processLineOfSight(cx1, cy1, cz1, cx2, cy2, cz2)
	if not(hitx) then return end
	local distanz = getDistanceBetweenPoints3D(cx1, cy1, cz1, hitx, hity, hitz)
	local time = distanz*20
	--outputChatBox(tostring(distanz))
	--outputChatBox(tostring(cx2)..", "..tostring(cy2)..", "..tostring(cz2))
	setTimer(destroyElement, 1000, 1, col1)
	triggerServerEvent("onArmyRCTigerShoot", gMe, hitx, hity, hitz, time, startx, starty, startz)
	canshoot2 = false
	setTimer(function() canshoot2 = true end, 1000, 1)
end
addEvent("onRCTigerShootSparks", true)
addEventHandler("onRCTigerShootSparks", getRootElement(), function(sx, sy, sz)
	fxAddPunchImpact(sx, sy, sz, 0, -3, 0)
	fxAddPunchImpact(sx, sy, sz, 0, -3, 0)
	fxAddPunchImpact(sx, sy, sz, 0, -3, 0)
	fxAddPunchImpact(sx, sy, sz, 0, -3, 0)
	fxAddSparks(sx, sy, sz, 0, -3, 0)
	fxAddSparks(sx, sy, sz, 0, -3, 0)
	fxAddSparks(sx, sy, sz, 0, -3, 0)
	fxAddSparks(sx, sy, sz, 0, -3, 0)
end)
addEvent("onArmyRCTigerEnter", true)
addEventHandler("onArmyRCTigerEnter", getRootElement(), function()
	bindKey("mouse1", "up", shootRCRocket)
end)

addEvent("onArmyRCTigerExit", true)
addEventHandler("onArmyRCTigerExit", getRootElement(), function()
	unbindKey("mouse1", "up", shootRCRocket)
end)

function shootDodoRocket()
	if(isPedInVehicle(gMe) == false) then unbindKey("mouse1", "up", shootDodoRocket) return end
	if(canshoot == false) then return end
	local sx, sy = guiGetScreenSize()
	local cx, cy, cz = getCameraMatrix()
	cz = cz-5
	local wX,wY,wZ = getWorldFromScreenPosition(sx/2, sy/2, 2000)	
	local hit, x, y, z = processLineOfSight(cx, cy, cz, wX,wY,wZ)
	if not(x) then outputChatBox("Unbekanntes Ziel!", 200, 0, 0) return end
	local distanz = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz)
	if(distanz < 5) then return end
	local time = distanz*10
	canshoot = false
	setTimer(function() canshoot = true end, 5000, 1)
	triggerServerEvent("onArmyDodoRocketShoot", gMe, cx, cy, cz, x, y, z, time)
	outputChatBox("Rakete Abgefeuert! Mache neue Rakete zum abfeuern bereit.", 0, 200, 0)
end
function renderCursor(cX, cY, aX, aY)
	if isCursorShowing() or isMTAWindowActive() then
		mouseFrameDelay = 5
		return
	elseif mouseFrameDelay > 0 then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end
	

    local width, height = guiGetScreenSize()
    aX = aX - width / 2 
    aY = aY - height / 2
	
	
    rotX = rotX + aX * 0.3 * 0.01745
    rotY = rotY - aY * 0.3 * 0.01745
	
	local PI = math.pi
	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end
	
	if rotY > PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end

    if rotY < -PI / 2.05 then
       rotY = -PI / 2.05
    elseif rotY > PI / 2.05 then
        rotY = PI / 2.05
    end
	local cameraAngleX = rotX
    local cameraAngleY = rotY
	
    local freeModeAngleZ = math.sin(cameraAngleY)
    local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
    local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)
	
	local camPosX, camPosY, camPosZ = getCameraMatrix()

    local camTargetX = camPosX + freeModeAngleX * 100
    local camTargetY = camPosY + freeModeAngleY * 100
    local camTargetZ = camPosZ + freeModeAngleZ * 100
	setCameraMatrix ( camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ)
end
function setDodoEnabled()
	bindKey("mouse1", "up", shootDodoRocket)
	--outputChatBox("Rakete gebindet", 0, 200, 0)
	addEventHandler("onClientRender", getRootElement(), renderHud)
	addEventHandler("onClientCursorMove", getRootElement(), renderCursor)
end

function setDodoDisabled()
	unbindKey("mouse1", "up", shootDodoRocket)
	--outputChatBox("Rakete ungebindet", 0, 200, 0)
	removeEventHandler("onClientRender", getRootElement(), renderHud)
	removeEventHandler("onClientCursorMove", getRootElement(), renderCursor)
	setCameraTarget(gMe)
end
addEventHandler("onClientPlayerWasted", gMe, function()
	setDodoDisabled()
end)
addEvent("onArmyDodoExit", true)
addEventHandler("onArmyDodoExit", getRootElement(), function()
	unbindKey("num_add", "down", setDodoEnabled)
	unbindKey("num_add", "up", setDodoDisabled)
end)

addEvent("onArmyDodoEnter", true)
addEventHandler("onArmyDodoEnter", getRootElement(), function()
	bindKey("num_add", "down", setDodoEnabled)
	bindKey("num_add", "up", setDodoDisabled)
end)

function renderHud()

	local sx, sy
	sx, sy = guiGetScreenSize()
	sx = sx/2
	sy = sy/2
	if not(sx) or not(sy) then return end	
	dxDrawLine(sx, sy-12.9, sx, sy+12.9, tocolor(0, 0, 255), 2)
	dxDrawLine(sx-12.9, sy, sx+12.9, sy, tocolor(0, 0, 255), 2)
	-- Camera --
	local x,y,z = getElementPosition(getPedOccupiedVehicle(gMe))
		
	local rx, ry, rz = getElementRotation(getPedOccupiedVehicle(gMe))
	
	rz = rz +180
	
	local cx = x + math.cos(math.rad(rz))
	local cy = y + math.sin(math.rad(rz)) 
	
	setCameraMatrix ( cx, cy, z-2, vx,vy,vz)
	
	
end
--  ATM --

local Guivar = 0

function createArmyATMGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	local Knopf = {}
	local X, Y, Width, Height = getMiddleGuiPosition(243,145)
	local Fenster = guiCreateWindow(X, Y, Width, Height, "Army Ausruestung",false)
	Knopf[1] = guiCreateButton(61,100,120,32,"Schliessen",false,Fenster)
	Knopf[2] = guiCreateButton(9,26,110,33,"Army-Klasse ausruesten",false,Fenster)
	Knopf[3] = guiCreateButton(122,26,110,33,"Skin wechseln",false,Fenster)
	Knopf[4] = guiCreateButton(9,62,110,33,"Klasse verlassen",false,Fenster)
	Knopf[5] = guiCreateButton(122,62,110,33,"Autos Respawnen",false,Fenster)
		
	addEventHandler("onClientGUIClick", Knopf[5], function() -- Respawnen
		triggerServerEvent("onArmyCarRespawn", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[4], function() -- Verlassen
		triggerServerEvent("onArmyClassLeave", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[3], function() -- Skin
		triggerServerEvent("onArmySkinChange", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[2], function() -- Klasse
		triggerServerEvent("onArmyClassAusrueste", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster)
		Guivar = 0
		showCursor(false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end, false)
end

addEvent("onArmyATMStart", true)
addEventHandler("onArmyATMStart", getRootElement(), createArmyATMGui)