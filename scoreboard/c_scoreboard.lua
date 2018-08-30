
local x,y = guiGetScreenSize()
local Scoreboard = guiCreateGridList(x/2-400,y/2-225.5,800,451,false)
guiGridListSetSelectionMode(Scoreboard,1)
guiGridListSetSortingEnabled ( Scoreboard, false )
local Spielername = guiGridListAddColumn(Scoreboard,"Spieler",0.25)
local fraktion = guiGridListAddColumn(Scoreboard,"Fraktion",0.25)
local status = guiGridListAddColumn(Scoreboard,"Status",0.25)
local spielzeit = guiGridListAddColumn(Scoreboard,"Spielzeit",0.14)
local ping = guiGridListAddColumn(Scoreboard,"Ping",0.05)
local bild = guiCreateStaticImage(x/2-400,y/2-225.5,800,451, "data/images/background.png", false)

guiSetAlpha(bild, 0.35)
guiSetAlpha(Scoreboard,0.7)
guiSetVisible(Scoreboard,false)
guiSetVisible(bild,false)
guiSetFont ( Scoreboard, "default-bold-small" )
guiMoveToBack(bild)

local antVar = 0

function show_scoreboard_fade()
	if(guiGetVisible(Scoreboard) == false) then removeEventHandler("onClientRender", getRootElement(), show_scoreboard_fade) antVar = 0 return end
	local alpha = guiGetAlpha(Scoreboard)
	local balpha = guiGetAlpha(bild)
	guiSetAlpha(Scoreboard, alpha+0.085)
	guiSetAlpha(bild, balpha+0.04)
	if(guiGetAlpha(Scoreboard) > 0.69) then
		removeEventHandler("onClientRender", getRootElement(), show_scoreboard_fade)
		guiSetAlpha(Scoreboard, 0.7)
		guiSetAlpha(bild, 0.20)
		antVar = 0
	end
end

function hide_scoreboard_fade()
	if(guiGetVisible(Scoreboard) == false) then removeEventHandler("onClientRender", getRootElement(), hide_scoreboard_fade) antVar = 0 return end
	local alpha = guiGetAlpha(Scoreboard)
	local balpha = guiGetAlpha(bild)
	guiSetAlpha(Scoreboard, alpha-0.085)
	guiSetAlpha(bild, balpha-0.04)
	if(guiGetAlpha(Scoreboard) < 0.01) then
		guiSetVisible(Scoreboard, false)
		guiSetVisible(bild, false)
		guiGridListClear(Scoreboard)
		removeEventHandler("onClientRender", getRootElement(), hide_scoreboard_fade)
		antVar = 0
	end
end

bindKey("tab", "up", 
function()
	if(antVar == 1) then
		guiSetVisible(Scoreboard, false)
		guiSetVisible(bild, false)
		guiGridListClear(Scoreboard)
		removeEventHandler("onClientRender", getRootElement(), hide_scoreboard_fade)
		antVar = 0 return end
	addEventHandler("onClientRender", getRootElement(), hide_scoreboard_fade)
	antVar = 1
end)
function updatePlayerlistIn()
if(guiGetVisible(Scoreboard) == false) then return end
guiGridListClear(Scoreboard)

for id,spieler in pairs ( getElementsByType("player" ) ) do
	
		local name = getPlayerName(spieler)
		local ping = getPlayerPing(spieler)
		local fraktion = tonumber(getElementData(spieler, "pFraktion"))
		local fname = "Wartend..."
		local spielzeit = "N/A"
		local status = "N/A"
		local r = 255
		local g = 255
		local b = 255
		if not(fraktion) then
		else
		status = getElementData(spieler, "pStatus")
		spielzeit = getElementData(spieler,"pSpielzeit")
		fname = fraktionNamen[tonumber(getElementData(spieler, "pFraktion"))]
		if(fname == "Yakuza") then
			r = 200
			g = 0
			b = 255
		elseif(fname == "Terroristen") then
			r = 255
			g = 0
			b = 0
		elseif(fname == "Fahrschule") then
			r = 200
			g = 200
			b = 0
		elseif(fname == "RCPD") then
			r = 0
			g = 255
			b = 0
		elseif(fname == "RCNR") then
			r = 0
			g = 255
			b = 255
		elseif(fname == "Red Brothers") then
			r = 200
			g = 50
			b = 0
		elseif(fname == "FBI") then
			r = 0
			g = 150
			b = 255
		else
			r = 255
			g = 255
			b = 255
		
			end
		end
		
		local row1 = guiGridListAddRow ( Scoreboard )
	
		guiGridListSetItemText(Scoreboard,row1,1,name,false,false)
		guiGridListSetItemText(Scoreboard,row1,5,ping,false,false)
		guiGridListSetItemText(Scoreboard,row1,2,fname,false,false)
		guiGridListSetItemText(Scoreboard,row1,4,spielzeit,false,false)
		guiGridListSetItemText(Scoreboard,row1,3,status,false,false)
		guiGridListSetItemColor(Scoreboard,row1,2,r, g, b)
		
	end
end

function updatePlayerlist()
	
guiGridListClear(Scoreboard)
for id,spieler in pairs ( getElementsByType("player" ) ) do
	
		local name = getPlayerName(spieler)
		local ping = getPlayerPing(spieler)
		local fraktion = tonumber(getElementData(spieler, "pFraktion"))
		local fname = "Wartend..."
		local spielzeit = "N/A"
		local status = "N/A"
		local r = 255
		local g = 255
		local b = 255
		if not(fraktion) then
		else
		status = getElementData(spieler, "pStatus")
		spielzeit = getElementData(spieler,"pSpielzeit")
		fname = fraktionNamen[tonumber(getElementData(spieler, "pFraktion"))]
		if(fname == "Yakuza") then
			r = 200
			g = 0
			b = 255
		elseif(fname == "Terroristen") then
			r = 255
			g = 0
			b = 0
		elseif(fname == "Fahrschule") then
			r = 200
			g = 200
			b = 0
		elseif(fname == "RCPD") then
			r = 0
			g = 255
			b = 0
		elseif(fname == "RCNR") then
			r = 0
			g = 255
			b = 255
		elseif(fname == "Red Brothers") then
			r = 200
			g = 0
			b = 0
		else
			r = 255
			g = 255
			b = 255
		
			end
		end
		
		local row1 = guiGridListAddRow ( Scoreboard )
		guiSetVisible(Scoreboard,true)
		guiSetVisible(bild,true)

	
		guiGridListSetItemText(Scoreboard,row1,1,name,false,false)
		guiGridListSetItemText(Scoreboard,row1,5,ping,false,false)
		guiGridListSetItemText(Scoreboard,row1,2,fname,false,false)
		guiGridListSetItemText(Scoreboard,row1,4,spielzeit,false,false)
		guiGridListSetItemText(Scoreboard,row1,3,status,false,false)
		guiGridListSetItemColor(Scoreboard,row1,2,r, g, b)
		
	end
end
addEvent("onScoreboardUpdate", true)
addEventHandler("onScoreboardUpdate", getRootElement(), updatePlayerlist)

setTimer(updatePlayerlistIn, 50, -1)
	
bindKey("tab", "down", 
function()
	if(antVar == 1) then return end
	updatePlayerlist()
	addEventHandler("onClientRender", getRootElement(), show_scoreboard_fade)
	guiSetAlpha(Scoreboard, 0)
	guiSetAlpha(bild, 0)
	antVar = 1
end)