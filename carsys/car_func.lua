addEvent("onVehActionTrigger", true)
addEventHandler("onVehActionTrigger", getRootElement(),
function(veh, var)
	if not(veh) then return end
	if(var == 1) then
	local state = getVehicleOverrideLights ( veh )
	if (state == 1) or(state == 0) then
		setVehicleOverrideLights ( veh, 2 )
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 1)
	else
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 1)
		setVehicleOverrideLights ( veh, 1 ) 
	end
	elseif(var == 2) then
	local state = getVehicleEngineState ( veh )
	if(state == true) then
		setVehicleEngineState(veh, false)
		setElementData(veh, "motor", false)
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 3) -- aus
		--setElementData(source, "motor", 1)
	else
		setTimer(function () setVehicleEngineState(veh, true) end,1050,1,veh)
		setElementData(veh, "motor", true)
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 2) -- an
		--setElementData(source, "motor", nil)
	end
	elseif(var == 3) then
	local state = isVehicleLocked ( veh )
	if(state == true) then
		setVehicleLocked(veh, false)
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 1)
		local state = getVehicleOverrideLights ( veh )
		local lightsVar = 0
		if(state == 0) or (state == 1) then lightsVar = 0 else lightsVar = 1 end
		if(isTimer(Light_Timer)) then return end
		setVehicleOverrideLights (veh, 2 )
		--setVehicleLightState (veh, 0, 0 )
		--setVehicleLightState (veh, 1, 0 )
		--setVehicleLightState (veh, 2, 0 )
		--setVehicleLightState (veh, 3, 0 )
		Light_Timer = setTimer(
		function()
		setVehicleOverrideLights (veh, 1 )
		--setVehicleLightState (veh, 0, 1 )
		--setVehicleLightState (veh, 1, 1 )
		--setVehicleLightState (veh, 2, 1 )
		--setVehicleLightState (veh, 3, 1 )		
		if(lightsVar == 1) then
			setVehicleOverrideLights (veh, 2 )
			--setVehicleLightState (veh, 0, 0 )
			--setVehicleLightState (veh, 1, 0 )
			--setVehicleLightState (veh, 2, 0 )
			--setVehicleLightState (veh, 3, 0 )
		end
		end, 500, 1)
	else
		setVehicleLocked(veh, true)
		local x, y, z = getElementPosition(veh)
		triggerClientEvent("onCarSoundStart", getRootElement(), veh, x, y, z, 4)
		local state = getVehicleOverrideLights ( veh )
		local lightsVar = 0
		if(state == 0) or (state == 1) then lightsVar = 0 else lightsVar = 1 end
		if(isTimer(Light_Timer)) then return end
		if(isTimer(Light_Timer2)) then return end		
			setVehicleOverrideLights (veh, 2 )
			--setVehicleLightState (veh, 0, 0 )
			--setVehicleLightState (veh, 1, 0 )
			--setVehicleLightState (veh, 2, 0 )
			--setVehicleLightState (veh, 3, 0 )
			Light_Timer = setTimer(
			function()
				setVehicleOverrideLights (veh, 1 )
				--setVehicleLightState (veh, 0, 1 )
				--setVehicleLightState (veh, 1, 1 )
				--setVehicleLightState (veh, 2, 1 )
				--setVehicleLightState (veh, 3, 1 )
					setTimer(
					function()
					setVehicleOverrideLights (veh, 2 )
					--setVehicleLightState (veh, 0, 0 )
					--setVehicleLightState (veh, 1, 0 )
					--setVehicleLightState (veh, 2, 0 )
					--setVehicleLightState (veh, 3, 0 )			
						setTimer(
						function()
						setVehicleOverrideLights (veh, 1 )
						--setVehicleLightState (veh, 0, 1 )
						--setVehicleLightState (veh, 1, 1 )
						--setVehicleLightState (veh, 2, 1 )
						--setVehicleLightState (veh, 3, 1 )
						if(lightsVar == 1) then
						setVehicleOverrideLights (veh, 2 )
						--setVehicleLightState (veh, 0, 0 )
						--setVehicleLightState (veh, 1, 0 )
						--setVehicleLightState (veh, 2, 0 )
						--setVehicleLightState (veh, 3, 0 )
						end
				end, 250, 1)
			end, 250, 1)
		end, 350, 1)
		end
		elseif(var == 4) then

			executeCommandHandler("park", source)
		elseif(var == 5) then
			if(getElementData(source, "repair") == true) then return end
			setElementData(source, "repair", true)
			toggleAllControls(source, false)
			fadeCamera(source, false, 3.0, 255, 255, 255)
			local playa = source
			setTimer(
				function()
					local rand = math.random(0, 3)
					if(rand == 2) then
						setElementData(playa, "repair", false)
						fadeCamera(playa, true)
						toggleAllControls(playa, true)
						setElementData(veh, "Schrott", 0)
						setVehicleDamageProof(veh, false)
						setElementHealth(veh, 400)
						outputChatBox("Du hast es Gerade hinbekommen, dass dein Auto wieder startet.", playa, 0, 200, 200)
					else
						setElementData(playa, "repair", false)
						fadeCamera(playa, true)
						toggleAllControls(playa, true)
						outputChatBox("Der Versuch, dein Auto zu Reparieren, Schlug fehl!", playa, 200, 0, 0, false)
					end
				end, 4000, 1)
			
	end
end
)
--[[
function check_motor_func ( thePlayer ) 
	if(getVehicleEngineState(source) == true) then
	setVehicleEngineState(source, true)
	else
	setVehicleEngineState(source, false)	
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), check_motor_func ) 

function check_motor_func ( thePlayer ) 
	if(getVehicleEngineState(source) == true) then
	setVehicleEngineState(source, true)
	else
	setVehicleEngineState(source, false)
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), check_motor_func ) 
--]]


addEventHandler( "onVehicleEnter", getRootElement(),
function (player, seat, jacked, door)

local vehicle = getPedOccupiedVehicle(player)
if not(vehicle) then return end
local state = getElementData(vehicle, "motor")

	if(state == false) then
		setVehicleEngineState(vehicle, false)
	else
	local benzin = tonumber(getElementData(vehicle, "fuel"))
	if not(benzin) then
		setVehicleEngineState(vehicle, true)
	else
		if(benzin < 1) then
			setVehicleEngineState(vehicle, false)
			outputChatBox("Dieses Fahrzeug hat kein Treibstoff mehr.", player, 200, 0, 0,false)
			setElementData(vehicle, "motor", false)
		else
			setVehicleEngineState(vehicle, true)
		end
	end
	end
end)

outputDebugString("Bitte Warten, Fahrzeugmotoren werden Geladen...")
setTimer(
function()
	local vehs = 0
	for index, car in ipairs(getElementsByType("vehicle")) do
		vehs = vehs+1
		if (getElementData(car, "Typ") == "Anfaengerauto") then
			setElementData(car, "motor", true)
			setElementData(car, "fuelable", false)
			setElementData(car, "fuel", 100)
		else
			if(getElementData(car, "Typ") == "Freecar") or (getElementData(car, "Besitzer") == "Niemand") then
				if not(getElementData(car, "fuel")) then
					setElementData(car, "fuel", 100)
				end
			end
			setElementData(car, "motor", false)
			if not(getElementData(car, "fuelable")) then
				setElementData(car, "fuelable", true)
			end
			if(getElementData(car, "Typ") == "Fraktionsauto") then
				setElementData(car, "fuel", 100)
			end
		end
	end
	outputDebugString(vehs.." Fahrzeugmotore geladen.")
end, 2500, 1)

function damage_func(loss)
	if(loss < 90)  then return end
	if(getVehicleEngineState(source) == false) then setElementHealth(source, getElementHealth(source)+loss) end 
	local thePlayer = getVehicleOccupant(source)
	if not(thePlayer) then return end
	local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(thePlayer))
    local speed = math.sqrt(vx^2 + vy^2 + vz^2) * 161 * 1.25 
	if(speed < 10) then return end
	--outputChatBox(loss)
    if(thePlayer) then 
	if(getElementData(thePlayer, "inDamage") == true) then return end
        triggerClientEvent("onVehicleDamageScreen", thePlayer)
    end
end

addEventHandler("onVehicleDamage", getRootElement(), damage_func)

addEventHandler("onVehicleExplode", getRootElement(),
function()
	setVehicleEngineState(source, false)
	setElementData(source, "motor", false)
	setVehicleOverrideLights(source, 1)
end)

addEvent("onVehicleDamageSound", true)
addEventHandler("onVehicleDamageSound", getRootElement(), function(x, y, z)
	local ra = math.random(1, 7)
	triggerClientEvent(getRootElement(), "onClientSoundPos", source, x, y, z, "sounds/glas/glas"..ra..".mp3", 25)
end)