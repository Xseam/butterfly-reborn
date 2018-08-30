local Guivar = 0

local objects = {
	[1] = "1344, Muelltonne 1",
	[2] = "1349, Einkaufswagen",
	[3] = "913, Schrank",
	[4] = "1763, Sofa 1",
	[5] = "1439, Muelltonne 2",
	[6] = "1372, Mueltonne 3",
	[7] = "1215, Lampe",
	[8] = "2912, Kiste",
	[9] = "2972, Palette",
	[10] = "1370, Gasflasche",
	[11] = "1676, Tankstelle",
	[12] = "2780, Nebelmaschine",
	[13] = "1225, Benzinfass",
	[14] = "3065, Basketball",
	[15] = "2976, Gruenes Teil",
	[16] = "2918, Koralle",
	[17] = "3786, Rakete",
	[18] = "1459, Strassensperre",
	[19] = "1422, Blockade",
	[20] = "1208, Waschmaschine",
	[21] = "1481, Grill",
	[22] = "1748, Fernsehr",
	[23] = "1801, Bett",
	[24] = "2103, Stereoanlage",
	[25] = "2190, Computer",
	[26] = "2415, Frittierer",
	[27] = "1704, Sessel",
	[28] = "1723, Sofa",
	[29] = "2008, Computertisch",
	[30] = "2964, Billiardtisch",
	[31] = "2919, Tasche",
	[32] = "1646, Liege 1",
	[33] = "1255, Liege 2"
}

	local APFenster = {}
function createNotAdminPanel()
	if(Guivar == 1) then return end
	if(getElementData(gMe, "Clicked") == 1) then return end
	setElementData(gMe, "Clicked", 1)
	guiSetInputMode("no_binds_when_editing")
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)


	local APKnopf = {}
	local APEdit = {}
	local APGrid = {}
	local APTabPanel = {}
	local APTab = {}
	local APLabel = {}
	local APRadio = {}
	local APCheckbox = {}
	
	
	local X, Y, Width, Height = getMiddleGuiPosition(518,305)
	APFenster[1] = guiCreateWindow(X, Y, Width, Height,"Management",false)
	APTabPanel[1] = guiCreateTabPanel(9,21,500,275,false,APFenster[1])
	APTab[1] = guiCreateTab("Funktionen",APTabPanel[1])
	APTab[2] = guiCreateTab("Spielerliste",APTabPanel[1])
	APTab[3] = guiCreateTab("Objekte",APTabPanel[1])
	APTab[4] = guiCreateTab("Fraktionen", APTabPanel[1])
	APTab[5] = guiCreateTab("Maps",APTabPanel[1])
	

	-- Tab 1 --
	--[[
	1 - Kicken
	2 - Bannen
	3 - Leader
	4 - Rang
	5 - Bankgeld
	6 - Handgeld
	7 - Handgeld Geben
	8 - Freezen
	9 - Zu Spieler Porten
	10 - Spieler Herporten
	11 - Waffen geben
	12 - INT Setzen
	13 - DIM Setzen
	14 - Ob. Spawnen
	15 - Obs. Respawnen
	16 - Obs. Loeschen
	17 - Autos Respawnen
	18 - Haussystem Restarten
	19 - Gamemode Restarten
	20 - Notabschalten
	--]]
	APKnopf[1] = guiCreateButton(153,48,95,38,"Kicken",false,APTab[1])
	APKnopf[2] = guiCreateButton(252,48,95,38,"Bannen",false,APTab[1])
	APEdit[1] = guiCreateEdit(151,15,171,25,"Grund",false,APTab[1])
	APEdit[2] = guiCreateEdit(330,15,110,24,"Zeit",false,APTab[1])
	APKnopf[3] = guiCreateButton(153,92,95,38,"Leader ernennen ->",false,APTab[1])
	APEdit[3] = guiCreateEdit(253,92,43,38,"ID",false,APTab[1])
	APKnopf[4] = guiCreateButton(300,92,95,38,"<- Fraktionsrang setzen",false,APTab[1])
	APKnopf[5] = guiCreateButton(153,135,95,38,"Bankgeld\nsetzen ->",false,APTab[1])
	APKnopf[6] = guiCreateButton(301,137,95,38,"<- Handgeld setzen",false,APTab[1])
	APEdit[4] = guiCreateEdit(254,135,43,38,"BG",false,APTab[1])
	APKnopf[7] = guiCreateButton(400,136,95,38,"Handgeld Geben",false,APTab[1])
	APEdit[5] = guiCreateEdit(399,92,80,39,"Menge",false,APTab[1])
	APKnopf[8] = guiCreateButton(350,48,95,38,"Freezen",false,APTab[1])
	APKnopf[9] = guiCreateButton(152,175,95,38,"Zu Spieler Porten",false,APTab[1])
	APKnopf[10] = guiCreateButton(254,176,95,38,"Spieler herporten",false,APTab[1])
	APKnopf[11] = guiCreateButton(354,176,95,38,"Waffe Geben: ",false,APTab[1])
	APEdit[6] = guiCreateEdit(451,177,43,38,"",false,APTab[1])
	APEdit[7] = guiCreateEdit(409,216,78,25,"Anzahl",false,APTab[1])
	APKnopf[12] = guiCreateButton(153,216,105,25,"INT Setzen ->",false,APTab[1])
	APEdit[8] = guiCreateEdit(263,216,47,25,"interiorid",false,APTab[1])
	APKnopf[13] = guiCreateButton(313,215,91,26,"<- Dim. Setzen",false,APTab[1])
	--APKnopf[14] = guiCreateButton(450,61,53,22,"[X]",false,APTab[1])
	APGrid[1] = guiCreateGridList(8,7,132,238,false,APTab[1])
	guiGridListSetSelectionMode(APGrid[1],2)

	guiGridListAddColumn(APGrid[1],"Spielername",0.8)
	
	guiGridListClear(APGrid[1]) for index, spieler in pairs(getElementsByType("player")) do guiGridListSetItemText(APGrid[1], guiGridListAddRow(APGrid[1]), 1, getPlayerName(spieler), false, false) end
	-- Tab 2 --
	APGrid[2] = guiCreateGridList(6,5,490,240,false,APTab[2])
	guiGridListSetSelectionMode(APGrid[2],1)

	guiGridListAddColumn(APGrid[2],"Spieler",0.3)

	guiGridListAddColumn(APGrid[2],"Fraktion",0.17)

	guiGridListAddColumn(APGrid[2],"Handgeld",0.17)

	guiGridListAddColumn(APGrid[2],"Bankgeld",0.17)

	guiGridListAddColumn(APGrid[2],"Wanteds",0.1)

	local function reloadPlayerlist()
		guiGridListClear(APGrid[2])
		for index, spieler in pairs(getElementsByType("player")) do
			local row = guiGridListAddRow(APGrid[2])
			local name = getPlayerName(spieler)
			local fraktion = getPlayerFraktion(spieler)
			if(fraktion) then
				fraktion = fraktionNamen[fraktion]
				if(fraktion) then else fraktion = "N/A" end
			else
				fraktion = "N/A"
			end
			local handgeld = tonumber(getElementData(spieler, "pHGeld"))
			if(handgeld) then else handgeld = "N/A" end
			local bankgeld = tonumber(getElementData(spieler, "pBGeld"))
			if(bankgeld) then else bankgeld = "N/A" end
			local wanteds = tonumber(getElementData(spieler, "pWanteds"))
			if(wanteds) then else wanteds = "N/A" end
			guiGridListSetItemText(APGrid[2], row, 1, name, false, false)
			guiGridListSetItemText(APGrid[2], row, 2, fraktion, false, false)
			guiGridListSetItemText(APGrid[2], row, 3, handgeld.."$", false, false)
			guiGridListSetItemText(APGrid[2], row, 4, bankgeld.."$", false, false)
			guiGridListSetItemText(APGrid[2], row, 5, wanteds, false, false)
		end
	end
	reloadPlayerlist()
	-- Tab 3 --
	
	APGrid[3] = guiCreateGridList(7,6,193,234,false,APTab[3])
	guiGridListSetSelectionMode(APGrid[3],1)

	guiGridListAddColumn(APGrid[3],"Objektname",0.6)

	guiGridListAddColumn(APGrid[3],"ID",0.2)
	APKnopf[14] = guiCreateButton(209,21,129,36,"Ausgewaehltes Objekt\nSpawnen",false,APTab[3])
	APKnopf[15] = guiCreateButton(209,68,129,36,"Objekte Respawnen",false,APTab[3])
	APKnopf[16] = guiCreateButton(208,112,129,36,"Gespawnte Objekte\nLoeschen",false,APTab[3])
	local objects1 = 0
	local objects2 = 0
	for index, ob in pairs(getElementsByType("object")) do
		if(getElementData(ob, "O_MOVEABLE") == true) then objects1 = objects1+1 end
		if(getElementData(ob, "O_MOVEABLE2") == true) then objects2 = objects2+1 end
	end
	for i = 1, #objects, 1 do
		local id, name = tonumber(gettok(objects[i], 1, ",")),gettok(objects[i], 2, ",")
		local row = guiGridListAddRow(APGrid[3])
		guiGridListSetItemText(APGrid[3], row, 1, name, false, false) 
		guiGridListSetItemText(APGrid[3], row, 2, id, false, false) 
	end
	APLabel[1] = guiCreateLabel(349,49,129,122,"Zurzeit Gespawnte \nObjekte:\n"..objects2.."\n\nDynamische Objekte:\n"..objects1,false,APTab[3])
	guiSetFont(APLabel[1],"default-bold-small")
	APLabel[2] = guiCreateLabel(344,29,130,18,"_____________",false,APTab[3])
	guiLabelSetColor(APLabel[2],0, 255, 255)
	guiSetFont(APLabel[2],"default-bold-small")
		addEventHandler("onClientGUIClick", APKnopf[16],
	function()
		triggerServerEvent("onNotAdminPanelObjectDelete", gMe)
	end, false)	
	addEventHandler("onClientGUIClick", APKnopf[15],
	function()
		triggerServerEvent("onNotAdminPanelObjectRespawn", gMe)
	end, false)	
	
	addEventHandler("onClientGUIClick", APKnopf[14],
	function()
		local idlol = guiGridListGetItemText ( APGrid[3], guiGridListGetSelectedItem(APGrid[3], 2), 2 )
		if not(idlol) then return end
		triggerServerEvent("onNotAdminPanelObjectCreate", gMe, idlol)
	end, false)	
	-- Tab 4 --
	
	APLabel[3] = guiCreateLabel(12,10,80,17,"Respawnen:",false,APTab[4])
	guiSetFont(APLabel[3],"default-bold-small")
	APLabel[4] = guiCreateLabel(12,15,80,17,"____________",false,APTab[4])
	guiLabelSetColor(APLabel[4],0, 255, 255)
	APRadio[1] = guiCreateRadioButton(13,37,120,26,"Noobspawn",false,APTab[4])
	guiSetFont(APRadio[1],"default-bold-small")
	APRadio[2] = guiCreateRadioButton(13,58,120,26,"Freecars",false,APTab[4])
	guiSetFont(APRadio[2],"default-bold-small")
	APRadio[3] = guiCreateRadioButton(13,77,120,26,"Yakuza",false,APTab[4])
	guiSetFont(APRadio[3],"default-bold-small")
	APRadio[4] = guiCreateRadioButton(13,99,120,26,"Terroristen",false,APTab[4])
	guiSetFont(APRadio[4],"default-bold-small")
	APRadio[5] = guiCreateRadioButton(13,118,120,26,"Fahrschule",false,APTab[4])
	guiSetFont(APRadio[5],"default-bold-small")
	APRadio[6] = guiCreateRadioButton(13,138,120,26,"RCPD",false,APTab[4])
	guiSetFont(APRadio[6],"default-bold-small")
	APRadio[7] = guiCreateRadioButton(13,157,120,26,"RCNR",false,APTab[4])
	guiSetFont(APRadio[7],"default-bold-small")
	APRadio[8] = guiCreateRadioButton(13,176,120,26,"Red Brothers",false,APTab[4])
	guiSetFont(APRadio[8],"default-bold-small")
	APRadio[9] = guiCreateRadioButton(13,194,120,26,"FBI",false,APTab[4])
	guiSetFont(APRadio[9],"default-bold-small")
	APRadio[10] = guiCreateRadioButton(13,213,120,26,"Frei",false,APTab[4])
	guiSetFont(APRadio[10],"default-bold-small")
	APKnopf[17] = guiCreateButton(135,39,109,33,"Respawnen",false,APTab[4])
	guiSetFont(APKnopf[17],"default-bold-small")
	APLabel[5] = guiCreateLabel(137,109,207,71,"Fraktionsinfos:\n\nMitglieder Online: 0\nFraktionsautos: -",false,APTab[4])
	guiSetFont(APLabel[5],"default-bold-small")
	APLabel[6] = guiCreateLabel(136,88,80,17,"____________",false,APTab[4])
	guiLabelSetColor(APLabel[6],0,255,255)
	APLabel[7] = guiCreateLabel(131,78,80,17,"Respawnen:",false,APTab[4])
	guiSetFont(APLabel[7],"default-bold-small")
	APLabel[8] = guiCreateLabel(257,10,117,26,"Anderes:",false,APTab[4])
	guiSetFont(APLabel[8],"default-bold-small")
	APLabel[9] = guiCreateLabel(255,15,80,17,"____________",false,APTab[4])
	guiLabelSetColor(APLabel[9],0,255,255)
	APKnopf[18] = guiCreateButton(260,40,111,33,"Haussystem Restarten",false,APTab[4])
	APLabel[10] = guiCreateLabel(376,34,105,101,"Warnung: Haeuser \nkoennen bei zu often\nRestarten verloren\nGehen!\n\n\nNur Bei notfaellen.",false,APTab[4])
	guiSetFont(APLabel[10],"default-bold-small")
	APKnopf[19] = guiCreateButton(258,106,111,33,"Gamemode Restarten",false,APTab[4])
	APKnopf[20] = guiCreateButton(258,147,111,33,"Notabschaltug",false,APTab[4])
	APCheckbox[1] = guiCreateCheckBox(381,151,110,23,"Sicher?",false,false,APTab[4])
	guiSetFont(APCheckbox[1],"default-bold-small")
	
	addEventHandler("onClientGUIClick", APKnopf[20],
	function()
		if(guiCheckBoxGetSelected(APCheckbox[1]) == false) then outputChatBox("Du musst die Notabschaltung Bestaetigen!", 200, 0, 0) return end
		triggerServerEvent("onNotAdminPanelNotabschaltung", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[19],
	function()
		triggerServerEvent("onNotAdminPanelGamemoderestart", gMe)
	end, false)
	addEventHandler("onClientGUIClick", APKnopf[18],
	function()
		triggerServerEvent("onNotAdminPanelHouserestart", gMe)
	end, false)
	addEventHandler("onClientGUIClick", APKnopf[17],
	function()
		local radio = {}
		for i = 1, #APRadio, 1 do
			radio[i] = guiRadioButtonGetSelected(APRadio[i])
		end
		if(radio[1] == true) then
			triggerServerEvent("onNoobspawnCarsRespawn", gMe)
		elseif(radio[2] == true) then
			--triggerServerEvent("onNoobspawnCarsRespawn", gMe)
			outputChatBox("Die werden eh noch entfernt.", 0, 200, 200)
		elseif(radio[3] == true) then
			triggerServerEvent("onYakuzaCarRespawnAD", gMe)
		elseif(radio[4] == true) then
			triggerServerEvent("onTerrorCarRespawnAD", gMe)
		elseif(radio[5] == true) then
			triggerServerEvent("onFahrschulCarRespawnAD", gMe)
		elseif(radio[7] == true) then
			triggerServerEvent("onrcnrCarRespawnAD", gMe)
		elseif(radio[6] == true) then
			triggerServerEvent("onrcpdCarRespawnAD", gMe)
		elseif(radio[8] == true) then
			triggerServerEvent("onTerrorCarRespawnAD", gMe)
		elseif(radio[9] == true) then		
			triggerServerEvent("onFBICarRespawnAD", gMe)
		elseif(radio[10] == true) then
			--triggerServerEvent("onTerrorCarRespawnAD", gMe)
		end
	end, false)
	-- Tab 5 --
	
	APGrid[4] = guiCreateGridList(8,10,187,230,false,APTab[5])
	guiGridListSetSelectionMode(APGrid[4],1)

	guiGridListAddColumn(APGrid[4],"Resourcenname",0.48)
	guiGridListAddColumn(APGrid[4],"Gestartet?",0.25)
	APKnopf[21] = guiCreateButton(213,21,117,33,"Resource Starten",false,APTab[5])
	APKnopf[22] = guiCreateButton(213,61,117,33,"Resource Stoppen",false,APTab[5])
	APKnopf[23] = guiCreateButton(214,101,117,33,"Resource Restarten",false,APTab[5])
	--[[for i = 1, #resourcen, 1 do
		local row = guiGridListAddRow(APGrid[4])
		local name = resourcen[i]
		guiGridListSetItemText(APGrid[4], row, 1, name, false, false)
		local resname = resourcenNamen[name]
		
		
	end--]]
	addEventHandler("onClientGUIClick", APKnopf[23], function() -- Stoppen
		local item = guiGridListGetItemText(APGrid[4], guiGridListGetSelectedItem(APGrid[4]), 1)
		if(item == "") or (item == " ") then return end
		triggerServerEvent("onNotAdminPanelResourceRestart", gMe, item)
	end, false)
	addEventHandler("onClientGUIClick", APKnopf[22], function() -- Stoppen
		local item = guiGridListGetItemText(APGrid[4], guiGridListGetSelectedItem(APGrid[4]), 1)
		if(item == "") or (item == " ") then return end
		triggerServerEvent("onNotAdminPanelResourceStop", gMe, item)
	end, false)
	addEventHandler("onClientGUIClick", APKnopf[21], function() -- Starten
		local item = guiGridListGetItemText(APGrid[4], guiGridListGetSelectedItem(APGrid[4]), 1)
		if(item == "") or (item == " ") then return end
		triggerServerEvent("onNotAdminPanelResourceStart", gMe, item)
	end, false)

	triggerServerEvent("onNotAdminPanelResourcenGet", gMe)
	guiGridListClear(APGrid[4])
	addEvent("onNotAdminPanelResourcenGetBack", true)
	addEventHandler("onNotAdminPanelResourcenGetBack", getRootElement(), function(name, state)
		local row = guiGridListAddRow(APGrid[4])
		guiGridListSetItemText(APGrid[4], row, 1, name, false, false)
		guiGridListSetItemText(APGrid[4], row, 2, state, false, false)
	end)

	addEvent("onNotAdminPanelResourcenUpdate", true)
	addEventHandler("onNotAdminPanelResourcenUpdate", getRootElement(), function(name, state)
		guiGridListClear(APGrid[4])	
		triggerServerEvent("onNotAdminPanelResourcenGet", gMe)
	end)
	-- Anderes --
	local cv = 0
	for i = 1, 8, 1 do
		cv = cv+1
		addEventHandler("onClientGUIClick", APEdit[cv], function() guiSetText(source, "") end, false)
	end
	addEventHandler("onClientGUIClick", APKnopf[13],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local id = tonumber(guiGetText(APEdit[8]))
		triggerServerEvent("onNotAdminPanelDIM", gMe, playa, id)
	end, false)	
	addEventHandler("onClientGUIClick", APKnopf[12],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local id = tonumber(guiGetText(APEdit[8]))
		triggerServerEvent("onNotAdminPanelINT", gMe, playa, id)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[11],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local id = tonumber(guiGetText(APEdit[6]))
		local anzahl = tonumber(guiGetText(APEdit[7]))
		triggerServerEvent("onNotAdminPanelWaffeGeb", gMe, playa, id, anzahl)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[10],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		triggerServerEvent("onNotAdminPanelPorteHer", gMe, playa)
	end, false)
	
	
	addEventHandler("onClientGUIClick", APKnopf[9],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		triggerServerEvent("onNotAdminPanelzuPorte", gMe, playa)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[7],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local text = tonumber(guiGetText(APEdit[5]))
		triggerServerEvent("onNotAdminPanelHandGeldGebe", gMe, playa, text)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[6],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local text = tonumber(guiGetText(APEdit[4]))
		triggerServerEvent("onNotAdminPanelHandGeld", gMe, playa, text)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[5],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local text = tonumber(guiGetText(APEdit[4]))
		triggerServerEvent("onNotAdminPanelBankGeld", gMe, playa, text)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[4],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local id = tonumber(guiGetText(APEdit[3]))
		triggerServerEvent("onNotAdminPanelRang", gMe, playa, id)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[3],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		local id = tonumber(guiGetText(APEdit[3]))
		triggerServerEvent("onNotAdminPanelLeader", gMe, playa, id)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[8],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		if not(getPlayerFromName(playa)) then return end
		triggerServerEvent("onNotAdminPanelFreeze", gMe, playa)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[2],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		local grund = guiGetText(APEdit[1])
		local zeit = tonumber(guiGetText(APEdit[2]))
		if not(getPlayerFromName(playa)) then return end
		if(grund == " ") or (grund == "") then grund = "N/A" end
		triggerServerEvent("onNotAdminPanelBan", gMe, playa, grund, zeit)
	end, false)
	
	addEventHandler("onClientGUIClick", APKnopf[1],
	function()
		local playa = guiGridListGetItemText ( APGrid[1], guiGridListGetSelectedItem(APGrid[1], 1 )) if(playa == " ") or (playa == "") then return end
		local grund = guiGetText(APEdit[1])
		if not(getPlayerFromName(playa)) then return end
		if(grund == " ") or (grund == "") then grund = "N/A" end
		triggerServerEvent("onNotAdminPanelKick", gMe, playa, grund)
	end, false)
	
	
	local function giveRights()
		for i = 1, #APKnopf, 1 do
			guiSetEnabled(APKnopf[i], false)
		end
		local function setAn(int)
			guiSetEnabled(APKnopf[int], true)
		end
		local function setAllAn()
			for i = 1, #APKnopf, 1 do
				guiSetEnabled(APKnopf[i], true)
			end
		end
		
		local adminlevel = tonumber(getElementData(gMe, "pAdminlevel"))
		--[[
			1 - Kicken
			2 - Bannen
			3 - Leader
			4 - Rang
			5 - Bankgeld
			6 - Handgeld
			7 - Handgeld Geben
			8 - Freezen
			9 - Zu Spieler Porten
			10 - Spieler Herporten
			11 - Waffen geben
			12 - INT Setzen
			13 - DIM Setzen
			14 - Ob. Spawnen
			15 - Obs. Respawnen
			16 - Obs. Loeschen
			17 - Autos Respawnen
			18 - Haussystem Restarten
			19 - Gamemode Restarten
			20 - Notabschalten
	--]]
		if(adminlevel > 0) then -- Clanmitglied
			setAn(12)
			setAn(13)
		end
		if(adminlevel > 1) then -- Mod
			setAn(1)
			setAn(2)
			setAn(5)
			setAn(6)
			setAn(7)
			setAn(8)
			setAn(9)
			setAn(10)
			setAn(14)
			setAn(15)
			setAn(16)
			setAn(17)
		end
		if(adminlevel > 2) then -- Super mod
			setAn(11)
			setAn(18)
		end
		if(adminlevel > 3) then -- Admin
			setAn(19)
			setAn(20)
			setAn(3)
			setAn(4)
		end
		if(adminlevel > 4) then -- Leiter
			setAllAn()
		end
		
	end
	giveRights()
	
end


addCommandHandler("panel", 
function()
	local data = tonumber(getElementData(gMe, "pAdminlevel"))
	if(data < 1) then outputChatBox("Du hast keine Rechte, das Adminpanel zu oeffnen.", 255, 0, 0, false) return end
	if(Guivar == 0) then
		createNotAdminPanel()
	else
		guiSetVisible(APFenster[1], false)
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end
end)