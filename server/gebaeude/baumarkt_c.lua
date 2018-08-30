local Verkaufstante = createPed(141, -23.342805862427, -57.328399658203, 1003.546875)
setElementInterior(Verkaufstante, 6)
addEventHandler("onClientPedDamage", Verkaufstante, cancelEvent)

-- Campfire: 841 -- Fackel: 3461, -- Liege: 1255, --Grill: 1481
local Guivar = 0
addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
addEvent("onBaumarktGuiStart", true)
addEventHandler("onBaumarktGuiStart", getRootElement(),
function()
	if not(source == gMe) then return end
	if(Guivar == 1) then return end
	toggleAllControls(false)
	Guivar = 1
	showCursor(true)

	setCameraMatrix(-21.534162521362, -55.986572265625, 1003.946875, -23.342805862427, -57.328399658203, 1003.946875)
	
	local BAUFenster = {}
	local BAUKnopf = {}
	local BAULabel = {}
	local BAUBild = {}

			local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = 565,233
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	BAUFenster[1] = guiCreateWindow(X, Y, Width, Height, "Baumarkt",false)
	guiWindowSetSizable(BAUFenster[1], false)
	BAULabel[1] = guiCreateLabel(168,22,229,53,"Willkommen im Baumarkt!\nWas darf's sein?",false,BAUFenster[1])
	guiLabelSetHorizontalAlign(BAULabel[1],"center",false)
	guiSetFont(BAULabel[1],"default-bold-small")
	BAUKnopf[1] = guiCreateButton(221,197,125,24,"Schliessen",false,BAUFenster[1])
	BAUKnopf[2] = guiCreateButton(21,167,107,26,"Kaufen[25$]",false,BAUFenster[1])
	BAULabel[2] = guiCreateLabel(41,77,82,16,"Lagerfeuer",false,BAUFenster[1])
	guiSetFont(BAULabel[2],"default-bold-small")
	BAUBild[1] = guiCreateStaticImage(12,97,128,62,"data/images/baumarkt/campfire.png",false,BAUFenster[1])
	BAULabel[3] = guiCreateLabel(193,77,82,16,"Grill",false,BAUFenster[1])
	guiSetFont(BAULabel[3],"default-bold-small")
	BAUBild[2] = guiCreateStaticImage(150,97,128,62,"data/images/baumarkt/grill.png",false,BAUFenster[1])
	BAUKnopf[3] = guiCreateButton(160,166,107,26,"Kaufen[30$]",false,BAUFenster[1])
	BAUBild[3] = guiCreateStaticImage(287,97,128,62,"data/images/baumarkt/liege.png",false,BAUFenster[1])
	BAULabel[4] = guiCreateLabel(325,76,82,16,"Liege",false,BAUFenster[1])
	guiSetFont(BAULabel[4],"default-bold-small")
	BAUKnopf[4] = guiCreateButton(298,164,107,26,"Kaufen[10$]",false,BAUFenster[1])
	BAUBild[4] = guiCreateStaticImage(425,98,127,62,"data/images/baumarkt/fackel.png",false,BAUFenster[1])
	BAULabel[5] = guiCreateLabel(467,76,52,14,"Fackel",false,BAUFenster[1])
	guiSetFont(BAULabel[5],"default-bold-small")
	BAUKnopf[5] = guiCreateButton(435,166,107,26,"Kaufen[5$]",false,BAUFenster[1])

	addEventHandler("onClientGUIClick", BAUKnopf[5],
	function()
		local geld = tonumber(getElementData(gMe, "pHGeld"))
		if(geld < 6) then outputChatBox("Du hast nicht genug Kohle auf der Hand!", 255, 0, 0, false) return end
		setElementData(gMe, "pBFackel", tonumber(getElementData(gMe, "pBFackel")+1))
		setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld")-5))
		outputChatBox("Du hast dir dieses Objekt gekauft! Es wurde in dein Inventar abgelegt. Beachte: Es haelt nur diese Sitzung!", 0, 200, 0, false)
		setCameraTarget(gMe)
		Guivar = 0
		showCursor(false)
		guiSetVisible(BAUFenster[1], false)
		toggleAllControls(true)
	end, false)
	
	addEventHandler("onClientGUIClick", BAUKnopf[4],
	function()
		local geld = tonumber(getElementData(gMe, "pHGeld"))
		if(geld < 11) then outputChatBox("Du hast nicht genug Kohle auf der Hand!", 255, 0, 0, false) return end
		setElementData(gMe, "pBLiege", tonumber(getElementData(gMe, "pBLiege")+1))
		setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld")-10))
		outputChatBox("Du hast dir dieses Objekt gekauft! Es wurde in dein Inventar abgelegt. Beachte: Es haelt nur diese Sitzung!", 0, 200, 0, false)
		setCameraTarget(gMe)
		Guivar = 0
		showCursor(false)
		guiSetVisible(BAUFenster[1], false)
		toggleAllControls(true)
	end, false)
	
	addEventHandler("onClientGUIClick", BAUKnopf[3],
	function()
		local geld = tonumber(getElementData(gMe, "pHGeld"))
		if(geld < 31) then outputChatBox("Du hast nicht genug Kohle auf der Hand!", 255, 0, 0, false) return end
		setElementData(gMe, "pBGrill", tonumber(getElementData(gMe, "pBGrill")+1))
		setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld")-30))
		outputChatBox("Du hast dir dieses Objekt gekauft! Es wurde in dein Inventar abgelegt. Beachte: Es haelt nur diese Sitzung!", 0, 200, 0, false)
		setCameraTarget(gMe)
		Guivar = 0
		showCursor(false)
		guiSetVisible(BAUFenster[1], false)
		toggleAllControls(true)
	end, false)
	
	addEventHandler("onClientGUIClick", BAUKnopf[2],
	function()
		local geld = tonumber(getElementData(gMe, "pHGeld"))
		if(geld < 26) then outputChatBox("Du hast nicht genug Kohle auf der Hand!", 255, 0, 0, false) return end
		setElementData(gMe, "pBLagerfeuer", tonumber(getElementData(gMe, "pBLagerfeuer")+1))
		setElementData(gMe, "pHGeld", tonumber(getElementData(gMe, "pHGeld")-25))
		outputChatBox("Du hast dir dieses Objekt gekauft! Es wurde in dein Inventar abgelegt. Beachte: Es haelt nur diese Sitzung!", 0, 200, 0, false)
		setCameraTarget(gMe)
		Guivar = 0
		showCursor(false)
		guiSetVisible(BAUFenster[1], false)
		toggleAllControls(true)
	end, false)
	
	addEventHandler("onClientGUIClick", BAUKnopf[1],
	function()
		setCameraTarget(gMe)
		Guivar = 0
		showCursor(false)
		guiSetVisible(BAUFenster[1], false)
		toggleAllControls(true)
	end, false)
end)

local object = 0

addEvent("start_objekt_baumarkt", true)
addEventHandler("start_objekt_baumarkt", gMe,
function(var)
	if not(source == gMe) then return end
	setElementData(gMe, "inobjekt", 1)
	local x, y, z = getElementPosition(gMe)
	local int = getElementInterior(gMe)
	local dim = getElementDimension(gMe) -- 1459
	local id = 1255
	-- Campfire:  -- Fackel: , -- Liege: , --Grill: 
	if(var == "Grill") then id = 1481 end
	if(var == "Lagerfeuer") then id = 841 end
	if(var == "Liege") then id = 1255 end
	if(var == "Fackel") then id = 3461 end
	if(var == "Radio") then id = 2103 end
	object = createObject(id, x, y+1, z)
	setElementInterior(object, int)
	setElementDimension(object, dim)
	setCameraMatrix(x, y+5, z+1, x, y, z)
	setToBinds_b()
	setElementFrozen(gMe, true)
	outputChatBox("Benutze die Pfeiltasten, um das Objekt zu bewegen! Um es zu Drehen, benutze das Mausrad!", 0, 255, 0, false)
	outputChatBox("Nutze 'Bild. oben' und 'Bild. unten' um das Objekt hoch und Runter zu bewegen!", 0, 255, 0, false)
	outputChatBox("Nutze die Leertaste um Abzubrechen, und Enter um das Objekt zu Platzieren!", 0, 255, 0, false)
end)
function setToBinds_b()
	bindKey("arrow_l", "down", move_b_left)
	bindKey("arrow_r", "down", move_b_right)
	bindKey("arrow_u", "down", move_b_up)
	bindKey("arrow_d", "down", move_b_down)
	bindKey("pgup", "down", move_b_zero)
	bindKey("pgdn", "down", move_b_zup)
	bindKey("mouse_wheel_up", "down", rotate_b_1)
	bindKey("mouse_wheel_down", "down", rotate_b_2)
	bindKey("enter", "down", b_fertig_func)
	bindKey("space", "down", b_abbrechen_func)
	--addEventHandler("onClientRender", getRootElement(), check_for_object)
end
function b_abbrechen_func()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	unbindKey("arrow_l", "down", move_b_left)
	unbindKey("arrow_r", "down", move_b_right)
	unbindKey("arrow_u", "down", move_b_up)
	unbindKey("arrow_d", "down", move_b_down)
	unbindKey("pgup", "down", move_b_zero)
	unbindKey("pgdn", "down", move_b_zup)
	unbindKey("mouse_wheel_up", "down", rotate_b_1)
	unbindKey("mouse_wheel_down", "down", rotate_b_2)
	unbindKey("enter", "down", b_fertig_func)
	unbindKey("space", "down", b_abbrechen_func)
	destroyElement(object)
	setCameraTarget(gMe)
	setElementData(gMe, "inobjekt", 0)
	setElementFrozen(gMe, false)
end
function b_fertig_func()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	unbindKey("arrow_l", "down", move_b_left)
	unbindKey("arrow_r", "down", move_b_right)
	unbindKey("arrow_u", "down", move_b_up)
	unbindKey("arrow_d", "down", move_b_down)
	unbindKey("pgup", "down", move_b_zero)
	unbindKey("pgdn", "down", move_b_zup)
	unbindKey("mouse_wheel_up", "down", rotate_b_1)
	unbindKey("mouse_wheel_down", "down", rotate_b_2)
	unbindKey("enter", "down", b_fertig_func)
	unbindKey("space", "down", b_abbrechen_func)
	local x, y, z = getElementPosition(object)
	local x1, y1, z1 = getElementRotation(object)
	local int = getElementInterior(object)
	local dim = getElementDimension(object)
	local modell = getElementModel(object)
	if(modell == 1481) then setElementData(gMe, "pBGrill", tonumber(getElementData(gMe, "pBGrill"))-1) end
	if(modell == 841) then setElementData(gMe, "pBLagerfeuer", tonumber(getElementData(gMe, "pBLagerfeuer"))-1) end
	if(modell == 1255) then setElementData(gMe, "pBLiege", tonumber(getElementData(gMe, "pBLiege"))-1) end
	if(modell == 3461) then setElementData(gMe, "pBFackel", tonumber(getElementData(gMe, "pBFackel"))-1) end
	if(modell == 2103) then setElementData(gMe, "pRadios", tonumber(getElementData(gMe, "pRadios"))-1) end -- Radio
	if(modell == 2103) then -- Radio
		triggerServerEvent("onRadioCreate", gMe, x, y, z, x1, y1, z1, int, dim)
	else
		triggerServerEvent("onBaumarktObjectFinished", gMe, modell, x, y, z, x1, y1, z1, int, dim)
	end
	destroyElement(object)
	setCameraTarget(gMe)
	setElementData(gMe, "inobjekt", 0)
	setElementFrozen(gMe, false)
end

function rotate_b_2()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z-5)
end


function rotate_b_1()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementRotation(object)
	setElementRotation(object, x, y, z+5)
end

function move_b_zero()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y, z+0.25)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_b_zup()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y, z-0.25)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_b_down()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y+0.5, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end
function move_b_right()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x-0.5, y, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end
function move_b_left()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x+0.5, y, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end

function move_b_up()
	if not(tonumber(getElementData(gMe, "inobjekt")) == 1) then return end
	local x, y, z = getElementPosition(object)
	setElementPosition(object, x, y-0.5, z)
	local x, y, z = getElementPosition(object)
	setCameraMatrix(x, y+5, z+1, x, y, z)
end