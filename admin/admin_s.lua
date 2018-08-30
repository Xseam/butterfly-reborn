local resourcen = {
	[1] = "Kartbahn",
}
local resourcenNamen = {
	["Kartbahn"] = "kartbahn",
}

addEvent("onNotAdminPanelObjectDelete", true)
addEventHandler("onNotAdminPanelObjectDelete", getRootElement(),
function()
	local obs = 0
	for index, ob in pairs(getElementsByType("object")) do
		if(getElementData(ob, "O_MOVEABLE2") == true) then
			destroyElement(ob)
			obs = obs+1
		end
	end
	if(obs == 0) then outputChatBox("Es sind keine Erstellten Objekte da!", source, 200, 0, 0,false) return end
	outputChatBox(obs.." Objekte geloescht.", source, 0, 200, 0)
end)

addEvent("onNotAdminPanelResourceRestart", true)
addEventHandler("onNotAdminPanelResourceRestart", getRootElement(), function(res)
	local res = getResourceFromName(resourcenNamen[res])
	if not(res) then outputChatBox("Resource nicht auf dem Server.", source, 255, 0, 0) return end
	local state = getResourceState(res)
	if(state ~= "running") then outputChatBox("Resource laeuft nicht!", source, 255, 0, 0) return end
	local suc = restartResource(res)
	if(suc) then
		outputChatBox("Resource "..getResourceName(res).." wurde neu gestartet.", source, 0, 200, 0)
		triggerClientEvent(source, "onNotAdminPanelResourcenUpdate", source)
		outputServerLog(getPlayerName(source).." hat Resource "..getResourceName(res).." neu gestartet.")
	else
		outputChatBox("Resource "..getResourceName(res).." konnte nicht neu gestartet werden.", source, 0, 200, 0)
	end
end)

addEvent("onNotAdminPanelResourceStop", true)
addEventHandler("onNotAdminPanelResourceStop", getRootElement(), function(res)
	local res = getResourceFromName(resourcenNamen[res])
	if not(res) then outputChatBox("Resource nicht auf dem Server.", source, 255, 0, 0) return end
	local state = getResourceState(res)
	if(state ~= "running") then outputChatBox("Resource laeuft nicht!", source, 255, 0, 0) return end
	local suc = stopResource(res)
	if(suc) then
		outputChatBox("Resource "..getResourceName(res).." wurde gestoppt.", source, 0, 200, 0)
		triggerClientEvent(source, "onNotAdminPanelResourcenUpdate", source)
		outputServerLog(getPlayerName(source).." hat Resource "..getResourceName(res).." gestoppt.")
	else
		outputChatBox("Resource "..getResourceName(res).." konnte nicht gestoppt werden.", source, 0, 200, 0)
	end
end)

addEvent("onNotAdminPanelResourceStart", true)
addEventHandler("onNotAdminPanelResourceStart", getRootElement(), function(res)
	local res = getResourceFromName(resourcenNamen[res])
	if not(res) then outputChatBox("Resource nicht auf dem Server.", source, 255, 0, 0) return end
	local state = getResourceState(res)
	if(state == "running") then outputChatBox("Resource laeuft bereits!", source, 255, 0, 0) return end
	local suc = startResource(res)
	if(suc) then
		outputChatBox("Resource "..getResourceName(res).." wurde gestartet.", source, 0, 200, 0)
		triggerClientEvent(source, "onNotAdminPanelResourcenUpdate", source)
		outputServerLog(getPlayerName(source).." hat Resource "..getResourceName(res).." gestartet.")
	else
		outputChatBox("Resource "..getResourceName(res).." konnte nicht gestartet werden.", source, 0, 200, 0)
	end
end)

addEvent("onNotAdminPanelResourcenGet", true)
addEventHandler("onNotAdminPanelResourcenGet", getRootElement(), function()
	for i = 1, #resourcen, 1 do
		local name = resourcenNamen[resourcen[i]]
		local res = getResourceFromName(name)
		local running
		if not(res) then running = "N/A" else
			running = getResourceState(res)
			if(running == "running") then running = "Ja" else running = "Nein" end
		end
		triggerClientEvent(source, "onNotAdminPanelResourcenGetBack", source, resourcen[i], running)
	end
end)

addEvent("onNotAdminPanelNotabschaltung", true)
addEventHandler("onNotAdminPanelNotabschaltung", getRootElement(),
function()	
	if(client ~= source) then return end
	local playa = source
	for index, spieler in pairs(getElementsByType("player")) do
		kickPlayer(spieler, "Console", "Notabschaltung.\nAbgeschaltet von: "..getPlayerName(source))
	end

	shutdown("Notabschaltung")
end)
addCommandHandler("o",function(thePlayer, cmd, ...)
	if(getPlayerAdminlevel(thePlayer) < 1) then outputChatBox("Du bist nicht Befugt.", thePlayer, 200, 0, 0) return end
	if not(...) then outputChatBox("Bitte geb einen Text ein!", thePlayer, 200, 0, 0) return end
	local text = table.concat( {...}, " " )
	local title = "N/A"
	local ad = getPlayerAdminlevel(thePlayer)
	if(ad == 1) then title = "Supporter" end
	if(ad == 2) then title = "Moderator" end
	if(ad == 3) then title = "Super Mod" end
	if(ad == 4) then title = "Administrator" end
	if(ad == 5) then title = "Inhaber" end
	if(ad == 6) then title = "Projektleiter" end
	outputChatBox("(("..title.." "..getPlayerName(thePlayer)..": "..text.."))", getRootElement(), 255, 255, 255)
end)
addEvent("onNotAdminPanelGamemoderestart", true)
addEventHandler("onNotAdminPanelGamemoderestart", getRootElement(),
function()	
	if(client ~= source) then return end
	outputChatBox("Server wird restartet...", source, 0, 200, 200)
	local playa = source
	setTimer(function()
		local res = getResourceFromName ( "xpreallife" )
		local sucess = restartResource(res)
		if(sucess) then
		
		else
			outputChatBox("Fehler beim Restarten des Gamemodes!", playa, 200, 0, 0 )
		end
	end, 3500, 1)
end)

addEvent("onNotAdminPanelHouserestart", true)
addEventHandler("onNotAdminPanelHouserestart", getRootElement(),
function()
	if(client ~= source) then return end
	if(Hausvar == 1) then outputChatBox("Bitte Warte eine Minute!", source, 200, 0, 0) return end
	local res = getResourceFromName ( "xp-housesystem" )
	local sucess = restartResource(res)
	if(sucess) then
		Hausvar = 1
		setTimer(function()
			Hausvar = 0
		end, 60000, 1)
		outputChatBox("Haussystem wird restartet!", source, 0, 200, 0)
	else
		outputChatBox("Fehler! Resource nicht Laufend, oder nicht gefunden.", source, 200, 0, 0)
	end
end)

addEvent("onNotAdminPanelObjectRespawn", true)
addEventHandler("onNotAdminPanelObjectRespawn", getRootElement(),
function()
	executeCommandHandler("reposdynob", source)
end)
addEvent("onNotAdminPanelObjectCreate", true)
addEventHandler("onNotAdminPanelObjectCreate", getRootElement(),
function(id)
	if client ~= source then return end
	if not(id) then return end
	local x, y, z = getElementPosition(source)
	local object = createObject(id, x, y, z)
	setElementInterior(object, getElementInterior(source))
	setElementData(object, "O_MOVEABLE", true)
	setElementData(object, "O_MOVEABLE2", true)
	addEventHandler("onElementClicked", object,
		function(but, stat, thePlayer)
			if(but == "left") and (stat == "down") then
				if(getElementData(thePlayer, "Clicked") == 1) then return end
					local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
					setElementData(thePlayer, "Clicked", 1)
					setTimer(setElementData, 1250, 1, thePlayer, "Clicked", 0)
					setPlayerToDymObject(thePlayer, source)
				end
		end)
		outputChatBox("Dynamisches Objekt Erstellt!", source, 0, 200, 0)
		setElementPosition(source, x, y, z+1)
end)


addEvent("onNotAdminPanelDIM", true)
addEventHandler("onNotAdminPanelDIM", getRootElement(),
function(playa, id)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local sucess = setElementDimension(playa, id)
	if(sucess) then outputChatBox("Du wurdest von Admin "..getPlayerName(source).." in die Dimension "..id.." verschoben.", playa, 0, 200, 0, false) outputChatBox("Du hast "..getPlayerName(playa).." in die Dimension "..id.." verschoben.", source, 0, 200, 0, false) else outputChatBox("Fehler !", source, 200, 0, 0, false) end
end)

addEvent("onNotAdminPanelINT", true)
addEventHandler("onNotAdminPanelINT", getRootElement(),
function(playa, id)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local sucess = setElementInterior(playa, id)
	if(sucess) then outputChatBox("Du wurdest von Admin "..getPlayerName(source).." in den Interior "..id.." verschoben.", playa, 0, 200, 0, false) outputChatBox("Du hast "..getPlayerName(playa).." in Interior "..id.." verschoben.", source, 0, 200, 0, false) else outputChatBox("Fehler !", source, 200, 0, 0, false) end
end)

addEvent("onNotAdminPanelWaffeGeb", true)
addEventHandler("onNotAdminPanelWaffeGeb", getRootElement(),
function(playa, id, anzahl)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local sucess = giveWeapon(playa, id, anzahl)
	if(sucess) then outputChatBox("Dir wurde von Admin "..getPlayerName(source).." die Waffe "..id.." mit "..anzahl.." schuss gegeben.", playa, 0, 200, 0, false) outputChatBox("Du hast "..getPlayerName(playa).." die Waffe "..id.." mit "..anzahl.." schuss gegeben.", source, 0, 200, 0, false) else outputChatBox("Fehler beim Geben der Waffe!", source, 200, 0, 0, false) end
end)

addEvent("onNotAdminPanelPorteHer", true)
addEventHandler("onNotAdminPanelPorteHer", getRootElement(),
function(playa, text)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local x, y, z = getElementPosition(source)
	local int, dim = getElementInterior(source), getElementDimension(source)
	if(isPedInVehicle(playa) == true) then setElementPosition(getPedOccupiedVehicle(playa), x, y+1, z) else setElementPosition(playa, x, y+1, z) end
	setElementInterior(playa, int)
	setElementDimension(playa, dim)
end)

addEvent("onNotAdminPanelzuPorte", true)
addEventHandler("onNotAdminPanelzuPorte", getRootElement(),
function(playa, text)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local x, y, z = getElementPosition(playa)
	local int, dim = getElementInterior(playa), getElementDimension(playa)
	if(isPedInVehicle(source) == true) then setElementPosition(getPedOccupiedVehicle(source), x, y+1, z) else setElementPosition(source, x, y+1, z) end
	setElementInterior(source, int)
	setElementDimension(source, dim)
end)

addEvent("onNotAdminPanelHandGeldGebe", true)
addEventHandler("onNotAdminPanelHandGeldGebe", getRootElement(),
function(playa, text)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	local geld = tonumber(getElementData(playa, "pHGeld"))
	setElementData(playa, "pHGeld", geld+text)
	outputChatBox("Dir wurde von Admin "..getPlayerName(source).." "..text.."$ gegeben.", playa, 0, 255, 255, false)
	outputChatBox("Du hast "..getPlayerName(playa).." "..text.."$ gegeben.", source, 0, 255, 255, false)
end)

addEvent("onNotAdminPanelHandGeld", true)
addEventHandler("onNotAdminPanelHandGeld", getRootElement(),
function(playa, text)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	setElementData(playa, "pHGeld", text)
	outputChatBox("Dein Handgeld wurde von Admin "..getPlayerName(source).." auf "..text.."$ gesetzt.", playa, 0, 255, 255, false)
	outputChatBox("Du hast "..getPlayerName(playa).."'s Handgeld auf "..text.."$ gesetzt.", source, 0, 255, 255, false)
end)

addEvent("onNotAdminPanelBankGeld", true)
addEventHandler("onNotAdminPanelBankGeld", getRootElement(),
function(playa, text)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	setElementData(playa, "pBGeld", text)
	outputChatBox("Dein Bankgeld wurde von Admin "..getPlayerName(source).." auf "..text.."$ gesetzt.", playa, 0, 255, 255, false)
	outputChatBox("Du hast "..getPlayerName(playa).."'s Bankgeld auf "..text.."$ gesetzt.", source, 0, 255, 255, false)
end)

addEvent("onNotAdminPanelRang", true)
addEventHandler("onNotAdminPanelRang", getRootElement(),
function(playa, id)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	setElementData(playa, "pFraktionsrang", id)
	outputChatBox("Du wurdest von Admin "..getPlayerName(source).." auf Rang "..id.." gesetzt.", playa, 0, 255, 255, false)
	outputChatBox("Du hast "..getPlayerName(playa).." auf Rang "..id.." gesetzt.", source, 0, 255, 255, false)
end)

addEvent("onNotAdminPanelLeader", true)
addEventHandler("onNotAdminPanelLeader", getRootElement(),
function(playa, id)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	setElementData(playa, "pFraktion", id)
	setElementData(playa, "pFraktionsrang", 6)
	outputChatBox("Du wurdest von Admin "..getPlayerName(source).." zum Leader der Fraktion "..id.." ernannt.", playa, 0, 255, 255, false)
	outputChatBox("Du hast "..getPlayerName(playa).." Leader der Fraktion "..id.." gemacht.", source, 0, 255, 255, false)
end)

addEvent("onNotAdminPanelFreeze", true)
addEventHandler("onNotAdminPanelFreeze", getRootElement(),
function(playa)
	if client ~= source then return end
	local playa = getPlayerFromName(playa)
	if(isElementFrozen(playa)) then
		setElementFrozen(playa, false)
		outputChatBox(getPlayerName(playa).." wurde entfroren.", source, 0, 200, 0, false) 
		outputChatBox("Du wurdest von "..getPlayerName(source).." entfroren.", playa, 0, 200, 0, false) 
	else
		setElementFrozen(playa, true)
		outputChatBox(getPlayerName(playa).." wurde eingefroren.", source, 0, 200, 0, false) 
		outputChatBox("Du wurdest von Admin "..getPlayerName(source).." eingefroren.", playa, 200, 0, 0, false)
	end
end)

addEvent("onNotAdminPanelKick", true)
addEventHandler("onNotAdminPanelKick", getRootElement(),
function(playa, text)
	if client ~= source then return end
	if not(playa) then return end
	if not(getPlayerFromName(playa)) then return end
	local playa = getPlayerFromName(playa)
	outputChatBox("#FF0000AdminCMD: #FFFFFF"..getPlayerName(playa).." #FF0000wurde von #FFFFFF"..getPlayerName(source).." #FF0000vom Server gekickt.", getRootElement(), 255, 255, 255, true)
	outputChatBox("#FF0000Grund: "..text, getRootElement(), 255, 255, 255, true)
	outputServerLog(getPlayerName(source).." hat "..getPlayerName(playa).." mit dem Grund "..text.." gekickt.")
	kickPlayer(playa, source, text)
end)
addEvent("onNotAdminPanelBan", true)
addEventHandler("onNotAdminPanelBan", getRootElement(),
function(playa, text, zeit)
	if client ~= source then return end
	if not(playa) then return end
	if not(getPlayerFromName(playa)) then return end
	local playa = getPlayerFromName(playa)
	--kickPlayer(playa, source, text)
	outputChatBox("#FF0000AdminCMD: #FFFFFF"..getPlayerName(playa).." #FF0000wurde von #FFFFFF"..getPlayerName(source).." #FF0000fuer "..zeit.." Stunden gebannt.", getRootElement(), 255, 255, 255, true)
	outputChatBox("#FF0000Grund: "..text, getRootElement(), 255, 255, 255, true)
	outputServerLog(getPlayerName(source).." hat "..getPlayerName(playa).." mit dem Grund "..text.." fuer "..zeit.." Stunden gebannt.")
	local name = getPlayerName(source)
	local name2 = getPlayerName(playa)
	local ip = getPlayerIP(playa)
	local serial = getPlayerSerial(playa)
	time = zeit*3600
	local _stamp = getRealTime()
	_stamp = _stamp.timestamp
	local stamp = getRealTime( tonumber(_stamp+time) )
	stamp = stamp.timestamp
	
	local query = "INSERT INTO ban ( Name, Admin, Grund, Datum, IP, Serial ) VALUES ( '"..name2.."', '"..name.."', '"..text.."', '"..stamp.."', '"..ip.."', '"..serial.."'  )"
	local result = mysql_query( handler, query )
	kickPlayer(playa,"Du wurdest fuer "..zeit.." Stunden von "..name.." gebannt. \nGrund: "..text)
	
	if result then mysql_free_result(result) return true else return false end
end)

addEventHandler ( "onPlayerConnect", getRootElement(),
	function (playerNick,playerSerial )
	
		local pname = playerNick
		local pserial = playerSerial
		
		local query = mysql_query( handler, "SELECT Name, Datum FROM ban WHERE Name = '"..pname.."'")
		local _query = mysql_query( handler, "SELECT Name, Datum FROM ban WHERE Serial = '"..pserial.."'")
		
		local rows = mysql_num_rows ( query )
		local _rows = mysql_num_rows ( _query )
		local _stamp = getRealTime()
		_stamp = tonumber(_stamp.timestamp)
		
		if rows > 0 then
		
			local dsatz = mysql_fetch_assoc ( query )
			
			if _stamp > tonumber(dsatz["Datum"]) and tonumber(dsatz["Datum"]) == 0 then
			
				cancelEvent( true, "Du bist Permanent gebannt. Bitte Melde dich bei einem Admin, falls du Fragen hast." )
			
			elseif _stamp > tonumber(dsatz["Datum"]) then
			
				mysql_query( handler, "DELETE FROM ban WHERE Name = '"..pname.."'")
			
			elseif _stamp < tonumber(dsatz["Datum"]) then
			
				cancelEvent( true, "Du wurdest Gebannt. fuer Fragen melde dich bei einem Admin\noder im Forum." )
			
			end
			
			return true
		
		end
		
		if _rows > 0 then
		
			local dsatz = mysql_fetch_assoc ( _query )
			
			if _stamp > tonumber(dsatz["Datum"]) and tonumber(dsatz["Datum"]) == 0 then
			
				cancelEvent( true, "Du bist Permanent gebannt. Bitte Melde dich bei einem Admin, falls du Fragen hast." )
			
			elseif _stamp > tonumber(dsatz["Datum"]) then
			
				mysql_query( handler, "DELETE FROM ban WHERE Serial = '"..pserial.."'")
			
			elseif _stamp < tonumber(dsatz["Datum"]) then
			
				cancelEvent( true, "Du wurdest Gebannt. fuer Fragen melde dich bei einem Admin\noder im Forum." )
			
			end
			
			return true
		
		end
			
	end )