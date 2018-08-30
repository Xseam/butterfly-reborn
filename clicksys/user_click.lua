function user_click_func( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if (getElementType(source) == "player") then
			if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
			local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
			if(source == thePlayer) then return end
			if(tonumber(getElementData(source, "tazered")) == 1) and (isPedInVehicle(thePlayer)) and (getPlayerFraktion(thePlayer) == 4) then
			local validSeats = {}
			local veh = getPedOccupiedVehicle(thePlayer)
			for i = 2, 3 do
				if not getVehicleOccupant ( veh, i ) then
				validSeats[i] = true
			end
			for key, index in pairs ( validSeats ) do
				warpPedIntoVehicle ( source, veh, key )
				return
			end
			outputChatBox("Du hast kein Freien Sitz mehr!", thePlayer, 200, 0, 0, false)
				
			end
			return end
			triggerClientEvent(thePlayer, "onPlayerClicksys", thePlayer, source)
			setElementData(thePlayer, "Clicked", 1)
		end
	end
end	
addEvent("onFraktionsClickAction", true)
addEventHandler("onFraktionsClickAction", getRootElement(),
function(player, var)
	if not(player) then return end
	if(var == 1) then
		outputChatBox("Du hast "..getPlayerName(player).." seinen Fuehrerschein abgenommen.", source, 0, 200, 0, false)
		outputChatBox("Officer "..getPlayerName(source).." hat dir deinen Fuehrerschein abgenommen!", player, 200, 0, 0, false)
		setElementData(player, "pFSchein", 0)
	elseif(var == 2) then
		outputChatBox("Du hast "..getPlayerName(player).." seinen Angelschein abgenommen.", source, 0, 200, 0, false)
		outputChatBox("Officer "..getPlayerName(source).." hat dir deinen Angelschein abgenommen!", player, 200, 0, 0, false)
		setElementData(player, "pANGELSchein", 0)
	elseif(var == 3) then
		local misc = getElementData(player, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		outputChatBox("Du hast "..getPlayerName(player).." Durchsucht.", source, 0, 200, 0, false)
		outputChatBox("Drogen: "..drogen.."g | Mats: "..mats, source, 0, 200, 200)
		outputChatBox("Officer "..getPlayerName(source).." hat dich Durchsucht.", player, 200, 200, 0, false)
	elseif(var == 4) then
		outputChatBox("Du hast "..getPlayerName(player).."'s Illegale Gegenstaende abgenommen.", source, 0, 200, 0, false)
		outputChatBox("Officer "..getPlayerName(source).." hat dir deine Illegalen Gegenstaende abgenommen!", player, 200, 200, 0, false)
		setElementData(player, "pMISC", "|0|0|")
	elseif(var == 5) then
		outputChatBox("Du hast "..getPlayerName(player).."'s Waffen abgenommen.", source, 0, 200, 0, false)
		outputChatBox("Officer "..getPlayerName(source).." hat dir deine Waffen abgenommen!", player, 200, 200, 0, false)
		takeAllWeapons(player)
	end
end)

addEventHandler( "onElementClicked", getRootElement(), user_click_func ) 
addEvent("onSpeicalActionPlayer_func_geben", true)
addEventHandler("onSpeicalActionPlayer_func_geben", getRootElement(), 
function(var, player, text)
	if not(var) then return end
	if not(player) then return end
	if not(text) then return end
	if(var == 1) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." einige Banknoten...", nearbyPlayer, 148, 222, 0 )
		end
		local data = tonumber(getElementData(source, "pHGeld"))
		setElementData(source, "pHGeld", data-text)
		local data2 = tonumber(getElementData(player, "pHGeld"))
		setElementData(player, "pHGeld", data2+text)
		outputChatBox("Du hast "..getPlayerName(player).." "..text.."$ gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.."$ ueberreicht.", player, 0, 230, 220, false)
	elseif(var == 2) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." einige Zigaretten...", nearbyPlayer, 148, 222, 0 )
		end
		local data = tonumber(getElementData(source, "pZigaretten"))
		setElementData(source, "pZigaretten", data-text)
		local data2 = tonumber(getElementData(player, "pZigaretten"))
		setElementData(player, "pZigaretten", data2+text)
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Zigaretten gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Zigaretten ueberreicht.", player, 0, 230, 220, false)
	elseif(var == 3) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." einige Biere...", nearbyPlayer, 148, 222, 0 )
		end
		local data = tonumber(getElementData(source, "pBiere"))
		setElementData(source, "pBiere", data-text)
		local data2 = tonumber(getElementData(player, "pBiere"))
		setElementData(player, "pBiere", data2+text)
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Bier(e) gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Bier(e) ueberreicht.", player, 0, 230, 220, false)
	elseif(var == 4) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." einige Pflaenzchen...", nearbyPlayer, 200, 222, 0 )
		end
		local misc = getElementData(source, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		local misc2 = getElementData(player, "pMISC")
		local drogen2, mats2 = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		setElementData(source, "pMISC", "|"..drogen-text.."|"..mats.."|")
		setElementData(player, "pMISC", "|"..drogen2+text.."|"..mats2.."|")
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Drogen gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Drogen ueberreicht.", player, 0, 230, 220, false)		
	elseif(var == 5) then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." einige Eisenteile...", nearbyPlayer, 200, 222, 0 )
		end
		local misc = getElementData(source, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		local misc2 = getElementData(player, "pMISC")
		local drogen2, mats2 = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		setElementData(source, "pMISC", "|"..drogen.."|"..mats-text.."|")
		setElementData(player, "pMISC", "|"..drogen2.."|"..mats2+text.."|")
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Materialien gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Materialien ueberreicht.", player, 0, 230, 220, false)
	elseif(var == "Kanister") then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." Benzinkanister...", nearbyPlayer, 148, 222, 0 )
		end
		local item = "pKanister"
		local data = tonumber(getElementData(source, item))
		setElementData(source, item, data-text)
		local data2 = tonumber(getElementData(player, item))
		setElementData(player, item, data2+text)
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Benzinkanister gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Benzinkanister ueberreicht.", player, 0, 230, 220, false)	
	elseif(var == "Erstehilfe") then
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." gibt "..getPlayerName(player).." ein(ige) Erste-Hilfe Koffer...", nearbyPlayer, 148, 222, 0 )
		end
		local item = "pErstehilfe"
		local data = tonumber(getElementData(source, item))
		setElementData(source, item, data-text)
		local data2 = tonumber(getElementData(player, item))
		setElementData(player, item, data2+text)
		outputChatBox("Du hast "..getPlayerName(player).." "..text.." Erste-Hilfe Koffer gegeben!", source, 0, 230, 0, false)
		outputChatBox(getPlayerName(source).." hat dir "..text.." Erste-Hilfe Koffer ueberreicht.", player, 0, 230, 220, false)			
	end

end
)

addEvent("onSpeicalActionPlayer_func", true)
addEventHandler("onSpeicalActionPlayer_func", getRootElement(), 
function(var, player)
	if not(var) then return end
	if not(player) then return end
	if(var == 1) then -- Handgeld
		local Geld = tonumber(getElementData(source, "pHGeld"))
		outputChatBox("Du hast "..getPlayerName(player).." dein Geld gezeigt.", source, 0, 200, 255, false)
		outputChatBox(getPlayerName(source).." zeigt dir sein Geld: "..Geld.."$ auf der Hand.", player, 0, 200, 255, false)
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." zeigt "..getPlayerName(player).." sein Geld.", nearbyPlayer, 148, 222, 0 )
		end
	elseif(var == 2) then -- Scheine
			local fsschein = tonumber(getElementData(source, "pFSchein"))
			local lkwschein = tonumber(getElementData(source, "pLKWSchein"))
			local helischein = tonumber(getElementData(source, "pHELISchein"))
			local flugschein = tonumber(getElementData(source, "pFLUGSchein"))
			local bootsschein = tonumber(getElementData(source, "pBOOTSSchein"))
			local angelschein = tonumber(getElementData(source, "pANGELSchein"))
			local motorradschein = tonumber(getElementData(source, "pMOTORRADSchein"))
			if(fsschein == 1) then fsschein = "Vorhanden" else fsschein = "Nicht Vorhand." end
			if(lkwschein == 1) then lkwschein = "Vorhanden" else lkwschein = "Nicht Vorhand." end
			if(helischein == 1) then helischein = "Vorhanden" else helischein = "Nicht Vorhand." end
			if(flugschein == 1) then flugschein = "Vorhanden" else flugschein = "Nicht Vorhand." end
			if(bootsschein == 1) then bootsschein = "Vorhanden" else bootschein = "Nicht Vorhand." end
			if(angelschein == 1) then angelschein = "Vorhanden" else angelschein = "Nicht Vorhand." end
			if(motorradschein == 1) then motorradschein = "Vorhanden" else mottoradschein = "Nicht Vorhand." end
		outputChatBox("Du hast "..getPlayerName(player).." deine scheine gezeigt.", source, 0, 200, 255, false)
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." zeigt "..getPlayerName(player).." seine Scheine.", nearbyPlayer, 148, 222, 0 )
		end
		outputChatBox("Scheine von "..getPlayerName(source)..":", player, 0, 255, 100, false)
		outputChatBox("______________________________", player, 0, 255, 100, false)
		outputChatBox("Fuehrerschein: "..fsschein, player, 0, 255, 120, false)
		outputChatBox("Helikopterschein: "..helischein, player, 0, 255, 120, false)
		outputChatBox("Flugzeugschein: "..flugschein, player, 0, 255, 120, false)
		outputChatBox("Bootsschein: "..bootsschein, player, 0, 255, 120, false)
		outputChatBox("Angelschein: "..angelschein, player, 0, 255, 120, false)
		outputChatBox("Motorradschein: "..motorradschein, player, 0, 255, 120, false)
		outputChatBox("______________________________", player, 0, 255, 100, false)
	elseif(var == 3) then -- Presseausweis
		local rang = tonumber(getElementData(source, "pFraktionsrang"))
		outputChatBox("Du hast "..getPlayerName(player).." dein Presseausweis gezeigt.", source, 0, 200, 255, false)
		outputChatBox(getPlayerName(source).." zeigt dir sein Presseausweis: 'RCNR' Rank "..rang, player, 0, 200, 255, false)
		local posX, posY, posZ = getElementPosition( source )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			local name = getPlayerName ( source )
			outputChatBox ( "*"..name.." zeigt "..getPlayerName(player).." sein Presseausweis.", nearbyPlayer, 148, 222, 0 )
		end
	end
end
)
