local Guivar = 0
-- Falls Jemand noch Radiosender hat, bitte Melden! --
local radNotes = {}
local radState = {}
local radPos = {}

local radioSender = {
	[1] = "FFN|http://player.ffn.de/tunein_ffn.asx",
	[2] = "89.0 RTL|http://80.237.156.45/890rtl-128.mp3",
	[3] = "Technobase.FM|http://listen.technobase.fm/dsl.asx",
	[4] = "N-Joy|http://ndrstream.ic.llnwd.net/stream/ndrstream_n-joy_hi_mp3.m3u",
	[5] = "HardBase.FM|http://listen.hardbase.fm/tunein-dsl-asx",
	[6] = "HouseTime.FM|http://listen.housetime.fm/tunein-dsl-asx",
	[7] = "Techno4ever|http://www.techno4ever.net/t4e/stream/dsl_listen.asx",
	[8] = "Anarchy of Sound|http://server02.stream-login.eu/tunein.php/kn1093/playlist.pls",
	[9] = "RauteM. Charts|http://charthits-high.rautemusik.fm//listen.pls",
	[10] = "RauteM. Club|http://club-high.rautemusik.fm/rm.page//listen.pls",
	[11] = "RauteM. Rock|http://rock-high.rautemusik.fm//listen.pls",
	[12] = "RauteM. Metal|http://metal-high.rautemusik.fm/rm.page//listen.pls",
	[13] = "RauteM. House|http://house-high.rautemusik.fm/rm.page//listen.pls",
	[14] = "RauteM. Jam|http://jam-high.rautemusik.fm/rm.page//listen.pls",
	[15] = "RauteM. Progressive|http://progressive-high.rautemusik.fm/listen.pls",
	[16] = "RauteM. Goldies|http://goldies-high.rautemusik.fm/rm.page//listen.pls",
	[17] = "RauteM. Lounge|http://lounge-high.rautemusik.fm/rm.page//listen.pls",
	[18] = "RauteM. Harder|http://harder-high.rautemusik.fm/listen.pls",
	[19] = "RauteM. BCB|http://bcb-high.rautemusik.fm/listen.pls",
	[20] = "RauteM. Oriental|http://oriental-high.rautemusik.fm/listen.pls",
	[21] = "RauteM. Schlager|http://schlager-high.rautemusik.fm/listen.pls",
	[22] = "RauteM. Drumstep|http://drumstep-high.rautemusik.fm//listen.pls",
}
-- Kacke, funktioniert nicht --
--[[
addEventHandler("onClientRender", getRootElement(), function()
	for index, radio in pairs(getElementsByType("object")) do
		if(getElementData(radio, "radio") == true) and (getElementData(radio, "radio.url")) then
			if not(radState[radio]) then radState[radio] = {} radNotes[radio] = {} end
			if not(radState[radio][1]) and not(radState[radio][2])and not(radState[radio][3])and not(radState[radio][4])  then
				radState[radio][1] = true
				radPos[radio] = {}
				radPos[radio][1] = {}
				setTimer(function() radState[radio][1] = nil radPos[radio][1]["Y"] = nil radPos[radio][1]["Z"] = nil end, 2000, 1)
			end
			if not(radState[radio][2]) and not(radState[radio][1])and not(radState[radio][3])and not(radState[radio][4])  then
				radState[radio][2] = true
				radPos[radio] = {}
				radPos[radio][2] = {}
				setTimer(function() radState[radio][2] = nil radPos[radio][2]["Y"] = nil radPos[radio][2]["Z"] = nil end, 2000, 1)
			end
			if not(radState[radio][3]) and not(radState[radio][1])and not(radState[radio][2])and not(radState[radio][4])  then
				radState[radio][3] = true
				radPos[radio] = {}
				radPos[radio][3] = {}
				setTimer(function() radState[radio][3] = nil radPos[radio][3]["Y"] = nil radPos[radio][3]["Z"] = nil end, 2000, 1)
			end
			if not(radState[radio][4]) and not(radState[radio][2])and not(radState[radio][3])and not(radState[radio][1])  then
				radState[radio][4] = true
				radPos[radio] = {}
				radPos[radio][4] = {}
				setTimer(function() radState[radio][4] = nil radPos[radio][4]["Y"] = nil radPos[radio][4]["Z"] = nil end, 2000, 1)
			end
			local x, y, z = getElementPosition(radio)
			local sx, sy = getScreenFromWorldPosition(x, y, z)
			if (sx) and (sy) then
				if(radState[radio][1] == true) then
					if not(radPos[radio][1]) then
						radPos[radio][1] = {}
						radPos[radio][1]["Y"], radPos[radio][1]["Z"] = math.random(0.2, 1.0), math.random(0.2, 1.0)
					end
					dxDrawImage(x, y, 28, 28, "data/images/note1.png")
				end
				if(radState[radio][2] == true) then
					if not(radPos[radio][2]) then
						radPos[radio][2] = {}
						radPos[radio][2]["Y"], radPos[radio][2]["Z"] = math.random(0.2, 1.0), math.random(0.2, 1.0)
					end
					dxDrawImage(x, y, 28, 28, "data/images/note1.png")
				end
				if(radState[radio][3] == true) then
					if not(radPos[radio][3]) then
						radPos[radio][3] = {}
						radPos[radio][3]["Y"], radPos[radio][3]["Z"] = math.random(0.2, 1.0), math.random(0.2, 1.0)
					end
					dxDrawImage(x, y, 28, 28, "data/images/note1.png")
				end
				if(radState[radio][4] == true) then
					if not(radPos[radio][4]) then
						radPos[radio][4] = {}
						radPos[radio][4]["Y"], radPos[radio][4]["Z"] = math.random(0.2, 1.0), math.random(0.2, 1.0)
					end
					dxDrawImage(x, y, 28, 28, "data/images/note1.png")
				end
			end
		end
	end
end)
--]]
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	for index, radios in pairs(getElementsByType("object")) do
		if(getElementData(radios, "radio") == true) and (getElementData(radios, "radio.url")) then
			local x, y, z = getElementPosition(radios)
			local url = getElementData(radios, "radio.url")
			if(url) then
				local looped = getElementData(radios, "radio.looped")
				local sound = playSound3D(url, x, y, z, looped)
				setElementInterior(sound, getElementInterior(radios))
				setElementDimension(sound, getElementDimension(radios))
				setSoundMaxDistance(sound, 20)
				setElementData(sound, "parent", radios)
			end
		end
	end
end)

addEvent("onRadioSoundStart", true)
addEventHandler("onRadioSoundStart", getRootElement(),
function(theRadio)
	local x, y, z = getElementPosition(theRadio)
	local url = getElementData(theRadio, "radio.url")
	for index, sound in pairs(getElementsByType("sound")) do
		if(getElementData(sound, "parent") == theRadio) then
			destroyElement(sound)
		end
	end
	if(url) then
		local looped = getElementData(theRadio, "radio.looped")
		local sound = playSound3D(url, x, y, z, looped)
		setElementInterior(sound, getElementInterior(theRadio))
		setElementDimension(sound, getElementDimension(theRadio))
		setSoundMaxDistance(sound, 20)
		setElementData(sound, "parent", theRadio)
	end
end)

addEvent("onRadioSoundStop", true)
addEventHandler("onRadioSoundStop", getRootElement(),
function(radio)
	for index, sound in pairs(getElementsByType("sound")) do
		if(getElementData(sound, "parent") == radio) then
			destroyElement(sound)
		end
	end
end)

addEvent("onPlayerRadioClick", true)
addEventHandler("onPlayerRadioClick", getRootElement(),
function(theRadio)
	if(Guivar == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	showCursor(true)
	addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
	setElementData(gMe, "Clicked", 1)
	local X, Y, Width, Height = getMiddleGuiPosition(430,302)
	local Fenster = guiCreateWindow(X, Y, Width, Height,"Radio von "..getElementData(theRadio, "radio.owner"),false)
	local Label = guiCreateLabel(9,23,161,19,"Radio Stream URL Aendern:",false,Fenster)
	guiSetFont(Label,"default-bold-small")
	local Edit = guiCreateEdit(9,51,294,30,"",false,Fenster)
	if(getElementData(theRadio, "radio.url")) then
		guiSetText(Edit, getElementData(theRadio, "radio.url"))
	end
	local Knopf1 = guiCreateButton(196,20,104,25,"Abbrechen",false,Fenster)
	local Knopf2 = guiCreateButton(11,85,92,26,"Veraendern",false,Fenster)
	local Knopf3 = guiCreateButton(105,84,96,28,"Radio Aufheben",false,Fenster)
	local Knopf4 = guiCreateButton(204,85,98,26,"Radio Loeschen",false,Fenster)
	local Label2 = guiCreateLabel(10,119,161,19,"Vorgegebene Sender:",false,Fenster)
	guiSetFont(Label2,"default-bold-small")
	local Grid = guiCreateGridList(12,153,409,140,false,Fenster)
	local Checkbox = guiCreateCheckBox(309,27,112,28,"Looping",false,false,Fenster)
	guiCheckBoxSetSelected(Checkbox,false)
	guiSetFont(Checkbox,"default-bold-small")
	if(getElementData(theRadio, "radio.looped") == true) then guiCheckBoxSetSelected(Checkbox, true) end
	local Knopf5 = guiCreateButton(304,85,97,26,"Radio Stoppen",false,Fenster)
	guiGridListSetSelectionMode(Grid,1)
	guiGridListAddColumn(Grid,"Sender",0.5)
	guiGridListAddColumn(Grid,"URL",0.62)
	
	local Knopf6 = guiCreateButton(181,120,114,25,"^ Einfuegen",false,Fenster)
	local function fillList()
		guiGridListClear(Grid)
		guiGridListSetSortingEnabled(Grid, false)
		for i = 1, #radioSender, 1 do
			local sender = gettok(radioSender[i], 1, "|")
			local url = gettok(radioSender[i], 2, "|")
			local row = guiGridListAddRow(Grid)
			guiGridListSetItemText(Grid, row, 1, sender, false, false)
			guiGridListSetItemText(Grid, row, 2, url, false, false)
		end
	end
	fillList()
	local function closeFenster()
		destroyElement(Fenster)
		Guivar = 0
		removeEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)
		showCursor(false)
		setElementData(gMe, "Clicked", 0)
	end
	
	addEventHandler("onClientGUIClick", Knopf1, closeFenster, false)
	addEventHandler("onClientGUIClick", Knopf6, function()
		local url = guiGridListGetItemText(Grid, guiGridListGetSelectedItem(Grid), 2)
		if(url == "") or (url == " ") then outputChatBox("Du musst ein Sender auswaehlen!", 200, 0, 0) return end
		guiSetText(Edit, url)
	end, false)
	addEventHandler("onClientGUIClick", Knopf5, function()
		triggerServerEvent("onRadioStop", gMe, theRadio)
		closeFenster()
	end, false)
	addEventHandler("onClientGUIClick", Knopf4, function()
		triggerServerEvent("onRadioDestroy", gMe, theRadio)
		closeFenster()
	end, false)
	addEventHandler("onClientGUIClick", Knopf3, function()
		triggerServerEvent("onRadioAufheb", gMe, theRadio)
		closeFenster()
	end, false)
	addEventHandler("onClientGUIClick", Knopf2, function()
	local url = guiGetText(Edit)
		if(url == "") or (url == " ") then outputChatBox("Du musst eine URL eingeben!", 200, 0, 0) return end
		local sound = playSound3D(url, 0, 0, 0)
		if(sound == false) then outputChatBox("Fehlerhafte URL! Sound kann nicht Abgespielt werden.", 200, 0, 0) return end
		destroyElement(sound)
		local looped = guiCheckBoxGetSelected(Checkbox)
		triggerServerEvent("onRadioURLChange",gMe, theRadio, url, looped)
		closeFenster()
	end, false)
end)
local zeit = 5
local timer = {}
local playerzeit = {}
function removebike(thePlayer)
	if isElement(bus) and source == bus then
	    outputChatBox( "wird zerstoert in 5 sekunden, wenn du nicht wieder in den Bus einsteigst", thePlayer, 255, 255, 0, true )
		playerzeit[thePlayer] = zeit
		timer[thePlayer] = setTimer(function()
			playerzeit[thePlayer] = playerzeit[thePlayer]-1
			outputChatBox( "wird zerstoert in "..playerzeit[thePlayer].." sekunden, wenn du nicht wieder in den Bus einsteigst", thePlayer, 255, 255, 0, true )
			if(playerzeit[thePlayer] < 1) then
				destroyElement(bus)
			end
		end, 1000, zeit)
		
	end
end
addEventHandler("onVehicleExit", getRootElement(), removebike)
addEventHandler("onVehicleEnter", getRootElement(), function(thePlayer)
	if(isTimer(timer[thePlayer])) then
		killTimer(timer[thePlayer])
		playerzeit[thePlayer] = zeit
	end
end)