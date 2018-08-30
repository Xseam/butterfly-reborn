local Pizzamarkerout = createMarker(203.43977355957, -202.7341003418, 1.578125, "corona", 1.0, 255, 255, 255, 255)
local Pizzamarkerdrinne = createMarker(372.45297241211, -133.52066040039, 1001.4921875, "corona", 1.0, 255, 255, 255, 255) setElementInterior(Pizzamarkerdrinne, 5)
-- 372.13616943359, -132.05659484863, 1001.4921875


addEventHandler("onMarkerHit", Pizzamarkerout, 
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement)) then return end
	setInPosition(hitElement, 372.13616943359, -132.05659484863, 1001.4921875, 5)
end)

addEventHandler("onMarkerHit", Pizzamarkerdrinne, 
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement)) then return end
	setInPosition(hitElement, 203.53089904785, -206.33393859863, 1.578125, 0)
end)