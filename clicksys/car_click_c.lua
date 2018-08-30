--[[ 
|===================|
|Script bei MuLTi&  |
|SK_Styla! [C]!     |
|===================| --]]

local Guivar = 0
addEventHandler("onClientRender", getRootElement(),
function()
if(Guivar == 1) then showCursor(true) end
end)

function createCarWindow(vehicle)
if(Guivar == 1) then return end
Guivar = 1

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 331,181
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	showCursor(true)
	local Carfenster = {}
	local Carknopf = {}
	local Carlabel = {}
	
	--local name = getVehicleName(vehicle)
	local id = getElementModel(vehicle)
	local Besitzer = getElementData(vehicle, "Besitzer")
	local myFraktion = tonumber(getElementData(gMe, "pFraktion"))
	if not(myFraktion) then myFraktion = 0 end
	local myFraktionName = fraktionNamen[myFraktion]
	if not(Besitzer) then Besitzer = "Niemand" end
	local Astate = isVehicleLocked(vehicle)
	local Locked = "Nein"
	if(Astate == true) then Locked = "Ja" else Locked = "Nein" end
	local KM = getElementData(vehicle, "Kilometer")
	if not(KM) then KM = 0 end
	local Typ = getElementData(vehicle, "Typ")
	if not(Typ) then Typ = "Nicht gesetzt" end
	Carfenster[1] = guiCreateWindow(X, Y, Width, Height, "Fahrzeugdetails",false)
	Carlabel[1] = guiCreateLabel(13,29,196,16,"Fahrzeugmodell: "..id,false,Carfenster[1])
	guiSetFont(Carlabel[1],"default-bold-small")
	Carlabel[2] = guiCreateLabel(12,50,196,17,"Besitzer: "..Besitzer,false,Carfenster[1])
	guiSetFont(Carlabel[2],"default-bold-small")
	Carlabel[3] = guiCreateLabel(9,72,188,18,"Abgeschlossen: "..Locked,false,Carfenster[1])
	guiSetFont(Carlabel[3],"default-bold-small")
	Carlabel[4] = guiCreateLabel(11,96,190,27,"Kilometer Hinterlegt:\n"..KM.." KM",false,Carfenster[1])
	guiSetFont(Carlabel[4],"default-bold-small")
	Carlabel[5] = guiCreateLabel(9,138,189,20,"Typ: "..Typ,false,Carfenster[1])
	guiSetFont(Carlabel[5],"default-bold-small")
	Carknopf[1] = guiCreateButton(211,25,109,30,"Abbrechen",false,Carfenster[1])
	Carknopf[2] = guiCreateButton(211,62,109,30,"Abschliessen",false,Carfenster[1])
	Carknopf[3] = guiCreateButton(211,99,109,30,"Reparieren",false,Carfenster[1])
	Carknopf[4] = guiCreateButton(211,137,109,30,"Licht An/Aus",false,Carfenster[1])
	Carknopf[8] = guiCreateButton(130,26,76,28,"Parken",false,Carfenster[1])
	guiSetFont(Carknopf[1], "default-bond-small")
	guiSetFont(Carknopf[2], "default-bond-small")
	guiSetFont(Carknopf[3], "default-bond-small")
	guiSetFont(Carknopf[4], "default-bond-small")
	guiSetFont(Carknopf[8], "default-bond-small")
	local schrott = tonumber(getElementData(vehicle, "Schrott"))
	if(schrott) then
		if(schrott == 1) then
			guiSetEnabled(Carknopf[3], true)
		else
			guiSetEnabled(Carknopf[3], false)
		end
	else
		guiSetEnabled(Carknopf[3], false)
	end

	if(tonumber(getElementData(gMe, "pAdminlevel")) > 1) then
			
			local Width,Height = 463,180
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
		
		guiSetSize(Carfenster[1], Width, Height, false)
		guiSetPosition(Carfenster[1], X, Y, false)
		
		Carknopf[5] = guiCreateButton(327,25,109,30,"Respawnen",false,Carfenster[1])
		local Caredit = guiCreateEdit(327,57,111,28,"Grund",false,Carfenster[1])
		Carknopf[6] = guiCreateButton(327,88,109,30,"Loeschen",false,Carfenster[1])
		Carknopf[7] = guiCreateButton(327,122,109,30,"Reparieren",false,Carfenster[1])
		addEventHandler("onClientGUIClick", Carknopf[7], -- Reparieren
		function()
			triggerServerEvent("set_vehicle_fix", gMe, vehicle)
		end, false)
			addEventHandler("onClientGUIClick", Carknopf[6], -- Loeschen
		function()
			local typ = getElementData(vehicle, "Typ")
			if(typ == "Fraktionsauto") then outputChatBox("Fehler beim Loeschen des Autos!", 255, 0, 0, false) return end
			triggerServerEvent("set_vehicle_remove", gMe, vehicle, guiGetText(Caredit))
		end, false)
		
		addEventHandler("onClientGUIClick", Carknopf[5], -- Respawnen
		function()
			triggerServerEvent("set_vehicle_respawn", gMe, vehicle)
		end,false)
	end
	addEventHandler("onClientGUIClick", Carknopf[2],
	function()
		if(Besitzer == getPlayerName(gMe)) or (Besitzer == myFraktionName) then
			triggerServerEvent("onVehActionTrigger", gMe, vehicle, 3)
		else
			infolabel_func("Du bist nicht der Besitzer\noder ein Fraktionsmitglied!", 255, 0, 0, 3000)
		end
		
	end, false)
	addEventHandler("onClientGUIClick", Carknopf[3],
	function()
		if(Besitzer == getPlayerName(gMe)) or (Besitzer == myFraktionName) then
			triggerServerEvent("onVehActionTrigger", gMe, vehicle, 5)
			guiSetVisible(Carfenster[1], false)
			showCursor(false)
			Guivar = 0
			setTimer(setElementData, 250, 1,gMe, "Clicked", nil)
		else
			infolabel_func("Du bist nicht der Besitzer!", 255, 0, 0, 3000)
		end
	end, false)
	addEventHandler("onClientGUIClick", Carknopf[8],
	function()
		if(Besitzer == getPlayerName(gMe)) or (Besitzer == myFraktionName)then
			triggerServerEvent("onVehActionTrigger", gMe, vehicle, 4)
		else
			if(getPlayerFraktion(gMe) == 4) or (getPlayerFraktion(gMe) == 7) then
				triggerServerEvent("onVehActionAbschlepp", gMe, vehicle)
			else
				infolabel_func("Du bist nicht der Besitzer!", 255, 0, 0, 3000)
			end
		end
		
	end, false)	
	addEventHandler("onClientGUIClick", Carknopf[1],
	function()
		guiSetVisible(Carfenster[1], false)
		showCursor(false)
		Guivar = 0
		setTimer(setElementData, 250, 1,gMe, "Clicked", nil)
	end, false)
end

addEvent("onCarClicksys", true)
addEventHandler("onCarClicksys", getRootElement(),
function(vehicle)
	if not(vehicle) then return end
	if not(source == gMe) then return end
	createCarWindow(vehicle)
end)