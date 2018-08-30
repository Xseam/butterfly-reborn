local Bombmarker = createMarker(-845.70709228516, -854.49255371094, 149.640625, "corona", 2.5, 200, 0, 0, 255)
local Hifi = createObject(2099, -801.91461181641, -829.03546142578, 147.6828125, 0, 0, 230)
addEventHandler( "onElementClicked", getRootElement(),
function ( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if(source == Hifi) then
		triggerClientEvent("onHifiClickedTerror", thePlayer)
		end
	end
end	) 

addEventHandler("onMarkerHit", Bombmarker,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if not(getPlayerFraktion(hitElement) == 2) then return end
	outputChatBox("Tippe /bombshop ein, um dieses Fahrzeug mit einer Bombe auszustatten. Beachte: Du kannst sie nichtmehr ausbauen.", hitElement, 0, 255, 0, false)
end)
bombvar = {}

addCommandHandler("bombshop", 
function(thePlayer)
	if not(getPlayerFraktion(thePlayer) == 2) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D(x, y, z, -845.70709228516, -854.49255371094, 149.640625) > 5) then return end
	local veh = getPedOccupiedVehicle(thePlayer)
	if not(veh) then return end
	outputChatBox("Bombe wird eingebaut...", thePlayer, 0, 200, 0)
	setElementFrozen(veh, true)
	setTimer(
		function()
		outputChatBox("Bombe wurde eingebaut! Benutze das Clicksystem und klicke auf das Auto, um die Bombe hochgehen zu lassen!", thePlayer, 0, 255, 0)
		setElementData(veh, "vehbomb", true)
		setElementData(thePlayer, "canTriggerBomb", true)
		setElementFrozen(veh, false)
		end, 3000, 1)
end)


function check_bomb( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if (getElementType(source) == "vehicle") then
			if(getElementData(source, "vehbomb") == true) then
				if(getElementData(thePlayer, "canTriggerBomb") == true) then
				local x, y, z = getElementPosition(source)
				local theVeh = source
				triggerClientEvent("onClientSoundPos", thePlayer, x, y, z, "sounds/countdown.mp3")
				setTimer( function()
				createExplosion(x, y, z, 0)
					setTimer(
					function()
					createExplosion(x, y, z, 0)
					createExplosion(x, y, z, 1)
					createExplosion(x, y, z, 7)
				end, 250, 1)
				setElementData(theVeh, "vehbomb", false)
				setElementData(thePlayer, "canTriggerBomb", false)
				end, 3500, 1)
				end
			end
		end
	end
end	
		
addEventHandler( "onElementClicked", getRootElement(), check_bomb ) 

addCommandHandler("bombe",
function(thePlayer, cmd, level)
	if not(getPlayerFraktion(thePlayer) == 2) then return end
	local level = tonumber(level)
	if(level == 1) then
		if(bombvar[thePlayer] == 1) then
			bombvar[thePlayer] = 0
			outputChatBox("Bombe entschaerft!", thePlayer, 0, 200, 0, false)
		else
			outputChatBox("Du hast keine Bombe!", thePlayer, 200, 0, 0, false)
		end
	elseif(level == 0) or (level == nil) then
		if(bombvar[thePlayer] == 0) or (bombvar[thePlayer] == nil) then
			bombvar[thePlayer] = 1
			outputChatBox("Bombe Scharf! Nutze den Command noch einmal, um zu Zuenden!", thePlayer, 200, 0, 0, false)
		elseif(bombvar[thePlayer] == 1) then
			bombvar[thePlayer] = 0
			local x, y, z = getElementPosition(thePlayer)
			if not(x) or not(y) or not(z) then return end
			triggerClientEvent("onClientSoundPos", thePlayer, x, y, z, "sounds/countdown.mp3")
			setTimer( function()
			createExplosion(x, y, z, 0, thePlayer)
				setTimer(
				function()
				createExplosion(x, y, z, 0, thePlayer)
				createExplosion(x, y, z, 1, thePlayer)
				createExplosion(x, y, z, 7, thePlayer)
			end, 500, 1)
		end, 3500, 1)
		end
	end

end)

--[[

addCommandHandler("bombe",
function(thePlayer, cmd, level)
	if not(getPlayerFraktion(thePlayer) == 2) then return end
	local level = tonumber(level)
	outputChatBox("1")
	if(level == nil) then
	outputChatBox("2")
	if(tonumber(getElementData(thePlayer, "Bombe") == nil)) then
	outputChatBox("3")
		outputChatBox("Bombe bereitgemacht! Benutze den Command nocheinmal, um zu zuenden.", thePlayer, 255, 0, 0, false)
		setElementData(thePlayer, "Bombe", 1)
	elseif(getElementData(thePlayer, "Bombe") == 1) then
	outputChatBox("4")
		local x, y, z = getElementPosition(thePlayer)
		if not(x) or not(y) or not(z) then return end
		createExplosion(x, y, z, 0, thePlayer)
		setTimer(
			function()
			createExplosion(x, y, z, 0, thePlayer)
			createExplosion(x, y, z, 1, thePlayer)
			createExplosion(x, y, z, 7, thePlayer)
			end, 500, 1)
	end	
	outputChatBox("5")
	elseif(level == 0) then
		if(getElementData(thePlayer, "Bombe") == 1) then
		outputChatBox("6")
			setElementData(thePlayer, "Bombe", nil)
			outputChatBox("Bombe entschaerft.", thePlayer, 0, 200, 0, false) 
		else outputChatBox("Du hast keine bombe bereitet.", thePlayer, 200, 0, 0, false) return end
	end
end)
--]]

addCommandHandler("equip",
function(thePlayer, cmd, level)
	if not(getPlayerFraktion(thePlayer) == 2) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D(x, y, z, -780.24273681641, -833.07971191406, 149.08235168457) > 7) then return end
	if(getPlayerMoney(thePlayer) < 501) then outputChatBox("Du brauchst 500$.", thePlayer, 200, 0, 0) return end
	takeAllWeapons(thePlayer)
	setElementData(thePlayer, "pHGeld", getElementData(thePlayer, "pHGeld")-500)
	if(level == nil) or (level == 0) then
	giveWeapon ( thePlayer, 4 , 1 )
	giveWeapon ( thePlayer, 24 , 100 )
	giveWeapon ( thePlayer, 25 , 100 )
	giveWeapon ( thePlayer, 28 , 2500 )
	giveWeapon ( thePlayer, 31 , 500 )
	giveWeapon ( thePlayer, 34 , 50 )
	giveWeapon ( thePlayer, 35 , 10, true )
	giveWeapon ( thePlayer, 39 , 10 )
	elseif(level == 1) then
	giveWeapon ( thePlayer, 4 , 1 )
	giveWeapon ( thePlayer, 24 , 100 )
	giveWeapon ( thePlayer, 25 , 100 )
	giveWeapon ( thePlayer, 28 , 2500 )
	giveWeapon ( thePlayer, 31 , 500 )
	giveWeapon ( thePlayer, 34 , 50 )
	giveWeapon ( thePlayer, 35 , 10, true )
	giveWeapon ( thePlayer, 17 , 10 )
	elseif(level == 2) then
	giveWeapon ( thePlayer, 4 , 1 )
	giveWeapon ( thePlayer, 24 , 100 )
	giveWeapon ( thePlayer, 25 , 100 )
	giveWeapon ( thePlayer, 28 , 2500 )
	giveWeapon ( thePlayer, 31 , 500 )
	giveWeapon ( thePlayer, 34 , 50 )
	giveWeapon ( thePlayer, 38 , 500, true )
	giveWeapon ( thePlayer, 18 , 10 )	
	end
end)

addCommandHandler("tie",
function(thePlayer, command, target)
	if not(getPlayerFraktion(thePlayer) == 2) then return end
	if not(target) then return end
	local target = getPlayerFromName(target)
	if not (target) then outputChatBox("Ungueltiger Spieler!", thePlayer, 200, 0, 0, false)  return end
	local x, y, z = getElementPosition(target)
	local x1, y1, z1 = getElementPosition(thePlayer)
	if(target == thePlayer) then outputChatBox("Du kannst dich nicht fesseln/entfesseln!", thePlayer, 200, 0, 0, false) return end
	if(isPedInVehicle(target)) then else outputChatBox("Der Spieler muss in einem Auto sitzen!", thePlayer, 200, 0, 0) return end
	if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then outputChatBox("Du bist zu weit Weg!", thePlayer, 200, 0, 0, false) return end
	if(getElementData(target, "tied") == true) then
		fadeCamera(target, true, 0)
		toggleAllControls(target, true)
		setElementData(target, "tied", nil)
		setPlayerMuted(target, true)
		outputChatBox("Du wurdest entfesselt.", target, 0, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde entfesselt", thePlayer, 0, 200, 0, false)
	else
		fadeCamera(target, false, 0)
		toggleAllControls(target, false)
		setElementData(target, "tied", true)
		setPlayerMuted(target, false)
		outputChatBox("Du wurdest Gefesselt!", target, 255, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde gefesselt!", thePlayer, 0, 200, 0, false)
	end
	
end
)