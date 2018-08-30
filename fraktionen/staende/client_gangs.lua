local Marker = createMarker(352.85870361328, -1810.1188964844, 3.9666110992432, "cylinder", 1.0,  0, 255, 0, 200)
local Guivar = 0

function createStandBoese()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	
	local Fenster = {}
	local Knopf = {}
	local Label = {}
	local Radio = {}

	local X, Y, Width, Height = getMiddleGuiPosition(282,258)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Schiesstand",false)
	Label[1] = guiCreateLabel(19,23,246,28,"Willkommen beim Schiesstand!\nHier kannst du schiessuebungen machen.",false,Fenster[1])
	guiLabelSetHorizontalAlign(Label[1],"center",false)
	guiSetFont(Label[1],"default-bold-small")
	Knopf[1] = guiCreateButton(12,219,116,30,"Abbrechen",false,Fenster[1])
	Label[2] = guiCreateLabel(12,66,52,20,"Waffe:",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Radio[1] = guiCreateRadioButton(11,91,99,19,"9mm",false,Fenster[1])
	guiSetFont(Radio[1],"default-bold-small")
	Radio[2] = guiCreateRadioButton(11,108,99,19,"Desert Eagle",false,Fenster[1])
	guiSetFont(Radio[2],"default-bold-small")
	Radio[3] = guiCreateRadioButton(11,125,99,19,"MP5",false,Fenster[1])
	guiSetFont(Radio[3],"default-bold-small")
	Radio[4] = guiCreateRadioButton(11,142,99,19,"Schrotflinte",false,Fenster[1])
	guiSetFont(Radio[4],"default-bold-small")
	Radio[5] = guiCreateRadioButton(11,159,99,19,"AK47",false,Fenster[1])
	guiSetFont(Radio[5],"default-bold-small")
	Radio[6] = guiCreateRadioButton(11,175,99,19,"M4",false,Fenster[1])
	guiSetFont(Radio[6],"default-bold-small")
	Radio[7] = guiCreateRadioButton(11,191,99,19,"Tec-9",false,Fenster[1])
	guiSetFont(Radio[7],"default-bold-small")
	Radio[8] = guiCreateRadioButton(124,92,95,18,"Gewehr",false,Fenster[1])
	guiSetFont(Radio[8],"default-bold-small")
	Radio[9] = guiCreateRadioButton(124,108,95,18,"Sniper",false,Fenster[1])
	guiSetFont(Radio[9],"default-bold-small")
	Radio[10] = guiCreateRadioButton(124,124,95,18,"SPAZ-12",false,Fenster[1])
	guiRadioButtonSetSelected(Radio[10],true)
	guiSetFont(Radio[10],"default-bold-small")
	Knopf[2] = guiCreateButton(134,219,116,30,"Uebung Starten",false,Fenster[1])
	Knopf[3] = guiCreateButton(134,179,116,30,"Ziele Neu erstellen",false,Fenster[1])

	if(getElementData(gMe, "shooting") == true) then
		guiSetText(Knopf[2], "Uebung Beenden")
	end
		addEventHandler("onClientGUIClick", Knopf[3], function()
		if(getPlayerFraktionsrang(gMe) > 2) then
			triggerServerEvent("onSchiesstandRestart", gMe)
		else
			outputChatBox("Dies koennen nur User ab Rank 3!", 255, 0, 0)
		end

	end, false)
	addEventHandler("onClientGUIClick", Knopf[2], function()
		if(getElementData(gMe, "shooting") == true) then
			triggerServerEvent("onSchiesstandStop", gMe)
			Guivar = 0
			destroyElement(Fenster[1])
			showCursor(false)
		else
			local waffe = {}
			for i = 1, #Radio, 1 do
				waffe[i] = guiRadioButtonGetSelected(Radio[i])
			end
			local wep = 0
			if(waffe[1] == true) then wep = 22 end
			if(waffe[2] == true) then wep = 24 end
			if(waffe[3] == true) then wep = 29 end
			if(waffe[4] == true) then wep = 25 end
			if(waffe[5] == true) then wep = 30 end
			if(waffe[6] == true) then wep = 31 end
			if(waffe[7] == true) then wep = 32 end
			if(waffe[8] == true) then wep = 33 end
			if(waffe[9] == true) then wep = 34 end
			if(waffe[10] == true) then wep = 27 end	
			if(wep == 0) then return end
			triggerServerEvent("onSchiesstandStart", gMe, wep)
			Guivar = 0
			destroyElement(Fenster[1])
			showCursor(false)
		end

	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		Guivar = 0
		destroyElement(Fenster[1])
		showCursor(false)
	end, false)
end

addEventHandler("onClientMarkerHit", Marker, function(hitElement)
	if(hitElement ~= gMe) then return end
	if(getPlayerFraktion(gMe) == 1) or (getPlayerFraktion(gMe) == 2) or (getPlayerFraktion(gMe) == 6) then
		createStandBoese()
	else
		outputChatBox("Nur fuer Boese Fraktionen!", 200, 0, 0)
	end
end)