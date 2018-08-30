
local Marker1 = createMarker(1374.0849609375, 404.88519287109, 19.955516815186, "corona", 1.0, 255, 255, 255, 200) -- Eingang
-- Draussen: 1372.0050048828, 405.87298583984, 19.7578125
local Marker2 = createMarker(-2026.8883056641, -103.60192108154, 1035.1834716797, "corona", 1.0, 255, 255, 255, 200) -- Ausgang
setElementInterior(Marker2, 3)
local Marker3 = createMarker(1393.3563232422, 423.72183227539, 19.970623016357, "corona", 1.0, 255, 255, 255, 200) -- Unten Dach
-- Unten: 1393.9295654297, 425.08511352539, 19.973478317261
local Marker4 = createMarker(1389.4227294922, 405.15219116211, 28.755516052246, "corona", 1.0, 255, 255, 255, 200) -- Oben Dach
-- Oben: 1390.1716308594, 406.57540893555, 28.755516052246

local Tafel = createObject(2164, 1369.7309570313, 401.30838012695, 18.53846244812, 0, 0, 270)

addEventHandler( "onElementClicked", getRootElement(),
function ( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
		if(source == Tafel) then
			if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
				local result = mysql_query( handler, "SELECT * FROM scheinpreise;" )
				if ( result and mysql_num_rows( result ) > 0) then
				local row = mysql_fetch_assoc(result)
				triggerClientEvent("onFahrschulTafelClick", thePlayer, row['FSCHEIN'] or 0, row['LKWSCHEIN'] or 0, row['HELISCHEIN'] or 0, row['FLUGSCHEIN'] or 0, row['BOOTSSCHEIN'] or 0, row['ANGELSCHEIN'] or 0, row['MOTORRADSCHEIN'] or 0)
				setElementData(thePlayer, "Clicked", 1)
				else
					local query2 = "INSERT INTO scheinpreise ( FSCHEIN, LKWSCHEIN, HELISCHEIN, FLUGSCHEIN, BOOTSSCHEIN, ANGELSCHEIN, MOTORRADSCHEIN ) VALUES ( '0', '0', '0', '0', '0', '0', '0' )"
					local result2 = mysql_query( handler, query2 )
					local row = mysql_fetch_assoc(result2)
					triggerClientEvent("onFahrschulTafelClick", thePlayer, row['FSCHEIN'] or 0, row['LKWSCHEIN'] or 0, row['HELISCHEIN'] or 0, row['FLUGSCHEIN'] or 0, row['BOOTSSCHEIN'] or 0, row['ANGELSCHEIN'] or 0, row['MOTORRADSCHEIN'] or 0)
					setElementData(thePlayer, "Clicked", 1)
				end
		end
	end
end	)

addCommandHandler("pruefen",
function(thePlayer, cmd, target, schein)
	if not(target) then outputChatBox("Benutze: /pruefen [Spieler] [Schein]", thePlayer, 200, 0, 0, false) return end
	if not(schein) then outputChatBox("Benutze: /pruefen [Spieler] [Schein]", thePlayer, 200, 0, 0, false) return end
	local target = getPlayerFromName(target)
	if not(target) then outputChatBox("Spieler nicht gefunden!", thePlayer, 200, 0, 0, false) return end
	local schein = tostring(schein)
	if(schein == "fuehrerschein") or (schein == "lkwschein") or (schein == "helischein") or (schein == "flugschein") or (schein == "bootsschein") or(schein == "angelschein") or(schein == "motorradschein") then else outputChatBox("Ungueltiger Schein!", thePlayer, 200, 0, 0, false) return end
	if (getElementData(thePlayer, "pruefling")) then outputChatBox("Du bist bereits in einer Pruefung!", thePlayer, 200, 0, 0, false) return end
	local x, y, z = getElementPosition(thePlayer)
	local x1, y1, z1 = getElementPosition(target)
	if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 15) then outputChatBox("Du bist zu weit von dem Spieler weg!", thePlayer, 200, 0, 0, false) return end
	setElementData(target, "fahrpruefung", true)
	setElementData(thePlayer, "fahrpruefung", true)
	setElementData(thePlayer, "pruefling", getPlayerName(target))
	setElementData(thePlayer, "schein", schein)
	outputChatBox("Du bist nun in einer Fahrpruefung mit "..getPlayerName(target)..".", thePlayer, 200, 100, 0)
	outputChatBox("Benutze /endpruefung 0, um den Pruefling nicht zu Bestehen, 1 Um die Pruefung zu bestehen.", thePlayer, 200, 100, 0)
	outputChatBox("Du bist nun in einer Fahrpruefung. Fahrlehrer: "..getPlayerName(thePlayer).." Schein: "..schein, target, 200, 100, 0)
end)

addCommandHandler("endpruefung",
function(thePlayer, cmd, var)
	if not(var) then outputChatBox("Benutze: /endpruefung [0/1] | 0 = Nicht bestanden, 1 = Bestanden", thePlayer, 200, 0, 0, false ) return end
	if not(getElementData(thePlayer, "pruefling")) then outputChatBox("Du bist in keiner Pruefung!", thePlayer, 200, 0, 0, false) return end
	local user = getPlayerFromName(getElementData(thePlayer, "pruefling"))
	if not(user) then outputChatBox("Kritischer Fehler, Spieler nicht Online!", thePlayer, 200, 0, 0, false) 
		setElementData(thePlayer, "fahrpruefung", false)
		setElementData(thePlayer, "pruefling", nil)
		setElementData(thePlayer, "schein", nil)
	return end
	local var = tonumber(var)
	if(var == 0) then
		setElementData(thePlayer, "fahrpruefung", false)
		setElementData(thePlayer, "pruefling", nil)
		setElementData(thePlayer, "schein", nil)
		setElementData(user, "fahrpruefung", false)
		outputChatBox("Die Pruefung wurde Beendet. Der Buerger ist Durchgefallen.", thePlayer, 0, 200, 0, false)
		outputChatBox("Die Pruefung wurde Beendet. Tut uns leid, du bist Durchgefallen.", user, 230, 0, 0, false)
	elseif(var == 1) then
		local schein = getElementData(thePlayer, "schein")
		setElementData(thePlayer, "fahrpruefung", false)
		setElementData(thePlayer, "pruefling", nil)
		setElementData(thePlayer, "schein", nil)
		setElementData(user, "fahrpruefung", false)
		outputChatBox("Die Pruefung wurde Beendet. Der Buerger hat Bestanden.", thePlayer, 0, 200, 0, false)	
		outputChatBox("Die Pruefung wurde Beendet. Herzlichen Glueckwunsch, du hast die Pruefung Bestanden.", user, 0, 230, 0, false)
		if(schein == "fuehrerschein") then
			setElementData(user, "pFSchein", 1)
		elseif(schein == "lkwschein") then
			setElementData(user, "pLKWSchein", 1)
		elseif(schein == "helischein") then
			setElementData(user, "pHELISchein", 1)
		elseif(schein == "flugschein") then
			setElementData(user, "pFLUGSchein", 1)
		elseif(schein == "bootsschein") then
			setElementData(user, "pBOOTSSchein", 1)
		elseif(schein == "angelschein") then
			setElementData(user, "pANGELSchein", 1)
		elseif(schein == "motorradschein") then
			setElementData(user, "pMOTORRADSchein", 1)
		end
	else return end
end)

addEventHandler("onMarkerHit", Marker4,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(getPedOccupiedVehicle(hitElement)) then return end
	if(canEnterFahrschule(hitElement) == false) then return end
	setInPosition(hitElement, 1393.9295654297, 425.08511352539, 19.973478317261, 0)
end)

addEventHandler("onMarkerHit", Marker3,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(getPedOccupiedVehicle(hitElement)) then return end
	if(canEnterFahrschule(hitElement) == false) then return end
	setInPosition(hitElement, 1390.1716308594, 406.57540893555, 28.755516052246, 0)
end)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(getPedOccupiedVehicle(hitElement)) then return end
	setInPosition(hitElement, -2027.1169433594, -105.62176513672, 1035.171875, 3)
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(getPedOccupiedVehicle(hitElement)) then return end
	setInPosition(hitElement, 1372.0050048828, 405.87298583984, 19.7578125, 0)
end)

function canEnterFahrschule(element)
	if(getPlayerFraktion(element) == 3) then return true; end
	if(getElementData(element, "fahrstunde") == true) then return true; end
	return false;
end

function change_price_func(var, text)
	if(var == 1) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET FSCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("Fuehrerscheinpreis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	elseif(var == 2) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET LKWSCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("LKW-Preis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	elseif(var == 3) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET HELISCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("Helipreis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	elseif(var == 4) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET FLUGSCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("Flugscheinpreis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	elseif(var == 5) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET BOOTSSCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("Bootsscheinpreis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	elseif(var == 6) then
		local result = mysql_query(handler,"UPDATE scheinpreise SET ANGELSCHEIN = '"..text.."'")
		if(result) then
		outputChatBox("Angelscheinpreis auf "..text.."$ geaendert!", source, 0, 200, 0, false)
		else
		outputChatBox("Fehler beim Setzen des Preises!", source, 200, 0, 0, false)
		end
	end

end

addEvent("onFahrschulPreisAender", true)
addEventHandler("onFahrschulPreisAender", getRootElement(), change_price_func)