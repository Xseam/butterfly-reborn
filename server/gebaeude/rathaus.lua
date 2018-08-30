
local Rathausmarker1 = createMarker(207.84722900391, -62.303722381592, 1.7708486318588, "corona", 1.0, 255, 255, 255, 255)
local Rathausmarker2 = createMarker( 1701.0, -1667.88, 19, "cylinder", 2.0, 255, 255, 255, 100) setElementInterior(Rathausmarker2, 18)
local Inpickup = createPickup(1728.3690185547, -1651.3092041016, 20.230054855347, 3, 1273, 1000) setElementInterior(Inpickup, 18)
local Intsphere = createColSphere(1728.3690185547, -1651.3092041016, 20.230054855347, 1)setElementInterior(Intsphere, 18)

addEventHandler("onMarkerHit", Rathausmarker1,
function (hitPlayer)
	setInPosition(hitPlayer, 1710.433715,-1669.379272,20.225049, 18)
	--setElementInterior(hitPlayer, 18)
end
)

addEventHandler("onMarkerHit", Rathausmarker2,
function (hitPlayer)
	setInPosition(hitPlayer, 207.84722900391, -62.303722381592-2, 1.7708486318588, 0)
	--setElementInterior(hitPlayer, 0)
end
)

addEventHandler("onColShapeHit", Intsphere,
function(thePlayer)
	if(getElementType(thePlayer) == "vehicle") then return end
	triggerClientEvent(thePlayer, "onRathausEnter", thePlayer)
end)

addEvent("onRathausPersoBuy", true)
addEventHandler("onRathausPersoBuy", getRootElement(),
function()
	outputChatBox("Du hast den Personalausweis erfolgreich Beantragt. Er wird dir bald zugeliefert.", source, 0, 230, 0, false)
	mysql_query(handler,"UPDATE accounts SET PERSO = '1' WHERE NAME = '"..getPlayerName(source).."'")
	setElementData(source, "pPAntrag", true)
end)

-- function(meinregister, geld, autos, playerinfaction, playerohnefaction, regestrierte, zigaretten, biere, spielzeit, userfuehrerschein, userprivatautos, konten)
addEvent("onRathausStatistikenNeed", true)
addEventHandler("onRathausStatistikenNeed", getRootElement(),
function()
	local meinregister = 0
	local geld = 0
	local autos = 0
	local playerinfaction = 0
	local playerohnefaction = 0
	local regestrierte = 0
	local zigaretten = 0
	local biere = 0
	local spielzeit = 0
	local userfuehrerschein = 0
	local userprivatautos = 0
	local konten = 0
	
	local result1 = mysql_query( handler, "SELECT * FROM accounts")
	if result1 then
		dsatz = mysql_fetch_assoc( result1 )
		while dsatz do
			geld = (geld+dsatz['BANK_GELD']+dsatz['HAND_GELD'])
			regestrierte = (regestrierte+1)
			for index, lol in pairs(getElementsByType("vehicle")) do autos = (autos+1) end
			local spielzeit1 = gettok(dsatz['SPIELZEIT'], 1, ":")
			local spielzeit2 = gettok(dsatz['SPIELZEIT'], 2, ":")
			if(tonumber(dsatz['FRAKTION']) == 0) then playerohnefaction = (playerohnefaction+1) else
				playerinfaction = (playerinfaction+1)
			end
			dsatz = mysql_fetch_assoc ( result1 )
		end
	else
	

	end
	mysql_free_result ( result1 )
	triggerClientEvent(source, "onRathausStatistikenNeedBack", source, meinregister, geld, autos, playerinfaction, playerohnefaction, regestrierte, zigaretten, biere, spielzeit, userfuehrerschein, userprivatautos, konten)
end
)
