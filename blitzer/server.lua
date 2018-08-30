local erlaubt = 86
local geldmultiply = 1.15

local positions = {
	[1] = "681.83935546875, -645.21179199219, 16.1875, 8", -- Dillimore
	[2] = "232.84259033203, -180.63667297363, 1.4296875, 8", -- Blueberry
	[3] = "1241.4364013672, 346.94528198242, 19.40625, 8", -- Montgomery
	[4] = "2265.6098632813, 41.606163024902, 26.3359375, 8" -- Palomino Creek
}




addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
	for i = 1, #positions, 1 do
		local col = createColSphere(gettok(positions[i], 1, ","), gettok(positions[i], 2, ","), gettok(positions[i], 3, ","), gettok(positions[i], 4, ","))
		if(col) then
			addEventHandler("onColShapeHit", col, function(hitElement) -- Event
				if(getElementType(hitElement) == "vehicle") then -- wenn es ein Auto ist
					if(getVehicleOccupant(hitElement)) then -- wenn ein Spieler drinne sitzt
						local speed = math.ceil(getBlitzerSpeed(hitElement)/2)
						if(speed > erlaubt) then
							local playa = getVehicleOccupant(hitElement)
							local ueberschritten = speed-erlaubt
							triggerClientEvent(playa, "onBlitzerStart", playa, speed, ueberschritten)
							local x, y, z = getElementPosition(playa)
							local zone = getZoneName(x, y, z, false)
							local bussgeld = math.ceil(ueberschritten*geldmultiply)
							if(bussgeld > 5000) then outputChatBox("Das Bussgeld wurde dir nicht erteilt, da es ueber 5000$ liegt!", playa, 0, 200, 0) return end
							setElementData(playa, "pBlitzer", "Blitzerrechnung: \n_________\nOrt: "..zone..", Geschwindigkeit: "..speed.." km/h\nErlaubt: "..erlaubt.." km/h\nUeberschreitung: "..ueberschritten.." km/h\n_________\nBussgeld: "..bussgeld.."$")
							removePlayerItem(playa, "pBGeld", bussgeld)
							local time = getRealTime()
							local day = time.monthday
							local month = time.month+1
							local year = time.year+1900
							local hour = time.hour
							local minute = time.minute
							triggerClientEvent(playa, "writeToPaylog", playa, day.."."..month.."."..year.." um "..hour..":"..minute.."|".."Blitzerrechnung in "..zone..": "..bussgeld.."$", "KACKE")
							local query = "SELECT * FROM kassen"
							local result = mysql_query( handler, query )
							if ( result and mysql_num_rows( result ) > 0) then
								local row = mysql_fetch_assoc(result)
								local r = mysql_query(handler,"UPDATE kassen SET RCPD = '"..(row['RCNR']+bussgeld).."'")
								mysql_free_result(result)
								mysql_free_result(r)
							else 
							end
						end
					end
				end
			end)
		else -- wenn kein Col erstellt werden konnte
			outputDebugString("Blitzer "..i.." konnte nicht erstellt werden!")
		end
	end
	outputDebugString(#positions.." Blitzer geladen.")
end)


function getBlitzerSpeed(theElement)
    if isElement(theElement) then
        local vx, vy, vz = getElementVelocity(theElement)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161 * 1.35
    end
    return 0
end