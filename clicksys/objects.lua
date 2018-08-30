local maxObjects = 12
local respawnDelay = 10
local ped = createPed(73, 168.99253845215, -32.629245758057, 1.578125)
setPedRotation(ped, 271)
setElementFrozen(ped, true)

addEventHandler("onElementClicked", getRootElement(),
function(but, stat, thePlayer)
	if source == ped and but == "left" and stat == "down" then
		triggerClientEvent(thePlayer, "onVerkaeuferObjektClick", thePlayer)
	end
end)


local woodSpawns = {
	[1] = "260.25, -36.450000762939, 0.60, 0, 0, 170", 
	[2] = "218.58000183105, -31.549999237061, 0.5799999833107, 0, 0, 170", 
	[3] = "222.07000732422, -163.86000061035, 0.5799999833107, 0, 0, 170", 
	[4] = "162.72999572754, -221.42999267578, 0.5799999833107, 0, 0, 170", 
	[5] = "144.88999938965, -155.13999938965, 0.5799999833107, 0, 0, 260", 
	[6] = "308, -132.25, 0.5799999833107, 0, 0, 350",
	[7] = "1294.3100585938, 284.80999755859, 18.549999237061, 0, 0, 350",
	[8] = "1377.0100097656, 422.91000366211, 18.770000457764, 0, 0, 250",
	[9] = "691.44000244141, -589.15997314453, 15.329999923706, 0, 0, 250",
	[10] = "663.58001708984, -578.09997558594, 15.340000152588, 0, 0, 350",
	[11] = "629.54998779297, -520.90002441406, 15.340000152588, 0, 0, 350",
	[12] = "711.08001708984, -472.9700012207, 15.340000152588, 0, 0, 260"
}-- ID: 1462

local pcSpawns = {
	[1] = "115.86000061035, -192.7200012207, 0.47999998927116, 0, 0, 30",
	[2] = "155.05999755859, -61.380001068115, 2.0799999237061, 0, 0, 30",
	[3] = "1240.7099609375, 336.45001220703, 18.549999237061, 0, 0, 150",
	[4] = "1410.3900146484, 326.98001098633, 20.590000152588, 0, 0, 290",
	[5] = "1364.7099609375, 197.24000549316, 22.229999542236, 0, 0, 119",
	[6] = "1214.7800292969, 217.28999328613, 18.889999389648, 0, 0, 10",
	[7] = "662.09002685547, -552.30999755859, 17.510000228882, 0, 0, 200",
	[8] = "643.53997802734, -613.98999023438, 16.829999923706, 0, 0, 199",
	[9] = "732.25, -602.52001953125, 16.319999694824, 0, 0, 300",
	[10] = "1053.2900390625, -316.29998779297, 72.98999786377, 0, 0, 300",
	[11] = "2317.5300292969, -1.5900000333786, 27.040000915527, 0, 0, 300",
	[12] = "2541.9699707031, 109.55999755859, 25.479999542236, 0, 0, 300"
} --id: 2190

local kistenSpawns = {
	[1] = "673.02001953125, -503.5, 15.340000152588, 0, 0, 0", 
	[2] = "729.60998535156, -601.52001953125, 15.340000152588, 0, 0, 30", 
	[3] = "632.15002441406, -580.67999267578, 15.34, 0, 0, 50", 
	[4] = "120.88999938965, -200.2200012207, 0.55000001192093, 0, 0, 50", 
	[5] = "251.52000427246, -45.450000762939, 0.58999997377396, 0, 0, 100", 
	[6] = "269.55999755859, -144.13999938965, 0.57, 0, 0, 100", 
	[7] = "200, -267.98999023438, 0.57, 0, 0, 100", 
	[8] = "-117.94000244141, -96.019996643066, 2.1199998855591, 0, 0, 100", 
	[9] = "-264.04998779297, -262.20001220703, 0.97000002861023, 0, 0, 100", 
	[10] = "1254.8399658203, 195.7200012207, 18.549999237061, 0, 0, 100", 
	[11] = "1423.5100097656, 315.86999511719, 18.049999237061, 0, 0, 100", 
	[12] = "1083.2600097656, 578.60998535156, 19.229999542236, 0, 0, 100"

}-- ID: 3798

local moneySpawns = {
	[1] = "338.29998779297, -61.779998779297, 0.91000002622604, 0, 0, 0",
	[2] = "-151.49000549316, -230.46000671387, 2, 0, 0, 0",
	[3] = "-73.230003356934, -1180.1700439453, 1.1599999666214, 0, 0, 0"
}-- ID: 1550

local feuerSpawns = {
	[1] = "-54.369998931885, -230.19000244141, 6.1199998855591, 0, 0, 0", 
	[2] = "100.36000061035, -167.88999938965, 1.9299999475479, 0, 0, 0", 
	[3] = "254.11000061035, -52.459999084473, 0.93999999761581, 0, 0, 0", 
	[4] = "304.32000732422, -228.69999694824, 2, 0, 0, 0",
	[5] = "1244.1800537109, 324.26000976563, 19.870000839233, 0, 0, 0",
	[6] = "1288.25, 270.30999755859, 18.909999847412, 0, 0, 0",
	[7] = "2304.8999023438, 29.629999160767, 25.840000152588, 0, 0, 0",
	[8] = "2283.3200683594, -50.409999847412, 27.540000915527, 0, 0, 0",
	[9] = "680.41998291016, -473.39999389648, 15.89999961853, 0, 0, 0",
	[10] = "628.32000732422, -573.65997314453, 17.569999694824, 0, 0, 80",
	[11] = "855.90002441406, -598.76000976563, 17.780000686646, 0, 0, 0",
	[12] = "1076, -291.05999755859, 73.339996337891, 0, 0, 0"
}-- ID: 2690

function slowDestroyElement(element)
	if(isElement(element) ~= true) then return end
	local oVar = 1
	local oTimer = setTimer(
		function()
			oVar = oVar+1
			if(oVar < 0) then return end
			if(oVar > 18) then destroyElement(element) oVar = -100 return end
			setElementAlpha(element, getElementAlpha(element)-15)
		end, 50, 20)
end
function respawnFeuer(x, y, z, rotx, roty, rotz)
	local object = createObject(2690, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(getElementData(source, "clicked") == true) then return end
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pFeuer", tonumber(getElementData(thePlayer, "pFeuer"))+1)
				outputChatBox("Du hast einen Feuerloescher gefunden, und hebst ihn auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnFeuer, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end
function respawnComputer(x, y, z, rotx, roty, rotz)
	local object = createObject(2190, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pComputer", tonumber(getElementData(thePlayer, "pComputer"))+1)
				outputChatBox("Du hast einen Computer gefunden, und hebest ihn auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnComputer, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function respawnKiste(x, y, z, rotx, roty, rotz)
	local object = createObject(3798, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pKisten", tonumber(getElementData(thePlayer, "pKisten"))+1)
				outputChatBox("Du hast eine Kiste gefunden, und hebest sie auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnKiste, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function respawnWood(x, y, z, rotx, roty, rotz)
	local object = createObject(1462, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pBretter", tonumber(getElementData(thePlayer, "pBretter"))+1)
				outputChatBox("Du hast einige Bretter gefunden, und hebest sie auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnWood, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end
function createPCObject(index)
	local x, y, z, rotx, roty, rotz = gettok(pcSpawns[index], 1, ","), gettok(pcSpawns[index], 2, ","), gettok(pcSpawns[index], 3, ","), gettok(pcSpawns[index], 4, ","), gettok(pcSpawns[index], 5, ","), gettok(pcSpawns[index], 6, ",")
	local object = createObject(2190, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pComputer", tonumber(getElementData(thePlayer, "pComputer"))+1)
				outputChatBox("Du hast einen PC gefunden, und hebest ihn auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnComputer, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function createWoodObject(index)
	local x, y, z, rotx, roty, rotz = gettok(woodSpawns[index], 1, ","), gettok(woodSpawns[index], 2, ","), gettok(woodSpawns[index], 3, ","), gettok(woodSpawns[index], 4, ","), gettok(woodSpawns[index], 5, ","), gettok(woodSpawns[index], 6, ",")
	local object = createObject(1462, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pBretter", tonumber(getElementData(thePlayer, "pBretter"))+1)
				outputChatBox("Du hast einige Bretter gefunden, und hebest sie auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnWood, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function createKistenObject(index)
	local x, y, z, rotx, roty, rotz = gettok(kistenSpawns[index], 1, ","), gettok(kistenSpawns[index], 2, ","), gettok(kistenSpawns[index], 3, ","), gettok(kistenSpawns[index], 4, ","), gettok(kistenSpawns[index], 5, ","), gettok(kistenSpawns[index], 6, ",")
	local object = createObject(3798, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pKisten", tonumber(getElementData(thePlayer, "pKisten"))+1)
				outputChatBox("Du hast eine Kiste gefunden, und hebest sie auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnKiste, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end
function respawnMoneyBag(x, y, z, rotx, roty, rotz)
	local object = createObject(1550, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				local randmoney = math.random(1000, 5000)
				setElementData(thePlayer, "pHGeld", tonumber(getElementData(thePlayer, "pHGeld"))+randmoney)
				outputChatBox("Du hast eine Tasche voller Geld gefunden! Du oeffnest sie, und findest "..randmoney.."$!", thePlayer, 255, 255, 0, false)
				setTimer(respawnMoneyBag, respawnDelay+10*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function createMoneyBagobject(index)
	local x, y, z, rotx, roty, rotz = gettok(moneySpawns[index], 1, ","), gettok(moneySpawns[index], 2, ","), gettok(moneySpawns[index], 3, ","), gettok(moneySpawns[index], 4, ","), gettok(moneySpawns[index], 5, ","), gettok(moneySpawns[index], 6, ",")
	local object = createObject(1550, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				local randmoney = math.random(1000, 5000)
				setElementData(thePlayer, "pHGeld", tonumber(getElementData(thePlayer, "pHGeld"))+randmoney)
				outputChatBox("Du hast eine Tasche voller Geld gefunden! Du oeffnest sie, und findest "..randmoney.."$!", thePlayer, 255, 255, 0, false)
				setTimer(respawnMoneyBag, respawnDelay+10*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

function createFeuerObject(index)
	local x, y, z, rotx, roty, rotz = gettok(feuerSpawns[index], 1, ","), gettok(feuerSpawns[index], 2, ","), gettok(feuerSpawns[index], 3, ","), gettok(feuerSpawns[index], 4, ","), gettok(feuerSpawns[index], 5, ","), gettok(feuerSpawns[index], 6, ",")
	local object = createObject(2690, x, y, z, rotx, roty, rotz)
	setElementData(object, "OX", x)
	setElementData(object, "OY", y)
	setElementData(object, "OZ", z)
	setElementData(object, "ORX", rotx)
	setElementData(object, "ORY", roty)
	setElementData(object, "ORZ", rotz)
	setElementData(object, "O_PICKUPABLE", true)
	addEventHandler("onElementClicked", object,
	function(mouse, button, thePlayer)	
		if(mouse == "left") and (button == "down") then
				if(isPedInVehicle(thePlayer) == true) then return end
				if(getElementData(thePlayer, "oClick") == true) then return end
				if(getElementData(source, "clicked") == true) then return end
				setElementData(thePlayer, "oClick", true)
				setTimer(setElementData, 2000, 1, thePlayer, "oClick", false)
				local x, y, z, rotx, roty, rotz = getElementData(source, "OX"), getElementData(source, "OY"), getElementData(source, "OZ"), getElementData(source, "ORX"), getElementData(source, "ORY"), getElementData(source, "ORZ")
				setElementData(source, "clicked", true)
				slowDestroyElement(source)
				setElementData(thePlayer, "pFeuer", tonumber(getElementData(thePlayer, "pFeuer"))+1)
				outputChatBox("Du hast einen Feuerloescher gefunden, und hebst ihn auf!", thePlayer, 255, 255, 0, false)
				setTimer(respawnFeuer, respawnDelay*60*1000, x, y, z, rotx, roty, rotz)
		end
	end)
end

for i = 1, maxObjects, 1 do
	createWoodObject(i)
	createKistenObject(i)
	createPCObject(i)
	createFeuerObject(i)
end
for i = 1, #moneySpawns, 1 do
	local rand = math.random(0, 1)
	if(rand == 0) then
		createMoneyBagobject(i)
	end
end