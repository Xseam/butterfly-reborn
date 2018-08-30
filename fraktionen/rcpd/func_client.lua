local Wantmarker = createMarker(254.09541320801, 63.235809326172, 1003.040625, "corona", 1, 0, 255, 0, 200)
setElementInterior(Wantmarker, 6)
local wGui = 0
local wFenster
local sound1, sound2

function createWantedListGui()
	if(wGui == 1) then return end
	wGui = 1
	
	local X, Y, Width, Height = getMiddleGuiPosition(388,265)
	wFenster = guiCreateWindow(X, Y, Width, Height,"Gesuchte Personen",false)
	
	local Grid = guiCreateGridList(9,23,370,233,false,wFenster)
	guiGridListSetSelectionMode(Grid,1)
	guiGridListAddColumn(Grid,"Spieler",0.4)
	guiGridListAddColumn(Grid,"Fraktion",0.3)
	guiGridListAddColumn(Grid,"Wanteds",0.13)
	guiGridListSetSortingEnabled(Grid, false)
	local done = 0
	for index, player in pairs(getElementsByType("player")) do
		if(tonumber(getElementData(player, "pWanteds"))) then
			local wanteds = tonumber(getElementData(player, "pWanteds"))
			if(wanteds > 0) then
				done = 1
				local row = guiGridListAddRow(Grid)
				guiGridListSetItemText(Grid, row, 1, getPlayerName(player), false, false)
				guiGridListSetItemText(Grid, row, 2, fraktionNamen[tonumber(getElementData(player, "pFraktion"))], false, false)
				guiGridListSetItemText(Grid, row, 3, wanteds, false, false)
			end
		end
	
	end
	if(done == 0) then
		local row = guiGridListAddRow(Grid)
		guiGridListSetItemText(Grid, row, 1, "Kein Wantler", false, false)
	end
end
addEventHandler("onClientMarkerLeave", Wantmarker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	if(tonumber(getElementData(gMe, "pFraktion")) ~= 4) then return end
	if(wGui == 0) then return end
	destroyElement(wFenster)
	wGui = 0
end)

addEventHandler("onClientMarkerHit", Wantmarker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	if(tonumber(getElementData(gMe, "pFraktion")) ~= 4) then  return end
	if(wGui == 1) then guiSetVisible(wFenster, false) wGui = 0 return end
	createWantedListGui()
end)

--  posX="250.39999389648" posY="69.5" posZ="1003.9000244141"
local URL = "http://listen.technobase.fm/dsl.asx"

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	sound1 = playSound3D("sounds/portalradio.mp3", 250.39999389648, 69.5, 1003.9000, true) 
	setSoundVolume(sound1, 0.3)
	setElementInterior(sound1, 6)
	sound2 = playSound3D(URL, 214.5, 74, 1004, true) 
	setSoundVolume(sound2, 0.5)
	setElementInterior(sound2, 6)
	-- CAR MODS --
	  local pd = dxCreateShader("data/images/carmods/pd.fx")
	  if pd then
		dxSetShaderValue(pd, "myTex", dxCreateTexture("data/images/carmods/pd.png"))
		engineApplyShaderToWorldTexture(pd, "vehiclepoldecals128")
	  end
end)


Var = true

addEvent("onHifiClickedRCPD", true)
addEventHandler("onHifiClickedRCPD", getRootElement(),
function()
	if not(source == gMe) then return end
	if(Var == true) then
		Var = false
		setSoundVolume(sound2, 0)
	elseif(Var == false) then
		Var = true
		setSoundVolume(sound2, 1)
	end
end)

local Guivar = 0
local Guivar2 = 0
local Camvar = 0
local Fenster1

function build_police_ueberwachung()
	if(Camvar == 1) then return end
	Camvar = 1
	showCursor(true)
	local X, Y, Width, Height = getMiddleGuiPosition(231,105)
	local Fenster = guiCreateWindow(X, Y+122, Width, Height,"Ueberwachungskameras",false)
	local Knopf1 = guiCreateButton(9,22,101,33,"<< Zurueck",false,Fenster)
	local Knopf2 = guiCreateButton(115,23,101,33,"1",false,Fenster)
	local Knopf3 = guiCreateButton(9,60,101,33,"2",false,Fenster)
	local Knopf4 = guiCreateButton(115,60,101,33,"3",false,Fenster)
	addEventHandler("onClientGUIClick", Knopf4,
	function()
		triggerServerEvent("onPoliceComputerCam", gMe, 3)
	end, false)
	addEventHandler("onClientGUIClick", Knopf3,
	function()
		triggerServerEvent("onPoliceComputerCam", gMe, 2)
	end, false)
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		triggerServerEvent("onPoliceComputerCam", gMe, 1)
	end, false)
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		triggerServerEvent("onPoliceComputerCam", gMe, 4)
		destroyElement(Fenster1)
		destroyElement(Fenster)
		Camvar = 0
	end, false)
end

addEventHandler("onClientRender", getRootElement(),
function()
	if(Guivar == 1) then showCursor(true) end
	if(Guivar2 == 1) then showCursor(true) end
end)



addEvent("onPCClickedRCPD", true)
addEventHandler("onPCClickedRCPD", getRootElement(),
function()
	if not(source == gMe) then return end
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	
	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 355,114
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	Fenster1 = guiCreateWindow(X, Y, Width, Height,"Aktion",false)
	local Knopf1 = guiCreateButton(9,24,110,39,"Wantedcomputer\nStarten",false,Fenster1)
	local Knopf2 = guiCreateButton(124,25,110,39,"In Dienst gehen",false,Fenster1)
	local Knopf3 = guiCreateButton(9,66,110,39,"S.W.A.T. Ausruesten",false,Fenster1)
	local Knopf5 = guiCreateButton(238,25,110,39,"Ueberwachungs\nkameras",false,Fenster1)
	if(tonumber(getElementData(gMe, "pFraktionsrang")) < 3) then guiSetEnabled(Knopf3, false) end
	local Knopf4 = guiCreateButton(124,67,110,39,"Abbrechen",false,Fenster1)
	if(getPlayerFraktion(gMe) ~= 4) then guiSetEnabled(Knopf5, false) end
	
	local data1 = tonumber(getElementData(gMe, "dienst"))
	if(data1 == 1) then guiSetText(Knopf2, "Dienst verlassen") end
	local data2 = tonumber(getElementData(gMe, "swat"))
	if(data2 == 1) then guiSetText(Knopf3, "S.W.A.T. verlassen") end
	
	addEventHandler("onClientGUIClick", Knopf5,
	function()
	if(Camgui == 1) then return end
	destroyElement(Fenster1)
	build_police_ueberwachung()
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
	local data = tonumber(getElementData(gMe, "dienst"))
	if(data == 0) or (data == nil) then
		outputChatBox("Du bist nicht im Dienst!", 200, 0, 0, false)
	else
		Guivar = 0
		destroyElement(Fenster1)
		triggerEvent("start_policecomputer", gMe)
	end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
	local data = tonumber(getElementData(gMe, "dienst"))
	if(data == 0) or (data == nil) then
		setElementData(gMe, "dienst", 1)
		triggerServerEvent("onRCPDDuty", gMe, 1)
		guiSetText(Knopf2, "Dienst verlassen")
	else
		setElementData(gMe, "dienst", 0)
		triggerServerEvent("onRCPDDuty", gMe, 0)
		guiSetText(Knopf2, "In Dienst gehen")
	end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf3,
	function()
	local data = tonumber(getElementData(gMe, "swat"))
	if(data == 0) or (data == nil) then
		setElementData(gMe, "swat", 1)
		triggerServerEvent("onSwatDuty", gMe, 1)
		guiSetText(Knopf3, "S.W.A.T. verlassen")
	else
		setElementData(gMe, "swat", 0)
		triggerServerEvent("onSwatDuty", gMe, 0)
		guiSetText(Knopf3, "S.W.A.T. Ausruesten")
	end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf4,
	function()
		Guivar = 0
		destroyElement(Fenster1)
		showCursor(false)
	end, false)
end)
--[[

--]]

-- Anti Choke --

function cancel_teargas(weaponID, responsiblePed)
	if(tonumber(getElementData(source, "swat")) == 1) then cancelEvent() end
end
addEventHandler("onClientPlayerChoke", getLocalPlayer(), cancel_teargas)
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(),
function(attacker, weapon)
	if(weapon == 17) and (tonumber(getElementData(source, "swat")) == 1) then cancelEvent() end
end)

-- Tazer func --

local tazervar = 0

function playerPressedKey(button, press)
    if (press) and (button == "mouse1") then
		if(getPedWeapon(gMe) == 23) then
			if(tonumber(getElementData(gMe, "pFraktion")) == 4) then
				
				if(tazervar == 1) then
					toggleControl ( "fire", false )
					tazervar = 0
					if(isTimer(tazer_timer)) then return end
					tazer_timer = setTimer( function() tazervar = 0 toggleControl("fire", true) end, 5000, 1)
				end
				tazervar = 1
			end
		else
			if(tonumber(getElementData(gMe, "pFraktion")) == 4) then
				toggleControl ( "fire", true )
			end
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

addEvent("play_tazer_sound", true)
addEventHandler("play_tazer_sound", getRootElement(),
function(x, y, z)
	if not(x) or not(y) or not(z) then return end
	local sound = playSound3D("sounds/tazer.mp3", x, y, z)

end)

-- Blitzer --
function renderVehicleBlitzer()
	if(isACop(gMe) == true) then
		if(getElementData(gMe, "blitzercheck") ~= true) then return end
		if(isPedInVehicle(gMe) == false) then return end
		if(getElementData(getPedOccupiedVehicle(gMe), "Besitzer") == "RCPD") or (getElementData(getPedOccupiedVehicle(gMe), "Besitzer") == "FBI") then else return end
		if(math.ceil(getElementsSpeed(getPedOccupiedVehicle(gMe))) > 5) then return end
		for index, car in pairs(getElementsByType("vehicle", getRootElement(), true)) do
			if(isElement(car)) then else return end
			if(getElementData(car, "vspeed")) then
				local x, y, z = getElementPosition(car)
				local x1, y1, z1 = getElementPosition(gMe)
					local sx, sy = getScreenFromWorldPosition(x, y, z)
					if(sx) and (sy) then else return end
					dxDrawText(tostring(getElementData(car, "vspeed")).." km/h", sx, sy, sx, sy, tocolor ( 50, 50, 255, 255 ), 2, "default-bold")
			end
		end
	end
end

addEventHandler("onClientRender", getRootElement(), renderVehicleBlitzer)
function checkVehicleSpeed()
	if(isACop(gMe) == true) then
		if(getElementData(gMe, "blitzercheck") ~= true) then return end
		for index, car in pairs(getElementsByType("vehicle", getRootElement(), true)) do
			local speed = math.ceil(getElementsSpeed(car))
			if(speed) then
				setElementData(car, "vspeed", speed, false)
			else
				setElementData(car, "vspeed", "WTF", false)
			end
		end
	end
end

setTimer(checkVehicleSpeed, 500, 0)
-- Strassensperre --
local object = 0

addEvent("start_strassensperre", true)
addEventHandler("start_strassensperre", gMe,
function(var)
	if not(source == gMe) then return end
	setElementData(gMe, "insperre", 1)
	local x, y, z = getElementPosition(gMe)
	local int = getElementInterior(gMe)
	local dim = getElementDimension(gMe) -- 1459
	local id = 1459
	if(var == 1) then id = 1459 end
	if(var == 2) then id = 1422 end
	if(var == 3) then id = 1228 end
	if(var == 4) then id = 2899 end
	if(var == "Reporter") then id = 2773 end
	object = createObject(id, x, y+2, z)
	setElementInterior(object, int)
	setElementDimension(object, dim)
	setCameraMatrix(x, y+5, z+1, x, y, z)
	setToBinds()
	setElementFrozen(gMe, true)
	outputChatBox("Benutze die Pfeiltasten, um das Objekt zu bewegen! Um es zu Drehen, benutze das Mausrad!", 0, 255, 0, false)
	outputChatBox("Nutze 'Bild. oben' und 'Bild. unten' um das Objekt hoch und Runter zu bewegen!", 0, 255, 0, false)
	outputChatBox("Nutze die Leertaste um Abzubrechen, und Enter um das Objekt zu Platzieren!", 0, 255, 0, false)
end)
function setToBinds()
	bindKey("arrow_l", "down", move_o_left)
	bindKey("arrow_r", "down", move_o_right)
	bindKey("arrow_u", "down", move_o_up)
	bindKey("arrow_d", "down", move_o_down)
	bindKey("pgup", "down", move_o_zero)
	bindKey("pgdn", "down", move_o_zup)
	bindKey("mouse_wheel_up", "down", rotate_o_1)
	bindKey("mouse_wheel_down", "down", rotate_o_2)
	bindKey("enter", "down", o_fertig_func)
	bindKey("space", "down", o_abbrechen_func)
	--addEventHandler("onClientRender", getRootElement(), check_for_object)
end
function o_abbrechen_func()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	unbindKey("arrow_l", "down", move_o_left)
	unbindKey("arrow_r", "down", move_o_right)
	unbindKey("arrow_u", "down", move_o_up)
	unbindKey("arrow_d", "down", move_o_down)
	unbindKey("pgup", "down", move_o_zero)
	unbindKey("pgdn", "down", move_o_zup)
	unbindKey("mouse_wheel_up", "down", rotate_o_1)
	unbindKey("mouse_wheel_down", "down", rotate_o_2)
	unbindKey("enter", "down", o_fertig_func)
	unbindKey("space", "down", o_abbrechen_func)
	destroyElement(object)
	setCameraTarget(gMe)
	setElementData(gMe, "insperre", 0)
	setElementFrozen(gMe, false)
end
function o_fertig_func()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	unbindKey("arrow_l", "down", move_o_left)
	unbindKey("arrow_r", "down", move_o_right)
	unbindKey("arrow_u", "down", move_o_up)
	unbindKey("arrow_d", "down", move_o_down)
	unbindKey("pgup", "down", move_o_zero)
	unbindKey("pgdn", "down", move_o_zup)
	unbindKey("mouse_wheel_up", "down", rotate_o_1)
	unbindKey("mouse_wheel_down", "down", rotate_o_2)
	unbindKey("enter", "down", o_fertig_func)
	unbindKey("space", "down", o_abbrechen_func)
	local x, y, z = getElementPosition(object)
	local x1, y1, z1 = getElementRotation(object)
	local int = getElementInterior(object)
	local dim = getElementDimension(object)
	local modell = getElementModel(object)
	triggerServerEvent("onStrassensperreObjectFinished", gMe, modell, x, y, z, x1, y1, z1, int, dim)
	destroyElement(object)
	setCameraTarget(gMe)
	setElementData(gMe, "insperre", 0)
	setElementFrozen(gMe, false)
end

function rotate_o_2()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z-5)
end


function rotate_o_1()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z+5)
end

function move_o_zero()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y, z+0.25)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_o_zup()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y, z-0.25)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_o_down()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y+0.25, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end
function move_o_right()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x-0.25, y, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end
function move_o_left()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x+0.25, y, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_o_up()
	if not(tonumber(getElementData(gMe, "insperre")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y-0.25, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end