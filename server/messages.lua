local mes1 = {}
local mes2 = {}
local mes3 = {}
local wiederholung = 25

mes1[1] = "Information:=0, 255, 0"
mes1[2] = "Nutze F10 um das Hilfemenue zu oefnnen!=0,255,70"
mes1[3] = "Falls du Fragen hast, kannst du mit /report einen Admin Kontaktieren.=0, 255, 70"
mes1[4] = "Wir wuenschen dir viel Spass auf Butterfly-Reallife!=0, 255, 70"
mes1[5] = "Teamspeak IP: ungaming.de:1234=0, 255, 70"

mes2[1] = "Information:=0, 255, 0"
mes2[2] = "Du kannst mit F3 deine gekauften Autos betrachten!=0, 255, 70"
mes2[3] = "Nutze '/info' um deine Persoenlichkeiten zu betrachten!=0, 255, 70"
mes2[4] = "Forum: bf.sideboard.eu=0, 255, 70"
mes2[5] = "Teamspeak IP: ungaming.de:1234=0, 255, 70"

mes3[1] = "Information:=0, 255, 0"
mes3[2] = "Du kannst dich, wann immer du willst, an das RCPD wenden!=0, 255, 70"
mes3[3] = "Du hast Fragen oder brauchst Hilfe? Nutze /Report!=0, 255, 70"
mes3[4] = "Forum: bf.sideboard.eu=0, 255, 70"
mes3[5] = "Teamspeak IP: ungaming.de:1234=0, 255, 70"

function mess1()
	for i = 1, #mes1, 1 do
		local text = gettok(mes1[i], 1, "=")
		local farbe = gettok(mes1[i], 2, "=")
		local f1, f2, f3 = tonumber(gettok(farbe, 1, ",")), tonumber(gettok(farbe, 2, ",")), tonumber(gettok(farbe, 3, ","))
		outputChatBox(text, getRootElement(), f1, f2, f3)
	end
	setTimer(mess2, wiederholung*60*1000, 1)
end

function mess2()
	for i = 1, #mes2, 1 do
		local text = gettok(mes2[i], 1, "=")
		local farbe = gettok(mes2[i], 2, "=")
		local f1, f2, f3 = tonumber(gettok(farbe, 1, ",")), tonumber(gettok(farbe, 2, ",")), tonumber(gettok(farbe, 3, ","))
		outputChatBox(text, getRootElement(), f1, f2, f3)
	end
	setTimer(mess3, wiederholung*60*1000, 1)
end

function mess3()
	for i = 1, #mes3, 1 do
		local text = gettok(mes3[i], 1, "=")
		local farbe = gettok(mes3[i], 2, "=")
		local f1, f2, f3 = tonumber(gettok(farbe, 1, ",")), tonumber(gettok(farbe, 2, ",")), tonumber(gettok(farbe, 3, ","))
		outputChatBox(text, getRootElement(), f1, f2, f3)
	end
	setTimer(mess1, wiederholung*60*1000, 1)
end

mess1()

