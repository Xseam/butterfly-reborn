local HANDYFenster = {}
local HANDYKnopf = {}
local HANDYLabel = {}
local HANDYEdit = {}

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 316,156
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

HANDYFenster[1] = guiCreateWindow(X, Y, Width, Height, "Handynummer",false)
HANDYLabel[1] = guiCreateLabel(12,25,277,33,"Hier kannst du deine Handynummer beantragen!",false,HANDYFenster[1])
guiSetFont(HANDYLabel[1],"default-bold-small")
HANDYLabel[2] = guiCreateLabel(17,75,99,17,"Vorwahl: 01959 - ",false,HANDYFenster[1])
guiSetFont(HANDYLabel[2],"default-bold-small")
HANDYEdit[1] = guiCreateEdit(117,70,129,26,"",false,HANDYFenster[1])
guiEditSetMaxLength(HANDYEdit[1],6)
HANDYLabel[3] = guiCreateLabel(126,52,106,18,"6 Ziffern.",false,HANDYFenster[1])
guiSetFont(HANDYLabel[3],"default-bold-small")
HANDYKnopf[1] = guiCreateButton(9,120,90,27,"Abbrechen",false,HANDYFenster[1])
HANDYKnopf[2] = guiCreateButton(217,119,90,27,"Beantragen",false,HANDYFenster[1])

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function ()

	guiSetVisible(HANDYFenster[1],false)
	
end)

addEvent("onShopHandyKauf", true)
addEventHandler("onShopHandyKauf", getRootElement(),
function ()
	if(tonumber(getElementData(gMe, "pHandynummer")) ~= 0) then outputChatBox("Du hast bereits ein Handy!", 200, 0, 0, false) return end
	showCursor(true)
	guiSetVisible(HANDYFenster[1],true)
	local function beantragen ()
	
		local vorwahl = "01959"
		local nummer = guiGetText(HANDYEdit[1])
		
		if string.len(nummer) > 5 then
		
			if tonumber(nummer) == nil then outputChatBox("Du musst zahlen benutzen!",200,0,0) return end
	
				guiSetVisible(HANDYFenster[1],false)
				removeEventHandler("onClientGUIClick",HANDYKnopf[2],beantragen)
				showCursor(false)
				triggerServerEvent("onHandyKauf",gMe,vorwahl,nummer,name)
			
		end
	
	end
	addEventHandler("onClientGUIClick",HANDYKnopf[2],beantragen,false)

	local function abbrechen ()
	
		guiSetVisible(HANDYFenster[1],false)
		removeEventHandler("onClientGUIClick",HANDYKnopf[1],abbrechen)
		showCursor(false)
	
	end
	addEventHandler("onClientGUIClick",HANDYKnopf[1],abbrechen,false)
	
end)
local HA1Fenster = {}
local HA1Knopf = {}
local HA1Edit = {}
local Guivar = 0
local Guivar2 = 0

addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
function createHandyKontaktliste()
	if(Guivar2 == 1) then return end
	Guivar2 = 1
	local Fenster
	local Grid
	local Edit
	local Knopf1
	local Knopf2
	local Knopf3
	local Knopf4
	
	local X, Y, Width, Height = getMiddleGuiPosition(288,361)
	
	Fenster = guiCreateWindow(X, Y, Width, Height,"Kontaktliste",false)
	Grid = guiCreateGridList(9,27,270,264,false,Fenster)
	guiGridListSetSelectionMode(Grid,1)

	guiGridListAddColumn(Grid,"Name",0.6)

	guiGridListAddColumn(Grid,"Nummer",0.3)
	Knopf1 = guiCreateButton(9,294,88,28,"<< Zurueck ",false,Fenster)
	Knopf2 = guiCreateButton(104,294,88,28,"Loeschen",false,Fenster)
	Edit = guiCreateEdit(9,327,187,25,"",false,Fenster)
	Knopf3 = guiCreateButton(202,327,74,25,"Hinzuf.",false,Fenster)
	Knopf4 = guiCreateButton(199,294,78,28,"Anrufen",false,Fenster)
	local function fillList()
		guiGridListClear(Grid)
		local row = guiGridListAddRow(Grid)
		local file, text
		guiGridListSetItemText(Grid, row, 1, "Meine Nummer", false, false)
		guiGridListSetItemText(Grid, row, 2, getElementData(gMe, "pHandynummer"), false, false)
		for i = 1, 100, 1 do
			if(fileExists("nummern/"..i..".txt")) then
				local row = guiGridListAddRow(Grid)
				file = fileOpen("nummern/"..i..".txt")
				text = fileRead(file, 100)
				local name, nummer = gettok(text, 1, "|"), gettok(text, 2, "|")
				guiGridListSetItemText(Grid, row, 1, name, false, false)
				guiGridListSetItemText(Grid, row, 2, nummer, false, false)
				fileClose(file)
			end
		end
	end
	
	addEventHandler("onClientGUIClick", Knopf4,
	function()
		guiSetText(HA1Edit[1], guiGridListGetItemText(Grid, guiGridListGetSelectedItem(Grid), 2, false, false))
		guiSetVisible(Fenster, false)
		Guivar2 = 0
		guiSetVisible(HA1Fenster[1], true)
	end, false)
	
		addEventHandler("onClientGUIClick", Knopf3,
	function()
		local nummer = guiGetText(Edit)
		local newid = 1
		local done = 0
		for i = 1, 100, 1 do
			if(done == 1) then break; end
			if(fileExists("nummern/"..i..".txt") == false) then
				newid = i
				done = 1
			end
		end
		local numb = 0
		for index, player in pairs(getElementsByType("player")) do
			local handy = getElementData(player, "pHandynummer")
			if(handy) and(handy == nummer) then
				numb = player
			end
		end
		if(numb == 0) then outputChatBox("Kein Spieler zu der Nummer gefunden!", 200, 0, 0, false) return end
		local file = fileCreate("nummern/"..newid..".txt")
		fileWrite(file, "|"..getPlayerName(numb).."|"..nummer.."|")
		fileFlush(file)
		fileClose(file)
		outputChatBox("Spieler gespeichert!", 0, 200, 0, false)
		fillList()
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		local nummer = guiGridListGetItemText(Grid, guiGridListGetSelectedItem(Grid), 2, false, false)
		for i = 1, 100, 1 do
			if(fileExists("nummern/"..i..".txt") == true) then
				local file = fileOpen("nummern/"..i..".txt")
				local text = fileRead(file, 100)
				local nummer2 = gettok(text, 2, "|")
				if(nummer == nummer2) then
					fileClose(file)
					fileDelete("nummern/"..i..".txt")
					outputChatBox("Nummer geloescht!", 0, 200, 0, false)
					fillList()
					break
				end
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		guiSetVisible(Fenster, false)
		Guivar2 = 0
		guiSetVisible(HA1Fenster[1], true)
	end, false)

	fillList()
end
function createHandyGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	

	local X, Y, Width, Height = getMiddleGuiPosition(251,306)
	HA1Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Handy",false)
	HA1Edit[1] = guiCreateEdit(16,28,221,49,"",false,HA1Fenster[1])
	guiEditSetReadOnly(HA1Edit[1], true)
	HA1Knopf[1] = guiCreateButton(23,260,65,26,"0",false,HA1Fenster[1])
	HA1Knopf[2] = guiCreateButton(22,226,65,26,"1",false,HA1Fenster[1])
	HA1Knopf[3] = guiCreateButton(95,226,65,26,"2",false,HA1Fenster[1])
	HA1Knopf[4] = guiCreateButton(168,226,65,26,"3",false,HA1Fenster[1])
	HA1Knopf[5] = guiCreateButton(21,190,65,26,"4",false,HA1Fenster[1])
	HA1Knopf[6] = guiCreateButton(94,189,65,26,"5",false,HA1Fenster[1])
	HA1Knopf[7] = guiCreateButton(167,189,65,26,"6",false,HA1Fenster[1])
	HA1Knopf[8] = guiCreateButton(21,152,65,26,"7",false,HA1Fenster[1])
	HA1Knopf[9] = guiCreateButton(94,150,65,26,"8",false,HA1Fenster[1])
	HA1Knopf[10] = guiCreateButton(168,150,65,26,"9",false,HA1Fenster[1])
	HA1Knopf[11] = guiCreateButton(20,117,65,26,"/",false,HA1Fenster[1])
	HA1Knopf[12] = guiCreateButton(94,117,65,26,"#",false,HA1Fenster[1])
	HA1Knopf[13] = guiCreateButton(19,83,212,30,"Kontakte",false,HA1Fenster[1])
	HA1Knopf[14] = guiCreateButton(96,258,65,26,"Anrufen",false,HA1Fenster[1])
	HA1Knopf[15] = guiCreateButton(167,258,65,26,"Auflegen",false,HA1Fenster[1])
	HA1Knopf[16] = guiCreateButton(167,116,65,26,"Loeschen",false,HA1Fenster[1])
	
	local function setHandyDisabled()
		guiSetEnabled(HA1Knopf[1], false)
		guiSetEnabled(HA1Knopf[2], false)
		guiSetEnabled(HA1Knopf[3], false)
		guiSetEnabled(HA1Knopf[4], false)
		guiSetEnabled(HA1Knopf[5], false)
		guiSetEnabled(HA1Knopf[6], false)
		guiSetEnabled(HA1Knopf[7], false)
		guiSetEnabled(HA1Knopf[8], false)
		guiSetEnabled(HA1Knopf[9], false)
		guiSetEnabled(HA1Knopf[10], false)
		guiSetEnabled(HA1Knopf[11], false)
		guiSetEnabled(HA1Knopf[12], false)
		guiSetEnabled(HA1Knopf[13], false)
		guiSetEnabled(HA1Knopf[16], false)
		guiSetText(HA1Knopf[14], "Annehmen")
	end
	
	local function setHandyEnabled()
		guiSetEnabled(HA1Knopf[1], true)
		guiSetEnabled(HA1Knopf[2], true)
		guiSetEnabled(HA1Knopf[3], true)
		guiSetEnabled(HA1Knopf[4], true)
		guiSetEnabled(HA1Knopf[5], true)
		guiSetEnabled(HA1Knopf[6], true)
		guiSetEnabled(HA1Knopf[7], true)
		guiSetEnabled(HA1Knopf[8], true)
		guiSetEnabled(HA1Knopf[9], true)
		guiSetEnabled(HA1Knopf[10], true)
		guiSetEnabled(HA1Knopf[11], true)
		guiSetEnabled(HA1Knopf[12], true)
		guiSetEnabled(HA1Knopf[13], true)
		guiSetEnabled(HA1Knopf[16], true)
		guiSetText(HA1Knopf[14], "Anrufen")
	end
	local angerufen = getElementData(gMe, "angerufen")
	local wartend = getElementData(gMe, "wartend")
	if(angerufen == true) then
		local nummer = getElementData(getElementData(gMe, "anrufer"), "pHandynummer")
		setHandyDisabled()
		guiSetText(HA1Edit[1], nummer.." ruft an.")
		guiSetText(HA1Knopf[14], "Annehmen")
	end
	if(wartend == true) then
		setHandyDisabled()
		local nummer = getElementData(getElementData(gMe, "wartender"), "pHandynummer")
		guiSetText(HA1Edit[1], "Wartend auf "..nummer)
		guiSetEnabled(HA1Knopf[14], false)
	end
	
	if(getElementData(gMe, "imGesprach") == true) then
		setHandyDisabled()
		guiSetText(HA1Edit[1], "Im Gespraech mit: "..getElementData(getElementData(gMe, "gespraecher"), "pHandynummer"))
		guiSetEnabled(HA1Knopf[14], false)
		if(getElementData(gMe, "gespraecher") == false) then
			setElementData(gMe, "imGesprach", false)
			setHandyEnabled()
		end
	end
	
	
	local function addNummer()
		local nummer = guiGetText(source)
		if(nummer == 0) then nummer = 0 end
		local cur = guiGetText(HA1Edit[1])
		local new = cur..nummer
		if(string.len(tostring(new)) > 12) then return end
		guiSetText(HA1Edit[1], new)
	end
	local function addSound()
		if(tonumber(guiGetText(source)) == nil) then
			if(guiGetText(source) == "#") or (guiGetText(source) == "Loeschen") then
				playSound("sounds/handy/sonder1.mp3", false)
			elseif(guiGetText(source) == "/") then
				playSound("sounds/handy/sonder2.mp3", false)
			end
		else
		
			if(tonumber(guiGetText(source)) > -1) and (tonumber(guiGetText(source)) < 10) then
				playSound("sounds/handy/"..guiGetText(source)..".mp3", false)
			end
		end
	end
	
	for i = 1, 12, 1 do
		addEventHandler("onClientGUIClick", HA1Knopf[i], addNummer, false)
		addEventHandler("onClientGUIClick", HA1Knopf[i], addSound, false)

	end
	addEventHandler("onClientGUIClick", HA1Knopf[16],
	function()
		guiSetText(HA1Edit[1], "")
	end, false)
	
	addEventHandler("onClientGUIClick", HA1Knopf[13],
	function()
		if(guiGetText(HA1Edit[1]) == "") or (guiGetText(HA1Edit[1]) == " ") then
			guiSetVisible(HA1Fenster[1], false)
			createHandyKontaktliste()
		end
	end, false)
	
	addEventHandler("onClientGUIClick", HA1Knopf[13],
	function()
		if(guiGetText(HA1Edit[1]) == "") or (guiGetText(HA1Edit[1]) == " ") then
			guiSetVisible(HA1Fenster[1], false)
			createHandyKontaktliste()
		end
	end, false)

	
	addEventHandler("onClientGUIClick", HA1Knopf[14],
	function()
		local number = guiGetText(HA1Edit[1])
		if(number == nil) then playSound("sounds/handy/wrong.mp3", false) return end
		if(number == getElementData(gMe, "pHandynummer")) then playSound("sounds/handy/wrong.mp3", false) return end
		if(getElementData(gMe, "angerufen") == true) then
			triggerServerEvent("onPlayerAcceptPlayer", gMe)
			guiSetVisible(HA1Fenster[1], false)
			Guivar = 0
			showCursor(false)
			setElementData(gMe, "Clicked", 0)
		return end
		triggerServerEvent("onPlayerCallPlayer", gMe, number)
		
		addEvent("onHandySucess", true)
		addEventHandler("onHandySucess", getRootElement(),
		function(typ)
			if(typ == 1) then
				guiSetVisible(HA1Fenster[1], false)
				Guivar = 0
				showCursor(false)
				setElementData(gMe, "Clicked", 0)
			elseif(typ == 0) then
				 playSound("sounds/handy/wrong.mp3", false)
			end
		end)
	end, false)
	
	addEventHandler("onClientGUIClick", HA1Knopf[15],
	function()
		if(guiGetText(HA1Edit[1]) == "") or (guiGetText(HA1Edit[1]) == " ") then
			guiSetVisible(HA1Fenster[1], false)
			Guivar = 0
			showCursor(false)
			setElementData(gMe, "Clicked", 0)
		else
			if(getElementData(gMe, "imGesprach") == true) then
				triggerServerEvent("onPlayerCallStop", gMe, getElementData(gMe, "gespraecher"))
				setHandyEnabled()
				guiSetText(HA1Edit[1], "")
			
			else
				outputChatBox("Bitte erst Nummer loeschen!", 200, 0, 0, false)
				playSound("sounds/handy/wrong.mp3", false)
			end
		end
	end, false)
end

addCommandHandler("handy",
function()
	if(hasPlayerHandy(gMe) == false) then outputChatBox("Du hast kein Handy! Kauf dir im Shop eins.", 200, 0, 0, false) return end
	if(Guivar2 == 1) then return end
	if(Guivar == 0) then
		createHandyGui()
	elseif(Guivar == 1) then
		guiSetVisible(HA1Fenster[1], false)
		Guivar = 0
		showCursor(false)
	end
end)