local Guivar = 0

local Spawnpunkte = {
	["Strasse/Noobspawn"] = 0,
	["Fraktionsbase"] = 1,
	["Haus"] = 2,
	["Area51"] = 3,
}
	local SPAWNFenster = {}
	local SPAWNKnopf = {}
	local SPAWNLabel = {}
	local SPAWNGrid = {}
function createSpawnchangeGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	setElementData(gMe, "Clicked", 1)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 418,269
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)

	SPAWNFenster[1] = guiCreateWindow(X, Y, Width, Height, "Spawnpunkt setzen",false)
	SPAWNLabel[1] = guiCreateLabel(13,26,392,46,"Hier kannst du dein Spawnpunkt setzen.\nWaehle ein Punkt an, und drueck dann\nauf 'Auswaehlen'.",false,SPAWNFenster[1])
	guiLabelSetHorizontalAlign(SPAWNLabel[1],"center",false)
	guiSetFont(SPAWNLabel[1],"default-bold-small")
	SPAWNGrid[1] = guiCreateGridList(12,72,397,149,false,SPAWNFenster[1])
	guiGridListSetSelectionMode(SPAWNGrid[1],1)

	guiGridListAddColumn(SPAWNGrid[1],"Spawnpunkt",0.7)

	guiGridListAddColumn(SPAWNGrid[1],"Ausgewaehlt",0.2)
	SPAWNKnopf[1] = guiCreateButton(15,227,104,30,"Auswaehlen",false,SPAWNFenster[1])
	SPAWNKnopf[2] = guiCreateButton(126,227,104,30,"Schliessen",false,SPAWNFenster[1])

	
	local function aktualisiereSpawnpointGrid()
		guiGridListClear(SPAWNGrid[1])
		local spawnpoint = tonumber(getElementData(gMe, "pSpawn"))
		local row1 = guiGridListAddRow(SPAWNGrid[1])
		guiGridListSetItemText(SPAWNGrid[1], row1, 1, "Strasse/Noobspawn", false, false)
		guiGridListSetItemText(SPAWNGrid[1], row1, 2, "[  ]", false, false)
		local row2 = guiGridListAddRow(SPAWNGrid[1])
		guiGridListSetItemText(SPAWNGrid[1], row2, 1, "Fraktionsbase", false, false)
		guiGridListSetItemText(SPAWNGrid[1], row2, 2, "[  ]", false, false)
		local row3 = guiGridListAddRow(SPAWNGrid[1])
		guiGridListSetItemText(SPAWNGrid[1], row3, 1, "Haus", false, false)
		guiGridListSetItemText(SPAWNGrid[1], row3, 2, "[  ]", false, false)
		local row4
		if(getPlayerFraktion(gMe) == 4) or (getPlayerFraktion(gMe) == 7) then
			row4 = guiGridListAddRow(SPAWNGrid[1])
			guiGridListSetItemText(SPAWNGrid[1], row4, 1, "Area51", false, false)
			guiGridListSetItemText(SPAWNGrid[1], row4, 2, "[  ]", false, false)
		end
		if(spawnpoint == 0) then
			guiGridListSetItemText(SPAWNGrid[1], row1, 2, "[X]", false, false)
		elseif(spawnpoint == 1) then
			guiGridListSetItemText(SPAWNGrid[1], row2, 2, "[X]", false, false)
		elseif(spawnpoint == 2) then
			guiGridListSetItemText(SPAWNGrid[1], row3, 2, "[X]", false, false)
		elseif(spawnpoint == 3) then
			guiGridListSetItemText(SPAWNGrid[1], row4, 2, "[X]", false, false)
		else
			outputChatBox("Unbekannter Spawnpunkt!", 200, 0, 0, false)
		end
	end
	
	aktualisiereSpawnpointGrid()
	
	addEventHandler("onClientGUIClick", SPAWNKnopf[1],
	function()
		local spawn = guiGridListGetItemText(SPAWNGrid[1], guiGridListGetSelectedItem(SPAWNGrid[1]), 1)
		if(spawn == "") or (spawn == " ") then outputChatBox("Du musst ein Spawnpunkt auswaehlen.", 200, 0, 0, false) return end
		local spawn = Spawnpunkte[spawn]
		local var = 0
		if not(spawn) then return end
		local data = tonumber(getElementData(gMe, "pSpawn"))
		if(data == spawn) then outputChatBox("Du hast bereits diesen Spawnpunkt.", 200, 0, 0, false) return end
		if(spawn == 1) then -- Fraktion
			if(tonumber(getElementData(gMe, "pFraktion")) == 0) then outputChatBox("Du bist in keiner Fraktion.", 200, 0, 0, false) return end 
		end
		if(spawn == 2) then -- Haus
			for index, col in pairs(getElementsByType("colshape")) do
				if(getElementData(col, "HAUS") == true) then
					if(getElementData(col, "HBESITZER") == getPlayerName(gMe)) then
						var = 1
					else
							local mieter = getElementData(col, "HMIETER")
							local me = getPlayerName(gMe)
							local mieter1 = gettok(mieter, 1, "|")
							local mieter2 = gettok(mieter, 2, "|")
							local mieter3 = gettok(mieter, 3, "|")
							local mieter4 = gettok(mieter, 4, "|")
							local mieter5 = gettok(mieter, 5, "|")
							if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then
							var = 1
							end
						end
					end	
			end
			if(var == 0) then outputChatBox("Du hast kein Haus!", 200, 0, 0, false) return end
		end
		if(spawn == 3) then -- Area51
		
		end
		outputChatBox("Spawnpoint erfolgreich geaendert!", 0, 200, 0, false)
		setElementData(gMe, "pSpawn", spawn)
		aktualisiereSpawnpointGrid()
	end, false)
	
	addEventHandler("onClientGUIClick", SPAWNKnopf[2],
	function()
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
		destroyElement(SPAWNFenster[1])
	end, false)
end


bindKey("F4", "down",
function()
	if(Guivar == 0) then
		createSpawnchangeGui()
	elseif(Guivar == 1) then
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
		destroyElement(SPAWNFenster[1])
	end
end)


