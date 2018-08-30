-- Speedomat bei MuLTi! --
-- setElementSpeed bei MTA Wiki, Usefull functions --


local gSpeedo = 0
local gSpeed = 50

function disableSpeedomat()
	if(gSpeedo == 1) then
		gSpeedo = 0
		gSpeed = 50
		removeEventHandler("onClientRender", getRootElement(), check_for_speed)
		unbindKey("brake_reverse", "down", disableSpeedomat)
		unbindKey("handbrake", "down", disableSpeedomat)
		unbindKey("accelerate", "down", disableSpeedomat)
		setElementData(gMe, "usingspeedo", false)
	end
end

function check_for_speed()
	if(gSpeedo == 0) then removeEventHandler("onClientRender", getRootElement(), check_for_speed) return end
	if(isPedInVehicle(gMe) == false) or (isPlayerDead(gMe) == true) then removeEventHandler("onClientRender", getRootElement(), check_for_speed) return end
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then removeEventHandler("onClientRender", getRootElement(), check_for_speed) return end
	setElementSpeed(veh, "kmh", gSpeed)
end

function set_speedo_func(cmd)
	if(isPedInVehicle(gMe) == false) then return end
	if(getElementSpeed(getPedOccupiedVehicle(gMe), "kmh") < 25) then return end
	if(gSpeedo == 0) then
		local state = getVehicleEngineState ( getPedOccupiedVehicle(gMe) )
		if(state == false) then return end
		gSpeedo = 1
		gSpeed = getElementSpeed(getPedOccupiedVehicle(gMe), "kmh")
		addEventHandler("onClientRender", getRootElement(), check_for_speed)
		outputChatBox("Tempomat wurde auf "..math.ceil(gSpeed).." km/h Angeschaltet!", 0, 200, 200, false)
		bindKey("brake_reverse", "down", disableSpeedomat)
		bindKey("handbrake", "down", disableSpeedomat)
		bindKey("accelerate", "down", disableSpeedomat)
		setElementData(gMe, "usingspeedo", true)
	elseif(gSpeedo == 1) then
		gSpeedo = 0
		gSpeed = 50
		removeEventHandler("onClientRender", getRootElement(), check_for_speed)
		outputChatBox("Tempomat wurde Ausgeschaltet.", 0, 200, 200, false)
		unbindKey("brake_reverse", "down", disableSpeedomat)
		unbindKey("handbrake", "down", disableSpeedomat)
		unbindKey("accelerate", "down", disableSpeedomat)
		setElementData(gMe, "usingspeedo", false)
	end
end

addCommandHandler("tempomat", set_speedo_func)
bindKey("u", "down", set_speedo_func)

addEventHandler("onClientPlayerWasted", gMe,
function()
	if(source ~= gMe) then return end
	if(gSpeedo == 1) then
		gSpeedo = 0
		gSpeed = 50
		removeEventHandler("onClientRender", getRootElement(), check_for_speed)
		unbindKey("brake_reverse", "down", disableSpeedomat)
		unbindKey("handbrake", "down", disableSpeedomat)
		unbindKey("accelerate", "down", disableSpeedomat)
		setElementData(gMe, "usingspeedo", false)
	end
end)

addEventHandler("onClientVehicleCollision", root,
    function(collider,force, bodyPart, x, y, z, vx, vy, vz)
         if ( source == getPedOccupiedVehicle(gMe) ) then
			if(gSpeedo == 1) then
			gSpeedo = 0
			gSpeed = 50
			removeEventHandler("onClientRender", getRootElement(), check_for_speed)
			unbindKey("brake_reverse", "down", disableSpeedomat)
			unbindKey("handbrake", "down", disableSpeedomat)
			unbindKey("accelerate", "down", disableSpeedomat)
			setElementData(gMe, "usingspeedo", false)
			end
         end
    end
)



local s_maxSpeed = false

function tempo_func ( cmd, amount )
	if(amount) then
			local amount = tonumber ( amount )
			s_maxSpeed = amount
			if not isTimer ( s_maxSpeedTimer ) then
				s_maxSpeedTimer = setTimer ( fix_limit, 50, -1 )
			end
			outputChatBox ( "Du hast deine Maximale geschwindigkeit auf "..amount.." gesetzt. Benutze den Command noch einmal, um dieses Limit zu entfernen.", 0, 200, 0 )
	else
		if not s_maxSpeed then outputChatBox("Du musst eine Gueltige KM Anzahl eingeben!", 200, 0, 0, false) return end
		s_maxSpeed = false
		killTimer ( s_maxSpeedTimer )
		outputChatBox ( "Tempolimit wurde entfernt.", 0, 200, 0 )
	end
end
addCommandHandler ( "tempo", tempo_func )


function fix_limit ()

	local veh = getPedOccupiedVehicle(gMe)
	if veh then
		if isVehicleOnGround ( veh ) and getVehicleOccupant ( veh ) == gMe then
			local speed = getElementSpeed(veh, "kmh")
			if speed > s_maxSpeed then
				setElementSpeed(veh, "kmh", s_maxSpeed)
			end
		end
	end
end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (math.sqrt(x^2 + y^2 + z^2) * 161 * 1.35 / 2)
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then 
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
 
	return false
end