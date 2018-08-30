local adminvar = {}
setWeaponProperty("minigun", "pro", "maximum_clip_ammo", 5000)
setWeaponProperty("minigun", "pro", "damage", 5000)
setWeaponProperty("minigun", "pro", "accuracy", 10000)
setWeaponProperty("minigun", "pro", "move_speed", 2)
setWeaponProperty("minigun", "pro", "flags", 0x000004)
--setWeaponProperty("minigun", "pro", "flags", 0x000800)
--setWeaponProperty("minigun", "pro", "flags", 0x000001)

addCommandHandler("aduty",
function(thePlayer)
	if(tonumber(getElementData(thePlayer, "pAdminlevel")) < 5) then outputChatBox("Du hast nicht die Erlaubnis zu diesem Command.", thePlayer, 255, 0, 0, false) return end
	if(adminvar[thePlayer] == 1) then
		adminvar[thePlayer] = 0
		outputChatBox("Admin "..getPlayerName(thePlayer).." ist nun im Dienst!", getRootElement(), 100, 255, 255)
		giveWeapon(thePlayer, 38, 100000)
		setElementModel(thePlayer, 217)
	else
		adminvar[thePlayer] = 1
		outputChatBox("Du bist nun nichmehr im Dienst.", thePlayer, 0, 200, 0, false)
		takeWeapon(thePlayer, 38)
		setElementModel(thePlayer, tonumber(getElementData(thePlayer, "pSkin")))
	end
end)

addCommandHandler("admins", 
function(thePlayer)
	outputChatBox("#FFFFFFAdmins #0011FFOnline: ", thePlayer, 0, 0, 0, true)

	local cvar = 0
	for index, player in pairs(getElementsByType("player")) do
		local title = "N/A"
		local color = "#FFFFFF"
		if(tonumber(getElementData(player, "pAdminlevel")) > 0) then
			local data = tonumber(getElementData(player, "pAdminlevel"))
			if(data == 1) then
				title = "Supporter"
				color = "#00FFFF"
			elseif(data == 2) then
				title = "Moderator"
				color = "#00FF00"
			elseif(data == 3) then
				title = "Super Mod"
				color = "#FF9600"
			elseif(data == 4) then
				title = "Administrator"
				color = "#FFFF00"
			elseif(data == 5) then
				title = "Inhaber"
				color = "#FF0000"
			elseif(data > 5) then
				title = "Projektleiter"
				color = "#F00000"
			end
			cvar = (cvar+1)
			outputChatBox(color..title.." #FFFFFF"..getPlayerName(player), thePlayer, 255, 255, 255, true)
			
		end

	end	
	if(cvar == 0) then
			outputChatBox("Kein Admin online!", thePlayer, 255, 255, 255, false)
	end
end)

addCommandHandler("akick", 
function(thePlayer, cmd, target, ...)
	local data = tonumber(getElementData(thePlayer, "pAdminlevel"))
	if(data < 2) then outputChatBox("Du hast keine Berechtigung, diesen Command zu benutzen.", thePlayer, 255, 0, 0, false) return end
	if not(target) then outputChatBox("Du musst ein Spieler nennen!", thePlayer, 255, 0, 0, false) return end
	local playa = getPlayerFromName(target)
	if not(playa) then outputChatBox("Spieler wurde nicht gefunden!", thePlayer, 255, 0 ,0, false) return end
	local text = "N/A"
	if not(...) then else
		local parametersTable = {...}
		text = table.concat( parametersTable, " " )
	end
	outputChatBox("#FF0000AdminCMD: #FFFFFF"..getPlayerName(playa).." #FF0000wurde von #FFFFFF"..getPlayerName(thePlayer).." #FF0000vom Server gekickt.", getRootElement(), 255, 255, 255, true)
	if(text == "N/A") then else outputChatBox("#FF0000Grund: "..text, getRootElement(), 255, 255, 255, true) end
	kickPlayer(playa, thePlayer, text)
	outputServerLog(getPlayerName(thePlayer).." hat "..getPlayerName(playa).." mit dem Grund "..text.." gekickt.")
end)

