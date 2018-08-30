local Pennerskins = { 60, 26, 32, 34, 134, 135, 136, 137}
-- SPAWN --
function setToSpawn()
	if(getElementType(source) == "player") then
	local data = tonumber(getElementData(source, "pFraktion"))
	local geld = tonumber(getElementData(source, "pHGeld" ))
	local offlinemsg = getElementData(source, "pOfflinemsg" )
	local stvo = tonumber(getElementData(source, "pSTVO"))
	if(stvo) and (stvo > 14) then
		outputChatBox("Information: Dein Fuehrerschein wurde dir Abgenommen, da du ueber 14 STVO-Punkte hast.", source, 255, 0, 0)
		setElementData(source, "pFSchein", 0)
		setElementData(source, "pSTVO", 0)
		if(stvo > 2000) then
			outputServerLog(getPlayerName(source).." hat ueber 2000 STVO-Punkte! Something is not right here...")
		end
	end
	setPlayerMoney(source, 0)
	givePlayerMoney(source, geld)
	toggleAllControls(source, true)
	setElementModel(source, tonumber(getElementData(source, "pSkin")))
	setCameraTarget(source, source)
	setElementHealth(source, 100)
	local knast = tonumber(getElementData(source, "pJail"))
	if(offlinemsg == "") then else outputChatBox(offlinemsg, source, 200, 200, 0) mysql_query(handler,"UPDATE accounts SET OFFLINEMSG = '' WHERE NAME = '"..getPlayerName(source).."'") setElementData(source, "pOfflinemsg", "") end
	if(knast == 1) then
		triggerEvent("setPlayerToGefaengnis", source)
		resetThisSachen(source)
		outputChatBox("Du bist noch fuer "..tonumber(getElementData(source, "pJailtime")).." Minuten im Gefaengnis!", source, 200, 0, 0, false)
	return end
	local skin = getElementModel(source)
	if(skin == 0) then
		local randomSkin = math.random(#Pennerskins)
		setElementData(source, "pSkin", Pennerskins[randomSkin])
		setElementModel(source, Pennerskins[randomSkin] )
	end
	local spawnpunkt = tonumber(getElementData(source, "pSpawn"))
	setPlayerHudComponentVisible(source, "radar", true)
	if(spawnpunkt == 0) then -- Noobspawn
			setElementPosition(source, 268.58428955078, -24.63698387146, 1.9817626476288) 
			setElementInterior(source, 0)
			resetThisSachen(source)
			local hours = tonumber(gettok ( getElementData(source, "pSpielzeit"), 1, ":" ))
			local minutes = tonumber(gettok ( getElementData(source, "pSpielzeit"), 2, ":" ))
			local intro = getElementData(source, "doingIntro")
			
			if(hours < 1) and (minutes < 1) and (intro ~= true) then
				
				triggerClientEvent(source, "startWillkommenMenue", source)
				--[[
				setElementData(source, "inIntro", true)
				setElementDimension(source, 1)
				setElementHealth(source, 100)
				setPedArmor(source, 100)
				setPlayerHudComponentVisible(source, "radar", false)
				setElementPosition(source, -66.878890991211, 1534.0734863281, 14.427019119263)
				setElementModel(source, 287)
				giveWeapon(source, 31, 999999, true)
				--]]
			end
	elseif(spawnpunkt == 1) then -- Fraktion
		if (data == 0) or (data == nil) then -- Penner
			setElementPosition(source, 268.58428955078, -24.63698387146, 1.9817626476288) 
			setElementInterior(source, 0)
			resetThisSachen(source)
		elseif(data == 1) then -- Yakuza
			setElementPosition(source, -50.698333740234, -230.36587524414, 6.7646160125732) 
			setElementInterior(source, 0)
			resetThisSachen(source)
		elseif(data == 2) then -- Terror
			setElementPosition(source, -801.75653076172, -821.73602294922, 148.8828125)
			setElementInterior(source, 0)
			resetThisSachen(source)
		elseif(data == 3) then -- Fahrschule
			setElementPosition(source, -2034.9948730469, -114.85043334961, 1035.171875)
			setElementInterior(source, 3)
			resetThisSachen(source)

		elseif(data == 4) then -- RCPD
			setElementPosition(source, 252.07521057129, 69.465965270996, 1003.640625)
			setElementInterior(source, 6)
			resetThisSachen(source)
			setElementData(source, "pStrassensperre", 1)
			setElementData(source, "swat", 0)
			setElementData(source, "dienst", 0)
			setElementData(source, "insperre", 0)
			if(tonumber(getElementData(source, "pFraktionsrang")) > 2) then setElementData(source, "pNailroad", 1) end

		elseif(data == 5) then -- RCNR
			setElementPosition(source, 2260.8688964844, 76.298141479492, 30.760498046875)
			setElementInterior(source, 0)
			resetThisSachen(source)
			setElementData(source, "pPresseausweis", 1)
			giveWeapon(source, 43, 50)
		elseif(data == 6) then -- RB
			setElementPosition(source, 1108.9733886719, -304.42404174805, 73.9921875)
			setElementInterior(source, 0)
			resetThisSachen(source)		
		elseif(data == 7) then -- FBI
			setElementPosition(source, 2524.5014648438, -1281.7750244141, 1048.2890625)
			setElementInterior(source, 2)
			resetThisSachen(source)
			setElementData(source, "pStrassensperre", 1)
			setElementData(source, "swat", 0)
			setElementData(source, "dienst", 0)
			setElementData(source, "insperre", 0)
			if(tonumber(getElementData(source, "pFraktionsrang")) > 2) then setElementData(source, "pNailroad", 1) end
		end
	elseif(spawnpunkt == 2) then -- Haus
		local x, y, z, int, dim = getPlayerHouse(source)
		if int == 0 and dim == 0 then 
			outputChatBox("Du hast kein Haus mehr, dein Spawnpunkt wurde auf 'Srasse' geaendert.", source, 0, 200, 0, false)
			setElementData(source, "pSpawn", 0)
			triggerEvent("onXPSpawn", source)
			resetThisSachen(source)
		return 
		else
			setElementInterior(source, int)
			setElementDimension(source, dim)
			setElementPosition(source, x, y, z)
			resetThisSachen(source)
		end
	elseif(spawnpunkt == 3) then -- Area51
			setElementPosition(source, 246.55770874023, 1859.5083007813, 14.084012985229)
			setElementInterior(source, 0)
			resetThisSachen(source)
			setElementData(source, "pStrassensperre", 1)
			setElementData(source, "swat", 0)
			setElementData(source, "dienst", 0)
			setElementData(source, "insperre", 0)
			if(tonumber(getElementData(source, "pFraktionsrang")) > 2) then setElementData(source, "pNailroad", 1) end
	end
		local result = mysql_query( handler, "SELECT * FROM accounts WHERE NAME = \'"..getPlayerName(source).."\';" )
		if(result) then
			local row = mysql_fetch_assoc(result)
			local x, y, z = tonumber(row['X']), tonumber(row['Y']), tonumber(row['Z'])
			local waffen = row['WAFFEN']
			if(waffen == "0") then else
			for i = 1, 12 do
			local wstring = gettok ( waffen, i, string.byte( '|' ) )
					if wstring then
						if wstring then
							if #wstring >= 3 then
							local weapon = tonumber ( gettok ( wstring, 1, string.byte( ',' ) ) )
							local ammo = tonumber ( gettok ( wstring, 2, string.byte( ',' ) ) )
							giveWeapon ( source, weapon, ammo, true )
						end
					end
				end
			end
			end
			mysql_query(handler,"UPDATE accounts SET WAFFEN = '0' WHERE NAME = '"..getPlayerName(source).."'")
			if(x == 0) and (y == 0) and (z == 0) then return end
			setElementPosition(source, x, y, z)
			setElementInterior(source, 0)
			setElementDimension(source, 0)
			mysql_query(handler,"UPDATE accounts SET X = '0' WHERE NAME = '"..getPlayerName(source).."'")
			mysql_query(handler,"UPDATE accounts SET Y = '0' WHERE NAME = '"..getPlayerName(source).."'")
			mysql_query(handler,"UPDATE accounts SET Z = '0' WHERE NAME = '"..getPlayerName(source).."'")
			
		end
	else
		return
	end

end

addEvent("onXPSpawn", true)
addEventHandler("onXPSpawn", getRootElement(), setToSpawn)


function resetThisSachen(thePlayer)
	setElementFrozen(thePlayer, false)
	setCameraTarget(thePlayer, thePlayer)
end

function getPlayerHouse(thePlayer)
	local var = 0
	local mvar = 0
	local x, y, z, int, dim
	for index, col in pairs(getElementsByType("colshape")) do
			if(getElementData(col, "HAUS") == true) then
				if(getElementData(col, "HBESITZER") == getPlayerName(thePlayer)) then
					intx, inty, intz, int, dim = getElementData(col, "HINTX"), getElementData(col, "HINTY"), getElementData(col, "HINTZ"), getElementData(col, "HINT"), getElementData(col, "HID")
					var = 1
					return intx, inty, intz, int, dim, 1, miete, mietend
				end
			end
		end
	if(var == 0) then
	for index, col in pairs(getElementsByType("colshape")) do
			if(getElementData(col, "HAUS") == true) then
					local mieter = getElementData(col, "HMIETER")
					local me = getPlayerName(thePlayer)
					local mieter1 = gettok(mieter, 1, "|")
					local mieter2 = gettok(mieter, 2, "|")
					local mieter3 = gettok(mieter, 3, "|")
					local mieter4 = gettok(mieter, 4, "|")
					local mieter5 = gettok(mieter, 5, "|")
					if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then
							intx, inty, intz, int, dim, miete, mietend = getElementData(col, "HINTX"), getElementData(col, "HINTY"), getElementData(col, "HINTZ"), getElementData(col, "HINT"), getElementData(col, "HID"), getElementData(col, "HMIETPREIS"), getElementData(col, "HMIETEND")
							mvar = 1
					end
			end
		end
		if(mvar == 1) then if(miete) then return intx, inty, intz, int, dim, 2, miete, mietend else return intx, inty, intz, int, dim, 2, 0, mietend end else return 0, 0, 0, 0, 0, 0, 0 end
	end
end

--[[
function setPlayerToSpawnpunktHaus(thePlayer)
	local intx, inty, intz, int, dim, var
		for index, col in pairs(getElementsByType("colshape")) do
				if(getElementData(col, "HAUS") == true) then
					if(getElementData(col, "HBESITZER") ~= getPlayerName(thePlayer)) then
								if(var == 1) then return end
								local mieter = getElementData(col, "HMIETER")
								local me = getPlayerName(thePlayer)
								local mieter1 = gettok(mieter, 1, "|")
								local mieter2 = gettok(mieter, 2, "|")
								local mieter3 = gettok(mieter, 3, "|")
								local mieter4 = gettok(mieter, 4, "|")
								local mieter5 = gettok(mieter, 5, "|")
								if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then
									intx, inty, intz, int, dim = getElementData(col, "HINTX"), getElementData(col, "HINTY"), getElementData(col, "HINTZ"), getElementData(col, "HINT"), getElementData(col, "HID") 
									setElementInterior(source, int)
									setElementDimension(source, dim)
									setElementPosition(source, intx, inty, intz)
									var = 1
								else
									outputChatBox("Du hast kein Haus mehr, dein Spawnpunkt wurde auf 'Srasse' geaendert.", source, 0, 200, 0, false)
									setElementData(source, "pSpawn", 0)
									triggerEvent("onXPSpawn", source)
									
								end
							else
							intx, inty, intz, int, dim = getElementData(col, "HINTX"), getElementData(col, "HINTY"), getElementData(col, "HINTZ"), getElementData(col, "HINT"), getElementData(col, "HID") 
							setElementInterior(source, int)
							setElementDimension(source, dim)
							setElementPosition(source, intx, inty, intz)
							var = 1
						end
				end	
		end
end
--]]