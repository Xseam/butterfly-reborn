local Guivar = 0
function createFrakLagerGui()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	setElementData(gMe, "Clicked", 1)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	
	local LAGFenster = {}
	local LAGKnopf = {}
	local LAGLabel = {}
	local LAGEdit = {}
	local LAGRadio = {}
	
	local X, Y, Width, Height = getMiddleGuiPosition(387,120)
	LAGFenster[1] = guiCreateWindow(X, Y, Width, Height,"Lager",false)
	LAGLabel[1] = guiCreateLabel(11,25,271,17,"Vorhandene Drogen: 0g",false,LAGFenster[1])
	guiSetFont(LAGLabel[1],"default-bold-small")
	LAGLabel[2] = guiCreateLabel(11,39,271,17,"Vorhandene Materialien: 0",false,LAGFenster[1])
	guiSetFont(LAGLabel[2],"default-bold-small")
	LAGKnopf[1] = guiCreateButton(21,71,116,30,"Schliessen",false,LAGFenster[1])
	LAGEdit[1] = guiCreateEdit(217,24,88,25,"",false,LAGFenster[1])
	guiEditSetMaxLength(LAGEdit[1],5)
	LAGKnopf[2] = guiCreateButton(218,58,87,24,"Herausnehmen",false,LAGFenster[1])
	LAGKnopf[3] = guiCreateButton(218,82,87,24,"Einlagern",false,LAGFenster[1])
	LAGRadio[1] = guiCreateRadioButton(312,27,67,25,"Drogen",false,LAGFenster[1])
	LAGRadio[2] = guiCreateRadioButton(313,52,66,25,"Mats.",false,LAGFenster[1])
	-- 
	local myFrak = getPlayerFraktion(gMe)
	triggerServerEvent("onDrugDataFrakNeed", gMe, myFrak)
	addEvent("onDrugDataFrakNeedBack", true)
	addEventHandler("onDrugDataFrakNeedBack", getRootElement(),
	function(drugs, mats)
		guiSetText(LAGLabel[1], "Vorhandene Drogen: "..drugs.."g")
		guiSetText(LAGLabel[2], "Vorhandene Materialien: "..mats)
	end)
	--
	addEventHandler("onClientGUIClick", LAGKnopf[2],
	function()
		local r1 = guiRadioButtonGetSelected(LAGRadio[1])
		local r2 = guiRadioButtonGetSelected(LAGRadio[2])
		local misc = getElementData(gMe, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		if(r1 == true) then
			local text = tonumber(guiGetText(LAGEdit[1]))
			if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0) return end
			triggerServerEvent("onDrugDataAuszahl", gMe, text, "Drogen")
		elseif(r2 == true) then
			local text = tonumber(guiGetText(LAGEdit[1]))
			if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0) return end
			triggerServerEvent("onDrugDataAuszahl", gMe, text, "Mats")
		end
	end, false)
	
	addEventHandler("onClientGUIClick", LAGKnopf[3],
	function()
		local r1 = guiRadioButtonGetSelected(LAGRadio[1])
		local r2 = guiRadioButtonGetSelected(LAGRadio[2])
		local misc = getElementData(gMe, "pMISC")
		local drogen, mats = tonumber(gettok(misc, 1, "|")), tonumber(gettok(misc, 2, "|"))
		if(r1 == true) then
			local text = tonumber(guiGetText(LAGEdit[1]))
			if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0) return end
			if(drogen < text) then outputChatBox("Soviele Drogen hast du nicht!", 200, 0, 0) return end
			triggerServerEvent("onDrugDataEinzahl", gMe, text, "Drogen")
		elseif(r2 == true) then
			local text = tonumber(guiGetText(LAGEdit[1]))
			if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0) return end
			if(mats < text) then outputChatBox("Soviele Materialien hast du nicht!", 200, 0, 0) return end
			triggerServerEvent("onDrugDataEinzahl", gMe, text, "Mats")
		end
	end, false)
	
	addEventHandler("onClientGUIClick", LAGKnopf[1],
	function()
		Guivar = 0
		showCursor(false)
		destroyElement(LAGFenster[1])
		setElementData(gMe, "Clicked", 0)
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	end, false)
	
	
end

addEvent("onFraktionsDrugsGuiStart", true)
addEventHandler("onFraktionsDrugsGuiStart", getRootElement(),
function()
	createFrakLagerGui()
end)

local drugtime = 0
local indrugs
local drugTimer

function addDrugTime()
	if(indrugs == 0) then
		killTimer(drugTimer)
		drugTimer = setTimer(
			function()
			indrugs = nil
			toggleControl("sprint", true)
			end, math.random(30000, 50000), 1)
		indrugs = 1
	else
		drugTimer = setTimer(
			function()
			indrugs = nil
			toggleControl("sprint", true)
			end, math.random(30000, 50000), 1)
		indrugs = 1
	end
	toggleControl("sprint", false)
end

addEvent("onPlayerDrugNehme", true)
addEventHandler("onPlayerDrugNehme", getRootElement(),
function()
	addDrugTime()
end)

local sx, sy = guiGetScreenSize()
local interface_d = {}
local images = {}

local effectStates = {cl=1,sxx,syy,state=false}

function d_render()
if(isPedDead(getLocalPlayer())) then if(indrugs == 1) then indrugs = nil end end
		if indrugs == 1 then
			if effectStates.cl > 0.1 then
			 effectStates.cl = effectStates.cl - 0.01
			end
		 dxUpdateScreenSource(d_screen)
		 dxDrawImage(0,0,sx,sy,interface_d.shader)
		 effectStates.realState = true
		elseif effectStates.realState then
			if effectStates.cl < 1 then
			 effectStates.cl = effectStates.cl + 0.01
			else
			 effectStates.realState = false
			end
		 dxUpdateScreenSource(d_screen)
		 dxDrawImage(0,0,sx,sy,interface_d.shader)
		end
	local tick = getTickCount()
	dxSetShaderValue(interface_d.shader,'pX',1/sx*math.random(0,10)/12*(1/effectStates.cl)+sx*tick%30/10)
	dxSetShaderValue(interface_d.shader,'pY',1/sy*math.random(0,10)/12*(1/effectStates.cl)+sy*tick%30/10)
	dxSetShaderValue(interface_d.shader,'cr',effectStates.cl)
	dxSetShaderValue(interface_d.shader,'cb',effectStates.cl)
	--dxSetShaderValue(interface_d.shader,'cg',effectStates.cl)

	
end

addCommandHandler("rebind", function() indrugs = nil end)

addEventHandler('onClientResourceStart',resourceRoot,function()
	interface_d.shader = dxCreateShader('client/choke/shad.fx')
	d_screen = dxCreateScreenSource(sx,sy)
	dxUpdateScreenSource(d_screen)
	dxSetShaderValue(interface_d.shader,'screenSource',d_screen)
	dxSetShaderValue(interface_d.shader,'cr',1)
	dxSetShaderValue(interface_d.shader,'cg',1)
	dxSetShaderValue(interface_d.shader,'cb',1)
	dxSetShaderValue(interface_d.shader,'pX',1/sx)
	dxSetShaderValue(interface_d.shader,'pY',1/sy)
	addEventHandler('onClientHUDRender',root,d_render)
end)