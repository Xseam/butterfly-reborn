setFPSLimit(65)
local startup = 0
function on_startup()
	outputDebugString("===========================")
	outputDebugString("")
	outputDebugString("Butterfly-Reallife bei MuLTi!")
	outputDebugString("")
	outputDebugString("===========================")
	local resourcen = getResources()
	local resrun, resfail, resload = 0, 0, 0
	for index, resource in pairs(resourcen) do
		if(getResourceState ( resource ) == "running") then
			resrun = resrun+1
		end
		if(getResourceState ( resource ) == "loaded") then
			resload = resload+1
		end
		if(getResourceState ( resource ) == "failed to load") then
			resfail = resfail+1
		end
	end
	outputDebugString("")
	outputDebugString("Zurzeit Laufende Ressourcen: "..resrun)
	outputDebugString("Zurzeit Geladete Ressourcen: "..resload)
	outputDebugString("Fehlerhafte Ressourcen: "..resfail)
	if(resrun > 10) then
		outputDebugString("Warnung: Es sind mehr als 10 Ressourcen Laufend.")
	end
	setTimer(
		function()
		outputDebugString("-----------")
		outputDebugString("")
		outputDebugString("Server bereit, Verbindungen einzulassen.")
		startup = 1
		end, 5000, 1)
end
on_startup()
-- Morde / Tode --

addEventHandler( "onPlayerWasted", getRootElement(),
	function(ammo, killer, weapon, part)
		if part then
			if part == 9 then
				setPedHeadless (source, true )
			end
		end
		-- Killogs --
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		if not(fileExists("logs/killlogs/"..day.."."..month.."."..year..".txt")) then
			fileCreate("logs/killlogs/"..day.."."..month.."."..year..".txt")
		end
		local file = fileOpen("logs/killlogs/"..day.."."..month.."."..year..".txt")
		fileSetPos(file, fileGetSize(file))   
		if(killer ~= false) then
			if(getElementType(killer) == "player") then
				fileWrite(file, "\n"..hour..":"..minute..": "..getPlayerName(killer).." hat "..getPlayerName(source).." getoetet.("..weapon..")")
			elseif(getElementType(killer) == "vehicle") then
				if(getVehicleOccupant(killer)) then
					fileWrite(file, "\n"..hour..":"..minute..": "..getPlayerName(source).." hat "..getPlayerName(getVehicleOccupant(killer)).." getoetet.(Fahrzeug)")
				end
			
			end
		else
			fileWrite(file, "\n"..hour..":"..minute..": "..getPlayerName(source).." starb. (Kein Killer)")
		end
	
		fileFlush(file)
		fileClose(file)
		setElementData(source, "pTode", tonumber(getElementData(source, "pTode"))+1)
		if(killer == nil) then return end
		if not(killer) then return end
		if(getElementType(killer) == "player") then
				setElementData(killer, "pMorde", tonumber(getElementData(killer, "pMorde"))+1)
		end
		if(killer) then
			if(getElementType(killer) ~= "player") then return end
			if (getPlayerFraktion(killer) == 4) or (getPlayerFraktion(killer) == 7) then 
				if(getElementData(source, "pWanteds") > 0) then
					local wanteds = getElementData(source, "pWanteds")
						local zeit = 0
						local geld = 0

						if(wanteds == 1) then zeit = 7 geld = 100 end
						if(wanteds == 2) then zeit = 14 geld = 200 end
						if(wanteds == 3) then zeit = 21 geld = 500 end
						if(wanteds == 4) then zeit = 28 geld = 1000 end
						if(wanteds == 5) then zeit = 35 geld = 2000 end
						if(wanteds == 6) then zeit = 43 geld = 5000 end	
						setElementData(source, "pJail", 1)
						setElementData(source, "pJailtime", zeit)
						setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-geld)
						outputChatBox("Du wurdest von Polizist "..getPlayerName(killer).." getoetet, und bist nun fuer "..zeit.." Minuten und "..geld.."$ Im Gefaengnis.", source, 200, 0, 0)
						outputChatBox("Du hast Gesuchte Person "..getPlayerName(source).." getoetet, und erhaelst "..math.ceil(geld/3).." $!", killer, 0, 200, 0)
						setElementData(killer, "pHGeld", tonumber(getElementData(killer, "pHGeld"))+math.ceil(geld/5))
						setElementData(source, "pWanteds", 0)
						setPlayerWantedLevel(source, 0)
				end
			end
		end
	
	end
)


function on_spawn_func ()

	setPedHeadless ( source, false )
end
addEventHandler ( "onPlayerSpawn", getRootElement(), on_spawn_func )


-- Anti Nick Change --

function onNickChange_func(oldNick, newNick)
	outputChatBox("Bitte Frage einen Admin, wenn du dein Name aendern moechtest!", source, 255, 0, 0, false)
	cancelEvent()
end
addEventHandler("onPlayerChangeNick", getRootElement(), onNickChange_func) 

-- Anti Sleath-Kill --

function abort_stealth(targetPlayer)
     cancelEvent() 
end
addEventHandler("onPlayerStealthKill", getRootElement(), abort_stealth)

-- MSG --
function block_PM(msg)
	outputChatBox("Bitte benutze dein Handy!", source, 200, 0, 0)
	cancelEvent() 
end
addEventHandler("onPlayerPrivateMessage",getRootElement(),block_PM) 

-- Vechicle Explode --

addEventHandler("onVehicleExplode", getRootElement(),
function()
	local veh = source
	local x, y, z = getElementPosition(veh)
	triggerClientEvent("onVehicleXPExplode", veh, x, y, z)
end)
addEventHandler("onResourceStart", getResourceRootElement ( getThisResource() ),
function()
	--setServerPassword(nil)
	local result = mysql_query( handler, "SELECT * FROM drugs;" )
	if ( result and mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		local yakdrugs = (gettok(row['YAKUZA'], 1, "|")+5)
		local reddrugs = (gettok(row['REDBROTHERS'], 1, "|")+5)
		local yakmats = (gettok(row['YAKUZA'], 2, "|")+5)
		local redmats = (gettok(row['REDBROTHERS'], 2, "|")+5)
		mysql_query(handler, "UPDATE drugs SET YAKUZA = '|"..yakdrugs.."|"..yakmats.."|'")
		mysql_query(handler, "UPDATE drugs SET REDBROTHERS = '|"..reddrugs.."|"..redmats.."|'")
		outputServerLog("Fraktionsdrogen: Yakuza: "..yakdrugs..", Redbrothers: "..reddrugs)
		outputServerLog("Fraktionsmats: Yakuza:".. yakmats..", Redbrothers:"..redmats)
		mysql_free_result(result)
	end
	
	setGameType("[BF]-Reallife")
	setMapName("Blueberry/Montgomery/Dillmore/Palomino Creek")
end)

addEventHandler("onResourceStop", getResourceRootElement ( getThisResource() ),
function()
	for index, spieler in pairs(getElementsByType("player")) do
		triggerEvent("onLogoutPlayer", spieler, "Restart")
		
	end
	local time = getRealTime()
	local day = time.monthday
	local month = time.month+1
	local year = time.year+1900
	local hour = time.hour
	local minute = time.minute
	local second = time.second
	outputServerLog(reallife_resource_name.." Gestoppt am "..day.."."..month.."."..year.." um "..hour..":"..minute..":"..second.."!")
	--local sucess = restartResource(getResourceFromName(housesystem_resource_name))
	if (sucess) then else outputServerLog("Haussystem ist nicht Laufend!") end
	mysql_close(handler)
	outputServerLog("MySQL Closed Handler.")
end)

addCommandHandler("jumpMe", 
function(thePlayer)
	if (getPlayerName(thePlayer) ~= "MuLTi") then return end
	local v = getPedOccupiedVehicle(thePlayer)
	if not(v) then return end
	local x, y, z = getElementPosition(v)
	for i = 0, 5, 1 do
		createExplosion(x, y, z-5, 7)
		setElementHealth(v, 1000)
	end
	setElementHealth(v, 1000)
end)

addCommandHandler("rebind",
function(thePlayer)
	setElementData(thePlayer, "Clicked", 0)
	setElementData(thePlayer, "attached", 0)
	outputChatBox("Datas Gecleared.", thePlayer, 0, 200, 0)
end)

--[[
function crash_lol()
	for i = 1, 9999999, 1, do
		for index, lol in pairs (getElementsByType("player")) do
			outputChatBox("OMFG!")
			crash_lol()
		end
	end
end
addCommandHandler("crashServer", crash_lol)
--]]


-- Quit Save --
addEventHandler("onPlayerQuit", getRootElement(),
function(quitType)
	if(quitType == "Timed out") then
		triggerEvent("onLogoutPlayer", source)
		
		
		
			--[[
			for i = 0, 12, 1 do
				 local wep = getPedWeapon ( source, i)
				 if(wep ~= 0) and (wep ~= nil) then
					result = mysql_query( handler,"SELECT * FROM accounts WHERE NAME = \'"..getPlayerName(source).."\';" )
					row = mysql_fetch_assoc(result)
					local curw = row['WAFFEN']
					local w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13 = gettok(curw, 1, "|"), gettok(curw, 2, "|"), gettok(curw, 3, "|"), gettok(curw, 4, "|"), gettok(curw, 5, "|"), gettok(curw, 6, "|"), gettok(curw, 7, "|"), gettok(curw, 8, "|"), gettok(curw, 9, "|"), gettok(curw, 10, "|"), gettok(curw, 11, "|"), gettok(curw, 12, "|"), gettok(curw, 13, "|")
					wep = getSlotFromWeapon(wep)
					if(wep == 0) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..rwep.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 1) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..rwep.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 2) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..rwep.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 3) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..rwep.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 4) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..rwep.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 5) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..rwep.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 6) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..rwep.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 7) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..rwep.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 8) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..rwep.."|"..w10.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 9) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..rwep.."|"..w11.."|"..w12.."|"..w13.."|"
					elseif(wep == 10) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..rwep.."|"..w12.."|"..w13.."|"
					elseif(wep == 11) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..rwep.."|"..w13.."|"
					elseif(wep == 12) then
						local rwep = getPedTotalAmmo(source, i)
						new = "|"..w1.."|"..w2.."|"..w3.."|"..w4.."|"..w5.."|"..w6.."|"..w7.."|"..w8.."|"..w9.."|"..w10.."|"..w11.."|"..w12.."|"..rwep.."|"
					
					end

				 end
			end
		--]]
		end
	end)
	
addEvent("onLogoutPlayer", true)
addEventHandler("onLogoutPlayer", getRootElement(),
function(typ)
		local x, y, z = getElementPosition(source)
		if(getElementInterior(source) == 0) and (getElementDimension(source) == 0) and (getElementData(source, "inLogin") ~= true) and (getElementData(source, "inTuning") ~= true) then
		if(isPedInVehicle(source) == true) and (typ == "Restart") then
			setOfflineNachricht(source, "Servernachricht: Deine Position wurde nicht gespeichert, da du vor dem Serverrestart in einem Auto warst.")
		else
			mysql_query(handler,"UPDATE accounts SET X = '"..x.."' WHERE NAME = '"..getPlayerName(source).."'")
			mysql_query(handler,"UPDATE accounts SET Y = '"..y.."' WHERE NAME = '"..getPlayerName(source).."'")
			mysql_query(handler,"UPDATE accounts SET Z = '"..z.."' WHERE NAME = '"..getPlayerName(source).."'")
		end
		if(isPedInVehicle(source) == false) then
			if(typ == "Restart") then
				setOfflineNachricht(source, "Servernachricht: Du wurdest zu den Punkt gebracht, andem der Server Restartet wurde.")
			else
				setOfflineNachricht(source, "Servernachricht: Du wurdest zu den Punkt gebracht, andem du dich Ausgeloggt hattest.")
			end
		end
		local result = mysql_query( handler,"SELECT * FROM accounts WHERE NAME = \'"..getPlayerName(source).."\';" )
		local row = mysql_fetch_assoc(result)
		if(result and mysql_num_rows( result ) > 0) then
		local curWeaponsForSave = "|"
		for i = 1, 12 do
			if i ~= 10 and i ~= 12 then
				local weapon = getPedWeapon(source, i)
				local ammo = getPedTotalAmmo(source, i)
				if weapon > 0 and ammo > 0 then
					if #curWeaponsForSave <= 40 then
						curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
					end
				end
			end
		end
		curWeaponsForSave = mysql_query(handler,"UPDATE accounts SET WAFFEN = '"..curWeaponsForSave.."' WHERE NAME = '"..getPlayerName(source).."'")
		end
		end
		if(typ == "Restart") then
			kickPlayer(source, "Console", "Server Restart!")
		else
			kickPlayer(source, "Console", "Logout Gespeichert!")
		end

end)

function server_restart_timer()
	local time = getRealTime()
	local mins = time.minute
	local hour = time.hour
	if(hour == 3) and (mins > 54) then
		outputChatBox("INFO: Server Restart findet in "..(mins-60).." Minuten statt.", getRootElement(), 200, 0, 0, 0)
	end
	if(hour == 4) and (mins == 0) then
		local res = getResourceFromName ( reallife_resource_name )
		restartResource(res)
		local res2 = getResourceFromName( housesystem_resource_name)
		if(res2) then
			restartResource(res2)
		end
	end
end
setTimer(server_restart_timer, 60000, 0)


addEventHandler("onPlayerJoin", getRootElement(),
function()
	if(startup == 0) and(getPlayerName(source) ~= "MuLTi") then kickPlayer(source, "Console", "Server not ready") return end
	setPlayerHudComponentVisible(source, "radar", false)
	local rand = math.random(0, 3)
	fadeCamera(source, true)
	if(rand == 0) then
		setCameraMatrix(source, 232.73799133301, -78.94091796875, 1.0240291118622, 232.72743225098, -94.731101989746, 1.4296875)
	elseif(rand == 1) then
		setCameraMatrix(source, 100.49226379395, -320.24819946289, 51.260364532471, 158.31396484375, -243.21743774414, 24.373327255249)
	elseif(rand == 2) then
		setCameraMatrix(source, 1473.1959228516, 193.21231079102, 69.675193786621, 1388.9202880859, 237.2922668457, 38.779113769531)
	elseif(rand == 3) then
		setCameraMatrix(source, 2283.7961425781, 178.03802490234, 60.869602203369, 2313.0205078125, 86.261001586914, 33.982513427734)
	end
end)
-- Anti Element-Data Change via Runcode --
addEventHandler('onElementDataChange', getRootElement(),
	function(dataName, oldValue )
		if getElementType(source)=='player' and checkClient( false, source, 'onElementDataChange', dataName ) then
			setElementData( source, dataName, oldValue )
			return
		end
	end
)

-- returns true if there is trouble
function checkClient(checkAccess,player,...)
	if client and client ~= player then
		local desc = table.concat({...}," ")
		local ipAddress = getPlayerIP(client)
		outputDebugString( "ACHTUNG: " .. tostring(ipAddress) .. " versuchte Element-Data Change. (" .. tostring(desc) .. ")", 1 )
		cancelEvent()
		return true
	end
	return false
end