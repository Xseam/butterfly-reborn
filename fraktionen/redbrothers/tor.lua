local gate = createObject(980, 1024.6099853516, -368.39999389648, 75.620002746582, 0, 0, 356)
local state = 1 -- Oben
local GTime2 = 0

local Jail = createObject(974, 1019.4799804688,-314.10998535156, 65.069999694824, 0, 0, 180)
local Keyrb1 = createObject(2886, 1016.3699951172,-315.26, 74.379997253418, 0, 0, 360)
local Jailstatus = 0
local Jailtime = 0

function resetJailRedbrothers()
	Jailtime = 0
end

addEventHandler("onElementClicked", Keyrb1, function(theButton, theState, thePlayer)	
	outputChatBox("1")
    if (theState == "down") and (theButton == "left") then 
			outputChatBox("2")
	if (getDistanceBetweenElements(thePlayer, source) > 15) then return end
			outputChatBox("3")
		if(getPlayerFraktion(thePlayer) ~= 6) then return end
				outputChatBox("4")
				if(Jailtime == 1) then return end
				if(Jailstatus == 0) then 
						outputChatBox("5")
					Jailtime = 1
					Jailstatus = 1
					local X, Y, Z = getElementPosition(Jail)
					moveObject(Jail, 1000, X, Y, Z-3, 0, 0, 0, "InOutQuad")
					setTimer(resetJailRedbrothers, 1100, 1)
				else
						outputChatBox("6")
					Jailtime = 1
					Jailstatus = 0
					local X, Y, Z = getElementPosition(Jail)
					moveObject(Jail, 1000, X, Y, Z+3, 0, 0, 0, "InOutQuad")
					setTimer(resetJailRedbrothers, 1100, 1)
				end
			end
	
end)

addCommandHandler("ogate", 
function(thePlayer,cmd)
	if (getPlayerFraktion(thePlayer) == 6) or (getPlayerFraktion(thePlayer) == 4) then else return end
	if(GTime2 == 1) then return end
	local x, y, z = getElementPosition(thePlayer)
	if (getDistanceBetweenPoints3D ( x, y, z, 1024.6099853516, -368.39999389648, 75.620002746582 ) > 15) then return end
	if(state == 1) then
		local x, y, z = getElementPosition(gate)
		moveObject(gate, 1500,  x, y, z-6, 0, 0, 0, "InOutQuad")
		state = 0
	else
		local x, y, z = getElementPosition(gate)
		moveObject(gate, 1500, x, y, z+6, 0, 0, 0, "InOutQuad")
		state = 1
	end
	GTime2 = 1
	setTimer(function() GTime2 = 0 end, 1500, 1)
end)

