local TGate = createObject(980, -854.79998779297, -887.5, 151.39999389648, 0, 0, 318)

--[[

980, -75.8994140625, -352.7998046875, 3.2000000476837, 0, 0, 270

3095, -75.900001525879, -356.29998779297, 5.4000000953674, 0, 0, 0
3095, -75.900001525879, -349.70001220703, 5.4000000953674, 0, 0, 0
--]]

local Gatevar = 0
local GTime = 0

addCommandHandler("ogate",
function(thePlayer)
	if (getPlayerFraktion(thePlayer) == 2) or (getPlayerFraktion(thePlayer) == 4) then else return end
	if (GTime == 1) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D ( x, y, z, -854.79998779297, -887.5, 151.39999389648 ) > 20) then return end
	if(Gatevar == 0) then
		local x, y, z = getElementPosition(TGate)
		moveObject(TGate, 2000,  x, y, z-6, 0, 0, 0, "InOutQuad")
		Gatevar = 1
	else
		local x, y, z = getElementPosition(TGate)
		moveObject(TGate, 2000, x, y, z+6, 0, 0, 0, "InOutQuad")
		Gatevar = 0
	end
	GTime = 1
	setTimer(function() GTime = 0 end, 2000, 1)
end)