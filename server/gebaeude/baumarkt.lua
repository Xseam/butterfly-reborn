local Marker1 = createMarker(801.68829345703, -574.17462158203, 16.3359375, "corona", 1.0, 255, 255, 255, 255) -- Draussen: 799.62707519531, -574.20892333984, 16.3359375
local Marker2 = createMarker( -27.390155792236, -57.508453369141, 1003.546875,"corona", 1.0, 255, 255, 255, 255) setElementInterior(Marker2, 6) -- Drinnen: -27.033624649048, -56.098937988281, 1003.546875
local Marker3 = createMarker(-23.299932479858, -55.640647888184, 1003.546875, "corona", 1.0, 0, 255, 0, 255) setElementInterior(Marker3, 6)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, -27.033624649048, -56.098937988281, 1003.546875, 6)
end)

addEventHandler("onMarkerHit", Marker3,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	triggerClientEvent(hitElement, "onBaumarktGuiStart", hitElement)
end)


addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 799.62707519531, -574.20892333984, 16.3359375, 0)
end)


addEvent("onBaumarktObjectFinished", true)
addEventHandler("onBaumarktObjectFinished", getRootElement(),
function(modell, x, y, z, x1, y1, z1, int, dim)
	local object = createObject(modell, x, y, z)
	setElementRotation(object, x1, y1, z1)
	setElementInterior(object, int)
	setElementDimension(object, dim)
	setElementData(object, "PBAUMARKTOBJEKT", true)
end)