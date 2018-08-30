local pVeh = {}
local pTrailer = {}
local pBlip = {}
local pMarker = {}

local markerPos = {
	[1] = "-1031.1423339844, -625.59826660156, 32.0078125",
	[2] = "1293.7032470703, 265.49249267578, 19.410140991211",
	[3] = "2296.1760253906, -2.2354876995087, 26.3359375",
	[4] = "-543.52166748047, -488.21298217773, 25.5234375"
}
local trailerPosx, trailerPosy, trailerPosz = -106.11209869385, -1112.8045654297, 2.0027666091919

function check_job_trailer_attach(truck)
	local playa = getVehicleOccupant(truck)
	if(getElementData(source, "Besitzer") ~= getElementData(truck, "Besitzer")) then cancelEvent() return end
	if(getElementData(playa, "inJob") == true) and (getElementData(playa, "jobTrucker") == true) then
		destroyElement(pBlip[playa])
			local lol = math.random(1, #markerPos)
			local x, y, z = gettok(markerPos[lol], 1, ","), gettok(markerPos[lol], 2, ","), gettok(markerPos[lol], 3, ",")
			pBlip[playa] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 999999.9, playa)
			pMarker[playa] = createMarker(x, y, z, "cylinder", 2.0, 0, 0, 255, 200, playa)
			outputChatBox("Fahre nun zu der auf deiner Karte angegebenen Markierung!", playa, 0, 200, 200)
			addEventHandler("onTrailerDetach", pTrailer[playa], 
			function(truck)
				if(getElementData(truck, "Besitzer") ~= getElementData(source, "Besitzer")) then return end
				local playa2 = getVehicleOccupant(truck)
				outputChatBox("Job abgebrochen! Die Ware wurde beschaedigt.", playa2, 200, 0, 0)
				destroyElement(pVeh[playa2])
				destroyElement(pTrailer[playa2])
				destroyElement(pMarker[playa2])
				destroyElement(pBlip[playa2])
				setTimer(setElementPosition, 1000, 1, playa2, -106.11209869385, -1112.8045654297, 2.0027666091919)
				setElementData(playa2, "inJob", false)
				setElementData(playa2, "jobTrucker", false)
			end)
			addEventHandler("onMarkerHit", pMarker[playa],
			function(hitElement)
				if(getElementType(hitElement) ~= "vehicle") then return end
				local player = getVehicleOccupant(hitElement)
				if not(player) then return end
				if(getElementData(player, "inJob") == true) and (getElementData(player, "jobTrucker") == true) then
					destroyElement(pVeh[player])
					destroyElement(pTrailer[player])
					destroyElement(pMarker[player])
					destroyElement(pBlip[player])
					setElementData(player, "pHGeld", tonumber(getElementData(player, "pHGeld"))+getElementData(player, "JOBCASH"))
					setElementData(player, "JOBCASH", 0)
					outputChatBox("Du hast den Auftrag erfolgreich erfuellt! Das Geld wurde dir auf die Hand ueberwiesen.", player, 0, 200, 0)
					setTimer(setElementPosition, 1000, 1, player, -106.11209869385, -1112.8045654297, 2.0027666091919)
					setElementData(player, "inJob", false)
					setElementData(player, "jobTrucker", false)
					triggerClientEvent(player, "respawnPlayerJobTrucker", player) 
				end
			end)
	end
end
addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobTrucker") == true) then
		destroyElement(pVeh[source])
		destroyElement(pTrailer[source])
		destroyElement(pBlip[source])
		destroyElement(pMarker[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobTrucker", false)
		triggerClientEvent(source, "respawnPlayerJobTrucker", source) 
		outputChatBox("Job abgebrochen! Du bist gestorben.", source, 200, 0, 0)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobTrucker") == true) then
		destroyElement(pVeh[source])
		destroyElement(pTrailer[source])
		destroyElement(pBlip[source])
		destroyElement(pMarker[source])
	end
end)

addEvent("onTruckJobAnnehm", true)
addEventHandler("onTruckJobAnnehm", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) then outputChatBox("Du bist bereits in einem Job!", source, 200, 0, 0, false) return end
	setElementData(source, "inJob", true)
	setElementData(source, "jobTrucker", true)
	pTrailer[source] = createVehicle(591, trailerPosx, trailerPosy, trailerPosz)
	pVeh[source] = createVehicle(getVehicleModelFromName(getElementData(source, "JOBTRUCKVEH")), -62.514610290527, -1135.6793212891, 1.6841479539871)
	triggerClientEvent(getRootElement(), "onGhostmodeSet", source, pTrailer[source])
	triggerClientEvent(getRootElement(), "onGhostmodeSet", source, pVeh[source])
	setElementRotation(pVeh[source], 0.02630615234375, 0.0006103515625, 18.5224609375)
	setElementData(pVeh[source], "Besitzer", getPlayerName(source))
	setElementData(pTrailer[source], "Besitzer", getPlayerName(source))
	outputChatBox("Steig in den Truck ein, und koppel den Anhaenger drann!", source, 0, 200, 200, false)
	pBlip[source] = createBlipAttachedTo(pTrailer[source], 41, 2, 255, 0, 0, 255, 0, 999999.9, playa)
	addEventHandler("onTrailerAttach", pTrailer[source], check_job_trailer_attach)
	addEventHandler("onVehicleExplode", pVeh[source],
	function()
		local lolp = getElementData(source, "Besitzer")
		local playa = getPlayerFromName(lolp)
		if not(playa) then destroyElement(source) return end
		if(getElementData(playa, "inJob") == true) and (getElementData(playa, "jobTrucker") == true) then
			destroyElement(pVeh[playa])
			destroyElement(pTrailer[playa])
			destroyElement(pBlip[playa])
			destroyElement(pMarker[playa])
			setElementData(playa, "inJob", false)
			setElementData(playa, "jobTrucker", false)
			triggerClientEvent(playa, "respawnPlayerJobTrucker", playa) 
			outputChatBox("Job abgebrochen! Dein Fahrzeug ist Explodiert.", playa, 200, 0, 0)
		end
	end)

end)

addCommandHandler("quitjob",
function(thePlayer, cmd)
	if(getElementData(thePlayer, "inJob") == true) and (getElementData(thePlayer, "jobTrucker") == true) then
		destroyElement(pBlip[thePlayer])
		destroyElement(pMarker[thePlayer])
		destroyElement(pVeh[thePlayer])
		destroyElement(pTrailer[thePlayer])
		setElementData(thePlayer, "inJob", false)
		setElementData(thePlayer, "jobTrucker", false)
		
		outputChatBox("Info: Der Job wurde abgebrochen.", thePlayer, 255, 255, 0, false)
		setTimer(setElementPosition, 1000, 1, thePlayer, -62.514610290527, -1135.6793212891, 1.6841479539871)
		triggerClientEvent(playa, "respawnPlayerJobTrucker", playa) 
	end
end)