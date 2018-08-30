-- Tables --

local payday = {}

payday[0] = {}
payday[1] = {}
payday[2] = {}
payday[3] = {}
payday[4] = {}
payday[5] = {}
payday[6] = {}

-- Zivilist --
payday[0][1] = 0

-- Yakuza --
payday[1][0] = 250 -- Rang 0
payday[1][1] = 425 -- Rang 1
payday[1][2] = 500 -- Rang 2
payday[1][3] = 675 -- Rang 3
payday[1][4] = 725 -- Rang 4
payday[1][5] = 800 -- Rang 5
payday[1][6] = 950 -- Rang 6

-- Terror --
payday[2][0] = 275 -- Rang 0
payday[2][1] = 450 -- Rang 1
payday[2][2] = 525 -- Rang 2
payday[2][3] = 625 -- Rang 3
payday[2][4] = 700 -- Rang 4
payday[2][5] = 825 -- Rang 5
payday[2][6] = 900 -- Rang 6

-- Fahrschule --
payday[3][0] = 250 -- Rang 0
payday[3][1] = 400 -- Rang 1
payday[3][2] = 550 -- Rang 2
payday[3][3] = 625 -- Rang 3
payday[3][4] = 700 -- Rang 4
payday[3][5] = 875 -- Rang 5
payday[3][6] = 950 -- Rang 6

-- RCPD --
payday[4][0] = 275 -- Rang 0
payday[4][1] = 350 -- Rang 1
payday[4][2] = 450 -- Rang 2
payday[4][3] = 500 -- Rang 3
payday[4][4] = 625 -- Rang 4
payday[4][5] = 725 -- Rang 5
payday[4][6] = 850 -- Rang 6

-- RCNR --
payday[5][0] = 200 -- Rang 0
payday[5][1] = 350 -- Rang 1
payday[5][2] = 450 -- Rang 2
payday[5][3] = 525 -- Rang 3
payday[5][4] = 600 -- Rang 4
payday[5][5] = 725 -- Rang 5
payday[5][6] = 800 -- Rang 6

-- Red Brothers --
payday[6][0] = 250 -- Rang 0
payday[6][1] = 325 -- Rang 1
payday[6][2] = 400 -- Rang 2
payday[6][3] = 575 -- Rang 3
payday[6][4] = 650 -- Rang 4
payday[6][5] = 700 -- Rang 5
payday[6][6] = 800 -- Rang 6

addEvent("onPaydayStart", true)
addEventHandler("onPaydayStart", getRootElement(),
function()
	if not(source) then return end
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		local datum = day.."."..month.."."..year.." um "..hour..":"..minute
	local fraktion = getPlayerFraktion(source)
	local rang = 0
	if not(fraktion == 0) then rang = getPlayerFraktionsrang(source) end
	if(fraktion == 0) then
	local einkommen = 0
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) and(x8 == 1) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = math.random(350, 600)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	elseif(fraktion == 1) then
	local einkommen = 500 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	elseif(fraktion == 2) then
	local einkommen = 750 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	elseif(fraktion == 3) then
	local einkommen = 600 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	elseif(fraktion == 4) then
	local einkommen = 500 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	elseif(fraktion == 5) then
	local einkommen = 750 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	elseif(fraktion == 6) then
	local einkommen = 500 -- Grund
	local rangbonus = payday[fraktion][rang]
	local bankgeld = tonumber(getElementData(source, "pBGeld"))
	local miete = "N/A"
	local x1, x2, x3, x4, x5, x6, x7, x8 = getPlayerHouse(source)
	if(x6 == 2) and(x8 == 1) then miete = x7 else miete = 0 end
	local zinsen = math.ceil(math.sqrt(bankgeld*(1+0.07)))
	local arbeitslosengeld = 0
	local einkommen = (einkommen+rangbonus)
	local kapital = (bankgeld+zinsen+arbeitslosengeld+einkommen-miete)
	setElementData(source, "pBGeld", kapital)
	triggerClientEvent(source, "writeToAbrechnung", source, "Abrechnung am "..datum..":\n_______________________\nKapital: "..bankgeld.." $ | Einkommen: "..einkommen.." $ |\nArbeitslosengeld: "..arbeitslosengeld.." $\nZinssatz: 5 % | Zinsen:"..zinsen.." $\nMiete: "..miete.."$\n\n__________________\nNeuer Kontostand: "..kapital.." $")
	
	end
	outputChatBox("Du hast Geld zum Zahltag auf dein Konto ueberwiesen bekommen! Checke deine Abrechnungen in der Bank.", source, 0, 245, 0, false)
end)