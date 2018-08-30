local p_lights = {}
local p_timer = {}
local p_lvar = {}
local p_pvar = {}
local p_lvar2 = {}
local p_lvar3 = {}
local p_lvar4 = {}

local Marker1 = createMarker(626.96453857422, -571.75164794922, 17.920680999756, "corona", 1.0, 255, 0, 0, 255)
-- draussen: 630.76220703125, -571.71221923828, 16.3359375
local Marker2 = createMarker(246.80708312988, 62.529781341553, 1003.640625, "corona", 1.0, 255, 0, 0, 255)
setElementInterior(Marker2, 6)
-- Drinnen: 246.26898193359, 64.02808380127, 1003.640625
local Marker3 = createMarker(227.90019226074, 81.674446105957, 1005.0390625, "corona", 1.0, 255, 255, 255, 255)
setElementInterior(Marker3, 6)
-- Drinnen: 228.09924316406, 79.510055541992, 1005.0390625
local Marker4 = createMarker(610.79455566406, -550.49987792969, 16.95845413208, "corona", 1.0, 255, 255, 255, 255)
-- Draussen: 608.17352294922, -550.24047851563, 16.742511749268
local Marker5 = createMarker(240.66529846191, 71.002647399902, 1004.1390625, "cylinder", 1.0, 255, 255, 0, 200) -- Zu Heli
setElementInterior(Marker5, 6) --- Oben: 621.12243652344, -570.53796386719, 26.143182754517
local Marker6 = createMarker(621.24969482422, -569.00042724609, 25.243182754517, "cylinder", 1.0, 255, 255, 0, 200) -- Nach innen zu Heli
-- Innen: 239.77188110352, 74.270416259766, 1005.0390625
-- HIFI -- 
local Hifi = createObject(2099, 214.5, 74, 1004, 0, 0, 150)
setElementInterior(Hifi, 6)
-- Tore --
local PD1VAR = 0
local PD2VAR = 0
local PD1TOR = createObject(2930, 250.5, 64.199996948242, 1005.200012207, 0, 0, 0) -- Auf: 250.69999694824, 62.400001525879, 1005.200012207
local PD1KEY1 = createObject(2886, 250.39999389648, 64.800003051758, 1004.200012207, 0, 0, 270)
local PD1KEY2 = createObject(2886, 250.89999389648, 64.800003051758, 1004.200012207, 0, 0, 90)

local PD2TOR = createObject(2930, 245.5, 72.599998474121, 1005.200012207, 0, 0, 90) -- Auf: 243.69999694824, 72.599998474121, 1005.200012207
local PD2KEY1 = createObject(2886, 245.10000610352, 72.300003051758, 1004.0999755859, 0, 0, 0)
local PD2KEY2 = createObject(2886, 245.19999694824, 72.800003051758, 1004.0999755859, 0, 0, 180)

local PD3TOR = createObject(2930, 248, 87.800003051758,1005.200012207, 0, 0, 0)

local Schrank = createObject(2199, 254.25, 62.400001525879, 1002.6400146484, 0, 0, 180)
setElementInterior(Schrank, 6)

setElementInterior(PD1TOR, 6)
setElementInterior(PD2TOR, 6)
setElementInterior(PD1KEY1, 6)
setElementInterior(PD1KEY2, 6)
setElementInterior(PD2KEY1, 6)
setElementInterior(PD2KEY2, 6)
setElementInterior(PD3TOR, 6)

local PC = createObject(2190, 255,69.400001525879, 1003.4000244141, 0, 0, 300)
setElementInterior(PC, 6)
local PCFBI = createObject(2190, 2526.3701171875, -1289.1500244141, 1048.0899658203, 0, 0, 230)
setElementInterior(PCFBI, 2) 

addEventHandler("onMarkerHit", Marker6,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 239.77188110352, 74.270416259766, 1005.0390625, 6)
end)

addEventHandler("onMarkerHit", Marker5,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 621.12243652344, -570.53796386719, 26.143182754517, 0)
end)

addEventHandler("onMarkerHit", Marker4,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 228.09924316406, 79.510055541992, 1005.0390625, 6)
end)

addEventHandler("onMarkerHit", Marker3,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement,608.17352294922, -550.24047851563, 16.742511749268, 0)
end)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 246.26898193359, 64.02808380127, 1003.640625, 6)
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 630.76220703125, -571.71221923828, 16.3359375, 0)
end)

addCommandHandler("cuff",
function(thePlayer, command, target)
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	if not(target) then return end
	local target = getPlayerFromName(target)
	if not (target) then outputChatBox("Ungueltiger Spieler!", thePlayer, 200, 0, 0, false)  return end
	local x, y, z = getElementPosition(target)
	local x1, y1, z1 = getElementPosition(thePlayer)
	if(target == thePlayer) then outputChatBox("Du kannst dich nicht fesseln/entfesseln!", thePlayer, 200, 0, 0, false) return end
	if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then outputChatBox("Du bist zu weit Weg!", thePlayer, 200, 0, 0, false) return end
	if(getElementData(target, "tied") == true) then
		toggleAllControls(target, true)
		setElementData(target, "tied", nil)
		setPlayerMuted(target, true)
		outputChatBox("Dir wurden die Handschellen abgelegt.", target, 0, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde entcufft.", thePlayer, 0, 200, 0, false)
	else
		toggleAllControls(target, false)
		setElementData(target, "tied", true)
		setPlayerMuted(target, false)
		outputChatBox("Dir wurden Handschellen von Polizist "..getPlayerName(thePlayer).." angelegt!", target, 255, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde gecufft!", thePlayer, 0, 200, 0, false)
	end
	
end
)


function lspd_click (theButton, theState, thePlayer )
    if (theState == "down") and (theButton == "left") then 
	if(getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
        if source == PD1KEY1 or source == PD1KEY2 then
			
			if(PD1VAR == 0) then
				moveObject(PD1TOR, 1000, 250.69999694824, 62.400001525879, 1005.200012207, 0, 0, 0, "InOutQuad")
				PD1VAR = 1
			else
				moveObject(PD1TOR, 1000, 250.5, 64.199996948242, 1005.200012207, 0, 0, 0, "InOutQuad")
				PD1VAR = 0
			end
		end
		if source == PD2KEY1 or source == PD2KEY2 then
				if(getPlayerFraktion(thePlayer) ~= 4) then return end
			if(PD2VAR == 0) then
				moveObject(PD2TOR, 1000, 243.69999694824, 72.599998474121, 1005.200012207, 0, 0, 0, "InOutQuad")
				PD2VAR = 1
			else
				moveObject(PD2TOR, 1000, 245.5, 72.599998474121, 1005.200012207, 0, 0, 0, "InOutQuad")
				PD2VAR = 0
			end
		end
		if source == PC or source == PCFBI then
			triggerClientEvent("onPCClickedRCPD", thePlayer)
		end
		if(getElementData(thePlayer, "Clicked") == 1) then return end
		if(getElementData(source, "PBAUMARKTOBJEKT") == true) and(getPlayerFraktion(thePlayer) == 4) then destroyElement(source) end end

end

addEventHandler("onElementClicked", getRootElement(), lspd_click)

addEvent("onRCPDDuty", true)
addEventHandler("onRCPDDuty", getRootElement(),
function(var)
	if(var == 1) then
		giveWeapon(source, 3, 1)
		giveWeapon(source, 23, 999999, true)
	elseif(var == 0) then

		setElementModel(source, tonumber(getElementData(source, "pSkin")))
	end
end)

addEvent("onSwatDuty", true)
addEventHandler("onSwatDuty", getRootElement(),
function(var)
	if(var == 1) then
		giveWeapon(source, 23, 500)
		giveWeapon(source, 25, 25)
		giveWeapon(source, 29, 500)
		giveWeapon(source, 31, 500)
		giveWeapon(source, 34, 5)
		giveWeapon(source, 17, 5)
		if(getPlayerFraktion(source) == 7) then
			setElementModel(source, 286)
		else
			setElementModel(source, 285)
		end
	elseif(var == 0) then
		takeWeapon(source, 23)
		takeWeapon(source, 25)
		takeWeapon(source, 29)
		takeWeapon(source, 31)
		takeWeapon(source, 34)
		takeWeapon(source, 17)
		setElementModel(source, tonumber(getElementData(source, "pSkin")))
	end
end)

-- Police Lights --




function toggleLights(thePlayer, cmd, level)	
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	local level = tonumber(level)
	if not(level) then outputChatBox("#FF0000 Nutze: /lights [1/2]", thePlayer, 255, 255, 255, true) return end
	if(level < 1) or (level > 2) then outputChatBox("#FF0000Bitte waehle ein Level zwischen 1 und 2!", thePlayer, 255, 255, 255, true) return end
	local veh = getPedOccupiedVehicle(thePlayer)
	if not(veh) then return end
	local id = getElementModel(veh)

	if (id == 598) or (id == 596) or (id == 597) or (id == 599) then
		if(level == 1) then
			if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
				p_pvar[veh] = 1
				p_lights[veh] = 1
				
				setVehicleOverrideLights ( veh, 2 )
				p_timer[veh] = setTimer(
				function()
					if(p_lvar[veh] == 0) or (p_lvar[veh] == nil) then
						p_lvar[veh] = 1
						setVehicleLightState ( veh, 1, 0)
						setVehicleLightState ( veh, 2, 0)
						setVehicleLightState ( veh, 0, 1)
						setVehicleLightState ( veh, 3, 1)
						setVehicleHeadLightColor(veh, 0, 0, 255)
					else
						setVehicleLightState ( veh, 3, 0)
						setVehicleLightState ( veh, 0, 0)
						setVehicleLightState ( veh, 1, 1)
						setVehicleLightState ( veh, 2, 1)	
						setVehicleHeadLightColor(veh, 255, 0, 0)
						p_lvar[veh] = 0
					end
				end, 500, 0)
				else
					p_lights[veh] = 0
					killTimer(p_timer[veh])
					setVehicleLightState ( veh, 0, 0)
					setVehicleLightState ( veh, 1, 0)
					setVehicleLightState ( veh, 2, 0)
					setVehicleLightState ( veh, 3, 0)	
					setVehicleHeadLightColor(veh, 255, 255, 255)
					setVehicleOverrideLights ( veh, 1 )
				end
			elseif(level == 2) then
				if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
				p_lights[veh] = 1
				setVehicleOverrideLights ( veh, 2 )
				p_timer[veh] = setTimer(
				function()
					if(p_lvar3[veh] == 4) then
						setTimer(function() p_lvar3[veh] = 0 end, 1000, 1)
						setTimer(
						function()
							if(p_lvar4[veh] == 1)then
								p_lvar4[veh] = 0
								-- 0 = vorne links 1 = vorne rechts 2 = hinten links 3 = hinten rechts
								setVehicleLightState ( veh, 1, 0)
								setVehicleLightState ( veh, 2, 0)
								setVehicleLightState ( veh, 0, 1)
								setVehicleLightState ( veh, 3, 1)
								setVehicleHeadLightColor(veh, 77, 77, 255)
							else
								setVehicleLightState ( veh, 3, 0)
								setVehicleLightState ( veh, 0, 0)
								setVehicleLightState ( veh, 1, 1)
								setVehicleLightState ( veh, 2, 1)	
								setVehicleHeadLightColor(veh, 255, 77, 77)
								p_lvar4[veh] = 1
							end
						end, 50, 5)
					return end
					if(p_lvar2[veh] == 0) or (p_lvar2[veh] == nil) then
						p_lvar2[veh] = 1
						-- 0 = vorne links 1 = vorne rechts 2 = hinten links 3 = hinten rechts
						setVehicleLightState ( veh, 1, 0)
						setVehicleLightState ( veh, 2, 0)
						setVehicleLightState ( veh, 0, 1)
						setVehicleLightState ( veh, 3, 1)
						setVehicleHeadLightColor(veh, 0, 0, 255)
					else
						setVehicleLightState ( veh, 3, 0)
						setVehicleLightState ( veh, 0, 0)
						setVehicleLightState ( veh, 1, 1)
						setVehicleLightState ( veh, 2, 1)	
						setVehicleHeadLightColor(veh, 255, 0, 0)
						p_lvar2[veh] = 0
					end
					if(p_lvar3[veh] == nil) then p_lvar3[veh] = 0  end
					p_lvar3[veh] = (p_lvar3[veh]+1)
				end, 500, 0)
				else
					p_lights[veh] = 0
					killTimer(p_timer[veh])
					setVehicleLightState ( veh, 0, 0)
					setVehicleLightState ( veh, 1, 0)
					setVehicleLightState ( veh, 2, 0)
					setVehicleLightState ( veh, 3, 0)	
					setVehicleHeadLightColor(veh, 255, 255, 255)
					setVehicleOverrideLights ( veh, 1 )
				end
				end
			end
end
addCommandHandler("lights", toggleLights)



addEventHandler ( "onVehicleExplode", getRootElement(), 
function()
	if(p_lights[source] == 1) then
		killTimer(p_timer[source])	
	end
end )

addEventHandler ( "onVehicleRespawn", getRootElement(), 
function()
	if(p_lights[source] == 1) then
		if not(isTimer(p_timer[source])) then return end
		killTimer(p_timer[source])	
	end
end )

addEventHandler("onElementDestroy", getRootElement(), 
function ()
	if getElementType(source) == "vehicle" then
		if(p_lights[source] == 1) then
			killTimer(p_timer[source])
		end
	end
end)

addCommandHandler("stel",
function(thePlayer)
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
		if(isElementAttached(thePlayer)) then setElementData(getElementAttachedTo(thePlayer), "STEL", "0") detachElements(thePlayer) takeWeapon(thePlayer, 31) local x, y, z = getElementPosition(thePlayer) setElementPosition(thePlayer, x, y+1, z) return end
		local posX, posY, posZ = getElementPosition( thePlayer )
		local chatSphere = createColSphere( posX, posY, posZ, 10 )
		local nearbyVehicle = getElementsWithinColShape( chatSphere, "vehicle" )
		destroyElement( chatSphere )
		if(getElementData(nearbyVehicle[1], "STEL") ~= "0") then outputChatBox("Es befindet sich zurzeit jemand auf dem Dach!", thePlayer, 200, 0, 0, false) return end
		if(getElementModel(nearbyVehicle[1]) ~= 528) then return end
		if(isPedInVehicle(thePlayer)) then return end
		attachElements(thePlayer, nearbyVehicle[1], 0, -1, 1.1)
		giveWeapon(thePlayer, 31, 99999, true)
		setElementData(nearbyVehicle[1], "STEL", "LOL")
end
)

addEventHandler ( "onVehicleExplode", getRootElement(), 
function()
	if(isElementAttached(source) == 1) then
		deatachElements(source)
	end
	if(getElementModel(source) == 528) then
		setElementData(source, "STEL", "0")
	end
end )

addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(isElementAttached(source) == 1) then
		setElementData(getElementAttachedTo(source), "STEL", "0")
	end
end)
addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(isElementAttached(source) == 1) then
		setElementData(getElementAttachedTo(source), "STEL", "0")
	end
end)

function check_for_tazer( attacker, weapon, bodypart, loss )
	if not(attacker) then return end
	if(getPlayerFraktion(attacker) == 4) and (weapon == 23) or (getPlayerFraktion(attacker) == 7) and(weapon == 23) then
	if(getElementData(source, "tazered") == true) then return end
		setElementHealth(source, getElementHealth(source)+loss)
		setElementData(source, "tazered", true)
		setPedAnimation(source, "crack", "crckdeth2",-1,true,true,true)
		toggleAllControls(source, false)
		local x, y, z = getElementPosition(source)
		triggerClientEvent("play_tazer_sound", getRootElement(), x, y, z)
		local playa = source
		setTimer(
			function(playa)
				toggleAllControls(playa, true)
				setElementData(playa, "tazered", false)
				bindKey ( playa, "space", "down", function() setPedAnimation(playa) unbindKey ( playa, "space", "down", function() setPedAnimation(playa) end) end)
			end, math.random(25000, 30000), 1,playa,true)
	
	end
end
addEventHandler ( "onPlayerDamage", getRootElement (), check_for_tazer )

addEvent("onStrassensperreObjectFinished", true)
addEventHandler("onStrassensperreObjectFinished", getRootElement(),
function(modell, x, y, z, x1, y1, z1, int, dim)
	local object = createObject(modell, x, y, z)
	setElementRotation(object, x1, y1, z1)
	setElementInterior(object, int)
	setElementDimension(object, dim)
	setElementData(object, "PSTRASSENSPERRE", true)
	setElementCollisionsEnabled(object, true)
	
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)
		if(mouse == "left") and (button == "down") then
			if(modell == 2773) then
				if(getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 5) then 
					destroyElement(source)
				end
			else
				if(getPlayerFraktion(thePlayer) == 4) then 
					destroyElement(source)
				end
			end
		end
	end)
	
	if(modell == 2899) then -- Sperre
		local sphere = createColSphere(x, y, z, 3)
		setElementData(sphere, "PSTRASSENSPERRE", true)
		attachElements(sphere, object)
		addEventHandler("onColShapeHit", sphere,
		function(hitElement)
		if(getElementType(hitElement) == "player") then return end
			if(getElementType(hitElement) == "vehicle") then
				if(getElementData(hitElement, "Besitzer") == "RCPD") then else setVehicleWheelStates ( hitElement, 1, 1, 1, 1) end
			end
		end)
	end
end)

addCommandHandler("removenails", 
function(thePlayer)
	if(getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else outputChatBox("Du hast keine Berechtigung, diesen Befehl zu benutzen!", thePlayer, 230, 0, 0, false) return end
	for index, col in pairs(getElementsByType("colshape")) do
		if(isElementWithinColShape(thePlayer, col) == true) then
			if(getElementData(col, "PSTRASSENSPERRE") == true) then
				destroyElement(getElementAttachedTo(col))
				destroyElement(col)
				outputChatBox("Nagelbaender Erfolgreich entfernt!", thePlayer, 200, 0, 0, false)
			end
		end
	end
end)

addCommandHandler("m", 
function(thePlayer, cmd, ...)
	if not(...) then return end
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	if(isPedInVehicle(thePlayer) == false) then return end
	local veh = getPedOccupiedVehicle(thePlayer)
	if (getElementData(veh, "Besitzer") == "RCPD") or (getElementData(veh, "Besitzer") == "FBI") or (getElementData(veh, "Besitzer") == "FBI/RCPD") or (getElementData(veh, "Besitzer") == "RCPD/FBI") then else return end
	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
		local posX, posY, posZ = getElementPosition( thePlayer )
		local chatSphere = createColSphere( posX, posY, posZ, 35 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		local title = "N/A"
		if(getPlayerFraktion(thePlayer) == 4) then title = "Officer" end
		if(getPlayerFraktion(thePlayer) == 7) then title = "FBI Agent" end
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( thePlayer )
			outputChatBox ( "[RCPD](( Officer "..title..": "..text.." ))[RCPD]", nearbyPlayer, 255, 255, 0 )
		end
	
end)

addEvent("onPoliceComputerCam", true)
addEventHandler("onPoliceComputerCam", getRootElement(),
function(var)
	setElementFrozen(source, true)
	toggleAllControls(source, false)
	setElementInterior(source, 0)
	if(var == 1) then
		setCameraMatrix(source, 628.39337158203, -583.57122802734, 23.793170928955, 714.64996337891, -630.36114501953, 4.5445518493652)
	elseif(var == 2) then
		setCameraMatrix(source, 629.755859375, -561.30212402344, 24.597482681274, 719.63012695313, -518.98712158203, 13.105930328369)
	elseif(var == 3) then
		setCameraMatrix(source, 618.20837402344, -593.03344726563, 21.123563766479, 716.55242919922, -579.94055175781, 8.5926036834717)
	elseif(var == 4) then
		setElementInterior(source, 6)
		setElementFrozen(source, false)
		toggleAllControls(source, true)
		setCameraTarget(source, source)
		local x, y, z = getElementPosition(source)
		setElementPosition(source, x, y, z+1)
	end
end)

addCommandHandler("checkblitzer", function(thePlayer)
	if(isACop(thePlayer) == false) then outputChatBox("Du hast keine Berechtigung!", thePlayer, 200, 0, 0) return end
	if(isPedInVehicle(thePlayer) == false) then outputChatBox("Du musst in einem Auto sitzen!", thePlayer, 200, 0, 0) return end
	if(getElementData(getPedOccupiedVehicle(thePlayer), "Besitzer") == "RCPD") or (getElementData(getPedOccupiedVehicle(thePlayer), "Besitzer") == "FBI") then else outputChatBox("Du musst in einem Staatsfraktionsauto sitzen!", thePlayer, 200, 0, 0) return end
	if(getElementData(thePlayer, "blitzercheck") ~= true) then
		setElementData(thePlayer, "blitzercheck", true)
		outputChatBox("Du hast den Blitzermodus aktiviert. Dir wird nun die Geschwindigkeit jedes Fahrzeug im Stand angezeigt!", thePlayer, 0, 200, 0)
	else
		outputChatBox("Du hast den Blitzermodus deaktiviert.", thePlayer, 0, 200, 0)
		setElementData(thePlayer, "blitzercheck", false)
	end
end)