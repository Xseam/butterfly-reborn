local drugObs = {}

drugObs[1] = createObject(944, 1103.3299560547, -294.63000488281, 73.870002746582, 0, 0, 280)
setElementData(drugObs[1], "DROGENC", 6) -- Red Brothers
drugObs[2] = createObject(944, -50.25, -228.83000183105, 5.3099999427795, 0, 0, 350)
setElementData(drugObs[2], "DROGENC", 1)-- Yakuza


function click_check_droge( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
		if (isDrugOb(source) == true) and (isDrugObFraktion(thePlayer, source) == true) then
				local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
				triggerClientEvent(thePlayer, "onFraktionsDrugsGuiStart", thePlayer)
			end
		end
end
		
addEventHandler( "onElementClicked", getRootElement(), click_check_droge ) 

function isDrugObFraktion(thePlayer, element)
	if(tonumber(getElementData(element, "DROGENC")) == getPlayerFraktion(thePlayer)) then return true;
	else return false; end
end

function isDrugOb(element)
	if(getElementData(element, "DROGENC")) then return true;
	else return false; end
end

addEvent("onDrugDataFrakNeed", true)
addEventHandler("onDrugDataFrakNeed", getRootElement(),
function(fraktion)
	if(fraktion == 1) or (fraktion == 6) then
		local result = mysql_query( handler, "SELECT * FROM drugs;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			if(fraktion == 1) then
				local misc = row['YAKUZA']
				if(misc == nil) then
					local query = "INSERT INTO drugs ( YAKUZA, REDBROTHERS ) VALUES ( '|0|0|', '|0|0|' )"
					local result = mysql_query( handler, query )
					local row2 = mysql_fetch_assoc(result2)
					misc = row['YAKUZA']
					local drugs, mats = gettok(misc, 1, "|"), gettok(misc, 2, "|")
					triggerClientEvent(source, "onDrugDataFrakNeedBack", source, drugs, mats)
				else
					local drugs, mats = gettok(misc, 1, "|"), gettok(misc, 2, "|")
					triggerClientEvent(source, "onDrugDataFrakNeedBack", source, drugs, mats)
				end
			elseif(fraktion == 6) then
			
			local misc = row['REDBROTHERS']
				if(misc == nil) then
					local query = "INSERT INTO drugs ( YAKUZA, REDBROTHERS ) VALUES ( '|0|0|', '|0|0|' )"
					local result = mysql_query( handler, query )
					local row2 = mysql_fetch_assoc(result2)
					misc = row['REDBROTHERS']
					local drugs, mats = gettok(misc, 1, "|"), gettok(misc, 2, "|")
					triggerClientEvent(source, "onDrugDataFrakNeedBack", source, drugs, mats)
				else
					local drugs, mats = gettok(misc, 1, "|"), gettok(misc, 2, "|")
					triggerClientEvent(source, "onDrugDataFrakNeedBack", source, drugs, mats)
				end
			end
		else
			local query = "INSERT INTO drugs ( YAKUZA, REDBROTHERS ) VALUES ( '|0|0|', '|0|0|' )"
			local result = mysql_query( handler, query )
			outputChatBox("Bitte Oeffne das Lager noch einmal.", source, 0, 200, 0, false)
		end
		
	else
		outputServerLog(getPlayerName(source).." versuchte, Lager von anderen Fraktionen zu oeffnen.")
	end
end
)

addEvent("onDrugDataAuszahl", true)
addEventHandler("onDrugDataAuszahl", getRootElement(),
function(text, typ)
	if(typ == "Drogen") then
		local frak = getPlayerFraktion(source)
		local result1 = mysql_query( handler, "SELECT * FROM drugs;" )
		local row = mysql_fetch_assoc(result1)
		if(frak == 1) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['YAKUZA'], 1, "|")), tonumber(gettok(row['YAKUZA'], 2, "|"))
			if(vorhanden1 < text) then outputChatBox("Soviele Drogen sind nicht im Lager!", source, 200, 0, 0, false) return end
			local new = "|"..vorhanden1-text.."|"..vorhanden2.."|"
			local query = mysql_query( handler, "UPDATE drugs SET YAKUZA = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen+text.."|"..mats)
			outputChatBox("Du hast erfolgreich "..text.." Drogen entnommen!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		elseif(frak == 6) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['REDBROTHERS'], 1, "|")), tonumber(gettok(row['REDBROTHERS'], 2, "|"))
			if(vorhanden1 < text) then outputChatBox("Soviele Drogen sind nicht im Lager!", source, 200, 0, 0, false) return end
			local new = "|"..vorhanden1-text.."|"..vorhanden2.."|"
			local query = mysql_query( handler, "UPDATE drugs SET REDBROTHERS = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen+text.."|"..mats)
			outputChatBox("Du hast erfolgreich "..text.." Drogen entnommen!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		end	
	elseif(typ == "Mats") then
		local frak = getPlayerFraktion(source)
		local result1 = mysql_query( handler, "SELECT * FROM drugs;" )
		local row = mysql_fetch_assoc(result1)
		if(frak == 1) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['YAKUZA'], 1, "|")), tonumber(gettok(row['YAKUZA'], 2, "|"))
			if(vorhanden2 < text) then outputChatBox("Soviele Materialien sind nicht im Lager!", source, 200, 0, 0, false) return end
			local new = "|"..vorhanden1.."|"..vorhanden2-text.."|"
			local query = mysql_query( handler, "UPDATE drugs SET YAKUZA = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen.."|"..mats+text)
			outputChatBox("Du hast erfolgreich "..text.." Materialien entnommen!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		elseif(frak == 6) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['REDBROTHERS'], 1, "|")), tonumber(gettok(row['REDBROTHERS'], 2, "|"))
			if(vorhanden2 < text) then outputChatBox("Soviele Materialien sind nicht im Lager!", source, 200, 0, 0, false) return end
			local new = "|"..vorhanden1.."|"..vorhanden2-text.."|"
			local query = mysql_query( handler, "UPDATE drugs SET REDBROTHERS = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen.."|"..mats+text)
			outputChatBox("Du hast erfolgreich "..text.." Materialien entnommen!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		end	
	end
end)

addEvent("onDrugDataEinzahl", true)
addEventHandler("onDrugDataEinzahl", getRootElement(),
function(text, typ)
	if(typ == "Drogen") then
		local frak = getPlayerFraktion(source)
		local result1 = mysql_query( handler, "SELECT * FROM drugs;" )
		local row = mysql_fetch_assoc(result1)
		
		if(frak == 1) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['YAKUZA'], 1, "|")), tonumber(gettok(row['YAKUZA'], 2, "|"))
			local new = "|"..vorhanden1+text.."|"..vorhanden2.."|"
			local query = mysql_query( handler, "UPDATE drugs SET YAKUZA = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen-text.."|"..mats)
			outputChatBox("Du hast erfolgreich "..text.." Drogen eingelagert!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		elseif(frak == 6) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['REDBROTHERS'], 1, "|")), tonumber(gettok(row['REDBROTHERS'], 2, "|"))
			local new = "|"..vorhanden1+text.."|"..vorhanden2.."|"
			local query = mysql_query( handler, "UPDATE drugs SET REDBROTHERS = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen-text.."|"..mats)
			outputChatBox("Du hast erfolgreich "..text.." Drogen eingelagert!", source, 0, 200, 0)		
			triggerEvent("onDrugDataFrakNeed", source, frak)
		end
	elseif(typ == "Mats") then
		local frak = getPlayerFraktion(source)
		local result1 = mysql_query( handler, "SELECT * FROM drugs;" )
		local row = mysql_fetch_assoc(result1)
		if(frak == 1) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['YAKUZA'], 1, "|")), tonumber(gettok(row['YAKUZA'], 2, "|"))
			local new = "|"..vorhanden1.."|"..vorhanden2+text.."|"
			local query = mysql_query( handler, "UPDATE drugs SET YAKUZA = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen.."|"..mats-text)
			outputChatBox("Du hast erfolgreich "..text.." Materialien eingelagert!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		elseif(frak == 6) then
			local vorhanden1, vorhanden2 = tonumber(gettok(row['REDBROTHERS'], 1, "|")), tonumber(gettok(row['REDBROTHERS'], 2, "|"))
			local new = "|"..vorhanden1.."|"..vorhanden2+text.."|"
			local query = mysql_query( handler, "UPDATE drugs SET REDBROTHERS = '"..new.."'")
				local misc = getElementData(source, "pMISC")
				local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
				setElementData(source, "pMISC", "|"..drogen.."|"..mats-text)
			outputChatBox("Du hast erfolgreich "..text.." Materialien eingelagert!", source, 0, 200, 0)
			triggerEvent("onDrugDataFrakNeed", source, frak)
		end
	end
end)