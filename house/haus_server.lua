local index = 1
function createHaeuser ( )

		local query = "SELECT * FROM haus ;"
		local result = mysql_query( handler, query )
		
	if ( result ) then
	
		hsatz = mysql_fetch_assoc( result )
	while hsatz do

		local mieter = hsatz['MIETER']
		local x, y, z = hsatz['X'], hsatz['Y'], hsatz['Z']
		local intx, inty, intz = hsatz['INTX'], hsatz['INTY'], hsatz['INTZ']
		local int = hsatz['INT']
		local besitzer = hsatz['BESITZER']
		local preis = hsatz['PREIS']
		local id = hsatz['ID']
		if(besitzer ~= "staat") then
			createPickup ( x, y, z, 3, 1272, 1000 )
			_G["haus"..id] = createColSphere(x, y, z, 1)
		else
			createPickup ( x, y, z, 3, 1273, 1000 )
			_G["haus"..id] = createColSphere(x, y, z, 1)
		end
		
		local haus = _G["haus"..id]
		
		setElementData ( haus, "HBESITZER", besitzer )
		setElementData ( haus, "HMIETER", preis )
		setElementData ( haus, "HPREIS", preis)
		setElementData ( haus, "HINT", int )
		setElementData ( haus, "HINTX", intx )
		setElementData ( haus, "HINTY", inty )
		setElementData ( haus, "HINTZ", intz )
		setElementData ( haus, "HID", id )
		setElementData ( haus, "HAUS", true)
		addEventHandler ( "onColShapeHit", _G["haus"..id],
		function(player)
			local besitzer = getElementData ( source, "HBESITZER" )
			local mieter = getElementData ( source, "HMIETER" )
			local preis = getElementData ( source, "HPREIS" )
			local int = getElementData ( source, "HINT" )
			local intx = getElementData ( source, "HINTX" )
			local inty = getElementData ( source, "HINTY" )
			local intz = getElementData ( source, "HINTZ" )
			local id = getElementData ( source, "HID" )
			setElementData ( player, "lastHausVisit", source )
			outputChatBox("YAY")
		end)
		
		
		hsatz = mysql_fetch_assoc ( result )
		index = index + 1
		end
		
		mysql_free_result ( result )
		totalHaeuser = index - 1
		outputDebugString ( ( index - 1 ).." Haeuser erstellt!" )
	end
end
setTimer ( createHaeuser, 1000, 1 )

addEvent("onHausSystemCreateHaus", true)
addEventHandler("onHausSystemCreateHaus", getRootElement(),
function(x, y, z, int, intx, inty, intz, preis, typ)
outputChatBox(x..", "..y..", "..z..", "..int..", "..intx..", "..inty..", "..intz..", "..preis..", "..typ)
	local query = "INSERT INTO haus ( PREIS, X, Y, Z, INTERIOR, INTX, INTY, INTZ, TYP ) VALUES ( '"..preis.."', '"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..typ.."')"
	local result = mysql_query( handler, query )
	if(result) then	
		outputChatBox("Haus Erfolgreich erstellt!", source, 0, 200, 0, false)
	else
		outputChatBox("Fehler beim Erstellen des Hauses!", source, 0, 200, 0, false)
	end

end)