-- UPGRADE ON SLOT GLOBAL VAR IST DIE TUNINGID DIE DAS AUTO HAT!! --

local gMe = getLocalPlayer()
local Tuningmarker = createMarker(152.22434997559, -167.16401672363, 1.578125, "corona", 2.0, 0, 0, 255, 200)

local tuningvar = 1
local max_tunings = 3
local timeVar = 0

tuningPosTable = {} 
local tuningTeilPreis = 75

for a = 1, 3, 1 do
	tuningPosTable[a] = {}
end

tuningPosTable[1]["X"], tuningPosTable[1]["Y"], tuningPosTable[1]["Z"] = -2023.0321044922, 149.13999938965, 30
tuningPosTable[2]["X"], tuningPosTable[2]["Y"], tuningPosTable[2]["Z"] = -2032.2354736328, 142.03860473633, 28.8359375
tuningPosTable[3]["X"], tuningPosTable[3]["Y"], tuningPosTable[3]["Z"] = -2013.2652587891, 138.61672973633, 30

local object
local vTuns = {}

addEventHandler("onClientMarkerHit", Tuningmarker,
function(hitElement)
	if(getElementType(hitElement) == "player") then 
	local player = hitElement
	if(player ~= gMe) then return end
	if(isPedInVehicle(player) == false) then return end
	local veh = getPedOccupiedVehicle(player)
	local besitzer = getElementData(veh, "Besitzer")
	if(besitzer ~= getPlayerName(player)) then return end
	triggerServerEvent("onTuningGarageEinfahr", gMe)
	setElementData(gMe, "inTuning", true)
end
end)



local Guivar = 0
function createTuningMenue()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	guiSetInputMode("no_binds_when_editing")
	
	local TUNFenster = {}
	local TUNKnopf = {}
	local TUNLabel = {}
	TUNGrid = {}
	
	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 556,334
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

	TUNFenster[1] = guiCreateWindow(X, Y, Width, Height, "Tuninggarage",false)
	TUNLabel[1] = guiCreateLabel(160,22,194,36,"Willkommen in der Tuninggarage!\nHier kannst du dein Auto Tunen.",false,TUNFenster[1])
	guiSetFont(TUNLabel[1],"default-bold-small")
	TUNGrid[1] = guiCreateGridList(10,50,421,272,false,TUNFenster[1])
	guiGridListSetSelectionMode(TUNGrid[1],1)

	guiGridListAddColumn(TUNGrid[1],"Tuningname",0.3)

	guiGridListAddColumn(TUNGrid[1],"Preis",0.3)

	guiGridListAddColumn(TUNGrid[1],"ID",0.1)

	guiGridListAddColumn(TUNGrid[1],"Eingebaut",0.3)
	TUNKnopf[1] = guiCreateButton(440,50,102,36,"Kaufen",false,TUNFenster[1])
	TUNKnopf[2] = guiCreateButton(439,89,102,36,"Verkaufen",false,TUNFenster[1])
	TUNKnopf[3] = guiCreateButton(441,286,102,36,"Schliessen",false,TUNFenster[1])
	TUNLabel[2] = guiCreateLabel(440,136,106,39,"Geld auf der Hand:\n0$",false,TUNFenster[1])
	guiSetFont(TUNLabel[2],"default-bold-small")
	TUNLabel[3] = guiCreateLabel(364,30,185,17,"_____________________________",false,TUNFenster[1])
	guiLabelSetColor(TUNLabel[3],0, 255, 255)
	TUNLabel[4] = guiCreateLabel(9,29,147,17,"___________________",false,TUNFenster[1])
	guiLabelSetColor(TUNLabel[4],0,255,255)
	local function updateGeld()
	guiSetText(TUNLabel[2], "Geld auf der Hand:\n"..tonumber(getElementData(gMe, "pHGeld")).."$")
	end
	updateGeld()
	local veh = getElementModel(getPedOccupiedVehicle( gMe ))
	local vehID = getPedOccupiedVehicle(gMe)
	updateTuningGui(veh)
	
	addEventHandler("onClientGUIClick", TUNKnopf[3], -- Schliessen
	function()
		guiSetVisible(TUNFenster[1], false)
		Guivar = 0
		showCursor(false)
		setElementData(gMe, "inTuning", false)
		triggerServerEvent("onTuningMenueAbbrechen", gMe)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		setElementData(gMe, "Clicked", 0)
		destroyElement(object)
		toggleAllControls(true)
		unbindKey("arrow_l", "down", move_tuning_left)
		unbindKey("arrow_r", "down", move_tuning_right)
		tuningvar = 1
		timeVar = 0
		for i = 0, 16, 1 do
		local upgrade = getVehicleUpgradeOnSlot ( getPedOccupiedVehicle(gMe), i )
			if(upgrade) then
				removeVehicleUpgrade(getPedOccupiedVehicle(gMe), upgrade)
			end
		end
	end, false)
	

	addEventHandler("onClientGUIClick", TUNKnopf[2], -- Verkaufen
	function()
		local veh = getPedOccupiedVehicle(gMe)
		local id = guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 3, false, false)
		local done = guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 4, false, false)
		local preis = tonumber(gettok(guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 2, false, false), 1, "$"))
		if(id == " ") or (id == "") then return end
		if(done == "Nein") then outputChatBox("Du hast dieses Upgrade nicht Eingebaut!", 200, 0, 0, false) return end
		if(tonumber(id) == 5) then -- Motor
			triggerServerEvent("onSpecialTuningTeilVerkauf", gMe, veh, "Motor")
		elseif(tonumber(id) == 6) then -- Panzerung
			triggerServerEvent("onSpecialTuningTeilVerkauf", gMe, veh, "Panzerung")
		elseif(tonumber(id) == 7) then -- GPS
			triggerServerEvent("onSpecialTuningTeilVerkauf", gMe, veh, "GPS")		
		else
		
		triggerServerEvent("onTuningTeilVerkauf", gMe, veh, id, preis)
		removeVehicleUpgrade(getPedOccupiedVehicle(gMe), id)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", TUNKnopf[1], -- Kaufen
	function()
		local veh = getPedOccupiedVehicle(gMe)
		local id = guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 3, false, false)
		local done = guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 4, false, false)
		local preis = tonumber(gettok(guiGridListGetItemText(TUNGrid[1], guiGridListGetSelectedItem(TUNGrid[1]), 2, false, false), 1, "$"))
		if(id == " ") or (id == "") then return end
		if(done == "Ja") then outputChatBox("Du hast dieses Upgrade bereits!", 200, 0, 0, false) return end
		for i = 0, 16, 1 do
			vTuns[i] = getVehicleUpgradeOnSlot(veh, i)
		end
		if(tonumber(getElementData(gMe, "pHGeld")) < 1) then outputChatBox("Du hast nicht genug Geld auf der Hand!", 200, 0, 0) return end
		if(tonumber(id) == 5) then -- Motor
			triggerServerEvent("onSpecialTuningTeilKauf", gMe, veh, "Motor")
		elseif(tonumber(id) == 6) then -- Panzerung
			triggerServerEvent("onSpecialTuningTeilKauf", gMe, veh, "Panzerung")
		elseif(tonumber(id) == 7) then -- GPS
			triggerServerEvent("onSpecialTuningTeilKauf", gMe, veh, "GPS")
		else
			triggerServerEvent("onTuningTeilKauf", gMe, veh, id, preis, vTuns[0], vTuns[1], vTuns[2], vTuns[3], vTuns[4], vTuns[5], vTuns[6], vTuns[7], vTuns[8], vTuns[9], vTuns[10], vTuns[11], vTuns[12], vTuns[13], vTuns[14], vTuns[15], vTuns[16])
		--outputChatBox("Unbekannter Slot!", 200, 0, 0,false)
		end
	end, false)
		function show_vorschau ()
			local veh = getPedOccupiedVehicle(gMe)
			local rowindex, columnindex = guiGridListGetSelectedItem ( TUNGrid[1] )
			local selectedText = guiGridListGetItemText ( TUNGrid[1], rowindex, 3)
			if(selectedText == "Besserer Motor") or (selectedText == "Panzerung") or (selectedText == "GPS") then return end
			local data = getElementData(veh, "fTunings")
			for i = 0, 16, 1 do
				local upgrade = getVehicleUpgradeOnSlot ( veh, i )
				if(upgrade) then
					removeVehicleUpgrade(veh, upgrade)
				end
				local tok = i+1
				local tun = tonumber(gettok(data, tok, "|"))
				if(tun == 0) or (tun == nil) then vTuns[i] = 0 else
					addVehicleUpgrade(veh, tun)
					vTuns[i] = tun
				end
			end
			if selectedText then
				addVehicleUpgrade ( veh, selectedText )
			end
			guiSetText(TUNLabel[2], "Geld auf der Hand:\n"..tonumber(getElementData(gMe, "pHGeld")).."$")
		end
	addEventHandler ( "onClientGUIClick", TUNGrid[1], show_vorschau )
end


function updateTuningGui(veh)
	local myveh = getPedOccupiedVehicle(gMe)
	guiGridListClear(TUNGrid[1])
		local row = guiGridListAddRow(TUNGrid[1])
		guiGridListSetItemText( TUNGrid[1], row, 1, "  Spezial:", false, false )
		guiGridListSetItemColor ( TUNGrid[1], row, 1, 0, 255, 255)
		-- Spezial Teile --
		-- Motor --
		local rowtunings1 = guiGridListAddRow(TUNGrid[1])
		guiGridListSetItemText( TUNGrid[1], rowtunings1, 1, "Besserer Motor", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings1, 2, "550$", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings1, 3, "5", false, false )
		local spe1c = getElementData(myveh, "fTuningsspec")
		local spec = tonumber(gettok(spe1c, 1, "|"))
		if(spec) and (spec == 1) then
			guiGridListSetItemText( TUNGrid[1], rowtunings1, 4, "Ja", false, false )
		else
			guiGridListSetItemText( TUNGrid[1], rowtunings1, 4, "Nein", false, false )
		end
		-- Panzerung --
		local rowtunings2 = guiGridListAddRow(TUNGrid[1])
		guiGridListSetItemText( TUNGrid[1], rowtunings2, 1, "Panzerung", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings2, 2, "2000$", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings2, 3, "6", false, false )
		local spe1c = getElementData(myveh, "fTuningsspec")
		local spec = tonumber(gettok(spe1c, 2, "|"))
		if(spec) and (spec == 1) then
			guiGridListSetItemText( TUNGrid[1], rowtunings2, 4, "Ja", false, false )
		else
			guiGridListSetItemText( TUNGrid[1], rowtunings2, 4, "Nein", false, false )
		end
		-- GPS --
		local rowtunings3 = guiGridListAddRow(TUNGrid[1])
		guiGridListSetItemText( TUNGrid[1], rowtunings3, 1, "GPS", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings3, 2, "150$", false, false )
		guiGridListSetItemText( TUNGrid[1], rowtunings3, 3, "7", false, false )
		local spe1c = getElementData(myveh, "fTuningsspec")
		local spec = tonumber(gettok(spe1c, 3, "|"))
		if(spec) and (spec == 1) then
			guiGridListSetItemText( TUNGrid[1], rowtunings3, 4, "Ja", false, false )
		else
			guiGridListSetItemText( TUNGrid[1], rowtunings3, 4, "Nein", false, false )
		end
		for i = 0, 16, 1 do

			local compatList = compatibleUpgrades[veh][i]
			if(compatList) then
			for il, roou in ipairs(compatList) do	
				up = 1			
			end
			if up == 1 then
				local row = guiGridListAddRow ( TUNGrid[1] )
				guiGridListSetItemText( TUNGrid[1], row, 1, "  "..slotNames[i]..":", false, false )
				guiGridListSetItemText( TUNGrid[1], row, 2, " ", false, false )
				guiGridListSetItemText( TUNGrid[1], row, 3, " ", false, false )
				guiGridListSetItemText( TUNGrid[1], row, 4, " ", false, false )
				guiGridListSetItemColor ( TUNGrid[1], row, 1, 0, 255, 255)
			end
				for li, upgradeID in ipairs(compatList) do	
					local row = guiGridListAddRow ( TUNGrid[1] )
					guiGridListSetItemText( TUNGrid[1], row, 1, UpgradeNames[upgradeID], false, false )
					if i == 8 then
							if upgradeID == 1008 then price = 5*50 end
							if upgradeID == 1009 then price = 2*50 end
							if upgradeID == 1010 then price = 10*50 end
					else
						price = tuningTeilPreis
					end
					guiGridListSetItemText( TUNGrid[1], row, 2, price.."$", false, false )
					guiGridListSetItemText( TUNGrid[1], row, 3, upgradeID, false, false )
					local vehid = getPedOccupiedVehicle(gMe)
					local tunings = getElementData(vehid, "fTunings")
					local id = tonumber(gettok(tunings, i+1, "|"))
					if(getVehicleUpgradeOnSlot ( getPedOccupiedVehicle ( gMe ), i ) == upgradeID ) then
						guiGridListSetItemText( TUNGrid[1], row, 4, "Ja", false, false )
					else
						guiGridListSetItemText( TUNGrid[1], row, 4, "Nein", false, false )
					end
				end
				
			end
		end
	end
addEvent("onPlayerTuningUpdate", true)
addEventHandler("onPlayerTuningUpdate", getRootElement(), updateTuningGui)
--|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|
--[[
function updateTuningGui(veh)
	for upgradeSlot=0,16, 1 do
		up = 0
		local compatList = compatibleUpgrades[veh][upgradeSlot]
		if compatList then
			for i, upgradeID in ipairs(compatList) do	
				up = 1			
			end
		end
		if up == 1 then
			local row = guiGridListAddRow ( TUNGrid[1] )
			guiGridListSetItemText( TUNGrid[1], row, 1, "  "..slotNames[upgradeSlot]..":", false, false )
			guiGridListSetItemText( TUNGrid[1], row, 2, " ", false, false )
			guiGridListSetItemText( TUNGrid[1], row, 3, " ", false, false )
			guiGridListSetItemText( TUNGrid[1], row, 4, " ", false, false )
			guiGridListSetItemColor ( TUNGrid[1], row, 1, 0, 255, 255)
		for i, upgradeID in ipairs(compatList) do	
			local row = guiGridListAddRow ( TUNGrid[1] )
			guiGridListSetItemText( TUNGrid[1], row, 1, UpgradeNames[upgradeID], false, false )
			if upgradeSlot == 8 then
					if upgradeID == 1008 then price = 5*50 end
					if upgradeID == 1009 then price = 2*50 end
					if upgradeID == 1010 then price = 10*50 end
			else
				price = tuningTeilPreis
			end
			guiGridListSetItemText( TUNGrid[1], row, 2, price.."$", false, false )
			guiGridListSetItemText( TUNGrid[1], row, 3, upgradeID, false, false )
			local fix
			if getVehicleUpgradeOnSlot ( getPedOccupiedVehicle ( gMe ), upgradeSlot ) == upgradeID then 
				_G["upgradeSlot"..upgradeSlot.."MountedID"] = upgradeID
					fix = "    [x]"
				else
					fix = "    [  ]" 
				end
			guiGridListSetItemText( TUNGrid[1], row, 4, fix, false, false )
		end
		end
	end
end--]]


function setToRightCamTuning()
	local x, y, z = tuningPosTable[tuningvar]["X"], tuningPosTable[tuningvar]["Y"], tuningPosTable[tuningvar]["Z"]
	local x1, y1, z1, x2, y2, z2 = getCameraMatrix()
	setCameraMatrix(x, y, z, x2, y2, z2)
end

function move_tuning_left()
	if(timeVar == 1) then return end
	timeVar = 1
	setTimer(function() timeVar = 0 end, 100, 1)
	if(tuningvar == 1) then tuningvar = 2
	elseif(tuningvar == 2) then tuningvar = 3
	elseif(tuningvar == 3) then tuningvar = 1 end
	setToRightCamTuning()
end

function move_tuning_right()
if(timeVar == 1) then return end
	timeVar = 1
	setTimer(function() timeVar = 0 end, 100, 1)
	if(tuningvar == 1) then tuningvar = 3
	elseif(tuningvar == 2) then tuningvar = 1
	elseif(tuningvar == 3) then tuningvar = 2 end
	setToRightCamTuning()
end

addEvent("onTuningSetVar", true)
addEventHandler("onTuningSetVar", getRootElement(),
function()
	createTuningMenue()
	object = createObject(14796, -2034.1500244141, 146.4700012207, 31.60000038147)
	setElementDimension(object, getElementData(source, "curDim"))
	toggleAllControls(false)
	
	bindKey("arrow_l", "down", move_tuning_left)
	bindKey("arrow_r", "down", move_tuning_right)
	timeVar = 0
end)