Firmenpreis = 300000

function getPlayerFirma(thePlayer)
	local win = false
	for index, col in pairs(getElementsByType("colshape")) do
		if(getElementData(col, "FIRMA") == true) then
			if(getElementData(col, "FBESITZER") == getPlayerName(thePlayer)) then
				win = col
			else
				if(win == false) then
					local angestellte = getElementData(col, "FANGESTELLTE")
					local an1 = gettok(angestellte, 1, "|")
					local an2 = gettok(angestellte, 2, "|")
					local an3 = gettok(angestellte, 3, "|")
					local an4 = gettok(angestellte, 4, "|")
					local an5 = gettok(angestellte, 5, "|")
					if(an1 == getPlayerName(thePlayer)) then 
						win = col
					end
					if(an2 == getPlayerName(thePlayer)) then 
						win = col
					end
					if(an3 == getPlayerName(thePlayer)) then 
						win = col
					end
					if(an4 == getPlayerName(thePlayer)) then 
						win = col
					end
					if(an5 == getPlayerName(thePlayer)) then 
						win = col
					end
				end
			end
		end
	end
	return win
end