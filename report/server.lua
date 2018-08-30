local playerVar = {}
local playerSource = {}
local playerAdmin = {}
local var = 0
addEvent("onReportAbschick", true)
addEventHandler("onReportAbschick", getRootElement(), function(text)
	var = var+1
	playerVar[source] = var
	playerSource[var] = source
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerAdminlevel(player) > 0) then
			outputChatBox("Report von "..getPlayerName(source)..": (ID: "..var..")", player, 0, 255, 100)
			outputChatBox(text, player, 0, 255, 0)
			outputChatBox("Nutze /w [ID] um zu Antworten.", player, 255, 255, 0)
		end
	end
	outputChatBox("Report abgeschickt!", source, 0, 255, 0)
end)

addCommandHandler("w",
function(thePlayer, cmd, target, ...)
	if(getPlayerAdminlevel(thePlayer) < 1) then outputChatBox("Du bist leider nicht Berechtigt, diesen Befehl zu benutzen.", thePlayer, 200, 0, 0) return end
	if not(target) then outputChatBox("Du musst eine ID angeben!", thePlayer, 255, 0, 0) return end
	target = tonumber(target)
	if not(target) then return end
	local text = table.concat( {...}, " " )
	local player = playerSource[target]
	if(playerVar[player] == target) then
		outputChatBox("Admin "..getPlayerName(thePlayer).." fluestert dir: ", player, 0, 255, 0)
		outputChatBox(text, player, 0, 255, 100)
		outputChatBox("Nutze /re [Text] Um zu Antworten!", player, 0, 255, 0)
		playerAdmin[player] = thePlayer
		for index, player2 in pairs(getElementsByType("player")) do
		if(getPlayerAdminlevel(player2) > 0) then
			outputChatBox(getPlayerName(thePlayer).." hat "..getPlayerName(player).." gefluestert!", player2, 0, 255, 100)
		end
	end
	else
		outputChatBox("Spieler nicht Gefunden!", thePlayer, 255, 0, 0)
	end
end)

addCommandHandler("re",
function(thePlayer, cmd, ...)
	if not(playerAdmin[thePlayer]) then outputChatBox("Du kannst keinen Admin Fluestern!", thePlayer, 200, 0, 0) return end
	if not(...) then outputChatBox("Du musst einen Text Eingeben!", thePlayer, 200, 0, 0) return end
	local text = table.concat( {...}, " " )
	local id = playerVar[thePlayer]
	if(id) then
		local admin = playerAdmin[thePlayer]
		outputChatBox("Spieler "..getPlayerName(thePlayer).." reply'd dir:(ID: "..id..")", admin, 0, 255, 0)
		outputChatBox(text, admin, 0, 255, 255)
		outputChatBox("Du hast "..getPlayerName(admin).." geantwortet!", thePlayer, 0, 255, 0)
	else
		outputChatBox("Du hast keine ID!", thePlayer, 200, 0, 0)
	end
end)

addCommandHandler("clearreports",
function(thePlayer)
	if(getPlayerAdminlevel(thePlayer) > 1) then
		local reports = 0
		for index, player in pairs(getElementsByType("player")) do
			playerVar[player] = nil
			playerAdmin[player] = nil
			triggerClientEvent(player, "infolabel_starten_server", player, "Admin "..getPlayerName(thePlayer).." hat ein Report-\nReset durchgefuehrt.", 0, 255, 0, 5000)
		end
		for i = 0, var, 1 do
			playerSource[var] = nil
			reports = reports+1
		end
		var = 0
		outputChatBox(reports.." Report's wurden geloescht.", thePlayer, 0, 255, 0)
	else
		outputChatBox("Du hast keine Rechte diesen Befehl zu Benutzen!", thePlayer, 255, 0, 0)
	end
end)
