local Guivar = 0

function sendeReport(text)
	triggerServerEvent("onReportAbschick", gMe, text)
end

function showReportGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	guiSetInputMode("no_binds_when_editing")
	
	local X, Y, Width, Height = getMiddleGuiPosition(423,137)
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Report",false)
	local Label = guiCreateLabel(39,23,345,39,"Bitte Schreibe hier dein Problem hin. Ein Admin wird sich dann\num dich Kuemmern.",false,Fenster)
	guiLabelSetHorizontalAlign(Label,"center",false)
	guiSetFont(Label,"default-bold-small")
	local Knopf1 = guiCreateButton(11,98,101,30,"Senden",false,Fenster)
	local Knopf2 = guiCreateButton(116,98,101,30,"Abbrechen",false,Fenster)
	local Edit = guiCreateEdit(11,55,396,33,"",false,Fenster)
	local function removeEv()
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end
	addEventHandler("onClientGUIClick", Knopf1, -- Senden
	function()
		local text = guiGetText(Edit)
		if(text == "") or (text == " ") then outputChatBox("Ungueltiger Text!", 255, 0, 0) return end
		Guivar = 0
		destroyElement(Fenster)
		removeEv()
		showCursor(false)
		sendeReport(text)
	end, false)
	addEventHandler("onClientGUIClick", Knopf2, -- Abbrechen
	function()
		Guivar = 0
		destroyElement(Fenster)
		removeEv()
		showCursor(false)
	end, false)
end

addCommandHandler("report", function(cmd, ...)
	if not(...) then showReportGui() return end
	local text = table.concat( {...}, " " )
	sendeReport(text)
end)