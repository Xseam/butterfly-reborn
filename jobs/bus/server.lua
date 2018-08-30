local haltestellen = {
	[1] = "235.07487487793, -6.8073167800903, 1.8378213644028", -- Blueberry
	[2] = "660.65374755859, -597.38366699219, 16.1875", -- Dillmore
	[3] = "1304.2142333984, -79.508018493652, 36.513053894043", -- Red Country
	[4] = "1338.0500488281, 307.22085571289, 19.41095161438", -- Montgomery
	[5] = "2291.6535644531, -63.300682067871, 26.3359375", --Palomino Creek
}

local pBlip = {}
local pMarker = {}
local pVeh = {}
local pCheck = {}

function setRightHaltestelle(thePlayer)
	if(getElementData(thePlayer, "inJob") == true) and (getElementData(thePlayer, "jobBusfahrer") == true) then
		local data = tonumber(getElementData(thePlayer, "busPoint"))
		if(data > 1) then
			destroyElement(pBlip[thePlayer])
			destroyElement(pMarker[thePlayer])
		end
		if(data == 1) then
			local x, y, z = gettok(haltestellen[data], 1, ","), gettok(haltestellen[data], 2, ","), gettok(haltestellen[data], 3, ",")
			pBlip[thePlayer] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.99, thePlayer)
			pMarker[thePlayer] = createMarker(x, y, z, "cylinder", 2.5, 0, 0, 255, 200, thePlayer)
			addEventHandler("onMarkerHit", pMarker[thePlayer],
			function(hitElement)
				if(hitElement ~= thePlayer) then return end
				if(pCheck[hitElement] ~= true) then
				pCheck[hitElement] = true
				setTimer(function() pCheck[hitElement] = false end, 6500, 1)
					setTimer( function()
						setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld") + getElementData(thePlayer, "RANDCASH"))
						setRightHaltestelle(thePlayer)
						
					end, 6500, 1)
					outputChatBox("Checkpoint erreicht! Bitte Warte hier einige Sekunden.", thePlayer, 0, 200, 0)
				end
			end)
		elseif(data == 2) then
			local x, y, z = gettok(haltestellen[data], 1, ","), gettok(haltestellen[data], 2, ","), gettok(haltestellen[data], 3, ",")
			pBlip[thePlayer] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.99, thePlayer)
			pMarker[thePlayer] = createMarker(x, y, z, "cylinder", 2.5, 0, 0, 255, 200, thePlayer)
			addEventHandler("onMarkerHit", pMarker[thePlayer],
			function(hitElement)
				if(hitElement ~= thePlayer) then return end
				if(pCheck[hitElement] ~= true) then
				pCheck[hitElement] = true
				setTimer(function() pCheck[hitElement] = false end, 6500, 1)
					setTimer( function()
						setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld") + getElementData(thePlayer, "RANDCASH"))
						setRightHaltestelle(thePlayer)
						
					end, 6500, 1)
					outputChatBox("Checkpoint erreicht! Bitte Warte hier einige Sekunden.", thePlayer, 0, 200, 0)
				end
			end)
		elseif(data == 3) then
			local x, y, z = gettok(haltestellen[data], 1, ","), gettok(haltestellen[data], 2, ","), gettok(haltestellen[data], 3, ",")
			pBlip[thePlayer] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.99, thePlayer)
			pMarker[thePlayer] = createMarker(x, y, z, "cylinder", 2.5, 0, 0, 255, 200, thePlayer)
			addEventHandler("onMarkerHit", pMarker[thePlayer],
			function(hitElement)
				if(hitElement ~= thePlayer) then return end
				if(pCheck[hitElement] ~= true) then
				pCheck[hitElement] = true
				setTimer(function() pCheck[hitElement] = false end, 6500, 1)
					setTimer( function()
						setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld") + getElementData(thePlayer, "RANDCASH"))
						setRightHaltestelle(thePlayer)
						
					end, 6500, 1)
					outputChatBox("Checkpoint erreicht! Bitte Warte hier einige Sekunden.", thePlayer, 0, 200, 0)
				end
			end)
		elseif(data == 4) then
			local x, y, z = gettok(haltestellen[data], 1, ","), gettok(haltestellen[data], 2, ","), gettok(haltestellen[data], 3, ",")
			pBlip[thePlayer] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.99, thePlayer)
			pMarker[thePlayer] = createMarker(x, y, z, "cylinder", 2.5, 0, 0, 255, 200, thePlayer)
			addEventHandler("onMarkerHit", pMarker[thePlayer],
			function(hitElement)
				if(hitElement ~= thePlayer) then return end
				if(pCheck[hitElement] ~= true) then
				pCheck[hitElement] = true
				setTimer(function() pCheck[hitElement] = false end, 6500, 1)
					setTimer( function()
						setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld") + getElementData(thePlayer, "RANDCASH"))
						setRightHaltestelle(thePlayer)
						
					end, 6500, 1)
					outputChatBox("Checkpoint erreicht! Bitte Warte hier einige Sekunden.", thePlayer, 0, 200, 0)
				end
			end)
		elseif(data == 5) then
			local x, y, z = gettok(haltestellen[data], 1, ","), gettok(haltestellen[data], 2, ","), gettok(haltestellen[data], 3, ",")
			pBlip[thePlayer] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.99, thePlayer)
			pMarker[thePlayer] = createMarker(x, y, z, "cylinder", 2.5, 0, 0, 255, 200, thePlayer)
			addEventHandler("onMarkerHit", pMarker[thePlayer],
			function(hitElement)
				if(hitElement ~= thePlayer) then return end
				if(pCheck[hitElement] ~= true) then
				pCheck[hitElement] = true
				setTimer(function() pCheck[hitElement] = false end, 6500, 1)
					setTimer( function()
						setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld") + getElementData(thePlayer, "RANDCASH"))
						setRightHaltestelle(thePlayer)
						
					end, 6500, 1)
					outputChatBox("Checkpoint erreicht! Bitte Warte hier einige Sekunden.", thePlayer, 0, 200, 0)
				end
			end)
		elseif(data == 6) then
			setElementData(thePlayer, "inJob", false)
			setElementData(thePlayer, "jobBusfahrer", false)
			outputChatBox("Info: Der Job wurde erledigt!", thePlayer, 255, 255, 0, false)
			destroyElement(pBlip[thePlayer])
			destroyElement(pMarker[thePlayer])
			destroyElement(pVeh[thePlayer])
			setTimer(fadeCamera, 2000, 1, thePlayer, false)
			setTimer( function()
				setElementPosition(thePlayer, 2253.3359375, -90.632194519043, 26.48437)
				fadeCamera(thePlayer, true)
			end, 3000, 1)
			
		end
		setElementData(thePlayer, "busPoint", data+1)
	end
end

addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobBusfahrer") == true) then
		destroyElement(pVeh[source])
		destroyElement(pBlip[source])
		destroyElement(pMarker[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobBusfahrer", false)
		outputChatBox("Job abgebrochen! Du bist gestorben.", source, 200, 0, 0)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobBusfahrer") == true) then
		destroyElement(pVeh[source])
		destroyElement(pBlip[source])
		destroyElement(pMarker[source])
	end
end)

addEvent("onJobBusfahrerStart", true)
addEventHandler("onJobBusfahrerStart", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) then outputChatBox("Du bist bereits in einem Job!", source, 200, 0, 0, false) return end
	setElementData(source, "inJob", true)
	setElementData(source, "jobBusfahrer", true)
	setElementData(source, "busPoint", 1)
	pVeh[source] = createVehicle(getVehicleModelFromName("Coach"), 224.90057373047, 11.3519115448, 3.7138969898224)
	setVehicleDamageProof(pVeh[source], true)
	setElementFrozen(pVeh[source], true)
	setElementRotation(pVeh[source], 0.001220703125, 359.99926757813, 179.07928466797)
	setElementFrozen(pVeh[source], false)
	setElementData(pVeh[source], "motor", true)
	setVehicleEngineState(pVeh[source], true)
	triggerClientEvent(getRootElement(), "onGhostmodeSet", source, pVeh[source])
	--warpPedIntoVehicle(source, pVeh[source])
	--227.07684326172, 13.21683883667, 2.578125
	local thePlayer = source
	fadeCamera(thePlayer, false)
			setTimer( function()
				setElementPosition(thePlayer, 227.07684326172, 13.21683883667, 2.578125)
				fadeCamera(thePlayer, true)	
				outputChatBox("Fahre nun die 5 Haltestellen ab! Fahre eine nach der Anderen ab.", thePlayer, 0, 200, 200)
				outputChatBox("Um den Job abzubrechen, benutze /quitjob.", thePlayer, 0, 200, 0)
				outputChatBox("Wenn du noch nicht im Bus drinne bist, steig ein!", thePlayer, 0, 200, 0)
				setRightHaltestelle(thePlayer)
			end, 1000, 1)

end)

addCommandHandler("quitjob",
function(thePlayer, cmd)
	if(getElementData(thePlayer, "inJob") == true) and (getElementData(thePlayer, "jobBusfahrer") == true) then
		destroyElement(pBlip[thePlayer])
		destroyElement(pMarker[thePlayer])
		destroyElement(pVeh[thePlayer])
		setElementData(thePlayer, "inJob", false)
		setElementData(thePlayer, "jobBusfahrer", false)
		
		outputChatBox("Info: Der Job wurde abgebrochen.", thePlayer, 255, 255, 0, false)
		setElementPosition(thePlayer, 2253.3359375, -90.632194519043, 26.48437)
	end
end)