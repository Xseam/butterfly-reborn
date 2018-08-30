local box = {}

box[1] = createObject(3016, 241.60000610352, -181.19999694824, 1.6000000238419, 0, 0, 0) -- Ammu Nation Blueberry
box[2] = createObject(3016, -60.700000762939, -219.69999694824, 5.0999999046326, 0, 0, 70) -- Yakuzabase
box[3] = createObject(3016, 2333.3000488281, 64, 26.60000038147, 0, 0, 30) -- Ammu nation bei Bank im ort
box[4] = createObject(3016, 1352.9000244141, 308.60000610352, 20.10000038147, 0, 0,  100) -- Ammu nation montgomery
box[5] = createObject(3016, 1386.3000488281, 383.20001220703, 19.799999237061, 0, 0, 0) -- Fahrschule
box[6] = createObject(3016, -800.20001220703, -826.59997558594, 148.69999694824, 0, 0, 30) -- Terrorbase
box[7] = createObject(3016, 610.40002441406, -554.70001220703, 16.799999237061, 0, 0, 0) -- RCPD
box[8] = createObject(3016, 1106.4300537109, -316.2799987793, 74.26000213623, 0, 0, 0) -- Red Brothers

for b = 1, #box, 1 do
	setElementData(box[b], "WAFFENBOX", true)
end

		
addEventHandler( "onElementClicked", getRootElement(),
function( theButton, theState, thePlayer )
    if theState == "down" and theButton == "left" then 
		if(isAWaffenBox(source) == false) then return end
		local x, y, z = getElementPosition(thePlayer) local x1, y1, z1 = getElementPosition(source) if(getDistanceBetweenPoints3D(x, y, z, x1, y1, z1) > 10) then return end
		triggerClientEvent(thePlayer,"onWaffenboxGUIStart", thePlayer)
	end
end
)

function isAWaffenBox(element)
	if(getElementData(element, "WAFFENBOX") == true) then return true;
	else return false; end
end

addEvent("onWaffenboxDataNeed", true)
addEventHandler("onWaffenboxDataNeed", getRootElement(),
function()
if not(source) then return end
	local name = getPlayerName(source)
	local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
	local result = mysql_query( handler, query )
	local row = mysql_fetch_assoc( result )
	local w1 = row['SLOT1WAFFE']
	local w1a = row['SLOT1AMMU']
	local w2 = row['SLOT2WAFFE']
	local w2a = row['SLOT2AMMU']
	local w3 = row['SLOT3WAFFE']
	local w3a = row['SLOT3AMMU']
	local w4 = row['SLOT4WAFFE']
	local w4a = row['SLOT4AMMU']
	local w5 = row['SLOT5WAFFE']
	local w5a = row['SLOT5AMMU']
	triggerClientEvent(source, "onWaffenboxDataNeedBack", source, w1, w1a, w2, w2a, w3, w3a, w4, w4a, w5, w5a)
	mysql_free_result(result)
end)

addEvent("onWaffenboxAction", true)
addEventHandler("onWaffenboxAction", getRootElement(),
function(slot, var) -- VAR 0 = EINLAGERN, VAR 1 = RAUSNEHMEN, SLOT = SLOT
	if not(source) then return end
	if(slot == 1) then
		
		if(var == 1) then
			local name = getPlayerName(source)
			local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
			local result = mysql_query( handler, query )
			local row = mysql_fetch_assoc( result )
			giveWeapon(source, row['SLOT1WAFFE'], row['SLOT1AMMU'], true)
			mysql_query(handler,"UPDATE waffenbox SET SLOT1WAFFE = '0', SLOT1AMMU = '0' WHERE NAME = '"..getPlayerName(source).."'")
			triggerEvent("onWaffenboxDataNeed", source)
			mysql_free_result(result)
		elseif(var == 0) then
		local weapon = getPedWeapon ( source )
		local ammu = getPedTotalAmmo( source )
		if(weapon == 1) or (weapon == 0) then return end
			mysql_query(handler,"UPDATE waffenbox SET SLOT1WAFFE = '"..weapon.."', SLOT1AMMU = '"..ammu.."' WHERE NAME = '"..getPlayerName(source).."'")
			takeWeapon ( source, weapon)
			triggerEvent("onWaffenboxDataNeed", source)
		end
	elseif(slot == 2) then
		if(var == 1) then
			local name = getPlayerName(source)
			local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
			local result = mysql_query( handler, query )
			local row = mysql_fetch_assoc( result )
			giveWeapon(source, row['SLOT2WAFFE'], row['SLOT2AMMU'], true)
			mysql_query(handler,"UPDATE waffenbox SET SLOT2WAFFE = '0', SLOT2AMMU = '0' WHERE NAME = '"..getPlayerName(source).."'")
			triggerEvent("onWaffenboxDataNeed", source)
			mysql_free_result(result)
		elseif(var == 0) then
		local weapon = getPedWeapon ( source )
		local ammu = getPedTotalAmmo( source )
		if(weapon == 1) or (weapon == 0) then return end
			mysql_query(handler,"UPDATE waffenbox SET SLOT2WAFFE = '"..weapon.."', SLOT2AMMU = '"..ammu.."' WHERE NAME = '"..getPlayerName(source).."'")
			takeWeapon ( source, weapon)
			triggerEvent("onWaffenboxDataNeed", source)
		end
	elseif(slot == 3) then
		if(var == 1) then
			local name = getPlayerName(source)
			local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
			local result = mysql_query( handler, query )
			local row = mysql_fetch_assoc( result )
			giveWeapon(source, row['SLOT3WAFFE'], row['SLOT3AMMU'], true)
			mysql_query(handler,"UPDATE waffenbox SET SLOT3WAFFE = '0', SLOT3AMMU = '0' WHERE NAME = '"..getPlayerName(source).."'")
			triggerEvent("onWaffenboxDataNeed", source)
			mysql_free_result(result)
		elseif(var == 0) then
		local weapon = getPedWeapon ( source )
		local ammu = getPedTotalAmmo( source )
		if(weapon == 1) or (weapon == 0) then return end
			mysql_query(handler,"UPDATE waffenbox SET SLOT3WAFFE = '"..weapon.."', SLOT3AMMU = '"..ammu.."' WHERE NAME = '"..getPlayerName(source).."'")
			takeWeapon ( source, weapon)
			triggerEvent("onWaffenboxDataNeed", source)
		end
	elseif(slot == 4) then
		if(var == 1) then
			local name = getPlayerName(source)
			local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
			local result = mysql_query( handler, query )
			local row = mysql_fetch_assoc( result )
			giveWeapon(source, row['SLOT4WAFFE'], row['SLOT4AMMU'], true)
			mysql_query(handler,"UPDATE waffenbox SET SLOT4WAFFE = '0', SLOT4AMMU = '0' WHERE NAME = '"..getPlayerName(source).."'")
			triggerEvent("onWaffenboxDataNeed", source)
			mysql_free_result(result)
		elseif(var == 0) then
		local weapon = getPedWeapon ( source )
		local ammu = getPedTotalAmmo( source )
		if(weapon == 1) or (weapon == 0) then return end
			mysql_query(handler,"UPDATE waffenbox SET SLOT4WAFFE = '"..weapon.."', SLOT4AMMU = '"..ammu.."' WHERE NAME = '"..getPlayerName(source).."'")
			takeWeapon ( source, weapon)
			triggerEvent("onWaffenboxDataNeed", source)
		end
	elseif(slot == 5) then
		if(var == 1) then
			local name = getPlayerName(source)
			local query = "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';"
			local result = mysql_query( handler, query )
			local row = mysql_fetch_assoc( result )
			giveWeapon(source, row['SLOT5WAFFE'], row['SLOT5AMMU'], true)
			mysql_query(handler,"UPDATE waffenbox SET SLOT5WAFFE = '0', SLOT5AMMU = '0' WHERE NAME = '"..getPlayerName(source).."'")
			triggerEvent("onWaffenboxDataNeed", source)
			mysql_free_result(result)
		elseif(var == 0) then
		local weapon = getPedWeapon ( source )
		local ammu = getPedTotalAmmo( source )
		if(weapon == 1) or (weapon == 0) then return end
			mysql_query(handler,"UPDATE waffenbox SET SLOT5WAFFE = '"..weapon.."', SLOT5AMMU = '"..ammu.."' WHERE NAME = '"..getPlayerName(source).."'")
			takeWeapon ( source, weapon)
			triggerEvent("onWaffenboxDataNeed", source)
		end
	else return end
end
)