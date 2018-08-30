local lieferungKords = {
	[1] = "1294.1828613281, 218.49635314941, 19.5546875",
	[2] = "2317.1767578125, -23.949829101563, 26.335084915161", 
	[3] = "700.86975097656, -534.64221191406, 16.1875"
}

local playerVeh = {}
local playerBlip = {}
local playerMarker = {}
addEvent("onWaffenAuslieferungsJobStart", true)
addEventHandler("onWaffenAuslieferungsJobStart", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) then outputChatBox("Du bist bereits in einem Job!", source, 200, 0, 0, false) return end
	setElementData(source, "inJob", true)
	setElementData(source, "jobWaffenAuslieferung", true)
	playerVeh[source] = createVehicle(getVehicleModelFromName("Boxville"), 251.77734375, -158.0048828125, 1.6411669254303, 359.41223144531, 359.99450683594, 37.040405273438)
	setElementData(playerVeh[source], "motor", true)
	setVehicleEngineState(playerVeh[source], true)
	setVehicleDamageProof(playerVeh[source], true)
	warpPedIntoVehicle(source, playerVeh[source])
	outputChatBox("Fahre zu dem auf deiner Mini-Map angezeigten Punkt!(Wegpunkt)", source, 0, 200, 0, false)
	outputChatBox("Wenn du den Job abbrechen moechtest, benutze /quitjob.", source, 0, 200, 0, false)
	local randomv = math.random(1, #lieferungKords)
	local kord = lieferungKords[randomv]
	local x, y, z = gettok(kord, 1, ','), gettok(kord, 2, ','), gettok(kord, 3, ',')
	playerBlip[source] = createBlip(x, y, z, 41, 2, 255, 0, 0, 255, 0, 9999.9, source)
	playerMarker[source] = createMarker(x, y, z-0.5, "cylinder", 2.0, 0, 0, 255, 200, source)
	local playa = source
	addEventHandler("onMarkerHit", playerMarker[source],
	function(hitElement)
		if(hitElement ~= playa) then return end
		destroyElement(playerBlip[hitElement])
		destroyElement(playerMarker[hitElement])
		destroyElement(playerVeh[hitElement])
		setElementData(hitElement, "inJob", false)
		setElementData(hitElement, "jobWaffenAuslieferung", false)
		local geld = tonumber(getElementData(hitElement, "jobWaffenRandomCash"))
		outputChatBox("Info: Du hast fuer die Auslieferung "..geld.."$ bekommen.", hitElement, 255, 255, 0, false)
		givePlayerItem(hitElement, "pHGeld", geld)
		setTimer(setElementPosition, 1000, 1, hitElement, 239.65087890625, -152.72845458984, 1.578125)
	end)
end)
addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobWaffenAuslieferung") == true) then
		destroyElement(playerBlip[source])
		destroyElement(playerMarker[source])
		destroyElement(playerVeh[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobWaffenAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", source, 255, 255, 0, false)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobWaffenAuslieferung") == true) then
		destroyElement(playerBlip[source])
		destroyElement(playerMarker[source])
		destroyElement(playerVeh[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobWaffenAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", source, 255, 255, 0, false)
	end
end)

addCommandHandler("quitjob",
function(thePlayer, cmd)
	if(getElementData(thePlayer, "inJob") == true) and (getElementData(thePlayer, "jobWaffenAuslieferung") == true) then
		destroyElement(playerBlip[thePlayer])
		destroyElement(playerMarker[thePlayer])
		destroyElement(playerVeh[thePlayer])
		setElementData(thePlayer, "inJob", false)
		setElementData(thePlayer, "jobWaffenAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", thePlayer, 255, 255, 0, false)
		setTimer(setElementPosition, 1000, 1, thePlayer, 239.65087890625, -152.72845458984, 1.578125)
	end
end)