local Guivar = 0

	local NPCFenster = {}
	local NPCKnopf = {}
	local NPCLabel = {}
	local NPCEdit = {}
	local NPCGrid = {}
	local NPCBild = {}
	
function createNewsPCGui()
if(Guivar == 1) then return end
	if(getElementData(gMe, "Clicked") == 1) then return end
	setElementData(gMe, "Clicked", 1)
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	setElementData(gMe, "Clicked", 1)


		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 536,470
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)

	NPCFenster[1] = guiCreateWindow(X, Y, Width, Height, "Newscomputer",false)
	NPCBild[1] = guiCreateStaticImage(9,20,472,94,"data/images/rcnr.png",false,NPCFenster[1])
	NPCLabel[1] = guiCreateLabel(4,101,529,28,"______________________________________________________________________________",false,NPCFenster[1])
	NPCGrid[1] = guiCreateGridList(9,131,162,330,false,NPCFenster[1])
	guiGridListSetSelectionMode(NPCGrid[1],2)

	guiGridListAddColumn(NPCGrid[1],"Spieler",0.7)
	guiGridListClear(NPCGrid[1])
	for index, spieler in pairs(getElementsByType("player")) do
		local row = guiGridListAddRow(NPCGrid[1])
		local name = getPlayerName(spieler)
		guiGridListSetItemText(NPCGrid[1], row, 1, name, false, false)
	end
	NPCLabel[2] = guiCreateLabel(180,138,105,27,"Aktionen:",false,NPCFenster[1])
	guiSetFont(NPCLabel[2],"default-bold-small")
	NPCLabel[3] = guiCreateLabel(181,145,105,27,"____________________",false,NPCFenster[1])
	guiLabelSetColor(NPCLabel[3],0, 255, 255)
	guiSetFont(NPCLabel[3],"default-bold-small")
	NPCKnopf[1] = guiCreateButton(178,170,118,32,"Live-Interview Starten",false,NPCFenster[1])
	NPCKnopf[2] = guiCreateButton(299,170,118,32,"Live-Interview Beenden",false,NPCFenster[1])
	NPCLabel[4] = guiCreateLabel(182,294,110,20,"____________________",false,NPCFenster[1])
	guiLabelSetColor(NPCLabel[4],0,255,255)
	guiSetFont(NPCLabel[4],"default-bold-small")
	NPCKnopf[3] = guiCreateButton(239,249,118,32,"Kamera Anfordern",false,NPCFenster[1])
	NPCLabel[5] = guiCreateLabel(182,287,105,27,"Intern:",false,NPCFenster[1])
	guiSetFont(NPCLabel[5],"default-bold-small")
	NPCLabel[6] = guiCreateLabel(182,383,128,17,"Fraktionschat Posten:",false,NPCFenster[1])
	guiSetFont(NPCLabel[6],"default-bold-small")
	NPCEdit[1] = guiCreateEdit(181,404,315,26,"",false,NPCFenster[1])
	NPCKnopf[4] = guiCreateButton(391,433,107,28,"Posten",false,NPCFenster[1])
	NPCKnopf[5] = guiCreateButton(391,372,107,28,"Posten",false,NPCFenster[1])
	NPCLabel[7] = guiCreateLabel(182,322,104,15,"Newschat Posten:",false,NPCFenster[1])
	guiSetFont(NPCLabel[7],"default-bold-small")
	NPCEdit[2] = guiCreateEdit(181,343,315,26,"",false,NPCFenster[1])
	NPCKnopf[6] = guiCreateButton(238,209,118,32,"Person hinzufuegen",false,NPCFenster[1])
	
	addEventHandler("onClientGUIClick", NPCKnopf[3], -- Kamera
	function()
		triggerServerEvent("onFraktionsNewsKameraAnforder", gMe)
		
	end, false)
	
	addEventHandler("onClientGUIClick", NPCKnopf[4], -- Newschat
	function()
		local text = guiGetText(NPCEdit[1])
		if(text == " ") or (text == "") then return end
		triggerServerEvent("onFraktionsNewsChatPost", gMe, text)
		guiSetText(NPCEdit[1], "")
	end, false)
	
	addEventHandler("onClientGUIClick", NPCKnopf[5], -- Fraktionschat
	function()
		local text = guiGetText(NPCEdit[2])
		if(text == " ") or (text == "") then return end
		triggerServerEvent("onNewsChatPost", gMe, text)
		guiSetText(NPCEdit[2], "")
	end, false)
	
	addEventHandler("onClientGUIClick", NPCKnopf[6],
	function()
		local data = getElementData(gMe, "LIVEM")
		if(data == false) or(data == nil) then outputChatBox("Du bist kein Interview-Master oder in keinem Interview!", 255, 0, 0, false) return end
		local player = guiGridListGetItemText ( NPCGrid[1], guiGridListGetSelectedItem ( NPCGrid[1] ), 1 )
		if(player == " ") or (player == "") then outputChatBox("Du musst einen Spieler auswaehlen!", 200, 0, 0, false) return end
		local player = getPlayerFromName(player)
		if not(player) then outputChatBox("Spieler nicht online!", 200, 0, 0, false) return end
		triggerServerEvent("onNewsReporterInterviewEinlad", gMe, player)
		
	end, false)
	
	addEventHandler("onClientGUIClick", NPCKnopf[2],
	function()
		local data = getElementData(gMe, "LIVEM")
		local data2 = getElementData(gMe, "LIVE")
		if(data == false) or(data == nil)then outputChatBox("Du bist in keinem Interview!", 255, 0, 0, false) return end
		setElementData(gMe, "LIVEM", false)
		outputChatBox("Du hast den Live-Modus verlassen. Alle Live-Mitglieder wurden entlived.", 0, 255, 0, false)
		for index, player in pairs(getElementsByType("player")) do
			if(getElementData(player, "LIVE") == true) then
				setElementData(player, "LIVE", false)
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", NPCKnopf[1],
	function()
		local data = getElementData(gMe, "LIVEM")
		local data2 = getElementData(gMe, "LIVE")
		if(data == true) or(data2 == true) then outputChatBox("Du bist bereits in einem Interview!", 255, 0, 0, false) return end
		--[[
		local player = guiGridListGetItemText ( NPCGrid[1], guiGridListGetSelectedItem ( NPCGrid[1] ), 1 )
		if(player == " ") or (player == "") then outputChatBox("Du musst einen Spieler auswaehlen!", 200, 0, 0, false) return end
		local player = getPlayerFromName(player)
		if not(player) then outputChatBox("Spieler nicht online!", 200, 0, 0, false) return end
		triggerServerEvent("onNewsReporterInterviewStart", gMe, player)
		--]]
		setElementData(gMe, "LIVEM", true)
		outputChatBox("Du bist nun Live! Du kannst nun andere Leute einladen.", 0, 255, 0, false)
		
	end, false)
end

local keyvar = 0

bindKey("F5", "down",
function()
	if(keyvar == 0) then
		local veh = getPedOccupiedVehicle(gMe)
		if not(veh) then return end
		if(isANewsVan(veh) == false) then return end
		keyvar = 1
		createNewsPCGui()
	elseif(keyvar == 1) then
		setElementData(gMe, "Clicked", 0)
		keyvar = 0
		destroyElement(NPCFenster[1])
		Guivar = 0
		showCursor(false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		setElementData(gMe, "Clicked", 0)
	end
end)

function isANewsVan(vehicle)
	if not(vehicle) then return end
	if(getElementData(vehicle, "Besitzer") == "RCNR") then return true; end
	if(getElementModel(vehicle) == 582) or (getElementModel(vehicle) == 488) then return true; end
	return false;
end