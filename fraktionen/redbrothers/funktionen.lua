local Hifi = createObject(2099,1113.0799560547, -310.13000488281, 72.98999786377, 0, 0, 180)
addEventHandler("onElementClicked", Hifi,
function(but, stat, thePlayer)
	if(but == "left") and (stat == "down") then
		triggerClientEvent(thePlayer, "onRedBrothersHifi", thePlayer)
	end
end)

addCommandHandler("tie",
function(thePlayer, command, target)
	if not(getPlayerFraktion(thePlayer) == 6) then return end
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
