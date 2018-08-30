local p_Veh = {}

addCommandHandler("veh",
function(thePlayer, cmd, id, f1, f2, f3)
	if(getPlayerName(thePlayer) == "MuLTi") or (getPlayerName(thePlayer) == "SK_Styla") then
	if not(f1) or not(f2) or not(f3) then
	f1 = 0
	f2 = 0
	f3 = 0
	end
	if not(id) then return end
	local id = getVehicleModelFromName(id)
	if not (p_Veh[thePlayer] == nil) then outputChatBox("Du hast bereits ein Auto!, Benutze /delveh.", thePlayer, 255, 0, 0, false) return end
	local x, y, z = getElementPosition(thePlayer)
	p_Veh[thePlayer] = createVehicle(id, x+2, y, z)
	setVehicleColor(p_Veh[thePlayer], f1, f2, f3)
	outputChatBox("Fahrzeug "..id.." erstellt!", thePlayer, 0, 255, 0)
	warpPedIntoVehicle(thePlayer, p_Veh[thePlayer])
	setElementData(p_Veh[thePlayer], "Typ", "Adminauto")
	setElementData(p_Veh[thePlayer], "Besitzer", getPlayerName(thePlayer))
	end
end)
addCommandHandler("delveh",
function(thePlayer, cmd, id, f1, f2, f3)
	if(getPlayerName(thePlayer) == "MuLTi") or (getPlayerName(thePlayer) == "SK_Styla") then
	if (p_Veh[thePlayer] == nil) then outputChatBox("Du hast kein Auto!", thePlayer, 255, 0, 0, false) return end
	destroyElement(p_Veh[thePlayer])
	p_Veh[thePlayer] = nil
	outputChatBox("Fahrzeug geloescht.", thePlayer, 0, 255, 0)
	end
end)