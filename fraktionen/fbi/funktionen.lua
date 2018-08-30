local Marker = createMarker(1299.6947021484, -1311.5458984375, 13.446250915527, "corona", 1.0, 0, 200, 0, 200)
local Marker2 = createMarker(2522.9606933594, -1301.9133300781, 1048.2890625, "corona", 1.0, 0, 200, 0, 200)
setElementInterior(Marker2, 2)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 1299.7056884766, -1313.2104492188, 13.446250915527, 0, true)
end)

addEventHandler("onMarkerHit", Marker,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 2524.0053710938, -1301.9073486328, 1048.2890625, 2) -- Draussen: 1299.7056884766, -1313.2104492188, 13.446250915527
end)