local YGate = createObject(980, -75.8994140625, -352.7998046875, 3.2000000476837, 0, 0, 270)
local YForm1 = createObject(3095, -75.900001525879, -356.29998779297, 5.4000000953674, 0, 0, 0)
local YForm2 = createObject(3095, -75.900001525879, -349.70001220703, 5.4000000953674, 0, 0, 0)
local Jail = createObject(974, -54.139999389648, -215, 6.210000038147, 0, 0, 85)
local Keypad = createObject(2886, -54.229999542236,-218.74000549316, 6.8200001716614, 0, 0, 90)
local Jailstatus = 0
local Jailtime = 0

function resetJailYakuza()
	Jailtime = 0
end

addEventHandler("onElementClicked", Keypad,
function(theButton, theState, thePlayer)
    if (theState == "down") and (theButton == "left") then 
		if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
		if(getPlayerFraktion(thePlayer) ~= 1) then return end
				if(Jailtime == 1) then return end
				if(Jailstatus == 0) then 
					Jailtime = 1
					Jailstatus = 1
					local X, Y, Z = getElementPosition(Jail)
					moveObject(Jail, 2000, X, Y, Z-5, 0, 0, 0, "InOutQuad")
					setTimer(resetJailYakuza, 2100, 1)
				elseif(Jailstatus == 1) then
					Jailtime = 1
					Jailstatus = 0
					local X, Y, Z = getElementPosition(Jail)
					moveObject(Jail, 2000, X, Y, Z+5, 0, 0, 0, "InOutQuad")
					setTimer(resetJailYakuza, 2100, 1)
				end
			end
	
end)

--[[

980, -75.8994140625, -352.7998046875, 3.2000000476837, 0, 0, 270

3095, -75.900001525879, -356.29998779297, 5.4000000953674, 0, 0, 0
3095, -75.900001525879, -349.70001220703, 5.4000000953674, 0, 0, 0
--]]

local Gatevar = 0
local GTime = 0

addCommandHandler("ogate",
function(thePlayer)
	if (getPlayerFraktion(thePlayer) == 1) or (getPlayerFraktion(thePlayer) == 4) then else return end
	if (GTime == 1) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D ( x, y, z,-75.8994140625, -352.7998046875, 3.2000000476837 ) > 25) then return end
	if(Gatevar == 0) then
		local x, y, z = getElementPosition(YGate)
		moveObject(YGate, 2000,  x, y, z-6, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(YForm1)
		moveObject(YForm1, 2000,  x, y, z+2, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(YForm2)
		moveObject(YForm2, 2000,  x, y, z+2, 0, 0, 0, "InOutQuad")
		Gatevar = 1
	else
		local x, y, z = getElementPosition(YGate)
		moveObject(YGate, 2000, x, y, z+6, 0, 0, 0, "OutBounce", 1)
		local x, y, z = getElementPosition(YForm1)
		moveObject(YForm1, 2000,  x, y, z-2, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(YForm2)
		moveObject(YForm2, 2000,  x, y, z-2, 0, 0, 0, "InOutQuad")
		Gatevar = 0
	end
	GTime = 1
	setTimer(function() GTime = 0 end, 2000, 1)
end)