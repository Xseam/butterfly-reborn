local Guivar = 0

function createBrettGui(zone)
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	
	local adminlevel = tonumber(getElementData(gMe, "pAdminlevel"))
		
		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 877,489
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	local bFenster = guiCreateWindow(X, Y, Width, Height, "Schwarzes Brett von "..zone,false)
	local bText = guiCreateLabel(12,22,853,410,"Bitte Warten...",false,bFenster)
	local bKnopf1 = guiCreateButton(14,441,95,31,"Schliessen",false,bFenster)
	local bKnopf2 = guiCreateButton(118,442,95,31,"Bearbeiten",false,bFenster)
	local bKnopf3 = guiCreateButton(218,442,95,31,"Speichern",false,bFenster)
	local bKnopf4 = guiCreateButton(118,442,95,31,"Abbrechen",false,bFenster)
	local bMemo = guiCreateMemo(11,22,857,409,"",false,bFenster)
	guiSetVisible(bMemo, false)
	guiSetVisible(bKnopf2, false)
	guiSetVisible(bKnopf3, false)
	guiSetVisible(bKnopf4, false)
	if(adminlevel > 0) then
		guiSetVisible(bKnopf2, true)
		
		addEventHandler("onClientGUIClick", bKnopf2,
		function()
			triggerServerEvent("onBrettDataNeed", gMe, 1)
			guiSetVisible(bText, false)
			guiSetVisible(bMemo, true)
			guiSetVisible(bKnopf3, true)
			guiSetVisible(bKnopf2, false)
			guiSetVisible(bKnopf4, true)
		end, false)
		
		addEventHandler("onClientGUIClick", bKnopf4,
		function()
			guiSetVisible(bText, true)
			guiSetVisible(bMemo, false)
			guiSetVisible(bKnopf3, false)
			guiSetVisible(bKnopf2, true)
			guiSetVisible(bKnopf4, false)
		end, false)
		
		addEventHandler("onClientGUIClick", bKnopf3,
		function()
			local text = guiGetText(bMemo)
			triggerServerEvent("onBrettDataEditier", gMe, text)
			guiSetVisible(bText, true)
			guiSetVisible(bMemo, false)
			guiSetVisible(bKnopf3, false)
			guiSetVisible(bKnopf2, true)
			guiSetVisible(bKnopf4, false)
		end, false)
		
	end
	addEventHandler("onClientGUIClick", bKnopf1, 
	function()
		destroyElement(bFenster)
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end, false)
	triggerServerEvent("onBrettDataNeed", gMe, 0)
	addEvent("onBrettDataNeedBack", true)
	addEventHandler("onBrettDataNeedBack", getRootElement(),
	function(text, id)
		if(id == 0) then
			guiSetText(bText, text)
		elseif(id == 1) then
			guiSetText(bMemo, text)
		end
	end)
end

addEvent("onPlayerBrettClick", true)
addEventHandler("onPlayerBrettClick", getRootElement(),
function(zone)
createBrettGui(zone)
end)