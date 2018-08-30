
function createFirmen( )
		local query = "SELECT * FROM firmen;"
		local result = mysql_query( handler, query )
		local hsatz
		local firmen = 0
	if ( result ) then
		hsatz = mysql_fetch_assoc( result )
		while hsatz do
			local id = hsatz['ID']
			local name = hsatz['NAME']
			local besitzer = hsatz['BESITZER']
			local angestellte = hsatz['ANGESTELLTE']
			local beschreibung = hsatz['BESCHREIBUNG']
			local lohn = hsatz['LOHN']
			local x, y, z = hsatz['X'], hsatz['Y'], hsatz['Z']
			local pickup
			local col
			
			pickup = createPickup(x, y, z, 3, 1277, 1000)
			col = createColSphere(x, y, z, 2)
			
			setElementData(col, "FIRMA", true)
			setElementData(col, "FNAME", name)
			setElementData(col, "FID", id)
			setElementData(col, "FBESITZER", besitzer)
			setElementData(col, "FANGESTELLTE", angestellte)
			setElementData(col, "FBESCHREIBUNG", beschreibung)
			setElementData(col, "FLOHN", lohn)
			
			hsatz = mysql_fetch_assoc( result )
			firmen = firmen+1
		end
		
		outputDebugString(firmen.." Firmen wurden erstellt.")
	end

end
setTimer(createFirmen, 1000, 1)

addEvent("onFirmenSettingsChange", true)
addEventHandler("onFirmenSettingsChange", getRootElement(),
function(col, name, beschreibung, lohn)
	local fname = getElementData(col, "FNAME")
	local besitzer = getElementData(col, "FBESITZER")
	
	mysql_query(handler,"UPDATE firmen SET BESCHREIBUNG = '"..beschreibung.."' WHERE NAME = '"..fname.."' AND BESITZER = '"..besitzer.."'")
	mysql_query(handler,"UPDATE firmen SET LOHN = '"..lohn.."' WHERE NAME = '"..fname.."' AND BESITZER = '"..besitzer.."'")
	local shit = mysql_query(handler,"UPDATE firmen SET NAME = '"..name.."' WHERE NAME = '"..fname.."' AND BESITZER = '"..besitzer.."'")
	if(shit) then
		setElementData(col, "FNAME", name)
		setElementData(col, "FBESCHREIBUNG", beschreibung)
		setElementData(col, "FLOHN", lohn)
		outputChatBox("Firmeninfos gespeichert.", source, 0, 200, 0, false)
	else
		outputChatBox("Es gab einen fehler bei der Speicherung der Firmeninformationen. Spreche einen Admin an.", source, 200, 0, 0, false)
	end
end)

addEvent("onPlayerFirmaErstell", true)
addEventHandler("onPlayerFirmaErstell", getRootElement(),
function(name, beschreibung, x, y, z)
	if not(name) or not(beschreibung) or not(x) or not(y) or not(z) then return end
	local query = "INSERT INTO firmen ( NAME, BESITZER, ANGESTELLTE, BESCHREIBUNG, LOHN, X, Y, Z ) VALUES ( '"..name.."', '"..getPlayerName(source).."', '|-|-|-|-|-|', '"..beschreibung.."', '25', '"..x.."', '"..y.."', '"..z.."')"
	local result = mysql_query( handler, query )
	outputChatBox(name..", "..beschreibung..", "..x..", "..y..", "..z, source, 0, 200, 0)
	if(result) then	
		outputChatBox("Deine Firmenanfrage wurde erfolgreich eingereicht!", source, 0, 200, 0, false)
		outputChatBox("Es kann einige Tage Dauern, bis deine Firma erstellt wird.", source, 0, 200, 0, false)
		local pickup = createPickup(x, y, z, 3, 1273, 1000)
		addEventHandler("onPickupUse", pickup, function(hitElement) outputChatBox("Hier entsteht eine neue Firma.", hitElement, 0, 255, 0, false) end)
		setElementData(source, "pBGeld", tonumber(getElementData(source, "pBGeld"))-Firmenpreis)
	else
		outputChatBox("Fehler beim Einreichen der Firma!", source, 0, 200, 0, false)
	end
end)