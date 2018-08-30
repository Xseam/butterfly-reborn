local Tante1 = createPed(205, 376.50494384766, -65.849189758301, 1001.5078125)
setPedRotation(Tante1, 183)
local Marker = createMarker(376.49520874023, -67.648292541504, 1001.5151367188, "corona", 1.0, 0, 255, 0, 200)
addEventHandler("onClientPedDamage", Tante1, cancelEvent)
setElementInterior(Marker, 10)
setElementInterior(Tante1, 10)

local Guivar = 0

local foodLeben = {
	["Burger Snack"] = 3,
	["Salat"] = 10,
	["Mega Buerger"] = 15,
	["Cola"] = 5,
	["Big Pack Meal"] = 20,
	["Pommes"] = 6,
}

local preisTable = {
	["Burger Snack"] = 3,
	["Salat"] = 7,
	["Mega Buerger"] = 11,
	["Cola"] = 5,
	["Big Pack Meal"] = 15,
	["Pommes"] = 5,
}

local menueTable = {
	[1] = "Burger Snack",
	[2] = "Salat",
	[3] = "Mega Buerger",
	[4] = "Cola",
	[5] = "Big Pack Meal",
	[6] = "Pommes"
}

function createBSNMenue()
if(Guivar == 1) then return end
Guivar = 1
showCursor(true)
addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local BSNFenster = {}
	local BSNKnopf = {}
	local BSNLabel = {}
	local BSNGrid = {}
	local BSNBild = {}

	local X, Y, Width, Height = getMiddleGuiPosition(530,404)
	BSNFenster[1] = guiCreateWindow(X, Y, Width, Height,"Burger shot",false)
	BSNBild[1] = guiCreateStaticImage(9,20,154,132,"data/images/burgershot.png",false,BSNFenster[1])
	BSNLabel[1] = guiCreateLabel(174,26,335,131,"Willkommen im Burger Shot!\nHier kannst du was Essen, oder Trinken.\nBitte waehle eine Speise nach deiner Wahl aus!",false,BSNFenster[1])
	guiLabelSetVerticalAlign(BSNLabel[1],"center")
	guiLabelSetHorizontalAlign(BSNLabel[1],"center",false)
	guiSetFont(BSNLabel[1],"default-bold-small")
	BSNKnopf[1] = guiCreateButton(14,353,126,36,"Bestellen",false,BSNFenster[1])
	BSNKnopf[2] = guiCreateButton(147,353,126,36,"Abbrechen",false,BSNFenster[1])
	BSNGrid[1] = guiCreateGridList(10,173,511,172,false,BSNFenster[1])
	guiGridListSetSelectionMode(BSNGrid[1],1)

	guiGridListAddColumn(BSNGrid[1],"Speise",0.7)

	guiGridListAddColumn(BSNGrid[1],"Kosten",0.2)

	for i = 1, #menueTable, 1 do
		local name = menueTable[i]
		local preis = preisTable[name]
		local row = guiGridListAddRow(BSNGrid[1])
		guiGridListSetItemText(BSNGrid[1], row, 1, name, false, false)
		guiGridListSetItemText(BSNGrid[1], row, 2, preis.."$", false, false)
	end
	addEventHandler("onClientGUIClick", BSNKnopf[1],
	function()
		local item = guiGridListGetItemText(BSNGrid[1], guiGridListGetSelectedItem(BSNGrid[1]), 1, false, false)
		if(item == "") or (item == " ") then outputChatBox("Du musst eine Speise auswaehlen!", 200, 0, 0, false) return end
		local preis = preisTable[item]
		local geld = tonumber(getElementData(gMe, "pHGeld"))
		if(geld < preis) then outputChatBox("Du hast nicht genug Geld fuer diese Speise!", 200, 0, 0, false) return end
		guiSetVisible(BSNFenster[1], false)
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		toggleAllControls(false)
		fadeCamera(false, 2.0, 255, 255, 255)
		setTimer(
		function()
			fadeCamera(true, 2.0, 255, 255, 255)
			setElementHealth(gMe, (getElementHealth(gMe)+foodLeben[item]))
			toggleAllControls(true)
			setElementData(gMe, "pHGeld", geld-preis)
			--aktualisiereMoney()
			setPedAnimation(gMe, "food", "EAT_Burger",1,true,false,true)
			addHunger(5+math.random(0,5))
		end, 3000, 1)
	end, false)
	
	addEventHandler("onClientGUIClick", BSNKnopf[2],
	function()
		guiSetVisible(BSNFenster[1], false)
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
	end, false)
end

addEventHandler("onClientMarkerHit", Marker,
function(hitElement)
	if(hitElement ~= gMe) then return end
	createBSNMenue()
end)