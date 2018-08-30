local Ped = createPed(27, 658.14624023438, -677.01416015625, 16.202829360962)
local Marker = createMarker(660.64263916016, -678.08337402344, 16.092952728271, "corona", 1.0, 0, 255, 0, 200)
addEventHandler("onClientPedDamage", Ped, cancelEvent)
setPedRotation(Ped, 307)
local Keepervar = 0
setTimer(
function()
	if(Keepervar == 0) then
		Keepervar = Keepervar+1
		setPedAnimation( Ped, "ped", "WALK_civi", -1, true, true, false)
		setPedRotation(Ped, 307)
	elseif(Keepervar == 1) then
		Keepervar = Keepervar+1
		setPedAnimation( Ped )
		setPedRotation(Ped, 222)
	elseif(Keepervar == 2) then
		setPedAnimation( Ped, "ped", "WALK_civi", -1, true, true, false)
		Keepervar = Keepervar+1
		setPedRotation(Ped, 127)
	elseif(Keepervar == 3) then
		Keepervar = 0
		setPedAnimation( Ped )
		setPedRotation(Ped, 222)
		setElementPosition(Ped, 658.14624023438, -677.01416015625, 16.202829360962)
	end
end, 2000, 0)
local needs = {
	["Regal"] = "2x Bretter",
	["Zaun"] = "4x Bretter",
	["Tuer"] = "3x Bretter,\n1x Kiste",
	["Sperrholz"] = "3x Kiste",
	["Palette"] = "2x Kiste,\n2x Bretter",
	["Antenne"] = "1x Computer",
	["Spielekonsole"] = "2x Computer",
	["Verpackung"] = "1x Computer,\n1x Kiste",
	["Eisen"] = "2x Feuerloescher",
	["Draht"] = "1x Feuerloescher",
}
-- Regal, Zaun, Tuer, Palette, Sperrholz
--|Regal|Zaun|Tuer|Palette|Sperrholz|Antenne|Spielekonsole|Verpackung|Eisen|Draht|
--|0|0|0|0|0|0|0|0|0|0|
local bretterCrafts = {
	[1] = "Regal",
	[2] = "Zaun",
	[3] = "Tuer",
	[4] = "Palette",
}
local kistenCrafts = {
	[1] = "Tuer",
	[2] = "Sperrholz",
	[3] = "Palette",
	[4] = "Verpackung",
}

local computerCrafts = {
	[1] = "Antenne",
	[2] = "Spielekonsole",
	[3] = "Verpackung",
}

local feuerCrafts = {
	[1] = "Eisen",
	[2] = "Draht",
}

local Guivar = 0

function showSchmiedGuiWindow()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	local SCHFenster = {}
	local SCHKnopf = {}
	local SCHLabel = {}
	local SCHGrid = {}
	local X, Y, Width, Height = getMiddleGuiPosition(634,271)
	
	SCHFenster[1] = guiCreateWindow(X, Y, Width, Height, "Schmied",false)
	SCHLabel[1] = guiCreateLabel(5,21,320,35,"Hallo! Was kann ich fuer dich Tuen? Ich kann dir\nSachen, die du gesammelt hast, weiterverarbeiten.",false,SCHFenster[1])
	guiLabelSetHorizontalAlign(SCHLabel[1],"center",false)
	guiSetFont(SCHLabel[1],"default-bold-small")
	SCHLabel[2] = guiCreateLabel(11,37,365,19,"____________________________________________",false,SCHFenster[1])
	guiLabelSetColor(SCHLabel[2],0, 255, 0)
	SCHKnopf[1] = guiCreateButton(529,22,93,31,"Schliessen",false,SCHFenster[1])
	SCHLabel[3] = guiCreateLabel(20,62,97,15,"Dein Inventar:",false,SCHFenster[1])
	guiSetFont(SCHLabel[3],"default-bold-small")
	SCHGrid[1] = guiCreateGridList(11,97,260,123,false,SCHFenster[1])
	guiGridListSetSelectionMode(SCHGrid[1],1)

	guiGridListAddColumn(SCHGrid[1],"Item",0.65)

	guiGridListAddColumn(SCHGrid[1],"Anzahl",0.2)
	SCHLabel[4] = guiCreateLabel(281,133,70,61,"---->\nKann \nverarbeitet\nwerden zu:",false,SCHFenster[1])
	guiSetFont(SCHLabel[4],"default-bold-small")
	SCHGrid[2] = guiCreateGridList(359,95,260,123,false,SCHFenster[1])
	guiGridListSetSelectionMode(SCHGrid[2],1)

	guiGridListAddColumn(SCHGrid[2],"Item",0.65)

	guiGridListAddColumn(SCHGrid[2],"Anzahl",0.2)
	SCHLabel[5] = guiCreateLabel(363,23,162,60,"Benoetigt:\n",false,SCHFenster[1])
	guiSetFont(SCHLabel[5],"default-bold-small")
	SCHKnopf[2] = guiCreateButton(14,227,109,31,"Weiterverarbeiten",false,SCHFenster[1])
	SCHLabel[6] = guiCreateLabel(165,230,420,19,"Weiterverarbeitete Sachen kannst du Besser beim Ankaeufer verkaufen.",false,SCHFenster[1])
	guiSetFont(SCHLabel[6],"default-bold-small")
	local function loadList()
		guiGridListClear(SCHGrid[1])
		local it1 = tonumber(getElementData(gMe, "pBretter"))
		local it2 = tonumber(getElementData(gMe, "pKisten"))
		local it3 = tonumber(getElementData(gMe, "pComputer"))
		local it4 = tonumber(getElementData(gMe, "pFeuer"))
		if(it1 > 0) then
			local row = guiGridListAddRow(SCHGrid[1])
			guiGridListSetItemText(SCHGrid[1], row, 1, "Bretter", false, false)
			guiGridListSetItemText(SCHGrid[1], row, 2, it1, false, false)
		end
		if(it2 > 0) then
			local row = guiGridListAddRow(SCHGrid[1])
			guiGridListSetItemText(SCHGrid[1], row, 1, "Kisten", false, false)
			guiGridListSetItemText(SCHGrid[1], row, 2, it2, false, false)
		end
		if(it3 > 0) then
			local row = guiGridListAddRow(SCHGrid[1])
			guiGridListSetItemText(SCHGrid[1], row, 1, "Computer", false, false)
			guiGridListSetItemText(SCHGrid[1], row, 2, it3, false, false)
		end
		if(it4 > 0) then
			local row = guiGridListAddRow(SCHGrid[1])
			guiGridListSetItemText(SCHGrid[1], row, 1, "Feuerloescher", false, false)
			guiGridListSetItemText(SCHGrid[1], row, 2, it4, false, false)
		end
	end
	local function loadCraftScript(i)
	guiGridListClear(SCHGrid[2])
		if(i == 1) then
		
			for index = 1, #bretterCrafts, 1 do
				local row = guiGridListAddRow(SCHGrid[2])
				guiGridListSetItemText(SCHGrid[2], row, 1, bretterCrafts[index], false, false)
				guiGridListSetItemText(SCHGrid[2], row, 2, "1", false, false)
			end
		elseif(i == 2) then
			for index = 1, #kistenCrafts, 1 do
				local row = guiGridListAddRow(SCHGrid[2])
				guiGridListSetItemText(SCHGrid[2], row, 1, kistenCrafts[index], false, false)
				guiGridListSetItemText(SCHGrid[2], row, 2, "1", false, false)
			end
		elseif(i == 3) then
			for index = 1, #computerCrafts, 1 do
				local row = guiGridListAddRow(SCHGrid[2])
				guiGridListSetItemText(SCHGrid[2], row, 1, computerCrafts[index], false, false)
				guiGridListSetItemText(SCHGrid[2], row, 2, "1", false, false)
			end
		elseif(i == 4) then
			for index = 1, #feuerCrafts, 1 do
				local row = guiGridListAddRow(SCHGrid[2])
				guiGridListSetItemText(SCHGrid[2], row, 1, feuerCrafts[index], false, false)
				guiGridListSetItemText(SCHGrid[2], row, 2, "1", false, false)
			end
		
		end

	end
	--[[local needs = {
	["Regal"] = "2x Bretter",
	["Zaun"] = "4x Bretter",
	["Tuer"] = "3x Bretter,\n1x Kiste",
	["Sperrholz"] = "3x Kiste",
	["Palette"] = "2x Kiste,\n2x Bretter",
	["Antenne"] = "1x Computer",
	["Spielekonsole"] = "2x Computer",
	["Verpackung"] = "1x Computer,\n1x Kiste",
	["Eisen"] = "2x Feuerloescher",
	["Draht"] = "1x Feuerloescher",
	}--]]
	local function sendError()
		outputChatBox("Fehler! Du hast nicht das Material, was gebraucht wird.", 200, 0, 0, false)
	end
	addEventHandler("onClientGUIClick",SCHKnopf[2],
	function()
		
		local item = guiGridListGetItemText(SCHGrid[2], guiGridListGetSelectedItem(SCHGrid[2]), 1)
		if(item == "") or (item == " ") then return end
		guiGridListSetSelectedItem ( SCHGrid[1], 0, 0)
		guiGridListSetSelectedItem ( SCHGrid[2], 0, 0)
		local bretter = tonumber(getElementData(gMe, "pBretter"))
		local kisten = tonumber(getElementData(gMe, "pKisten"))
		local computer = tonumber(getElementData(gMe, "pComputer"))
		local feuer = tonumber(getElementData(gMe, "pFeuer"))
		if(item == "Regal") then
			if(bretter < 2) then sendError() return end
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
			local sun = "|"..(regal+1).."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pBretter", bretter-2)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Zaun") then
			if(bretter < 4) then sendError() return end
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
			local sun = "|"..regal.."|"..(zaun+1).."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pBretter", bretter-4)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Tuer") then
			if(bretter < 3) or (kisten < 1) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..(tuer+1).."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pBretter", bretter-3)
			setElementData(gMe, "pKisten", kisten-1)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Sperrholz") then
			if(kisten < 3) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..(sperrholz+1).."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pKisten", feuer-3)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Palette") then
			if(bretter < 2) or (kisten < 2) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..(palette+1).."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pBretter", bretter-2)
			setElementData(gMe, "pKisten", kisten-2)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Antenne") then
			if(computer < 1) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..(antenne+1).."|"..konsole.."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pComputer", computer-1)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Spielekonsole") then
			if(computer < 2) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..(konsole+1).."|"..verpackung.."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pComputer", computer-2)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Verpackung") then
			if(computer < 1) or (kisten < 1) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..(verpackung+1).."|"..eisen.."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pComputer", computer-1)
			setElementData(gMe, "pKisten", kisten-1)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Eisen") then
			if(feuer < 2) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..(eisen+1).."|"..draht.."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pFeuer", feuer-2)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		if(item == "Draht") then
			if(feuer < 1) then sendError() return end
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
			local sun = "|"..regal.."|"..zaun.."|"..tuer.."|"..sperrholz.."|"..palette.."|"..antenne.."|"..konsole.."|"..verpackung.."|"..eisen.."|"..(draht+1).."|"
			setElementData(gMe, "pSINV", sun)
			setElementData(gMe, "pFeuer", feuer-1)
			outputChatBox("Item wurde erfolgreich hergestellt.", 0, 200, 0, false)
			loadList()
		end
		
	end, false)
	addEventHandler("onClientGUIClick",SCHKnopf[1],
	function()
		Guivar = 0
		showCursor(false)
		guiSetVisible(SCHFenster[1], false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end, false)
	addEventHandler("onClientGUIClick", SCHGrid[2], 
	function()
		local item = guiGridListGetItemText(SCHGrid[2], guiGridListGetSelectedItem(SCHGrid[2]), 1)
		if(item == "") or (item == " ") then guiSetText(SCHLabel[5], "Benoetigt: \n") return end
		guiSetText(SCHLabel[5], "Benoetigt: \n"..needs[item])
	end)
	addEventHandler("onClientGUIClick", SCHGrid[1], 
	function()
		local item = guiGridListGetItemText(SCHGrid[1], guiGridListGetSelectedItem(SCHGrid[1]), 1)
		if(item == "") or (item == " ") then return end
		local q
		if(item == "Bretter") then q = 1 end
		if(item == "Kisten") then q = 2 end
		if(item == "Computer") then q = 3 end
		if(item == "Feuerloescher") then q = 4 end

			loadCraftScript(q)
	end)
	loadList()
end

addEventHandler("onClientMarkerHit", Marker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	showSchmiedGuiWindow()
end)