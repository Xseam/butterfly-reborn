local respawnDelay = 10
local Mann
local Auto
local Marker
local randomCash = 0

function createJobWaffenAuslieferungsGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local X, Y, Width, Height = getMiddleGuiPosition(357,148)
	
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Job",false)
	local Label = guiCreateLabel(7,29,335,71,"Hallo! Ich muss dringend eine Lieferung ausfahren.\nAber ich habe gerade keine Zeit!\nDu bekommst von mir "..randomCash.."$.\nMoechtest du dies fuer mich tuen?",false,Fenster)
	guiLabelSetHorizontalAlign(Label,"center",false)
	guiSetFont(Label,"default-bold-small")
	local Knopf1 = guiCreateButton(11,110,96,29,"Annehmen",false,Fenster)
	local Knopf2 = guiCreateButton(251,109,96,29,"Ablehnen",false,Fenster)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
		local data = tonumber(getElementData(gMe, "pFSchein"))
		if(data == 0) then outputChatBox("Du brauchst den Fuehrerschein dafuer!", 200, 0, 0, false) return end
		destroyElement(Mann)
		destroyElement(Auto)
		destroyElement(Marker)
		setTimer(createJobWaffenAuslieferung, jobRespawnDelay*60*1000, 1)
		triggerServerEvent("onWaffenAuslieferungsJobStart", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
	end, false)
end

function createJobWaffenAuslieferung()
	Mann = createPed(188, 247.51318359375, -157.4295501709, 1.578125)
	Auto = createVehicle(getVehicleModelFromName("Boxville"), 251.77734375, -158.0048828125, 1.6411669254303, 359.41223144531, 359.99450683594, 37.040405273438, "MOIN")
	setPedRotation(Mann, 90)
	setElementFrozen(Mann, true)
	setElementFrozen(Auto, true)
	setVehicleEngineState(Auto, false)
	addEventHandler("onClientPedDamage", Mann, cancelEvent)
	Marker = createMarker(246.69410705566, -157.46508789063, 0.778125, "cylinder", 1.0, 0, 255, 0, 200)
	randomCash = math.random(100, 200)
	setElementData(gMe, "jobWaffenRandomCash", randomCash)
	addEventHandler("onClientMarkerHit", Marker,
	function(hitElement)
		if(hitElement ~= gMe) then return end
		if(isPedInVehicle(gMe)) then return end
		createJobWaffenAuslieferungsGui()
	end)
end
createJobWaffenAuslieferung()

local Guivar = 0