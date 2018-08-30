local Guivar = 0


addEvent("onRCNRZeitungEditier", true)
addEventHandler("onRCNRZeitungEditier", getRootElement(),
function(text)
	if not(source == gMe) then return end
	if(Guivar == 1) then return end
	if(getElementData(gMe, "Clicked") == 1) then return end
	setElementData(gMe, "Clicked", 1)
	guiSetInputMode("no_binds_when_editing")
	showCursor(true)
	Guivar = 1
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
			local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 363,260
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)

	local Fenster = guiCreateWindow(X, Y, Width, Height,"Zeitung Bearbeiten",false)
	local Knopf1 = guiCreateButton(36,224,110,27,"Speichern",false,Fenster)
	local Knopf2 = guiCreateButton(150,224,110,27,"Abbrechen",false,Fenster)
	local Memo = guiCreateMemo(9,19,345,201,"",false,Fenster)
	
	guiSetText(Memo, text)
	
	addEventHandler("onClientGUIClick", Knopf1,
	function()
		local text = guiGetText(Memo)
		destroyElement(Fenster)
		Guivar = 0
		showCursor(false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		triggerServerEvent("onRCNRZeitungFertigEditier", gMe, text)
		setElementData(gMe, "Clicked", 0)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf2,
	function()
		destroyElement(Fenster)
		Guivar = 0
		showCursor(false)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		setElementData(gMe, "Clicked", 0)
	end, false)

end)