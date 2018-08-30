--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

gMe = getLocalPlayer()

function getFormatDate()
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		return day.."."..month.."."..year.." um "..hour..":"..minute;
end
local sound

addEvent("onClientSoundPos", true)
addEventHandler("onClientSoundPos", getRootElement(),
function(x, y, z, path, dis)
	sound = playSound3D(path, x, y, z)
	if not(dis) then dis = 20 end
	setSoundMaxDistance(sound, dis)
end)

addEvent("setWaterLevel", true)
addEventHandler("setWaterLevel", getRootElement(),
function(level)
	setWaterLevel(level)
end)

function disableGhostMode(vehicle)
	local x, y, z = getElementPosition(vehicle)
	local col = createColSphere(x, y, z, 10)
		if(#getElementsWithinColShape(col, "vehicle") > 1) then setTimer(disableGhostMode, 1000, 1, vehicle) destroyElement(col) else
			destroyElement(col)
			setElementAlpha(vehicle, 255)
			for index, car in pairs(getElementsByType("vehicle")) do
				setElementCollidableWith ( vehicle, car, true )
			end
		end
end

local pGhostTimer = {}

function set_ghostmode(vehicle)
	if(isTimer(pGhostTimer[vehicle])) then killTimer(pGhostTimer[vehicle]) end
	setElementAlpha(vehicle, 150)
	for index, car in pairs(getElementsByType("vehicle")) do
		setElementCollidableWith ( vehicle, car, false )
	end
	local veh = vehicle
	pGhostTimer[vehicle] = setTimer(disableGhostMode, 7500, 1, veh)
end

addEvent("onGhostmodeSet", true)
addEventHandler("onGhostmodeSet", getRootElement(), set_ghostmode)
local object1, object2
function getMiddleGuiPosition(lol, lol2)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = lol, lol2
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	return X, Y, Width, Height
end
local moov = 0
function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	if(moov == 1) then outputChatBox("Error: Du hast zu wenig Frames.", 0, 200, 0, false) return end
	object1 = createObject ( 1337, x1, y1, z1 )
	object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( object1, 0 )
	setElementAlpha ( object2, 0 )
	moveObject ( object1, time, x2, y2, z2 )
	moveObject ( object2, time, x2t, y2t, z2t )
	
	addEventHandler ( "onClientRender", getRootElement(), camRender )
	moov = 1
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, object1 )
	setTimer ( destroyElement, time, 1, object2 )
end

function removeCamHandler ()
	moov = 0
	removeEventHandler ( "onClientRender", getRootElement(), camRender )
end

function camRender ()

	local x1, y1, z1 = getElementPosition ( object1 )
	local x2, y2, z2 = getElementPosition ( object2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )

end
