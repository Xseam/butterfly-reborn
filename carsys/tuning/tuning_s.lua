local motorpreis = 550
local panzerungspreis = 2000
local gpspreis = 150

addEvent("onTuningGarageEinfahr", true)
addEventHandler("onTuningGarageEinfahr", getRootElement(),
function()
	local dim = getFreeDimension("player")
	local veh = getPedOccupiedVehicle(source)

	setElementDimension(source, dim)
	setElementDimension(veh, dim)
	setElementPosition(veh, -2028.9090576172, 146.8821105957, 28.46498298645)
	setElementRotation(veh, 0, 0, 260)
	setElementVelocity(veh, 0, 0, 0)
	setElementCollisionsEnabled(veh, false)
	setElementFrozen(veh, true)
	setElementData(source, "curDim", dim)
	setCameraMatrix(source, -2023.0321044922, 149.13999938965, 30, getElementPosition(veh))
	triggerClientEvent(source, "onTuningSetVar", source)
	if(getVehicleType(veh) == "Bike") then
		local playa = source
		setTimer(function()
			warpPedIntoVehicle(playa, veh, 1)
		end, 100, 2)
	end
end)

addEvent("onTuningMenueAbbrechen", true)
addEventHandler("onTuningMenueAbbrechen", getRootElement(),
function()
	local veh = getPedOccupiedVehicle(source)
	triggerClientEvent(getRootElement(), "onGhostmodeSet", source, veh)
	setElementDimension(source, 0)
	setElementDimension(veh, 0)
	setElementPosition(veh, 329.88626098633, -53.986976623535, 1.3253111362457)
	setElementRotation(veh, 0, 0, 0)
	setElementVelocity(veh, 0, 0, 0)
	setCameraTarget(source, source)
	setElementCollisionsEnabled(veh, true)
	setTimer(setElementFrozen, 1000, 1, veh, false)
	local data = getElementData(veh, "fTunings")
	for i = 0, 16, 1 do
		local upgrade = getVehicleUpgradeOnSlot ( veh, i )
		removeVehicleUpgrade(veh, upgrade)

		local tok = i+1
		local tun = tonumber(gettok(data, tok, "|"))
		if(tun == 0) or (tun == nil) then else
			addVehicleUpgrade(veh, tun)
		end
	end
end)





function getFreeDimension()
	local rand = math.random(1, 600000)
	for index, player in pairs(getElementsByType("player")) do
		if(getElementInterior(player) == rand) then 
			getFreeDimension()
		else
			return rand;
		end
	end
end


addEvent("onSpecialTuningTeilKauf", true)
addEventHandler("onSpecialTuningTeilKauf", getRootElement(),
function(veh, typ)
	if(typ == "Motor") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))
		setElementData(veh, "fTuningsspec", "|1|"..tuning2.."|"..tuning3.."|")
		setVehicleHandling(veh, "engineAcceleration", (getVehicleHandling(veh)['engineAcceleration']+5))
		setVehicleHandling(veh, "maxVelocity", (getVehicleHandling(veh)['maxVelocity']+15))
		outputChatBox("Du hast das Teil erfolgreich gekauft! Dein Fahrzeug ist nun schneller.", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-motorpreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
	elseif(typ == "Panzerung") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))
		setElementData(veh, "fTuningsspec", "|"..tuning1.."|1|"..tuning3.."|")
		if(tonumber(getVehicleHandling(veh)['collisionDamageMultiplier']) < 0.3) then setVehicleHandling(veh, "collisionDamageMultiplier", 0) else
			setVehicleHandling(veh, "collisionDamageMultiplier", (getVehicleHandling(veh)['collisionDamageMultiplier']-0.3))
		end
		outputChatBox("Du hast das Teil erfolgreich gekauft! Dein Fahrzeug verliert nun bei Kollisionen weniger Schaden.", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-panzerungspreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
	elseif(typ == "GPS") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))
		setElementData(veh, "fTuningsspec", "|"..tuning1.."|"..tuning2.."|1|")
		outputChatBox("Du hast das Teil erfolgreich gekauft! Du Siehst nun dein Auto auf der Karte.", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-gpspreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
		setElementData(veh, "fGPS", true)
	end
end)
addEvent("onSpecialTuningTeilVerkauf", true)
addEventHandler("onSpecialTuningTeilVerkauf", getRootElement(),
function(veh, typ)
	if(typ == "Motor") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))

		setElementData(veh, "fTuningsspec", "|0|"..tuning2.."|"..tuning3.."|")
		setVehicleHandling(veh, "engineAcceleration", getOriginalHandling(getElementModel(veh))['engineAcceleration'])
		setVehicleHandling(veh, "maxVelocity", getOriginalHandling(getElementModel(veh))['maxVelocity'])
		outputChatBox("Du hast das Teil erfolgreich verkauft, und "..motorpreis.."$ bekommen!", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))+motorpreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
	elseif(typ == "Panzerung") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))
		setElementData(veh, "fTuningsspec", "|"..tuning1.."|0|"..tuning3.."|")
		setVehicleHandling(veh, "collisionDamageMultiplier", getOriginalHandling(getElementModel(veh))['collisionDamageMultiplier'])
		outputChatBox("Du hast das Teil erfolgreich verkauft, und "..panzerungspreis.."$ bekommen!", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))+panzerungspreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
	elseif(typ == "GPS") then
		local tuning1, tuning2, tuning3 = tonumber(gettok(getElementData(veh, "fTuningsspec"), 1, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 2, "|")), tonumber(gettok(getElementData(veh, "fTuningsspec"), 3, "|"))
		setElementData(veh, "fTuningsspec", "|"..tuning1.."|"..tuning2.."|0|")
		outputChatBox("Du hast das Teil erfolgreich verkauft.", source, 0, 200, 0)
		setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))+gpspreis)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
		setElementData(veh, "fGPS", false)
	end
end)
addEvent("onTuningTeilVerkauf", true)
addEventHandler("onTuningTeilVerkauf", getRootElement(),
function(veh, part, preis)
	removeVehicleUpgrade(veh, part)
	setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))+preis)
		local t = {}
		for i = 0, 16, 1 do
			t[i] = getVehicleUpgradeOnSlot(veh, i)
		end
		local tuning = "|"
		tuning = tuning..t[0].."|"
		tuning = tuning..t[1].."|"
		tuning = tuning..t[2].."|"
		tuning = tuning..t[3].."|"
		tuning = tuning..t[4].."|"
		tuning = tuning..t[5].."|"
		tuning = tuning..t[6].."|"
		tuning = tuning..t[7].."|"
		tuning = tuning..t[8].."|"
		tuning = tuning..t[9].."|"
		tuning = tuning..t[10].."|"
		tuning = tuning..t[11].."|"
		tuning = tuning..t[12].."|"
		tuning = tuning..t[13].."|"
		tuning = tuning..t[14].."|"
		tuning = tuning..t[15].."|"
		tuning = tuning..t[16].."|"
		setElementData(veh, "fTunings", tuning)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
		outputChatBox("Du hast dir das Teil erfolgreich Verkauft und "..preis.."$ bekommen!", source, 0, 200, 0)
end)

addEvent("onTuningTeilKauf", true)
addEventHandler("onTuningTeilKauf", getRootElement(),
function(veh, part, preis, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16)
	addVehicleUpgrade(veh, part)
	setElementData(source, "pHGeld", tonumber(getElementData(source, "pHGeld"))-preis)
		local tuning = "|"
		if t0 == false then t0 = 0 else addVehicleUpgrade ( veh, t0 ) end
		tuning = tuning..t0.."|"
		if t1 == false then t1 = 0 else addVehicleUpgrade ( veh, t1 ) end
		tuning = tuning..t1.."|"
		if t2 == false then t2 = 0 else addVehicleUpgrade ( veh, t2 ) end
		tuning = tuning..t2.."|"
		if t3 == false then t3 = 0 else addVehicleUpgrade ( veh, t3 ) end
		tuning = tuning..t3.."|"
		if t4 == false then t4 = 0 else addVehicleUpgrade ( veh, t4 ) end
		tuning = tuning..t4.."|"
		if t5 == false then t5 = 0 else addVehicleUpgrade ( veh, t5 ) end
		tuning = tuning..t5.."|"
		if t6 == false then t6 = 0 else addVehicleUpgrade ( veh, t6 ) end
		tuning = tuning..t6.."|"
		if t7 == false then t7 = 0 else addVehicleUpgrade ( veh, t7 ) end
		tuning = tuning..t7.."|"
		if t8 == false then t8 = 0 else addVehicleUpgrade ( veh, t8 ) end
		tuning = tuning..t8.."|"
		if t9 == false then t9 = 0 else addVehicleUpgrade ( veh, t9 ) end
		tuning = tuning..t9.."|"
		if t10 == false then t10 = 0 else addVehicleUpgrade ( veh, t10 ) end
		tuning = tuning..t10.."|"
		if t11 == false then t11 = 0 else addVehicleUpgrade ( veh, t11 ) end
		tuning = tuning..t11.."|"
		if t12 == false then t12 = 0 else addVehicleUpgrade ( veh, t12 ) end
		tuning = tuning..t12.."|"
		if t13 == false then t13 = 0 else addVehicleUpgrade ( veh, t13 ) end
		tuning = tuning..t13.."|"
		if t14 == false then t14 = 0 else addVehicleUpgrade ( veh, t14 ) end
		tuning = tuning..t14.."|"
		if t15 == false then t15 = 0 else addVehicleUpgrade ( veh, t15 ) end
		tuning = tuning..t15.."|"
		if t16 == false then t16 = 0 else addVehicleUpgrade ( veh, t16 ) end
		tuning = tuning..t16.."|"
		setElementData(veh, "fTunings", tuning)
		triggerClientEvent(source, "onPlayerTuningUpdate", source, getElementModel(veh))
		outputChatBox("Du hast dir das Teil erfolgreich gekauft!", source, 0, 200, 0)
end)