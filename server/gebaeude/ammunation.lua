local Marker1 = createMarker(242.79536437988, -178.2749786377, 0.778125, "cylinder", 1.0, 0, 255, 0, 200)
-- Pos draussen: 240.81573486328, -178.24615478516, 1.578125
local Marker2 = createMarker(285.47299194336, -41.181083679199, 1000.715625, "cylinder", 1.0, 0, 255, 0, 200)
-- Pos drinne: 285.6604309082, -39.935348510742, 1001.515625
setElementInterior(Marker2, 1)

addEventHandler("onMarkerHit", Marker1, function(hitElement)
	if(getElementType(hitElement) == "player") then
		setInPosition(hitElement, 285.6604309082, -39.935348510742, 1001.515625, 1)
	end
end)

addEventHandler("onMarkerHit", Marker2, function(hitElement)
	if(getElementType(hitElement) == "player") then
		setInPosition(hitElement, 240.81573486328, -178.24615478516, 1.578125, 0)
	end
end)

addEvent("onAmmunationBuy", true)
addEventHandler("onAmmunationBuy", getRootElement(), function(id)
	local slot = getPedWeapon ( source, getSlotFromWeapon(id) )
	local preis
	local muni = ammuMunni[id]
	if(slot) and (slot == id) then -- Wenn er die Waffe hat
		preis = ammuMunniPreis[id]
	else
		preis = ammuPreis[id]
	end
	local money = tonumber(getElementData(source, "pHGeld"))
	if(money < preis) then outputChatBox("Du hast nicht genug Geld fuer diese Waffe! Es fehlen dir "..preis-money.."$.", source, 200, 0, 0) return end
	givePlayerItem(source, "pHGeld", -preis)
	giveWeapon(source, id, muni, true)
	outputChatBox("Du hast dir die Waffe gekauft!", source, 0, 200, 0)
end)