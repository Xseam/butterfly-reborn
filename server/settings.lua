handler = mysql_connect ( "127.0.0.1", "root", "", "bf" ) -- Globale Verbindung


if not(handler) then
	handler = mysql_connect ( "localhost", "root", "", "bfreallife" ) -- Alternative Verbindung, wenn die Globale Verbindung nicht da ist
end

housesystem_resource_name = "bf-housesystem"
reallife_resource_name = "bfreallife"

function setOfflineNachricht(thePlayer, nachricht)
	if(type(thePlayer) == "string") then
		if(isElement(getPlayerFromName(thePlayer))) then
			outputChatBox(nachricht, getPlayerFromName(thePlayer), 200, 200, 0)
		else
			mysql_query(handler,"UPDATE accounts SET OFFLINEMSG = '"..nachricht.."' WHERE NAME = '"..thePlayer.."'")
		end
	else
		if(isElement(thePlayer)) then
			outputChatBox(nachricht, thePlayer, 200, 200, 0)
		else
			mysql_query(handler,"UPDATE accounts SET OFFLINEMSG = '"..nachricht.."' WHERE NAME = '"..getPlayerName(thePlayer).."'")
		end
	end
end


local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setElementFrozen(thePlayer, true)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		fadeCamera(thePlayer, true)
		if not(typ) then
			setElementFrozen(thePlayer, false)
		else
			if(typ == true)  then
				setTimer(setElementFrozen, 1000, 1, thePlayer, false)
			end
		end
		end, 1000, 1)
end





function o_removePedFromVehicle(thePlayer) -- Total Scheisse --
	if not(thePlayer) then return end
	if not(getElementType(thePlayer) == "player") then return end
	local state = getPedOccupiedVehicleSeat ( thePlayer)
	if(state == 0) or (state == 2) then
		removePedFromVehicle(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		setElementPosition(thePlayer, x, y-1, z)
		setTimer(setPedAnimation, 500, 1, thePlayer, "ped", "CAR_getout_LHS", 1000, false, true, true)
	else
		removePedFromVehicle(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		setElementPosition(thePlayer, x, y+1, z)
		setTimer(setPedAnimation, 500, 1, thePlayer, "ped", "CAR_getout_RHS", 1000, false, true, true)	
	end
end

function getWeaponSlotMuniMats(weapon)
	local muni = 0
		if(weapon == getWeaponIDFromName("Colt 45")) then muni = 34 end
		if(weapon == getWeaponIDFromName("Deagle")) then muni = 14 end
		if(weapon == getWeaponIDFromName("Shotgun")) then muni = 5 end
		if(weapon == getWeaponIDFromName("MP5")) then muni = 50 end
		if(weapon == getWeaponIDFromName("AK-47")) then muni = 50 end
		if(weapon == getWeaponIDFromName("Knife")) then muni = 1 end
		if(weapon == getWeaponIDFromName("Rifle")) then muni = 5 end
	return muni;
end

function giveVehicleBetterEngine(theVehicle)
	if(getElementType(theVehicle) == "vehicle") then
		setVehicleHandling(theVehicle, "engineAcceleration", (getVehicleHandling(theVehicle)['engineAcceleration']+5))
		setVehicleHandling(theVehicle, "maxVelocity", (getVehicleHandling(theVehicle)['maxVelocity']+15))
	end
end

function giveVehiclePanzerung(theVehicle)
	if(getElementType(theVehicle) == "vehicle") then
		if(tonumber(getVehicleHandling(theVehicle)['collisionDamageMultiplier']) < 0.3) then setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0) else
			setVehicleHandling(theVehicle, "collisionDamageMultiplier", (getVehicleHandling(theVehicle)['collisionDamageMultiplier']-0.3))
		end
	end
end