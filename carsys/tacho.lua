local tFont1 = guiCreateFont("data/tachoFont.ttf", 15)
local tFont2 = guiCreateFont("data/tachoFont.ttf", 11)



addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	KMHLabel = guiCreateLabel(0.3333,0.9417,0.1786,0.0583,"0 km/h",true)
	guiLabelSetHorizontalAlign(KMHLabel,"center",false)
	guiSetFont(KMHLabel, tFont1)
	NAMELabel = guiCreateLabel(0.5224,0.9259,0.088,0.0269,"N/A",true)
	guiSetFont(NAMELabel, tFont2)
	BILD1 = guiCreateStaticImage(0.3604,0.9185,0.2547,0.0815,"data/images/carsys/steifen.png",true)
	guiSetAlpha(BILD1, 0.9)

	BILD2 = guiCreateStaticImage(0.5146,0.9556,0.0359,0.0407,"data/images/carsys/engine.png",true)

	BILD3 = guiCreateStaticImage(0.4792,0.9648,0.0313,0.0324,"data/images/carsys/light.png",true)

	BILD4 = guiCreateStaticImage(0.562,0.9602,0.0255,0.0343,"data/images/carsys/lock.png",true)
	
	BENZINLABEL = guiCreateLabel(0.3698,0.9704,0.1802,0.0176,"Benzin: 0%",true)
	guiSetFont(BENZINLABEL,"default-bold-small")
	hideTacho()
end)

function hideTacho()
	guiSetVisible(KMHLabel, false)
	guiSetVisible(NAMELabel, false)
	guiSetVisible(BENZINLABEL, false)
	guiSetVisible(BILD1, false)
	guiSetVisible(BILD2, false)
	guiSetVisible(BILD3, false)
	guiSetVisible(BILD4, false)
end
function showTacho()
	guiSetVisible(KMHLabel, true)
	guiSetVisible(NAMELabel, true)
	guiSetVisible(BENZINLABEL, true)
	guiSetVisible(BILD1, true)
	guiSetVisible(BILD2, true)
	guiSetVisible(BILD3, true)
	guiSetVisible(BILD4, true)
	guiMoveToBack(BILD1)
end

TachoVar = 0

function renderTacho_func()
	--if(TachoVar == 0) then return end
	
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then return end
	local speed = getVehicleSpeed()
	guiSetText(NAMELabel, getVehicleName(veh))
	guiSetText(KMHLabel, round(math.ceil(speed)/2).." km/h")
	if(getElementData(veh, "fuel")) then
		guiSetText(BENZINLABEL, "Kraftstoff: "..getElementData(veh, "fuel").."%")
	else
		guiSetText(BENZINLABEL, "Kraftstoff: 100%")
	end	
	local engine = getVehicleEngineState(veh)
	local lights = getVehicleOverrideLights(veh)
	local lock = isVehicleLocked(veh)
	if(engine == true) then
		guiSetAlpha(BILD2, 1)
	else
	guiSetAlpha(BILD2, 0.2)	
		end
	if(lights == 1) or(lights == 0) then
		guiSetAlpha(BILD3, 0.2)
	else
		guiSetAlpha(BILD3, 1)	
	end
	if(lock == true) then
		guiSetAlpha(BILD4, 1)
	else	
		guiSetAlpha(BILD4, 0.2)
	end
end

function startTacho_func(thePlayer, seat)
	if not(thePlayer == gMe) then return end
	if not(seat == 0) then return end
	if(TachoVar == 1) then return end
	TachoVar = 1
	local veh = getPedOccupiedVehicle(gMe)
	addEventHandler("onClientRender", getRootElement(), renderTacho_func)
	showTacho()
end
addEventHandler("onClientVehicleEnter",getRootElement(), startTacho_func)


function exitTacho_func(thePlayer)
	if not(thePlayer == gMe) then return end
	if(TachoVar == 0) then return end
	TachoVar = 0
	removeEventHandler("onClientRender", getRootElement(), renderTacho_func)
	hideTacho()
end
addEventHandler("onClientVehicleStartExit",getRootElement(), exitTacho_func)
addEventHandler("onClientVehicleExit",getRootElement(), exitTacho_func)
addEventHandler("onClientElementDestroy", getRootElement(), 
function()
	if(getElementType(source) == "vehicle") and (getVehicleOccupant(source) == gMe) then
		if(TachoVar == 0) then return end
		TachoVar = 0
		removeEventHandler("onClientRender", getRootElement(), renderTacho_func)
		hideTacho()
	end
end)
addEventHandler("onClientPlayerWasted", gMe, 
function()
	if not(source == gMe) then return end
	if(TachoVar == 0) then return end
	TachoVar = 0
	removeEventHandler("onClientRender", getRootElement(), renderTacho_func)
	hideTacho()
end)

local multiply = 1.35

function getVehicleSpeed()
    if isPedInVehicle(gMe) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(gMe))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161 * multiply
    end
    return 0
end

function round(num)
    return math.floor(num + 0.5)
end

