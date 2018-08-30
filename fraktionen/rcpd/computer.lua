
addEvent("onPoliceComputerSTVOLoesche", true)
addEventHandler("onPoliceComputerSTVOLoesche", getRootElement(),
function(spieler, anzahl, grund)
	if not(spieler) then return end
	if not(anzahl) then return end
	if not(grund) then return end
	local stvos = tonumber(getElementData(spieler, "pSTVO"))
	if(stvos-anzahl < 1) then 
		outputChatBox("Officer "..getPlayerName(source).." hat deine STVO-Punkte geloescht.", spieler, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, spieler, 0, 210, 50, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s STVO-Punkte gecleart.", source, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, source, 0, 210, 50, false)
		setElementData(spieler, "pSTVO", 0)
	else
		outputChatBox("Officer "..getPlayerName(source).." hat deine STVO-Punkte auf "..(stvos-anzahl).." gesetzt!", spieler, 255, 200, 0, false)
		outputChatBox("Grund: "..grund, spieler, 255, 200, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s STVO-Punkte auf "..(stvos-anzahl).." gesetzt!", source, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, source, 0, 210, 50, false)
		setElementData(spieler, "pSTVO", tonumber(stvos-anzahl))	
	end
end)

addEvent("onPoliceComputerSTVOGebe", true)
addEventHandler("onPoliceComputerSTVOGebe", getRootElement(),
function(spieler, anzahl, grund)
	if not(spieler) then return end
	if not(anzahl) then return end
	if not(grund) then return end
	local stvos = tonumber(getElementData(spieler, "pSTVO"))
	if(stvos+anzahl > 19) then 
		outputChatBox("Officer "..getPlayerName(source).." hat deine STVO-Punkte auf 20 gesetzt!", spieler, 255, 255, 0, false)
		outputChatBox("Grund: "..grund, spieler, 255, 255, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s STVOS auf 20 gesetzt!", source, 0, 200, 0, false)
		outputChatBox("Grund: "..grund, source, 0, 200, 0, false)
		setElementData(spieler, "pSTVO", 20)
	else
		outputChatBox("Officer "..getPlayerName(source).." hat deine STVO-Punkte auf "..(stvos+anzahl).." gesetzt!", spieler, 255, 255, 0, false)
		outputChatBox("Grund: "..grund, spieler, 255, 255, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s STVO's auf "..(stvos+anzahl).." gesetzt!", source, 0, 200, 0, false)
		outputChatBox("Grund: "..grund, source, 0, 200, 0, false)
		setElementData(spieler, "pSTVO", tonumber(stvos+anzahl))	
	end
end)


addEvent("onPoliceComputerWantedsGebe", true)
addEventHandler("onPoliceComputerWantedsGebe", getRootElement(),
function(spieler, anzahl, grund)
	if not(spieler) then return end
	if not(anzahl) then return end
	if not(grund) then return end
	local wanteds = tonumber(getElementData(spieler, "pWanteds"))
	if(wanteds+anzahl > 5) then 
		outputChatBox("Officer "..getPlayerName(source).." hat dein Wantedlevel auf 6 gesetzt!", spieler, 255, 0, 0, false)
		outputChatBox("Grund: "..grund, spieler, 255, 0, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s Wanteds auf 6 gesetzt!", source, 0, 200, 0, false)
		outputChatBox("Grund: "..grund, source, 0, 200, 0, false)
		setElementData(spieler, "pWanteds", 6)
	else
		outputChatBox("Officer "..getPlayerName(source).." hat dein Wantedlevel auf "..(wanteds+anzahl).." gesetzt!", spieler, 255, 0, 0, false)
		outputChatBox("Grund: "..grund, spieler, 255, 0, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s Wanteds auf "..(wanteds+anzahl).." gesetzt!", source, 0, 200, 0, false)
		outputChatBox("Grund: "..grund, source, 0, 200, 0, false)
		setElementData(spieler, "pWanteds", tonumber(wanteds+anzahl))	
	end
end)

addEvent("onPoliceComputerWantedsLoesche", true)
addEventHandler("onPoliceComputerWantedsLoesche", getRootElement(),
function(spieler, anzahl, grund)
	if not(spieler) then return end
	if not(anzahl) then return end
	if not(grund) then return end
	local wanteds = tonumber(getElementData(spieler, "pWanteds"))
	if(wanteds-anzahl < 1) then 
		outputChatBox("Officer "..getPlayerName(source).." hat dein Wantedlevel gecleart.", spieler, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, spieler, 0, 210, 50, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s Wanteds gecleart.", source, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, source, 0, 210, 50, false)
		setElementData(spieler, "pWanteds", 0)
	else
		outputChatBox("Officer "..getPlayerName(source).." hat dein Wantedlevel auf "..(wanteds-anzahl).." gesetzt!", spieler, 50, 200, 0, false)
		outputChatBox("Grund: "..grund, spieler, 50, 200, 0, false)
		outputChatBox("Du hast "..getPlayerName(spieler).."'s Wanteds auf "..(wanteds-anzahl).." gesetzt!", source, 0, 210, 50, false)
		outputChatBox("Grund: "..grund, source, 0, 210, 50, false)
		setElementData(spieler, "pWanteds", tonumber(wanteds-anzahl))	
	end
end)

addEvent("onDatenbankDataWrite", true)
addEventHandler("onDatenbankDataWrite", getRootElement(),
function(spieler, text)
if not (spieler) then return end
	local name = getPlayerName(spieler)
	local result = mysql_query( handler, "SELECT * FROM datenbank WHERE SPIELER = \'"..name.."\';" )
	if ( result and mysql_num_rows( result ) > 0) then
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		local datum = day.."."..month.."."..year.." um "..hour..":"..minute
		local text = text.."\n\nZuletzt bearbeitet von: "..getPlayerName(source).." am "..datum
		mysql_query(handler,"UPDATE datenbank SET TEXT = '"..text.."' WHERE SPIELER = '"..name.."'")
		outputChatBox("Spieler erfolgreich Bearbeitet!", source, 0, 200, 0, false)
	else
		outputChatBox("Fehler beim Schreiben! Datenbank des Spielers exestiert nicht!", source, 255, 0, 0, false)
	end
	mysql_free_result(result)
end)

addEvent("onDatenbankDataNeed", true)
addEventHandler("onDatenbankDataNeed", getRootElement(),
function(spieler)
if not (spieler) then return end
	local name = getPlayerName(spieler)
	local result = mysql_query( handler, "SELECT * FROM datenbank WHERE SPIELER = \'"..name.."\';" )
	if ( result and mysql_num_rows( result ) > 0) then
	else
		local query = "INSERT INTO datenbank ( SPIELER, TEXT ) VALUES ( '"..name.."', '--')"
		local result = mysql_query( handler, query )	
		local result2 = mysql_query( handler, "SELECT * FROM datenbank WHERE SPIELER = \'"..name.."\';" )
		local row = mysql_fetch_assoc(result2)
		triggerClientEvent(source,"onDatenbankDataNeedBack", source, row['TEXT'])
		return
	end
		local row = mysql_fetch_assoc(result)
		triggerClientEvent(source,"onDatenbankDataNeedBack", source, row['TEXT'])
		mysql_free_result(result)
end)