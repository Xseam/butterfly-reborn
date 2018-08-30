--[[ 
|===================|
|Script bei MuLTi   |
|[C]2012            |
|===================|

He, Du!
Falls du was hiervon haben moechtest,
Frage die Person, die das gemacht hat!(MuLTi)
Kopieren und Einfuegen ist Scheisse.

 --]]

fraktionNamen = {
	[0] = "Zivilist",
	[1] = "Yakuza",
	[2] = "Terroristen",
	[3] = "Fahrschule",
	[4] = "RCPD",
	[5] = "RCNR",
	[6] = "Red Brothers",
	[7] = "FBI",
}

local Guivar = 0
local Ruestungspreis = 100

addEventHandler("onClientRender", getRootElement(),
function()
	if(Guivar == 1) then showCursor(true) end
end)
local PCFenster = {}
local PCKnopf = {}
local PCCheckbox = {}
local PCLabel = {}
local PCEdit = {}
local PCGrid = {}

function createFactionGUI()
if(Guivar == 1) then return end
if(getElementData(gMe, "Clicked") == 1) then return end
Guivar = 1
setElementData(gMe, "Clicked", 1)
guiSetInputMode("no_binds_when_editing")
toggleAllControls(false)

showCursor(true)

	
	local myFraktion = tonumber(getElementData(gMe, "pFraktion"))
	local myRank = tonumber(getElementData(gMe, "pFraktionsrang"))
	if not(myRank) then myRank = 0 end

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 766,251
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	

PCFenster[1] = guiCreateWindow(X, Y, Width, Height,"FraktionsGUI",false)
PCLabel[1] = guiCreateLabel(13,32,466,42,"Fraktionscomputer Version: 1.0\nWillkommen, "..getPlayerName(gMe).."! Du bist in der Fraktion: '"..fraktionNamen[tonumber(getElementData(gMe, "pFraktion"))].."' .\n____________________________________________________________________________",false,PCFenster[1])
guiSetFont(PCLabel[1],"default-bold-small")
PCKnopf[1] = guiCreateButton(11,95,116,30,"Ruestung Bestellen",false,PCFenster[1])
PCKnopf[2] = guiCreateButton(11,133,116,30,"Waffen Bestellen",false,PCFenster[1])
PCCheckbox[1] = guiCreateCheckBox(374,84,89,21,"9mm",false,false,PCFenster[1])
PCCheckbox[2] = guiCreateCheckBox(374,108,89,21,"Deagle",false,false,PCFenster[1])
PCCheckbox[3] = guiCreateCheckBox(374,133,89,21,"Messer",false,false,PCFenster[1])
PCCheckbox[4] = guiCreateCheckBox(374,157,89,21,"MP5",false,false,PCFenster[1])
PCCheckbox[5] = guiCreateCheckBox(374,178,89,21,"AK-47",false,false,PCFenster[1])
PCCheckbox[6] = guiCreateCheckBox(374,199,102,23,"Raketenwerfer",false,false,PCFenster[1])
PCCheckbox[7] = guiCreateCheckBox(374,221,103,23,"Granaten",false,false,PCFenster[1])
PCCheckbox[8] = guiCreateCheckBox(298,82,75,22,"Sniper",false,false,PCFenster[1])
PCCheckbox[9] = guiCreateCheckBox(298,103,75,22,"Shotgun",false,false,PCFenster[1])
PCCheckbox[10] = guiCreateCheckBox(298,123,75,22,"RPG",false,false,PCFenster[1])
PCCheckbox[11] = guiCreateCheckBox(298,142,75,22,"SPAZ-12",false,false,PCFenster[1])
PCCheckbox[12] = guiCreateCheckBox(298,161,75,22,"M4",false,false,PCFenster[1])
--[[
1 = 9mm
2 = Deagle
3 = Messer
4 = MP5
5 = AK-47
6 = Raketenwerfer
7 = Granaten
8 = Sniper
9 = Shotgun
10 = RPG
11 = Spaz-12
12 = M4
--]]

PCLabel[5] = guiCreateLabel(667,149,88,20,"Rank: 0",false,PCFenster[1])
guiSetFont(PCLabel[5],"default-bold-small")
PCLabel[6] = guiCreateLabel(666,168,92,40,"Mitglied seit:",false,PCFenster[1])
guiSetFont(PCLabel[6],"default-bold-small")

if(myFraktion == 1) then -- Yakuza
	guiSetEnabled(PCCheckbox[9], false)
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[12], false)
	guiSetEnabled(PCCheckbox[6], false)
elseif(myFraktion == 2) then -- Terror
	guiSetEnabled(PCCheckbox[1], false)
	guiSetEnabled(PCCheckbox[2], false)
	guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[4], false)
	guiSetEnabled(PCCheckbox[5], false)
	guiSetEnabled(PCCheckbox[6], false)
	guiSetEnabled(PCCheckbox[7], false)
	guiSetEnabled(PCCheckbox[8], false)
	guiSetEnabled(PCCheckbox[9], false)
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[12], false)
	guiSetEnabled(PCKnopf[1], false)
	guiSetEnabled(PCKnopf[2], false)
elseif(myFraktion == 3) then -- Fahrschule
	--guiSetEnabled(PCCheckbox[1], false)
	guiSetEnabled(PCCheckbox[2], false)
	--guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[4], false)
	guiSetEnabled(PCCheckbox[5], false)
	guiSetEnabled(PCCheckbox[6], false)
	guiSetEnabled(PCCheckbox[7], false)
	guiSetEnabled(PCCheckbox[8], false)
	guiSetEnabled(PCCheckbox[9], false)
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[12], false)
	--guiSetEnabled(PCKnopf[1], false)
	--guiSetEnabled(PCKnopf[2], false)
	elseif(myFraktion == 4) then -- RCPD
	guiSetEnabled(PCCheckbox[5], false)
	guiSetEnabled(PCCheckbox[6], false)
	guiSetEnabled(PCCheckbox[7], false)
	guiSetEnabled(PCCheckbox[8], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[12], false)
elseif(myFraktion == 5) then -- RCNR
	guiSetEnabled(PCCheckbox[1], false)
	guiSetEnabled(PCCheckbox[2], false)
	guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[3], false)
	guiSetEnabled(PCCheckbox[4], false)
	guiSetEnabled(PCCheckbox[5], false)
	guiSetEnabled(PCCheckbox[6], false)
	guiSetEnabled(PCCheckbox[7], false)
	guiSetEnabled(PCCheckbox[8], false)
	guiSetEnabled(PCCheckbox[9], false)
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[12], false)
	--guiSetEnabled(PCKnopf[1], false)
	guiSetEnabled(PCKnopf[2], false)
elseif(myFraktion == 6) then -- RED BROTHERS
	guiSetEnabled(PCCheckbox[10], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[12], false)
	guiSetEnabled(PCCheckbox[6], false)
elseif(myFraktion == 7) then -- FBI
	guiSetEnabled(PCCheckbox[5], false)
	guiSetEnabled(PCCheckbox[6], false)
	guiSetEnabled(PCCheckbox[7], false)
	guiSetEnabled(PCCheckbox[8], false)
	guiSetEnabled(PCCheckbox[11], false)
	guiSetEnabled(PCCheckbox[610], false)
end

PCKnopf[3] = guiCreateButton(12,167,116,30,"Fahrzeuge\nRespawnen",false,PCFenster[1])
local sOnline = 0
local sAllgemein = 0
for index,spieler in pairs ( getElementsByType("player") ) do
	sAllgemein = (sAllgemein+1)
	if(tonumber(getElementData(spieler, "pFraktion")) == myFraktion) then
		sOnline = (sOnline+1)
	end
end

PCLabel[2] = guiCreateLabel(143,87,153,19,"Mitglieder Online: "..sOnline.."/"..sAllgemein,false,PCFenster[1])
guiSetFont(PCLabel[2],"default-bold-small")

local carVar = 0
for index,veh in pairs ( getElementsByType("vehicle") ) do
	if(getElementData(veh, "Besitzer") == fraktionNamen[myFraktion]) then
		carVar = (carVar+1)
	end
end
PCLabel[3] = guiCreateLabel(142,103,153,19,"Fraktionsfahrzeuge: "..carVar,false,PCFenster[1])
guiSetFont(PCLabel[3],"default-bold-small")
PCLabel[4] = guiCreateLabel(142,121,153,19,"Fraktionskasse: 0 $",false,PCFenster[1])
guiSetFont(PCLabel[4],"default-bold-small")
guiSetEnabled(PCLabel[4], false)
PCEdit[1] = guiCreateEdit(142,138,129,28,"",false,PCFenster[1])
PCKnopf[4] = guiCreateButton(142,170,67,22,"Einzahlen",false,PCFenster[1])
PCKnopf[5] = guiCreateButton(215,170,67,22,"Auszahlen",false,PCFenster[1])
--guiSetEnabled(PCKnopf[4], false)
--guiSetEnabled(PCKnopf[5], false)
PCKnopf[6] = guiCreateButton(172,204,116,30,"Abbrechen",false,PCFenster[1])
PCGrid[1] = guiCreateGridList(484,25,177,217,false,PCFenster[1])
guiGridListSetSelectionMode(PCGrid[1],1)

guiGridListAddColumn(PCGrid[1],"Spieler",0.55)

guiGridListAddColumn(PCGrid[1],"Rank",0.2)

addEventHandler("onClientGUIClick", PCKnopf[5],
function()
	local text = guiGetText(PCEdit[1])
	if(text == "") or (text == " ") then return end
	local text = tonumber(text)
	if(text == 0) or (text < 0) then return end
	triggerServerEvent("onFraktionspcKasseAuszahl", gMe, text)
	triggerServerEvent("onFraktionspcDataNeed", gMe)
end, false)

addEventHandler("onClientGUIClick", PCKnopf[4],
function()
	local text = guiGetText(PCEdit[1])
	if(text == "") or (text == " ") then return end
	local text = tonumber(text)
	if(text > tonumber(getElementData(gMe, "pHGeld"))) then outputChatBox("Du hast nicht soviel Geld!", 200, 0, 0, false) return end
	if(text == 0) or (text < 0) then return end
	triggerServerEvent("onFraktionspcKasseEinzahl", gMe, text)
	triggerServerEvent("onFraktionspcDataNeed", gMe)
end, false)



for index,spieler in pairs ( getElementsByType("player") ) do
	if(tonumber(getElementData(spieler, "pFraktion")) == myFraktion) then
		local name = getPlayerName(spieler)
		local row = guiGridListAddRow(PCGrid[1])
		guiGridListSetItemText(PCGrid[1],row,1,name,false,false)
		local rank = tonumber(getElementData(spieler, "pFraktionsrang"))
		if not (rank) then rank = 0 end
		guiGridListSetItemText(PCGrid[1],row,2,rank,false,false)
	end
end

PCKnopf[7] = guiCreateButton(667,47,89,27,"Rank Up",false,PCFenster[1])
PCKnopf[8] = guiCreateButton(667,82,89,27,"Rank Down",false,PCFenster[1])
PCKnopf[9] = guiCreateButton(667,115,89,27,"Uninvite",false,PCFenster[1])
PCKnopf[10] = guiCreateButton(11,202,116,30,"Skin Wechseln",false,PCFenster[1])
PCLabel[7] = guiCreateLabel(296,188,73,56,"Lager:\n\n0\nWaffen.",false,PCFenster[1])
guiSetFont(PCLabel[7],"default-bold-small")
triggerServerEvent("onFraktionspcDataNeed", gMe)
addEvent("onFraktionspcDataNeedBack", true)
addEventHandler("onFraktionspcDataNeedBack", gMe,
function(var, waffen)
	if not(source == gMe) then return end
	guiSetText(PCLabel[4], "Fraktionskasse: "..var.." $")
	guiSetText(PCLabel[7], "Lager:\n"..waffen.."\nWaffen.")
end)
if(myRank < 5) then
guiSetEnabled(PCGrid[1], false)
guiSetEnabled(PCKnopf[7], false)
guiSetEnabled(PCKnopf[8], false)
guiSetEnabled(PCKnopf[9], false)
end

addEventHandler("onClientGUIClick", PCKnopf[3],
function()
	if(myRank < 5) then outputChatBox("Nur Leader und Co-Leader koennen Fraktionsfahrzeuge Respawnen!", 200, 0, 0, false) return end
	if(myFraktion == 1) then
	triggerServerEvent("onYakuzaCarRespawn", gMe)
	elseif(myFraktion == 2) then
	triggerServerEvent("onTerrorCarRespawn", gMe)
	elseif(myFraktion == 3) then
	triggerServerEvent("onFahrschulCarRespawn", gMe)
	elseif(myFraktion == 4) then
	triggerServerEvent("onrcpdCarRespawn", gMe)
	elseif(myFraktion == 5) then
	triggerServerEvent("onrcnrCarRespawn", gMe)
	elseif(myFraktion == 6) then
	triggerServerEvent("onRedBrothersCarRespawn", gMe)
	elseif(myFraktion == 7) then
	triggerServerEvent("onFBICarRespawn", gMe)
	end
end, false)

addEventHandler("onClientGUIClick", PCKnopf[9],
function()
	local player = guiGridListGetItemText ( PCGrid[1], guiGridListGetSelectedItem ( PCGrid[1] ), 1 )
	if(player == " ") or (player == "") then outputChatBox("Spieler nicht gefunden.", 200, 0, 0, false) return end
	local player = getPlayerFromName(player)
	if not(player) then return end
	if(tonumber(getElementData(player, "pFraktion")) ~= tonumber(getElementData(gMe, "pFraktion"))) then outputChatBox("Der Spieler ist nicht in deiner Fraktion!", 225, 0, 0, false) return end
	if(tonumber(getElementData(player, "pFraktionsrang")) > 4) then outputChatBox("Du kannst keine Leader & Co-Leader Uninviten!", 225, 0, 0, false) return end
	triggerServerEvent("onFraktionUninvite", gMe, player)
	setTimer(reloadFraktionsGrid, 1000, 1)
	--outputChatBox("Test")
end, false)

addEventHandler("onClientGUIClick", PCKnopf[8],
function()
	local player = guiGridListGetItemText ( PCGrid[1], guiGridListGetSelectedItem ( PCGrid[1] ), 1 )
	if(player == " ") or (player == "") then outputChatBox("Spieler nicht gefunden.", 200, 0, 0, false) return end
	triggerServerEvent("onFraktionRankdown", gMe, player)
	setTimer(reloadFraktionsGrid, 1000, 1)
	--outputChatBox("Test")
end, false)

addEventHandler("onClientGUIClick", PCKnopf[7],
function()
	local player = guiGridListGetItemText ( PCGrid[1], guiGridListGetSelectedItem ( PCGrid[1] ), 1 )
	if(player == " ") or (player == "") then outputChatBox("Spieler nicht gefunden.", 200, 0, 0, false) return end
	triggerServerEvent("onFraktionRankup", gMe, player)
	setTimer(reloadFraktionsGrid, 1000, 1)
end, false)

--triggerServerEvent("onFraktionsPCInfos", gMe)
addEventHandler("onClientGUIClick", PCKnopf[2],
function()
local CH1 = guiCheckBoxGetSelected(PCCheckbox[1])
local CH2 = guiCheckBoxGetSelected(PCCheckbox[2])
local CH3 = guiCheckBoxGetSelected(PCCheckbox[3])
local CH4 = guiCheckBoxGetSelected(PCCheckbox[4])
local CH5 = guiCheckBoxGetSelected(PCCheckbox[5])
local CH6 = guiCheckBoxGetSelected(PCCheckbox[6])
local CH7 = guiCheckBoxGetSelected(PCCheckbox[7])
local CH8 = guiCheckBoxGetSelected(PCCheckbox[8])
local CH9 = guiCheckBoxGetSelected(PCCheckbox[9])
local CH10 = guiCheckBoxGetSelected(PCCheckbox[10])
local CH11 = guiCheckBoxGetSelected(PCCheckbox[11])
local CH12 = guiCheckBoxGetSelected(PCCheckbox[12])
triggerServerEvent("onFraktionsWaffen", gMe, CH1, CH2, CH3, CH4, CH5, CH6, CH7, CH8, CH9, CH10, CH11, CH12)
end, false)


addEventHandler("onClientGUIClick", PCKnopf[10],
function()
	triggerServerEvent("onFraktionsSkin", gMe)
end, false)




addEventHandler ( "onClientGUIClick", PCGrid[1], 
function()
local player = guiGridListGetItemText ( PCGrid[1], guiGridListGetSelectedItem ( PCGrid[1] ), 1 )
if(player == " ") or (player == "") then return end
local player = getPlayerFromName(player)
if not(player) then return end
	guiSetText(PCLabel[5], "Rank: "..tonumber(getElementData(player, "pFraktionsrang")))
end, false )

addEventHandler("onClientGUIClick", PCKnopf[1],
function()
	local money = getPlayerMoney()
	if(money < Ruestungspreis+1) then outputChatBox("Du benoetigst "..Ruestungspreis.." $!", 255, 0, 0, false) return end
	fadeCamera(false)
		setTimer(
		function()
		fadeCamera(true)
		givePlayerMoney(-Ruestungspreis)
		triggerServerEvent("onFraktionsPCArmor", gMe)
		showLebenKurz()
		aktualisiereMoney_func()
		setHunger("Full")
		end, 1500, 1)
end, false)

addEventHandler("onClientGUIClick", PCKnopf[6],
function()
	destroyElement(PCFenster[1])
	showCursor(false)
	Guivar = 0
	toggleAllControls(true)
	setElementData(gMe, "Clicked", 0)
end, false)

end

addEvent("onFraktionsGUIStart", true)
addEventHandler("onFraktionsGUIStart", gMe, 
function()
if not(source == gMe) then return end
createFactionGUI()
end)


function reloadFraktionsGrid()
guiGridListClear(PCGrid[1])
local myFraktion = tonumber(getElementData(gMe, "pFraktion"))
local myRank = tonumber(getElementData(gMe, "pFraktionsrang"))
for index,spieler in pairs ( getElementsByType("player") ) do
	if(tonumber(getElementData(spieler, "pFraktion")) == myFraktion) then
		local name = getPlayerName(spieler)
		local row = guiGridListAddRow(PCGrid[1])
		guiGridListSetItemText(PCGrid[1],row,1,name,false,false)
		local rank = tonumber(getElementData(spieler, "pFraktionsrang"))
		if not (rank) then rank = 0 end
		guiGridListSetItemText(PCGrid[1],row,2,rank,false,false)
	end
end
end