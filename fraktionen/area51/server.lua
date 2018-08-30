local gate = {}
local lift = {}
local gatetime = {}
local gatestatus = {}
local lifttime = {}
local liftstatus = {}
local key = {}
local atm = createObject(2942, 249.5, 1858.8000488281, 13.69999980926, 0, 0, 270)

addCommandHandler("arm", function(thePlayer)
	if(isACop(thePlayer) == false) then outputChatBox("Du hast keine Berechtigung, diesen Befehl zu benutzen.", thePlayer, 200, 0, 0) return end
	if(isPedInVehicle(thePlayer) == false) then outputChatBox("Du musst in einem Waffen-faehigen Fahrzeug sitzen!", thePlayer, 200, 0, 0) return end
	if(getElementData(getPedOccupiedVehicle(thePlayer), "armcar") ~= true) then outputChatBox("Du musst in einem Waffen-faehigen Fahrzeug sitzen!", thePlayer, 200, 0, 0) return end
	giveWeapon(thePlayer, 31, 250, true)
	giveWeapon(thePlayer, 22, 250)
	giveWeapon(thePlayer, 45, 1)
	giveWeapon(thePlayer, 46, 1)
	if(getPlayerFraktionsrang(thePlayer) > 4) then
		giveWeapon(thePlayer, 6, 1)
	end
end)

-- KEYS and GATES --

lift[1] = createObject(971, 285.8994140625, 1817.8994140625, 16.700000762939, 89.747436523438, 180, 180) -- Lift 1 Zu STartbahn hin
lift[2] = createObject(971, 285.8994140625, 1823.5, 16.700000762939, 89.747436523438, 180, 180) -- Lift 2 davon
key[1] = createObject(2886, 286, 1827.69921875, 18.60000038147, 0, 0, 90) -- Key dazu
key[2] = createObject(2886, 281.5, 1826.7998046875, 18.5, 0, 0, 0.4) -- Key dazu
liftstatus[1] = false -- unten
lifttime[1] = false

lift[3] = createObject(971, 135.69921875, 1944.8994140625, 18.39999961853, 90, 180, 180) -- Lift 2, von der Strasse
lift[4] = createObject(971, 135.69921875, 1937.7998046875, 18.299999237061, 90, 180, 180)
key[3] = createObject(2886, 123.7998046875, 1936.7998046875, 19.60000038147, 0, 0, 90)
key[4] = createObject(2886, 127.5, 1941.2998046875, 19.700000762939, 0, 0, 180)
liftstatus[2] = false -- unten
lifttime[2] = false

gate[1] = createObject(969, 96.69921875, 1925, 17.10000038147, 0, 0, 268) -- Gate 1, vom anfang hin 
key[5] = createObject(2886, 96.7998046875, 1922.19921875, 20.700000762939, 0, 0, 270)
key[6] = createObject(2886, 96.69921875, 1918.5, 20.700000762939, 0, 0, 90)
gatestatus[1] = false -- zu
gatetime[1] = false

gate[2] = createObject(16773, 214.5, 1875.7998046875, 11.699999809265, 0, 0, 180) -- Eingang zum Innenraum
key[7] = createObject(2886, 218, 1876.3994140625, 13.699999809265, 0, 0, 276)
key[8] = createObject(2886, 217.8994140625, 1875.099609375, 13.5, 0, 0, 276)

gatestatus[2] = false -- zu
gatetime[2] = false

gate[3] = createObject(2951, 226.5, 1872.8994140625, 12.6, 0, 0, 270) -- Eingang zum Innenraum 2, drinne
key[9] = createObject(2886, 226.3994140625, 1870.8994140625, 14.10000038147, 0, 0, 270)
key[10] = createObject(2886, 228.19921875, 1870.8994140625, 13.89999961853, 0, 0, 176)

gatestatus[3] = false -- zu
gatetime[3] = false

gate[4] = createObject(2951, 233.19921875, 1822.7998046875, 6.4000, 0, 0, 270) -- Eingang zum Kontrollraum
key[11] = createObject(2886, 233.7998046875, 1821.2998046875, 7.5, 0, 0, 90)
key[12] = createObject(2886, 233.099609375, 1824.2998046875, 7.6999998092651, 0, 0, 270)

gatestatus[4] = false -- zu
gatetime[4] = false

gate[5] = createObject(16773, 286.599609375, 1953.8994140625, 19.10000038147, 0, 0, 270) -- Hangar 1
gate[6] = createObject(16773, 286.599609375, 1957.7998046875, 19.10000038147, 0, 0, 270) -- Hangar 1
key[13] = createObject(2886, 286.599609375, 1946, 18.799999237061, 0, 0, 90)

gatestatus[5] = false -- zu
gatetime[5] = false

gate[7] = createObject(16773, 286.5, 1987.599609375, 19.10000038147, 0, 0, 270) -- Hangar 2
gate[8] = createObject(16773, 286.5, 1991.69921875, 19.10000038147, 0, 0, 270) -- Hangar 2
key[14] = createObject(2886, 286.69921875, 1979.8994140625, 18.39999961853, 0, 0, 90)

gatestatus[6] = false -- zu
gatetime[6] = false

gate[9] = createObject(16773, 286.599609375, 2021.7998046875, 19.1000000, 0, 0, 270) -- Hangar 3
gate[10] = createObject(16773, 286.5999, 2025.7998046875, 19.10000038147, 0, 0, 270) -- Hangar 3
key[15] = createObject(2886, 286.69921875, 2014.099609375, 18.200000762939, 0, 0, 90)

gatestatus[7] = false -- zu
gatetime[7] = false
-- ATM --
addEvent("onArmySkinChange", true)
addEventHandler("onArmySkinChange", getRootElement(), function()
	if(getElementModel(source) ~= 312) then
		setElementModel(source, 312)
	else
		setElementModel(source, 287)
	end
end)


addEvent("onArmyClassLeave", true)
addEventHandler("onArmyClassLeave", getRootElement(), function()
	setElementData(source, "class", nil)
	takeWeapon(source, 31)
	takeWeapon(source, 22)
	takeWeapon(source, 4)
	takeWeapon(source, 45)
	if(getPlayerFraktionsrang(source) > 4) then
		takeWeapon(source, 36)
		takeWeapon(source, 34)
	end
	outputChatBox("Du hast die Klasse verlassen.", source, 0, 200, 0)
	setElementModel(source, getElementData(source, "pSkin"))
end)

addEvent("onArmyClassAusrueste", true)
addEventHandler("onArmyClassAusrueste", getRootElement(), function()
	setElementData(source, "class", "army")
	giveWeapon(source, 31, 475, true)
	giveWeapon(source, 22, 500, true)
	giveWeapon(source, 4, 1)
	giveWeapon(source, 45, 1)
	if(getPlayerFraktionsrang(source) > 4) then
		giveWeapon(source, 36, 10, true)
		giveWeapon(source, 34, 10, true)
	end
	outputChatBox("Du hast dich Ausgeruestet.", source, 0, 200, 0)
end)

addEventHandler("onElementClicked", atm,
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		triggerClientEvent(thePlayer, "onArmyATMStart", thePlayer)
	end
end)

-- Gate 9 --

addEventHandler("onElementClicked", key[15],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[7] == true) then return end
		if(gatestatus[7] == false) then
			gatestatus[7] = true
			gatetime[7] = true
			local x, y, z = getElementPosition(gate[9])
			moveObject(gate[9], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(gate[10])
			moveObject(gate[10], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[7] = false end, 2000, 1)
		else
			gatestatus[7] = false
			gatetime[7] = true
			local x, y, z = getElementPosition(gate[9])
			moveObject(gate[9], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			local x, y, z = getElementPosition(gate[10])
			moveObject(gate[10], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			setTimer(function() gatetime[7] = false end, 4000, 1)
		end
	end
	
end)

-- Gate 7 --

addEventHandler("onElementClicked", key[14],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[6] == true) then return end
		if(gatestatus[6] == false) then
			gatestatus[6] = true
			gatetime[6] = true
			local x, y, z = getElementPosition(gate[7])
			moveObject(gate[7], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(gate[8])
			moveObject(gate[8], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[6] = false end, 2000, 1)
		else
			gatestatus[6] = false
			gatetime[6] = true
			local x, y, z = getElementPosition(gate[7])
			moveObject(gate[7], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			local x, y, z = getElementPosition(gate[8])
			moveObject(gate[8], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			setTimer(function() gatetime[6] = false end, 4000, 1)
		end
	end
	
end)

-- Gate 5 --

addEventHandler("onElementClicked", key[13],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[5] == true) then return end
		if(gatestatus[5] == false) then
			gatestatus[5] = true
			gatetime[5] = true
			local x, y, z = getElementPosition(gate[5])
			moveObject(gate[5], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(gate[6])
			moveObject(gate[6], 2000, x, y, z-10, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[5] = false end, 2000, 1)
		else
			gatestatus[5] = false
			gatetime[5] = true
			local x, y, z = getElementPosition(gate[5])
			moveObject(gate[5], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			local x, y, z = getElementPosition(gate[6])
			moveObject(gate[6], 4000, x, y, z+10, 0, 0, 0, "OutBounce", 1.0, 0.5)
			setTimer(function() gatetime[5] = false end, 4000, 1)
		end
	end
	
end)

-- Gate 4 --

addEventHandler("onElementClicked", key[12],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[4] == true) then return end
		if(gatestatus[4] == false) then
			gatestatus[4] = true
			gatetime[4] = true
			local x, y, z = getElementPosition(gate[4])
			moveObject(gate[4], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[4] = false end, 1000, 1)
		else
			gatestatus[4] = false
			gatetime[4] = true
			local x, y, z = getElementPosition(gate[4])
			moveObject(gate[4], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[4] = false end, 1000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[11],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[4] == true) then return end
		if(gatestatus[4] == false) then
			gatestatus[4] = true
			gatetime[4] = true
			local x, y, z = getElementPosition(gate[4])
			moveObject(gate[4], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[4] = false end, 1000, 1)
		else
			gatestatus[4] = false
			gatetime[4] = true
			local x, y, z = getElementPosition(gate[4])
			moveObject(gate[4], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[4] = false end, 1000, 1)
		end
	end
	
end)

-- Gate 3 --
addEventHandler("onElementClicked", key[10],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[3] == true) then return end
		if(gatestatus[3] == false) then
			gatestatus[3] = true
			gatetime[3] = true
			local x, y, z = getElementPosition(gate[3])
			moveObject(gate[3], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[3] = false end, 1000, 1)
		else
			gatestatus[3] = false
			gatetime[3] = true
			local x, y, z = getElementPosition(gate[3])
			moveObject(gate[3], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[3] = false end, 1000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[9],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[3] == true) then return end
		if(gatestatus[3] == false) then
			gatestatus[3] = true
			gatetime[3] = true
			local x, y, z = getElementPosition(gate[3])
			moveObject(gate[3], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[3] = false end, 1000, 1)
		else
			gatestatus[3] = false
			gatetime[3] = true
			local x, y, z = getElementPosition(gate[3])
			moveObject(gate[3], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[3] = false end, 1000, 1)
		end
	end
	
end)

-- Gate 2-- 

addEventHandler("onElementClicked", key[8],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[2] == true) then return end
		if(gatestatus[2] == false) then
			gatestatus[2] = true
			gatetime[2] = true
			local x, y, z = getElementPosition(gate[2])
			moveObject(gate[2], 1000, x, y, z-6, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[2] = false end, 1000, 1)
		else
			gatestatus[2] = false
			gatetime[2] = true
			local x, y, z = getElementPosition(gate[2])
			moveObject(gate[2], 1000, x, y, z+6, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[2] = false end, 1000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[7],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[2] == true) then return end
		if(gatestatus[2] == false) then
			gatestatus[2] = true
			gatetime[2] = true
			local x, y, z = getElementPosition(gate[2])
			moveObject(gate[2], 1000, x, y, z-6, 0, 0, 0, "InOutQuad")
			setTimer(function()gatetime[2] = false end, 1000, 1)
		else
			gatestatus[2] = false
			gatetime[2] = true
			local x, y, z = getElementPosition(gate[2])
			moveObject(gate[2], 1000, x, y, z+6, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[2] = false end, 1000, 1)
		end
	end
	
end)

-- Gate 1 --

addEventHandler("onElementClicked", key[6],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[1] == true) then return end
		if(gatestatus[1] == false) then
			gatestatus[1] = true
			gatetime[1] = true
			local x, y, z = getElementPosition(gate[1])
			moveObject(gate[1], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[1] = false end, 1000, 1)
		else
			gatestatus[1] = false
			gatetime[1] = true
			local x, y, z = getElementPosition(gate[1])
			moveObject(gate[1], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[1] = false end, 1000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[5],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(isACop(thePlayer) == false) then return end
		if(gatetime[1] == true) then return end
		if(gatestatus[1] == false) then
			gatestatus[1] = true
			gatetime[1] = true
			local x, y, z = getElementPosition(gate[1])
			moveObject(gate[1], 1000, x, y, z-4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[1] = false end, 1000, 1)
		else
			gatestatus[1] = false
			gatetime[1] = true
			local x, y, z = getElementPosition(gate[1])
			moveObject(gate[1], 1000, x, y, z+4, 0, 0, 0, "InOutQuad")
			setTimer(function() gatetime[1] = false end, 1000, 1)
		end
	end
	
end)

-- Lift 2 --

addEventHandler("onElementClicked", key[4],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 30) then return end
		if(isACop(thePlayer) == false) then return end
		if(lifttime[2] == true) then return end
		if(liftstatus[2] == false) then
			liftstatus[2] = true
			lifttime[2] = true
			local x, y, z = getElementPosition(lift[3])
			moveObject(lift[3], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[4])
			moveObject(lift[4], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[2] = false end, 3000, 1)
		else
			liftstatus[2] = false
			lifttime[2] = true
			local x, y, z = getElementPosition(lift[3])
			moveObject(lift[3], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[4])
			moveObject(lift[4], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[2] = false end, 3000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[3],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 30) then return end
		if(isACop(thePlayer) == false) then return end
		if(lifttime[2] == true) then return end
		if(liftstatus[2] == false) then
			liftstatus[2] = true
			lifttime[2] = true
			local x, y, z = getElementPosition(lift[3])
			moveObject(lift[3], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[4])
			moveObject(lift[4], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[2] = false end, 3000, 1)
		else
			liftstatus[2] = false
			lifttime[2] = true
			local x, y, z = getElementPosition(lift[3])
			moveObject(lift[3], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[4])
			moveObject(lift[4], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[4] = false end, 3000, 1)
		end
	end
	
end)

-- Lift 1 --
addEventHandler("onElementClicked", key[1],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 30) then return end
		if(isACop(thePlayer) == false) then return end
		if(lifttime[1] == true) then return end
		if(liftstatus[1] == false) then
			liftstatus[1] = true
			lifttime[1] = true
			local x, y, z = getElementPosition(lift[1])
			moveObject(lift[1], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[2])
			moveObject(lift[2], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[1] = false end, 3000, 1)
		else
			liftstatus[1] = false
			lifttime[1] = true
			local x, y, z = getElementPosition(lift[1])
			moveObject(lift[1], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[2])
			moveObject(lift[2], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[1] = false end, 3000, 1)
		end
	end
	
end)

addEventHandler("onElementClicked", key[2],
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 30) then return end
		if(isACop(thePlayer) == false) then return end
		if(lifttime[1] == true) then return end
		if(liftstatus[1] == false) then
			liftstatus[1] = true
			lifttime[1] = true
			local x, y, z = getElementPosition(lift[1])
			moveObject(lift[1], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[2])
			moveObject(lift[2], 3000, x, y, z+7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[1] = false end, 3000, 1)
		else
			liftstatus[1] = false
			lifttime[1] = true
			local x, y, z = getElementPosition(lift[1])
			moveObject(lift[1], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			local x, y, z = getElementPosition(lift[2])
			moveObject(lift[2], 3000, x, y, z-7, 0, 0, 0, "InOutQuad")
			setTimer(function() lifttime[1] = false end, 3000, 1)
		end
	end
	
end)