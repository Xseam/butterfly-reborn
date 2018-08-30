local Guivar = 0

addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
local Guivar2 = 0

local POFenster = {}
local POKnopf = {}
local POLabel = {}
local POEdit = {}
local POGrid = {}
local POBild = {}

function createPoliceComputer()
if(Guivar == 1) then return end
Guivar = 1
showCursor(true)
guiSetInputMode("no_binds_when_editing")
setElementData(gMe, "Clicked", 1)



	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 551,532
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

POFenster[1] = guiCreateWindow(X, Y, Width, Height, "Polizeicomputer",false)
POBild[1] = guiCreateStaticImage(9,22,547,109,"data/images/rcpd.png",false,POFenster[1])
POLabel[1] = guiCreateLabel(13,112,554,17,"_______________________________________________________________________________________",false,POFenster[1])
POGrid[1] = guiCreateGridList(12,135,254,347,false,POFenster[1])
guiGridListSetSelectionMode(POGrid[1],1)

guiGridListAddColumn(POGrid[1],"Spieler",0.4)

guiGridListAddColumn(POGrid[1],"Fraktion",0.3)

guiGridListAddColumn(POGrid[1],"Wts.",0.15)


POKnopf[1] = guiCreateButton(16,486,129,35,"Abbrechen",false,POFenster[1])
POLabel[2] = guiCreateLabel(281,148,98,17,"Allgemein:",false,POFenster[1])
guiSetFont(POLabel[2],"default-bold-small")
POLabel[3] = guiCreateLabel(281,154,98,17,"_________________________",false,POFenster[1])
guiLabelSetColor(POLabel[3],0, 255, 255)
guiSetFont(POLabel[3],"default-bold-small")
POLabel[4] = guiCreateLabel(279,183,265,70,"Spielername:N/A\nFraktion: N/A\nFraktionsrang: N/A\nWanteds: N/A\nSTVO-Punkte: N/A",false,POFenster[1])
guiSetFont(POLabel[4],"default-bold-small")
POKnopf[2] = guiCreateButton(275,260,133,30,"Spielerdatenbank oeffnen",false,POFenster[1])
POKnopf[3] = guiCreateButton(270,407,133,30,"Wanteds geben",false,POFenster[1])
POLabel[5] = guiCreateLabel(278,305,131,23,"Management:",false,POFenster[1])
guiSetFont(POLabel[5],"default-bold-small")
POLabel[6] = guiCreateLabel(275,310,98,17,"_________________________",false,POFenster[1])
guiLabelSetColor(POLabel[6],0,255,255)
guiSetFont(POLabel[6],"default-bold-small")
POLabel[7] = guiCreateLabel(271,353,58,19,"Anzahl: ",false,POFenster[1])
guiSetFont(POLabel[7],"default-bold-small")
POEdit[1] = guiCreateEdit(319,350,53,21,"",false,POFenster[1])
POLabel[8] = guiCreateLabel(271,378,87,19,"Begruendung:",false,POFenster[1])
guiSetFont(POLabel[8],"default-bold-small")
POEdit[2] = guiCreateEdit(355,374,144,26,"",false,POFenster[1])
POKnopf[4] = guiCreateButton(408,407,133,30,"Wanteds loeschen",false,POFenster[1])
POKnopf[5] = guiCreateButton(270,441,133,30,"STVO's geben",false,POFenster[1])
POKnopf[6] = guiCreateButton(408,441,133,30,"STVO's loeschen",false,POFenster[1])
POKnopf[7] = guiCreateButton(270,476,133,30,"Spieler Orten",false,POFenster[1])
POEdit[3] = guiCreateEdit(151,486,112,23,"suche",false,POFenster[1])
aktualisierercpdgridlist()

-- Suche --
function onSucheEintipp ()
	local s = POEdit[3]
	if ( source == s ) then
	local text = guiGetText ( s )
			if ( text == "" ) then
			aktualisierercpdgridlist()
		else
		guiGridListClear(POGrid[1])
		for id, spieler in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( spieler ) ), string.upper ( text ), 1, true ) ) then
						local name = getPlayerName(spieler)
						local fraktion = tonumber(getElementData(spieler, "pFraktion"))
						--local rang = tonumber(getElementData(spieler, "pFraktionsrang"))
						local wanteds = tonumber(getElementData(spieler, "pWanteds"))
						--local stvos = tonumber(getElementData(spieler, "pSTVO"))
						if not(wanteds) then wanteds = 0 end
						--if not(stvos) then stvos = 0 end
						if not(fraktion) then fraktion = "N/A"
						else
							fraktion = fraktionNamen[fraktion]
						end
						--if not(rang) then rang = "N/A" end
						
						local spielerrow = guiGridListAddRow(POGrid[1])
						guiGridListSetItemText(POGrid[1],spielerrow,1,name,false,false)
						guiGridListSetItemText(POGrid[1],spielerrow,2,fraktion,false,false)
						guiGridListSetItemText(POGrid[1],spielerrow,3,wanteds,false,false)
				end
			end
		end
	end
end

addEventHandler ( "onClientGUIChanged", POFenster[1], onSucheEintipp )

--[[

GUIEditor_Window[1] = guiCreateWindow(781,450,385,247,"Datenbank",false)
GUIEditor_Memo[1] = guiCreateMemo(9,20,367,187,"",false,GUIEditor_Window[1])
GUIEditor_Button[1] = guiCreateButton(9,212,122,26,"Speichern",false,GUIEditor_Window[1])
GUIEditor_Button[2] = guiCreateButton(134,212,122,26,"Abbrechen",false,GUIEditor_Window[1])
--]]

addEventHandler("onClientGUIClick", POKnopf[2], -- datenbank
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local spieler = getPlayerFromName(spieler)
	if(Guivar2 == 1) then return end
	Guivar2 = 1
	guiSetInputMode("no_binds_when_editing")
	
		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 385,247
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	local Fenster = guiCreateWindow(X, Y, Width, Height, "Datenbank",false)
	local Memo = guiCreateMemo(9,20,367,187,"",false,Fenster)
	local Knopf1 = guiCreateButton(9,212,122,26,"Speichern",false,Fenster)
	local Knopf2 = guiCreateButton(134,212,122,26,"Abbrechen",false,Fenster)
	triggerServerEvent("onDatenbankDataNeed", gMe, spieler)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		Guivar2 = 0
		destroyElement(Fenster)
		triggerServerEvent("onDatenbankDataWrite", gMe, spieler, guiGetText(Memo))
	end, false)
	
	addEvent("onDatenbankDataNeedBack", true)
	addEventHandler("onDatenbankDataNeedBack", gMe,
	function(text)
		if not(source == gMe) then return end
		guiSetText(Memo, text)
	end)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		Guivar2 = 0
		destroyElement(Fenster)
	end, false)
end, false)

local Ortvar = 0
addEventHandler("onClientGUIClick", POKnopf[7],  -- orten
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local spieler = getPlayerFromName(spieler)
	if(Ortvar == 1) then return end
	Ortvar = 1
	outputChatBox("Orte spieler...", 0, 255, 255)
	setTimer(
		function()
			if(getElementData(spieler, "pHandystate") == false) or (hasPlayerHandy(spieler) == false) then
				Ortvar = 0
				outputChatBox("Spieler konnte nicht geortet Werden!", 200, 0, 0)
			else
			
				local x, y, z = getElementPosition(spieler)
				local zone = getZoneName(x, y, z)
				outputChatBox("Spieler befindet sich in "..zone..".", 0, 255, 0, false)
				local pBlip = createBlipAttachedTo ( spieler, 0, 2, 0, 255, 0, 255, 0, 999999.0 )
				setTimer(destroyElement, 10000, 1, pBlip)
				setTimer(function() Ortvar = 0 end, 10000, 1)
			end
		end, math.random(15000, 20000), 1)
end, false)

addEventHandler("onClientGUIClick", POKnopf[6], -- Wanteds loeschen
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local anzahl = guiGetText(POEdit[1])
	if(anzahl == " ") or (anzahl == "") then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
	local anzahl = tonumber(anzahl)
	if(anzahl == 0) then return end
	if(anzahl < 0) then return end
	local grund = guiGetText(POEdit[2])
	if(gund == " ") or (grund == "") then grund = "N/A" end
	triggerServerEvent("onPoliceComputerSTVOLoesche", gMe, getPlayerFromName(spieler), anzahl, grund)
	setTimer(aktualisierercpdgridlist, 1000, 1)
end, false)

addEventHandler("onClientGUIClick", POKnopf[5], -- STVO's geben
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local anzahl = guiGetText(POEdit[1])
	if(anzahl == " ") or (anzahl == "") then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
	local anzahl = tonumber(anzahl)
	if(anzahl == 0) then return end
	if(anzahl < 0) then return end
	local grund = guiGetText(POEdit[2])
	if(gund == " ") or (grund == "") then grund = "N/A" end
	triggerServerEvent("onPoliceComputerSTVOGebe", gMe, getPlayerFromName(spieler), anzahl, grund)
	setTimer(aktualisierercpdgridlist, 1000, 1)
end, false)

addEventHandler("onClientGUIClick", POKnopf[4], -- Wanteds loeschen
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local anzahl = guiGetText(POEdit[1])
	if(anzahl == " ") or (anzahl == "") then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
	local anzahl = tonumber(anzahl)
	if(anzahl == 0) then return end
	if(anzahl < 0) then return end
	local grund = guiGetText(POEdit[2])
	if(gund == " ") or (grund == "") then grund = "N/A" end
	triggerServerEvent("onPoliceComputerWantedsLoesche", gMe, getPlayerFromName(spieler), anzahl, grund)
	setTimer(aktualisierercpdgridlist, 1000, 1)
end, false)

addEventHandler("onClientGUIClick", POKnopf[3], -- Wanteds Geben
function()
	local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
	if(spieler == "") or (spieler == " ") then return end
	local anzahl = guiGetText(POEdit[1])
	if(anzahl == " ") or (anzahl == "") then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
	local anzahl = tonumber(anzahl)
	if(anzahl == 0) then return end
	if(anzahl < 0) then return end
	local grund = guiGetText(POEdit[2])
	if(gund == " ") or (grund == "") then grund = "N/A" end
	triggerServerEvent("onPoliceComputerWantedsGebe", gMe, getPlayerFromName(spieler), anzahl, grund)
	setTimer(aktualisierercpdgridlist, 1000, 1)
end, false)

addEventHandler("onClientGUIClick", POKnopf[1], 
function()
	if(Guivar2 == 1) then return end
	destroyElement(POFenster[1])
	Guivar = 0
	showCursor(false)
	setElementData(gMe, "Clicked", 0)
end, false)

addEventHandler ( "onClientGUIClick", POGrid[1], 
function()
local spieler = guiGridListGetItemText ( POGrid[1], guiGridListGetSelectedItem ( POGrid[1] ), 1 )
if(spieler == " ") or (spieler == "") then guiSetText(POLabel[4], "Spielername: N/A\nFraktion: N/A\nFraktionsrang: N/A\nWanteds: N/A\nSTVO-Punkte: N/A") return end
local spieler = getPlayerFromName(spieler)
if not(spieler) then return end
		local name = getPlayerName(spieler)
		local fraktion = tonumber(getElementData(spieler, "pFraktion"))
		local rang = tonumber(getElementData(spieler, "pFraktionsrang"))
		local wanteds = tonumber(getElementData(spieler, "pWanteds"))
		local stvos = tonumber(getElementData(spieler, "pSTVO"))
		if not(wanteds) then wanteds = 0 end
		if not(stvos) then stvos = 0 end
		if not(fraktion) then fraktion = "N/A"
		else
			fraktion = fraktionNamen[fraktion]
		end
		if not(rang) then rang = "N/A" end
	guiSetText(POLabel[4], "Spielername: "..name.."\nFraktion: "..fraktion.."\nFraktionsrang: "..rang.."\nWanteds: "..wanteds.."\nSTVO-Punkte: "..stvos)
end, false )

end

local pVar = 0
bindKey("num_add", "down",
function()
	if(isPedInVehicle(gMe) == false) then return end
	local veh = getPedOccupiedVehicle(gMe)
	if not(veh) then return end
	if(getElementData(veh, "Besitzer") == "RCPD") or (getElementData(veh, "Besitzer") == "FBI") or (getElementData(veh, "Besitzer") == "FBI/RCPD") then
		if(getPlayerFraktion(gMe) == 4) or (getPlayerFraktion(gMe) == 7) then else return end
		if(getElementModel(veh) == getVehicleModelFromName("Dodo")) then return end
		if(tonumber(getElementData(gMe, "dienst")) == 0) or (tonumber(getElementData(gMe, "dienst")) == nil) then outputChatBox("Du bist nicht im Dienst!", 200, 0, 0, false) return end 
		if(pVar == 0) then
			createPoliceComputer()
			pVar = 1
		elseif(pVar == 1) then
			if(Guivar2 == 1) then return end
			destroyElement(POFenster[1])
			Guivar = 0
			showCursor(false)
			pVar = 0
			setElementData(gMe, "Clicked",0)
		end
	end
end)

function aktualisierercpdgridlist()
	guiGridListClear(POGrid[1])
	for index,spieler in pairs ( getElementsByType("player") ) do
		local name = getPlayerName(spieler)
		local fraktion = tonumber(getElementData(spieler, "pFraktion"))
		--local rang = tonumber(getElementData(spieler, "pFraktionsrang"))
		local wanteds = tonumber(getElementData(spieler, "pWanteds"))
		--local stvos = tonumber(getElementData(spieler, "pSTVO"))
		if not(wanteds) then wanteds = 0 end
		--if not(stvos) then stvos = 0 end
		if not(fraktion) then fraktion = "N/A"
		else
			fraktion = fraktionNamen[fraktion]
		end
		--if not(rang) then rang = "N/A" end
		
		local spielerrow = guiGridListAddRow(POGrid[1])
		guiGridListSetItemText(POGrid[1],spielerrow,1,name,false,false)
		guiGridListSetItemText(POGrid[1],spielerrow,2,fraktion,false,false)
		guiGridListSetItemText(POGrid[1],spielerrow,3,wanteds,false,false)
	end
end
addEvent("start_policecomputer", true)
addEventHandler("start_policecomputer", gMe,
function()
if not(source == gMe) then return end
	createPoliceComputer()
end)