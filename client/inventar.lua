--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

local Guivar = 0 -- Inventar
addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
local Guivar2 = 0 -- Rechnung
local Guivar3 = 0 -- Zeitung
local Guivar4 = 0 -- Mats
local Guivar5 = 0 -- Blitzer
local Guivarstatus = 0 -- Staten
local INVVar = 0


local INVFenster = {}
local INVKnopf = {}
local INVCheckbox = {}
local INVLabel = {}
local INVEdit = {}
local INVGrid = {}
local INVBild = {}


local waffenMats = {
	["9mm"] = 4,
	["deagle"] = 8,
	["schrotflinte"] = 5,
	["mp5"] = 9,
	["ak-47"] = 12,
	["messer"] = 3,
	["gewehr"] = 7,
}

local waffenObs = {
	[1] = "|331|",
	[2] = "|333|",
	[3] = "|334|",
	[4] = "|335|",
	[5] = "|336|",
	[6] = "|337|",
	[7] = "|338|",
	[8] = "|339|",
	[9] = "|341|",
	[10] = "|321|",
	[11] = "|322|",
	[12] = "|323|",
	[14] = "|325|",
	[15] = "|326|",
	[16] = "|342|",
	[17] = "|343|",
	[18] = "|344|",
	[22] = "|346|",
	[23] = "|347|",
	[24] = "|348|",
	[25] = "|349|",
	[26] = "|350|",
	[27] = "|351|",
	[28] = "|352|",
	[29] = "|353|",
	[30] = "|355|",
	[31] = "|356|",
	[33] = "|357|",
	[34] = "|358|",
	[35] = "|359|",
	[36] = "|360|",
	[37] = "|361|",
	[38] = "|362|",
	[39] = "|363|",
	[40] = "|364|",
	[41] = "|365|",
	[42] = "|366|",
	[43] = "|367|",
	[44] = "|368|",
	[45] = "|369|",
	[46] = "|371|"
}

function showInventarGUI()
if(Guivar == 1) then return end
setElementData(gMe, "Clicked", 1)
Guivar = 1
guiSetInputMode("no_binds_when_editing")
showCursor(true)

local X, Y, Width, Height = getMiddleGuiPosition(533,249)
	

INVFenster[1] = guiCreateWindow(X, Y, Width, Height, "Inventar",false)
INVLabel[1] = guiCreateLabel(11,26,301,20,"Klicke auf ein Item, um die Beschreibung anzusehen!",false,INVFenster[1])
guiSetFont(INVLabel[1],"default-bold-small")
INVGrid[1] = guiCreateGridList(10,46,296,146,false,INVFenster[1])
guiGridListSetSelectionMode(INVGrid[1],1)

guiGridListAddColumn(INVGrid[1],"Item",0.7)

guiGridListAddColumn(INVGrid[1],"Anzahl",0.2)
INVKnopf[1] = guiCreateButton(10,201,97,36,"Benutzen",false,INVFenster[1])
INVLabel[2] = guiCreateLabel(409,33,114,147,"Beschreibung:\n",false,INVFenster[1])
guiSetFont(INVLabel[2],"default-bold-small")
INVBild[1] = guiCreateStaticImage(307,79,90,68,"data/images/trans.png",false,INVFenster[1])
INVLabel[3] = guiCreateLabel(307,177,191,25,"___________________________",false,INVFenster[1])
guiSetFont(INVLabel[3],"default-bold-small")
INVLabel[4] = guiCreateLabel(119,210,46,18,"Anzahl:",false,INVFenster[1])
guiSetFont(INVLabel[4],"default-bold-small")
INVEdit[1] = guiCreateEdit(170,200,74,31,"",false,INVFenster[1])
--INVKnopf[2] = guiCreateButton(427,197,95,17,"Geben",false,INVFenster[1])
--INVLabel[5] = guiCreateLabel(252,206,72,19,"Empfaenger: ",false,INVFenster[1])
--guiSetFont(INVLabel[5],"default-bold-small")
--INVEdit[2] = guiCreateEdit(328,201,92,31,"",false,INVFenster[1])
INVKnopf[3] = guiCreateButton(427,218,95,17,"Wegwerfen",false,INVFenster[1])
addEventHandler("onClientGUIClick", INVGrid[1], INVCLICK)
loadInventar()
	local function closeInventar()
			destroyElement(INVFenster[1])
			showCursor(false)
			Guivar = 0
			INVVar = 0
			setElementData(gMe, "Clicked", 0)
	end
	addEventHandler("onClientGUIClick", INVKnopf[1], --Benutzen
	function()
	local item = guiGridListGetItemText ( INVGrid[1], guiGridListGetSelectedItem ( INVGrid[1] ), 1 )
	if(item == " ") or (item == "") then outputChatBox("Du musst ein Item auswaehlen!", 200, 0, 0, false) return end
	if(item == "Wuerfel") then
		triggerServerEvent("onInventarAction", gMe, 1)
		closeInventar()
	elseif(item == "Zigaretten") then
		triggerServerEvent("onInventarAction", gMe, 2)
		closeInventar()
	elseif(item == "Bier") then
		triggerServerEvent("onInventarAction", gMe, 3)
		closeInventar()

	elseif(item == "Nagelband") then
		if(tonumber(getElementData(gMe, "insperre")) == 1) then return end
		triggerEvent("start_strassensperre", gMe, 4)
		closeInventar()
	elseif(item == "Absperrung") then
		if(tonumber(getElementData(gMe, "insperre")) == 1) then return end
		triggerEvent("start_strassensperre", gMe, "Reporter")
		closeInventar()
	elseif(item == "Strassensperre") then
		if(tonumber(getElementData(gMe, "insperre")) == 1) then return end
		triggerEvent("start_strassensperre", gMe, 1)
		closeInventar()
	elseif(item == "Strassensperre 2") then
		if(tonumber(getElementData(gMe, "insperre")) == 1) then return end
		triggerEvent("start_strassensperre", gMe, 2)
		closeInventar()
	elseif(item == "Strassensperre 3") then
		if(tonumber(getElementData(gMe, "insperre")) == 1) then return end
		triggerEvent("start_strassensperre", gMe, 3)
		closeInventar()
	elseif(item == "Fackel") then
		if(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
		triggerEvent("start_objekt_baumarkt", gMe, "Fackel")
		closeInventar()
	elseif(item == "Grill") then
		if(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
		triggerEvent("start_objekt_baumarkt", gMe, "Grill")
		closeInventar()
		
	elseif(item == "Lagerfeuer") then
		if(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
		triggerEvent("start_objekt_baumarkt", gMe, "Lagerfeuer")
		closeInventar()
	elseif(item == "Liege") then
		if(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
		triggerEvent("start_objekt_baumarkt", gMe, "Liege")
		closeInventar()
	elseif(item == "Radio") then
		if(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
		triggerEvent("start_objekt_baumarkt", gMe, "Radio")
		closeInventar()
	elseif(item == "Angel") then
		outputChatBox("Bitte Benutze einen Koeder!", 200, 100, 0, false)
	elseif(item == "Wuermer") then
		triggerEvent("onAngelBenutzung", gMe, "Wuermer")
		guiSetVisible(INVFenster[1], false)
		Guivar = 0
		INVVar = 0
		setElementData(gMe, "Clicked", 0)
	elseif(item == "Erste-Hilfe Koffer") then
		triggerServerEvent("onInventarAction", gMe, "Erstehilfe")
		closeInventar()
	elseif(item == "Benzinkanister") then
		triggerServerEvent("onInventarAction", gMe, "Kanister")
		closeInventar()
	elseif(item == "Floehe") then
		triggerEvent("onAngelBenutzung", gMe, "Floehe")
		guiSetVisible(INVFenster[1], false)
		Guivar = 0
		INVVar = 0
		setElementData(gMe, "Clicked", 0)
	elseif(item == "Drogen") then
		local drogen, mats = tonumber(gettok(getElementData(gMe, "pMISC"), 1, "|")), tonumber(gettok(getElementData(gMe, "pMISC"), 2, "|"))
		if(drogen < 3) then outputChatBox("Du benoetigst 3g Drogen, fuer diese Aktion.", 200, 0, 0, false) return end
		triggerEvent("onPlayerDrugNehme", gMe)
		guiSetVisible(INVFenster[1], false)
		Guivar = 0
		INVVar = 0
		setElementData(gMe, "Clicked", 0)
		setElementData(gMe, "pMISC", "|"..(drogen-3).."|"..mats.."|")
		triggerServerEvent("onInventarAction", gMe, 4)
		showCursor(false)
	elseif(item == "Arztrechnung") then		
		if(Guivar2 == 1) then return end
		Guivar2 = 1
		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 344,262
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
	
		local Fenster = guiCreateWindow(X, Y, Width, Height,"Rechnung",false)
		local Memo = guiCreateMemo(9,19,326,201,getElementData(gMe, "pArztrechnung"),false,Fenster)
		local Knopf = guiCreateButton(117,224,102,29,"OK",false,Fenster)
		guiMemoSetReadOnly(Memo, true)
		
		addEventHandler("onClientGUIClick", Knopf,
		function()
			destroyElement(Fenster)
			Guivar2 = 0
		end, false)
	elseif(item == "Blitzerrechnung") then		
		if(Guivar5 == 1) then return end
		Guivar5 = 1
		local X, Y, Width, Height = getMiddleGuiPosition(344,262)

	
		local Fenster = guiCreateWindow(X, Y, Width, Height,"Rechnung",false)
		local Memo = guiCreateMemo(9,19,326,201,getElementData(gMe, "pBlitzer"),false,Fenster)
		local Knopf = guiCreateButton(117,224,102,29,"OK",false,Fenster)
		guiMemoSetReadOnly(Memo, true)
		
		addEventHandler("onClientGUIClick", Knopf,
		function()
			destroyElement(Fenster)
			Guivar5 = 0
		end, false)
	elseif(item == "Materialien") then		
		if(Guivar4 == 1) then return end
		Guivar4 = 1
		local X, Y, Width, Height = getMiddleGuiPosition(160,229)
		local Fenster = guiCreateWindow(X, Y, Width, Height,"Waffe Herstellen",false)
		local Radio = {}
		
		Radio[1] = guiCreateRadioButton(24,17,95,25,"9mm(4 M.)",false,Fenster)
		guiSetFont(Radio[1],"default-bold-small")
		guiRadioButtonSetSelected(Radio[1],true)
		Radio[2] = guiCreateRadioButton(24,36,95,25,"Deagle(8 M.)",false,Fenster)
		guiSetFont(Radio[2],"default-bold-small")
		Radio[3] = guiCreateRadioButton(23,58,118,23,"Schrotfline(5 M.)",false,Fenster)
		guiSetFont(Radio[3],"default-bold-small")
		Radio[4] = guiCreateRadioButton(23,77,118,23,"MP5(9 M.)",false,Fenster)
		guiSetFont(Radio[4],"default-bold-small")
		Radio[5] = guiCreateRadioButton(24,97,118,23,"AK-47(12 M.)",false,Fenster)
		guiSetFont(Radio[5],"default-bold-small")
		Radio[6] = guiCreateRadioButton(23,137,118,23,"Messer(3 M.)",false,Fenster)
		guiSetFont(Radio[6],"default-bold-small")
		Radio[7] = guiCreateRadioButton(23,117,116,22,"Gewehr(7 M.)",false,Fenster)
		guiSetFont(Radio[7],"default-bold-small")
		local Knopf1 = guiCreateButton(21,165,112,27,"Herstellen",false,Fenster)
		local Knopf2 = guiCreateButton(21,193,112,27,"Abbrechen",false,Fenster)
		addEventHandler("onClientGUIClick", Knopf1,
		function()
			local r1, r2, r3, r4, r5, r6, r7 = guiRadioButtonGetSelected(Radio[1]), guiRadioButtonGetSelected(Radio[2]), guiRadioButtonGetSelected(Radio[3]), guiRadioButtonGetSelected(Radio[4]), guiRadioButtonGetSelected(Radio[5]), guiRadioButtonGetSelected(Radio[6]), guiRadioButtonGetSelected(Radio[7])
			local waffe
			if(r1 == true) then waffe = "9mm" end
			if(r2 == true) then waffe = "deagle" end
			if(r3 == true) then waffe = "schrotflinte" end
			if(r4 == true) then waffe = "mp5" end
			if(r5 == true) then waffe = "ak-47" end
			if(r6 == true) then waffe = "messer" end
			if(r7 == true) then waffe = "gewehr" end
			local misc = getElementData(gMe, "pMISC")
			local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
			local preis = waffenMats[waffe]
			if(preis > mats) then outputChatBox("Du benoetigst weitere "..(preis-mats).." Materialien.", 200, 0, 0) return end
			triggerServerEvent("onInventarWaffeMats", gMe, waffe)
			setElementData(gMe, "pMISC", "|"..drogen.."|"..(mats-preis).."|")
			destroyElement(Fenster)
			Guivar4 = 0
		end, false)
		addEventHandler("onClientGUIClick", Knopf2,
		function()
			destroyElement(Fenster)
			Guivar4 = 0
		end, false)
	elseif(item == "Zeitung") then
		if(Guivar3 == 1) then return end
		Guivar3 = 1
		
		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 363,260
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)

		local Fenster = guiCreateWindow(X, Y, Width, Height,"Zeitung Bearbeiten",false)
		local Knopf2 = guiCreateButton(150,224,110,27,"OK",false,Fenster)
		local Memo = guiCreateMemo(9,19,345,201,"Bitte Warten...",false,Fenster)
		guiMemoSetReadOnly(Memo, true)
		
		triggerServerEvent("onRCNRZeitungNeed", gMe)
		addEvent("onRCNRZeitungNeedBack", true)
		addEventHandler("onRCNRZeitungNeedBack", getRootElement(),
		function(text)
			if not(text) then return end
			guiSetText(Memo, text)
		end)
		
		addEventHandler("onClientGUIClick", Knopf2,
		function()
			destroyElement(Fenster)
			Guivar3 = 0
	end, false)
	elseif(item == "Status") then
		if(Guivarstatus == 1) then return end
		Guivarstatus = 1
		
		
		local X, Y, Width, Height = getMiddleGuiPosition(254,250)
		local Fenster = guiCreateWindow(X, Y, Width, Height,"Freigeschaltete Status",false)
		local Grid = guiCreateGridList(9,20,236,186,false,Fenster)
		guiGridListSetSelectionMode(Grid,1)

		guiGridListAddColumn(Grid,"Status",0.75)
		local Knopf1 = guiCreateButton(12,211,100,32,"Verwenden",false,Fenster)
		local Knopf2 = guiCreateButton(140,211,100,32,"Schliessen",false,Fenster)
		
		local function fillStatus()
			-- Anfaenger --
			local row = guiGridListAddRow(Grid)
			guiGridListSetItemText(Grid, row, 1, "Anfaenger", false, false)
			-- Member --
			local fraktion = getPlayerFraktion(gMe)
			if(fraktion ~= 0) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Member", false, false)
			end
			-- Rank ueber 3 --
			if(fraktion ~= 0) and (getPlayerFraktionsrang(gMe) > 2) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Aufsteiger", false, false)
			end
			if(fraktion ~= 0) and (getPlayerFraktionsrang(gMe) > 4) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Anfuehrer", false, false)
			end
			-- Fraktionsintern --
			if(fraktion == 2) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Bombenleger", false, false)
			end
			
			-- Adminintern --
			if(getPlayerAdminlevel(gMe) > 1) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Fachkraft", false, false)
			end
			if(getPlayerAdminlevel(gMe) > 4) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Sicherheitsmaster", false, false)
			end
			-- Morde und Tode
			if(tonumber(getElementData(gMe, "pMorde")) > 200) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Moerder", false, false)
			end
			if(tonumber(getElementData(gMe, "pTode")) > 200) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Krankenhausmessie", false, false)
			end
			-- MISC --
			if(getPlayerName(gMe) == "MuLTi") then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Scriptelidudler", false, false)
			end
			-- Buerger --
			if(tonumber(gettok ( getElementData(gMe, "pSpielzeit"), 1, ":" )) > 25) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Buerger", false, false)
			end
			if(tonumber(gettok ( getElementData(gMe, "pSpielzeit"), 1, ":" )) < 2) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Immigrant", false, false)
			end
			if(tonumber(getElementData(gMe, "pBGeld")) > 500000) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Finanzchecker", false, false)
			end
			if(tonumber(getElementData(gMe, "pBGeld")) > 1000000) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Millionaer", false, false)
			end
			if(tonumber(getElementData(gMe, "pBGeld")) > 5000000) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Multimillionaer", false, false)
			end
			if(tonumber(getElementData(gMe, "pBGeld")) > 10000000) then
				guiGridListSetItemText(Grid, guiGridListAddRow(Grid), 1, "Milliardaer", false, false)
			end
		end
		
		fillStatus()
		addEventHandler("onClientGUIClick", Knopf2,
		function()
			destroyElement(Fenster)
			Guivarstatus = 0
		end, false)
		addEventHandler("onClientGUIClick", Knopf1,
		function()
			local status = guiGridListGetItemText(Grid, guiGridListGetSelectedItem(Grid), 1)
			if(status == "") or (status == " ") then outputChatBox("Du musst ein Status auswaehlen!", 200, 0, 0) return end
			triggerServerEvent("onInventarStatusChange", gMe, status)
		end, false)
	
	end
	loadInventar()
	end, false)


	addEventHandler("onClientGUIClick", INVKnopf[3], -- Wegwerfen
	function()
	local item = guiGridListGetItemText ( INVGrid[1], guiGridListGetSelectedItem ( INVGrid[1] ), 1 )
	if(item == " ") or (item == "") then outputChatBox("Du musst ein Item auswaehlen!", 200, 0, 0, false) return end
	local text = tonumber(guiGetText(INVEdit[1]))
	if not(text) then text = 1 guiSetText(INVEdit[1], "1") end
	if(text == 0) then return end
	if(text < 0) then return end
	if(getWeaponIDFromName(item)) then
		local id = getWeaponIDFromName(item)
		local muni = guiGridListGetItemText ( INVGrid[1], guiGridListGetSelectedItem ( INVGrid[1] ), 2 )
		local object = tonumber(gettok(waffenObs[id], 1, "|"))
		triggerServerEvent("onInventarWaffeAbgeb", gMe, id, muni, object)
		closeInventar()
		return
	end
	if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
	if(item == "Wuerfel") then local item2 = tonumber(getElementData(gMe, "pWuerfel")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pWuerfel", tonumber(getElementData(gMe, "pWuerfel"))-text) end
	if(item == "Zigaretten") then local item2 = tonumber(getElementData(gMe, "pZigaretten")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pZigaretten", tonumber(getElementData(gMe, "pZigaretten"))-text) end
	if(item == "Bier") then local item2 = tonumber(getElementData(gMe, "pBier")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pBier", tonumber(getElementData(gMe, "pBier"))-text) end
	if(item == "Zeitung") then local item2 = tonumber(getElementData(gMe, "pZeitung")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pZeitung", tonumber(getElementData(gMe, "pZeitung"))-text) end
	if(item == "Geld") then outputChatBox("Spende das Geld lieber, anstatt wegzuwerfen...", 200, 200, 0, false)return end
	if(item == "Arztrechnung") then outputChatBox("Du hast deine Arztrechnung weggeworfen! Richtig so.", 200, 200, 0, false) setElementData(gMe, "pArztrechnung", nil) end
	if(item == "Blitzerrechnung") then outputChatBox("Du hast deine Blitzerrechnung weggeworfen! Richtig so.", 200, 200, 0, false) setElementData(gMe, "pBlitzer", nil) end
	if(item == "Bretter") then local item2 = tonumber(getElementData(gMe, "pBretter")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pBretter", tonumber(getElementData(gMe, "pBretter"))-text) end
	if(item == "Kisten") then local item2 = tonumber(getElementData(gMe, "pKisten")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pKisten", tonumber(getElementData(gMe, "pKisten"))-text) end
	if(item == "Computer") then local item2 = tonumber(getElementData(gMe, "pComputer")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pComputer", tonumber(getElementData(gMe, "pComputer"))-text) end
	if(item == "Feuerloescher") then local item2 = tonumber(getElementData(gMe, "pFeuer")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pFeuer", tonumber(getElementData(gMe, "pFeuer"))-text) end
	if(item == "Angel") then local item2 = tonumber(getElementData(gMe, "pAngel")) if(item2 < text) then return end outputChatBox("Du hast "..text.." '"..item.."' weggeworfen!", 200, 200, 0, false) setElementData(gMe, "pAngel", tonumber(getElementData(gMe, "pAngel"))-text) end
	
	loadInventar()
	end, false)
end
local rowTable = { -- 51 Inventar-Objekte LOL xD
	["====[Items]===="] = "Kategorie",
	["====[Scheine]===="] = "Kategorie",
	["====[Sammelobjekte]===="] = "Kategorie",
	["====[Hergestellt]===="] = "Kategorie",
	["====[Fische]===="] = "Kategorie",
	["====[Waffen]===="] = "Kategorie",
	["Wuerfel"] = "Damit kannst du \neine Zahl zwischen\n 1 und 6\nWuerfel.",
	["Zigaretten"] = "Fuellt dein Leben\nauf. Beachte:\nRauchen ist \nungesund!",
	["Bier"] = "Fuellt dein Leben\nauf. Bei Feierabend\nKannst du dir ruhig \nmal eins \nGoennen!",
	["Zeitung"] = "Hier erfaehrst du\ndie aktuellen News.\nFrisch von\nder RCNR!",
	["Geld"] = "Geld regiert die\nWelt!\n\nGeld ist das, womit\ndu dir Sachen \nkaufen kannst.",
	["Arztrechnung"] = "Das kommt\nimmer von den vielen\nspielereien!",
	["Strassensperre"] = "Nur fuer\nRCPD'ler!\nUnfesste Sperre.",
	["Strassensperre 2"] = "Nur fuer\nRCPD'ler!\nUnfesste Barriere.",
	["Strassensperre 3"] = "Nur fuer\nRCPD'ler!\n\Dynamische Sperre.",
	["Nagelband"] = "Nur fuer\nRCPD'ler!\n\nNagelband,\nwelches die\nRaeder zerstoert.",
	["Lagerfeuer"] = "Das Beste\nentspannen unter\nden Sternenhimmel!",
	["Grill"] = "Hau die\nWurst drauf!",
	["Fackel"] = "Du brauchst\blicht? kein\nProblem",
	["Liege"] = "Chill mal!",
	["Personalausweis"] = "Brauchst du\nimmer fuer\nEvents.",
	["Presseausweis"] = "Braucht man\nimmer mal.",
	["Fuehrerschein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nAutos.",
	["LKW-Schein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nLast Kraft Wagens.",
	["Helikopterschein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nHelikopters.",
	["Flugzeugschein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nFlugzeuges.",
	["Bootsschein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nMotorbootes.",
	["Angelschein"] = "Die Offizielle\nElaubnis zum\nAngeln.",
	["Motorradschein"] = "Die Offizielle\nFahrerlaubnis zum\nfuehren eines\nMotorrads.",
	["Bretter"] = "Lagen wohl\nirgendwo herrum\n...",
	["Kisten"] = "Lagen wohl\nirgendwo herrum\n...",
	["Computer"] = "Lagen wohl\nirgendwo herrum\n...",
	["Feuerloescher"] = "Lagen wohl\nirgendwo herrum\n...",
	["Regal"] = "Wurde hergestellt.",
	["Zaun"] = "Wurde hergestellt.",
	["Tuer"] = "Wurde hergestellt.",
	["Sperrholz"] = "Wurde hergestellt.",
	["Palette"] = "Wurde hergestellt.",
	["Antenne"] = "Wurde hergestellt.",
	["Spielekonsole"] = "Wurde hergestellt.",
	["Verpackung"] = "Wurde hergestellt.",
	["Eisen"] = "Wurde hergestellt.",
	["Draht"] = "Wurde hergestellt.",
	["Drogen"] = "Illegal, helfen\naber bei\nProblemen!",
	["Materialien"] = "Illegal, kannst\naber damit\nWaffen bauen.",
	["Angel"] = "Brauch mann\num Fische zu\nFangen.",
	["Wuermer"] = "Der Koeder\nmacht den\nfang aus!",
	["Floehe"] = "Der Koeder\nmacht den\nfang aus!",
	["Forelle"] = "Sehr\nLecker.",
	["Lachs"] = "Sehr\nLecker.",
	["Hai"] = "Sehr\nLecker.",
	["Barsch"] = "Sehr\nLecker.",
	["Rochen"] = "Sehr\nLecker.",
	["Aal"] = "Sehr\nLecker.",
	["Thunfisch"] = "Sehr\nLecker.",
	["Schwertfisch"] = "Sehr\nLecker.",
	["Erste-Hilfe Koffer"] = "Besser als\nnichts.\n1x-liger\nGebrauch.",
	["Benzinkanister"] = "Bitte nicht\nTrinken!\nNur fuer\nFahrzeuge.",
	["Status"] = "Alle Staten\nvon dir,\ndie du\nfreigeschaltet\nhast.",
	["Radio"] = "Damit kannst\ndu Streams\nAbspielen,\ndie jeder\nhoeren kann!",
	["Absperrung"] = "Damit die\nReporter Sperren\nerrichten\nkoennen.",
	["Blitzerrechnung"] = "Wohl nicht\naufgepasst,\nwas?",
}

function INVCLICK( button)
	if not button == "left" then return end
	local row = tostring(guiGridListGetItemText ( INVGrid[1], guiGridListGetSelectedItem ( INVGrid[1] ), 1 ))
	if(row == " ") or (row == "") then return end
	if(row == "Wuerfel") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/wuerfel.png")
	elseif(row == "Zigaretten") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/zigarette.png")
	elseif(row == "Bier") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/bier.png")
	elseif(row == "Zeitung") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/zeitung.png")
	elseif(row == "Geld") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/geld.png")
	elseif(row == "Arztrechnung") or (row == "Blitzerrechnung") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/rechnung.png")
	elseif(row == "Fuehrerschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/car.png")
	elseif(row == "LKW-Schein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/truck.png")
	elseif(row == "Helikopterschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/helikopter.png")
	elseif(row == "Flugzeugschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/flugzeug.png")
	elseif(row == "Bootsschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/boot.png")
	elseif(row == "Angelschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/fisch.png")
	elseif(row == "Motorradschein") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/bike.png")
	elseif(row == "Presseausweis") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/ausweis.png")
	elseif(row == "Personalausweis") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/perso.png")
	elseif(row == "Kisten") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/kisten.png")
	elseif(row == "Bretter") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/bretter.png")
	elseif(row == "Computer") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/computer.png")
	elseif(row == "Feuerloescher") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/feuer.png")
	elseif(row == "Drogen") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/drug.png")
	elseif(row == "Materialien") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/mats.png")
	elseif(row == "====[Fische]====") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/fish.png")
	elseif(row == "Erste-Hilfe Koffer") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/erstehilfe.png")
	elseif(row == "Radio") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/radio.png")
	elseif(row == "Benzinkanister") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/kanister.png")
	elseif(row == "Strassensperre") or (row == "Strassensperre 2") or (row == "Strassensperre 3") or (row == "Absperrung") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/barrikade.png")
	elseif(row == "Angel") or (row == "Wuermer") or (row == "Floehe") then
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/angel.png")
	else
		guiStaticImageLoadImage(INVBild[1], "data/images/inv/unknow.png")
	end
	if(rowTable[row]) then
		guiSetText(INVLabel[2], "Beschreibung:\n\n"..rowTable[row])
	end
end

function loadInventar()
	guiGridListClear(INVGrid[1])
	local wuerfel = tonumber(getElementData(gMe, "pWuerfel"))
	local zigaretten = tonumber(getElementData(gMe, "pZigaretten"))
	local biere = tonumber(getElementData(gMe, "pBiere"))
	local rechnung = getElementData(gMe, "pArztrechnung")
	local nagelband = tonumber(getElementData(gMe, "pNailroad"))
	local sperre = tonumber(getElementData(gMe, "pStrassensperre"))
	local zeitung = tonumber(getElementData(gMe, "pZeitung"))
	local handgeld = tonumber(getElementData(gMe, "pHGeld"))
	local fsschein = tonumber(getElementData(gMe, "pFSchein"))
	local lkwschein = tonumber(getElementData(gMe, "pLKWSchein"))
	local helischein = tonumber(getElementData(gMe, "pHELISchein"))
	local flugschein = tonumber(getElementData(gMe, "pFLUGSchein"))
	local bootsschein = tonumber(getElementData(gMe, "pBOOTSSchein"))
	local angelschein = tonumber(getElementData(gMe, "pANGELSchein"))
	local motorradschein = tonumber(getElementData(gMe, "pMOTORRADSchein"))
	local presseausweis = tonumber(getElementData(gMe, "pPresseausweis"))
	local bretter = tonumber(getElementData(gMe, "pBretter"))
	local kisten = tonumber(getElementData(gMe, "pKisten"))
	local computer = tonumber(getElementData(gMe, "pComputer"))
	local feuer = tonumber(getElementData(gMe, "pFeuer"))
	local grill = tonumber(getElementData(gMe, "pBGrill"))
	local fackel = tonumber(getElementData(gMe, "pBFackel"))
	local liege = tonumber(getElementData(gMe, "pBLiege"))
	local lagerfeuer = tonumber(getElementData(gMe, "pBLagerfeuer"))
	local perso = tonumber(getElementData(gMe, "pPerso"))
	local items = guiGridListAddRow ( INVGrid[1] )
	local simv = getElementData(gMe, "pSINV")
	local regal = tonumber(gettok(simv, 1, "|"))
	local zaun = tonumber(gettok(simv, 2, "|"))
	local tuer = tonumber(gettok(simv, 3, "|"))
	local sperrholz = tonumber(gettok(simv, 4, "|"))
	local palette = tonumber(gettok(simv, 5, "|"))
	local antenne = tonumber(gettok(simv, 6, "|"))
	local konsole = tonumber(gettok(simv, 7, "|"))
	local verpackung = tonumber(gettok(simv, 8, "|"))
	local eisen = tonumber(gettok(simv, 9, "|"))
	local draht = tonumber(gettok(simv, 10, "|"))
	local misc = getElementData(gMe, "pMISC")
	local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
	local ang = getElementData(gMe, "pKoeder")
	local fish = getElementData(gMe, "pFische")
	local forelle = tonumber(gettok(fish, 1, "|"))
	local lachs = tonumber(gettok(fish, 2, "|"))
	local hai = tonumber(gettok(fish, 3, "|"))
	local barsch = tonumber(gettok(fish, 4, "|"))
	local rochen = tonumber(gettok(fish, 5, "|"))
	local aal = tonumber(gettok(fish, 6, "|"))
	local thunfisch = tonumber(gettok(fish, 7, "|"))
	local schwertfisch = tonumber(gettok(fish, 8, "|"))
	local kanister = tonumber(getElementData(gMe, "pKanister"))
	local erstehilfe = tonumber(getElementData(gMe, "pErstehilfe"))
	local radio = tonumber(getElementData(gMe, "pRadios"))
	local blitzer = getElementData(gMe, "pBlitzer")
	
	local angel, wuermer, floehe = tonumber(getElementData(gMe, "pAngel")), tonumber(gettok(ang, 1, "|")), tonumber(gettok(ang, 2, "|"))
	guiGridListSetItemText(INVGrid[1],items,1,"====[Items]====",false,false)

	local row = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],row,1,"Status",false,false)
	guiGridListSetItemText(INVGrid[1],row,2,"-",false,false)
	
	if(wuerfel > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Wuerfel",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,wuerfel,false,false)
	end
	if(zigaretten > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Zigaretten",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,zigaretten,false,false)	
	end
	if(biere > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Bier",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,biere,false,false)
	end
	if(zeitung > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Zeitung",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,zeitung,false,false)
	end
	if(erstehilfe > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Erste-Hilfe Koffer",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,erstehilfe,false,false)
	end
	if(kanister > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Benzinkanister",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,kanister,false,false)
	end
	if(rechnung) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Arztrechnung",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(blitzer)then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Blitzerrechnung",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(drogen > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Drogen",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,drogen,false,false)
	end
	if(mats > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Materialien",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,mats,false,false)
	end
	if(radio > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Radio",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,radio,false,false)
	end
	if(angel > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Angel",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,angel,false,false)
	end
	if(wuermer > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Wuermer",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,wuermer,false,false)
	end
	if(floehe > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Floehe",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,floehe,false,false)
	end
	if(nagelband > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Nagelband",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"-",false,false)
	end
	if(presseausweis > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Absperrung",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(sperre > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Strassensperre",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"-",false,false)
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Strassensperre 2",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"-",false,false)
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Strassensperre 3",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"-",false,false)
	end

	if(liege > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Liege",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,liege,false,false)
	end
	if(grill > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Grill",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,grill,false,false)
	end
	if(lagerfeuer > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Lagerfeuer",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,lagerfeuer,false,false)
	end
	if(fackel > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Fackel",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,fackel,false,false)
	end	

	if(handgeld > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Geld",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,handgeld,false,false)
	end	

	local row = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],row,1,"====[Sammelobjekte]====",false,false)
	if(computer > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Computer",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,computer,false,false)
	end
	if(feuer > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Feuerloescher",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,feuer,false,false)
	end
	if(kisten > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Kisten",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,kisten,false,false)
	end
	if(bretter > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Bretter",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,bretter,false,false)
	end
		local row = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],row,1,"====[Hergestellt]====",false,false)
	--[[
		local regal = gettok(simv, 1, "|")
	local zaun = gettok(simv, 2, "|")
	local tuer = gettok(simv, 3, "|")
	local sperrholz = gettok(simv, 4, "|")
	local palette = gettok(simv, 5, "|")
	local antenne = gettok(simv, 6, "|")
	local konsole = gettok(simv, 7, "|")
	local verpackung = gettok(simv, 8, "|")
	local eisen = gettok(simv, 9, "|")
	local draht = gettok(simv, 10, "|")
	--]]
	if(regal > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Regal",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,regal,false,false)
	end
	if(zaun > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Zaun",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,zaun,false,false)
	end
	if(tuer > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Tuer",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,tuer,false,false)
	end
	if(sperrholz > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Sperrholz",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,sperrholz,false,false)
	end
	if(palette > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Palette",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,palette,false,false)
	end
	if(antenne > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Antenne",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,antenne,false,false)
	end
	if(konsole > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Spielekonsole",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,konsole,false,false)
	end
	if(verpackung > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Verpackung",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,verpackung,false,false)
	end
	if(eisen > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Eisen",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,eisen,false,false)
	end
	if(draht > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Draht",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,draht,false,false)
	end
	
	local scheine = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],scheine,1,"====[Scheine]====",false,false)
	if(perso > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Personalausweis",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(presseausweis > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Presseausweis",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(fsschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Fuehrerschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(lkwschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"LKW-Schein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(helischein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Helikopterschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(flugschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Flugzeugschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(bootsschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Bootsschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(angelschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Angelschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	if(motorradschein == 1) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Motorradschein",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,"1",false,false)
	end
	--[[
		local forelle = tonumber(gettok(fish, 1, "|"))
	local lachs = tonumber(gettok(fish, 2, "|"))
	local hai = tonumber(gettok(fish, 3, "|"))
	local barsch = tonumber(gettok(fish, 4, "|"))
	local rochen = tonumber(gettok(fish, 5, "|"))
	local aal = tonumber(gettok(fish, 6, "|"))
	local thunfisch = tonumber(gettok(fish, 7, "|"))
	local schwertfisch = tonumber(gettok(fish, 8, "|"))
	--]]
	local row = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],row,1,"====[Fische]====",false,false)
	if(forelle > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Forelle",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,forelle,false,false)
	end
	if(lachs > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Lachs",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,lachs,false,false)
	end
	if(hai > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Hai",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,hai,false,false)
	end
	if(barsch > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Barsch",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,barsch,false,false)
	end
	if(rochen > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Rochen",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,rochen,false,false)
	end
	if(aal > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Aal",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,aal,false,false)
	end
	if(thunfisch > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Thunfisch",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,thunfisch,false,false)
	end
	if(schwertfisch > 0) then
		local row = guiGridListAddRow ( INVGrid[1] )
		guiGridListSetItemText(INVGrid[1],row,1,"Schwertfisch",false,false)
		guiGridListSetItemText(INVGrid[1],row,2,schwertfisch,false,false)
	end
	local row = guiGridListAddRow ( INVGrid[1] )
	guiGridListSetItemText(INVGrid[1],row,1,"====[Waffen]====",false,false)
	for i = 0, 12, 1 do
		 local wep = getPedWeapon ( gMe, i )
		 if(wep ~= 0) then
			local name = getWeaponNameFromID(wep)
			local muni = getPedTotalAmmo(gMe, i)
			local row = guiGridListAddRow ( INVGrid[1] )
			guiGridListSetItemText(INVGrid[1],row,1,name,false,false)
			guiGridListSetItemText(INVGrid[1],row,2,muni,false,false)
		 end
	end
end


function toggleInventar()
if(getElementData(gMe, "inLogin") == true) then return end
	if(INVVar == 0) then
		showInventarGUI()
		INVVar = 1
	elseif(INVVar == 1) then
		if(Guivar2 == 1) then return end
		if(Guivar3 == 1) then return end
		if(Guivar4 == 1) then return end
		if(Guivar5 == 1) then return end
		if(Guivarstatus == 1) then return end
		guiSetVisible(INVFenster[1], false)
		showCursor(false)
		Guivar = 0
		INVVar = 0
		setElementData(gMe, "Clicked", 0)
	end
end

bindKey("z", "down", toggleInventar)
addCommandHandler("inv", toggleInventar)
