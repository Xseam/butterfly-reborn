--[[local objects_o = {
	[1] = "1345, 216.58999633789, -3.3399999141693, 2.3399999141693, 0, 0, 90",
	[2] = "1345, 217.05000305176, -0.6700000166893, 2.3399999141693, 0, 0, 80",
	[3] = "912, 162.21000671387, -56.349998474121, 1.1399999856949, 0, 0, 80",
	[4] = "913, 162.30000305176, -53.439998626709, 1.4099999666214, 0, 0, 100",
	[5] = "912, 189.1591796875, -138.259765625, 1.1499999761581, 0, 0, 20",
	[6] = "912, 187.72999572754, -139.19000244141, 1.1399999856949, 0, 0, 60",
	[7] = "1439, 144.52000427246, -135.2799987793,  0.5799999833107, 0, 0, 0",
	[8] = "1439, -19.090000152588, -269.42999267578, 4.4299998283386, 0, 0, 0",
	[9] = "1439, 243.83000183105, -11.109999656677, 0.68999999761581, 0, 0, 0",
	[10] = "1349, 217.36000061035, -114.7799987793, 1.1399999856949, 0, 0, 20",
	[11] = "1349, 217, -116.87000274658, 1.1399999856949, 0, 0, 130",
	[12] = "1349, 163.58000183105, -12.010000228882, 1.1499999761581, 0, 0, 250",
	[13] = "1345, 89.51000213623, -171.63000488281, 2.3499999046326, 0, 0, 70",
	[14] = "1347, 284.35998535156, -4.210000038147, 1.9900000095367, 0, 0, 0",
	[15] = "1430, 635.71002197266, -541.79998779297, 15.64999961853, 0, 0, 0",
	[16] = "1430, 635.66998291016, -540.73999023438, 15.64999961853, 0, 0, 0",
	[17] = "1439, 698.39001464844, -608.96002197266, 15.340000152588, 0, 0, 200",
	[18] = "1439, 695.34997558594, -609.40002441406, 15.340000152588, 0, 0, 180",
	[19] = "3035, 705.53002929688, -494.39001464844, 16.110000610352, 0, 0,0",
	[20] = "3035, 702.73999023438, -491.73999023438, 16.110000610352, 0, 0, 310",
	[21] = "2319, 670.05999755859,-588.92999267578, 16.17, 0, 0, 310",
	[22] = "911, 671.03002929688, -590.66998291016, 15.89999961853, 0, 0, 320",
	[23] = "1764, 668.65002441406, -589.13000488281, 15.340000152588, 0, 0, 300",
	[24] = "1721, 668.72998046875, -539.14001464844, 15.340000152588, 0, 0, 30",
	[25] = "1721, 669.73999023438, -538.38000488281, 15.659999847412, 284, 0, 90",
	[26] = "1721, 670.15002441406, -591.55999755859, 15.340000152588, 0, 0, 20",
	[27] = "1721, 189.60000610352, -139.53999328613, 0.58999997377396, 0, 0, 100",
	[28] = "1763, 185.14999389648, -137.80000305176, 0.94999998807907, 274,5, 0, 204",
	[29] = "1737, 177.19000244141, -100.58999633789, 0.55000001192093, 0, 0, 20",
	[30] = "913, 177.61999511719, -99.419998168945, 1.0299999713898, 42.5, 0, 0",
	[31] = "912, 176.17999267578, -100.09999847412, 1.1200000047684, 0, 0, 80",
	[32] = "1439, 180.80000305176, -99.269996643066, 0.54000002145767, 0, 0, 0",
	[33] = "1370, 173.92999267578, -93.040000915527, 4.4400000572205, 0, 0, 0",
	[34] = "1370, 172.7799987793, -93.080001831055, 4.4400000572205, 0, 0, 0",
	[35] = "1370, 173.80999755859, -94.099998474121, 4.4000000, 0, 0, 0",
	[36] = "1349, 171.61999511719, -94.400001525879, 4.4699997901917, 0, 0, 330",
	[37] = "1349, 172.86999511719, -95.589996337891, 4.4699997901917, 0, 0, 50",
	[38] = "1349, 177.85000610352, -102.23999786377, 1.1200000047684, 0, 0, 30",
	[39] = "1349, 181.03999328613, -99.349998474121, 1.9199999570847, 0, 0, 129",
	[40] = "1344, 174.66999816895, -102.30999755859, 0.95999997854233, 88, 0, 336",
	[41] = "1349, 256.7799987793, -65.339996337891, 1.1499999761581, 0, 0, 338",
	[42] = "1439, 260.9700012207, -62.659999847412, 0.5799999833107, 0, 0, 0",
	[43] = "913, 262.60998535156, -63.650001525879, 1.1399999856949, 40, 0, 300",
	[44] = "1764, 260.66000366211, -63.799999237061, 0.5799999833107, 0, 0, 326",
	[45] = "1409, 258.30999755859, -63.299999237061, 0.5799999999999, 0, 0, 0",
	[46] = "1409, 259.44000244141, -63.040000915527, 0.5799999833107, 0, 0, 0",
	[47] = "1748, 258.39999389648, -63.099998474121, 1.6799999475479, 0, 0, 20",
	[48] = "1748, 216.99000549316, -4.75, 1.460000038147, 0, 0, 70",
	[49] = "1748, 188.30000305176, -139.88000488281, 0.5799999833107, 0, 0, 42",
	[50] = "3525, 175.38999938965, -98.019996643066, 1.2699999809265, 0, 0, 0",
}--]]
local objects_o = {
	[1] = "1344, 216.17999267578, -3.3099999427795, 2.3800001144409, 0, 0, 90",
	[2] = "1344, 217.28999328613, 0.37000000476837, 2.3800001144409, 0, 0, 50",
	[3] = "1349, 217.58000183105, -1.789999961853, 1.8899999856949, 271.24993896484, 0, 0, 62",
	[4] = "913, 216.17999267578, 1.8200000524521, 1.9700000286102, 270.75012207031, 0, 0, 18",
	[5] = "913, 261.16000366211, -62.889999389648, 1.4099999666214, 0, 0, 30",
	[6] = "1763, 262.07998657227, -63.490001678467, 0.5799999833107, 0, 0, 0",
	[7] = "1439, 265.14001464844, -62.060001373291, 1.0800000429153, 70, 0, 332",
	[8] = "1349, 261.38000488281, -64.360000610352, 1.1499999761581, 0, 0, 318",
	[9] = "1747, 261.20001220703, -62.75, 2.25, 0, 0, 0",
	[10] = "1344, 256.79998779297, -62.479999542236, 1.3899999856949, 0, 0, 0",
	[11] = "1439, 243.63999938965, -12.329999923706, 0.62000000476837, 0, 0, 354",
	[12] = "913, 267.05999755859, -7.0199999809265, 2.2400000095367, 0, 0, 16",
	[13] = "1439, 265.20999145508, -7.7699999809265, 1.3799999952316, 0, 0, 30",
	[14] = "1349, 281.89001464844, -5.1700000762939, 1.9700000286102, 0, 0, 310",
	[15] = "1347, 284.0299987793, -5.0799999237061, 1.9700000286102, 0, 0, 0",
	[16] = "1372, 281.92001342773, -36.409999847412, 0.60000002384186, 0, 0, 180",
	[17] = "1372, 279.79998779297, -36.349998474121, 0.60000002384186, 0, 0, 180",
	[18] = "1810, 282.4700012207, -35.439998626709, 0.66000002622604, 0, 0, 320",
	[19] = "1810, 278.41000366211, -36.080001831055, 0.62, 0, 0, 140",
	[20] = "913, 243.94000244141, -51.069999694824, 1.4099999666214, 0, 0, 110",
	[21] = "1370, 249.30000305176, -55.099998474121, 1.1200000047684, 0, 0, 0",
	[22] = "913, 208.33999633789, -183, 1.4099999666214, 0, 0, 170",
	[23] = "911, 207.07000732422, -181.99000549316, 1.1399999856949, 0, 0, 150",
	[24] = "910, 211.05000305176, -182.30999755859, 1.8500000238419, 0, 0, 200",
	[25] = "1215, 212.35000610352, -181.11000061035, 1.1399999856949, 0, 0, 0",
	[26] = "1215, 205.36999511719, -182.80000305176, 1.139999999, 0, 0, 0",
	[27] = "1215, 239.91000366211, -65.019996643066, 1.1399999856949, 0, 0, 0",
	[28] = "1215, 226.35000610352, -64.050003051758, 1.1299999952316, 0, 0, 0",
	[29] = "1215, 225.41999816895, -15.539999961853, 1.1499999761581, 0, 0, 0",
	[30] = "1215, 224.7799987793, -27.870000839233, 1.1399999856949, 0, 0, 0",
	[31] = "1215, 102.59999847412, -206.19999694824, 1.1499999761581, 0, 0, 0",
	[32] = "2912, 241.7200012207, -41.520000457764, 0.5799999833107, 0, 0, 20",
	[33] = "2912, 241.7200012207, -41.520000457764, 1.25, 0, 0, 59",
	[34] = "2912, 241.7200012207, -41.520000457764, 1.9500000476837, 0, 0, 360",
	[35] = "2912, 242.02000427246, -40.549999237061, 0.5799999833107, 0, 0, 70",
	[36] = "2972, 91.279998779297, -184.44000244141, 0.47999998927116, 0, 0, 0",
	[37] = "2972, 93.290000915527, -185.25999450684, 0.47999998927116, 0, 0, 18",
	[38] = "2975, -67.669921875, -329.76953125, 4.42, 0, 0, 70",
	[39] = "2975, -68.389999389648, -327.9700012207, 4.4299998283386, 0, 0, 170",
	[40] = "913, -66.059997558594, -326.67001342773, 5.2600002288818, 0, 0, 52",
	[41] = "913, 649.04998779297, -568.26000976563, 16.090000152588, 0, 0, 240",
	[42] = "1439, 661.09002685547, -565.23999023438, 15.340000152588, 0, 0, 270",
	[43] = "1439, 628.71997070313, -577.01000976563, 16.030000686646, 0, 0, 90",
	[44] = "1370, 657.38000488281, -649.09002685547, 15.880000114441, 0, 0, 0",
	[45] = "1370, 658.59997558594, -649.23999023438, 15.880000114441, 0, 0, 0",
	[46] = "1370, 658.20001220703, -647.82000732422, 15.880000114441, 0, 0, 0",
	[47] = "1349, 649.25, -566.38000488281, 15.829999923706, 0, 0, 100",
	[48] = "1345, 621.78002929688, -539.54998779297, 16.110000610352, 0, 0, 0",
	[49] = "1345, 619.27001953125, -539.45001220703, 16.110000610352, 0, 0, 0",
	[50] = "1344, 603.15997314453, -539.29998779297, 16.139999389648, 0, 0, 170",
	[51] = "1768, 648.65997314453, -567.23999023438, 15.239999771118, 0, 0, 250",
	[52] = "1764, 163.28999328613, -57.330001831055, 0.5799999833107, 0, 0, 80",
	[53] = "910, 163.25999450684, -53.470001220703, 1.8500000238419, 0, 0, 50",
	[54] = "1721, 164.66999816895, -57.650001525879, 0.5799999833107, 0, 0, 320",
	[55] = "1764, 163.94000244141, -54.540000915527, 0.5799999833107, 0, 0, 10",
	[56] = "1349, 163.94999694824, -56.340000152588, 1.5900000333786, 0, 0, 290"

}


local pObjects = {}

for i = 1, #objects_o, 1 do
	local id, x, y, z, rotx, roty, rotz = gettok(objects_o[i], 1, ","), gettok(objects_o[i], 2, ","), gettok(objects_o[i], 3, ","), gettok(objects_o[i], 4, ","), gettok(objects_o[i], 5, ","), gettok(objects_o[i], 6, ","), gettok(objects_o[i], 7, ",")
	pObjects[i] = createObject(id, x, y, z, rotx, roty, rotz)
	setElementData(pObjects[i], "O_MOVEABLE", true)
	addEventHandler("onElementClicked", pObjects[i],
		function(but, stat, thePlayer)
			if(but == "left") and (stat == "down") then
				if(getElementData(thePlayer, "Clicked") == 1) then return end
					local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
					if(isPedInVehicle(thePlayer)) then return end
					setElementData(thePlayer, "Clicked", 1)
					setTimer(setElementData, 1250, 1, thePlayer, "Clicked", 0)
					setPlayerToDymObject(thePlayer, source)
				end
		end)
			
end
outputDebugString(#objects_o.." Dynamische Objekte erstellt.")

function setPlayerToDymObject(thePlayer2, element)
	if(getElementType(element) ~= "object") then return end
	if(getElementData(element, "O_MOVEABLE") ~= true) then return end
	if(isElementAttached(element) == true) then
		local aeles = getAttachedElements(element)
		if(aeles[0] ~= thePlayer2) or (aeles[1] == thePlayer2) then else return end
		triggerClientEvent(thePlayer2, "getObjectGroundPosition", thePlayer2, element)
	else
		if(getElementData(thePlayer2, "attached") == true) then return end
		if not(getElementData(thePlayer2, "attachedElement")) then
			local rotx, roty, rotz = getElementRotation(thePlayer2)
			local ang = getPedRotation( thePlayer2 )
			local x, y, z = getElementPosition( thePlayer2 )
			local x2, y2, z2 = getElementPosition(element)
			local sx, sy, sz = x+math.sin(math.rad(-ang))*2, y+math.cos(math.rad(-ang))*2, z
			moveObject( element, 300, sx, sy, sz, rotx, roty, rotz-180)
			setTimer( function()
				attachElements(element, thePlayer2, 0, 2, 0)
				setElementAlpha(element, 200)
				setElementData(thePlayer2, "attachElement", element)
				setElementData(thePlayer2, "attached", true)
				toggleControl(thePlayer2, "jump", false)
				--toggleControl(thePlayer2, "sprint", false)
				toggleControl(thePlayer2, "enter_exit", false)
			end, 300, 1)
		else
			
			if(getElementData(thePlayer2, "attachedElement") ~= element) then return end
			local rotx, roty, rotz = getElementRotation(thePlayer2)
			local ang = getPedRotation( thePlayer2 )
			local x, y, z = getElementPosition( thePlayer2 )
			local x2, y2, z2 = getElementPosition(element)
			local sx, sy, sz = x+math.sin(math.rad(-ang))*2, y+math.cos(math.rad(-ang))*2, z
			moveObject( element, 300, sx, sy, sz, rotx, roty, rotz-180)
			setTimer( function()
				attachElements(element, thePlayer2, 0, 2, 0)
				setElementAlpha(element, 200)
				setElementData(thePlayer2, "attachElement", element)
				setElementData(thePlayer2, "attached", true)
				toggleControl(thePlayer2, "jump", false)
				--toggleControl(thePlayer2, "sprint", false)
				toggleControl(thePlayer2, "enter_exit", false)
			end, 300, 1)
		end
	end
end

addEvent("getObjectGroundPositionBack", true)
addEventHandler("getObjectGroundPositionBack", getRootElement(),
function(element3, Z1)
	setElementAlpha(element3, 255)
	setElementData(source, "attachElement", nil)
	setElementData(source, "attached", nil)
	detachElements(element3, source)
	local rotx, roty, rotz = getElementRotation(source)
	local ang = getPedRotation( source )
	local x, y, z = getElementPosition( source )
	local sx, sy, sz = x+math.sin(math.rad(-ang))*2, y+math.cos(math.rad(-ang))*2, Z1
	setElementPosition( element3, sx, sy, z)
	setElementRotation( element3, rotx, roty, rotz)
	moveObject( element3, 300, sx, sy, Z1)
	setTimer(setElementPosition, 300, 1, element3, sx, sy, sz)
	setElementData(element3, "lastvisitor", getPlayerName(source))
	local int = getElementInterior(source)
	setElementInterior(element3, int)
	toggleControl(source, "jump", true)
	--toggleControl(source, "sprint", true)
	toggleControl(source, "enter_exit", true)
end)

addCommandHandler("reposdynob",
function(thePlayer)
	if(getPlayerAdminlevel(thePlayer) < 3) then return end
	for i = 1, #objects_o, 1 do
		destroyElement(pObjects[i])
		local id, x, y, z, rotx, roty, rotz = gettok(objects_o[i], 1, ","), gettok(objects_o[i], 2, ","), gettok(objects_o[i], 3, ","), gettok(objects_o[i], 4, ","), gettok(objects_o[i], 5, ","), gettok(objects_o[i], 6, ","), gettok(objects_o[i], 7, ",")
		pObjects[i] = createObject(id, x, y, z, rotx, roty, rotz)
		setElementData(pObjects[i], "O_MOVEABLE", true)
		addEventHandler("onElementClicked", pObjects[i],
			function(but, stat, thePlayer)
				if(but == "left") and (stat == "down") then
				local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
			
						setPlayerToDymObject(thePlayer, source)
					end
			end)
	end
	outputChatBox("Dynamische Objekte zum Aufheben wurden neu erstellt.", thePlayer, 0, 200, 0, flse)
end)

addCommandHandler("getvisitdata",
function(thePlayer)
	if(getPlayerAdminlevel(thePlayer) < 1) then return end
	if(getElementData(thePlayer, "attached") == true) then
		local ob = getElementData(thePlayer, "attachElement")
		if not(ob) then outputChatBox("Du hast kein Element attached.", thePlayer, 200, 0, 0, false) return end
		outputChatBox("Letzter Spieler angehoben: "..getElementData(ob, "lastvisitor"),thePlayer, 0, 200, 200, false)
	end
end)

addEventHandler("onPlayeWasted", getRootElement(),
function()
	if(getElementData(source, "attached") == true) then
		local ob = getElementData(source, "attachElement")
		if not(ob) then return end
		setElementAlpha(ob, 255)
		deatachElements(ob, source)
		setElementData(source, "attached", nil)
		setElementData(source, "attachElement", nil)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(getElementData(source, "attached") == true) then
		local ob = getElementData(source, "attachElement")
		if not(ob) then return end
		setElementAlpha(ob, 255)
	end
end)