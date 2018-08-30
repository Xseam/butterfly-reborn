local Gate = createObject(980, 356.88000488281, -1786.0300292969, 3.25, 0, 90, 0)
local Gateoffen = false
local Gatevar = 0
local Key1 = createObject(2886, 353.64001464844, -1786.0100097656, 6.3600001335144, 0, 0, 180)
local Key2 = createObject(2886, 353.63000488281, -1786.7399902344, 6.3000001907349, 0, 0, 0)
local col = createColSphere(321.23092651367, -1800.1088867188, 4.6639537811279, 50)

local obs = {}

addEventHandler("onElementClicked", Key2,
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(getPlayerFraktion(thePlayer) == 1) or (getPlayerFraktion(thePlayer) == 2) or (getPlayerFraktion(thePlayer) == 6) then else return end
		if(Gatevar == 1) then return end
		if(Gateoffen == false) then
			Gatevar = 1
			Gateoffen = true
			setTimer(function() Gatevar = 0 end, 2000, 1)
			local x, y, z = getElementPosition(Gate)
			moveObject(Gate, 2000, x, y, z-5, 0, 0, 0, "InOutQuad")
		else
			Gatevar = 1
			Gateoffen = false
			setTimer(function() Gatevar = 0 end, 2000, 1)
			local x, y, z = getElementPosition(Gate)
			moveObject(Gate, 2000, x, y, z+5, 0, 0, 0, "InOutQuad")
		end
	end
	
end)
addEventHandler("onColShapeLeave", col, function(hitElement)
	if(getElementType(hitElement) == "player") then
		if(getElementData(hitElement, "shooting") == true) then
			setElementData(hitElement, "shooting", false)
			takeWeapon(hitElement, getElementData(hitElement, "shootwep"))
			setElementData(hitElement, "shootwep", nil)
			outputChatBox("Du hast die Schiessuebung Beendet.", hitElement, 0, 255, 255)
		end
	end
end)
addEventHandler("onElementClicked", Key1,
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(getPlayerFraktion(thePlayer) == 1) or (getPlayerFraktion(thePlayer) == 2) or (getPlayerFraktion(thePlayer) == 6) then else return end
		if(Gatevar == 1) then return end
		if(Gateoffen == false) then
			Gatevar = 1
			Gateoffen = true
			setTimer(function() Gatevar = 0 end, 2000, 1)
			local x, y, z = getElementPosition(Gate)
			moveObject(Gate, 2000, x, y, z-5, 0, 0, 0,"InOutQuad")
		else
			Gatevar = 1
			Gateoffen = false
			setTimer(function() Gatevar = 0 end, 2000, 1)
			local x, y, z = getElementPosition(Gate)
			moveObject(Gate, 2000, x, y, z+5, 0, 0, 0, "InOutQuad")
		end
	end
	
end)
-- Objects --
function recreateObjectsShoot()
	for i = 1, #obs, 1 do
		if(isElement(obs[i])) then
			destroyElement(obs[i])
		end
	end
	obs[1] = createObject(1950, 312.57998657227, -1808.6600341797, 5.1300001144409)
	obs[2] = createObject(1950, 312.39999389648, -1806.5400390625, 5.039999961853)
	obs[3] = createObject(1950, 312.51000976563, -1807.4599609375, 5.1300001144409)
	obs[4] = createObject(1950, 311.66000366211, -1806.9200439453, 5.1300001144409)
	obs[5] = createObject(1950, 312.5693359375, -1808.4091796875, 5.1300001144409)
	obs[6] = createObject(1950, 312.57000732422, -1807.8399658203, 5.1300001144409)
	obs[7] = createObject(1950, 311.89999389648, -1807.1600341797, 5.1300001144409)
	obs[8] = createObject(1950, 311.7200012207, -1810.8800048828, 6.5300002098083)
	obs[9] = createObject(1950, 306.70999145508, -1804.6199951172, 5.2399997711182)
	obs[10] = createObject(1950, 306.60998535156, -1803.8900146484, 5.2399997711182)
	obs[11] = createObject(1950, 306.42999267578, -1802.3499755859, 5.25)
	obs[12] = createObject(1950, 305.32000732422, -1797.9499511719, 5.0999999046326)
	obs[13] = createObject(1950, 305.13000488281, -1796.9100341797, 5.0999999046326)
	obs[14] = createObject(1950, 306.0299987793, -1796.3599853516, 5.0999999046326)
	obs[15] = createObject(1950, 306.63000488281, -1794.5300292969, 5.1199998855591)
	obs[16] = createObject(1950, 306.48999023438, -1793.4699707031, 5.1199998855591)
	obs[17] = createObject(1950, 301.76000976563, -1813.8800048828, 5.0100002288818)
	obs[18] = createObject(1950, 298.07998657227, -1810.4899902344, 5.6100001335144)
	obs[19] = createObject(1950, 298.48999023438, -1809.6099853516, 5.6100001335144)
	obs[20] = createObject(1950, 297.38000488281, -1803.9799804688, 5.6199998855591)
	obs[21] = createObject(1950, 296.35000610352, -1803.4399414063, 5.6199998855591)
	obs[22] = createObject(1950, 295.64999389648, -1806.2099609375, 5.6199998855591)
	obs[23] = createObject(1950, 291.86999511719, -1815.3900146484, 4.9400000572205)
	obs[24] = createObject(1950, 292.82000732422, -1814.1199951172, 4.9400000572205)
	obs[25] = createObject(1950, 292.51000976563, -1813.3199462891, 4.9400000572205)
	obs[26] = createObject(1950, 280.11999511719, -1813.2299804688, 6.4400000572205)
	obs[27] = createObject(1950, 279.7799987793, -1812.2800292969, 6.4400000572205)
	obs[28] = createObject(1950, 281.23999023438, -1812.9699707031, 4.9499998092651)
	obs[29] = createObject(1950, 281.26000976563, -1811.5999755859, 4.9499998092651)
	obs[30] = createObject(1950, 279.20999145508, -1810.2199707031, 4.9899997711182)
	obs[31] = createObject(1950, 279.88000488281, -1814.5400390625, 4.9000000953674)
	obs[32] = createObject(1950, 286.25, -1795.2600097656, 6.4699997901917)
	obs[33] = createObject(1950, 286.5, -1794.3199462891, 6.4699997901917)
	obs[34] = createObject(1950, 287.58999633789, -1792.9899902344, 5.0100002288818)
	obs[35] = createObject(1950, 287.79000854492, -1791.7399902344, 5.0100002288818)
	obs[36] = createObject(1950, 287, -1796.4300537109, 5.0300002098083)
	obs[37] = createObject(1950, 285.83999633789, -1796.6999511719, 5.0300002098083)
	obs[38] = createObject(1950, 285.07000732422, -1797.7700195313, 5.0300002098083)
	obs[39] = createObject(1950, 285.08999633789, -1790.5100097656, 6.4699997901917)
	obs[40] = createObject(1950, 284.95001220703, -1789.1199951172, 6.4699997901917)
	obs[41] = createObject(1950, 292.98001098633, -1790.0699462891, 5.210000038147)
	obs[42] = createObject(1950, 293.70001220703, -1789.6999511719, 5.210000038147)
	obs[43] = createObject(1950, 293.79998779297, -1788.5699462891, 5.210000038147)
	obs[44] = createObject(1950, 295.2200012207, -1789.8000488281, 4.5300002098083)
	obs[45] = createObject(1950, 295.17001342773, -1790.2299804688, 4.5300002098083)
	for i = 1, #obs, 1 do
		local x, y, z = getElementPosition(obs[i])
		setElementPosition(obs[i], x, y, z-1)
		moveObject(obs[i], 2000, x, y, z)
	end
end
addEvent("onSchiesstandRestart", true)
addEventHandler("onSchiesstandRestart", getRootElement(), function()
	recreateObjectsShoot()
	outputChatBox("Ziele werden neu erstellt.", source, 0, 200, 0)
end)

addEvent("onSchiesstandStop", true)
addEventHandler("onSchiesstandStop", getRootElement(), function()
	setElementData(source, "shooting", false)
	takeWeapon(source, getElementData(source, "shootwep"))
	setElementData(source, "shootwep", nil)
	outputChatBox("Du hast die Schiessuebung Beendet.", source, 0, 255, 255)
end)

addEvent("onSchiesstandStart", true)
addEventHandler("onSchiesstandStart", getRootElement(), function(weapon)
	setElementData(source, "shooting", true)
	setElementData(source, "shootwep", weapon)
	giveWeapon(source, weapon, 999999, true)
	outputChatBox("Du hast die Schiessuebung gestartet. Beende sie wieder, indem du nochmal in den Marker gehst.", source, 0, 200, 0)
	fadeCamera(source, false, 1.0, 255, 255, 255)
	local playa = source
	setTimer(fadeCamera, 1000, 1, playa, true)
end)

addEventHandler("onPlayerWasted", getRootElement(), function()
	if(getElementData(source, "shooting") == true) then
		setElementData(source, "shooting", false)
		takeWeapon(source, getElementData(source, "shootwep"))
		setElementData(source, "shootwep", nil)
		outputChatBox("Du hast die Schiessuebung Beendet.", source, 0, 255, 255)
	end
end)