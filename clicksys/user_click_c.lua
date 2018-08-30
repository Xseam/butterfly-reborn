local Guivar = 0
local Guivar2 = 0


function createUserFensterWindow(player)
if(Guivar == 1) then return end
if not(player) then return end
	if(getElementData(gMe, "Clicked") == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 524,197
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	local PLFenster = {}
	local PLKnopf = {}
	local PLLabel = {}
	local PLEdit = {}
	PLGrid = {}
	
	local name = getPlayerName(player)
	local zeit = getElementData(player, "pSpielzeit")
	if not(zeit) then zeit = "N/A" end
	local fraktion = fraktionNamen[tonumber(getElementData(player, "pFraktion"))]
	if not(fraktion) then fraktion = "N/A" end
	local status = getElementData(player, "pStatus")
	if not(status) then status = "N/A" end
	local myFraktion = getPlayerFraktion(gMe)
	
	
	PLFenster[1] = guiCreateWindow(X, Y, Width, Height, "Usermenue",false)
	PLLabel[1] = guiCreateLabel(26,45,144,29,"Spielername:\n"..name,false,PLFenster[1])
	guiSetFont(PLLabel[1],"default-bold-small")
	PLLabel[2] = guiCreateLabel(25,78,154,15,"Spielzeit: "..zeit,false,PLFenster[1])
	guiSetFont(PLLabel[2],"default-bold-small")
	PLLabel[3] = guiCreateLabel(25,96,114,29,"Fraktion:\n"..fraktion,false,PLFenster[1])
	guiSetFont(PLLabel[3],"default-bold-small")
	PLLabel[4] = guiCreateLabel(14,18,116,18,"Allgemein:",false,PLFenster[1])
	guiSetFont(PLLabel[4],"default-bold-small")
	PLLabel[5] = guiCreateLabel(15,24,116,18,"_____________________",false,PLFenster[1])
	guiLabelSetColor(PLLabel[5],0, 255, 255)
	guiSetFont(PLLabel[5],"default-bold-small")
	PLLabel[6] = guiCreateLabel(24,126,114,29,"Status:\n"..status,false,PLFenster[1])
	guiSetFont(PLLabel[6],"default-bold-small")
	PLKnopf[1] = guiCreateButton(22,162,111,21,"Schliessen",false,PLFenster[1])
	PLLabel[7] = guiCreateLabel(208,17,116,18,"Interaktion:",false,PLFenster[1])
	guiSetFont(PLLabel[7],"default-bold-small")
	PLLabel[8] = guiCreateLabel(205,20,116,18,"_____________________",false,PLFenster[1])
	guiLabelSetColor(PLLabel[8],0,255,255)
	guiSetFont(PLLabel[8],"default-bold-small")
	PLGrid[1] = guiCreateGridList(205,39,203,149,false,PLFenster[1])
	guiGridListSetSelectionMode(PLGrid[1],1)

	guiGridListAddColumn(PLGrid[1],"Item",0.6)

	guiGridListAddColumn(PLGrid[1],"Anzahl",0.2)
	PLKnopf[2] = guiCreateButton(415,79,98,29,"Geben",false,PLFenster[1])
	PLKnopf[3] = guiCreateButton(415,114,98,29,"Zeigen",false,PLFenster[1])
	PLEdit[1] = guiCreateEdit(414,44,99,29,"",false,PLFenster[1])
	PLLabel[9] = guiCreateLabel(438,24,56,14,"Anzahl:",false,PLFenster[1])
	guiSetFont(PLLabel[9],"default-bold-small")
	if(myFraktion == 4) then
		PLKnopf[4] = guiCreateButton(415,150,98,29,"Fraktion...",false,PLFenster[1])
		addEventHandler("onClientGUIClick", PLKnopf[4],
		function()
			if(Guivar2 == 1) then return end
			Guivar2 = 1
			local Radios = {}
			local Knopf = {}
			local X, Y, Width, Height = getMiddleGuiPosition(320,103)
			local Fenster = guiCreateWindow(X, Y, Width, Height,"Polizei-Interaktion",false)
			Radios[1] = guiCreateRadioButton(12,21,111,22,"Waffenschein",false,Fenster)
			guiSetFont(Radios[1],"default-bold-small")
			Radios[2] = guiCreateRadioButton(12,44,111,22,"Fuehrerschein",false,Fenster)
			guiSetFont(Radios[2],"default-bold-small")
			Radios[3] = guiCreateRadioButton(12,65,111,22,"Angelschein",false,Fenster)
			guiSetFont(Radios[3],"default-bold-small")
			Radios[4] = guiCreateRadioButton(126,73,111,21,"Drogen/Mats",false,Fenster)
			guiSetFont(Radios[4],"default-bold-small")
			Radios[5] = guiCreateRadioButton(228,78,73,16,"Waffen",false,Fenster)
			guiRadioButtonSetSelected(Radios[5],true)
			Knopf[1] = guiCreateButton(123,23,95,24,"Abnehmen",false,Fenster)
			Knopf[2] = guiCreateButton(123,51,95,24,"Durchsuchen",false,Fenster)
			Knopf[3] = guiCreateButton(222,23,89,24,"Ticket Geben",false,Fenster)
			Knopf[4] = guiCreateButton(222,51,89,24,"Abbrechen",false,Fenster)
			addEventHandler("onClientGUIClick", Knopf[2],
			function()
				triggerServerEvent("onFraktionsClickAction", gMe, player, 3)
			end, false)
			addEventHandler("onClientGUIClick", Knopf[1],
			function()
				local radio = {}
				radio["Waffenschein"] = guiRadioButtonGetSelected(Radios[1])
				radio["Fuehrerschein"] = guiRadioButtonGetSelected(Radios[2])
				radio["Angelschein"] = guiRadioButtonGetSelected(Radios[3])
				radio["Drogen"] = guiRadioButtonGetSelected(Radios[4])
				radio["Waffen"] = guiRadioButtonGetSelected(Radios[5])
				if(radio["Waffenschein"] ==  true) then
					outputChatBox("Diese Funktion folgt.", 200, 0, 0, false)
				end
				if(radio["Fuehrerschein"] ==  true) then
					local data = tonumber(getElementData(player, "pFSchein"))
					if(data == 0) then outputChatBox("Dieser User hat kein Fuehrerschein!", 200,0, 0) return end
					triggerServerEvent("onFraktionsClickAction", gMe, player, 1)
				end
				if(radio["Angelschein"] ==  true) then
					local data = tonumber(getElementData(player, "pANGELSchein"))
					if(data == 0) then outputChatBox("Dieser User hat kein Angelschein!", 200,0, 0) return end
					triggerServerEvent("onFraktionsClickAction", gMe, player, 2)
				end
				if(radio["Drogen"] ==  true) then
					triggerServerEvent("onFraktionsClickAction", gMe, player, 4)
				end
				if(radio["Waffen"] ==  true) then
					triggerServerEvent("onFraktionsClickAction", gMe, player, 5)
				end
			end, false)
			addEventHandler("onClientGUIClick", Knopf[4],
			function()
				Guivar2 = 0
				guiSetVisible(Fenster, false)
			end, false)
		end, false)
	end
	loadInventarList_player()
	
	addEventHandler("onClientGUIClick", PLKnopf[2], -- Geben
	function()
	local item = guiGridListGetItemText ( PLGrid[1], guiGridListGetSelectedItem ( PLGrid[1] ), 1 )
	if(item == " ") or (item == "") then outputChatBox("Du musst ein Item auswaehlen!", 200, 0, 0, false) return end
	local text = tonumber(guiGetText(PLEdit[1]))
	if(text == nil) then return end
	if(item == "Handgeld") then
		local data = tonumber(getElementData(gMe, "pHGeld"))
		if(text > data) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		if(text < 0) then outputChatBox("Du kannst kein Minus-Geld geben!", 200, 0, 0) return end
		if(text > 500000) then outputChatBox("Du kannst nicht mehr als 500k geben!", 200, 0, 0) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, 1, player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Zigaretten") then
		local data = tonumber(getElementData(gMe, "pZigaretten"))
		if(text > data) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, 2, player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Erste-Hilfe Koffer") then
		local data = tonumber(getElementData(gMe, "pErstehilfe"))
		if(text > data) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, "Erstehilfe", player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Benzinkanister") then
		local data = tonumber(getElementData(gMe, "pKanister"))
		if(text > data) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, "Kanister", player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Bier") then
		local data = tonumber(getElementData(gMe, "pBiere"))
		if(text > data) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, 3, player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Drogen") then
		local misc = getElementData(gMe, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		if(text > drogen) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, 4, player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	elseif(item == "Materialien") then
		local misc = getElementData(gMe, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		if(text > mats) then outputChatBox("Ungueltige Menge!", 210, 0, 0, false) return end
		triggerServerEvent("onSpeicalActionPlayer_func_geben", gMe, 5, player, text)
		guiSetText(PLEdit[1], "")
		setTimer(loadInventarList_player, 500, 1)
	else
		outputChatBox("Dieses Item kannst du nicht Weitergeben.", 200, 0, 0, false)
	end
	end, false)
	
	addEventHandler("onClientGUIClick", PLKnopf[3], -- Zeigen
	function()
	local item = guiGridListGetItemText ( PLGrid[1], guiGridListGetSelectedItem ( PLGrid[1] ), 1 )
	if(item == " ") or (item == "") then outputChatBox("Du musst ein Item auswaehlen!", 200, 0, 0, false) return end
	if(item == "Handgeld") then
		triggerServerEvent("onSpeicalActionPlayer_func", gMe, 1, player)
	elseif(item == "Scheine") then
		triggerServerEvent("onSpeicalActionPlayer_func", gMe, 2, player)
	elseif(item == "Presseausweis") then
		triggerServerEvent("onSpeicalActionPlayer_func", gMe, 3, player)
	else
		outputChatBox("Dieses Item kannst du nicht Zeigen.", 200, 0, 0, false)
	end
	end, false)
	
	addEventHandler("onClientGUIClick", PLKnopf[1],
	function()
		if(Guivar2 == 1) then return end
		Guivar = 0
		guiSetVisible(PLFenster[1], false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end, false)


end


addEvent("onPlayerClicksys", true)
addEventHandler("onPlayerClicksys", getRootElement(),
function(player)
	if not(player) then return end
	if not(source == gMe) then return end
	createUserFensterWindow(player)
end)

function loadInventarList_player()
	guiGridListClear(PLGrid[1])
	local zigaretten = tonumber(getElementData(gMe, "pZigaretten"))
	local biere = tonumber(getElementData(gMe, "pBiere"))
	local handgeld = tonumber(getElementData(gMe, "pHGeld"))
	local presseausweis = tonumber(getElementData(gMe, "pPresseausweis"))
	local misc = getElementData(gMe, "pMISC")
	local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
	local kanister = tonumber(getElementData(gMe, "pKanister"))
	local erstehilfe = tonumber(getElementData(gMe, "pErstehilfe"))
	
	
	local row = guiGridListAddRow ( PLGrid[1] )
	guiGridListSetItemText(PLGrid[1],row,1,"Handgeld",false,false)
	guiGridListSetItemText(PLGrid[1],row,2,handgeld,false,false)	
	
	local row = guiGridListAddRow ( PLGrid[1] )
	guiGridListSetItemText(PLGrid[1],row,1,"Scheine",false,false)
	guiGridListSetItemText(PLGrid[1],row,2,"-",false,false)	
		
	if(zigaretten > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Zigaretten",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,zigaretten,false,false)	
	end
	if(biere > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Bier",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,biere,false,false)
	end
	if(presseausweis > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Presseausweis",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,"1",false,false)
	end
	if(drogen > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Drogen",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,drogen,false,false)
	end
	if(mats > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Materialien",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,mats,false,false)
	end
	if(kanister > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Benzinkanister",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,kanister,false,false)
	end
	if(erstehilfe > 0) then
		local row = guiGridListAddRow ( PLGrid[1] )
		guiGridListSetItemText(PLGrid[1],row,1,"Erste-Hilfe Koffer",false,false)
		guiGridListSetItemText(PLGrid[1],row,2,erstehilfe,false,false)
	end
end