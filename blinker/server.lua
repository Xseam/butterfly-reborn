local Blink = {}



addEventHandler("onPlayerVehicleEnter",getRootElement(),
function (veh)
	if(getElementType(source) ~= "player") then return end
bindKey(source,".","down",blinkerrechts)
bindKey(source,",","down",blinkerlinks)
bindKey(source,"-","down",warnblink)
setElementData(veh,"br",0)
setElementData(veh,"br1",1)
setElementData(veh,"bl",0)
setElementData(veh,"bl1",1)
setElementData(veh,"wb",0)
setElementData(veh,"wb1",1)

end)

addEventHandler("onPlayerVehicleExit",getRootElement(),
function (veh)

unbindKey(source,".","down",blinkerrechts)
unbindKey(source,",","down",blinkerlinks)
unbindKey(source,"-","down",warnblink)

end)

function blinkerrechts (source)

	local vehicle = getPedOccupiedVehicle(source)
	
	if vehicle then
	
	if getVehicleController ( vehicle ) ~= source then return end
	
	if getElementData(vehicle,"bl1") == 0 or getElementData(vehicle,"wb1") == 0 then return end
	
		if getElementData(vehicle,"br1") == 1 then
	
		setElementData(vehicle,"br1",0)
		
			Blink[vehicle] = setTimer(function (vehicle)
			
				if getElementData(vehicle,"br") == 0 then
			
					setElementData(vehicle,"br",1)
					
					setVehicleLightState ( vehicle, 2, 1 )
					setVehicleLightState ( vehicle, 1, 1 )
					setElementData(vehicle,"blink",1)
				
				elseif getElementData(vehicle,"br") == 1 then
				
					setElementData(vehicle,"br",0)
					setVehicleLightState ( vehicle, 2, 0 )
					setVehicleLightState ( vehicle, 1, 0 )
				
				end
				
			end
			
			,500,0,vehicle)
		
		elseif getElementData(vehicle,"br1") == 0 then
		
			killTimer(Blink[vehicle])
			setElementData(vehicle,"br1",1)
			setVehicleLightState ( vehicle, 2, 0 )
			setVehicleLightState ( vehicle, 1, 0 )
			setElementData(vehicle,"blink",0)
			

		
		end
	
	end

end

function blinkerlinks (source)

	local vehicle = getPedOccupiedVehicle(source)
	
	if vehicle then
	
	if getVehicleController ( vehicle ) ~= source then return end
	
	if getElementData(vehicle,"br1") == 0 or getElementData(vehicle,"wb1") == 0 then return end
	
		if getElementData(vehicle,"bl1") == 1 then
	
		setElementData(vehicle,"bl1",0)
	
			Blink[vehicle] = setTimer(function (vehicle)
			
				if getElementData(vehicle,"bl") == 0 then
			
					setElementData(vehicle,"bl",1)
					
					setVehicleLightState ( vehicle, 3, 1 )
					setVehicleLightState ( vehicle, 0, 1 )
					setElementData(vehicle,"blink",1)
				
				elseif getElementData(vehicle,"bl") == 1 then
				
					setElementData(vehicle,"bl",0)
					setVehicleLightState ( vehicle, 0, 0 )
					setVehicleLightState ( vehicle, 3, 0 )
				
				end
				
			end
			
			,501,0,vehicle)
		
		elseif getElementData(vehicle,"bl1") == 0 then

			killTimer(Blink[vehicle])
			setElementData(vehicle,"bl1",1)
			setVehicleLightState ( vehicle, 0, 0 )
			setVehicleLightState ( vehicle, 3, 0 )
			setElementData(vehicle,"blink",0)
			

		
		end
	
	end

end

function warnblink (source)

	local vehicle = getPedOccupiedVehicle(source)
	
	if vehicle then
	
	if getVehicleController ( vehicle ) ~= source then return end
	
	if getElementData(vehicle,"br1") == 0 or getElementData(vehicle,"bl1") == 0 then return end
	
		if getElementData(vehicle,"wb1") == 1 then
	
		setElementData(vehicle,"wb1",0)
	
			Blink[vehicle] = setTimer(function (vehicle)
			
				if getElementData(vehicle,"wb") == 0 then
			
					setElementData(vehicle,"wb",1)
					
					setVehicleLightState ( vehicle, 3, 1 )
					setVehicleLightState ( vehicle, 0, 1 )
					setVehicleLightState ( vehicle, 1, 1 )
					setVehicleLightState ( vehicle, 2, 1 )
					setElementData(vehicle,"blink",1)
				
				elseif getElementData(vehicle,"wb") == 1 then
				
					setElementData(vehicle,"wb",0)
					setVehicleLightState ( vehicle, 0, 0 )
					setVehicleLightState ( vehicle, 3, 0 )
					setVehicleLightState ( vehicle, 1, 0 )
					setVehicleLightState ( vehicle, 2, 0 )
				
				end
				
			end
			
			,499,0,vehicle)
		
		elseif getElementData(vehicle,"wb1") == 0 then
		
			killTimer(Blink[vehicle])
			setElementData(vehicle,"wb1",1)
			setVehicleLightState ( vehicle, 0, 0 )
			setVehicleLightState ( vehicle, 3, 0 )
			setVehicleLightState ( vehicle, 1, 0 )
			setVehicleLightState ( vehicle, 2, 0 )
			setElementData(vehicle,"blink",0)

		
		end
	
	end

end
addEventHandler("onVehicleExplode", getRootElement(),
function()
	if(getElementData(source, "blink") == 1) then
		killTimer(Blink[source])
	end
end)

addEventHandler("onElementDestroy", getRootElement(),
function()
	if(getElementData(source, "blink") == 1) then
		killTimer(Blink[source])
	end
end)