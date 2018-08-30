local respawnDelay = 10
local Junge
local Faggio
local Marker
local randomCash = 0
function createJobAuslieferungsGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local X, Y, Width, Height = getMiddleGuiPosition(357,148)
	
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Job",false)
	local Label = guiCreateLabel(7,29,335,71,"Hey du! Kannst du mir eventuell ein Gefallen tuen?\nIch habe ein wichtiges Paket auszuliefern. Wenn du es fuer\nmich auslieferst, bekommst du von mir "..randomCash.."$.\nMoechtest du dies tuen fuer mich?",false,Fenster)
	guiLabelSetHorizontalAlign(Label,"center",false)
	guiSetFont(Label,"default-bold-small")
	local Knopf1 = guiCreateButton(11,110,96,29,"Annehmen",false,Fenster)
	local Knopf2 = guiCreateButton(251,109,96,29,"Ablehnen",false,Fenster)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
		local data = tonumber(getElementData(gMe, "pMOTORRADSchein"))
		if(data == 0) then outputChatBox("Du brauchst den Motorradschein dafuer!", 200, 0, 0, false) return end
		destroyElement(Junge)
		destroyElement(Faggio)
		destroyElement(Marker)
		setTimer(createJobAuslieferungBlueberry, jobRespawnDelay*60*1000, 1)
		triggerServerEvent("onAuslieferungsJobStart", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
	end, false)
end

function createJobAuslieferungBlueberry()
	Junge = createPed(188, 246.58195495605, -78.086585998535, 1.578125)
	Faggio = createVehicle(getVehicleModelFromName("Faggio"), 248.22300720215, -77.846702575684, 1.1763147115707, 359.93811035156, 0, 290.33642578125, "LOL")
	setPedRotation(Junge, 7)
	setElementFrozen(Junge, true)
	setElementFrozen(Faggio, true)
	setVehicleEngineState(Faggio, false)
	addEventHandler("onClientPedDamage", getRootElement(), function() if(source == Junge) then cancelEvent() end end)
	Marker = createMarker(247.12438964844, -76.93196105957, 1.078125, "cylinder", 1.0, 0, 255, 0, 200)
	randomCash = math.random(90, 200)
	setElementData(gMe, "jobRandomCash", randomCash)
	addEventHandler("onClientMarkerHit", Marker,
	function(hitElement)
		if(hitElement ~= gMe) then return end
		if(isPedInVehicle(gMe)) then return end
		createJobAuslieferungsGui()
	end)
end
createJobAuslieferungBlueberry()

local Guivar = 0
