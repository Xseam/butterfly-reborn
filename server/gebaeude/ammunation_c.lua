local Ped = createPed(179, 296.01257324219, -40.217876434326, 1001.515625)
setPedRotation(Ped, 360)
setElementFrozen(Ped, true)
addEventHandler("onClientPedDamage", Ped, cancelEvent)
local Marker = createMarker(296.12487792969, -38.514972686768, 1001.715625, "corona", 1.0, 255, 255, 0, 200)
setElementInterior(Marker, 1)
setElementInterior(Ped, 1)

local Guivar = 0

function createAmmunationGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", root, function() if(Guivar == 1) then showCursor(true) end end)
	setElementData(gMe, "Clicked", 1)
	
	local Fenster = {}
	local Knopf = {}
	local Label = {}
	local Grid = {}
	local Bild = {}

	local X, Y, Width, Height = getMiddleGuiPosition(407,383)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Ammu Nation",false)
	Bild[1] = guiCreateStaticImage(9,23,389,70,"data/images/waffen/ammunation.png",false,Fenster[1])
	Label[1] = guiCreateLabel(36,95,339,52,"Willkommen im Ammu-Nation! Hier kannst du\nWaffen oder Munition kaufen.",false,Fenster[1])
	guiLabelSetHorizontalAlign(Label[1],"center",false)
	guiSetFont(Label[1],"default-bold-small")
	Grid[1] = guiCreateGridList(15,147,218,227,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Waffe",0.45)

	guiGridListAddColumn(Grid[1],"ID",0.1)

	guiGridListAddColumn(Grid[1],"Preis",0.3)
	Bild[2] = guiCreateStaticImage(252,150,118,90,"data/images/waffen/unknow.png",false,Fenster[1])
	Label[2] = guiCreateLabel(244,247,147,42,"Waffe: -\nPreis: -\nMunitionspreis: -",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Knopf[1] = guiCreateButton(240,298,155,32,"Waffe Kaufen",false,Fenster[1])
	Knopf[2] = guiCreateButton(241,332,153,32,"Abbrechen",false,Fenster[1])
	
	for i = 1, #ammuWaffen, 1 do
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, getWeaponNameFromID(ammuWaffen[i]), false, false)
		guiGridListSetItemText(Grid[1], row, 2, tonumber(ammuWaffen[i]), false, false)
		guiGridListSetItemText(Grid[1], row, 3, tonumber(ammuPreis[ammuWaffen[i]]).."$", false, false)
	end
	addEventHandler("onClientGUIClick", Knopf[1], function()
		local id = guiGridListGetItemText ( Grid[1], guiGridListGetSelectedItem ( Grid[1] ), 2 )
		if(id == "") or (id == " ") then outputChatBox("Du musst eine Waffe auswaehlen!", 200, 0, 0) return end
		triggerServerEvent("onAmmunationBuy", gMe, tonumber(id))
	end, false)	
	addEventHandler("onClientGUIClick", Grid[1], function( button )
		if not button == "left" then return end
		local id = guiGridListGetItemText ( Grid[1], guiGridListGetSelectedItem ( Grid[1] ), 2 )
		--outputChatBox(id)
		if(id == "") or (id == " ") then
			guiSetText(Label[2], "Waffe: -\nPreis: -\nMunitionspreis: -")
			guiStaticImageLoadImage(Bild[2], "data/images/waffen/unknow.png")
		return end
			id = tonumber(id)
			guiSetText(Label[2], "Waffe: "..getWeaponNameFromID(id).."\nPreis: "..tonumber(ammuPreis[id]).."$\nMunitionspreis: "..tonumber(ammuMunniPreis[id]).."$")
			if(fileExists("data/images/waffen/"..id..".png")) then
				guiStaticImageLoadImage(Bild[2], "data/images/waffen/"..id..".png")
			else
				guiStaticImageLoadImage(Bild[2], "data/images/waffen/unknow.png")
			end
	end, false)
	addEventHandler("onClientGUIClick", Knopf[2], function()
		Guivar = 0
		removeEventHandler("onClientRender", root, function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		destroyElement(Fenster[1])
		setCameraTarget(gMe)
		setElementData(gMe, "Clicked", 0)
	end, false)
end



addEventHandler("onClientMarkerHit", Marker, function(hitElement)
if(hitElement ~= gMe) then return end
	local x, y, z = getElementPosition(gMe)
	local x1, y1, z1 = getElementPosition(Ped)
	setCameraMatrix(x, y, z+1, x1, y1, z1)
	createAmmunationGui()
end)