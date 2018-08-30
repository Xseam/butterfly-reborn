-- Shop auch bei [XP]MuLTi, und alle anderen Sachen auch! (Hust, siehe Info) --

local Ped = createPed(240, 252.44059753418, -54.828395843506, 1.5776443481445)
setElementInterior(Ped, 0)
setPedRotation(Ped, 180)

local Marker = createMarker(252.44053649902, -56.282543182373, 1.670312, "corona", 1.0, 255, 255, 255, 255)

addEventHandler("onClientPedDamage", getRootElement(),
function()
	if(source == Ped) then
		cancelEvent()
		
	end
end)

local Guivar = 0

local shopItem = {
	[1] = "Zigaretten",
	[2] = "Wuerfel",
	[3] = "Bier",
	[4] = "Zeitung",
	[5] = "Nachtsichtgeraet",
	[6] = "Kamera",
	[7] = "Handy",
	[8] = "Radio",
}

local shopPreis = {
	["Zigaretten"] = 5,
	["Wuerfel"] = 2,
	["Bier"] = 5,
	["Zeitung"] = 5,
	["Nachtsichtgeraet"] = 20, 
	["Kamera"] = 55, 
	["Handy"] = 60,
	["Radio"] = 125,
}


function createShopKaufenMenue()
if(Guivar == 1) then return end
	Guivar = 1

	showCursor(true)

			local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 558,270
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
		
		local SFenster = guiCreateWindow(X, Y, Width, Height, "Shop",false)
	local SLabel = guiCreateLabel(11,24,541,45,"Willkommen in meinem Laden!\nWas darf's sein?\n________________________________________________________________________________",false,SFenster)
	guiSetFont(SLabel,"default-bold-small")
	local SGrid = guiCreateGridList(11,77,455,180,false,SFenster)

	guiGridListSetSelectionMode(SGrid,1)
	guiGridListAddColumn(SGrid,"Gegenstand",0.5)
	guiGridListAddColumn(SGrid,"Preis",0.23)
	guiGridListAddColumn(SGrid,"Anzahl",0.2)


	for v = 1, #shopItem, 1 do
		local row = guiGridListAddRow ( SGrid )
		guiGridListSetItemText(SGrid,row,1,shopItem[v],false,false)
		guiGridListSetItemText(SGrid,row,2,shopPreis[shopItem[v]].." $",false,false)
		guiGridListSetItemText(SGrid,row,3,"1 Stk.",false,false)
	end

	local SKnopf1 = guiCreateButton(474,222,75,33,"Kaufen",false,SFenster)
	local SKnopf2 = guiCreateButton(474,176,75,33,"Abbrechen",false,SFenster)


	addEventHandler("onClientGUIClick", SKnopf1,
	function()
		local item = guiGridListGetItemText (SGrid, guiGridListGetSelectedItem ( SGrid ), 1 )
		if(item == "") or (item == " ") then return end
		if(item == "Zigaretten") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			local data = getElementData(gMe, "pZigaretten")
			setElementData(gMe, "pZigaretten", data+5)
			outputChatBox("Du hast dir das Item '"..item.."' erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
		elseif(item == "Wuerfel") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			local data = tonumber(getElementData(gMe, "pWuerfel"))
			if(data == 1) then outputChatBox("Du hast Bereits den Wuerfel!", 200, 0, 0, false) return end
			setElementData(gMe, "pWuerfel", 1)	
			outputChatBox("Du hast dir das Item '"..item.."' erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
		elseif(item == "Bier") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			local data = getElementData(gMe, "pBiere")
			setElementData(gMe, "pBiere", data+1)
			outputChatBox("Du hast dir das Item '"..item.."' erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
		elseif(item == "Zeitung") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			local data = tonumber(getElementData(gMe, "pZeitung"))
			if(data == 1) then outputChatBox("Du hast bereits eine Zeitung. Wirf die andere erst weg!", 200, 0, 0, false) return end
			outputChatBox("Du hast dir die Zeitung erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pZeitung", 1)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
			triggerServerEvent("onRCNRZeitungKauf", gMe)
		elseif(item == "Nachtsichtgeraet") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			triggerServerEvent("onShopKaufen", gMe, 1)
			outputChatBox("Du hast dir das Nachtsichtgeraet erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
		elseif(item == "Kamera") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			triggerServerEvent("onShopKaufen", gMe, 2)
			outputChatBox("Du hast dir eine Kamera erfolgreich gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
		elseif(item == "Handy") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(hasPlayerHandy(gMe) == true) then outputChatBox("Du hast bereits ein Handy!", 200, 0, 0, false) return end
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			triggerEvent("onShopHandyKauf", gMe)
			guiMoveToBack(SFenster)
		elseif(item == "Radio") then
			local geld = tonumber(getElementData(gMe, "pHGeld"))
			if(geld < shopPreis[item]+1) then outputChatBox("Du hast nicht genug Geld.", 200, 0,0, false) return end
			if(tonumber(getElementData(gMe, "pRadios")) > 0) then outputChatBox("Du hast schon ein Radio!", 200, 0, 0, false) return end
			outputChatBox("Du hast dir ein Radio gekauft!", 0, 200, 0, false)
			setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld"))-shopPreis[item])
			setElementData(gMe, "pRadios", tonumber(getElementData(gMe, "pRadios"))+1)
		end
		
	end, false)

	addEventHandler("onClientGUIClick", SKnopf2,
	function()
		guiSetVisible(SFenster, false)
		Guivar = 0
		setCameraTarget(gMe)
		showCursor(false)
	end, false)

end

addEventHandler("onClientMarkerHit", Marker,
function(hitElement)
if (hitElement ~= gMe) then return end
	setCameraMatrix(250.33177185059, -55.539154052734, 2.4786133766174, 252.44059753418, -54.828395843506, 1.6976443481445)
	createShopKaufenMenue()
end)