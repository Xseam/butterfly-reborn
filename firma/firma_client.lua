
local scX, scY = guiGetScreenSize();
local l_w      = 64;
local l_h      = 64;
local l_ratio  = l_w / l_h;
local lscale_w = 1920 / scX;
l_w            = l_w / lscale_w;
l_h            = l_w / l_ratio;

local randomn = 1

addEventHandler( 'onClientRender', root, function()
  for i, v in pairs( getElementsByType( 'colshape' )) do
	if getElementData( v, "FIRMA")  == true then

      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, true, false, false, false, false, false, false, v ) then
        local dist = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z );

		if dist >= 5 and dist <= 75 then
          local px, py = getScreenFromWorldPosition( x, y, z + 1.0, 0.06 );
		  local px2, py2 = getScreenFromWorldPosition( x, y, z + 1.2, 0.06 );
          if px and px2 then
				local name = getElementData(v, "FNAME")
				local besitzer = getElementData(v, "FBESITZER")
				if(name) and (besitzer) then
					dxDrawText( "Firma:\n"..name.."\nIm Besitz von:\n"..besitzer, px + 1, py + scY/38, px + 1, py + 1, tocolor( 0, 0, 0, 255 ), 0.4, schrift, 'center', 'center', false, false )
					dxDrawText( "Firma:\n"..name.."\nIm Besitz von:\n"..besitzer, px, py + scY/38, px, py, tocolor( 255, 255, 255, 255 ), 0.4, schrift, 'center', 'center', false, false )
				end
				 dxDrawImage( px2-l_w/2, py2 - scY/17, l_w, l_h, 'data/images/firma/'..randomn..'.png', 0, 0, 0)
			  end
			end

      end
    end
  end
end )



setTimer(
	function()
	if(randomn == 1) then
		randomn = 2
	elseif(randomn == 2) then
		randomn = 1
	end
end, 2500, 0)


local Guivar = 0
local Guivar2 = 0
local Guivar3 = 0

function createFirmenManagementGui(cole)
	if(Guivar3 == 1) then return end
	Guivar3 = 1
	showCursor(true)
	local col = cole
	
	local FIMMFenster = {}
	local FIMMKnopf = {}
	local FIMMMemo = {}
	local FIMMCheckbox = {}
	local FIMMLabel = {}
	local FIMMEdit = {}
	local FIMMGrid = {}

	local name = getElementData(col, "FNAME")
	local besitzer = getElementData(col, "FBESITZER")
	local angestellte = getElementData(col, "FANGESTELLTE")
	local beschreibung = getElementData(col, "FBESCHREIBUNG")
	local lohn = getElementData(col, "FLOHN")
	local X, Y, Width, Height
	if(besitzer == getPlayerName(gMe)) then
		X, Y, Width, Height = getMiddleGuiPosition(699,428)
	else
		X, Y, Width, Height = getMiddleGuiPosition(699,231)
	end
	FIMMFenster[1] = guiCreateWindow(X, Y, Width, Height, "Firmenmanagement",false)
	FIMMLabel[1] = guiCreateLabel(10,25,370,18,"Firma: "..name..", im Besitz von: "..besitzer,false,FIMMFenster[1])
	guiSetFont(FIMMLabel[1],"default-bold-small")
	FIMMLabel[2] = guiCreateLabel(8,31,202,14,"______________________",false,FIMMFenster[1])
	guiLabelSetColor(FIMMLabel[2],0, 255, 255)
	FIMMLabel[3] = guiCreateLabel(9,47,133,18,"Firmenname Aendern:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[3],"default-bold-small")
	FIMMEdit[1] = guiCreateEdit(9,65,156,26,name,false,FIMMFenster[1])
	FIMMLabel[4] = guiCreateLabel(9,94,182,15,"Firmenbeschreibung aendern:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[4],"default-bold-small")
	FIMMMemo[1] = guiCreateMemo(10,114,217,106,beschreibung,false,FIMMFenster[1])
	FIMMLabel[5] = guiCreateLabel(236,46,97,17,"Lohn Einstellen:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[5],"default-bold-small")
	FIMMEdit[2] = guiCreateEdit(236,64,94,23,lohn,false,FIMMFenster[1])
	FIMMLabel[6] = guiCreateLabel(332,65,27,25,"$",false,FIMMFenster[1])
	FIMMLabel[7] = guiCreateLabel(249,89,68,16,"(20-200$)",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[7],"default-bold-small")
	FIMMKnopf[1] = guiCreateButton(596,24,92,30,"Schliessen",false,FIMMFenster[1])
	FIMMKnopf[2] = guiCreateButton(239,150,93,30,"Firma verkaufen",false,FIMMFenster[1])
	FIMMCheckbox[1] = guiCreateCheckBox(239,118,88,22,"Bestaetigen",false,false,FIMMFenster[1])
	guiCheckBoxSetSelected(FIMMCheckbox[1],false)
	guiSetFont(FIMMCheckbox[1],"default-bold-small")
	FIMMGrid[1] = guiCreateGridList(360,64,215,156,false,FIMMFenster[1])
	guiGridListSetSelectionMode(FIMMGrid[1],2)

	guiGridListAddColumn(FIMMGrid[1],"Name",0.8)
	local angestellte = getElementData(col, "FANGESTELLTE")
	local an1 = gettok(angestellte, 1, "|")
	local an2 = gettok(angestellte, 2, "|")
	local an3 = gettok(angestellte, 3, "|")
	local an4 = gettok(angestellte, 4, "|")
	local an5 = gettok(angestellte, 5, "|")
	if(an1 ~= "-") then
		local row = guiGridListAddRow(FIMMGrid[1])
		guiGridListSetItemText(FIMMGrid[1], row, 1, an1, false, false)
	end
	if(an2 ~= "-") then
		local row = guiGridListAddRow(FIMMGrid[1])
		guiGridListSetItemText(FIMMGrid[1], row, 1, an2, false, false)
	end
	if(an3 ~= "-") then
		local row = guiGridListAddRow(FIMMGrid[1])
		guiGridListSetItemText(FIMMGrid[1], row, 1, an3, false, false)
	end
	if(an4 ~= "-") then
		local row = guiGridListAddRow(FIMMGrid[1])
		guiGridListSetItemText(FIMMGrid[1], row, 1, an4, false, false)
	end
	if(an5 ~= "-") then
		local row = guiGridListAddRow(FIMMGrid[1])
		guiGridListSetItemText(FIMMGrid[1], row, 1, an5, false, false)
	end
	FIMMLabel[8] = guiCreateLabel(370,33,158,15,"Angestellte:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[8],"default-bold-small")
	FIMMLabel[9] = guiCreateLabel(365,36,144,17,"________________",false,FIMMFenster[1])
	guiLabelSetColor(FIMMLabel[9],0,255,255)
	if(besitzer == getPlayerName(gMe)) then
	FIMMGrid[2] = guiCreateGridList(361,261,215,156,false,FIMMFenster[1])
	guiGridListSetSelectionMode(FIMMGrid[2],2)

	guiGridListAddColumn(FIMMGrid[2],"Name",0.8)
	for index, player in pairs(getElementsByType("player")) do
		local name = getPlayerName(player)
		local row = guiGridListAddRow(FIMMGrid[2])
		guiGridListSetItemText(FIMMGrid[2], row, 1, name, false, false)
	end
	FIMMGrid[3] = guiCreateGridList(16,244,311,175,false,FIMMFenster[1])
	guiGridListSetSelectionMode(FIMMGrid[3],2)

	guiGridListAddColumn(FIMMGrid[3],"Firmenname",0.6)

	guiGridListAddColumn(FIMMGrid[3],"Besitzer",0.3)
	for index, sp in pairs(getElementsByType("colshape")) do
		if(getElementData(sp, "FIRMA") == true) then
			local name = getElementData(sp, "FNAME")
			local besitzer = getElementData(sp, "FBESITZER")
			local row = guiGridListAddRow(FIMMGrid[3])
			guiGridListSetItemText(FIMMGrid[3], row, 1, name, false, false)
			guiGridListSetItemText(FIMMGrid[3], row, 2, besitzer, false, false)
		end
	end
	FIMMLabel[10] = guiCreateLabel(369,230,74,17,"Spielerliste:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[10],"default-bold-small")
	FIMMLabel[11] = guiCreateLabel(365,234,144,17,"________________",false,FIMMFenster[1])
	guiLabelSetColor(FIMMLabel[11],0,255,255)
	FIMMLabel[12] = guiCreateLabel(21,225,141,16,"Vorhandene Firmen:",false,FIMMFenster[1])
	guiSetFont(FIMMLabel[12],"default-bold-small")
	FIMMKnopf[3] = guiCreateButton(581,297,108,28,"<-- Einstellen",false,FIMMFenster[1])
	FIMMKnopf[4] = guiCreateButton(581,99,104,28,"<-- Kuendigen",false,FIMMFenster[1])
	end
	addEventHandler("onClientGUIClick", FIMMKnopf[1],
	function()
		Guivar3 = 0
		showCursor(false)
		guiSetVisible(FIMMFenster[1], false)
		if(getElementData(col, "FBESITZER") == getPlayerName(gMe)) then
			local name = guiGetText(FIMMEdit[1])
			local beschreibung = guiGetText(FIMMMemo[1])
			local lohn = tonumber(guiGetText(FIMMEdit[2]))
			if not(lohn) then return end
			triggerServerEvent("onFirmenSettingsChange", gMe, col, name, beschreibung, lohn)
			end
	end, false)
end

function createFirmenVorschauGui(col)
	if(Guivar2 == 1) then return end
	Guivar2 = 1
	showCursor(true)
	
	local FIVFenster = {}
	local FIVKnopf = {}
	local FIVMemo = {}
	local FIVLabel = {}
	local FIVGrid = {}

	local name = getElementData(col, "FNAME")
	local besitzer = getElementData(col, "FBESITZER")
	local angestellte = getElementData(col, "FANGESTELLTE")
	local beschreibung = getElementData(col, "FBESCHREIBUNG")
	local X, Y, Width, Height = getMiddleGuiPosition(523,218)
	FIVFenster[1] = guiCreateWindow(X, Y, Width, Height, "Firmeninfo",false)
	FIVLabel[1] = guiCreateLabel(13,46,261,33,"Firmenname: "..name.."\nFirmenbesitzer: "..besitzer,false,FIVFenster[1])
	guiSetFont(FIVLabel[1],"default-bold-small")
	FIVLabel[2] = guiCreateLabel(10,21,75,15,"Allgemein:",false,FIVFenster[1])
	guiSetFont(FIVLabel[2],"default-bold-small")
	FIVLabel[3] = guiCreateLabel(12,25,76,18,"__________",false,FIVFenster[1])
	guiLabelSetColor(FIVLabel[3],0, 255, 255)
	guiSetFont(FIVLabel[3],"default-bold-small")
	FIVLabel[4] = guiCreateLabel(12,90,75,18,"Angestellte:",false,FIVFenster[1])
	guiSetFont(FIVLabel[4],"default-bold-small")
	FIVLabel[5] = guiCreateLabel(12,94,76,18,"__________",false,FIVFenster[1])
	guiLabelSetColor(FIVLabel[5],0,255,255)
	guiSetFont(FIVLabel[5],"default-bold-small")
	FIVGrid[1] = guiCreateGridList(12,112,168,97,false,FIVFenster[1])
	guiGridListSetSelectionMode(FIVGrid[1],2)

	guiGridListAddColumn(FIVGrid[1],"Spielername",0.7)
	local angestellte = getElementData(col, "FANGESTELLTE")
	local an1 = gettok(angestellte, 1, "|")
	local an2 = gettok(angestellte, 2, "|")
	local an3 = gettok(angestellte, 3, "|")
	local an4 = gettok(angestellte, 4, "|")
	local an5 = gettok(angestellte, 5, "|")
	if(an1 ~= "-") then
		local row = guiGridListAddRow(FIVGrid[1])
		guiGridListSetItemText(FIVGrid[1], row, 1, an1, false, false)
	end
	if(an2 ~= "-") then
		local row = guiGridListAddRow(FIVGrid[1])
		guiGridListSetItemText(FIVGrid[1], row, 1, an2, false, false)
	end
	if(an3 ~= "-") then
		local row = guiGridListAddRow(FIVGrid[1])
		guiGridListSetItemText(FIVGrid[1], row, 1, an3, false, false)
	end
	if(an4 ~= "-") then
		local row = guiGridListAddRow(FIVGrid[1])
		guiGridListSetItemText(FIVGrid[1], row, 1, an4, false, false)
	end
	if(an5 ~= "-") then
		local row = guiGridListAddRow(FIVGrid[1])
		guiGridListSetItemText(FIVGrid[1], row, 1, an5, false, false)
	end
	FIVKnopf[1] = guiCreateButton(189,182,115,27,"Schliessen",false,FIVFenster[1])
	FIVMemo[1] = guiCreateMemo(281,52,230,108,beschreibung,false,FIVFenster[1])
	guiMemoSetReadOnly(FIVMemo[1], true)
	FIVLabel[6] = guiCreateLabel(282,22,124,15,"Firmenbeschreibung:",false,FIVFenster[1])
	guiSetFont(FIVLabel[6],"default-bold-small")
	FIVLabel[7] = guiCreateLabel(281,26,129,18,"_________________",false,FIVFenster[1])
	guiLabelSetColor(FIVLabel[7],0,255,255)
	guiSetFont(FIVLabel[7],"default-bold-small")
	local cola = getPlayerFirma(gMe)
	if(cola == col) then
		FIVKnopf[2] = guiCreateButton(309,181,147,28,"Management Oeffnen",false,FIVFenster[1])
		addEventHandler("onClientGUIClick", FIVKnopf[2],
		function()
			Guivar2 = 0
			showCursor(false)
			guiSetVisible(FIVFenster[1], false)
			createFirmenManagementGui(col)
		end, false)
	end
	
	addEventHandler("onClientGUIClick", FIVKnopf[1],
	function()
		Guivar2 = 0
		showCursor(false)
		guiSetVisible(FIVFenster[1], false)
	end, false)
end

addEventHandler("onClientColShapeHit", getRootElement(),
function(hitElement)
	if(hitElement ~= gMe) then return end
	if(getElementData(source, "FIRMA") == true) then
		createFirmenVorschauGui(source)
	end
end)

function createFirmenErstellungsGui()
	if(getPlayerFirma(gMe) ~= false) then outputChatBox("Du hast bereits eine Firma/bist Angestellter!", 200, 0, 0, false) return end
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	
	local FIFenster = {}
	local FITabPanel = {}
	local FITab = {}
	local FIKnopf = {}
	local FIMemo = {}
	local FILabel = {}
	local FIEdit = {}

	local X, Y, Width, Height = getMiddleGuiPosition(625,284)
	FIFenster[1] = guiCreateWindow(X, Y, Width, Height, "Firmenfenster",false)
	FITabPanel[1] = guiCreateTabPanel(9,21,607,221,false,FIFenster[1])
	FITab[1] = guiCreateTab("Allgemeine Informationen",FITabPanel[1])
	FILabel[1] = guiCreateLabel(6,2,593,42,"Willkommen im Firmen-erstellungsformular! Hier kannst du eine Firma erstellen. Du benoetigst gewisse\nVoraussetzungen, um eine Firma zu erstellen. Hier werden sie aufgelistet.",false,FITab[1])
	guiLabelSetHorizontalAlign(FILabel[1],"center",false)
	guiSetFont(FILabel[1],"default-bold-small")
	FILabel[2] = guiCreateLabel(10,44,114,19,"Voraussetzungen:",false,FITab[1])
	guiSetFont(FILabel[2],"default-bold-small")
	FILabel[3] = guiCreateLabel(10,48,114,19,"_________________",false,FITab[1])
	guiLabelSetColor(FILabel[3],0, 255, 0)
	guiSetFont(FILabel[3],"default-bold-small")
	FILabel[4] = guiCreateLabel(9,67,101,68,"- Aktives Spielen\n- 50 Spielstunden\n- "..Firmenpreis.."$\n- Fairer Lohn",false,FITab[1])
	guiSetFont(FILabel[4],"default-bold-small")
	FILabel[5] = guiCreateLabel(141,62,448,64,"Solltest du diese Voraussetzungen erfuellen, steht dir die Erstellung einer Firma\nnichts mehr im Wege.\nBeachte, dass ein Admin dir wann immer er moechte, deine Firma kontrollieren \nkann, und bei falschen Taten, sie auch loeschen kann.(Passiert seht selten)",false,FITab[1])
	guiSetFont(FILabel[5],"default-bold-small")
	FILabel[6] = guiCreateLabel(7,143,592,20,"Maximale Angestellte: 5, Minimaler Lohn: 20$, Maximaler Lohn: 200$, Lohn wird von der Bank abgezogen.",false,FITab[1])
	guiSetFont(FILabel[6],"default-bold-small")
	FITab[2] = guiCreateTab("Erstellung",FITabPanel[1])
	FILabel[7] = guiCreateLabel(14,7,100,21,"Name der Firma:",false,FITab[2])
	guiSetFont(FILabel[7],"default-bold-small")
	FIEdit[1] = guiCreateEdit(12,25,153,22,"name",false,FITab[2])
	FILabel[8] = guiCreateLabel(13,57,130,18,"Firmenbeschreibung:",false,FITab[2])
	guiSetFont(FILabel[8],"default-bold-small")
	FIMemo[1] = guiCreateMemo(11,75,261,112,"description",false,FITab[2])
	FILabel[9] = guiCreateLabel(283,5,315,44,"Firmenposition: Deine Firma darf nur an Haeusern und \nFabriken Positioniert sein. Andererseits kann sie \nvon einem Admin geloescht werden.",false,FITab[2])
	guiSetFont(FILabel[9],"default-bold-small")
	FIKnopf[1] = guiCreateButton(315,50,247,23,"Meine Zurzeitige Position verwenden.",false,FITab[2])
	FIEdit[2] = guiCreateEdit(315,80,69,25,"X",false,FITab[2])
	FIEdit[3] = guiCreateEdit(401,80,69,25,"Y",false,FITab[2])
	FIEdit[4] = guiCreateEdit(490,80,69,25,"Z",false,FITab[2])
	local geld = tonumber(getElementData(gMe, "pBGeld"))
	local sucess = "Nein"
	if(geld < Firmenpreis) then
		sucess = "Nein"
	else
		sucess = "Ja"
	end
	guiSetEnabled(FIEdit[2], false)
	guiSetEnabled(FIEdit[3], false)
	guiSetEnabled(FIEdit[4], false)
	FILabel[10] = guiCreateLabel(314,116,270,16,Firmenpreis.."$ Erfuellt? "..sucess,false,FITab[2])
	guiLabelSetColor(FILabel[10],200, 200, 255)
	guiSetFont(FILabel[10],"default-bold-small")
	FIKnopf[2] = guiCreateButton(371,153,146,33,"Firma Erstellen",false,FITab[2])
	FITab[3] = guiCreateTab("Hinweise",FITabPanel[1])
	FILabel[11] = guiCreateLabel(5,3,595,188,"              Folgt.",false,FITab[3])
	guiSetFont(FILabel[11],"default-bold-small")
	FIKnopf[3] = guiCreateButton(11,244,100,31,"Schliessen",false,FIFenster[1])
	
	addEventHandler("onClientGUIClick", FIKnopf[3],
	function()
		Guivar = 0
		guiSetVisible(FIFenster[1], false)
		showCursor(false)
	end, false)
	
	addEventHandler("onClientGUIClick", FIKnopf[1],
	function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(FIEdit[2], x)
		guiSetText(FIEdit[3], y)
		guiSetText(FIEdit[4], z)
	end, false)
	
	addEventHandler("onClientGUIClick", FIKnopf[2],
	function()
		local name = guiGetText(FIEdit[1])
		local beschreibung = guiGetText(FIMemo[1])
		local x, y, z = tonumber(guiGetText(FIEdit[2])), tonumber(guiGetText(FIEdit[3])), tonumber(guiGetText(FIEdit[4]))
		if not(x) or not(y) or not(z) then outputChatBox("Ungueltige Position!", 200, 0, 0, false) return end
		if(name == "") or (name == " ") then return end
		if(string.len(name) < 1) or (string.len(name) > 32) then outputChatBox("Der Firmenname ist zu Lang.", 200, 0, 0, false) return end
		if(getElementInterior(gMe) ~= 0) then outputChatBox("Du kannst nicht in einem Interior eine Firma erstellen.", 200, 0, 0, false) return end
		if(isPedInVehicle(gMe) == true) then outputChatBox("Du kannst nicht in einem Auto eine Firma erstellen.", 200, 0, 0, false) return end
		if(isElementInWater(gMe) == true) then outputChatBox("Du kannst nicht im Wasser eine Firma erstellen.", 200, 0, 0, false) return end
		triggerServerEvent("onPlayerFirmaErstell", gMe, name, beschreibung, x, y, z)
	end, false)


end

addCommandHandler("createfirma", createFirmenErstellungsGui)


schrift = dxCreateFont( "data/impact.ttf", 20 )   