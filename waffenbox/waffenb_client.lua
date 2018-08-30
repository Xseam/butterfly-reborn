local Guivar = 0

addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

local waffe1 = 0
local waffe2 = 0
local waffe3 = 0
local waffe4 = 0
local waffe5 = 0
function createWaffenboxGUIMenue()
if(Guivar == 1) then return end
	if(getElementData(gMe, "Clicked") == 1) then return end
	setElementData(gMe, "Clicked", 1)
	Guivar = 1
	showCursor(true)


	WBOXFenster = {}
	WBOXKnopf = {}
	WBOXLabel = {}
	WBOXImage = {}

		local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 656,216
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	WBOXFenster[1] = guiCreateWindow(X, Y, Width, Height,"Waffenbox",false)
	WBOXKnopf[1] = guiCreateButton(280,175,100,31,"Schliessen",false,WBOXFenster[1])
	WBOXLabel[1] = guiCreateLabel(0,19,148,42,"Slot 1:\nWaffe: 0\nMunition: 0",false,WBOXFenster[1])
	guiLabelSetHorizontalAlign(WBOXLabel[1],"center",false)
	guiSetFont(WBOXLabel[1],"default-bold-small")
	WBOXKnopf[2] = guiCreateButton(275,129,111,37,"Herausnehmen/\nEinlagern",false,WBOXFenster[1]) -- Slot 3
	WBOXKnopf[3] = guiCreateButton(20,130,111,37,"Herausnehmen/\nEinlagern",false,WBOXFenster[1]) -- Slot 1
	WBOXLabel[2] = guiCreateLabel(134,17,148,42,"Slot 2:\nWaffe: 0\nMunition: 0",false,WBOXFenster[1])
	guiLabelSetHorizontalAlign(WBOXLabel[2],"center",false)
	guiSetFont(WBOXLabel[2],"default-bold-small")
	WBOXKnopf[4] = guiCreateButton(149,129,111,37,"Herausnehmen/\nEinlagern",false,WBOXFenster[1]) -- Slot 2
	WBOXKnopf[5] = guiCreateButton(401,129,111,37,"Herausnehmen/\nEinlagern",false,WBOXFenster[1]) -- Slot 4
	WBOXKnopf[6] = guiCreateButton(526,128,111,37,"Herausnehmen/\nEinlagern",false,WBOXFenster[1]) --Slot 5
	WBOXLabel[3] = guiCreateLabel(256,18,148,42,"Slot 3:\nWaffe: 0\nMunition: 0",false,WBOXFenster[1])
	guiLabelSetHorizontalAlign(WBOXLabel[3],"center",false)
	guiSetFont(WBOXLabel[3],"default-bold-small")
	WBOXLabel[4] = guiCreateLabel(374,18,148,42,"Slot 4:\nWaffe: 0\nMunition: 0",false,WBOXFenster[1])
	guiLabelSetHorizontalAlign(WBOXLabel[4],"center",false)
	guiSetFont(WBOXLabel[4],"default-bold-small")
	WBOXLabel[5] = guiCreateLabel(499,16,148,42,"Slot 5:\nWaffe: 0\nMunition: 0",false,WBOXFenster[1])
	guiLabelSetHorizontalAlign(WBOXLabel[5],"center",false)
	guiSetFont(WBOXLabel[5],"default-bold-small")
	WBOXLabel[6] = guiCreateLabel(17,174,253,33,"___________________________________________________",false,WBOXFenster[1])
	WBOXLabel[7] = guiCreateLabel(389,173,253,33,"___________________________________________________",false,WBOXFenster[1])
	WBOXImage[1] = guiCreateStaticImage(31,62,82,64,"data/images/waffen/unknow.png",false,WBOXFenster[1])
	WBOXImage[2] = guiCreateStaticImage(165,62,82,64,"data/images/waffen/unknow.png",false,WBOXFenster[1])
	WBOXImage[3] = guiCreateStaticImage(288,58,82,64,"data/images/waffen/unknow.png",false,WBOXFenster[1])
	WBOXImage[4] = guiCreateStaticImage(409,58,82,64,"data/images/waffen/unknow.png",false,WBOXFenster[1])
	WBOXImage[5] = guiCreateStaticImage(534,56,82,64,"data/images/waffen/unknow.png",false,WBOXFenster[1])
	guiSetEnabled(WBOXKnopf[2], false)
	guiSetEnabled(WBOXKnopf[3], false)
	guiSetEnabled(WBOXKnopf[4], false)
	guiSetEnabled(WBOXKnopf[5], false)
	guiSetEnabled(WBOXKnopf[6], false)
	addEventHandler("onClientGUIClick", WBOXKnopf[1],
	function()
		Guivar = 0
		showCursor(false)
		guiSetVisible(WBOXFenster[1], false)
		setElementData(gMe, "Clicked", 0)
	end, false)
	
	triggerServerEvent("onWaffenboxDataNeed", gMe)
		
		addEventHandler("onClientGUIClick", WBOXKnopf[6], --Slot 2
	function()
	if(waffe5 == 0) then
		triggerServerEvent("onWaffenboxAction", gMe, 5, 0)
	elseif(waffe5 == 1) then
		triggerServerEvent("onWaffenboxAction", gMe, 5, 1)
	end
	end, false)
	addEventHandler("onClientGUIClick", WBOXKnopf[5], --Slot 4
	function()
	if(waffe4 == 0) then
		triggerServerEvent("onWaffenboxAction", gMe, 4, 0)
	elseif(waffe4 == 1) then
		triggerServerEvent("onWaffenboxAction", gMe, 4, 1)
	end
	end, false)
	
	addEventHandler("onClientGUIClick", WBOXKnopf[2], --Slot 3
	function()
	if(waffe3 == 0) then
		triggerServerEvent("onWaffenboxAction", gMe, 3, 0)
	elseif(waffe3 == 1) then
		triggerServerEvent("onWaffenboxAction", gMe, 3, 1)
	end
	end, false)
	
		addEventHandler("onClientGUIClick", WBOXKnopf[4], --Slot 2
	function()
	if(waffe2 == 0) then
		triggerServerEvent("onWaffenboxAction", gMe, 2, 0)
	elseif(waffe2 == 1) then
		triggerServerEvent("onWaffenboxAction", gMe, 2, 1)
	end
	end, false)
	
	addEventHandler("onClientGUIClick", WBOXKnopf[3], --Slot 1
	function()
	if(waffe1 == 0) then
		triggerServerEvent("onWaffenboxAction", gMe, 1, 0)
	elseif(waffe1 == 1) then
		triggerServerEvent("onWaffenboxAction", gMe, 1, 1)
	end
	end, false)
end

addEvent("onWaffenboxGUIStart", true)
addEventHandler("onWaffenboxGUIStart", gMe, createWaffenboxGUIMenue)

addEvent("onWaffenboxDataNeedBack", true)
	addEventHandler("onWaffenboxDataNeedBack", gMe,
		function(w1, w1a, w2, w2a, w3, w3a, w4, w4a, w5, w5a)
		if not(source == gMe) then return end
		local w1 = tonumber(w1)
		local w2 = tonumber(w2)
		local w3 = tonumber(w3)
		local w4 = tonumber(w4)
		local w5 = tonumber(w5)
		local w1a = tonumber(w1a)
		local w2a = tonumber(w2a)
		local w3a = tonumber(w3a)
		local w4a = tonumber(w4a)
		local w5a = tonumber(w5a)
		guiSetEnabled(WBOXKnopf[2], true)
		guiSetEnabled(WBOXKnopf[3], true)
		guiSetEnabled(WBOXKnopf[4], true)
		guiSetEnabled(WBOXKnopf[5], true)
		guiSetEnabled(WBOXKnopf[6], true)
		guiSetText(WBOXLabel[1], "Slot 1:\n"..getWeaponNameFromID(w1).."\nMunition: "..w1a)
		guiSetText(WBOXLabel[2], "Slot 2:\n"..getWeaponNameFromID(w2).."\nMunition: "..w2a)
		guiSetText(WBOXLabel[3], "Slot 3:\n"..getWeaponNameFromID(w3).."\nMunition: "..w3a)
		guiSetText(WBOXLabel[4], "Slot 4:\n"..getWeaponNameFromID(w4).."\nMunition: "..w4a)
		guiSetText(WBOXLabel[5], "Slot 5:\n"..getWeaponNameFromID(w5).."\nMunition: "..w5a)
		if(w1 == 0) or(w1 == 1) or(w1 == nil) then guiSetText(WBOXKnopf[3], "Einlagern") waffe1 = 0 else waffe1 = 1 guiSetText(WBOXKnopf[3], "Herausnehmen") end
		if(w2 == 0) or(w2 == 1) or(w2 == nil) then guiSetText(WBOXKnopf[4], "Einlagern") waffe2 = 0 else waffe2 = 1 guiSetText(WBOXKnopf[4], "Herausnehmen") end
		if(w3 == 0) or(w3 == 1) or(w3 == nil) then guiSetText(WBOXKnopf[2], "Einlagern") waffe3 = 0 else waffe3 = 1 guiSetText(WBOXKnopf[2], "Herausnehmen") end
		if(w4 == 0) or(w4 == 1) or(w4 == nil) then guiSetText(WBOXKnopf[5], "Einlagern") waffe4 = 0 else waffe4 = 1 guiSetText(WBOXKnopf[5], "Herausnehmen") end
		if(w5 == 0) or(w5 == 1) or(w5 == nil) then guiSetText(WBOXKnopf[6], "Einlagern") waffe5 = 0 else waffe5 = 1 guiSetText(WBOXKnopf[6], "Herausnehmen") end
		local bild1 = guiStaticImageLoadImage(WBOXImage[1], "data/images/waffen/"..tostring(w1)..".png")
		if(bild1) then else guiStaticImageLoadImage(WBOXImage[1], "data/images/waffen/unknow.png") end
		local bild2 = guiStaticImageLoadImage(WBOXImage[2], "data/images/waffen/"..tostring(w2)..".png")
		if(bild2) then else guiStaticImageLoadImage(WBOXImage[2], "data/images/waffen/unknow.png") end
		local bild3 = guiStaticImageLoadImage(WBOXImage[3], "data/images/waffen/"..tostring(w3)..".png")
		if(bild3) then else guiStaticImageLoadImage(WBOXImage[3], "data/images/waffen/unknow.png") end
		local bild4 = guiStaticImageLoadImage(WBOXImage[4], "data/images/waffen/"..tostring(w4)..".png")
		if(bild4) then else guiStaticImageLoadImage(WBOXImage[4], "data/images/waffen/unknow.png") end
		local bild5 = guiStaticImageLoadImage(WBOXImage[5], "data/images/waffen/"..tostring(w5)..".png")
		if(bild5) then else guiStaticImageLoadImage(WBOXImage[5], "data/images/waffen/unknow.png") end
	end
	)
	