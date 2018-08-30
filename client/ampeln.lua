local aus = false
local ausTimer

function setTrafficLightsAus()
    local lightsOff = getTrafficLightState() == 9
 
    if lightsOff then
        setTrafficLightState(6)
    else
        setTrafficLightState(9)
    end
end

function checkServerAmpeln()
	local hour, mins = getTime()
	local state = getTrafficLightState()
	if(hour > 22) or (hour < 6) then -- Nacht
		--outputConsole("Nacht")
		if(aus == false) then
			aus = true
			
			ausTimer = setTimer(setTrafficLightsAus, 500, 0)
		end
	else
		--outputConsole("Tag")
		if(aus == true) then
			killTimer(ausTimer)
			aus = false
			setTrafficLightState("auto")
		end
	end
	--outputConsole(tostring(aus))
end

setTimer(checkServerAmpeln, 60000, 0)
addCommandHandler("checkTrafficLights", checkServerAmpeln)