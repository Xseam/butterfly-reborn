
local Object = createObject(1454, 2315.5, 0.5, 25, 0, 0, 270) -- Bombenobjektda
local ATM = {}
ATM[1] = createObject(2942, 2316.6999511719, -4.6999998092651, 26.39999961853, 0, 0, 270)
setElementData(ATM[1], "ATM", 1)
ATM[2] = createObject(2942, 2316.6999511719, -7.4000000953674, 26.39999961853, 0, 0, 270)
setElementData(ATM[2], "ATM", 2)
ATM[3] = createObject(2942, 2316.6999511719, -10.60000038147, 26.39999961853, 0, 0, 270)
setElementData(ATM[3], "ATM", 3)
ATM[4] = createObject(2942, 2316.6999511719, -13.60000038147, 26.39999961853, 0, 0, 270)
setElementData(ATM[4], "ATM", 4)

ATM[5] = createObject(2942, 242.45399475098, -56.897258758545, 1.278125, 0, 0, 270) -- Blueberry am Laden
setElementData(ATM[5], "ATM", "Stadt")
ATM[6] = createObject(2942, 647.46673583984, -519.68005371094, 16.253686141968, 0, 0, 359) -- PD
setElementData(ATM[6], "ATM", "Stadt")
ATM[7] = createObject(2942, 1204.4814453125, 187.63793945313, 20.53777885437, 0, 0, (64)) -- Autohaus 1 --
setElementData(ATM[7], "ATM", "Stadt")
ATM[8] = createObject(2942, 1374.2985839844, 473.61642456055, 19.892170715332, 0, 0, (245)) -- Tankstelle Montgomery --
setElementData(ATM[8], "ATM", "Stadt")


function createPed1()
	if(BankPed1) then destroyElement(BankPed1) end
	local BankPed1 = createPed(17, 2310.7661132813, -11.012133598328, 26.7421875)
	setElementHealth(BankPed1, 1000)
	setElementFrozen(BankPed1, true)
	setElementRotation(BankPed1, 0, 0, 180)
end

function createPed2()
	if(BankPed2) then destroyElement(BankPed2) end
	local BankPed2 = createPed(141, 2306.5319824219, -1.4296736717224, 26.7421875)
	setElementHealth(BankPed2, 1000)
	setElementFrozen(BankPed2, true)
	setElementRotation(BankPed2, -0, 0, 228)
end

function createPed3()
	if(BankPed3) then destroyElement(BankPed3) end
	local BankPed3 = createPed(228, 2318.3229980469, -10.08620262146, 26.749565124512)
	setElementHealth(BankPed3, 1000)
	setElementFrozen(BankPed3, true)
	setElementRotation(BankPed3, -0, 0, 90)
end

createPed1()
createPed2()
createPed3()

setTimer(createPed1, 5000000, 0)
setTimer(createPed2, 5000000, 0)
setTimer(createPed3, 5000000, 0)

for i = 1, #ATM, 1 do 
	addEventHandler( "onElementClicked", ATM[i], 
	function(theButton, theState, thePlayer )
		if theState == "down" and theButton == "left" then 
			if(tonumber(getElementData(thePlayer, "Clicked")) == 1) then return end
			triggerClientEvent(thePlayer, "onBankTerminalClick", thePlayer, getElementData(source, "ATM"))
			setElementData(thePlayer, "Clicked", 1)
			end
		end
	)
end
addEvent("onBankGeldSpende", true)
addEventHandler("onBankGeldSpende", getRootElement(), function(money)
	local query = "SELECT * FROM kassen"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		local r = mysql_query(handler,"UPDATE kassen SET RCNR = '"..(row['RCNR']+money).."'")
		mysql_free_result(result)
		mysql_free_result(r)
		for index, player in pairs(getElementsByType("player")) do
			if(getPlayerFraktion(player) == 5) then
				outputChatBox(getPlayerName(source).." hat "..money.." $ gespendet!", player, 0, 255, 255)
			end
		end
	else 
		givePlayerItem(source, "pBGeld", money)
		outputChatBox("Fehler beim Spenden! Du hast dein Geld zurueckbekommen.", 255, 0, 0)
	end
end)
addEvent("onBankAction", true)
addEventHandler("onBankAction", getRootElement(),
function(text, var, empfaenger, grund)
	if(var == 1) then
		local name = getPlayerName(source)
		local bankgeld = tonumber(getElementData(source, "pBGeld"))
		local handgeld	 = tonumber(getElementData(source, "pHGeld"))
		setElementData(source, "pBGeld", bankgeld+text)
		setElementData(source, "pHGeld", handgeld-text)
		outputChatBox("Du hast "..text.."$ Eingezahlt!", source, 0, 200, 0, false)
		triggerEvent("onBankdataNeed", source)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		if(getElementData(source, "ATMVAR") == "Stadt") then
		local x, y, z = getElementPosition(source)
		local zone = getZoneName ( x, y, z )
			triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast in "..zone.." "..text.."$ Eingezahlt!")
		else
			triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast "..text.."$ Eingezahlt!")
		end
	elseif(var == 2) then
		local name = getPlayerName(source)
		local bankgeld = tonumber(getElementData(source, "pBGeld"))
		local handgeld = tonumber(getElementData(source, "pHGeld"))
		if(bankgeld < text) then outputChatBox("Du hast nicht soviel Geld auf der Bank!", source, 200, 0, 0, false) return end
		setElementData(source, "pBGeld", bankgeld-text)
		setElementData(source, "pHGeld", handgeld+text)
		outputChatBox("Du hast "..text.."$ Ausgezahlt!", source, 0, 200, 0, false)
		triggerEvent("onBankdataNeed", source)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		if(getElementData(source, "ATMVAR") == "Stadt") then
			local x, y, z = getElementPosition(source)
			local zone = getZoneName ( x, y, z )
				triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast in "..zone.." "..text.."$ Ausgezahlt!")
			else
				triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast "..text.."$ Ausgezahlt!")
		end
	elseif(var == 3) then
		local name = getPlayerName(source)
		local bankgeld = tonumber(getElementData(source, "pBGeld"))
		if(bankgeld < text) then outputChatBox("Du hast nicht soviel Geld auf der Bank!", source, 200, 0, 0, false) return end
		local target = getPlayerFromName(empfaenger)
		if not(target) then outputChatBox("Spieler Error!", source, 255, 0, 0, false) return end
		setElementData(target, "pBGeld", getElementData(target, "pBGeld")+text)
		setElementData(source, "pBGeld", getElementData(source, "pBGeld")-text)
		outputChatBox("Ueberweisung erfolgreich!", source, 0, 200, 0, false)
		outputChatBox("Bankinfo: Dir wurde Geld ueberwiesen. Checke dein Kontoauszug!", getPlayerFromName(empfaenger), 0, 200, 0, false)
		triggerEvent("onBankdataNeed", source)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
			triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast "..text.."$ an "..empfaenger.." Ueberwiesen!\nGrund: "..grund)
			triggerClientEvent(getPlayerFromName(empfaenger), "writeToPaylog", getPlayerFromName(empfaenger), day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Dir wurde "..text.."$ von "..getPlayerName(source).." Ueberwiesen!\nGrund: "..grund)
	end
end)

addEvent("onBankdataNeed", true)
addEventHandler("onBankdataNeed", getRootElement(),
function()
	local name = getPlayerName(source)
	local query = "SELECT * FROM accounts WHERE NAME = \'"..name.."\';"
	local result = mysql_query( handler, query )
	local row = mysql_fetch_assoc( result )
	local geld = row['BANK_GELD']
	
	local query2 = "SELECT * FROM bank WHERE SPIELER = \'"..name.."\';"
	local result2 = mysql_query( handler, query2 )
	local row2 = mysql_fetch_assoc( result2)
	if (row2 == nil) then
		setElementData(source, "Konto", false)
	else
		setElementData(source, "Konto", true)
	end
	
	triggerClientEvent(source, "onBankdataNeedBack", source, geld)
	mysql_free_result(result)
	mysql_free_result(result2)
end)

addEvent("onBankkontoEroeffne", true)
addEventHandler("onBankkontoEroeffne", getRootElement(),
function(text1)
	local query = "INSERT INTO bank ( SPIELER, PIN) VALUES ( '"..getPlayerName(source).."', '"..text1.."' )"
	local result = mysql_query( handler, query )
	if(result) then
		triggerClientEvent(source, "onBankkontoErfolgreichEroeffnet", source)
	else
		outputChatBox("Fehler beim Eroeffnen des Kontos!", source, 200, 0, 0, false)
	end
end)

addEvent("onBankkontoAnmelden", true)
addEventHandler("onBankkontoAnmelden", getRootElement(),
function(text1)
	local name = getPlayerName(source)
	local query = "SELECT * FROM bank WHERE SPIELER = \'"..name.."\' AND PIN = \'"..text1.."\';"
	local result = mysql_query( handler, query )
	local row = mysql_fetch_assoc( result )
	
	if ( result and mysql_num_rows( result ) > 0) then
		triggerClientEvent(source, "onBankkontoErfolgreichAnmeld", source)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		triggerClientEvent(source, "writeToPaylog", source, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Du hast dich Angemeldet.")
		mysql_free_result(result)
	else
		outputChatBox("Fehler beim Anmelde: Falscher PIN!", source, 200, 0, 0, false)
	end
end)