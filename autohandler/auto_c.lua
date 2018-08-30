local Verkaeufer = createPed(240, 1224.4094238281, 174.96228027344, 26.028469085693)
setPedRotation(Verkaeufer, 180)
local Mechanik = createPed(50, 666.44329833984, -547.748046875, 16.3359375)
local Verk2 = createPed(240,-106.06753540039, -119.0933303833, 3.1171875)
setPedRotation(Verk2, 168)

local pGuivar = 0

addEventHandler("onClientPedDamage", Verkaeufer, cancelEvent)
addEventHandler("onClientPedDamage", Verk2, cancelEvent)

local Guivar = 0

-- PAINT --
addEvent("onPrivatcarColor", true)
addEventHandler("onPrivatcarColor", getRootElement(),
function()
if(pGuivar == 1) then return end
	pGuivar = 1
	setElementData(gMe, "Clicked", 1)
	local pFenste = {}
	local pKnopf = {}
	local pLabel = {}
	local pScrollbar = {}
	local pRadio = {}
	addEventHandler("onClientRender", getRootElement(), function() if(pGuivar == 1) then showCursor(true) end end)

			local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 503,266
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
		
	pFenste[1] = guiCreateWindow(X, Y, Width, Height, "Pay'n'Spray",false)
	guiWindowSetSizable(pFenste[1], false)
	pLabel[1] = guiCreateLabel(8,20,428,21,"Willkommen! Hier kannst du deine Autofarbe und deine Lichtfarbe aendern.",false,pFenste[1])
	guiSetFont(pLabel[1],"default-bold-small")
	pLabel[2] = guiCreateLabel(145,153,94,16,"Lichtfarbe:",false,pFenste[1])
	guiSetFont(pLabel[2],"default-bold-small")
	pScrollbar[1] = guiCreateScrollBar(20,174,318,23,true,false,pFenste[1])
	pScrollbar[2] = guiCreateScrollBar(20,198,318,23,true,false,pFenste[1])
	pScrollbar[3] = guiCreateScrollBar(20,221,318,23,true,false,pFenste[1])
	pLabel[3] = guiCreateLabel(129,38,94,16,"Fahrzeugfarbe:",false,pFenste[1])
	guiSetFont(pLabel[3],"default-bold-small")
	pScrollbar[4] = guiCreateScrollBar(23,58,318,23,true,false,pFenste[1])
	pScrollbar[5] = guiCreateScrollBar(23,82,318,23,true,false,pFenste[1])
	pScrollbar[6] = guiCreateScrollBar(23,105,318,23,true,false,pFenste[1])
	pLabel[4] = guiCreateLabel(385,48,69,45,"Kosten der \nAenderung:\n50$",false,pFenste[1])
	guiSetFont(pLabel[4],"default-bold-small")
	pKnopf[1] = guiCreateButton(360,222,111,27,"Abbrechen",false,pFenste[1])
	pKnopf[2] = guiCreateButton(360,186,111,27,"Kaufen",false,pFenste[1])
	pRadio[1] = guiCreateRadioButton(368,98,89,19,"Farbe 1",false,pFenste[1])
	pRadio[2] = guiCreateRadioButton(368,115,89,19,"Farbe 3",false,pFenste[1])
	pRadio[3] = guiCreateRadioButton(368,131,89,19,"Farbe 2",false,pFenste[1])
	pRadio[4] = guiCreateRadioButton(368,148,89,19,"Farbe 4",false,pFenste[1])
	pRadio[5] = guiCreateRadioButton(28,129,88,18,"Paintjob 1",false,pFenste[1])
	guiSetFont(pRadio[5],"default-bold-small")
	pRadio[6] = guiCreateRadioButton(109,130,88,18,"Paintjob 2",false,pFenste[1])
	guiSetFont(pRadio[6],"default-bold-small")
	pRadio[7] = guiCreateRadioButton(192,130,88,18,"Paintjob 3",false,pFenste[1])
	guiSetFont(pRadio[7],"default-bold-small")
	pRadio[8] = guiCreateRadioButton(273,130,88,18,"Paintjob 4",false,pFenste[1])
	guiRadioButtonSetSelected(pRadio[8],true)
	guiSetFont(pRadio[8],"default-bold-small")
	guiRadioButtonSetSelected(pRadio[1],true)
	
	local veh = getPedOccupiedVehicle(gMe)
	
	local c1, c2, c3 = getVehicleColor(veh)
	local c4, c5, c6 = getVehicleHeadLightColor(veh)
	
	--
	local camx, camy, camz, camx1, camy1, camz1 = getCameraMatrix()
	local a, b, c = getElementPosition(gMe)
	setCameraMatrix(camx, camy, camz+5, a, b, c)
	--
	
	addEventHandler("onClientGUIClick", pRadio[5],
	function()
		setVehiclePaintjob(veh, 0)
	end, false)
	
	addEventHandler("onClientGUIClick", pRadio[6],
	function()
		setVehiclePaintjob(veh, 1)
	end, false)
	addEventHandler("onClientGUIClick", pRadio[7],
	function()
		setVehiclePaintjob(veh, 2)
	end, false)

	addEventHandler("onClientGUIClick", pRadio[8],
	function()
		setVehiclePaintjob(veh, 3)
	end, false)
	addEventHandler("onClientGUIClick", pKnopf[2],
	function()
		local data = tonumber(getElementData(gMe, "pHGeld"))
		if(data < 51) then outputChatBox("Du brauchst 50$ fuer diese Aktion!", 230, 0, 0, false) return end
		
		local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12 = getVehicleColor(veh, true)
		local lf1, lf2, lf3 = getVehicleHeadLightColor(veh)
		local paintjob = getVehiclePaintjob(veh)
		setElementData(gMe, "Clicked", 0)
		pGuivar = 0
		showCursor(false)
		destroyElement(pFenste[1])
		setCameraTarget(gMe)
		triggerServerEvent("onPrivatAutoFarbeKauf", gMe, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, lf1, lf2, lf3, paintjob)
		removeEventHandler("onClientRender", getRootElement(), function() if(pGuivar == 1) then showCursor(true) end end)
	end, false)
	
	addEventHandler("onClientGUIClick", pKnopf[1],
	function()
		setElementData(gMe, "Clicked", 0)
		pGuivar = 0
		showCursor(false)
		destroyElement(pFenste[1])
		setCameraTarget(gMe)
		removeEventHandler("onClientRender", getRootElement(), function() if(pGuivar == 1) then showCursor(true) end end)
		triggerServerEvent("onPrivatAutoFarbeReset", gMe)
	end, false)

	addEventHandler("onClientGUIScroll",root,
	function ()
	   if (source == pScrollbar[1]) or (source == pScrollbar[2]) or (source == pScrollbar[3]) then
		
		local f1, f2, f3 = (guiScrollBarGetScrollPosition(pScrollbar[1])*2.55), (guiScrollBarGetScrollPosition(pScrollbar[2])*2.55), (guiScrollBarGetScrollPosition(pScrollbar[3])*2.55)
		guiLabelSetColor(pLabel[2], f1, f2, f3)
		setVehicleHeadLightColor(veh, f1, f2, f3)
	   end
	   	if (source == pScrollbar[4]) or (source == pScrollbar[5]) or (source == pScrollbar[6]) then
		local f4, f5, f6 = (guiScrollBarGetScrollPosition(pScrollbar[4])*2.55), (guiScrollBarGetScrollPosition(pScrollbar[5])*2.55), (guiScrollBarGetScrollPosition(pScrollbar[6])*2.55)
		guiLabelSetColor(pLabel[3], f4, f5, f6)
		if(guiRadioButtonGetSelected(pRadio[1]) == true) then
			setVehicleColor(veh, f4, f5, f6)
		end
		if(guiRadioButtonGetSelected(pRadio[2]) == true) then
			local x, y, z, x2, y2, z2, x3, y3, z3, x4, y4, z4 = getVehicleColor(veh, true)
			setVehicleColor(veh, x, y, z, f4, f5, f6)
		end
		if(guiRadioButtonGetSelected(pRadio[3]) == true) then
			local x, y, z, x2, y2, z2, x3, y3, z3, x4, y4, z4 = getVehicleColor(veh, true)
			setVehicleColor(veh, x, y, z, x2, y2, z2, f4, f5, f6)
		end
		if(guiRadioButtonGetSelected(pRadio[4]) == true) then
			local x, y, z, x2, y2, z2, x3, y3, z3, x4, y4, z4 = getVehicleColor(veh, true)
			setVehicleColor(veh, x, y, z, x2, y2, z2, x3, y3, z3, f4, f5, f6)
		end
	   end
	  end)

end)
-- AUTOHAUS --
function createAutohausGuiMenue()
if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local AUTOFenster = {}
	local AUTOKnopf = {}
	local AUTOLabel = {}
	local AUTORadio = {}
	local AUTOGrid = {}
	
		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 376,261
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

	AUTOFenster[1] = guiCreateWindow(X, Y, Width, Height, "Autohaus",false)
	AUTOLabel[1] = guiCreateLabel(9,25,238,29,"Guten Tag der Herr/Dame!\nWas darfs sein?",false,AUTOFenster[1])
	guiLabelSetHorizontalAlign(AUTOLabel[1],"center",false)
	guiSetFont(AUTOLabel[1],"default-bold-small")
	AUTOLabel[2] = guiCreateLabel(8,42,343,17,"____________________________________________________",false,AUTOFenster[1])
	guiSetFont(AUTOLabel[2],"default-bold-small")
	AUTOKnopf[1] = guiCreateButton(238,206,108,33,"Abbrechen",false,AUTOFenster[1])
	AUTOGrid[1] = guiCreateGridList(10,61,218,191,false,AUTOFenster[1])
	guiGridListSetSelectionMode(AUTOGrid[1],1)

	guiGridListAddColumn(AUTOGrid[1],"Fahrzeugname",0.6)

	guiGridListAddColumn(AUTOGrid[1],"Preis",0.2)
	AUTOKnopf[2] = guiCreateButton(240,165,105,28,"Auto Kaufen",false,AUTOFenster[1])
	AUTOLabel[3] = guiCreateLabel(238,68,103,22,"Bezahlmethode:",false,AUTOFenster[1])
	guiSetFont(AUTOLabel[3],"default-bold-small")
	AUTORadio[1] = guiCreateRadioButton(236,96,104,24,"Bar",false,AUTOFenster[1])
	guiSetFont(AUTORadio[1],"default-bold-small")
	AUTORadio[2] = guiCreateRadioButton(236,121,104,24,"Bank",false,AUTOFenster[1])
	guiRadioButtonSetSelected(AUTORadio[2],true)
	guiSetFont(AUTORadio[2],"default-bold-small")
	
	addEventHandler("onClientGUIClick", AUTOKnopf[1],
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(AUTOFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end, false)
	
	addEventHandler("onClientGUIClick", AUTOKnopf[2],
	function()
		local auto = guiGridListGetItemText (AUTOGrid[1], guiGridListGetSelectedItem ( AUTOGrid[1] ), 1 )
		if(auto == "") or (auto == " ") then outputChatBox("Bitte Waehle ein Auto aus!", 255, 0, 0, false) return end
		local bar = guiRadioButtonGetSelected(AUTORadio[1])
		local bank = guiRadioButtonGetSelected(AUTORadio[2])
		local zahlung = "pHGeld"
		if(bar == true) then zahlung = "pHGeld"
		elseif(bank == true) then zahlung = "pBGeld" end
		local data = tonumber(getElementData(gMe, zahlung))
		local vehicle = getVehicleModelFromName(auto)
		local autopreis = a_preisTable[auto]
		if not(autopreis) then outputChatBox("Fehler beim Kauf! Auto wurde nicht gefunden!", 200, 0, 0, false) return end
		if(data < autopreis+1) then outputChatBox("Du hast nicht genug Geld auf der Hand/Bank!", 200, 0, 0, false) return end
		outputChatBox("Auto: "..auto..", Preis: "..autopreis.." Zahlung: "..zahlung, 0, 255, 255)
		Guivar = 0
		showCursor(false)
		destroyElement(AUTOFenster[1])
		local id = getVehicleModelFromName(auto)
		if not (id) then return end
		local car1 = tonumber(getElementData(gMe, "Carslot1"))
		local car2 = tonumber(getElementData(gMe, "Carslot2"))
		local car3 = tonumber(getElementData(gMe, "Carslot3"))
		local car4 = tonumber(getElementData(gMe, "Carslot4"))
		local car5 = tonumber(getElementData(gMe, "Carslot5"))
		local slot = 0
		if not(car5) then slot = 5 
		elseif not(car4) then slot = 4 
		elseif not(car3) then slot = 3
		elseif not(car2) then slot = 2
		elseif not(car1) then slot = 1 end
		if(slot == 0) then outputChatBox("Du hast kein Autoslot mehr frei!", 200, 0, 0, false) return end
		setElementData(gMe, zahlung, data-autopreis)
		triggerServerEvent("onAutoKauf1", gMe, id, slot)
		--setElementData(gMe, data, data-autopreis)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end, false)
	
		guiGridListClear(AUTOGrid[1])
		for x = 1, #a_autoTable, 1 do
			local x1, y1, z1 = getElementPosition(gMe)
			if(getZoneName(x1, y1, z1, false) == "Blueberry") or (getZoneName(x1, y1, z1, false) == "Blueberry Acres") then -- Beim Flugzeug
				local car = a_autoTable[x]
				local vehid = getVehicleModelFromName(car)
				if(getVehicleType(vehid) == "Plane") or (getVehicleType(vehid) == "Helicopter") then -- Nur Flugzeuge Rausfiltern
					local row = guiGridListAddRow(AUTOGrid[1])
					guiGridListSetItemText(AUTOGrid[1],row,1,a_autoTable[x],false,false)
					guiGridListSetItemText(AUTOGrid[1],row,2,a_preisTable[a_autoTable[x]].."$",false,false)
				end
			else -- Autohaus
				local car = a_autoTable[x]
				local vehid = getVehicleModelFromName(car)
	
					if(getVehicleType(vehid) == "Plane") and (car ~= "Vortex") then else-- Vortex mit
						if(getVehicleType(vehid) == "Helicopter") then else
							local row = guiGridListAddRow(AUTOGrid[1])
							guiGridListSetItemText(AUTOGrid[1],row,1,a_autoTable[x],false,false)
							guiGridListSetItemText(AUTOGrid[1],row,2,a_preisTable[a_autoTable[x]].."$",false,false)
						end
					end
			end
		end


end

addEvent("onAutohausGuiStart1", true)
addEventHandler("onAutohausGuiStart1", getRootElement(),
function()
	if not(source == gMe) then return end
	createAutohausGuiMenue()
end)
local Guivara = 0
local FensterAG = {}
local cantriggerthis = 0
local vehblip = {}
local vehbliptimer = {}

function showAutoListGui()
	if(Guivara == 1) then return end
	Guivara = 1

	local Grid = {}
	local Bild = {}
	local X, Y, Width, Height = getMiddleGuiPosition(494,233)

	FensterAG[1] = guiCreateWindow(X, Y, Width, Height,"Fahrzeuginfos",false)
	Grid[1] = guiCreateGridList(9,22,476,202,false,FensterAG[1])
	guiGridListSetSelectionMode(Grid[1],2)

	guiGridListAddColumn(Grid[1],"Slot",0.15)

	guiGridListAddColumn(Grid[1],"Fahrzeugname",0.4)

	guiGridListAddColumn(Grid[1],"Standort",0.35)

	Bild[1] = guiCreateStaticImage(137,78,213,97,"data/images/inv/car.png",false,FensterAG[1])
	guiMoveToBack(Bild[1])
	guiSetAlpha(Bild[1], 0.8)
	
	local slot1 = getElementData(gMe, "Car1")
	local slot2 = getElementData(gMe, "Car2")
	local slot3 = getElementData(gMe, "Car3")
	local slot4 = getElementData(gMe, "Car4")
	local slot5 = getElementData(gMe, "Car5")
	
	local zone1 = "N/A"
	local zone2 = "N/A"
	local zone3 = "N/A"
	local zone4 = "N/A"
	local zone5 = "N/A"
	
	if not(slot1) then slot1 = "N/A" end
	if not(slot2) then slot2 = "N/A" end
	if not(slot3) then slot3 = "N/A" end
	if not(slot4) then slot4 = "N/A" end
	if not(slot5) then slot5 = "N/A" end
	local x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, x5, y5, z5
	if(slot1 ~= "N/A") then x1, y1, z1 = getElementPosition(slot1) end
	if(slot2 ~= "N/A") then x2, y2, z2 = getElementPosition(slot2) end
	if(slot3 ~= "N/A") then x3, y3, z3 = getElementPosition(slot3) end
	if(slot4 ~= "N/A") then x4, y4, z4 = getElementPosition(slot4) end
	if(slot5 ~= "N/A") then x5, y5, z5 = getElementPosition(slot5) end
	local temp1, temp2, temp3, temp4, temp5
	if(slot1) and (slot1 ~= "N/A") then zone1 = getZoneName(x1, y1, z1, false) temp1 = getVehicleName(slot1) else temp1 = "N/A" end
	if(slot2) and (slot2 ~= "N/A") then zone2 = getZoneName(x2, y2, z2, false) temp2 = getVehicleName(slot2) else temp2 = "N/A" end
	if(slot3) and (slot3 ~= "N/A") then zone3 = getZoneName(x3, y3, z3, false) temp3 = getVehicleName(slot3) else temp3 = "N/A" end
	if(slot4) and (slot4 ~= "N/A") then zone4 = getZoneName(x4, y4, z4, false) temp4 = getVehicleName(slot4) else temp4 = "N/A" end
	if(slot5) and (slot5 ~= "N/A") then zone5 = getZoneName(x5, y5, z5, false) temp5 = getVehicleName(slot5) else temp5 = "N/A" end
	
	local row1 = guiGridListAddRow(Grid[1])
	local row2 = guiGridListAddRow(Grid[1])
	local row3 = guiGridListAddRow(Grid[1])
	local row4 = guiGridListAddRow(Grid[1])
	local row5 = guiGridListAddRow(Grid[1])
	guiSetFont(Grid[1], "default-bold-small")
	local r1, g1, b1 = 255, 255, 255
	local r2, g2, b2 = 0, 255, 255
	local r3, g3, b3 = 255, 0, 0
	local r4, g4, b4 = 0, 255,0
	local r5, g5, b5 = 0, 0, 255
	
	guiGridListSetItemText(Grid[1], row5, 1,"5",false, false)
	guiGridListSetItemText(Grid[1], row4, 1,"4",false, false)
	guiGridListSetItemText(Grid[1], row3, 1,"3",false, false)
	guiGridListSetItemText(Grid[1], row2, 1,"2",false, false)
	guiGridListSetItemText(Grid[1], row1, 1,"1",false, false)
	guiGridListSetItemText(Grid[1], row5, 2,temp5,false, false)
	guiGridListSetItemText(Grid[1], row4, 2,temp4,false, false)
	guiGridListSetItemText(Grid[1], row3, 2,temp3,false, false)
	guiGridListSetItemText(Grid[1], row2, 2,temp2,false, false)
	guiGridListSetItemText(Grid[1], row1, 2,temp1,false, false)
	guiGridListSetItemText(Grid[1], row5, 3,zone5,false, false)
	guiGridListSetItemText(Grid[1], row4, 3,zone4,false, false)
	guiGridListSetItemText(Grid[1], row3, 3,zone3,false, false)
	guiGridListSetItemText(Grid[1], row2, 3,zone2,false, false)
	guiGridListSetItemText(Grid[1], row1, 3,zone1,false, false)
	if(slot5 ~= "N/A") and (getElementData(slot5, "fGPS") == true) then
		guiGridListSetItemColor(Grid[1], row5, 1, r5, g5, b5)
		guiGridListSetItemColor(Grid[1], row5, 2, r5, g5, b5)
		guiGridListSetItemColor(Grid[1], row5, 3, r5, g5, b5)
	end
	if(slot4 ~= "N/A") and (getElementData(slot4, "fGPS") == true) then
		guiGridListSetItemColor(Grid[1], row4, 1, r4, g4, b4)
		guiGridListSetItemColor(Grid[1], row4, 2, r4, g4, b4)
		guiGridListSetItemColor(Grid[1], row4, 3, r4, g4, b4)
	end
	if(slot3 ~= "N/A") and (getElementData(slot3, "fGPS") == true) then
		guiGridListSetItemColor(Grid[1], row3, 1, r3, g3, b3)
		guiGridListSetItemColor(Grid[1], row3, 2, r3, g3, b3)
		guiGridListSetItemColor(Grid[1], row3, 3, r3, g3, b3)
	end
	if(slot2 ~= "N/A") and (getElementData(slot2, "fGPS") == true) then
		guiGridListSetItemColor(Grid[1], row2, 1, r2, g2, b2)
		guiGridListSetItemColor(Grid[1], row2, 2, r2, g2, b2)
		guiGridListSetItemColor(Grid[1], row2, 3, r2, g2, b2)
	end
	if(slot1 ~= "N/A") and (getElementData(slot1, "fGPS") == true) then
		guiGridListSetItemColor(Grid[1], row1, 1, r1, g1, b1)
		guiGridListSetItemColor(Grid[1], row1, 2, r1, g1, b1)
		guiGridListSetItemColor(Grid[1], row1, 3, r1, g1, b1)
	end
	-- GPS
	if(slot5 ~= "N/A") then
		if(getElementData(slot5, "fGPS") == true) then
			if(isElement(vehblip[5])) then destroyElement(vehblip[5]) killTimer(vehbliptimer[5]) end
			local x, y, z = getElementPosition(slot5)
			vehblip[5] = createBlip(x, y, z, 0, 2, r5, g5, b5, 255, 0, 99999.0)
			vehbliptimer[5] = setTimer(function() destroyElement(vehblip[5]) end, 5000, 1)
		end
	end	
	if(slot4 ~= "N/A") then
		if(getElementData(slot4, "fGPS") == true) then
			if(isElement(vehblip[4])) then destroyElement(vehblip[4]) killTimer(vehbliptimer[4]) end
			local x, y, z = getElementPosition(slot4)
			vehblip[4] = createBlip(x, y, z, 0, 2, r4, g4, b4, 255, 0, 99999.0)
			vehbliptimer[4] = setTimer(function() destroyElement(vehblip[4]) end, 5000, 1)
		end
	end	
	if(slot3 ~= "N/A") then
		if(getElementData(slot3, "fGPS") == true) then
			if(isElement(vehblip[3])) then destroyElement(vehblip[3]) killTimer(vehbliptimer[3]) end
			local x, y, z = getElementPosition(slot3)
			vehblip[3] = createBlip(x, y, z, 0, 2, r3, g3, b3, 255, 0, 99999.0)
			vehbliptimer[3] = setTimer(function() destroyElement(vehblip[3]) end, 5000, 1)
		end
	end	
	if(slot2 ~= "N/A") then
		if(getElementData(slot2, "fGPS") == true) then
			if(isElement(vehblip[2])) then destroyElement(vehblip[2]) killTimer(vehbliptimer[2]) end
			local x, y, z = getElementPosition(slot2)
			vehblip[2] = createBlip(x, y, z, 0, 2, r2, g2, b2, 255, 0, 99999.0)
			vehbliptimer[2] = setTimer(function() destroyElement(vehblip[2]) end, 5000, 1)
		end
	end		
	if(slot1 ~= "N/A") then
		if(getElementData(slot1, "fGPS") == true) then
			if(isElement(vehblip[1])) then destroyElement(vehblip[1]) killTimer(vehbliptimer[1]) end
			local x, y, z = getElementPosition(slot1)
			vehblip[1] = createBlip(x, y, z, 0, 2, r1, g1, b1, 255, 0, 99999.0)
			vehbliptimer[1] = setTimer(function() destroyElement(vehblip[1]) end, 5000, 1)
		end
	end
	
end

bindKey("F3", "down",
function()
	if(Guivara == 1) then return end
	if(getElementData(gMe, "inLogin") == true) then return end
	showAutoListGui()
end)
bindKey("F3", "up",
function()
	if(Guivara == 0) then return end
	destroyElement(FensterAG[1])
	Guivara = 0
end)
