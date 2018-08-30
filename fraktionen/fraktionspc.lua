fraktionNamen = {
	[0] = "Zivilist",
	[1] = "Yakuza",
	[2] = "Terroristen",
	[3] = "Fahrschule",
	[4] = "RCPD",
	[5] = "RCNR",
	[6] = "Red Brothers",
	[7] = "FBI",
}

waffenTeile = {}

fpcs = {}
fpcsvar = {}

local pcobject1 = createObject(2612, -60, -233.89999389648, 6.3000001907349, 0 ,0, 180) -- zu Yakuza

fpcs[1] = createObject(2942, -60.299999237061, -233.39999389648, 5.0999999046326, 0, 0, 140)
setElementData(fpcs[1], "FRAKTIONSPC", 1) -- Fraktion Yakuza
fpcs[2] = createObject(2942, -799.82275390625, -821.78704833984, 148.6828125, 0, 0, 270)
setElementData(fpcs[2], "FRAKTIONSPC", 2) -- Fraktion Terror
fpcs[3] = createObject(2942, -2031.1102294922, -119.39597320557, 1034.771875, 0, 0, 180)
setElementData(fpcs[3], "FRAKTIONSPC", 3) -- Fraktion Fahrschule
setElementInterior(fpcs[3], 3)
fpcs[4] = createObject(2942, 606.79998779297,-561.40002441406, 17.799999237061, 0, 0, 270)
setElementData(fpcs[4], "FRAKTIONSPC", 4) -- Fraktion RCPD
fpcs[5] = createObject(2942, 373.92828369141, 198.07586669922, 1013.9796875, 0, 0, -90)
setElementData(fpcs[5], "FRAKTIONSPC", 5) -- Fraktion RCNR
setElementInterior(fpcs[5], 3)
fpcs[6] = createObject(2942, 1104.2700195313, -296.92999267578, 73.629997253418, 0, 0, 270)
setElementData(fpcs[6], "FRAKTIONSPC", 6) -- Fraktion RB
fpcs[7] = createObject(2942, 2530.2299804688, -1292.6199951172, 1047.9300537109, 0, 0, 270)
setElementData(fpcs[7], "FRAKTIONSPC", 7) -- Fraktion FBI
setElementInterior(fpcs[7], 2)

local yakuzaSkins = { 120, 121, 122, 123, 169, 57 }
local terrorSkins = { 14, 221, 222, 229, 262, 263 }
local fahrschulSkins = { 226, 250, 185, 98, 17, 170 }
local rcpdSkins = { 280, 281, 282, 283, 284, 288 }
local rcnrSkins = { 59, 57, 141, 185, 187, 188, 189, 223, 296 }
local rbSkins = { 111, 112, 113, 124, 125, 126, 127, 131 }
local fbiSkins = { 163, 164, 165, 166, 294 }

function onATMClick( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
		if not(isPC(source)) then return end
		if not(isFraktionsPC(thePlayer, source)) then return end
		local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
		triggerClientEvent(thePlayer, "onFraktionsGUIStart", thePlayer)
		end
end
		
addEventHandler( "onElementClicked", getRootElement(), onATMClick ) 

function isFraktionsPC(thePlayer, element)
	if(tonumber(getElementData(element, "FRAKTIONSPC")) == getPlayerFraktion(thePlayer)) then return true;
	else return false; end
end

function isPC(element)
	if(getElementData(element, "FRAKTIONSPC")) then return true;
	else return false; end
end

addEvent("onFraktionUninvite", true)
addEventHandler("onFraktionUninvite", getRootElement(),
function(player)
	local player = getPlayerFromName(player)
	--outputChatBox("LOL!")
	setElementData(player, "pFraktion", 0)
	setElementData(player, "pFraktionsrang", 0)
	outputChatBox("Du hast "..getPlayerName(player).." aus der Fraktion entfernt.", source, 0, 200, 0, false)
	outputChatBox("Du wurdest von "..getPlayerName(source).." aus der Fraktion entfernt.", player, 225, 0, 0, false)
	outputChatBox("Du bist nun Zivilist!", player, 200, 0, 0, false)
	--outputChatBox("LOL!4")
end)

addEvent("onFraktionRankdown", true)
addEventHandler("onFraktionRankdown", getRootElement(),
function(player)
	local player = getPlayerFromName(player)
	--outputChatBox("LOL!")
	local rank = getPlayerFraktionsrang(player)
	if not(rank) then return end
	--outputChatBox("LOL!2")
	if(rank < 1) then outputChatBox("Du kannst den Rank nicht niedriger als 0 Setzen!", source, 200, 0, 0, false) return end
	--outputChatBox("LOL!3")
	setElementData(player, "pFraktionsrang", tonumber(getElementData(player, "pFraktionsrang"))-1)
	local newrank = getPlayerFraktionsrang(player)
	outputChatBox("Du hast "..getPlayerName(player).." Rank: "..newrank.." gegeben.", source, 0, 200, 0, false)
	outputChatBox("Du wurdest von "..getPlayerName(source).." auf Rank "..newrank.." degradiert!", player, 225, 0, 0, false)
	--outputChatBox("LOL!4")
end)

addEvent("onFraktionRankup", true)
addEventHandler("onFraktionRankup", getRootElement(),
function(player)
	local player = getPlayerFromName(player)
	local rank = getPlayerFraktionsrang(player)
	if not(rank) then return end
	if(rank > 4) then outputChatBox("Du kannst den Rank nicht hoeher als 5. Setzen!", source, 200, 0, 0, false) return end
	setElementData(player, "pFraktionsrang", tonumber(getElementData(player, "pFraktionsrang"))+1)
	local newrank = getPlayerFraktionsrang(player)
	outputChatBox("Du hast "..getPlayerName(player).." Rank: "..newrank.." gegeben.", source, 0, 200, 0, false)
	outputChatBox("Glueckwunsch, du wurdest von "..getPlayerName(source).." auf Rank "..newrank.." gesetzt!", player, 0, 225, 0, false)
end)

addEvent("onFraktionsPCArmor", true)
addEventHandler("onFraktionsPCArmor", getRootElement(),
function()
	setPedArmor(source, 100)
end)

addEvent("onFraktionsSkin", true)
addEventHandler("onFraktionsSkin", getRootElement(),
function ()
	local data = getPlayerFraktion(source)
	if not(data) then return end
	if(data == 0) then return end
	local skinVar = 0
	if(data == 1) then
		skinVar = yakuzaSkins
	elseif(data == 2) then
		skinVar = terrorSkins
	elseif(data == 3) then
		skinVar = fahrschulSkins
	elseif(data == 4) then
		skinVar = rcpdSkins
	elseif(data == 5) then
		skinVar = rcnrSkins
	elseif(data == 6) then
		skinVar = rbSkins
	elseif(data == 7) then
		skinVar = fbiSkins
	end
		local randomSkin = math.random(#skinVar)
		setElementModel(source, skinVar[randomSkin] )
end)

--[[
1 = 9mm
2 = Deagle
3 = Messer
4 = MP5
5 = AK-47
6 = Raketenwerfer
7 = Granaten
8 = Sniper
9 = Shotgun
10 = RPG
11 = Spaz-12
12 = M4--]]

addEvent("onFraktionsWaffen", true)
addEventHandler("onFraktionsWaffen", getRootElement(),
function(CH1, CH2, CH3, CH4, CH5, CH6, CH7, CH8, CH9, CH10, CH11, CH12)
	if(CH1 == false) and (CH2 == false) and (CH3 == false) and (CH4 == false) and (CH5 == false) and (CH6 == false) and (CH7 == false) and (CH8 == false) and (CH9 == false) and (CH10 == false) and (CH11 == false) and (CH12 == false) then return end
	local data = getPlayerFraktion(source)
	if(data == 0) then return end
	local title = "N/A"
	if(data == 1) then title = "YAKUZAWAFFEN" end
	if(data == 2) then title = "TERRORISTWAFFEN" end
	if(data == 3) then title = "FAHRSCHULEWAFFEN" end
	if(data == 4) then title = "RCPDWAFFEN" end
	if(data == 6) then title = "REDBROTHERSWAFFEN" end
	if(data == 7) then title = "FBIWAFFEN" end
	local query1 = mysql_query( handler, "SELECT * FROM kassen;" )
	local row = mysql_fetch_assoc(query1)
	local waffen = row[title]	
	if(tonumber(waffen) < 0) then mysql_query(handler,"UPDATE kassen SET "..title.." = '0'") return end
	if(tonumber(waffen) < 1) then outputChatBox("Es sind keine Waffen mehr vorhanden!", source, 200, 0, 0, false) return end
	--
	local weapons = 0
	if(CH1 == true) then
		weapons = (weapons+1)
	end
	if(CH2 == true) then
		weapons = (weapons+1)
	end
	if(CH3 == true) then
		weapons = (weapons+1)
	end
	if(CH4 == true) then
		weapons = (weapons+1)
	end
	if(CH5 == true) then
		weapons = (weapons+1)
	end
	if(CH6 == true) then
		weapons = (weapons+5)
	end
	if(CH7 == true) then
		weapons = (weapons+1)
	end
	if(CH8 == true) then
		weapons = (weapons+1)
	end
	if(CH9 == true) then
		weapons = (weapons+1)
	end
	if(CH10 == true) then
		weapons = (weapons+5)
	end
	if(CH11 == true) then
		weapons = (weapons+1)
	end
	if(CH12 == true) then

		weapons = (weapons+1)
	end
	if(tonumber(waffen) < weapons) then outputChatBox("Es sind nicht genug Waffen vorhanden!", source, 200, 0, 0, false) return end
	if(CH1 == true) then
		giveWeapon(source, 22, 17, true)

	end
	if(CH2 == true) then
		giveWeapon(source, 24, 17, true)

	end
	if(CH3 == true) then
		giveWeapon(source, 4, 1, true)

	end
	if(CH4 == true) then
		giveWeapon(source, 29, 30, true)

	end
	if(CH5 == true) then
		giveWeapon(source, 30, 30, true)

	end
	if(CH6 == true) then
		giveWeapon(source, 35, 1, true)

	end
	if(CH7 == true) then
		giveWeapon(source, 16, 1, true)

	end
	if(CH8 == true) then
		giveWeapon(source, 34, 1, true)

	end
	if(CH9 == true) then
		giveWeapon(source, 25, 5, true)

	end
	if(CH10 == true) then
		giveWeapon(source, 36, 1, true)

	end
	if(CH11 == true) then
		giveWeapon(source, 27, 7, true)

	end
	if(CH12 == true) then
		giveWeapon(source, 31, 50, true)

	end

	local result = mysql_query(handler,"UPDATE kassen SET "..title.." = '"..(waffen-weapons).."'")
	if(result) then
		triggerEvent("onFraktionspcDataNeed", source)
	else
		outputChatBox("Fehler!", source, 0, 200, 0, false)
	end
end)

addEvent("onFraktionspcDataNeed", true)
addEventHandler("onFraktionspcDataNeed", getRootElement(),
function()
local data = getPlayerFraktion(source)
if(data == 0) then return end
if(data == 1) then
		local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['YAKUZA'], row['YAKUZAWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"
			local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['YAKUZA'], row['YAKUZAWAFFEN'])
			end	
			mysql_free_result(result)
	elseif(data == 2) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['TERRORIST'], row['TERRORISTWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['TERRORIST'], row['TERRORISTWAFFEN'])
			end	
			mysql_free_result(result)
	elseif(data == 3) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['FAHRSCHULE'], row['FAHRSCHULEWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['FAHRSCHULE'], row['FAHRSCHULEWAFFEN'])
			end
			mysql_free_result(result)
	elseif(data == 4) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['RCPD'], row['RCPDWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['RCPD'], row['RCPDWAFFEN'])
			end
			mysql_free_result(result)
	elseif(data == 5) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['RCNR'], row['RCNRWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['RCNR'], row['RCNRWAFFEN'])
			end
			mysql_free_result(result)
	elseif(data == 6) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['REDBROTHERS'], row['REDBROTHERSWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"
			local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['REDBROTHERS'], row['REDBROTHERSWAFFEN'])
			end
			mysql_free_result(result)
	elseif(data == 7) then
			local result = mysql_query( handler, "SELECT * FROM kassen;" )
		if ( result and mysql_num_rows( result ) > 0) then
			local row = mysql_fetch_assoc(result)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['FBI'], row['FBIWAFFEN'])
		else
			local query2 = "INSERT INTO kassen ( YAKUZA, YAKUZAWAFFEN, TERRORIST, TERRORISTWAFFEN, FAHRSCHULE, FAHRSCHULEWAFFEN, RCPD, RCPDWAFFEN, RCNR, RCNRWAFFEN, REDBROTHERS, REDBROTHERSWAFFEN ) VALUES ( '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0')"
			local result2 = mysql_query( handler, query2 )
			local row = mysql_fetch_assoc(result2)
			triggerClientEvent(source, "onFraktionspcDataNeedBack", source, row['FBI'], row['FBIWAFFEN'])
			end
			mysql_free_result(result)
	end	
end
)
addEvent("onFraktionspcKasseAuszahl", true)
addEventHandler("onFraktionspcKasseAuszahl", getRootElement(),
function(text)
	if not(text) then return end
	local data = getPlayerFraktion(source)
	if(data == 0) then return end
	local title = "N/A"
	if(data == 1) then title = "YAKUZA" end
	if(data == 2) then title = "TERRORIST" end
	if(data == 3) then title = "FAHRSCHULE" end
	if(data == 4) then title = "RCPD" end
	if(data == 5) then title = "RCNR" end
	if(data == 6) then title = "REDBROTHERS" end
	if(data == 7) then title = "FBI" end
	local data2 = getPlayerFraktionsrang(source)
	if(data2 < 5) then outputChatBox("Du kannst erst mit Rank 5 was Auszahlen.", source, 200, 0, 0, false) return end
	local query1 = mysql_query( handler, "SELECT * FROM kassen;" )
	local row = mysql_fetch_assoc(query1)
	local bargeld = row[title]
	if(tonumber(bargeld) < tonumber(text)) then outputChatBox("Es ist nicht soviel Vorhanden!", source, 200, 0, 0, false) return end
	local result = mysql_query(handler,"UPDATE kassen SET "..title.." = '"..(bargeld-text).."'")
	if(result) then
		outputChatBox("Du hast erfolgreich "..text.." $ Ausgezahlt!", source, 0, 200, 0, false)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))+text)
	else
		outputChatBox("Fehler!", source, 0, 200, 0, false)
	end
end)
addEvent("onFraktionspcKasseEinzahl", true)
addEventHandler("onFraktionspcKasseEinzahl", getRootElement(),
function(text, var)
	if not(text) then return end
	local data = getPlayerFraktion(source)
	if(data == 0) then return end
	local title = "N/A"
	if(data == 1) then title = "YAKUZA" end
	if(data == 2) then title = "TERRORIST" end
	if(data == 3) then title = "FAHRSCHULE" end
	if(data == 4) then title = "RCPD" end
	if(data == 5) then title = "RCNR" end
	if(data == 6) then title = "REDBROTHERS" end
	if(data == 7) then title = "FBI" end
	local query1 = mysql_query( handler, "SELECT * FROM kassen;" )
	local row = mysql_fetch_assoc(query1)
	local bargeld = row[title]
	local result = mysql_query(handler,"UPDATE kassen SET "..title.." = '"..(bargeld+text).."'")
	if (var == nil) then
	if(result) then
		outputChatBox("Du hast erfolgreich "..text.." $ Eingezahlt!", source, 0, 200, 0, false)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-text)
	else
		outputChatBox("Fehler!", source, 0, 200, 0, false)
	end
	elseif(var == 1) then
	
	end
end)

addEvent("onWaffentruckEinzahl", true)
addEventHandler("onWaffentruckEinzahl", getRootElement(),
function(waffen)
	local data = getPlayerFraktion(source)
	if(data == 0) then return end
	local title = "N/A"
	if(data == 1) then title = "YAKUZAWAFFEN" end
	if(data == 2) then title = "TERRORISTWAFFEN" end
	if(data == 3) then title = "FAHRSCHULEWAFFEN" end
	if(data == 4) then title = "RCPDWAFFEN" end
	if(data == 5) then title = "RCNRWAFFEN" end
	if(data == 6) then title = "REDBROTHERSWAFFEN" end
	if(data == 7) then title = "FBI" end
	local query1 = mysql_query( handler, "SELECT * FROM kassen;" )
	local row = mysql_fetch_assoc(query1)
	local waffen2 = row[title]
	local newwaffen = (waffen2+waffen)
	mysql_query(handler,"UPDATE kassen SET "..title.." = '"..newwaffen.."'")
	
end
)