
addEvent("onHandyKauf",true)
addEventHandler("onHandyKauf",getRootElement(),
function ( vorwahl, nummer, name )
	
	local nummer2 = vorwahl..""..nummer

	local result = mysql_query( handler, "SELECT HANDYNUMMER FROM accounts WHERE HANDYNUMMER = '"..nummer2.."'")
	
	if result and mysql_num_rows( result ) > 0 then outputChatBox("Die Handynummer exestiert schon!",source,200,0,0) return end
	local name = getPlayerName(source)
	outputChatBox("Du hast dir ein Handy mit der Nummer "..vorwahl.."/"..nummer.." beantrag!",source,0,0,200)
	mysql_query(handler,"UPDATE accounts SET HANDYNUMMER = '"..nummer2.."' WHERE NAME = '"..name.."'")
	setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-60)
	setElementData(source, "pHandynummer", nummer)
end)
addEvent("onPlayerCallPlayer", true)
addEventHandler("onPlayerCallPlayer", getRootElement(),
function(number)
	local called = 0
	for index, player in pairs(getElementsByType("player")) do
		local handy = getElementData(player, "pHandynummer")
		if(handy) then
			if(called == 1) then outputChatBox("Es wurden mehrere Spieler mit der Handynummer gefunden! Breche ab.", source, 200, 0, 0, false) return end
			if(handy == number) then
				if(getElementData(player, "imGesprach") == 1) or (getElementData(player, "angerufen") == true) then outputChatBox("Leitung Besetzt!", source, 0, 200, 0, false) return end
				called = 1
				triggerClientEvent(source, "onHandySucess", source, 1)

				setElementData(player, "angerufen", true)
				setElementData(player, "anrufer", source)
				setElementData(source, "wartend", true)
				setElementData(source, "wartender", player)
				outputChatBox("Dein Handy klingelt!", player, 0, 200, 0)
				outputChatBox("Du hast die Nummer gewaehlt. Es klingelt.", source, 0, 200, 0)
			end
		end
	end
	if(called == 0) then
		triggerClientEvent(source, "onHandySucess", source, 0)
	end
end)

addEvent("onPlayerAcceptPlayer", true)
addEventHandler("onPlayerAcceptPlayer", getRootElement(),
function()
	local anrufer = getElementData(source, "anrufer")
	outputChatBox("Du redest nun mit "..getPlayerName(anrufer)..".", source, 255, 255, 255)
	outputChatBox("Du redest nun mit "..getPlayerName(source)..".", anrufer, 255, 255, 255)
	setElementData(source, "angerufen", false)
	setElementData(source, "anrufer", false)
	setElementData(anrufer,"wartend", false)
	setElementData(anrufer, "wartender", false)
	setElementData(source, "imGesprach", true)
	setElementData(source, "gespraecher", anrufer)
	setElementData(anrufer, "imGesprach", true)
	setElementData(anrufer, "gespraecher", source)
end)

addEvent("onPlayerCallStop", true)
addEventHandler("onPlayerCallStop", getRootElement(),
function(player)
	setElementData(source, "imGesprach", false)
	setElementData(source, "gespraecher", false)
	setElementData(player, "imGesprach", false)
	setElementData(player, "gespraecher", false)
	outputChatBox("Teilnehmer legt auf.", player, 255, 255, 255)
	outputChatBox("Aufgelegt.", source, 255, 255, 255)
end)

addEventHandler("onPlayerWasted", getRootElement(),
function()
	if(getElementData(source, "imGesprach") == true) then
		local anrufer = getElementData(source, "gespraecher")
		setElementData(anrufer, "imGesprach", false)
		setElementData(anrufer, "gespraecher", false)
		outputChatBox("*Knacks*, die Leitung ist Tot.", anrufer, 0, 200, 0, false)
	end
	if(getElementData(source, "angerufen") == true) then
		local anrufer = getElementData(source, "anrufer")
		setElementData(anrufer, "wartend", false)
		setElementData(anrufer, "wartender", false)
		outputChatBox("*Knacks*, die Leitung ist Tot.", anrufer, 0, 200, 0, false)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "imGesprach") == true) then
		local anrufer = getElementData(source, "gespraecher")
		setElementData(anrufer, "imGesprach", false)
		setElementData(anrufer, "gespraecher", false)
		outputChatBox("Spieler ist Offline gegangen!", anrufer, 0, 200, 0, false)
	end
	if(getElementData(source, "angerufen") == true) then
		local anrufer = getElementData(source, "anrufer")
		setElementData(anrufer, "wartend", false)
		setElementData(anrufer, "wartender", false)
		outputChatBox("Spieler ist Offline gegangen!", anrufer, 0, 200, 0, false)
	end
end)
addCommandHandler("sms", function(thePlayer, cmd, number, ...)	
	if (hasPlayerHandy(thePlayer) == false) then outputChatBox("Du hast kein Handy!", thePlayer, 200, 0, 0) return end
	if not(number) then outputChatBox("Du musst eine Nummer angeben!", thePlayer, 200, 0, 0) return end
	if(tonumber(number) == nil) then outputChatBox("Ungueltige Nummer!", thePlayer, 200, 0, 0) return end
	if not(...) then outputChatBox("Bitte gebe ein Text ein!", thePlayer, 200, 0, 0) return end
	local text = table.concat( {...}, " " )
	local done = 0
	for index, player in pairs(getElementsByType("player")) do
		local handy = getElementData(player, "pHandynummer")
		if(handy) and (tonumber(handy)) then
			if(handy == number) then
				done = 1
				setTimer(function()
					outputChatBox("SMS von "..getPlayerName(thePlayer).." ("..getElementData(thePlayer, "pHandynummer").."):", player, 255, 255, 0)
					outputChatBox(text, player, 255, 255, 0)
				end, 2500, 1)
			end
		end
	end
	if(done == 1) then
		outputChatBox("SMS Erfolgreich an "..number.." versendet!", thePlayer, 0, 200, 0)
	else
		outputChatBox("Es wurde kein Spieler mit dieser Nummer gefunden.", thePlayer, 200, 0, 0)
	end
	
end)



