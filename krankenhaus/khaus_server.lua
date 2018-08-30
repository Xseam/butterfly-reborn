--local totzeit = 6000
local totzeit = 1
local totPed = {}
local totAmbulance = {}
local respawnTimeItems = 10
function setDeath ( ammo, attacker, weapon, bodypart )
	if(getElementData(source, "inIntro") == true) then return end
	local thePlayer = source
	fadeCamera(thePlayer, false, 3.5, 255, 255, 255)
	setElementData(thePlayer, "atTot", true)
	local x, y, z = getElementPosition(thePlayer)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		local datum = day.."."..month.."."..year.." um "..hour..":"..minute
		local bkosten = math.random(5, 50)
		local kkosten = math.random(50, 120)
		local gesamtkosten = (bkosten+kkosten)
	setElementData(thePlayer, "pArztrechnung", "______________\nRechnung vom "..datum..":\nBehandlungskosten: "..bkosten.."$\nKrankenwagenkosten: "..kkosten.."$\n______________\nEndkosten: "..gesamtkosten.."$\n\nWir wuenschen dir noch einen schoenen Tag!")
	setElementData(thePlayer, "pBGeld", tonumber(getElementData(thePlayer, "pBGeld"))-gesamtkosten)
	triggerClientEvent("writeToPaylog", thePlayer, datum.."| Krankenhausrechnung von "..gesamtkosten.."$.", 1)
		addInventarDrop(thePlayer, 1)
		addInventarDrop(thePlayer, 2)
		if(getElementInterior(thePlayer) ~= 0) then setTimer(setRealToKrankenhaus, 3500, 1, thePlayer) else
		setTimer( function()
			totAmbulance[thePlayer] = createVehicle(416, x, y, z, "WTF")
			totPed[thePlayer] = createPed(274, x, y+1, z+1)
			setElementAlpha(totAmbulance[thePlayer], 200)
			setVehicleSirensOn(totAmbulance[thePlayer], true)
			setElementFrozen(totAmbulance[thePlayer], true)
			warpPedIntoVehicle(totPed[thePlayer], totAmbulance[thePlayer])
			setCameraMatrix(thePlayer, x, y, z+20, x, y, z)
			fadeCamera(thePlayer ,true)
			setTimer(fadeCamera, 2000, 1, thePlayer, false, 1.0, 255, 255, 255)
			setTimer(setRealToKrankenhaus, 3500, 1, thePlayer)
		end, 4000, 1)
	end
	--[[setTimer(
	function()
	--spawnPlayer ( thePlayer, 0, 0, 0 )
	setElementFrozen(thePlayer, true)
	setElementInterior(thePlayer, 0)
	setCameraMatrix(thePlayer, 1269.8784179688, 334.33276367188, 23.40625, 1254.9797363281, 332.41571044922, 22.5546875)
	setPlayerHudComponentVisible ( thePlayer, "all", false )
	setTimer(fadeCamera, 500, 1, thePlayer, true)
	setTimer(
		function()
		fadeCamera(thePlayer, false, 1.0, 255, 255, 255)
		setTimer(
		function()
			fadeCamera(thePlayer, true, 1.0, 255, 255, 255)
			spawnPlayer ( thePlayer, 0, 0, 0 )
			triggerClientEvent("showRightHud", thePlayer)
			triggerEvent("onXPSpawn", thePlayer)
			setElementData(thePlayer, "atTot", false)
			outputChatBox("Deine Krankenhausrechnung befindet sich im Inventar.", thePlayer, 0, 200, 255, false)
			end, 1000, 1)
		end, totzeit, 1)
	end, 4000, 1)
	--]]
end
addEventHandler ( "onPlayerWasted", getRootElement(), setDeath )

function addInventarDrop(thePlayer, id)
	-- IDS: Geld: 1212 Paket: 1575, Pizza: 1582, Ausweis(Karte): 1581
	local x, y, z = getElementPosition(thePlayer)
	local int, dim = getElementInterior(thePlayer), getElementDimension(thePlayer)
	
	if(id == 1) then
		local geld = tonumber(getElementData(thePlayer, "pHGeld"))
		if(geld < 0) then return end
		local moneydrop = math.ceil ( geld / 5 )
		local redo = 1
		if(moneydrop > 200) then redo = 2 end
		if(moneydrop > 500) then redo = 3 end
		if(moneydrop > 1500) then redo = 4 end
		if(moneydrop > 5000) then redo = 5 end
		if(moneydrop > 10000) then redo = 6 end
		setElementData(thePlayer, "pHGeld", geld-moneydrop)
		wert = math.ceil(moneydrop/redo)
		for i = 1, redo, 1 do
		
			local ob = createObject(1212, x+math.random(0.10, 2.50), y+math.random(0.1, 2.5), z-0.7)
			setElementData(ob, "GWERT", wert)
			setElementInterior(ob, int)
			setElementDimension(ob, dim)
			setTimer(destroyElement, respawnTimeItems*60*1000, 1, ob)
			addEventHandler( "onElementClicked",ob, 
			function(mouse, button, theUser)	
				if(mouse == "left") and (button == "down") then
					
					local wertg = getElementData(source, "GWERT")
					outputChatBox("Du hebst ein Geldbuendel mit "..wertg.."$ auf...", theUser, 0, 200, 0, false)
					destroyElement(source)
					setElementData(theUser, "pHGeld", tonumber(getElementData(theUser, "pHGeld"))+wertg)
				end
			end)
			
		end
		
	end
	if(id == 2) then
		local kard = createObject(1581, x+math.random(0.10, 2.50), y+math.random(0.1, 2.5), z-0.7, 0, 90, 20)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		setElementData(kard, "OWNER", getPlayerName(thePlayer))
		setElementData(kard, "TIME", day.."."..month.."."..year.." um "..hour..":"..minute)
		setElementInterior(kard, int)
		setElementDimension(kard, dim)
		setTimer(destroyElement, respawnTimeItems*60*1000, 1, kard)
		addEventHandler( "onElementClicked",kard, 
			function(mouse, button, theUser)	
				if(mouse == "left") and (button == "down") then
					local zeit = getElementData(source, "TIME")
					local owner = getElementData(source, "OWNER")
					outputChatBox("Du hast eine Informationskarte gefunden!", theUser, 0, 200, 200, false)
					outputChatBox("Crippen Memorial Hospital Meldet: ", theUser, 0, 200, 100, false)
					outputChatBox("Name: "..owner, theUser, 0, 200, 0, false)
					outputChatBox("Uhrzeit des Sterbens: "..zeit, theUser, 0, 200, 0, false)
					destroyElement(source)
				end
			end)
	end
end

function setRealToKrankenhaus(thePlayer)
	if(totPed[thePlayer]) then destroyElement(totPed[thePlayer]) end
	if(totAmbulance[thePlayer]) then destroyElement(totAmbulance[thePlayer]) end
	totPed[thePlayer] = nil
	totAmbulance[thePlayer] = nil
	fadeCamera(thePlayer, true)
	spawnPlayer ( thePlayer, 0, 0, 0 )
	setElementFrozen(thePlayer, true)
	setElementInterior(thePlayer, 0)
	setCameraMatrix(thePlayer, 1269.8784179688, 334.33276367188, 23.40625, 1254.9797363281, 332.41571044922, 22.5546875)
	for i = 1, 10, 1 do
		outputChatBox(" ", thePlayer)
	end
	local zeit = totzeit
	if(getElementData(thePlayer, "derby") == true) then
		zeit = 0.2
		outputChatBox("Du bist nun fuer "..zeit.." Minute(n) im Krankenhaus, da du in der Derby-Halle gestorben bist.", thePlayer, 0, 255, 255)
		setElementData(thePlayer, "derby", false)
	else
		outputChatBox("Du bist nun fuer "..totzeit.." Minute(n) im Krankenhaus.", thePlayer, 0, 255, 255)
	end
	setPlayerHudComponentVisible ( thePlayer, "all", false )
	setTimer(fadeCamera, 500, 1, thePlayer, true)
	setTimer(
		function()
		fadeCamera(thePlayer, false, 1.0, 255, 255, 255)
		setTimer(
		function()
			fadeCamera(thePlayer, true, 1.0, 255, 255, 255)
			spawnPlayer ( thePlayer, 0, 0, 0 )
			triggerClientEvent("showRightHud", thePlayer)
			triggerEvent("onXPSpawn", thePlayer)
			setElementData(thePlayer, "atTot", false)
			outputChatBox("Deine Krankenhausrechnung befindet sich im Inventar.", thePlayer, 0, 200, 255, false)
			end, 1000, 1)
		end, zeit*1000*60, 1)
end