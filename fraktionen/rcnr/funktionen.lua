

local Marker1 = createMarker(2252.2358398438, 70.569923400879, 26.40781211853, "corona", 1.0, 255, 255, 255, 200)
-- Draussen: 2252.3259277344, 69.696235656738, 26.40781211853
local Marker2 = createMarker(368.34893798828, 162.32258605957, 1014.1826171875, "corona", 1.0, 255, 255, 255, 200)
setElementInterior(Marker2, 3)
-- Drinnen: 365.77322387695, 162.55743408203, 1014.1875
local Tuer = createObject(1498, 368.79998779297, 161.60000610352, 1013.200012207, 0, 0, 90) setElementInterior(Tuer, 3) 
local Zeitungsmarker = createMarker(330.46884155273, 191.62963867188, 1014.8875, "arrow", 1.0, 0, 255, 0, 200)
setElementInterior(Zeitungsmarker, 3)

addEventHandler("onMarkerHit", Zeitungsmarker,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	if(getPlayerFraktion(hitElement) ~= 5) then return end
	local text = ""
	local query = "SELECT * FROM zeitung WHERE NAME = 'RCNR'"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		text = row['TEXT']
	else
		mysql_query( handler, "INSERT INTO zeitung ( NAME, TEXT ) VALUES ( 'RCNR', '' )" )
		text = ""
	end
	triggerClientEvent(hitElement, "onRCNRZeitungEditier", hitElement, text)
end)

addEvent("onRCNRZeitungFertigEditier", true)
addEventHandler("onRCNRZeitungFertigEditier", getRootElement(),
function(text)
	if not(text) then return end
	local query = "SELECT * FROM zeitung WHERE NAME = 'RCNR'"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local r = mysql_query(handler,"UPDATE zeitung SET TEXT = '"..text.."' WHERE NAME = 'RCNR'")
		if(r) then outputChatBox("Du hast die Zeitung erfolgreich Editiert!", source, 0, 200, 0, false) else outputChatBox("Fehler beim Speichern der Zeitung!", source, 0, 200, 0, false) end
	else
		mysql_query( handler, "INSERT INTO zeitung ( NAME, TEXT ) VALUES ( 'RCNR', '' )" )
		local r = mysql_query(handler,"UPDATE zeitung SET TEXT = '"..text.."' WHERE NAME = 'RCNR'")
		if(r) then outputChatBox("Du hast die Zeitung erfolgreich Editiert!", source, 0, 200, 0, false) else outputChatBox("Fehler beim Speichern der Zeitung!", source, 0, 200, 0, false) end
	end
end)

addEvent("onRCNRZeitungKauf", true)
addEventHandler("onRCNRZeitungKauf", getRootElement(),
function()
	local query = "SELECT * FROM kassen"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		local r = mysql_query(handler,"UPDATE kassen SET RCNR = '"..(row['RCNR']+25).."'")
		mysql_free_result(result)
		mysql_free_result(r)
	else 
	end
end)


addEvent("onRCNRZeitungNeed", true)
addEventHandler("onRCNRZeitungNeed", getRootElement(),
function()
	local text = ""
	local query = "SELECT * FROM zeitung WHERE NAME = 'RCNR'"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		text = row['TEXT']
		triggerClientEvent(source, "onRCNRZeitungNeedBack", source, text)
	else
		mysql_query( handler, "INSERT INTO zeitung ( NAME, TEXT ) VALUES ( 'RCNR', '' )" )
		text = "Keine Zeitung vorhanden"
		triggerClientEvent(source, "onRCNRZeitungNeedBack", source, text)
	end
	
end)
addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	if(getPlayerFraktion(hitElement) ~= 5) then outputChatBox("Du hast kein Schluessel fuer die Tuer.", hitElement, 200, 0, 0, false) return end
	setInPosition(hitElement, 365.77322387695, 162.55743408203, 1014.1875, 3)
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 2252.3259277344, 69.696235656738, 26.40781211853, 0)
end)

-- NEWS --

addCommandHandler("news",
function(thePlayer, cmd, ...)
	local veh = getPedOccupiedVehicle(thePlayer)
	if (getPlayerFraktion(thePlayer) ~= 5) then return end
	if not(veh) then outputChatBox("Du musst in einem Newsvan sitzen!", thePlayer, 200, 0, 0, false) return end
	if (isANewsVan(veh) == false) then outputChatBox("Du musst in einem Newsvan sitzen!", thePlayer, 200, 0, 0, false) return end
	if not(...) then outputChatBox("Du musst ein Text eingeben!", thePlayer, 200, 0, 0, false) return end
	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	outputChatBox("|[Reporter "..getPlayerName(thePlayer)..": "..text.."]|", getRootElement(), 255, 221, 0)
	setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld")+5)
end)


function isANewsVan(vehicle)
	if not(vehicle) then return end
	if(getElementModel(vehicle) == 582) or (getElementModel(vehicle) == 488) then return true;
	else return false; end
end


