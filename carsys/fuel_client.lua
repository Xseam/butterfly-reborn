local Guivar = 0
local curPreis = 0
local kanisterpreis = 10
local snackpreis = 1
local kofferpreis = 5

local matrixTable = {
	["Montgomery"] = "1373.0875244141, 468.23675537109, 19.866430282593, 1451.6517333984, 406.68798828125, 26.144304275513",
	["Dillimore"] = "648.47686767578, -547.35052490234, 16.487861633301, 692.93634033203, -636.7998046875, 21.197618484497",
	["Mulholland"] = "983.06170654297, -951.97570800781, 46.0104637146, 1059.8748779297, -889.08331298828, 33.999034881592",
}

addEvent("onTankeEinfahr", true)
addEventHandler("onTankeEinfahr", getRootElement(),
function(literpreis)
	curPreis = literpreis
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementFrozen(getPedOccupiedVehicle(gMe), true)
	toggleAllControls(false)
	guiSetInputMode("no_binds_when_editing")
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	setElementData(gMe, "Clicked", 1)
	local px, py, pz = getElementPosition(gMe)
	local zone = getZoneName(px, py, pz, false)
	local c1, c2, c3, c4, c5, c6 = gettok(matrixTable[getZoneName(px, py, pz, false)], 1, ","), gettok(matrixTable[getZoneName(px, py, pz, false)], 2, ","), gettok(matrixTable[getZoneName(px, py, pz, false)], 3, ","), gettok(matrixTable[getZoneName(px, py, pz, false)], 4, ","), gettok(matrixTable[getZoneName(px, py, pz, false)], 5, ","), gettok(matrixTable[getZoneName(px, py, pz, false)], 6, ",")
	setCameraMatrix(c1, c2, c3, c4, c5, c6)
	local TANFenster = {}
	local TANKnopf = {}
	local TANLabel = {}
	local TANEdit = {}
	local TANRadio = {}
	local TANBild = {}

	local X, Y, Width, Height = getMiddleGuiPosition(331,273)
	local x, y, z = getElementPosition(gMe)
	local zonename = getZoneName(x, y, z, false)
	TANFenster[1] = guiCreateWindow(X, Y, Width, Height, "Tankstelle "..zonename,false)
	guiWindowSetSizable(TANFenster[1], false)
	TANKnopf[1] = guiCreateButton(11,228,114,32,"Schliessen",false,TANFenster[1])
	TANBild[1] = guiCreateStaticImage(18,-1,125,103,"data/images/tankstelle.png",false,TANFenster[1])
	TANLabel[1] = guiCreateLabel(156,26,154,58,"Zurzeitiger Treibstoffpreis:\n"..curPreis.."$ / Liter",false,TANFenster[1])
	guiLabelSetVerticalAlign(TANLabel[1],"center")
	guiLabelSetHorizontalAlign(TANLabel[1],"center",false)
	guiSetFont(TANLabel[1],"default-bold-small")
	TANRadio[1] = guiCreateRadioButton(15,99,119,28,"Volltanken",false,TANFenster[1])
	guiSetFont(TANRadio[1],"default-bold-small")
	TANRadio[2] = guiCreateRadioButton(14,150,119,28,"Liter Tanken:",false,TANFenster[1])
	guiSetFont(TANRadio[2],"default-bold-small")
	TANEdit[1] = guiCreateEdit(123,150,87,27,"",false,TANFenster[1])
	TANLabel[2] = guiCreateLabel(217,156,47,16,"Liter",false,TANFenster[1])
	guiSetFont(TANLabel[2],"default-bold-small")
	TANLabel[3] = guiCreateLabel(156,82,158,43,"Insgesammte Kosten:\n0$",false,TANFenster[1])
	guiLabelSetHorizontalAlign(TANLabel[3],"center",false)
	guiSetFont(TANLabel[3],"default-bold-small")
	TANKnopf[2] = guiCreateButton(131,228,114,32,"Tanken",false,TANFenster[1])
	TANKnopf[3] = guiCreateButton(13,189,114,32,"Kanister Kaufen",false,TANFenster[1])
	TANKnopf[4] = guiCreateButton(131,190,114,32,"Erste-Hilfe Koffer",false,TANFenster[1])
	TANKnopf[5] = guiCreateButton(249,209,71,28,"Snack",false,TANFenster[1])
	addEventHandler("onClientGUIClick", TANKnopf[5],
	function()
		local money = tonumber(getElementData(gMe, "pHGeld"))
		if(money < snackpreis) then outputChatBox("Dir fehlen "..(money-snackpreis).." $!", 200, 0, 0) return end
		setElementData(gMe, "pHGeld", money-snackpreis)
		addHunger(5)
		habe_Hunger()
	end, false)
	
	addEventHandler("onClientGUIClick", TANKnopf[4],
	function()
		local money = tonumber(getElementData(gMe, "pHGeld"))
		if(money < kofferpreis) then outputChatBox("Dir fehlen "..(money-kofferpreis).." $!", 200, 0, 0) return end
		if(tonumber(getElementData(gMe, "pErstehilfe")) > 1) then outputChatBox("Du kannst nur Maximal 2 Erste-Hilfe Koffer Tragen!", 200, 0, 0) return end
		setElementData(gMe, "pHGeld", money-kofferpreis)
		setElementData(gMe, "pErstehilfe", tonumber(getElementData(gMe, "pErstehilfe"))+1)
		outputChatBox("Du hast dir ein Erste-Hilfe Koffer gekauft. Du kannst ihn im Inventar benutzen!", 0, 200, 0)
	end, false)
	
	addEventHandler("onClientGUIClick", TANKnopf[3],
	function()
		local money = tonumber(getElementData(gMe, "pHGeld"))
		if(money < kanisterpreis) then outputChatBox("Dir fehlen "..(money-kanisterpreis).." $!", 200, 0, 0) return end
		if(tonumber(getElementData(gMe, "pKanister")) > 1) then outputChatBox("Du kannst nur Maximal 2 Benzinkanister Tragen!", 200, 0, 0) return end
		setElementData(gMe, "pHGeld", money-kanisterpreis)
		setElementData(gMe, "pKanister", tonumber(getElementData(gMe, "pKanister"))+1)
		outputChatBox("Du hast dir ein Benzinkanister gekauft. Du kannst ihn im Inventar benutzen!", 0, 200, 0)
	end, false)
	addEventHandler("onClientGUIChanged", TANEdit[1],
	function()
		if(guiRadioButtonGetSelected(TANRadio[2]) == true) then
			local myBenzin = tonumber(getElementData(getPedOccupiedVehicle(gMe), "fuel"))
			local eingetippt = tonumber(guiGetText(TANEdit[1]))
			if(eingetippt) then
				if(eingetippt < 101) and (eingetippt > 0) then
					local kaufend = (eingetippt)
					local kaufpreis = math.ceil(kaufend*curPreis)
					guiSetText(TANLabel[3], "Insgesammte Kosten:\n"..kaufpreis.."$")
				else
					guiSetText(TANLabel[3], "Insgesammte Kosten:\nError")
				end
			end
		end
	end, false)
	addEventHandler("onClientGUIClick", TANRadio[2],
	function()
		if(guiRadioButtonGetSelected(TANRadio[2]) == true) then return end
		guiSetText(TANLabel[3], "Insgesammte Kosten:\n0$")
	end, false)
	addEventHandler("onClientGUIClick", TANRadio[1],
	function()
		local myBenzin = tonumber(getElementData(getPedOccupiedVehicle(gMe), "fuel"))
		local kaufend = (100-myBenzin)
		local kaufpreis = math.ceil(kaufend*curPreis)
		guiSetText(TANLabel[3], "Insgesammte Kosten:\n"..kaufpreis.."$")
	end, false)
	
	addEventHandler("onClientGUIClick", TANKnopf[2],
	function()
		local radio1 = guiRadioButtonGetSelected(TANRadio[1])
		local radio2 = guiRadioButtonGetSelected(TANRadio[2])
		if(radio1 == true) then
			local myBenzin = tonumber(getElementData(getPedOccupiedVehicle(gMe), "fuel"))
			if(myBenzin > 95) then outputChatBox("Du hast noch Genug Benzin!", 200, 0, 0, false) return end
			local kaufend = (100-myBenzin)
			local kaufpreis = math.ceil(kaufend*curPreis)
			local myGeld = tonumber(getElementData(gMe, "pHGeld"))
			if(kaufpreis > myGeld) then outputChatBox("Du hast nicht Genug Geld! Dir fehlen "..(myGeld-kaufpreis).." $.", 200, 0, 0, false) return end
			triggerServerEvent("onTankstelleFill", gMe, getPedOccupiedVehicle(gMe), kaufend, kaufpreis)
			fadeCamera(false, 1.5, 255, 255, 255)
		elseif(radio2 == true) then
			local myBenzin = tonumber(getElementData(getPedOccupiedVehicle(gMe), "fuel"))
			if(myBenzin > 95) then outputChatBox("Du hast noch Genug Benzin!", 200, 0, 0, false) return end
			local kaufend = tonumber(guiGetText(TANEdit[1]))
			if(kaufend < 0) or (kaufend > myBenzin) then outputChatBox("Fehlerhafte Treifstoffmenge!", 200, 0, 0, false) return end
			local kaufpreis = math.ceil(kaufend*curPreis)
			local myGeld = tonumber(getElementData(gMe, "pHGeld"))
			if(kaufpreis > myGeld) then outputChatBox("Du hast nicht Genug Geld! Dir fehlen "..(myGeld-kaufpreis).." $.", 200, 0, 0, false) return end
			triggerServerEvent("onTankstelleFill", gMe, getPedOccupiedVehicle(gMe), kaufend, kaufpreis)
			fadeCamera(false, 1.5, 255, 255, 255)
		else
			outputChatBox("Du musst eine Art auswaehlen!", 200, 0, 0, false) return
		end
		Guivar = 0
		destroyElement(TANFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
		
	end, false)
	addEventHandler("onClientGUIClick", TANKnopf[1],
	function()
		Guivar = 0
		destroyElement(TANFenster[1])
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
		setElementFrozen(getPedOccupiedVehicle(gMe), false)
		toggleAllControls(true)
		setCameraTarget(gMe)
	end, false)
end)