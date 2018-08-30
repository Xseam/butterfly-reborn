function TeamChat_func ( player, cmd, ... )	
	
	local parametersTable = {...}
	local text = table.concat( parametersTable, " " )
	local Fraktion = getPlayerFraktion(player)
	local Rang = getPlayerFraktionsrang(player)
	if not(Rang) then return end
	if not(Fraktion) then return end
	if not(text) then outputChatBox("Bitte gebe einen Text ein!", player, 200, 0, 0, false) return end
	if(Fraktion == 0) then return end
			local red = 0
			local green = 0
			local blue = 0
			local title = "N/A"
			if (Fraktion == 1) then
				red = 171
				green = 0
				blue = 171
				if (Rang == 0) then title = "Outsider" end
				if (Rang == 1) then title = "Neuling" end
				if (Rang == 2) then title = "Partner" end
				if (Rang == 3) then title = "Mitglied" end
				if (Rang == 4) then title = "Erfahrenes Mitglied" end
				if (Rang == 5) then title = "Hohes Mitglied" end
				if (Rang == 6) then title = "Don" end
				
			end
			if (Fraktion == 2) then -- Terror
				red = 200
				green = 0
				blue = 0
				if (Rang == 0) then title = "Bastler" end
				if (Rang == 1) then title = "Waffenschieber" end
				if (Rang == 2) then title = "Bombenbastler" end
				if (Rang == 3) then title = "Profi" end
				if (Rang == 4) then title = "Attentaeter" end
				if (Rang == 5) then title = "Terrorist" end
				if (Rang == 6) then title = "Al Qaida" end
			end
				if (Fraktion == 3) then -- Fahrschule
				red = 0
				green = 200
				blue = 100
				if (Rang == 0) then title = "Reifenwechsler" end
				if (Rang == 1) then title = "Neuling" end
				if (Rang == 2) then title = "Azubi" end
				if (Rang == 3) then title = "Co-Pilot" end
				if (Rang == 4) then title = "Fahrlehrer" end
				if (Rang == 5) then title = "Stellvertreter" end
				if (Rang == 6) then title = "Chef" end
			end
			if (Fraktion == 4) then -- LSPD
				red = 50
				green = 50
				blue = 255
				if (Rang == 0) then title = "Neuzugang" end
				if (Rang == 1) then title = "Cadet" end
				if (Rang == 2) then title = "Corporal" end
				if (Rang == 3) then title = "Sergeant" end
				if (Rang == 4) then title = "Master Sergeant" end
				if (Rang == 5) then title = "Superintendent" end
				if (Rang == 6) then title = "Chief" end
			end
			if (Fraktion == 5) then -- RCNR
				red = 0
				green = 255
				blue = 255
				if (Rang == 0) then title = "Zeitungsmaedel" end
				if (Rang == 1) then title = "Azubi" end
				if (Rang == 2) then title = "Sektretaer" end
				if (Rang == 3) then title = "Reporter" end
				if (Rang == 4) then title = "Masterreporter" end
				if (Rang == 5) then title = "Journalist" end
				if (Rang == 6) then title = "Chefredakteur" end
			end
			if (Fraktion == 6) then -- Red Brothers
				red = 200
				green = 50
				blue = 0
				if (Rang == 0) then title = "Outsider" end
				if (Rang == 1) then title = "Member" end
				if (Rang == 2) then title = "Capi" end
				if (Rang == 3) then title = "Reporter" end
				if (Rang == 4) then title = "Capo" end
				if (Rang == 5) then title = "Consigliere" end
				if (Rang == 6) then title = "Don" end
			end
			for index, spieler in pairs(getElementsByType("player")) do 
				if(getPlayerFraktion(spieler) == Fraktion) then
					outputChatBox ( "[ "..title.." "..getPlayerName(player)..": "..text.."]", spieler, red, green, blue )
				end
			end
	end
addCommandHandler ( "t", TeamChat_func )