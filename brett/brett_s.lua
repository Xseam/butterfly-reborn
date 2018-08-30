local Brett1 = createObject(3927, 223.58999633789, -46.709999084473, 1.3799999952316, 0, 0, 90) -- Blueberry 
local Brett2 = createObject(3927, 223.61000061035, -47.430000305176, -0.9200000166893, 0, 180, 90) -- Blueberry
local Brett3 = createObject(3927, 223.58000183105, -46.569999694824, -0.9200000166893, 0, 180, 90) -- Blueberry
local Marker = createMarker(224.42999267578, -46.849998474121, 0.60000002384186, "cylinder", 1.0, 0, 255, 255, 200) -- Blueberry

local Brett4 = createObject(3927, 631.83001708984, -558.39001464844, 14.760000228882, 0, 180, 90) -- Dillmore
local Brett5 = createObject(3927, 631.86999511719, -556.78997802734, 14.760000228882, 0, 180, 90) -- 
local Brett6 = createObject(3927, 631.88000488281, -557.23999023438, 16.309999465942, 0, 0, 90) -- 
local Marker2 = createMarker(632.89001464844, -557.40997314453, 15.319999694824, "cylinder", 1.0, 0, 255, 255, 200) -- Dillmore

local Brett7 = createObject(3927, 1314.4499511719, 287.05999755859, 18.159999847412, 0, 180, 65) -- Montgomery
local Brett8 = createObject(3927, 1315.0100097656, 288.29998779297, 18.159999847412, 0, 180, 65) -- 
local Brett9 = createObject(3927, 1314.8399658203, 287.98999023438, 19.309999465942, 0, 0, 65) -- 
local Marker3 = createMarker(1314.0200195313, 288.14001464844, 18.530000686646, "cylinder", 1.0, 0, 255, 255, 200) -- Montgomery

setElementData(Brett1, "BRETT", true)
setElementData(Brett2, "BRETT", true)
setElementData(Brett3, "BRETT", true)
setElementData(Marker, "BRETT", true)

setElementData(Brett4, "BRETT", true)
setElementData(Brett5, "BRETT", true)
setElementData(Brett6, "BRETT", true)
setElementData(Marker2, "BRETT", true)

setElementData(Brett7, "BRETT", true)
setElementData(Brett8, "BRETT", true)
setElementData(Brett9, "BRETT", true)
setElementData(Marker3, "BRETT", true)


function brett_click_func( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if (getElementType(source) == "object") then
			if(source == Brett1) or (source == Brett2) or (source == Brett3) or (source == Brett4) or (source == Brett5) or (source == Brett6) or (source == Brett7) or (source == Brett8) or (source == Brett9) then
				if(getElementData(source, "BRETT") ~= true) then return end
				if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
				local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
				triggerClientEvent(thePlayer, "onPlayerBrettClick", thePlayer, getZoneName(x, y, z))
				setElementData(thePlayer, "Clicked", 1)
			end
		end
	end
end	
		
addEventHandler( "onElementClicked", getRootElement(), brett_click_func ) 

addEvent("onBrettDataNeed", true)
addEventHandler("onBrettDataNeed", getRootElement(),
function(id)
	local text = ""
	local x, y, z = getElementPosition(source)
	local zone = getZoneName(x, y, z)
	local query = "SELECT * FROM sonstiges WHERE BRETT = '"..zone.."'"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		text = row['INHALT']
		triggerClientEvent(source, "onBrettDataNeedBack", source, text, id)
	else
		mysql_query( handler, "INSERT INTO sonstiges ( BRETT, INHALT ) VALUES ( '"..zone.."', 'Kein Inhalt' )" )
		text = "Kein Inhalt"
		triggerClientEvent(source, "onBrettDataNeedBack", source, text, id)
	end
end)

addEvent("onBrettDataEditier", true)
addEventHandler("onBrettDataEditier", getRootElement(),
function(text)
	if not(text) then return end
	local x, y, z = getElementPosition(source)
	local zone = getZoneName(x, y, z)
	local query = "SELECT * FROM sonstiges WHERE BRETT = '"..zone.."'"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local r = mysql_query(handler,"UPDATE sonstiges SET INHALT = '"..text.."' WHERE BRETT = '"..zone.."'")
		if(r) then outputChatBox("Du hast das Brett "..zone.." erfolgreich bearbeitet!", source, 0, 200, 0, false) else outputChatBox("Fehler beim Speichern des Brettes!", source, 0, 200, 0, false) end
		triggerEvent("onBrettDataNeed", source, 0)
		outputChatBox("Einwohnermeldung: Das Brett '"..zone.."' wurde von "..getPlayerName(source).." bearbeitet.", getRootElement(), 255, 255, 0)
	else
		mysql_query( handler, "INSERT INTO sonstiges ( BRETT, INHALT ) VALUES ( '"..zone.."', '' )" )
		local r = mysql_query(handler,"UPDATE sonstiges SET INHALT = '"..text.."' WHERE BRETT = '"..zone.."'")
		if(r) then outputChatBox("Du hast das Brett "..zone.." erfolgeich bearbeitet!", source, 0, 200, 0, false) else outputChatBox("Fehler beim Speichern des Brettes!", source, 0, 200, 0, false) end
		triggerEvent("onBrettDataNeed", source, 0)
		outputChatBox("Einwohnermeldung: Das Brett '"..zone.."' wurde von "..getPlayerName(source).." bearbeitet.", getRootElement(), 255, 255, 0)
	end
end)