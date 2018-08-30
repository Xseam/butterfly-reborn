local Marker = createMarker(694.97094726563, -500.12933349609, 16.3359375, "corona", 1.0, 0, 255, 0, 200)

local Guivar = 0

local kaufTable = {
	[1] = "Angel",
	[2] = "Wuermer",
	[3] = "Floehe",
}
local kaufPreis = {
	["Angel"] = 75,
	["Wuermer"] = 10,
	["Floehe"] = 8,
}
local fishNames = {
	[1] = "Forelle",
	[2] = "Koffer",
	[3] = "Lachs",
	[4] = "Hai",
	[5] = "Barsch",
	[6] = "Rochen",
	[7] = "Aal",
	[8] = "Thunfisch",
	[9] = "Schwertfisch",
	[10] = "Hut",
	[11] = "Geldsack",
	[12] = "Schuh"
}
--|0|0|0|0|0|0|0|0|
-- Forelle, Lachs, Hai, Barsch, Rochen, Aal, Thunfisch, Schwertfisch
local angebissen = 0
local waX, waY, waZ = 0, 0, 0
function createAngelGuiMenue()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setCameraMatrix(683.39739990234, -489.13558959961, 19.9875, 697.28912353516, -500.13198852539, 17.7359375)
	
	local ANGFenster = {}
	local ANGKnopf = {}
	local ANGLabel = {}
	local ANGGrid = {}

	local X, Y, Width, Height = getMiddleGuiPosition(436,196)
	ANGFenster[1] = guiCreateWindow(X, Y, Width, Height, "Angelshop",false)
	ANGLabel[1] = guiCreateLabel(18,19,397,31,"Herzlich Willkommen im Angel-Shop!\nWas koennen wir fuer dich tuen?",false,ANGFenster[1])
	guiLabelSetHorizontalAlign(ANGLabel[1],"center",false)
	guiSetFont(ANGLabel[1],"default-bold-small")
	ANGKnopf[1] = guiCreateButton(12,158,123,25,"Kaufen",false,ANGFenster[1])
	ANGGrid[1] = guiCreateGridList(13,45,412,109,false,ANGFenster[1])
	guiGridListSetSelectionMode(ANGGrid[1],1)

	guiGridListAddColumn(ANGGrid[1],"Item",0.5)

	guiGridListAddColumn(ANGGrid[1],"Preis",0.2)

	guiGridListAddColumn(ANGGrid[1],"Vorhanden",0.2)
	ANGKnopf[2] = guiCreateButton(139,158,123,25,"Schliessen",false,ANGFenster[1])
	
	local function loadList()
		guiGridListClear(ANGGrid[1])
		for i = 1, #kaufTable, 1 do
			local row = guiGridListAddRow(ANGGrid[1])
			guiGridListSetItemText(ANGGrid[1], row, 1, kaufTable[i], false, false)
			guiGridListSetItemText(ANGGrid[1], row, 2, kaufPreis[kaufTable[i]].."$", false, false)
			local win
			if(kaufTable[i] == "Angel") then
				local data = tonumber(getElementData(gMe, "pAngel"))
				if(data > 0) then
					win = "Ja"
				else
					win = "Nein"
				end
			end
			if(kaufTable[i] == "Wuermer") then
				local data = getElementData(gMe, "pKoeder")
				local wuermer = tonumber(gettok(data, 1, "|"))
				win = wuermer
			end
			if(kaufTable[i] == "Floehe") then
				local data = getElementData(gMe, "pKoeder")
				local floehe = tonumber(gettok(data, 2, "|"))
				win = floehe
			end
			guiGridListSetItemText(ANGGrid[1], row, 3, win, false, false)
		end
	end
	addEventHandler("onClientGUIClick", ANGKnopf[1],
	function()
		local item = guiGridListGetItemText(ANGGrid[1], guiGridListGetSelectedItem(ANGGrid[1]), 1)
		if(item == "") or (item == " ") then outputChatBox("Du musst ein Item auswaehlen!", 200, 0, 0, false) return end
		if(item == "Angel") then
			local data = tonumber(getElementData(gMe, "pAngel"))
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(data > 0) then outputChatBox("Du hast bereits eine Angel!", 200, 0, 0, false) return end
			local preis = kaufPreis["Angel"]
			if(preis > geld) then outputChatBox("Du hast nicht Genug geld bei dir!", 200, 0, 0, false) return end
			setElementData(gMe, "pAngel", 1)
			setElementData(gMe, "pHGeld", geld-preis)
			outputChatBox("Du hast dir eine Angel gekauft.", 0, 200, 0, false)
			loadList()
		elseif(item == "Wuermer") then
			local kacke = getElementData(gMe, "pKoeder")
			local data = tonumber(gettok(kacke, 1, "|"))
			local data2 = tonumber(gettok(kacke, 2, "|"))
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			local preis = kaufPreis["Wuermer"]
			if(preis > geld) then outputChatBox("Du hast nicht Genug geld bei dir!", 200, 0, 0, false) return end
			setElementData(gMe, "pKoeder", "|"..(data+1).."|"..data2.."|")
			setElementData(gMe, "pHGeld", geld-preis)
			outputChatBox("Du hast dir einen Wurm gekauft.", 0, 200, 0, false)
			loadList()
		elseif(item == "Floehe") then
			local kacke = getElementData(gMe, "pKoeder")
			local data = tonumber(gettok(kacke, 1, "|"))
			local data2 = tonumber(gettok(kacke, 2, "|"))
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			local preis = kaufPreis["Floehe"]
			if(preis > geld) then outputChatBox("Du hast nicht Genug geld bei dir!", 200, 0, 0, false) return end
			setElementData(gMe, "pKoeder", "|"..data.."|"..(data2+1).."|")
			setElementData(gMe, "pHGeld", geld-preis)
			outputChatBox("Du hast dir einen Flo gekauft.", 0, 200, 0, false)
			loadList()
		
		end
	end, false)
	
	addEventHandler("onClientGUIClick", ANGKnopf[2],
	function()
		guiSetVisible(ANGFenster[1], false)
		Guivar = 0
		showCursor(false)
		setCameraTarget(gMe)
	end, false)

	loadList()
end

addEventHandler("onClientMarkerHit", Marker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	createAngelGuiMenue()
	
end)

function applyFishing()
	unbindKey("mouse1", "down", applyFishing)
	if(angebissen == 0) then
		outputChatBox("Du ziehst die Angel ein, und siehst, es befindet sich nichts drann.", 200, 0, 0, false)
		setPedAnimation(gMe, nil, nil)
		setElementData(gMe, "Clicked", 0)
		setElementData(gMe, "atAngel", false)
	elseif(angebissen == 1) then
		triggerServerEvent("onFischAngebissen", gMe)
	end
end

function setToFishing()
	setPedAnimation ( gMe, "SWORD", "sword_3", -1, false, false, false, true )
	outputChatBox("Du hast deine Angel in Wasser geworfen.", 0, 200, 0, false)
	local data = getElementData(gMe, "pKoeder")
	local wuermer, floehe = tonumber(gettok(data, 1, "|")), tonumber(gettok(data, 2, "|"))
	setElementData(gMe, "pKoeder", "|"..(wuermer-1).."|"..floehe.."|")
	removeEventHandler("onClientClick", getRootElement(), check_for_angel)
	setElementData(gMe, "Clicked", 0)
	bindKey("mouse1", "down", applyFishing)
	showCursor(false)
end

function check_for_angel(mouse,button, _, _, wx, wy, wz, element)
	if(mouse == "left") and (button == "down") then
		
		if(getElementData(gMe, "Clicked") == 1) then return end
			if not element then
				local pX, pY, pZ = getElementPosition ( gMe )
				local bool, wX, wY, wZ = testLineAgainstWater ( pX, pY, pZ + 100, wx, wy, wz )
				if bool then
					local x1, y1, z1 = getElementPosition ( gMe )
					local x2, y2, z2 = wx, wy, wz
					local nX = x2 - ( ( x1 - x2 ) / ( z1 - z2 ) ) * ( z2 )
					local nY = y2 - ( ( y1 - y2 ) / ( z1 - z2 ) ) * ( z2 )
					
					local dist = getDistanceBetweenPoints2D ( x1, y1, nX, nY )
					
					
					if dist <= 35 then
						
						setToFishing()
						waX, waY, waZ = wX, wY, wZ
						outputChatBox(waX..", "..waY..", "..waZ)
						createObject(1337, waX, waY, waZ)
					else
						outputChatBox("Du musst deine Angel in Wasser Werfen!", 200, 0, 0, false)
						setElementData(gMe, "Clicked", 0)
						showCursor(false)
						setElementData(gMe, "atAngel", false)
						removeEventHandler("onClientClick", getRootElement(), check_for_angel)
					end
				else
					outputChatBox("Du musst deine Angel in Wasser Werfen!", 200, 0, 0, false)
					setElementData(gMe, "Clicked", 0)
					showCursor(false)
					setElementData(gMe, "atAngel", false)
					removeEventHandler("onClientClick", getRootElement(), check_for_angel)
				end
			end
		
	elseif(mouse == "right") and (button == "down") then
		showCursor(gMe, false)
		setElementData(gMe, "atAngel", false)
		removeEventHandler("onClientClick", getRootElement(), check_for_angel)
		end
end


addEvent("onAngelBenutzung", true)
addEventHandler("onAngelBenutzung", getRootElement(), 
function(typ)
	if(getElementData(gMe, "atAngel") == true) then outputChatBox("Du Angelst gerade!", 0, 200, 0, false) return end
	
	if(typ == "Wuermer") then
		setElementData(gMe, "atAngel", true)
		showCursor(true)
		addEventHandler("onClientClick", getRootElement(), check_for_angel)
	elseif(typ == "Floehe") then
		setElementData(gMe, "atAngel", true)
	end
end)

addCommandHandler("quitangeln",
function(thePlayer, cmd)
	if(getElementData(thePlayer, "atAngel") ~= true) then outputChatBox("Du bist nicht beim Angeln!", thePlayer, 200, 0, 0, false) return end
	setElementData(thePlayer, "atAngel", false)
	outputChatBox("Du hast das Angeln abgebrochen.", thePlayer, 200, 0, 0, false)
	setElementFrozen(thePlayer, false)
end)