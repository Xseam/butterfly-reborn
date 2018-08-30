addEvent("onADAbschick", true)
addEventHandler("onADAbschick", getRootElement(),
function(text)
	local nummer = getElementData(source, "pHandynummer")
	if not(nummer) or(nummer == 0) then nummer = "N/A" end
	outputChatBox("| Werbung von "..getPlayerName(source).." |(NR: "..nummer..")", getRootElement(), 102, 255, 0, false)
	outputChatBox(text, getRootElement(), 255, 255, 255, true)
end)