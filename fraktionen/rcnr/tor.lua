local Tor = createObject(980, 2264.6999511719, 51.700000762939, 28.299999237061)
local Gatevar = 0
local GTime = 0

addCommandHandler("ogate",
function(thePlayer)
	if (getPlayerFraktion(thePlayer) == 5) or (getPlayerFraktion(thePlayer) == 4) then else return end
	if (GTime == 1) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D ( x, y, z, 2264.6999511719, 51.700000762939, 28.299999237061 ) > 15) then return end
	if(Gatevar == 0) then
		local x, y, z = getElementPosition(Tor)
		moveObject(Tor, 2000,  x, y, z-6, 0, 0, 0, "InOutQuad")
		Gatevar = 1
	else
		local x, y, z = getElementPosition(Tor)
		moveObject(Tor, 2000, x, y, z+6, 0, 0, 0, "InOutQuad")
		Gatevar = 0
	end
	GTime = 1
	setTimer(function() GTime = 0 end, 1950, 1)
end)

