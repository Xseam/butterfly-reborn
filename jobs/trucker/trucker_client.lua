local Guivar = 0

local truckVehs = {
	[1] = "Linerunner",
	[2] = "Roadtrain"
}
local ausreden = {
	[1] = "Schmerzen",
	[2] = "Arbeit",
	[3] = "Grippe",
	[4] = "zu Tuen"
}
local veh
local Fahrer
local Marker

local randomCasht = 0
function showJobTruckerGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	
	local X, Y, Width, Height = getMiddleGuiPosition(357,148)
	
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Job",false)
	local Label = guiCreateLabel(7,29,335,71,"Hallo, hast du kurz Zeit fuer mich?\nIch muss ein Anhaenger wegbringen, aber habe "..getElementData(gMe, "JOBAUSREDE")..",\nwenn du es auslieferst, bekommst du von mir "..randomCasht.."$.\nMoechtest du dies tuen fuer mich?",false,Fenster)
	guiLabelSetHorizontalAlign(Label,"center",false)
	guiSetFont(Label,"default-bold-small")
	local Knopf1 = guiCreateButton(11,110,96,29,"Annehmen",false,Fenster)
	local Knopf2 = guiCreateButton(251,109,96,29,"Ablehnen",false,Fenster)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
		triggerServerEvent("onTruckJobAnnehm", gMe)
		destroyElement(veh)
		destroyElement(Fahrer)
		destroyElement(Marker)
		setTimer(createJobTruckerFahrt, jobRespawnDelay*60*1000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
	end, false)
end
function createJobTruckerFahrt()
	local kacke = math.random(1, #truckVehs)
	veh = createVehicle(getVehicleModelFromName(truckVehs[kacke]), -62.514610290527, -1135.6793212891, 1.6841479539871)
	setElementRotation(veh, 0.02630615234375, 0.0006103515625, 18.5224609375)
	Fahrer = createPed(15, -65.72314453125, -1134.6135253906, 1.078125)
	local kacke2 = math.random(1, #ausreden)
	setElementData(gMe, "JOBAUSREDE", ausreden[kacke2])
	setElementData(gMe, "JOBTRUCKVEH", truckVehs[kacke])
	setPedRotation(Fahrer, 67)
	setElementFrozen(Fahrer, true)
	setElementFrozen(veh, true)
	addEventHandler("onClientPedDamage", Fahrer, cancelEvent)
	Marker = createMarker(-66.67317199707, -1134.2117919922, 0.578125, "cylinder", 1.0, 0, 255, 0, 200)
	addEventHandler("onClientMarkerHit", Marker,
	function(hitElement)
		if(hitElement ~= gMe) then return end
		if(isPedInVehicle(gMe)) then return end
		showJobTruckerGui()
	end)
	randomCasht = math.random(100, 200)
	setElementData(gMe, "JOBCASH", randomCasht)
end
createJobTruckerFahrt()

addEvent("respawnPlayerJobTrucker", true)
addEventHandler("respawnPlayerJobTrucker", getRootElement(),
function()
	setTimer(createJobTruckerFahrt, jobRespawnDelay*60*1000, 1)
end)