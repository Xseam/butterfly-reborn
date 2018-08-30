local id = 1
local prestige = {}
addEvent("onPrestigeErstell", true)
addEventHandler("onPrestigeErstell", getRootElement(),
function(name, preis, x, y, z)
	if not(name) then return end
	if not(preis) then return end
	if not(x) or not(y) or not(z) then return end
	if not(source) then return end

	local query = "INSERT INTO prestige ( NAME, PREIS, X, Y, Z, BESITZER ) VALUES ( '"..name.."', '"..preis.."', '"..x.."', '"..y.."', '"..z.."', '0')"
	local result = mysql_query( handler, query )
	if(result) then	
		outputChatBox("Prestige Erfolgreich erstellt! Beim Serverrestart wird es erscheinen.", source, 0, 200, 0, false)
	else
	outputChatBox("Fehler beim Erstellen der Prestiger!", source, 0, 200, 0, false)
	end
end)

function createPrestiges ( i )

		local query = "SELECT * FROM prestige WHERE ID = \'"..i.."\';"
		local result = mysql_query( handler, query )
		
	if ( result and mysql_num_rows( result ) > 0 ) then
		local query2 = "SELECT * FROM prestige WHERE ID = \'"..i.."\';"
		local result2 = mysql_query( handler, query2 )
		local row = mysql_fetch_assoc(result2)
		local x, y, z = row['X'], row['Y'], row['Z']
		local besitzer = row['BESITZER']
		local preis = row['PREIS']
		local id = row['ID']
		createPickup ( x, y, z, 3, 1239, 1000 )
		prestige["prestige"..id] = createColSphere ( x, y, z, 2 )

		--createBlip( x, y, z, 32, 2, 255, 0, 0, 255, 0, 300)
		addEventHandler ( "onColShapeHit", prestige["prestige"..id],
		function(player)
			if(getElementType(player) ~= "player") then return end
			local besitzer = getElementData ( source, "PBESITZER" )
			local preis = getElementData ( source, "PPREIS" )
			setElementData ( player, "lastPrestigeVisit", source )
		end)
		
		local pickup = prestige["prestige"..id]
		
		setElementData ( pickup, "PBESITZER", besitzer )
		setElementData ( pickup, "PPREIS", preis )
		setElementData ( pickup, "PID", id )
		setElementData ( pickup, "PRESTIGE", true)
		
		i = i + 1
		createPrestiges( i )
	else
		totalPrestigeObjects = i - 1
		outputDebugString ( ( i - 1 ).." prestige Objekte Erstellt!" )
	end
end
setTimer ( createPrestiges, 1000, 1, 1 )

function buyprestige_func ( player )

	local pickup = getElementData ( player, "lastPrestigeVisit" )
	if pickup then
		local pname = getPlayerName ( player )
		if getElementData ( pickup, "PBESITZER" ) == "" or getElementData ( pickup, "PBESITZER" ) == "0" then else outputChatBox("Dieses Prestige steht nicht zum Verkauf!", player, 230, 0, 0, false) return end
				local isOwning = false
				for i = 1, totalPrestigeObjects do
					if getElementData ( prestige["prestige"..i], "PBESITZER" ) == pname then
						isOwning = true
						break
					end
				end
				if(isOwning == true) then outputChatBox("Du hast bereits ein Prestige! Verkauf das Alte erst!", player, 230, 0, 0, false) return end
				local preis = tonumber(getElementData(pickup, "PPREIS"))
				local geld = tonumber(getElementData(player, "pHGeld"))
				local id = getElementData(pickup, "PID")
				if(geld < preis+1) then outputChatBox("Du hast nicht Genug geld fuer dieses Prestige!", player, 230, 0, 0, false) return end
				local result = mysql_query(handler,"UPDATE prestige SET BESITZER = '"..pname.."' WHERE ID = '"..id.."'")
				if(result) then
					outputChatBox("Glueckwunsch, du hast dir das Prestige Gekauft!", player, 0, 230, 0, false)
					setElementData(player, "pHGeld", geld-preis)
					setElementData( pickup, "PBESITZER", pname )
				else
					outputChatBox("Fehler beim Kaufen des Objektes!", player, 230, 0, 0, false)
				end
		end
end
addCommandHandler ( "buyprestige", buyprestige_func )

function sellprestige_func ( player )
		local query = "SELECT * FROM prestige WHERE BESITZER = \'"..getPlayerName(player).."\';"
		local result = mysql_query( handler, query )
		if not(result and mysql_num_rows( result ) > 0) then outputChatBox("Dir gehoert kein Preistige!", player, 245, 0, 0, false) return end
			local row = mysql_fetch_assoc(result)
			local preis = row['PREIS']
			local result2 = mysql_query(handler,"UPDATE prestige SET BESITZER = '0' WHERE BESITZER = '"..getPlayerName(player).."'")
			if(result2) then
				for i = 1, totalPrestigeObjects do
					if getElementData ( prestige["prestige"..i], "PBESITZER" ) == getPlayerName ( player ) then
						setElementData ( prestige["prestige"..i], "PBESITZER", "0" )
					end
				end
				setElementData(player, "pHGeld", tonumber(getElementData(player, "pHGeld"))+preis)
				outputChatBox("Du hast das Prestige verkauft, und erhaelst "..preis.."$!", player, 0, 230, 0, false)
			else
				outputChatBox("Fehler beim Verkaufen des Prestige-Objektes!", player, 250, 0, 0, false)
				
			end

end
addCommandHandler ( "sellprestige", sellprestige_func )