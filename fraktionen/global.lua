FraktionsCarRespawn = 30

function f_help_func(thePlayer)
	local Fraktion = getPlayerFraktion(thePlayer)
	if(Fraktion == 0) then outputChatBox("Du bist in keiner Fraktion.", thePlayer, 200, 0, 0, false) return end
	if(Fraktion == 1) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /tie (Fesseln) | /ogate (Tor) ", thePlayer, 200, 200, 0)
		outputChatBox("/invite (Spieler Einladen) ", thePlayer, 200, 200, 0)
		outputChatBox("Fraktionscomputer", thePlayer, 200, 200, 0)
	elseif(Fraktion == 2) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /tie (Fesseln) | /ogate (Tor) ", thePlayer, 200, 200, 0)
		outputChatBox("/invite (Spieler Einladen) ", thePlayer, 200, 200, 0)
		outputChatBox("/equip (Bewaffnen)(nur im Container) | /bombe [0/1] (Bombe Bereitmachen / zuenden)", thePlayer, 200, 200, 0)
		outputChatBox("/bombshop (Bombe in Auto einbauen)", thePlayer, 200, 200, 0)
	elseif(Fraktion == 3) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /invite (Spieler Einladen)", thePlayer, 200, 200, 0)
		outputChatBox("/pruefen [Name] [Schein] | /endpruefung [0/1], 0 = Durchgefallen, 1 = Bestanden", thePlayer, 200, 200, 0)
		outputChatBox("Scheine: fuehrerschein, lkwschein, helischein, flugschein, bootschein, angelschein, motorradschein", thePlayer, 200, 200, 0)
		outputChatBox("Wichtig: Pruefling muss Geld erst ueberweisen!", thePlayer, 200, 200, 0)
		outputChatBox("Auf Tafel Klicken -> Scheinpreise aendern ", thePlayer, 200, 200, 0)
	elseif(Fraktion == 4) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /invite (Spieler Einladen)", thePlayer, 200, 200, 0)
		outputChatBox("/jail [Name] [0 = nicht Gestellt, 1 = Gestellt]", thePlayer, 200, 200, 0)
		outputChatBox("/cuff [Name] -> Spieler Handschellen anlegen | Inventar -> Strassensperren und Nagelbaender", thePlayer, 200, 200, 0)
		outputChatBox("/removenails -> Nagelbaender entfernen | /m [Text] -> Megafon fuer PD Autos", thePlayer, 200, 200, 0)
		outputChatBox("/lights [1/2] -> Blaulichter | /stel -> Auf ein FBI-Truck stellen", thePlayer, 200, 200, 0)
	elseif(Fraktion == 5) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /invite (Spieler Einladen)", thePlayer, 200, 200, 0)
		outputChatBox("Im Interior: -> Zeitung Editieren im Gruenen Marker", thePlayer, 200, 200, 0)
		outputChatBox("Fraktionscomputer, News-Computer: Im Auto 'F5' Druecken,", thePlayer, 200, 200, 0)
		outputChatBox("-> Kamera bestellen, Live-Modus, Newschat", thePlayer, 200, 200, 0)
		outputChatBox("/news [Text] -> News-Text posten", thePlayer, 200, 200, 0)
	elseif(Fraktion == 6) then
		outputChatBox("Fraktions-Funktionen: ", thePlayer, 255, 255, 0)
		outputChatBox("/t (Teamchat) | /tie (Fesseln) | /ogate (Tor) ", thePlayer, 200, 200, 0)
		outputChatBox("/invite (Spieler Einladen) ", thePlayer, 200, 200, 0)
		outputChatBox("Fraktionscomputer", thePlayer, 200, 200, 0)
	
	end
	outputChatBox("--> Fraktionsfeatures werden gerne Eingebaut! <--", thePlayer, 0, 255, 0)
end

addCommandHandler("fhelp", f_help_func)


function invite_player_func(thePlayer, cmd, target)
	local frak = getPlayerFraktion(thePlayer)
	local rang = getPlayerFraktionsrang(thePlayer)
	if(frak == 0) then outputChatBox("Du hast keine Rechte diesen Befehl zu benutzen!", thePlayer, 200, 0, 0, false) return end
	if(rang < 5) then outputChatBox("Du kannst erst mit Rang 5-6 Jemanden inviten!", thePlayer, 200, 0, 0, false) return end
	local target = getPlayerFromName(target)
	if not(target) then outputChatBox("Spieler nicht gefunden/ist nicht Online!", thePlayer, 200, 0, 0, false) return end
	local playerfrak = getPlayerFraktion(target)
	if(playerfrak ~= 0) then outputChatBox("Der Spieler ist bereits in einer Fraktion!", thePlayer, 200, 0, 0, false) return end
	setElementData(target, "pFraktion", frak)
	setElementData(target, "pFraktionsrang", 0)
	outputChatBox("Glueckwunsch, du wurdest von "..getPlayerName(thePlayer).." in die Fraktion "..fraktionNamen[frak].." aufgenommen!", target, 0, 230, 50)
	outputChatBox("Benutze /fhelp um die Befehle zu sehen!", target, 0, 230, 50)
end

addCommandHandler("invite", invite_player_func)

function set_current_skin(thePlayer)
	local model = getElementModel(thePlayer)
	setElementData(thePlayer, "pSkin", model)
	outputChatBox("Zurzeitger Skin wurde als Standart gespeichert!", thePlayer, 0, 230, 0, false)
end

addCommandHandler("setcurskin", set_current_skin)