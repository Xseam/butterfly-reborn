
--REGISTER

function register ( name,pw,land,geschlecht,alter )

	local source = getPlayerFromName(name)
	local serial = getPlayerSerial(source)
	local ip = getPlayerIP(source)
	
	local name_ = mysql_escape_string ( handler, name )
	local pw_ = mysql_escape_string ( handler, pw )
	local serial_ = mysql_escape_string ( handler, serial )
	local ip_ = mysql_escape_string ( handler, ip )
	local land_ = mysql_escape_string( handler, land )
	local geschlecht_ = mysql_escape_string( handler, geschlecht )
	
	local pwneu = md5(pw_)
	local query = "INSERT INTO accounts ( NAME, PASSWORD, AGE, GESCHLECHT, LAND, SERIAL, IP ) VALUES ( '"..name_.."', '"..pwneu.."', '"..alter.."', '"..geschlecht_.."', '"..land_.."', '"..serial_.."', '"..ip_.."' )"
	local result = mysql_query( handler, query )
	triggerEvent("onLoginDataNeed", source)
	if result then mysql_free_result(result) return true else return false end
	
end
addEvent( "onRegister", true )
addEventHandler( "onRegister", getRootElement(), register)

local randomAmbientCars = { 400, 401, 402, 411, 413, 419 }

addEvent("onAmbientCarCreate", true)
addEventHandler("onAmbientCarCreate", getRootElement(),
function(id)
	if(id == 1) then
		local rand = math.random(0, 5)
		local veh
		if(rand == 0) then veh = 416 end
		if(rand == 1) then veh = 402 end
		if(rand == 2) then veh = 407 end
		if(rand == 3) then veh = 596 end
		if(rand == 4) then veh = 599 end
		if(rand == 5) then veh = 589 end
		local ambientCar = createVehicle(veh, 230.39385986328, -18.44188117981, 1.5801894664764)
		setElementFrozen(ambientCar, true)
		setTimer(setElementFrozen, 250, 1, ambientCar, false)
		setElementRotation(ambientCar, 355.32092285156, 359.62609863281, 179.53814697266)

		local ambientPed = createPed(276, 230.39385986328, -18.44188117981, 1.5801894664764)
		setVehicleSirensOn(ambientCar, true)
		warpPedIntoVehicle(ambientPed, ambientCar)		
		setElementVisibleTo ( ambientCar, getRootElement(), false )
		setElementVisibleTo ( ambientPed, getRootElement(), false )
		
		setElementVisibleTo ( ambientCar, source, true )
		setElementVisibleTo ( ambientPed, source, true )
		triggerClientEvent(source, "setPedControl", source, ambientPed)
		setTimer(destroyElement, 10000, 1, ambientCar)
		setTimer(destroyElement, 10000, 1, ambientPed)
	elseif(id == 2) then
	--273.93524169922, -74.301376342773, 1.5220999717712
	--359.97717285156, 359.95776367188, 90.188598632813
	local rand = math.random(0, 5)
		local veh
		if(rand == 0) then veh = 557 end
		if(rand == 1) then veh = 539 end
		if(rand == 2) then veh = 515 end
		if(rand == 3) then veh = 503 end
		if(rand == 4) then veh = 486 end
		if(rand == 5) then veh = 455 end
		local playa = source
		local ambientCar = createVehicle(veh, 273.93524169922, -74.301376342773, 1.5220999717712)
		setVehicleHandling(ambientCar, "maxVelocity", 100)
		setElementFrozen(ambientCar, true)
		setTimer(setElementFrozen, 250, 1, ambientCar, false)
		setElementRotation(ambientCar, 359.97717285156, 359.95776367188, 90.188598632813)

		local ambientPed = createPed(276, 273.93524169922, -74.301376342773, 1.5220999717712)
		
		warpPedIntoVehicle(ambientPed, ambientCar)		
		setElementVisibleTo ( ambientCar, getRootElement(), false )
		setElementVisibleTo ( ambientPed, getRootElement(), false )
		
		setElementVisibleTo ( ambientCar, playa, true )
		setElementVisibleTo ( ambientPed, playa, true )
		triggerClientEvent(playa, "setPedControl", playa, ambientPed)
		setTimer(destroyElement, 10000, 1, ambientCar)
		setTimer(destroyElement, 10000, 1, ambientPed)
	elseif(id == 3) then
	-- 866.80352783203, 351.73706054688, 19.587312698364
	-- 359.87084960938, 359.99987792969, 102.853515625
		local rand = math.random(0, 5)
		local veh
		if(rand == 0) then veh = 487 end
		if(rand == 1) then veh = 579 end
		if(rand == 2) then veh = 554 end
		if(rand == 3) then veh = 541 end
		if(rand == 4) then veh = 560 end
		if(rand == 5) then veh = 559 end
		local playa = source
		local ambientCar = createVehicle(veh, 866.80352783203, 351.73706054688, 19.587312698364)
		setVehicleHandling(ambientCar, "maxVelocity", 100)
		setElementFrozen(ambientCar, true)
		setTimer(setElementFrozen, 250, 1, ambientCar, false)
		setElementRotation(ambientCar, 359.87084960938, 359.99987792969, 101.453515625)

		local ambientPed = createPed(276, 866.80352783203, 351.73706054688, 19.587312698364)
		
		warpPedIntoVehicle(ambientPed, ambientCar)		
		setElementVisibleTo ( ambientCar, getRootElement(), false )
		setElementVisibleTo ( ambientPed, getRootElement(), false )
		
		setElementVisibleTo ( ambientCar, playa, true )
		setElementVisibleTo ( ambientPed, playa, true )
		triggerClientEvent(playa, "setPedControl", playa, ambientPed)
		setTimer(destroyElement, 15000, 1, ambientCar)
		setTimer(destroyElement, 15000, 1, ambientPed)
	end

end)
addEvent( "warpPedIntoVehicle", true)
addEventHandler("warpPedIntoVehicle", getRootElement(),
function(ped, vehicle)
warpPedIntoVehicle(ped, vehicle)
end)

addEvent("onLoginDataNeed", true)
addEventHandler("onLoginDataNeed", getRootElement(),
function()
	local result = mysql_query( handler, "SELECT * FROM accounts WHERE NAME = '"..getPlayerName(source).."';")
	local player = source
	if ( result and mysql_num_rows( result ) > 0) then
		triggerClientEvent(player, "onLoginDataNeedBack", player, 1)
	else
		triggerClientEvent(player, "onLoginDataNeedBack", player, 2)
	end
	if(result) then mysql_free_result(result)end
end)

addEvent( "onLogin", true )
addEventHandler( "onLogin", getRootElement(),
function ( player, name, pw )

	local query = "SELECT * FROM accounts WHERE NAME = \'"..name.."\' AND PASSWORD = \'"..md5(pw).."\';"
	local result = mysql_query( handler, query )

	local result2 = mysql_query( handler, "SELECT * FROM inventar WHERE NAME = \'"..name.."\';" )
	if ( result2 and mysql_num_rows( result2 ) > 0) then
	else
		local query2 = "INSERT INTO inventar ( NAME, WUERFEL, ZIGARETTEN, BIERE, GEKAUFT ) VALUES ( '"..name.."', '0', '0', '0', '0' )"
		local result2 = mysql_query( handler, query2 )
		mysql_free_result(result2)
	end
	
	local result3 = mysql_query( handler, "SELECT * FROM scheine WHERE NAME = \'"..name.."\';" )
	if ( result3 and mysql_num_rows( result3 ) > 0) then
	else
		local query3 = "INSERT INTO scheine ( NAME, FSCHEIN, LKWSCHEIN, HELISCHEIN, FLUGSCHEIN, BOOTSSCHEIN, ANGELSCHEIN, MOTORRADSCHEIN ) VALUES ( '"..name.."', '0', '0', '0', '0', '0', '0', '0' )"
		local result3 = mysql_query( handler, query3 )
		mysql_free_result(result3)
	end
	local result4 = mysql_query( handler, "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';" )
	if ( result4 and mysql_num_rows( result4 ) > 0) then
	else
		local query4 = "INSERT INTO waffenbox ( NAME, SLOT1WAFFE, SLOT1AMMU, SLOT2WAFFE, SLOT2AMMU, SLOT3WAFFE, SLOT3AMMU, SLOT4WAFFE, SLOT4AMMU, SLOT5WAFFE, SLOT5AMMU ) VALUES ( '"..name.."', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0' )"
		local result4 = mysql_query( handler, query4 )
		mysql_free_result(result4)
	end
		local result5 = mysql_query( handler, "SELECT * FROM jobs WHERE NAME = \'"..name.."\';" )
	if ( result5 and mysql_num_rows( result5 ) > 0) then
	else
		local query5 = "INSERT INTO jobs ( NAME, CURJOB ) VALUES ( '"..name.."', '0' )"
		local result5 = mysql_query( handler, query5 )
		mysql_free_result(result5)
	end
	
		if ( result and mysql_num_rows( result ) > 0) then
		result2 = mysql_query( handler, "SELECT * FROM inventar WHERE NAME = \'"..name.."\';" )
		result3 = mysql_query( handler, "SELECT * FROM scheine WHERE NAME = \'"..name.."\';" )
		result4 = mysql_query( handler, "SELECT * FROM waffenbox WHERE NAME = \'"..name.."\';" )
		result5 = mysql_query( handler, "SELECT * FROM jobs WHERE NAME = \'"..name.."\';" )
		local row = mysql_fetch_assoc(result)
		local row2 = mysql_fetch_assoc(result2)
		local row3 = mysql_fetch_assoc(result3)
		local row4 = mysql_fetch_assoc(result4)
		local row5 = mysql_fetch_assoc(result5)
		
		while not(row2) do row2 = mysql_fetch_assoc(result2) if(row2) then break end end
		
		setElementData ( player, "pName", name )
		setElementData ( player, "pAdminlevel", row['ADMINLEVEL'] or 0 )
		setElementData ( player, "pBGeld", row['BANK_GELD'] or 0 )
		setElementData ( player, "pHGeld", row['HAND_GELD'] or 0 )
		setElementData ( player, "pStatus", row['STATUS'] or 'nil' )
		setElementData ( player, "pSpielzeit", row['SPIELZEIT'] or "00:00" )
		setElementData ( player, "pFraktion", row['FRAKTION'] or 0 )
		setElementData ( player, "pFraktionsrang", row['FRAKTIONSRANG'] or 0 )
		setElementData ( player, "pSkin", row['SKIN'] or 78 )
		setElementData ( player, "pMorde", row['MORDE'] or 0 )
		setElementData ( player, "pTode", row['TODE'] or 0 )
		setElementData ( player, "pWanteds", row['WANTEDS'] or 0 )
		setElementData ( player, "pSTVO", row['STVO'] or 0 )
		setElementData ( player, "pJail", row['JAIL'] or 0 )
		setElementData ( player, "pJailtime", row['JAILTIME'] or 0 )
		setElementData ( player, "pOfflinemsg", row['OFFLINEMSG'] or 0 )
		setElementData ( player, "pStrassensperre", 0 )
		setElementData ( player, "pNailroad", 0 )
		setElementData ( player, "pPresseausweis", 0 )
		setElementData ( player, "pZeitung", 0 )
		setElementData ( player, "pArztrechnung", "Keine Arztrechnung vorhanden." )
		setPlayerMoney ( player, getElementData(player,"pHGeld" ))
		setElementData ( player, "pPerso", row['PERSO'] or 0 )
		setElementData ( player, "pSpawn", row['SPAWN'] or 0 )
		setElementData ( player, "pHandynummer", row['HANDYNUMMER'] or 0 )
		setPlayerWantedLevel( player, getElementData(player, "pWanteds"))
		-- |0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|
		-- Inventar --
		setElementData ( player, "pWuerfel", row2['WUERFEL'] or 0 )
		setElementData ( player, "pZigaretten", row2['ZIGARETTEN'] or 0 )
		setElementData ( player, "pBiere", row2['BIERE'] or 0 )
		setElementData ( player, "pBGrill", row2['BGRILL'] or 0 )
		setElementData ( player, "pBLiege", row2['BLIEGE'] or 0 )
		setElementData ( player, "pBFackel", row2['BFACKEL'] or 0 )
		setElementData ( player, "pBLagerfeuer", row2['BLAGERFEUER'] or 0 )
		setElementData ( player, "pBretter", row2['BRETTER'] or 0 )
		setElementData ( player, "pKisten", row2['KISTEN'] or 0 )
		setElementData ( player, "pComputer", row2['COMPUTER'] or 0 )
		setElementData ( player, "pFeuer", row2['FEUER'] or 0 )
		setElementData ( player, "pSINV", row2['SINV'] or 0 )
		setElementData ( player, "pMISC", row2['MISC'] or 0 )
		setElementData ( player, "pAngel", row2['ANGEL'] or 0)
		setElementData ( player, "pKoeder", row2['KOEDER'] or 0)
		setElementData ( player, "pFische", row2['FISCHE'] or 0)
		setElementData ( player, "pErstehilfe", row2['ERSTEHILFE'] or 0)
		setElementData ( player, "pKanister", row2['KANISTER'] or 0)
		setElementData ( player, "pSFernseher", row2['FERNSEHER'] or 0)
		setElementData ( player, "pRadios", row2['RADIOS'] or 0)
		-- Scheine --
		setElementData ( player, "pFSchein", row3['FSCHEIN'] or 0 )
		setElementData ( player, "pLKWSchein", row3['LKWSCHEIN'] or 0 )
		setElementData ( player, "pHELISchein", row3['HELISCHEIN'] or 0 )
		setElementData ( player, "pFLUGSchein", row3['FLUGSCHEIN'] or 0 )
		setElementData ( player, "pBOOTSSchein", row3['BOOTSSCHEIN'] or 0 )
		setElementData ( player, "pANGELSchein", row3['ANGELSCHEIN'] or 0 )
		setElementData ( player, "pMOTORRADSchein", row3['MOTORRADSCHEIN'] or 0 )
		-- Waffenbox --
		setElementData ( player, "pSLOT1WAFFE", row4['SLOT1WAFFE'] or 0 )
		setElementData ( player, "pSLOT1MUNI", row4['SLOT1MUNI'] or 0 )
		setElementData ( player, "pSLOT2WAFFE", row4['SLOT2WAFFE'] or 0 )
		setElementData ( player, "pSLOT2MUNI", row4['SLOT2MUNI'] or 0 )
		setElementData ( player, "pSLOT3WAFFE", row4['SLOT3WAFFE'] or 0 )
		setElementData ( player, "pSLOT3MUNI", row4['SLOT3MUNI'] or 0 )
		setElementData ( player, "pSLOT4WAFFE", row4['SLOT4WAFFE'] or 0 )
		setElementData ( player, "pSLOT4MUNI", row4['SLOT4MUNI'] or 0 )
		setElementData ( player, "pSLOT5WAFFE", row4['SLOT5WAFFE'] or 0 )
		setElementData ( player, "pSLOT5MUNI", row4['SLOT5MUNI'] or 0 )
		-- Jobs --
		setElementData ( player, "pCurjob", row5['CURJOB'] or 0 )
		setElementData ( player, "pHandystate", true)
		-- Andere --
		setElementData( player, "inLogin", false)
		mysql_free_result(result)
		mysql_free_result(result2)
		mysql_free_result(result3)
		mysql_free_result(result4)
		mysql_free_result(result5)
		
			addEventHandler( "onElementDataChange", source, 
			function ( data )
		
				if data == "pAdminlevel" then
				
					local newData = getElementData( source, "pAdminlevel" )
					mysql_query(handler,"UPDATE accounts SET ADMINLEVEL = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pBGeld" then
				
					local newData = getElementData( source, "pBGeld" )
					mysql_query(handler,"UPDATE accounts SET BANK_GELD = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pHGeld" then
				
					local newData = getElementData( source, "pHGeld" )
					setPlayerMoney ( source, tonumber(newData) )
					mysql_query(handler,"UPDATE accounts SET HAND_GELD = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					triggerClientEvent(source, "aktualisiereMoney", source)
				elseif data == "pStatus" then
				
					local newData = getElementData( source, "pStatus" )
					mysql_query(handler,"UPDATE accounts SET STATUS = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pSpielzeit" then
				
					local newData = getElementData( source, "pSpielzeit" )
					mysql_query(handler,"UPDATE accounts SET SPIELZEIT = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pFraktion" then
				
					local newData = getElementData( source, "pFraktion" )
					mysql_query(handler,"UPDATE accounts SET FRAKTION = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pFraktionsrang" then
				
					local newData = getElementData( source, "pFraktionsrang" )
					mysql_query(handler,"UPDATE accounts SET FRAKTIONSRANG = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pTode" then
				
					local newData = getElementData( source, "pTode" )
					mysql_query(handler,"UPDATE accounts SET TODE = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
									
				elseif data == "pMorde" then
				
					local newData = getElementData( source, "pMorde" )
					mysql_query(handler,"UPDATE accounts SET MORDE = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
						
				elseif data == "pSkin" then
				
					local newData = getElementData( source, "pSkin" )
					setElementModel( source, getElementData( source, "pSkin" ) )
					mysql_query(handler,"UPDATE accounts SET SKIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pWanteds" then
				
					local newData = getElementData( source, "pWanteds" )
					setPlayerWantedLevel( source, getElementData( source, "pWanteds" ) )
					mysql_query(handler,"UPDATE accounts SET WANTEDS = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pSTVO" then
				
					local newData = getElementData( source, "pSTVO" )
					mysql_query(handler,"UPDATE accounts SET STVO = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					-- Baumarkt
				elseif data == "pBGrill" then
				
					local newData = getElementData( source, "pBGrill" )
					mysql_query(handler,"UPDATE accounts SET BGRILL = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pBFackel" then
				
					local newData = getElementData( source, "pBFackel" )
					mysql_query(handler,"UPDATE accounts SET BFACKEL = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pBLiege" then
				
					local newData = getElementData( source, "pBLiege" )
					mysql_query(handler,"UPDATE accounts SET BLIEGE = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pBLagerfeuer" then
				
					local newData = getElementData( source, "pBLagerfeuer" )
					mysql_query(handler,"UPDATE accounts SET BLAGERFEUER = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pPerso" then
				
					local newData = getElementData( source, "pPerso" )
					mysql_query(handler,"UPDATE accounts SET PERSO = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pSpawn" then
				
					local newData = getElementData( source, "pSpawn" )
					mysql_query(handler,"UPDATE accounts SET SPAWN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				-- Knast --
				elseif data == "pJail" then
				
					local newData = getElementData( source, "pJail" )
					mysql_query(handler,"UPDATE accounts SET JAIL = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pJailtime" then
				
					local newData = getElementData( source, "pJailtime" )
					mysql_query(handler,"UPDATE accounts SET JAILTIME = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				-- job
				elseif data == "pCurjob" then
				
					local newData = getElementData( source, "pCurjob" )
					mysql_query(handler,"UPDATE jobs SET CURJOB = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				-- Inventar	
				-- Objetke --
				elseif data == "pBretter" then
				
					local newData = getElementData( source, "pBretter" )
					mysql_query(handler,"UPDATE inventar SET BRETTER = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pKisten" then
				
					local newData = getElementData( source, "pKisten" )
					mysql_query(handler,"UPDATE inventar SET KISTEN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pComputer" then
				
					local newData = getElementData( source, "pComputer" )
					mysql_query(handler,"UPDATE inventar SET COMPUTER = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pFeuer" then
				
					local newData = getElementData( source, "pFeuer" )
					mysql_query(handler,"UPDATE inventar SET FEUER = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pSINV" then
				
					local newData = getElementData( source, "pSINV" )
					mysql_query(handler,"UPDATE inventar SET SINV = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pMISC" then
				
					local newData = getElementData( source, "pMISC" )
					mysql_query(handler,"UPDATE inventar SET MISC = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pSFernseher" then
				
					local newData = getElementData( source, data )
					mysql_query(handler,"UPDATE inventar SET FERNSEHER = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
				elseif data == "pAngel" then
				
					local newData = getElementData( source, "pAngel" )
					mysql_query(handler,"UPDATE inventar SET ANGEL = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")

				elseif data == "pKoeder" then
				
					local newData = getElementData( source, "pKoeder" )
					mysql_query(handler,"UPDATE inventar SET KOEDER = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pFische" then
				
					local newData = getElementData( source, "pFische" )
					mysql_query(handler,"UPDATE inventar SET FISCHE = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pWuerfel" then
				
					local newData = getElementData( source, "pWuerfel" )
					mysql_query(handler,"UPDATE inventar SET WUERFEL = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
				elseif data == "pBiere" then
				
					local newData = getElementData( source, "pBiere" )
					mysql_query(handler,"UPDATE inventar SET BIERE = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")		
					
				elseif data == "pZigaretten" then
				
					local newData = getElementData( source, "pZigaretten" )
					mysql_query(handler,"UPDATE inventar SET ZIGARETTEN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
				elseif data == "pKanister" then
				
					local newData = getElementData( source, data )
					mysql_query(handler,"UPDATE inventar SET KANISTER = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")		
				elseif data == "pErstehilfe" then
				
					local newData = getElementData( source, data )
					mysql_query(handler,"UPDATE inventar SET ERSTEHILFE = '"..newData.."' WHERE NAME = '"..getPlayerName(source).."'")	
				elseif data == "pRadios" then
				
					local newData = getElementData( source, data )
					mysql_query(handler,"UPDATE inventar SET RADIOS = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")					
						-- Scheine
				elseif data == "pFSchein" then
				
					local newData = getElementData( source, "pFSchein" )
					mysql_query(handler,"UPDATE scheine SET FSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
				
				elseif data == "pLKWSchein" then
				
					local newData = getElementData( source, "pLKWSchein" )
					mysql_query(handler,"UPDATE scheine SET LKWSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
				
				elseif data == "pHELISchein" then
			
					local newData = getElementData( source, "pHELISchein" )
					mysql_query(handler,"UPDATE scheine SET HELISCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
				
				elseif data == "pFLUGSchein" then
				
					local newData = getElementData( source, "pFLUGSchein" )
					mysql_query(handler,"UPDATE scheine SET FLUGSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
					
					
				elseif data == "pBOOTSSchein" then
					local newData = getElementData( source, "pBOOTSSchein" )
					mysql_query(handler,"UPDATE scheine SET BOOTSSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")
					
					
				elseif data == "pANGELSchein" then
					local newData = getElementData( source, "pANGELSchein" )
					mysql_query(handler,"UPDATE scheine SET ANGELSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
				
				elseif data == "pMOTORRADSchein" then
					local newData = getElementData( source, "pMOTORRADSchein" )
					mysql_query(handler,"UPDATE scheine SET MOTORRADSCHEIN = '"..tonumber(newData).."' WHERE NAME = '"..getPlayerName(source).."'")	
				end
			
			end )
		
		triggerClientEvent(player,"onLoginFN",player)
		outputDebugString(getPlayerName(player).." hat sich Eingeloggt.")
		triggerClientEvent(player, "onSammelObjekteErstell", player)
	else
		outputChatBox("Dieser Account Existiert nicht oder du hast ein Falsches Passwort eingegeben!",player,255,0,0,true)
		triggerClientEvent(player,"onLoginFalsch", player)
	end
	mysql_free_result(result)
	
end)
