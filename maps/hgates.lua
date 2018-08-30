local gates = {}
local pads = {}
--[[
    createObject(3037, 746.40002441406, -583.79998779297,13.699999809265,0,0,0)
    createObject(2886, 746, -585.40002441406, 17.799999237061,0,0,268)
	createObject(2886, 747.20001220703,-585.09997558594,18,0,0,175.99499511719)
     <object id="object (warehouse_door2b) (zu)" doublesided="false" model="3037" interior="0" dimension="0" posX="746.40002441406" posY="-583.79998779297" posZ="17.89999961853" rotX="0" rotY="0" rotZ="0"></object>
 
--]]
-- Gates & Pads --
local gatevar = 1
gates[1] = createObject(3037, 787.78002929688, -505.70999145508, 17.520000457764, 0, 0, 90) -- Haus von MuLTi
setElementData(gates[1], "gate.type", "Admin")
setElementData(gates[1], "gate.admin", 1)
setElementData(gates[1], "gate.owner", "MuLti")
setElementData(gates[1], "gate.verschiebung", 5)
setElementData(gates[1], "gate.state", 0)
setElementData(gates[1], "gate.timestate", 0)

gates[2] = createObject(3037, 746.40002441406, -583.79998779297,17.89999961853,0,0,0) -- Haus von Snap
setElementData(gates[2], "gate.type", "Admin")
setElementData(gates[2], "gate.admin", 1)
setElementData(gates[2], "gate.owner", "Snap*")
setElementData(gates[2], "gate.verschiebung", 5)
setElementData(gates[2], "gate.state", 0)
setElementData(gates[2], "gate.timestate", 0)

gates[3] = createObject(10558, 204.8994140625, -236.099609375, 2.7999999523163,0,0,270) -- Haus von Dekay
setElementData(gates[3], "gate.type", "Admin")
setElementData(gates[3], "gate.admin", 1)
setElementData(gates[3], "gate.owner", "_-DeeKay-_")
setElementData(gates[3], "gate.verschiebung", 5)
setElementData(gates[3], "gate.state", 0)
setElementData(gates[3], "gate.timestate", 0)

gates[4] = createObject(10558, 215, -224.19921875, 2.7999999523163, 0, 0, 270) -- Haus von Dekay
setElementData(gates[4], "gate.type", "Admin")
setElementData(gates[4], "gate.admin", 1)
setElementData(gates[4], "gate.owner", "_-DeeKay-_")
setElementData(gates[4], "gate.verschiebung", 5)
setElementData(gates[4], "gate.state", 0)
setElementData(gates[4], "gate.timestate", 0)

-- --
pads[1] = createObject(2886, 782.40002441406, -505.82998657227, 17.5, 0, 0, 0)
setElementData(pads[1], "parent", gates[1])
pads[2] = createObject(2886, 789.17999267578, -504.63000488281, 18.049999237061, 0, 0, 268)
setElementData(pads[2], "parent", gates[1])

pads[3] = createObject(2886, 746, -585.40002441406, 17.799999237061,0,0,268)
setElementData(pads[3], "parent", gates[2])
pads[4] = createObject(2886, 747.20001220703,-585.09997558594,18,0,0,175.99499511719)
setElementData(pads[4], "parent", gates[2])

pads[5] = createObject(2886, 201.599609375, -236.2998046875, 2.5, 0, 0, 356)
setElementData(pads[5], "parent", gates[3])
pads[6] = createObject(2886, 201.599609375, -235.19921875, 2.4000000953674, 0, 0, 180)
setElementData(pads[6], "parent", gates[3])

pads[7] = createObject(2886, 211.69921875, -223.8994140625, 2.7999999523163, 0, 0, 180)
setElementData(pads[7], "parent", gates[4])
pads[8] = createObject(2886, 211.599609375, -224.3994140625, 2.9000000953674, 0, 0, 356)
setElementData(pads[8], "parent", gates[4])


for index, key in pairs(pads) do
	
	addEventHandler("onElementClicked", key,
	function(theButton, theState, thePlayer)
		if(theButton == "left") and (theState == "down") then
			if(getDistanceBetweenElements(thePlayer, source) > 15) then return end
			local gate = getElementData(source, "parent")
			if(getElementData(gate, "gate.type") == "Admin") then
				local adminlevel = tonumber(getElementData(gate, "gate.admin"))
				if(getPlayerAdminlevel(thePlayer) < adminlevel) then return end
				if(getElementData(gate, "gate.state") == 0) then
					if(isGateMoving(gate) == true) then return end
					local x, y, z = getElementPosition(gate)
					moveObject(gate, 1000, x, y, z-5, 0, 0, 0, "InOutQuad")
					setElementData(gate, "gate.timestate", 1)
					setTimer(setElementData, 1100, 1, gate, "gate.timestate", 0)
					setElementData(gate, "gate.state", 1)
				else
					if(isGateMoving(gate) == true) then return end
					setElementData(gate, "gate.state", 0)
					local x, y, z = getElementPosition(gate)
					moveObject(gate, 1000, x, y, z+5, 0, 0, 0, "InOutQuad")
					setElementData(gate, "gate.timestate", 1)
					setTimer(setElementData, 1100, 1, gate, "gate.timestate", 0)
				end
				
			else
				if(getElementData(gate, "gate.owner") == getPlayerName(thePlayer)) then
				if(getElementData(gate, "gate.state") == 0) then
					if(isGateMoving(gate) == true) then return end
					local x, y, z = getElementPosition(gate)
					moveObject(gate, 1000, x, y, z-5, 0, 0, 0, "InOutQuad")
					setElementData(gate, "gate.timestate", 1)
					setTimer(setElementData, 1100, 1, gate, "gate.timestate", 0)
				else
					if(isGateMoving(gate) == true) then return end
					local x, y, z = getElementPosition(gate)
					moveObject(gate, 1000, x, y, z+5, 0, 0, 0, "InOutQuad")
					setElementData(gate, "gate.timestate", 1)
					setTimer(setElementData, 1100, 1, gate, "gate.timestate", 0)
				end
				else return end
			
			
		end
	end
	end)
end

function isGateMoving(gate)
	if(getElementData(gate, "gate.timestate") == 0) then
		return false
	else
		return true
	end
end
