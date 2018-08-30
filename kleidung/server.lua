local interior = 14

local Marker1 = createMarker(1340.3267822266, 216.05975341797, 18.4546875, "cylinder", 1.5, 0, 200, 0, 200) -- Draussen
-- Vor tuer: 1341.037109375, 217.5224609375, 19.5546875
local Marker2 = createMarker(204.32640075684, -168.85549926758, 999.4234375, "cylinder", 1.5, 0, 200, 0, 200) -- Drinnen
-- Vor tuer: 204.35810852051, -167.18716430664, 1000.5234375
setElementInterior(Marker2, interior)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "player") then
		setInPosition(hitElement, 204.35810852051, -167.18716430664, 1000.5234375, 14)
	end
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "player") then
		setInPosition(hitElement, 1341.037109375, 217.5224609375, 19.5546875, 0)
	end
end)

-- --

addEvent("onClothesShopStart", true)
addEventHandler("onClothesShopStart", getRootElement(),
function()
	setElementPosition(source, 209.32945251465, -162.68161010742, 1000.5234375)
	setPedRotation(source, 90)
	setElementData(source, "atClothes", true)
	triggerClientEvent(source, "onClothesShopStartBack", source)
	setElementFrozen(source, true)
end)

addEvent("onClothesShopAbbrechen", true)
addEventHandler("onClothesShopAbbrechen", getRootElement(),
function()
	setElementData(source, "atClothes", false)
	setElementFrozen(source, false)
	setElementModel(source, tonumber(getElementData(source, "pSkin")))
	outputChatBox("Du hast die Aktion abgebrochen.", source, 200, 0, 0)
end)

addEvent("onClothesShopBuy", true)
addEventHandler("onClothesShopBuy", getRootElement(),
function(skin)
	setElementData(source, "pSkin", skin)
	setElementData(source, "atClothes", false)
	setElementFrozen(source, false)
end)