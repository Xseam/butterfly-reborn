local Guivar = 0
local Fenster = {}

function createSelfMenueGui()
	if(getElementData(gMe, "inLogin") == true) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

	local Knopf = {}
	local Knopf = {}
	local Bild = {}
	local X, Y, Width, Height = getMiddleGuiPosition(418,234)
	
	Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Information",false)
	Bild[1] = guiCreateStaticImage(14,29,133,119,"data/images/skins/unknow.png",false,Fenster[1])
	local skin = tonumber(getElementData(gMe, "pSkin"))
	if(skin) then
		if(fileExists("data/images/skins/"..skin..".png")) then
			guiStaticImageLoadImage(Bild[1], "data/images/skins/"..skin..".png")
		else
			guiStaticImageLoadImage(Bild[1], "data/images/skins/unknow.png")
		end
	end
	Knopf[1] = guiCreateLabel(155,41,258,109,"Name: "..getPlayerName(gMe).."\n\nFraktion: "..fraktionNamen[getPlayerFraktion(gMe)].."\n\nFraktionsrang: "..getPlayerFraktionsrang(gMe).."\n\nSpielzeit: "..getElementData(gMe, "pSpielzeit"),false,Fenster[1])
	guiSetFont(Knopf[1],"default-bold-small")
	Knopf[2] = guiCreateLabel(154,22,237,21,"_____________________________________",false,Fenster[1])
	guiLabelSetColor(Knopf[2],0, 255, 255)
	Knopf[3] = guiCreateLabel(156,133,237,21,"_____________________________________",false,Fenster[1])
	guiLabelSetColor(Knopf[3],0,255,255)
	Knopf[1] = guiCreateButton(13,157,129,29,"Shaders verwalten",false,Fenster[1])
	Knopf[2] = guiCreateButton(13,189,129,29,"Handy Deaktivieren",false,Fenster[1])
	Knopf[3] = guiCreateButton(146,158,129,29,"Hilfemenue Oeffnen",false,Fenster[1])
	Knopf[4] = guiCreateButton(147,189,129,29,"Report Melden",false,Fenster[1])
	Knopf[5] = guiCreateButton(278,158,129,29,"Skin Speichern",false,Fenster[1])
	Knopf[6] = guiCreateButton(278,189,129,29,"Schliessen",false,Fenster[1])
	local function reloadHandy()
		local handy = getElementData(gMe, "pHandystate")
		if(handy == false) then
			guiSetText(Knopf[2], "Handy aktivieren")
		else
			guiSetText(Knopf[2], "Handy deaktivieren")
		end
	end
	reloadHandy()
	addEventHandler("onClientGUIClick", Knopf[2],function() --Handy
		if(hasPlayerHandy(gMe) == false) then outputChatBox("Du hast kein Handy!", 200, 0, 0) return end
		local handy = getElementData(gMe, "pHandystate")
		if(handy == false) then
			setElementData(gMe, "pHandystate", true)
			outputChatBox("Du hast dein Handy aktiviert.", 0, 200, 0)
		else
			setElementData(gMe, "pHandystate", false)
			outputChatBox("Du hast dein Handy deaktivert.", 0, 200, 0)
		end
		reloadHandy()
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[3],function() -- Hilfemenue
		executeCommandHandler("helpmenue")
		destroyElement(Fenster[1])
		Guivar = 0
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[6],function() -- Exit LOL xD
		destroyElement(Fenster[1])
		Guivar = 0
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
	end, false)
	addEventHandler("onClientGUIClick", Knopf[1],function() -- Shaders
		executeCommandHandler("shaders")
		destroyElement(Fenster[1])
		Guivar = 0
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(true)
	end, false)
	addEventHandler("onClientGUIClick", Knopf[5],function() -- Skin
		triggerServerEvent("onSelfmenueSkinChange", gMe)
	end, false)
	
end
bindKey("i", "down", function()
	if(Guivar == 0) then
		createSelfMenueGui()
	else
		destroyElement(Fenster[1])
		Guivar = 0
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
	end
end)
addCommandHandler("info", function()
	if(Guivar == 0) then
		createSelfMenueGui()
	else
		destroyElement(Fenster[1])
		Guivar = 0
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
	end
end)

addEvent("onClientSelfmenue", true)
addEventHandler("onClientSelfmenue", getRootElement(), function() executeCommandHandler("info") end)
