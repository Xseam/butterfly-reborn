-- Waffentruck Script bei [XP]MuLTi --

local waffen1, waffen2, waffen3 = 769.98388671875, 1858.7867431641, 4.9421033859253 -- Koordinaten, wo der Abholpunkt sein soll
local wMarker = 0
local wBlip = 0
local wtDestroyTime = 30 -- Minuten zeit, wann der Waffentruck automatisch resettet werden soll

local state = 0 -- Waffentruck Status

local bases = {
	[1] = "-90.842864990234, -312.00103759766, 1.4296875",
	[2] = "-862.2353515625, -895.08557128906, 149.640625",
	[6] = "1023.7318115234, -380.56231689453, 72.538513183594",
}

addCommandHandler("waffentruck",
function(thePlayer)
	local frak = getPlayerFraktion(thePlayer)
	if(frak == 0) or (frak == 3) then outputChatBox("Du bist nicht authorisiert!", thePlayer, 200, 0, 0, false) return end
	local veh = getPedOccupiedVehicle(thePlayer)
	if not(veh) then outputChatBox("Du musst in deinem Fraktions-Flatbed sein!", thePlayer, 200, 0, 0, false) return end
		if(getElementModel(veh) == 455) and (getElementData(veh, "Besitzer") == fraktionNamen[frak]) then
			if(getElementData(thePlayer, "waffentruck") == true) then outputChatBox("Du machst bereits ein Waffentruck!", thePlayer, 200, 0, 0, false) return end
			if(state == 1) then outputChatBox("Es faehrt bereits ein Waffentruck, oder du musst noch Warten!", thePlayer, 200, 0, 0, false) return end
			setElementData(thePlayer, "waffentruck", true)
			setElementData(veh, "waffentruck", true)
			outputChatBox("Du hast die Waffentruck-Mission gestartet. Fahre zum Checkpoint und Lade die Waffen auf!", thePlayer, 0, 200, 0, false)
			for index, spieler in pairs(getElementsByType("player")) do
				if(getPlayerFraktion(spieler) == frak) then
				outputChatBox("|| Member "..getPlayerName(thePlayer).." hat ein Waffentruck gestartet! ||", spieler, 200, 255, 0, false)
				end
				if(getPlayerFraktion(spieler) == 4) then
				outputChatBox("|| Spieler "..getPlayerName(thePlayer).." hat ein Waffentruck gestartet! ||", spieler, 200, 255, 0, false)
				end
			end
			outputDebugString("Spieler "..getPlayerName(thePlayer).." hat ein Waffentruck gestartet.")
			wMarker = createMarker(waffen1, waffen2, waffen3, "cylinder", 5.0, 200, 255, 255, 255, thePlayer)
			wBlip = createBlip(waffen1, waffen2, waffen3, 51, 2, 255, 0, 0, 255, 0, 99999.0, thePlayer)
			state = 1
			setTimer(resetWaffentruck, wtDestroyTime*60*1000, 1)
			addEventHandler("onMarkerHit", wMarker,
				function(hitElement)
				if(getElementType(hitElement) == "player") then return end
				local player = getVehicleOccupant(hitElement)
				if not(player == thePlayer) then return end
				if(getElementData(player, "wartend") == true) then return end
				outputChatBox("Bitte Warte nun. Du laedst auf. Entferne dich nicht!", player, 0, 200, 0, false)
				setElementData(player, "wartend", true)
					setTimer(
					function()
						destroyElement(wMarker)
						destroyElement(wBlip)
						outputChatBox("Fahre nun wieder zurueck zu deiner Base!", player, 0, 200, 0, false)
						local x1 = gettok(bases[getPlayerFraktion(player)], 1, ",")
						local y1 = gettok(bases[getPlayerFraktion(player)], 2, ",")
						local z1 = gettok(bases[getPlayerFraktion(player)], 3, ",")
						wMarker = createMarker(x1, y1, z1, "corona", 3.0, 255, 255, 255, 255, player)
						wBlip = createBlip(x1, y1, z1, 51, 2, 255, 0, 0, 255, 0, 99999.0, player)
						setElementData(player, "wartend", false)
						addEventHandler("onMarkerHit", wMarker,
						function(hitElement2)
							if(getElementType(hitElement2) == "player") then return end
							local player2 = getVehicleOccupant(hitElement2)
							if not(player2 == thePlayer) then return end
							outputChatBox("Waffentruck Erfolgreich!", player2, 0, 200, 0, false)
							destroyElement(wMarker)
							destroyElement(wBlip)
							setElementData(player2, "waffentruck", false)
							setElementData(player, "wartend", false)
							local data = tonumber(getElementData(player2, "pHGeld"))
							local waffen = 0
							local geld = math.random(500, 2500)
							if(data > 10000) then
								waffen = math.random(120, 150) 
							end
							if(data < 10000) and (data > 9000) then
								waffen = math.random(100, 120)
							end
							
							if(data < 9000) and (data > 8000) then
								waffen = math.random(70, 100)
							end
							if(data < 8000) and (data > 5000) then
								waffen = math.random(50, 70)
							end
							if(data < 5000) then
								waffen = math.random(20, 50)
							end
							if(data < 500) then
								waffen = math.random(0, 10)
							end
							outputChatBox("Es wurden "..waffen.." Waffen und "..geld.." $ erbeutet. Die Einnahmen wurden in die Fraktionskasse ueberwiesen!", player2, 0, 255, 0, false)
							triggerEvent("onFraktionspcKasseEinzahl", player2, geld, 1)
							triggerEvent("onWaffentruckEinzahl", player2, waffen)
							setTimer(function() state = 0 end, 360000, 1)
					end)
					end, 30000, 1)
				end)
		else -- Flatbed
			outputChatBox("Du bist nicht in deinem Fraktions-Flatbed!", thePlayer, 200, 0, 0, false)
		end
end)

function resetWaffentruck()
	if(state == 1) then
		destroyElement(wMarker)
		destroyElement(wBlip)
		state = 0
		for index, spieler in pairs(getElementsByType("player")) do
			if(getElementData(spieler, "waffentruck") == true) then setElementData(spieler, "waffentruck", false) end
		end
	end
end
addEventHandler("onElementDestroy", getRootElement(),
function()
	if(getElementData(source, "waffentruck") == true) and (state == 1) then
		destroyElement(wMarker)
		destroyElement(wBlip)
		state = 0
		for index, spieler in pairs(getElementsByType("player")) do
			if(getElementData(spieler, "waffentruck") == true) then setElementData(spieler, "waffentruck", false) end
		end
	end
end)

addEventHandler("onVehicleExplode", getRootElement(),
function()
	if(getElementData(source, "waffentruck") == true) and (state == 1) then
		destroyElement(wMarker)
		destroyElement(wBlip)
		state = 0
		for index, spieler in pairs(getElementsByType("player")) do
			if(getElementData(spieler, "waffentruck") == true) then setElementData(spieler, "waffentruck", false) end
		end
	end
end)

addEventHandler("onPlayerLeave", getRootElement(),
function()
	if(getElementData(source, "waffentruck") == true) then
		destroyElement(wMarker)
		destroyElement(wBlip)
		state = 0
		for index, spieler in pairs(getElementsByType("player")) do
			if(getPlayerFraktion(spieler) == getPlayerFraktion(source)) then
				outputChatBox("|| Member "..getPlayerName(source).." ist Offline gegangen, der Waffentruck wurde resettet! ||", spieler, 200, 0, 0, false)
				
			end
		end
		outputDebugString("Spieler "..getPlayerName(thePlayer).." has failed the Waffentruck")
	end
end)