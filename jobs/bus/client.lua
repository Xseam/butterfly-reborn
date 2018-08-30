local Bus
local Fahrer
local Marker
local randomCash = 0

function createJobBusfahrer()
	Bus = createVehicle(getVehicleModelFromName("Coach"), 2254.1547851563, -82.385124206543, 26.661985397339)
	setElementFrozen(Bus, true)
	setVehicleDamageProof(Bus, false)
	setElementRotation(Bus, 359.96459960938, 0.31854248046875, 260.15502929688)
	Fahrer = createPed(240, 2255.3305664063, -84.962951660156, 26.511222839355)
	setPedRotation(Fahrer, 206)
	setElementFrozen(Fahrer, true)
	addEventHandler("onClientPedDamage", Fahrer, cancelEvent)
	Marker = createMarker(2256.7478027344, -87.316871643066, 25.492254257202, "cylinder", 1.0, 0, 255, 0, 200)

	addEventHandler("onClientMarkerHit", Marker,
	function(hitElement)
		if(hitElement ~= gMe) then return end
		showBusJobGui()
	end)
	randomCash = math.random(30, 100)
	setElementData(gMe, "RANDCASH", randomCash)
end


local Guivar = 0

function showBusJobGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)

	local X, Y, Width, Height = getMiddleGuiPosition(357,148)
	
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Job",false)
	local Label = guiCreateLabel(7,29,335,71,"Hallo! dieser Bus ist noch nicht gefahren.\nMoechtest du ihn fahren? Du musst 5 Stationen abfahren.\nDu bekommst pro Station "..randomCash.."$.",false,Fenster)
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
		destroyElement(Bus)
		destroyElement(Fahrer)
		destroyElement(Marker)
		setTimer(createJobBusfahrer, jobRespawnDelay*60*1000, 1)
		triggerServerEvent("onJobBusfahrerStart", gMe)
		
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster)
	end, false)
end













createJobBusfahrer()