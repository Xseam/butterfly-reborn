local doingbankrob = false
local playerBlip = {}
local playerMarker = {}
local enterCol = createColSphere(2305.8745117188, -16.342226028442, 26.749565124512, 3)
local bankrobstarted = false
local bankrobtime = 20
local bankraubmarker
local bankrobtimerplayer = {}
local isEntering = false


function createBankraubStep1()
	if(bankraubmarker) then destroyElement(bankraubmarker) end
	bankraubmarker = createMarker(2315.5305175781, -0.3339572250843, 25.9421875, "cylinder", 1.0, 0, 0, 255, 200)
	addEventHandler("onMarkerHit", bankraubmarker,
	function(hitElement)
		destroyElement(bankraubmarker)
		toggleAllControls(hitElement, false)
		outputChatBox("Bitte warte 5 Sekunden, du pflanzt die Bombe.", hitElement, 0, 200, 0)
		setTimer(function()
			toggleAllControls(hitElement, true)
			outputChatBox("Die Bombe explodiert in 20 Sekunden!", hitElement, 200, 0, 0)
			setTimer(triggerClientEvent, 17000, 1, getRootElement(), "onClientSoundPos", 2315.5305175781, -0.3339572250843, 26.7421875, "sounds/countdown.mp3")
			setTimer(function()
				createExplosion(2315.5305175781, -0.3339572250843, 26.7421875, 0, hitElement)
			end, 20000, 1)
		end, 5000, 1)
	end)

end
addCommandHandler("bankrob", function(thePlayer, cmd)
	
	if(getPlayerFraktion(thePlayer) == 1) or (getPlayerFraktion(thePlayer) == 2) or (getPlayerFraktion(thePlayer) == 6) then
	else
		outputChatBox("Du hast keine Berechtigung, ein Bankraub zu starten!", thePlayer, 200, 0, 0)
	return end
	outputChatBox("Folgt", thePlayer, 0, 200, 0)
	--[[
	local veh = getPedOccupiedVehicle(thePlayer)
	if not(veh) then outputChatBox("Du musst in einem Securicar-Fahrzeug sitzen!", thePlayer, 200, 0, 0) return end
	if not(getElementModel(veh) == 428) then outputChatBox("Du musst in einem Securicar-Fahrzeug sitzen!", thePlayer, 200, 0, 0) return end
	--if(#getVehicleOccupants(veh) < 2) then outputChatBox("Du brauchst mindestens 2 Leute beim Bankraub!", thePlayer, 200, 0, 0) return end
	if(doingbankrob == true) then outputChatBox("Es findet bereits ein Bankraub statt!", thePlayer, 200, 0, 0) return end
	if(playerBlip[thePlayer]) then destroyElement(playerBlip[thePlayer]) end
	if(playerMarker[thePlayer]) then destroyElement(playerMarker[thePlayer]) end
	doingbankrob = true
	setElementData(veh, "bankrobveh", true)
	setElementData(veh, "bankrobfrak", getPlayerFraktion(thePlayer))
	setElementData(veh, "bankrobdriver", thePlayer)
	outputChatBox("Bankraub gestartet! Fahre zur Bank! Der Countdown von "..bankrobtime.." Minuten laeuft.", thePlayer, 0, 200, 0)
	outputChatBox("Die Position wo du halten musst, wird dir auf deinen Radar angezeigt.", thePlayer, 0, 200, 0)
	setElementData(enterCol, "robfraktion", getPlayerFraktion(thePlayer))
	local beteiligte = ""
	for index, player in pairs(getVehicleOccupants(veh)) do
		setElementData(player, "bankrob", true)
		outputChatBox("Du bist nun am Bankraub mitbeteiligt.", thePlayer, 0, 200, 0)
		beteiligte = beteiligte..", "..getPlayerName(player)
	end
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerFraktion(player) == getPlayerFraktion(thePlayer)) then
			outputChatBox("| Member "..getPlayerName(thePlayer).." hat ein Bankraub gestartet! |", player, 0, 255, 255)
			outputChatBox("Mitbeteiligte Personen: "..beteiligte, player, 0, 255, 255)
		end
	end
	playerBlip[thePlayer] = createBlip(2338.8884277344, 34.647979736328, 26.484375, 19, 2, 255, 0, 0, 255, 0, 999999.0, thePlayer)
	playerMarker[thePlayer] = createMarker(2338.8884277344, 34.647979736328, 25.484375, "cylinder", 2.5, 0, 200, 0, 200, thePlayer)
	
	addEventHandler("onMarkerHit", playerMarker[thePlayer],
	function(hitElement)
		if(doingbankrob == true) then
			if(getElementType(hitElement) == "vehicle") and (getElementModel(hitElement) == 428) and (getElementData(hitElement, "bankrobveh") == true) then
				local occupant = getVehicleOccupant(hitElement)
				if(occupant ~= getElementData(hitElement, "bankrobdriver")) then return end
				destroyElement(playerBlip[thePlayer])
				destroyElement(playerMarker[thePlayer])
				outputChatBox("Parke Hier dein Securicar, und Gehe mit deinen Mitgliedern zur Bank!", occupant, 0, 200, 0)
				for index, player in pairs(getVehicleOccupants(hitElement)) do
					if(player == occupant) then else
					outputChatBox("Das Securiauto wurde geparkt. Gehe nun in die Bank!", player, 0, 200, 0)
					end
				end
				outputChatBox("Einwohnermeldung: Ein Bankraub wird in Palomino Creek durchgefuehrt!", getRootElement(), 255, 255, 0)
				createBankraubStep1()
			end
		end
	end)
	--]]
end)

addEventHandler("onColShapeHit", enterCol,
function(hitElement)
	if(getElementType(hitElement) ~= "player") then return end
	if(doingbankrob == true) and (getElementData(hitElement, "bankrob") == true) then
		outputChatBox("Du hast die Bank Betreten.", hitElement, 0, 200, 0)
		if(bankrobstarted == false) then
			triggerClientEvent(getRootElement(), "onBankraubStart", hitElement)
		end
		bankrobstarted = true
	end
end)

addEventHandler("onElementDestroy", getRootElement(),
function()
	if(doingbankrob == true) then
		if(getElementModel(source) == 428) and (getElementData(source, "bankrobveh") == true) then
			setElementData(source, "bankrobveh", false)
			setElementData(source, "bankrobfrak", nil)
			setElementData(source, "bankrobdriver", nil)
			doingbankrob = false
			local fraktion = getElementData(source, "bankrobfrak")
			triggerClientEvent(getRootElement(), "onBankraubStop", getElementData(source, "bankrobdriver"))
			if(fraktion) then
				destroyElement(playerBlip[getElementData(source, "bankrobdriver")])
				destroyElement(playerMarker[getElementData(source, "bankrobdriver")])
				for index, player in pairs(getElementsByType("player")) do
					if(getPlayerFraktion(player) == fraktion) then
						outputChatBox("Das Securicar von dem Bankraub ist Explodiert! Bankraub gescheitert.", player, 200, 0, 0)
					end
				end
			end
		end
	end
end)

addEventHandler("onVehicleExplode", getRootElement(),
function()
	if(doingbankrob == true) then
		if(getElementModel(source) == 428) and (getElementData(source, "bankrobveh") == true) then
			doingbankrob = false
			setElementData(source, "bankrobveh", false)
			setElementData(source, "bankrobfrak", nil)
			setElementData(source, "bankrobdriver", nil)
			triggerClientEvent(getRootElement(), "onBankraubStop", getElementData(source, "bankrobdriver"))
			local fraktion = getElementData(source, "bankrobfrak")
			if(fraktion) then
				destroyElement(playerBlip[getElementData(source, "bankrobdriver")])
				destroyElement(playerMarker[getElementData(source, "bankrobdriver")])
				for index, player in pairs(getElementsByType("player")) do
					if(getPlayerFraktion(player) == fraktion) then
						outputChatBox("Das Securicar von dem Bankraub ist Explodiert! Bankraub gescheitert.", player, 200, 0, 0)
					end
				end
			end
		end
	end
end)
