local Tor = createObject(980, 607.5, -587.79998779297, 20, 0, 0, 90) -- tor
local Plattform = createObject(980, 609.90002441406, -587.70001220703, 16.700000762939-1, 80, 0, 270) -- Plattform, ist oben ohne -3


local Gatevar = 0
local GTime = 0

addCommandHandler("ogate",
function(thePlayer)
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	if (GTime == 1) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D ( x, y, z, 607.5, -587.79998779297, 20 ) > 20) then return end
	if(Gatevar == 0) then
		local x, y, z = getElementPosition(Tor)
		local x1, y1,z1 = getElementPosition(Plattform)
		moveObject(Tor, 2000,  x, y, z-6, 0, 0, 0, "InOutQuad")
		moveObject(Plattform, 2000, x1, y1, z1+1)
		Gatevar = 1
	else
		local x, y, z = getElementPosition(Tor)
		local x1, y1,z1 = getElementPosition(Plattform)
		moveObject(Tor, 2000,  x, y, z+6, 0, 0, 0, "InOutQuad")
		moveObject(Plattform, 2000, x1, y1, z1-1)
		Gatevar = 0
	end
	GTime = 1
	setTimer(function() GTime = 0 end, 1900, 1)
end)