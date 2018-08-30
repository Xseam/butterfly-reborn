local Marker1 = createMarker(681.65142822266, -473.40045166016, 16.536296844482, "corona", 1.0, 255, 255, 255, 255) -- Draussen: 681.66442871094, -475.81271362305, 16.3359375
local Marker2 = createMarker(-229.29362487793, 1401.2030029297, 27.765625 , "corona", 1.0, 255, 255, 255, 255) setElementInterior(Marker2, 18) -- Drinnen: -226.82943725586, 1401.1088867188, 27.765625

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, -226.82943725586, 1401.1088867188, 27.765625, 18)
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 681.66442871094, -475.81271362305, 16.3359375, 0)
end)

local Bestellmarker = createMarker(-224.78160095215, 1404.0238037109, 27.7734375, "corona", 1.0, 0, 0, 255, 255)
setElementInterior(Bestellmarker, 18)

addEventHandler("onMarkerHit", Bestellmarker,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	triggerClientEvent(hitElement, "onUFOBarMarkerHit", hitElement)
end)