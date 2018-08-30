
function onStart_func() 
	for i = 1, 100, 1 do
		outputChatBox("", 255, 255, 255, false)
	end
	fadeCamera(true)
	setCameraTarget(gMe, gMe)
	setOcclusionsEnabled ( false )
	local txt = engineLoadTXD ( "data/carmods/newsvan.txd" )
	--local dff = engineLoadDFF ( "data/carmods/swat.dff", 285 )
	--engineReplaceModel ( dff, 285 )
	engineImportTXD ( txt, 582)
	setBirdsEnabled ( true )
	local x, y = guiGetScreenSize()
	if(x <= 1024 ) and ( y <= 768 ) then 
		outputChatBox("Warnung! Du Besitzt eine Niedrige Aufloesung. GUI's und Texte koennen bei dir falsch Dargestellt sein!", 255, 0, 0, false)
	end
	
	local shader = dxCreateShader("data/shader.fx")
	dxSetShaderValue(shader,"Tex",dxCreateTexture("data/images/radar.png"))
	engineApplyShaderToWorldTexture(shader,"radardisc")
	setTimer(function()
		outputConsole("sounds: "..#getElementsByType("sound"))
		outputConsole("players: "..#getElementsByType("player"))
		outputConsole("objects: "..#getElementsByType("object"))
		outputConsole("vehicles: "..#getElementsByType("vehicle"))
	end, 1000, 1)
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onStart_func )

function txd_1 ()
	skintxd = engineLoadTXD( "data/carmods/swat.txd" ) 
	engineImportTXD( skintxd, 285 )
end 
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), txd_1 )

function dff_1 ()

	skindff = engineLoadDFF( "data/carmods/swat.dff", 285 ) 
	engineReplaceModel ( skindff, 285 )

end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), dff_1 )

function on_damage_func ( attacker, weapon, body, loss)
	if(attacker) then
		if(getElementType(attacker) == "vehicle") and (getVehicleType(attacker) == "Helicopter") then cancelEvent() end
	end
end
addEventHandler ( "onClientPlayerDamage", getRootElement(), on_damage_func )
-- Blood --
--[[
local pedsTrue = {}
local pedsBone = {}
local pedsTimer = {}
local pedsPos = {}

addEventHandler("onClientRender", getRootElement(),
function()
	for index, playa in pairs(getElementsByType("ped")) do
		if(pedsTrue[playa]) then
			if(pedsTrue[playa] == true) then
				--local bone = pedsBone[playa]


				if(bone == 3) then bonep = 4 end
				if(bone == 4) then bonep = 0 end
				if(bone == 5) then bonep = 33 end
				if(bone == 6) then bonep = 23 end
				if(bone == 7) then bonep = 42 end
				if(bone == 8) then bonep = 52 end
				
				if(bonep == 0) then return end
				local x, y, z = getPedBonePosition(playa, bonep)
				
				fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)
				fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)
				fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)

				for index, posi in pairs(pedsBone[playa]) do
					local bonep = 0
					local bone = posi
					if(bone == 3) then bonep = 4 end
					if(bone == 4) then bonep = 0 end
					if(bone == 5) then bonep = 33 end
					if(bone == 6) then bonep = 23 end
					if(bone == 7) then bonep = 42 end
					if(bone == 8) then bonep = 52 end
					if(bonep == 0) then return end
					local x, y, z = getPedBonePosition(playa, bonep)
				
					fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)
					fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)
					fxAddBlood(x, y, z, 0, 0.2, 0.5, 2.5)
				end
			end
		end
	end

end)
--]]

function drawPedBlood(ped, bone)
	local x, y, z = getPedBonePosition(ped, bone)
	fxAddBlood(x, y, z, 0, 0.2, 0.5, 3.5)
	fxAddBlood(x, y, z, 0, 0.2, 0.5, 3.5)
	fxAddBlood(x, y, z, 0, 0.2, 0.5, 3.5)
end
local bodyparts = {}

addEventHandler("onClientPlayerDamage", getRootElement(),
function(attacker, weapon, body, loss)
	if(attacker) and (getElementType(attacker) == "player") and (weapon ~= 0) then
		if not(bodyparts[source]) then bodyparts[source] = {} end
		local bonep = 0
		if(body == 3) then bonep = 3 end
		if(body == 4) then bonep = 0 end
		if(body == 5) then bonep = 33 end
		if(body == 6) then bonep = 23 end
		if(body == 7) then bonep = 42 end
		if(body == 8) then bonep = 52 end
		if(body == 9) then bonep = 8 end
		if(bonep == 0) then return end
		local opfer = source
		if(bodyparts[opfer][body] == true) then return end
		bodyparts[opfer][body] = true
		setTimer(function() bodyparts[opfer][body] = false end, 4000, 1)
		setTimer(function()
			drawPedBlood(opfer, bonep)
		end, 50, 50)
		
	end
end)


-- Spielzeit --
function add_spielzeit ()
	if not(getElementData( gMe, "pSpielzeit" ) == nil) then
		
		if(getElementData(gMe, "inLogin") == true) then return end
		hours = tonumber(gettok ( getElementData(gMe, "pSpielzeit"), 1, ":" ))
		minutes = tonumber(gettok ( getElementData(gMe, "pSpielzeit"), 2, ":" ))
	
		if (minutes > 58) then
		
			hours = hours+1
				
			setElementData ( gMe, "pSpielzeit", hours..":00" )
			triggerServerEvent("onPaydayStart", gMe)
			outputConsole(hours..":"..minutes)
		else
			minutes = minutes+1	
			setElementData ( gMe, "pSpielzeit", hours..":"..minutes)
		
		end
	end
				
end

setTimer ( add_spielzeit, 60000, 0 )

addEvent("onVehicleXPExplode", true)
addEventHandler("onVehicleXPExplode", getRootElement(),
function(x, y, z)
	setTimer(	function()
		createExplosion(x, y, z, 7, true, -1.5, false)
		setTimer(createExplosion, 125, 1, x, y, z+5, 7, true, -1.5, false)
		setTimer(createExplosion, 250, 1, x, y, z+10, 7, true, -1.5, false)
		setTimer(createExplosion, 375, 1, x, y, z+15, 7, true, -1.5, false)
		createExplosion(x, y-1, z, 1, true, -1.5, false)

			
		end, 100, 1)
end)


local logutvar = 30
local logouttimer

function save_check_timer()
	if(logoutvar == 5) or (logoutvar == 10) or (logoutvar == 15) or (logoutvar == 20) or (logoutvar == 25) or (logoutvar == 30) then
		outputChatBox("Du wirst Ausgeloggt. Bitte Warte noch "..logoutvar.." Sekunden.", 0, 200, 200)
	else
		if(logoutvar < 1) then
			triggerServerEvent("onLogoutPlayer", gMe)
		end
	end
	
	logoutvar = logoutvar-1
end
function save_quit_func2()
	logoutvar = 30
	killTimer(logouttimer)
	outputChatBox("Speichern abgebrochen.", 200, 0, 0, false)
	removeEventHandler("onClientKey", getRootElement(), save_quit_func2)
end

function save_quit_func()
	logoutvar = 30
	killTimer(logouttimer)
	outputChatBox("Speichern abgebrochen.", 200, 0, 0, false)
end
function save_func(cmd)
	if(isTimer(logouttimer)) then
		save_quit_func()
		return
	else
		if(getElementData(gMe, "inLogin") == true) then return end
		if(getElementData(gMe, "inTuning") == true) then return end
		logoutvar = 30
		logouttimer = setTimer(save_check_timer, 1000, 35)
		outputChatBox("Du loggst dich aus! Bitte Warte 30 Sekunden.", 0, 200, 200)
		setTimer(
			function()
			addEventHandler("onClientKey", getRootElement(), save_quit_func2) 
		end, 1000, 1)
	end
end

addCommandHandler("getout", save_func)

local erlaubteStatus = {
	["Anfaenger"] = true,
	["Buerger"] = true,
	["Immigrant"] = true
}

function removeMyStatus()
	outputChatBox("Du hast dein Status "..getElementData(gMe, "pStatus").." Verloren. Dein Status wurde auf Anfaenger gesetzt!", 255, 0, 0)
	setElementData(gMe, "pStatus", "Anfaenger")
end

function statusCheck()
	if(getElementData(gMe, "inLogin") == true) then return end
	local status = getElementData(gMe, "pStatus")
	if(erlaubteStatus[status]) then return end
	-- staten --
	if(status == "Member") then
		if(getPlayerFraktion(gMe) == 0) then
			removeMyStatus()
		end
	end
	
	if(status == "Aufsteiger") then
		if(getPlayerFraktion(gMe) == 0) or (getPlayerFraktionsrang(gMe) < 2) then
			removeMyStatus()
		end
	end
	
	if(status == "Anfuehrer") then
		if(getPlayerFraktion(gMe) == 0) or (getPlayerFraktionsrang(gMe) < 5) then
			removeMyStatus()
		end
	end
	if(status == "Bombenleger") then
		if(getPlayerFraktion(gMe) ~= 2) then
			removeMyStatus()
		end
	end
	if(status == "Finanzchecker") then
		if(tonumber(getElementData(gMe, "pBGeld")) < 500000) then
			removeMyStatus()
		end
	end
	
	if(status == "Millionaer") then
		if(tonumber(getElementData(gMe, "pBGeld")) < 1000000) then
			removeMyStatus()
		end
	end
	if(status == "Multimillionaer") then
		if(tonumber(getElementData(gMe, "pBGeld")) < 5000000) then
			removeMyStatus()
		end
	end
	if(status == "Milliardaer") then
		if(tonumber(getElementData(gMe, "pBGeld")) < 1000000) then
			removeMyStatus()
		end
	end
	if(status == "Fachkraft") then
		if(getPlayerAdminlevel(gMe) < 1) then
			removeMyStatus()
		end
	end
	if(status == "Sicherheitsmaster") then
		if(getPlayerAdminlevel(gMe) < 4) then
			removeMyStatus()
		end
	end
end

setTimer(statusCheck, 10000, 0)

setTimer(function() -- Chatbox input
	if(isChatBoxInputActive()) then
		if(getElementData(gMe, "writing") == true) then else
			setElementData(gMe, "writing", true)
		end
	else
		if(getElementData(gMe, "writing") == false) then else
			setElementData(gMe, "writing", false)
		end
	end
end, 250, 0)
local altx, alty, altz = 0, 0, 0
local warns = 0

setTimer(function() -- AFK Check
	if(altx == 0) and (alty == 0) then
		altx, alty, altz = getElementPosition(gMe)
	else
		local x, y, z = getElementPosition(gMe)
		if(x == altx) and (y == alty) and (z == altz) then
			warns = warns+1
			if(warns > 1) then
				if(getElementData(gMe, "idle") == true) then else
					setElementData(gMe, "idle", true)
				end
			end
		else
			warns = 0
			altx, alty, altz = 0, 0, 0
			if(getElementData(gMe, "idle") == false) then else
					setElementData(gMe, "idle", false)
			end
		end
	end
end, 5000, 0)

addEventHandler("onClientKey", getRootElement(),
function(key)
		if(getElementData(gMe, "idle") == true) then
			setElementData(gMe, "idle", false)
		end
end)