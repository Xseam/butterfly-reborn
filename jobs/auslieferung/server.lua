local lieferungKords = {
	[1] = "999.14190673828, -1136.6307373047, 23.649988174438",
	[2] = "1065.9711914063, -1317.3568115234, 13.3828125", 
	[3] = "1288.0336914063, 235.9513092041, 19.404237747192",
	[4] = "2271.6997070313, -25.16330909729, 26.3359375", 
	[5] = "672.6748046875, -482.04559326172, 16.189054489136"
}

local playerVeh = {}
local playerBlip = {}
local playerMarker = {}
addEvent("onAuslieferungsJobStart", true)
addEventHandler("onAuslieferungsJobStart", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) then outputChatBox("Du bist bereits in einem Job!", source, 200, 0, 0, false) return end
	setElementData(source, "inJob", true)
	setElementData(source, "jobAuslieferung", true)
	playerVeh[source] = createVehicle(getVehicleModelFromName("Faggio"), 249.07260131836, -67.504379272461, 1.0286103487015, 359.90612792969, 0.0001220703125, 90.407348632813)
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
		setElementData(hitElement, "jobAuslieferung", false)
		local geld = tonumber(getElementData(hitElement, "jobRandomCash"))
		outputChatBox("Info: Du hast fuer die Auslieferung "..geld.."$ bekommen.", hitElement, 255, 255, 0, false)
		setElementData(hitElement, "pHGeld", tonumber(getElementData(hitElement, "pHGeld"))+geld)
		setTimer(setElementPosition, 1000, 1, hitElement, 249.07260131836, -67.604379272461, 1.0286103487015)
	end)
end)
addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobAuslieferung") == true) then
		destroyElement(playerBlip[source])
		destroyElement(playerMarker[source])
		destroyElement(playerVeh[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", source, 255, 255, 0, false)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "inJob") == true) and (getElementData(source, "jobAuslieferung") == true) then
		destroyElement(playerBlip[source])
		destroyElement(playerMarker[source])
		destroyElement(playerVeh[source])
		setElementData(source, "inJob", false)
		setElementData(source, "jobAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", source, 255, 255, 0, false)
	end
end)

addCommandHandler("quitjob",
function(thePlayer, cmd)
	if(getElementData(thePlayer, "inJob") == true) and (getElementData(thePlayer, "jobAuslieferung") == true) then
		destroyElement(playerBlip[thePlayer])
		destroyElement(playerMarker[thePlayer])
		destroyElement(playerVeh[thePlayer])
		setElementData(thePlayer, "inJob", false)
		setElementData(thePlayer, "jobAuslieferung", false)
		outputChatBox("Info: Die Auslieferung wurde abgebrochen.", thePlayer, 255, 255, 0, false)
		setTimer(setElementPosition, 1000, 1, thePlayer, 249.07260131836, -67.604379272461, 1.0286103487015)
	end
end)