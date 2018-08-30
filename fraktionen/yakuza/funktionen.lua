local Marker1 = createMarker(-50.624805450439, -233.66194152832, 6.7646160125732, "corona", 1.0, 255, 255, 255, 200) -- Unten
local Marker2 = createMarker(-75.581176757813, -245.59707641602, 32.548904418945, "corona", 1.0, 255, 255, 255, 200) -- Oben
local Hifi = createObject(2099, -77.599998474121, -232.30000305176, 40.200000762939, 0, 0, 230) -- HIFI
local Marker3 = createMarker(-83.912246704102, -233.54902648926, 41.226745605469, "corona", 1.0, 255, 255, 255, 200) -- Oben Lounge
local Marker4 = createMarker(-49.905059814453, -269.36730957031, 6.633186340332, "corona", 1.0, 255, 255, 255, 200) -- Unten lounge
-- -83.779098510742, -231.69065856934, 41.226745605469 Oben spawn
-- -49.968383789063, -271.82604980469, 6.633186340332 Unten sawn
		
addEventHandler( "onElementClicked", getRootElement(),
function ( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
        if(source == Hifi) then
		triggerClientEvent("onHifiClickedYakuza", thePlayer)
		end
	end
end	) 

addEventHandler("onMarkerHit", Marker4,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if not(getPlayerFraktion(hitElement) == 1) then outputChatBox("Du bist kein Mitglied!", hitElement, 200, 0, 0, false) return end
	setInPosition(hitElement, -83.779098510742, -231.69065856934, 41.226745605469, 0)
end)

addEventHandler("onMarkerHit", Marker3,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if not(getPlayerFraktion(hitElement) == 1) then outputChatBox("Du bist kein Mitglied!", hitElement, 200, 0, 0, false) return end
	setInPosition(hitElement, -49.968383789063, -271.82604980469, 6.633186340332, 0)
end)

addEventHandler("onMarkerHit", Marker1,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if not(getPlayerFraktion(hitElement) == 1) then outputChatBox("Du bist kein Mitglied!", hitElement, 200, 0, 0, false) return end
	setInPosition(hitElement, -72.207748413086, -245.86357116699, 32.579357147217, 0)
end)

addEventHandler("onMarkerHit", Marker2,
function(hitElement)
	if (getElementType(hitElement) == "vehicle") then return end
	if not(getPlayerFraktion(hitElement) == 1) then outputChatBox("Du bist kein Mitglied!", hitElement, 200, 0, 0, false) return end
	setInPosition(hitElement, -50.424270629883, -230.36627197266, 6.7646160125732, 0)
end)

addCommandHandler("tie",
function(thePlayer, command, target)
	if not(getPlayerFraktion(thePlayer) == 1) then return end
	if not(target) then return end
	local target = getPlayerFromName(target)
	if not (target) then outputChatBox("Ungueltiger Spieler!", thePlayer, 200, 0, 0, false)  return end
	local x, y, z = getElementPosition(target)
	local x1, y1, z1 = getElementPosition(thePlayer)
	if(target == thePlayer) then outputChatBox("Du kannst dich nicht fesseln/entfesseln!", thePlayer, 200, 0, 0, false) return end
	if(isPedInVehicle(target)) then else outputChatBox("Der Spieler muss in einem Auto sitzen!", thePlayer, 200, 0, 0) return end
	if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then outputChatBox("Du bist zu weit Weg!", thePlayer, 200, 0, 0, false) return end
	if(getElementData(target, "tied") == true) then
		fadeCamera(target, true, 0)
		toggleAllControls(target, true)
		setElementData(target, "tied", nil)
		setPlayerMuted(target, true)
		outputChatBox("Du wurdest entfesselt.", target, 0, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde entfesselt", thePlayer, 0, 200, 0, false)
	else
		fadeCamera(target, false, 0)
		toggleAllControls(target, false)
		setElementData(target, "tied", true)
		setPlayerMuted(target, false)
		outputChatBox("Du wurdest Gefesselt!", target, 255, 200, 0, false)
		outputChatBox("Spieler "..getPlayerName(target).." wurde gefesselt!", thePlayer, 0, 200, 0, false)
	end
	
end
)
