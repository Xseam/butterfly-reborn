-- Alle Funktionen bei MuLTi! --

function getFreeDimension(typ)
	local var
	local rand = math.random(1, 65535)
	for index, element in pairs(getElementsByType(typ)) do
		if(var == 1) then return end
		if(getElementDimension(element) == rand) then 
			var = 1
			getFreeDimension(typ)
		else
			var = 0
			return rand;
		end
	end
end

function round(num)
    return math.floor(num + 0.5)
end


function getPlayerFraktion(thePlayer)
	return tonumber(getElementData(thePlayer, "pFraktion"))
end
function getPlayerAdminlevel(thePlayer)
	return tonumber(getElementData(thePlayer, "pAdminlevel"))
end

function getPlayerFraktionsrang(thePlayer)
	return tonumber(getElementData(thePlayer, "pFraktionsrang"))
end

function isLoggedIn(thePlayer)
	if(getElementData(thePlayer, "inLogin") == true) then return false else return true end
end

function addPlayerHealth ( player, value )

	if isElement ( player ) then
		local health = getElementHealth( player )
		if(health > 99) then setElementHealth ( player, 100) return end
		
		local total = getElementHealth ( player ) + value
		if total > 99 then
			setElementHealth ( player, 100 )
		else
			setElementHealth ( player, total )
		end
	end
end
function removePlayerItem(thePlayer, theItem, value)
	if(getPlayerName(thePlayer)) then
		local data = getElementData(thePlayer, theItem)
		if(data) then
			if(tonumber(data) ~= nil) then -- Numeric
				data = tonumber(getElementData(thePlayer, theItem))
				if(data-value < 0) then return end 
				setElementData(thePlayer, theItem, data-value)
			else
				setElementData(thePlayer, theItem, data-value)
			end
		end
	end
end
function givePlayerItem(thePlayer, theItem, value)
	if(getPlayerName(thePlayer)) then
		local data = getElementData(thePlayer, theItem)
		if(data) then
			if(tonumber(data) ~= nil) then -- Numeric
				data = tonumber(getElementData(thePlayer, theItem))
				setElementData(thePlayer, theItem, data+value)
			else
				setElementData(thePlayer, theItem, data+value)
			end
		end
	end
end


function hasPlayerHandy(thePlayer)
 	if not(getElementData(thePlayer, "pHandynummer")) or not (tonumber(getElementData(thePlayer, "pHandynummer"))) or (tonumber(getElementData(thePlayer, "pHandynummer")) == 0) then
		return false
	else
		return true
	end
end


function isACop(thePlayer)
	if(getPlayerFraktion(thePlayer) == 4) or (getPlayerFraktion(thePlayer) == 7) then return true else return false end
end

function isAGangMember(thePlayer)
	if(getPlayerFraktion(thePlayer) == 1) or (getPlayerFraktion(thePlayer) == 2) or (getPlayerFraktion(thePlayer) == 7) then return true else return false end
end

function getElementsSpeed(theElement)
    if isElement(theElement) then
        local vx, vy, vz = getElementVelocity(theElement)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161 * 1.35
    end
    return 0
end

function getDistanceBetweenElements(element1, element2)
	local x, y, z = getElementPosition(element1)
	local x1, y1, z1 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
end