local CanTriggerAgain = 0
local CanTriggerAgain2 = 0
local CanTriggerAgain3 = 0
function startVehicleLight()
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then return end
	if not(getVehicleOccupant (veh, 0 ) == gMe) then return end
	if (CanTriggerAgain == 1) then return end
	triggerServerEvent("onVehActionTrigger", gMe, veh, 1)
	CanTriggerAgain = 1
	setTimer(function() CanTriggerAgain = 0 end, 500, 1)
end

function startVehicleMotor()
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then return end
	if not(getVehicleOccupant (veh, 0 ) == gMe) then return end
	if (canTriggerThis(veh) == false) then return end
	if (CanTriggerAgain2 == 1) then return end
	local benzin = tonumber(getElementData(veh, "fuel"))
	if(benzin) then
		if(benzin < 1) then outputChatBox("Dieses Fahrzeug hat kein Treibstoff mehr!", 200, 0, 0, false) return end
	end
	local schrott = tonumber(getElementData(veh, "Schrott"))
	if(schrott) then
		if(schrott == 1) then outputChatBox("Dieses Fahrzeug hat einen Totalschaden!", 200, 0, 0, false) return end
	end
	triggerServerEvent("onVehActionTrigger", gMe, veh, 2)
	CanTriggerAgain2 = 1
	setTimer(function() CanTriggerAgain2 = 0 end, 500, 1)
	if(getElementData(gMe, "usingspeedo") == true) then disableSpeedomat() end
end

function startVehicleLock()
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then return end
	if not(getVehicleOccupant (veh, 0 ) == gMe) then return end
	if (canTriggerThis(veh) == false) then return end
	if (CanTriggerAgain3 == 1) then return end
	triggerServerEvent("onVehActionTrigger", gMe, veh, 3)
	CanTriggerAgain3 = 1
	setTimer(function() CanTriggerAgain3 = 0 end, 500, 1)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	bindKey("l", "down", startVehicleLight)
	bindKey("m", "down", startVehicleMotor)
	bindKey("o", "down", startVehicleLock)
	bloodImage = guiCreateStaticImage(0.0005,0.0019,0.9911,0.9741,"data/images/blood.png",true)
	guiSetVisible(bloodImage, false)
	guiSetAlpha(bloodImage, 0.6)
end)

addCommandHandler("rebind",
function()
	bindKey("l", "down", startVehicleLight)
	bindKey("m", "down", startVehicleMotor)
	bindKey("o", "down", startVehicleLock)
end)

addEvent("onCarSoundStart", true)
addEventHandler("onCarSoundStart", getRootElement(),
function(veh, x, y, z, var)
if not(x) or not(y) or not(z) or not(var) then return end
if(var == 1) then
	local sound = playSound3D("sounds/switch.wav", x, y, z, false)
	attachElements(sound, veh)
elseif(var == 2) then
	local sound = playSound3D("sounds/EngineStart.mp3", x, y, z, false)
	setSoundVolume(sound, 0.2)
	attachElements(sound, veh)
elseif(var == 3) then
	local sound = playSound3D("sounds/EngineStop.mp3", x, y, z, false)
	setSoundVolume(sound, 0.4)
	attachElements(sound, veh)
elseif(var == 4) then
	local sound = playSound3D("sounds/carlock.mp3", x, y, z, false)
	attachElements(sound, veh)
end
end)

function canTriggerThis(veh)
	if(getElementData(veh, "Besitzer") == getPlayerName(gMe)) then return true; end
	if(getElementData(veh, "Besitzer") == fraktionNamen[tonumber(getElementData(gMe, "pFraktion"))]) then return true; end
	if(getElementData(veh, "Typ") == "Freecar") then return true; end
	if(getElementData(veh, "Besitzer") == "Fahrschule") and (tonumber(getElementData(gMe, "pFraktion")) == 3) then return true; end
	if(getElementData(veh, "Besitzer") == "Fahrschule") and (getElementData(gMe, "fahrstunde") == true) then return true; end
	if(getElementData(veh, "Besitzer") == "FBI/RCPD") and (getPlayerFraktion(gMe) == 4) or (getElementData(veh, "Besitzer") == "FBI/RCPD") and (getPlayerFraktion(gMe) == 7) then return true; end
	return false;
end

local roll = 0
local rollhoh = 0.5
local alpharender = 0.001
function renderUnfall()
	x, y, z, x2, y2, z2, roll, fov = getCameraMatrix()
	setCameraMatrix(x, y, z, x2, y2, z2, roll, 180)
	x, y, z, x2, y2, z2, roll, fov = getCameraMatrix()
	if(guiGetAlpha(bloodImage) > 0.03) then
		guiSetVisible(bloodImage, true)
		guiSetAlpha(bloodImage, guiGetAlpha(bloodImage)-alpharender)
	else
		guiSetVisible(bloodImage, false)
		guiSetAlpha(bloodImage, 0.6)
		removeEventHandler("onClientRender", getRootElement(), renderUnfall) 
		if (getElementData(gMe, "atTot") == false) then
		setCameraTarget(gMe, gMe)
		toggleAllControls(true)
		end
		setElementData(gMe, "inDamage", false)
	end
	
end

addEvent("onVehicleDamageScreen", true)
addEventHandler("onVehicleDamageScreen", getRootElement(),
function()
	if not(source == gMe) then return end
	addEventHandler("onClientRender", getRootElement(), renderUnfall)
	toggleAllControls(false)
	setElementData(gMe, "inDamage", true)
	local rand = math.random(0, 1)
	if(rand == 0) then return end
	setPedControlState(gMe, "horn", true)
	setTimer(setPedControlState, 100, 1, gMe, "horn", false)
	local x, y, z = getElementPosition(getPedOccupiedVehicle(gMe))
	triggerServerEvent("onVehicleDamageSound", gMe, x, y, z)
end)