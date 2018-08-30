local Inmarker = createMarker(304.70501708984, -176.50537109375, 1.5284695625305, "corona", 1.0, 255, 255, 0, 255)
local Outmarker = createMarker(362.91928100586, -75.216972351074, 1001.5078125, "corona", 1.0, 255, 255, 0, 255) setElementInterior(Outmarker, 10)


addEventHandler("onMarkerHit", Inmarker,
function(hitElement)
	if not(getElementType(hitElement) == "player") then return end
	--setElementInterior(hitElement, 10)
	setInPosition(hitElement, 364.65036010742, -73.543533325195, 1001.5078125, 10)
end)
addEventHandler("onMarkerHit", Outmarker,
function(hitElement)
	if not(getElementType(hitElement) == "player") then return end
	--setElementInterior(hitElement, 0)
	setInPosition(hitElement, 301.66934204102, -179.25010681152, 1.5284695625305, 0)
end)
