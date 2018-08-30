local Guivar = 0

addEventHandler("onClientRender", getRootElement(), function() if(Guivar == 1) then showCursor(true) end end)

local Loginfenster = {}
local LoginTabPanel = {}
local LoginTab = {}
local LoginKnopf = {}
local LoginLabel = {}
local LoginEdit = {}
local LoginRadio = {}
local LoginGrid = {}
local LoginBild = {}
	
function createRegisterMenue()
	if(Guivar == 1) then return end
	local data = tonumber(getElementData(gMe, "scriptvar"))
	if(data == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	setElementData(gMe, "inLogin", true)

	local X, Y, Width, Height = getMiddleGuiPosition(531,300)
	showCursor(true)
	-- LOGIN --
	Loginfenster[1] = guiCreateWindow(X, Y, Width, Height,"Willkommen!",false)
	LoginTabPanel[1] = guiCreateTabPanel(9,26,513,265,false,Loginfenster[1])
	LoginTab[1] = guiCreateTab("Login",LoginTabPanel[1])
	LoginBild[1] = guiCreateStaticImage(8,11,489,68,"data/images/logo.png",false,LoginTab[1])
	LoginLabel[1] = guiCreateLabel(99,87,301,35,"Willkommen auf BF-Reallife!\nDeine Daten wurden gefunden, bitte Logge dich ein!",false,LoginTab[1])
	guiLabelSetHorizontalAlign(LoginLabel[1],"center",false)
	guiSetFont(LoginLabel[1],"default-bold-small")
	LoginLabel[2] = guiCreateLabel(16,122,117,17,"Passwort:",false,LoginTab[1])
	guiSetFont(LoginLabel[2],"default-bold-small")
	LoginEdit[1] = guiCreateEdit(15,142,471,29,"12345",false,LoginTab[1])
	guiEditSetMasked(LoginEdit[1],true)
	LoginKnopf[1] = guiCreateButton(158,179,183,29,"Einloggen",false,LoginTab[1])
	LoginLabel[3] = guiCreateLabel(9,214,497,27,"(Falls du noch kein Account hast, Registriere dich, oder nehme einen anderen Namen.)",false,LoginTab[1])
	guiSetFont(LoginLabel[3],"default-bold-small")
	-- REGISTER --
	LoginTab[2] = guiCreateTab("Register",LoginTabPanel[1])
	LoginLabel[4] = guiCreateLabel(17,12,228,24,"Bitte Fuelle dieses Formular aus!",false,LoginTab[2])
	guiSetFont(LoginLabel[4],"default-bold-small")
	LoginLabel[5] = guiCreateLabel(15,41,292,15,"Accountname: "..getPlayerName(gMe),false,LoginTab[2])
	guiLabelSetColor(LoginLabel[5],255, 255, 0)
	guiSetFont(LoginLabel[5],"default-bold-small")
	LoginLabel[6] = guiCreateLabel(15,58,211,18,"Passwort:",false,LoginTab[2])
	guiLabelSetColor(LoginLabel[6],0, 255, 0)
	guiSetFont(LoginLabel[6],"default-bold-small")
	LoginEdit[2] = guiCreateEdit(12,77,197,23,"",false,LoginTab[2])
	guiEditSetMasked(LoginEdit[2],true)
	LoginEdit[3] = guiCreateEdit(11,119,197,23,"",false,LoginTab[2])
	guiEditSetMasked(LoginEdit[3],true)
	LoginLabel[7] = guiCreateLabel(14,103,211,18,"Bestaetigung:",false,LoginTab[2])
	guiLabelSetColor(LoginLabel[7],0, 255, 0)
	guiSetFont(LoginLabel[7],"default-bold-small")
	LoginLabel[8] = guiCreateLabel(322,32,183,18,"Alter:(Kein Geburtstdatum)",false,LoginTab[2])
	guiLabelSetColor(LoginLabel[8],255, 255, 0)
	guiSetFont(LoginLabel[8],"default-bold-small")
	LoginEdit[4] = guiCreateEdit(330,55,69,23,"",false,LoginTab[2])
	LoginLabel[9] = guiCreateLabel(327,98,164,17,"Sprache:",false,LoginTab[2])
	guiLabelSetColor(LoginLabel[9],255,255,0)
	guiSetFont(LoginLabel[9],"default-bold-small")
	LoginGrid[1] = guiCreateGridList(323,119,183,97,false,LoginTab[2])
	guiGridListSetSelectionMode(LoginGrid[1],1)

	guiGridListAddColumn(LoginGrid[1],"Land",0.6)

	addEventHandler("onClientGUIClick", LoginEdit[1], function() if(guiGetText(source) == "12345") then guiSetText(source, "") end end, false)

		local row = guiGridListAddRow (LoginGrid[1] )
		guiGridListSetItemText(LoginGrid[1],row,1,"Deutschland",false,false)
		local row = guiGridListAddRow (LoginGrid[1] )
		guiGridListSetItemText(LoginGrid[1],row,1,"Oesterreich",false,false)
		local row = guiGridListAddRow (LoginGrid[1] )
		guiGridListSetItemText(LoginGrid[1],row,1,"Schweiz",false,false)

		
			guiWindowSetSizable ( Loginfenster[1], false )
			guiWindowSetMovable ( Loginfenster[1], false )


	LoginLabel[10] = guiCreateLabel(13,153,117,18,"Geschlecht:",false,LoginTab[2])
	guiLabelSetColor(LoginLabel[10],255, 255,0 )
	guiSetFont(LoginLabel[10],"default-bold-small")
	LoginRadio[1] = guiCreateRadioButton(15,175,114,21,"Maennlich",false,LoginTab[2])
	guiRadioButtonSetSelected(LoginRadio[1],true)
	LoginRadio[2] = guiCreateRadioButton(14,195,114,21,"Weiblich",false,LoginTab[2])
	LoginKnopf[2] = guiCreateButton(169,187,134,30,"Registrieren",false,LoginTab[2])
	-- Functions --
	local function setEnabled()
		for i = 1, #LoginKnopf, 1 do
			guiSetEnabled(LoginKnopf[i], true)
		end
	end
	
	local function setDisabled()
		for i = 1, #LoginKnopf, 1 do
			guiSetEnabled(LoginKnopf[i], false)
		end
	end
	
	setDisabled()

	triggerServerEvent("onLoginDataNeed", gMe)
	addEvent("onLoginDataNeedBack", true)
	addEventHandler("onLoginDataNeedBack", getRootElement(),
	function(var)
		if(var == 1) then
			setEnabled()
			guiSetSelectedTab(LoginTabPanel[1], LoginTab[1])
			guiSetEnabled(LoginTab[2], false)
			guiSetEnabled(LoginTab[1], true)
		else
			setEnabled()
			guiSetSelectedTab(LoginTabPanel[1], LoginTab[2])
			guiSetEnabled(LoginTab[1], false)
			guiSetEnabled(LoginTab[2], true)
		end
	end)

	-- EVENTS --
	--guiSetVisible(Loginfenster[1], false)
	addEvent("onBetakeyErfolgreich", true)
	addEventHandler("onBetakeyErfolgreich", getRootElement(),
	function()
		guiSetVisible(Loginfenster[1], true)
	end)
	addEventHandler("onClientGUIClick", LoginKnopf[2],
	function()
		local name = getPlayerName(gMe)
		local pw = guiGetText(LoginEdit[2])
		local pw2 = guiGetText(LoginEdit[3])
		if (pw == " ") or (pw == "") or (pw == "123456") then outputChatBox("Ungueltiges Passwort!", 255, 0, 0, false) return end
		
			if (pw ~= pw2) then outputChatBox("Die Passworter Stimmen nicht ueberein!", 255, 0, 0, false) return end
		
				if string.len(pw) <= 6 then outputChatBox("Die Minimale Passwortlaenge betraegt 6 Zeichen!", 200, 0, 0, false) return end
		
				local land = guiGridListGetItemText (LoginGrid[1], guiGridListGetSelectedItem ( LoginGrid[1] ), 1 )
		
					if(land == " ") or (land == "") then outputChatBox("Du musst ein Land auswaehlen!", 255, 0, 0, false) return end
						
						local alter = guiGetText(LoginEdit[4])
						local alternew = tonumber(alter)
						
						if(alter == " ") or (alter == "") then outputChatBox("Ungueltiges Alter!", 255, 0, 0, false) return end
								
							if(alternew < 0) or (alternew > 99) then outputChatBox("Ungueltiges Alter!", 255, 0, 0, false) return end
						
								local radio1 = guiRadioButtonGetSelected(LoginRadio[1])
								local radio2 = guiRadioButtonGetSelected(LoginRadio[2])
								local geschlecht = "N/A"
									
								if(radio1 == true) then geschlecht = "Maennlich" else geschlecht = "Weiblich" end
							
									triggerServerEvent("onRegister",gMe,name,pw,land,geschlecht,alter)
									infolabel_func("Du hast dich erfolgreich Registriert!", 0, 255, 0, 4000)
									setDisabled()

	end, false)

	addEventHandler("onClientGUIClick", LoginKnopf[1],
	function()

		local pw = guiGetText(LoginEdit[1])
		if (pw == " ") or (pw == "") then outputChatBox("Falsches Passwort!", 255, 0, 0, false) return end
		local player = getLocalPlayer()
		showCursor(false)
		Guivar = 0
		triggerServerEvent("onLogin",gMe,player, getPlayerName(getLocalPlayer()),pw)
		infolabel_func("Bitte Warten...", 0, 255, 0, 4000)
		setDisabled()
	end, false)

end
addEvent("onLoginFalsch", true)
addEventHandler("onLoginFalsch", getLocalPlayer(),
function()
	showCursor(true)
	Guivar = 1
	for i = 1, #LoginKnopf, 1 do
		guiSetEnabled(LoginKnopf[i], true)
	end
end)
addEvent("onLoginFN",true)
addEventHandler("onLoginFN",getLocalPlayer(),
function()
	fadeCamera(false, 1.0, 255, 255, 255)
	setTimer(fadeCamera, 2000, 1, true, 1.0, 255, 255, 255)
	guiSetVisible(Loginfenster[1], false)
	Guivar = 0
	showCursor(false)
	setTimer(function() resetAmbient() end, 1000, 1)
	setTimer(infolabel_func, 2000, 1, "Du hast dich erfolgreich\neingeloggt!", 0, 255, 0, 3000)
	setPlayerHudComponentVisible("radar", true)
	-- MYSQL ABFRAGE --
	local carslotvar = 5
	for index, veh in pairs(getElementsByType("vehicle")) do
		if(getElementData(veh, "Besitzer")) then
			if(getElementData(veh, "Besitzer") == getPlayerName(gMe)) then
				if(carslotvar > 5) then return end
				setElementData(gMe, "Carslot"..carslotvar, tonumber(getElementData(veh, "Carslot")))
				setElementData(gMe, "Car"..carslotvar, veh)
				carslotvar = carslotvar-1
			end
		end
	end
end, false)
local sound = 0

local ped1
local ped2
local ped3
local ped4
local ped5
local ped6
local ped7
local pedcar

-- AMBIENT --
function resetAmbient()
	removeEventHandler("onClientRender", getRootElement(), moveAmbient)
	triggerServerEvent("onXPSpawn", gMe)
	setElementData(gMe, "inLogin", false)
	ambientZeit = 0
	moveMent = 0
	if(sound) then
		setSoundVolume(sound, 0)
		destroyElement(sound)
	end
	if(isElement(ped1)) then destroyElement(ped1) end
	if(isElement(ped2)) then destroyElement(ped2) end
	if(isElement(ped3)) then destroyElement(ped3) end
	if(isElement(ped4)) then destroyElement(ped4) end
	if(isElement(ped5)) then destroyElement(ped5) end
	if(isElement(ped6)) then destroyElement(ped6) end
	if(isElement(ped7)) then destroyElement(ped7) end
	if(isElement(pedcar)) then destroyElement(pedcar) end
end

local moveMent = 0
local ambientZeit = 0
local randomVar = 0

function moveAmbient()
	local data = getElementData(gMe, "inLogin")
	if (data == 0) then return end
	moveMent = (moveMent+0.0025)
	if(randomVar == 1)  then
		if(ambientZeit == 0) then
			setCameraMatrix(226.35038757324, -52.032470703125, 5.578125+moveMent, 232.00550842285, -68.740165710449, 5.4282329082489+moveMent)
		else
			setCameraMatrix(70.030120849609, -205.12910461426, 5.5993193387985+moveMent, 64.771110534668, -200.03796386719, 5.5992846488953+moveMent)
		end
	elseif(randomVar == 2) then
		if(ambientZeit == 0) then
			setCameraMatrix(234.57122802734, -158.62205505371, 3.4296875+moveMent, 231.08728027344, -150.70335388184, 3.4296875+moveMent) -- Done
		else
			setCameraMatrix(235.43348693848, -260.41595458984, 3.4296875+moveMent, 230.55987548828, -246.96383666992, 3.4296875+moveMent) -- done
		end
	elseif(randomVar == 3) then
	if(ambientZeit == 0) then
			setCameraMatrix(677.92504882813, 313.15502929688, 21.890584945679+moveMent, 688.31158447266, 314.1943359375, 21.8828125+moveMent) -- Done
		else
			setCameraMatrix(1280.1007080078, 345.46606445313, 21.411493301392+moveMent, 1279.9127197266, 351.93109130859, 21.411880493164+moveMent) -- Done
		end
	end
end

function setToAmbientCar(id)
	--triggerServerEvent("onAmbientCarCreate", gMe, id)
	if(id == 1) then -- Blueberry, auf sicht von Noobspawn
	--225.05963134766, -9.770866394043, 1.7500904798508
	ped1 = createPed(math.random(15, 40),224.99615478516, -137.42658996582, 1.578125)
	setPedRotation(ped1, 170)
	setPedAnimation( ped1, "ped", "WALK_civi", -1, true, true, false)
	
	ped2 = createPed(math.random(15, 40), 225.65718078613, -136.2272644043, 1.578125)
	setPedRotation(ped2, 274)
	setPedAnimation( ped2, "ped", "WALK_civi", -1, true, true, false)

	ped3 = createPed(math.random(15, 40), 240.60830688477, -86.999626159668, 1.5703315734863)
	setPedRotation(ped3, 360)
	setPedAnimation( ped3, "ped", "WALK_civi", -1, true, true, false)
	
	pedcar = createVehicle(getVehicleModelFromName("bobcat"), 221.61544799805, -83.064323425293, 1.5735276937485)
	setElementRotation(pedcar, 359.26055908203, 0.065185546875, 244.06488037109)
	
	ped4 = createPed(math.random(15, 40), 222.1554107666, -81.7451171875, 1.578125)
	setPedRotation(ped4, 335)
	setPedAnimation( ped4, "SMOKING", "M_smklean_loop", -1, true, true, false)
	
	elseif(id == 2) then -- Blueberry, am Ammu Nation
	ped1 = createPed(math.random(15, 40), 225.51341247559, -159.55628967285, 1.578125)
	setPedRotation(ped1, 0)
	setPedAnimation( ped1, "ped", "WALK_civi", -1, true, true, false)
	
	ped2 = createPed(math.random(15, 40), 239.45959472656, -140.98182678223, 1.578125)
	setPedRotation(ped2, 180)
	setPedAnimation( ped2, "ped", "WALK_civi", -1, true, true, false)
	
	ped3 = createPed(math.random(15, 40), 219.75451660156, -149.65238952637, 1.578125)
	setPedRotation(ped3, 270)
	setPedAnimation( ped3, "ped", "WALK_civi", -1, true, true, false)
	
	ped4 = createPed(math.random(15, 40), 240.15452575684, -144.00640869141, 1.57812)
	setPedRotation(ped4, 360)
	setPedAnimation( ped4, "ped", "WALK_civi", -1, true, true, false)
	
	pedcar = createVehicle(getVehicleModelFromName("Burrito"), 215.05934143066, -124.16770172119, 1.6920953989029)
	setElementRotation(pedcar, 359.27789306641, 0.1737060546875, 129.076171875)
	

	ped5 = createPed(math.random(15, 40), 215.44528198242, -126.24008178711, 1.5737917423248)
	setPedRotation(ped3, 312)
	setPedAnimation( ped3, "DANCING", "dance_loop", -1, true, true, false)
	
	ped6 = createPed(math.random(15, 40), 216.93241882324, -124.74756622314, 1.5712430477142)
	setPedRotation(ped4, 128)
	setPedAnimation( ped4, "CRACK", "crckidle4", -1, true, true, false)
	elseif(id == 3) then -- Wald da
	ped1 = createPed(math.random(15, 40), 696.98980712891, 323.16012573242, 20.22645759582)
	setPedRotation(ped1, 222)
	setPedAnimation( ped1, "ped", "WALK_civi", -1, true, true, false)

	ped2 = createPed(math.random(15, 40), 729.72253417969, 308.27221679688, 20.234375)
	setPedRotation(ped2, 346)
	setPedAnimation( ped2, "CRACK", "crckidle4", -1, true, true, false)
	
	pedcar = createVehicle(getVehicleModelFromName("Bobcat"), 732.291015625, 308.15698242188, 20.355974197388)
	setElementRotation(pedcar, 359.1396484375, 0, 321.41729736328)
	end
end

function showToAmbient()
	local data = tonumber(getElementData(gMe, "scriptvar"))
	if(data == 1) then return end
	sound = playSound("sounds/calm2.mp3", false)
	fadeCamera(false, -1.0, 255, 255, 255) --Sofort
	setTimer(fadeCamera, 1000, 1, true, 1.0, 255, 255, 255)
	setElementInterior(gMe, 0)
	local realtime = getRealTime()
	local stunde = realtime.hour
	local ambientvar = math.random(0, 2)
	if(ambientvar == 0) then
	if( stunde < 20 ) and ( stunde > 7) then
		setCameraMatrix(226.35038757324, -52.032470703125, 5.578125, 232.00550842285, -68.740165710449, 5.4282329082489)
		ambientZeit = 0
		randomVar = 1
		setToAmbientCar(1)
	else	
		setCameraMatrix(70.030120849609, -205.12910461426, 5.5993193387985, 64.771110534668, -200.03796386719, 5.5992846488953)
		ambientZeit = 1
		randomVar = 1
	end
	elseif(ambientvar == 1) then
	if( stunde < 20 ) and ( stunde > 7) then
		setCameraMatrix(234.57122802734, -158.62205505371, 3.4296875, 231.08728027344, -150.70335388184, 3.4296875) -- Done
		ambientZeit = 0
		randomVar = 2
		setToAmbientCar(2)
	else
		setCameraMatrix(235.43348693848, -260.41595458984, 3.4296875, 230.55987548828, -246.96383666992, 3.4296875) -- done
		ambientZeit = 1
		randomVar = 2
	end	
	elseif(ambientvar == 2) then
	if( stunde < 20 ) and ( stunde > 7) then
		setCameraMatrix(677.92504882813, 313.15502929688, 21.890584945679, 688.31158447266, 314.1943359375, 21.8828125) -- Done
		ambientZeit = 0
		randomVar = 3
		setToAmbientCar(3)
	else	
		setCameraMatrix(1280.1007080078, 345.46606445313, 21.411493301392, 1279.9127197266, 351.93109130859, 21.411880493164) -- Done
		ambientZeit = 1
		randomVar = 3
	end		
	end
	setElementPosition(gMe, 0, 0, 0)
	setElementFrozen(gMe, true)
	addEventHandler("onClientRender", getRootElement(), moveAmbient)
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), createRegisterMenue )
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), showToAmbient )

addEvent("setPedControl", true)
addEventHandler("setPedControl", getRootElement(),
	function(ped)
	setPedControlState(ped, "accelerate", true)

end)