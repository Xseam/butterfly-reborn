local Marker2 = createMarker(1358.634765625, -41.257381439209, 1000.9266967773, "corona", 1.0, 255, 255, 255, 255)
setElementInterior(Marker2, 1) -- Drinne: 1360.6441650391, -41.430202484131, 1000.9211425781
local Marker1 = createMarker(246.37020874023, 87.996505737305, 1003.640625, "corona", 1.0, 255, 255, 255, 255)
setElementInterior(Marker1, 6)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 246.54695129395, 86.037704467773, 1003.640625, 6)
end)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if(getElementType(hitElement) == "vehicle") then return end
	if(isPedInVehicle(hitElement) == true) then return end
	setInPosition(hitElement, 1360.6441650391, -41.430202484131, 1000.9211425781, 1)
end)
local Gate = {}
Gate[1] = createObject(2930, 1363.4000244141, -21.299999237061, 1002.5999755859, 0, 0, 90)
Gate[2] = createObject(2930, 1363.3994140625, -21.2998046875, 1005.299987793, 0, 0, 90)
Gate[3] = createObject(2930, 1369.19921875, -21.2998046875, 1005.299987793, 0, 0, 90)
Gate[4] = createObject(2930, 1369.19921875, -21.2998046875, 1002.5999755859, 0, 0, 90)
Gate[5] = createObject(2930, 1374.599609375, -21.2998046875, 1002.5999755859, 0, 0, 90)
Gate[6] = createObject(2930, 1374.599609375, -21.2998046875, 1005.299987793, 0, 0, 90)
Gate[7] = createObject(2930, 1380.2998046875, -21.2998046875, 1005.299987793, 0, 0, 90)
Gate[8] = createObject(2930, 1380.2998046875, -21.2998046875, 1002.5999755859, 0, 0, 90)
Gate[9] = createObject(2930, 1386.099609375, -21.2998046875, 1005.299987793, 0, 0, 90)
Gate[10] = createObject(2930, 1386.099609375, -21.2998046875, 1002.5999755859, 0, 0, 90)
Gate[11] = createObject(2930, 1386.7998046875,-42.599609375, 1002.5999755859, 0, 0, 90) -- Anfangsseite
Gate[12] = createObject(2930, 1386.7998046875, -42.599609375, 1005.299987793, 0, 0, 90)
Gate[13] = createObject(2930, 1381.099609375, -42.69921875, 1005.299987793, 0, 0, 90)
Gate[14] = createObject(2930, 1381.099609375, -42.599609375, 1002.5999755859, 0, 0, 90) 
Gate[15] = createObject(2930, 1376.19921875, -42.7998046875, 1005.299987793, 0, 0, 90)
Gate[16] = createObject(2930, 1376.19921875, -42.599609375, 1002.5999755859, 0, 0, 90)
-- 							  1378.0999755859 <-- Auf!
for i = 1, #Gate, 1 do
	setElementInterior(Gate[i], 1)
end

local gZellvar = 0
local gMoving = 0
local Tuervar = 0

local Alleaufpad = createObject(2886, 1360.8000488281, -47.5, 1000.700012207, 270, 0, 0)
setElementInterior(Alleaufpad, 1)

local Tuer = createObject(2930, 1364.69921875, -43, 1002.5999755859, 0, 0, 0) -- Auf: 1364.6999511719, -41.200000762939, 1002.5999755859
local tPad1 = createObject(2886, 1364.599609375, -45, 1001.5, 0, 0, 270)
local tPad2 = createObject(2886, 1364.7998046875, -45, 1001.5, 0, 0, 90)
setElementInterior(Tuer, 1)
setElementInterior(tPad1, 1)
setElementInterior(tPad2, 1)



addEventHandler("onElementClicked", getRootElement(),
function(theButton, theState, thePlayer )
    if (theState == "down") and (theButton == "left") then 
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
        if source == tPad1 or source == tPad2 then
			if(Tuervar == 0) then
				Tuervar = 1
				moveObject(Tuer, 1000, 1364.69921875, -43, 1002.5999755859)
			elseif(Tuervar == 1) then
				Tuervar = 0
				moveObject(Tuer, 1000, 1364.6999511719, -41.200000762939, 1002.5999755859)
			end
		end
		if source == Alleaufpad then
			if(gZellvar == 0) then
				if(gMoving == 1) then return end
				gMoving = 1
				gZellvar = 1
				setTimer(function() gMoving = 0 end, 5000, 1)
				for i = 1, #Gate, 1 do
					local x, y, z = getElementPosition(Gate[i])
					moveObject(Gate[i], 5000, x+2, y, z)
				end
	
			elseif(gZellvar == 1) then
				if(gMoving == 1) then return end
				gMoving = 1
				gZellvar = 0
				setTimer(function() gMoving = 0 end, 5000, 1)
				for i = 1, #Gate, 1 do
					local x, y, z = getElementPosition(Gate[i])
					moveObject(Gate[i], 5000, x-2, y, z)
				end
			end
		end
	end

end)




-- JAIL SYSTEM --

local jailPos = {
	[1] = "1376.939453125, -46.603816986084, 1000.9193725586", -- Anfang, unten
	[2] = "1381.9990234375, -45.420997619629, 1000.922668457",
	[3] = "1387.6263427734, -46.015129089355, 1000.9233398438",
	[4] = "1386.9331054688, -18.301956176758, 1000.9215087891",
	[5] = "1381.2565917969, -18.225662231445, 1000.9243164063",
	[6] = "1375.333984375, -17.80627822876, 1000.921875",
	[7] = "1369.9116210938, -17.562162399292, 1000.921875",
	[8] = "1364.1373291016, -17.523851394653, 1000.921875", -- Hier drunter obene Ebene, Anfang oben
	[9] = "1376.8887939453, -45.78698348999, 1003.6454467773",
	[10] = "1381.9886474609, -46.177822113037, 1003.6454467773",
	[11] = "1387.8675537109, -45.573421478271, 1003.6454467773",
	[12] = "1386.8698730469, -18.004972457886, 1003.6454467773",
	[13] = "1381.0791015625, -18.039392471313, 1003.6454467773",
	[14] = "1375.271484375, -18.344411849976, 1003.6454467773",
	[15] = "1369.9536132813, -18.009336471558, 1003.6454467773",
	[16] = "1364.2487792969, -18.162336349487, 1003.6454467773",
}

local Jailsphere = createColSphere(1369.1683349609, -44.86234664917, 1000.9186401367, 8)
setElementInterior(Jailsphere, 1)
local Jailsphere2 = createColSphere(634.61560058594, -564.71392822266, 16.335937, 8)

addCommandHandler("jaila", 
function(thePlayer, cmd, target, typ)
	if not(target) then outputChatBox("Du musst ein Ziel eintippen!", thePlayer, 200, 0, 0, false) return end
	if not(typ) then outputChatBox("Du musst ein Typ eingeben![1 = Gestellt, 0 = Nicht gestellt", thePlayer, 200, 0, 0, false) return end
	local typ = tonumber(typ)
	if(typ < 0) or (typ > 1) then outputChatBox("Ungueltiger Typ!", thePlayer, 200, 0, 0, false) return end
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	local target = getPlayerFromName(target)
	if not(target) then outputChatBox("Spieler nicht gefunden!", thePlayer, 200, 0, 0, false) return end
	if (isPedInVehicle(thePlayer) == false) then outputChatBox("Du musst in einem Auto sein!", thePlayer, 200, 0, 0, false) return end
	if (isPedInVehicle(target) == false) then outputChatBox("Der Spieler muss in einem Auto sein!", thePlayer, 200, 0, 0, false) return end
	if(isElementWithinColShape(thePlayer, Jailsphere2) == false) then outputChatBox("Du bist nicht nage genug am Einknastort!(Colshape vorm PD)", thePlayer, 200 ,0, 0, false) return end
	if(isElementWithinColShape(target, Jailsphere2) == false) then outputChatBox("Der Spieler ist nicht nahe genug am Einknastort!", thePlayer, 200 ,0, 0, false) return end
	if(tonumber(getElementData(target, "pJail")) == 1) then outputChatBox("Der Spieler ist schon im Gefaengnis!", thePlayer, 200, 0, 0, false) return end
	local wanteds = tonumber(getElementData(target, "pWanteds"))	
	if(wanteds == 0) then outputChatBox("Der Spieler hat keine Wanteds!", thePlayer, 200, 0, 0, false) return end
	takeAllWeapons(target)
	setElementData(target, "pJail", 1)	
	local zeit = 0
	local geld = 0
	if(typ == 1) then

		if(wanteds == 1) then zeit = 7 geld = 100 end
		if(wanteds == 2) then zeit = 14 geld = 200 end
		if(wanteds == 3) then zeit = 21 geld = 500 end
		if(wanteds == 4) then zeit = 28 geld = 1000 end
		if(wanteds == 5) then zeit = 35 geld = 2000 end
		if(wanteds == 6) then zeit = 43 geld = 5000 end	
	elseif(typ == 0) then
		if(wanteds == 1) then zeit = 10 geld = 200 end
		if(wanteds == 2) then zeit = 20 geld = 400 end
		if(wanteds == 3) then zeit = 30 geld = 800 end
		if(wanteds == 4) then zeit = 40 geld = 1600 end
		if(wanteds == 5) then zeit = 50 geld = 2800 end
		if(wanteds == 6) then zeit = 60 geld = 10000 end		
	end
	setElementData(target, "pJailtime", zeit)
	removePedFromVehicle(target)
	triggerEvent("setPlayerToGefaengnis", target)
	setElementData(target, "pHGeld", tonumber(getElementData(target, "pHGeld"))-geld)
	setElementData(target, "pWanteds", 0)
	outputChatBox("Du wurdest von Polizist "..getPlayerName(thePlayer).." fuer "..zeit.." Minuten und "..geld.." $ ins Gefaengnis gesteckt.", target, 200, 50, 0, false)
	outputChatBox("Du hast "..getPlayerName(target).." fuer "..zeit.." Minuten und "..geld.." $ eingeknastet.", thePlayer, 0, 200, 0, false)
	takeAllWeapons(target)
	
end)

addCommandHandler("jail", 
function(thePlayer, cmd, target, typ)
	if not(target) then outputChatBox("Du musst ein Ziel eintippen!", thePlayer, 200, 0, 0, false) return end
	if not(typ) then outputChatBox("Du musst ein Typ eingeben![1 = Gestellt, 0 = Nicht gestellt", thePlayer, 200, 0, 0, false) return end
	local typ = tonumber(typ)
	if(typ < 0) or (typ > 1) then outputChatBox("Ungueltiger Typ!", thePlayer, 200, 0, 0, false) return end
	if (getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then else return end
	local target = getPlayerFromName(target)
	if not(target) then outputChatBox("Spieler nicht gefunden!", thePlayer, 200, 0, 0, false) return end
	if(isElementWithinColShape(thePlayer, Jailsphere) == false) then outputChatBox("Du bist nicht nage genug am Einknastort!(Colshape im Knst)", thePlayer, 200 ,0, 0, false) return end
	if(isElementWithinColShape(target, Jailsphere) == false) then outputChatBox("Der Spieler ist nicht nahe genug am Einknastort!", thePlayer, 200 ,0, 0, false) return end
	if(tonumber(getElementData(target, "pJail")) == 1) then outputChatBox("Der Spieler ist schon im Gefaengnis!", thePlayer, 200, 0, 0, false) return end
	local wanteds = tonumber(getElementData(target, "pWanteds"))	
	if(wanteds == 0) then outputChatBox("Der Spieler hat keine Wanteds!", thePlayer, 200, 0, 0, false) return end
	takeAllWeapons(target)
	setElementData(target, "pJail", 1)	
	local zeit = 0
	local geld = 0
	if(typ == 1) then

		if(wanteds == 1) then zeit = 7 geld = 100 end
		if(wanteds == 2) then zeit = 14 geld = 200 end
		if(wanteds == 3) then zeit = 21 geld = 500 end
		if(wanteds == 4) then zeit = 28 geld = 1000 end
		if(wanteds == 5) then zeit = 35 geld = 2000 end
		if(wanteds == 6) then zeit = 43 geld = 5000 end	
	elseif(typ == 0) then
		if(wanteds == 1) then zeit = 10 geld = 200 end
		if(wanteds == 2) then zeit = 20 geld = 400 end
		if(wanteds == 3) then zeit = 30 geld = 800 end
		if(wanteds == 4) then zeit = 40 geld = 1600 end
		if(wanteds == 5) then zeit = 50 geld = 2800 end
		if(wanteds == 6) then zeit = 60 geld = 10000 end		
	end
	setElementData(target, "pJailtime", zeit)
	triggerEvent("setPlayerToGefaengnis", target)
	setElementData(target, "pHGeld", tonumber(getElementData(target, "pHGeld"))-geld)
	setElementData(target, "pWanteds", 0)
	outputChatBox("Du wurdest von Polizist "..getPlayerName(thePlayer).." fuer "..zeit.." Minuten und "..geld.." $ ins Gefaengnis gesteckt.", target, 200, 50, 0, false)
	outputChatBox("Du hast "..getPlayerName(target).." fuer "..zeit.." Minuten und "..geld.." $ eingeknastet.", thePlayer, 0, 200, 0, false)
	takeAllWeapons(target)
	outputChatBox("(( Polizist "..getPlayerName(thePlayer).." hat Verbrecher "..getPlayerName(target).." eingesperrt! ))", getRootElement(), 100, 255, 0, false)
end)

local knastTimer = {}

addEvent("setPlayerToGefaengnis", true)
addEventHandler("setPlayerToGefaengnis", getRootElement(),
function()
	local randomspawn = math.random(1, #jailPos)
	local x = gettok(jailPos[randomspawn], 1, ",")
	local y = gettok(jailPos[randomspawn], 2, ",")
	local z = gettok(jailPos[randomspawn], 3, ",")
	setElementPosition(source, x, y, z)
	setElementInterior(source, 1)
	setElementData(source, "Jailed", 1)
	if(getElementData(source, "tied") == true) then
		toggleAllControls(source, true)
		setPlayerMuted(source, false)
		setElementData(source, "tied", false)
	end
	local playa = source
	if(isTimer(knastTimer[playa])) then killTimer(knastTimer[playa]) end
	local data2 = tonumber(getElementData(playa, "pJailtime"))
	knastTimer[playa] = setTimer(function() checkForKnast(playa) end, 60000, data2)
end)

function checkForKnast(playa)
	if not(playa) and(knastTimer[playa]) then killTimer(knastTimer[playa]) return end
	if not(playa) then killTimer(knastTimer[playa]) return end
	if(playa == nil) then killTimer(knastTimer[playa]) return end
	if(tonumber(getElementData(playa, "Jailed")) == 0) then killTimer(knastTimer[playa]) return end
	local data = tonumber(getElementData(playa, "pJailtime"))
	setElementData(playa, "pJailtime", data-1)
	local data2 = tonumber(getElementData(playa, "pJailtime"))
		if(data2 < 1) then
			killTimer(knastTimer[playa])
			setElementData(playa, "pJail", 0)
			setElementData(playa, "pJailtime", 0)
			setElementData(playa, "Jailed", 0)
			setElementPosition(playa, 1361.4057617188, -44.862365722656, 1000.9240112305)
			outputChatBox("Du wurdest Entlassen. Versuch dich zu Bessern!", playa, 0, 200, 0, false)
			setElementData(playa, "pWanteds", 0)
		end
end

addCommandHandler("jailtime", 
function(thePlayer)
if(tonumber(getElementData(thePlayer, "Jailed")) == 0) then outputChatBox("Du bist nicht im Gefaengnis!", thePlayer, 200, 0, 0, false) return end
outputChatBox("Du bist noch fuer "..tonumber(getElementData(thePlayer, "pJailtime")).." minuten im Knast.", thePlayer, 200, 0, 0, false)
end)

addEventHandler("onPlayerQuit", getRootElement(),
function()
	if(tonumber(getElementData(source, "Jailed")) == 1) then killTimer(knastTimer[source]) end
end)