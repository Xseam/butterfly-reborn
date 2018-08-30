local Partymarkerdraussen = createMarker(243.45471191406, -237.19961547852, 1.5504941940308, "corona", 1.0, 255, 255, 255, 255)
-- Draussen: 240.77119445801, -237.13032531738, 1.578125
local Partymarkerdrinnen = createMarker(493.37823486328, -24.767194747925, 1000.6796875, "corona", 1.0, 255, 255, 255, 255) setElementInterior(Partymarkerdrinnen, 17)
-- drinnen: 493.54141235352, -22.394718170166, 1000.6796875

addEventHandler("onMarkerHit", Partymarkerdraussen,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	--setElementInterior(hitElement, 17)
	setInPosition(hitElement, 493.54141235352, -22.394718170166, 1000.6796875, 17)
end)

addEventHandler("onMarkerHit", Partymarkerdrinnen,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	--setElementInterior(hitElement, 0)
	setInPosition(hitElement, 240.77119445801, -237.13032531738, 1.578125, 0)
end)


-- Ped --
--[[

local Keeper = createPed(240, 502.50198364258, -23.778837203979, 1000.6796875)
setElementInterior(Keeper, 17)


local Keepervar = 0
setTimer(
function()
	if(Keepervar == 0) then
	Keepervar = 1
	setPedAnimation( Keeper, "ped", "WALK_civi", -1, true, true, false)
	setPedRotation(Keeper, 0)
	elseif(Keepervar == 1) then
	Keepervar = 2
	setPedAnimation( Keeper )
	setPedRotation(Keeper, 90)
	elseif(Keepervar == 2) then
	setPedAnimation( Keeper, "ped", "WALK_civi", -1, true, true, false)
	Keepervar = 3
	setPedRotation(Keeper, 180)
	elseif(Keepervar == 3) then
	Keepervar = 0
	setPedAnimation( Keeper )
	setPedRotation(Keeper, 90)
	end
end, 4000, 0)--]]